Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964997AbWACXtb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964997AbWACXtb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 18:49:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965037AbWACXp7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 18:45:59 -0500
Received: from saraswathi.solana.com ([198.99.130.12]:39061 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S965015AbWACXpw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 18:45:52 -0500
Message-Id: <200601040037.k040bkki012571@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
Subject: [PATCH 10/12] UML - Simplify console opening/closing and irq registration
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 03 Jan 2006 19:37:46 -0500
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch simplifies the opening and closing of host console
devices and the registration and deregistration of IRQs.  The intent
is to make it obvious that an IRQ can't exist without an open file
descriptor.
chan_enable will now open the channel, and when both opening and IRQ
registration are desired, this should be used.  Opening only is done
for the initial console, so that interface still needs to exist.
The free_irqs_later interface is now gone.  It was intended to avoid
freeing an IRQ while it was being processed.  It did this, but it
didn't eliminate the possiblity of free_irq being called from an
interrupt, which is bad.  In its place is a list of irqs to be
freed, which is processed by the signal handler just before exiting.
close_one_chan now disables irqs.
When a host device disappears, it is just closed, and that disables
IRQs.
The device id registered with the IRQ is now the chan structure, not
the tty.  This is because the interrupt arrives on a descriptor
associated with the channel.  This caused equivalent changes in the
arguments to line_timer_cb.
line_disable is gone since it is not used any more.
The count field in the line structure is gone.  tty->count is used
instead.
The complicated logic in sigio_handler with freeing IRQs when
necessary and making sure its idea of the next irq is correct is now
much simpler.  The irq list can't be rearranged underneath it, so it
is now a simple list walk.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.15/arch/um/drivers/chan_kern.c
===================================================================
--- linux-2.6.15.orig/arch/um/drivers/chan_kern.c	2006-01-03 17:32:45.000000000 -0500
+++ linux-2.6.15/arch/um/drivers/chan_kern.c	2006-01-03 17:33:23.000000000 -0500
@@ -1,4 +1,4 @@
-/* 
+/*
  * Copyright (C) 2000, 2001, 2002 Jeff Dike (jdike@karaya.com)
  * Licensed under the GPL
  */
@@ -240,20 +240,65 @@ void chan_enable_winch(struct list_head 
 	}
 }
 
-void enable_chan(struct list_head *chans, struct tty_struct *tty)
+void enable_chan(struct line *line)
 {
 	struct list_head *ele;
 	struct chan *chan;
 
-	list_for_each(ele, chans){
+	list_for_each(ele, &line->chan_list){
 		chan = list_entry(ele, struct chan, list);
-		if(!chan->opened) continue;
+		if(open_one_chan(chan))
+			continue;
+
+		if(chan->enabled)
+			continue;
+		line_setup_irq(chan->fd, chan->input, chan->output, line,
+			       chan);
+		chan->enabled = 1;
+	}
+}
+
+static LIST_HEAD(irqs_to_free);
+
+void free_irqs(void)
+{
+	struct chan *chan;
+
+	while(!list_empty(&irqs_to_free)){
+		chan = list_entry(irqs_to_free.next, struct chan, free_list);
+		list_del(&chan->free_list);
+
+		if(chan->input)
+			free_irq(chan->line->driver->read_irq, chan);
+		if(chan->output)
+			free_irq(chan->line->driver->write_irq, chan);
+		chan->enabled = 0;
+	}
+}
+
+static void close_one_chan(struct chan *chan, int delay_free_irq)
+{
+	if(!chan->opened)
+		return;
 
-		line_setup_irq(chan->fd, chan->input, chan->output, tty);
+	if(delay_free_irq){
+		list_add(&chan->free_list, &irqs_to_free);
+	}
+	else {
+		if(chan->input)
+			free_irq(chan->line->driver->read_irq, chan);
+		if(chan->output)
+			free_irq(chan->line->driver->write_irq, chan);
+		chan->enabled = 0;
 	}
+	if(chan->ops->close != NULL)
+		(*chan->ops->close)(chan->fd, chan->data);
+
+	chan->opened = 0;
+	chan->fd = -1;
 }
 
-void close_chan(struct list_head *chans)
+void close_chan(struct list_head *chans, int delay_free_irq)
 {
 	struct chan *chan;
 
@@ -263,11 +308,7 @@ void close_chan(struct list_head *chans)
 	 * so it must be the last closed.
 	 */
 	list_for_each_entry_reverse(chan, chans, list) {
-		if(!chan->opened) continue;
-		if(chan->ops->close != NULL)
-			(*chan->ops->close)(chan->fd, chan->data);
-		chan->opened = 0;
-		chan->fd = -1;
+		close_one_chan(chan, delay_free_irq);
 	}
 }
 
@@ -339,24 +380,27 @@ int chan_window_size(struct list_head *c
 	return 0;
 }
 
-void free_one_chan(struct chan *chan)
+void free_one_chan(struct chan *chan, int delay_free_irq)
 {
 	list_del(&chan->list);
+
+	close_one_chan(chan, delay_free_irq);
+
 	if(chan->ops->free != NULL)
 		(*chan->ops->free)(chan->data);
-	free_irq_by_fd(chan->fd);
+
 	if(chan->primary && chan->output) ignore_sigio_fd(chan->fd);
 	kfree(chan);
 }
 
-void free_chan(struct list_head *chans)
+void free_chan(struct list_head *chans, int delay_free_irq)
 {
 	struct list_head *ele, *next;
 	struct chan *chan;
 
 	list_for_each_safe(ele, next, chans){
 		chan = list_entry(ele, struct chan, list);
-		free_one_chan(chan);
+		free_one_chan(chan, delay_free_irq);
 	}
 }
 
@@ -466,7 +510,8 @@ struct chan_type chan_table[] = {
 #endif
 };
 
-static struct chan *parse_chan(char *str, int device, struct chan_opts *opts)
+static struct chan *parse_chan(struct line *line, char *str, int device,
+			       struct chan_opts *opts)
 {
 	struct chan_type *entry;
 	struct chan_ops *ops;
@@ -499,25 +544,30 @@ static struct chan *parse_chan(char *str
 	if(chan == NULL)
 		return NULL;
 	*chan = ((struct chan) { .list	 	= LIST_HEAD_INIT(chan->list),
+				 .free_list 	=
+				 	LIST_HEAD_INIT(chan->free_list),
+				 .line		= line,
 				 .primary	= 1,
 				 .input		= 0,
 				 .output 	= 0,
 				 .opened  	= 0,
+				 .enabled  	= 0,
 				 .fd 		= -1,
 				 .ops 		= ops,
 				 .data 		= data });
 	return chan;
 }
 
-int parse_chan_pair(char *str, struct list_head *chans, int device,
+int parse_chan_pair(char *str, struct line *line, int device,
 		    struct chan_opts *opts)
 {
+	struct list_head *chans = &line->chan_list;
 	struct chan *new, *chan;
 	char *in, *out;
 
 	if(!list_empty(chans)){
 		chan = list_entry(chans->next, struct chan, list);
-		free_chan(chans);
+		free_chan(chans, 0);
 		INIT_LIST_HEAD(chans);
 	}
 
@@ -526,14 +576,14 @@ int parse_chan_pair(char *str, struct li
 		in = str;
 		*out = '\0';
 		out++;
-		new = parse_chan(in, device, opts);
+		new = parse_chan(line, in, device, opts);
 		if(new == NULL)
 			return -1;
 
 		new->input = 1;
 		list_add(&new->list, chans);
 
-		new = parse_chan(out, device, opts);
+		new = parse_chan(line, out, device, opts);
 		if(new == NULL)
 			return -1;
 
@@ -541,7 +591,7 @@ int parse_chan_pair(char *str, struct li
 		new->output = 1;
 	}
 	else {
-		new = parse_chan(str, device, opts);
+		new = parse_chan(line, str, device, opts);
 		if(new == NULL)
 			return -1;
 
@@ -592,27 +642,12 @@ void chan_interrupt(struct list_head *ch
 			if(chan->primary){
 				if(tty != NULL)
 					tty_hangup(tty);
-				line_disable(tty, irq);
-				close_chan(chans);
+				close_chan(chans, 1);
 				return;
 			}
-			else {
-				if(chan->ops->close != NULL)
-					chan->ops->close(chan->fd, chan->data);
-			}
+			else close_one_chan(chan, 1);
 		}
 	}
  out:
 	if(tty) tty_flip_buffer_push(tty);
 }
-
-/*
- * Overrides for Emacs so that we follow Linus's tabbing style.
- * Emacs will notice this stuff at the end of the file and automatically
- * adjust the settings for this buffer only.  This must remain at the end
- * of the file.
- * ---------------------------------------------------------------------------
- * Local variables:
- * c-file-style: "linux"
- * End:
- */
Index: linux-2.6.15/arch/um/drivers/line.c
===================================================================
--- linux-2.6.15.orig/arch/um/drivers/line.c	2006-01-03 17:32:45.000000000 -0500
+++ linux-2.6.15/arch/um/drivers/line.c	2006-01-03 17:33:23.000000000 -0500
@@ -1,4 +1,4 @@
-/* 
+/*
  * Copyright (C) 2001, 2002 Jeff Dike (jdike@karaya.com)
  * Licensed under the GPL
  */
@@ -23,8 +23,9 @@
 
 static irqreturn_t line_interrupt(int irq, void *data, struct pt_regs *unused)
 {
-	struct tty_struct *tty = data;
-	struct line *line = tty->driver_data;
+	struct chan *chan = data;
+	struct line *line = chan->line;
+	struct tty_struct *tty = line->tty;
 
 	if (line)
 		chan_interrupt(&line->chan_list, &line->task, tty, irq);
@@ -33,10 +34,10 @@ static irqreturn_t line_interrupt(int ir
 
 static void line_timer_cb(void *arg)
 {
-	struct tty_struct *tty = arg;
-	struct line *line = tty->driver_data;
+	struct line *line = arg;
 
-	line_interrupt(line->driver->read_irq, arg, NULL);
+	chan_interrupt(&line->chan_list, &line->task, line->tty,
+		       line->driver->read_irq);
 }
 
 /* Returns the free space inside the ring buffer of this line.
@@ -342,8 +343,9 @@ int line_ioctl(struct tty_struct *tty, s
 static irqreturn_t line_write_interrupt(int irq, void *data,
 					struct pt_regs *unused)
 {
-	struct tty_struct *tty = data;
-	struct line *line = tty->driver_data;
+	struct chan *chan = data;
+	struct line *line = chan->line;
+	struct tty_struct *tty = line->tty;
 	int err;
 
 	/* Interrupts are enabled here because we registered the interrupt with
@@ -365,7 +367,7 @@ static irqreturn_t line_write_interrupt(
 	if (test_bit(TTY_DO_WRITE_WAKEUP, &tty->flags) &&
 	   (tty->ldisc.write_wakeup != NULL))
 		(tty->ldisc.write_wakeup)(tty);
-	
+
 	/* BLOCKING mode
 	 * In blocking mode, everything sleeps on tty->write_wait.
 	 * Sleeping in the console driver would break non-blocking
@@ -377,52 +379,29 @@ static irqreturn_t line_write_interrupt(
 	return IRQ_HANDLED;
 }
 
-int line_setup_irq(int fd, int input, int output, struct tty_struct *tty)
+int line_setup_irq(int fd, int input, int output, struct line *line, void *data)
 {
-	struct line *line = tty->driver_data;
 	struct line_driver *driver = line->driver;
 	int err = 0, flags = SA_INTERRUPT | SA_SHIRQ | SA_SAMPLE_RANDOM;
 
 	if (input)
 		err = um_request_irq(driver->read_irq, fd, IRQ_READ,
 				       line_interrupt, flags,
-				       driver->read_irq_name, tty);
+				       driver->read_irq_name, data);
 	if (err)
 		return err;
 	if (output)
 		err = um_request_irq(driver->write_irq, fd, IRQ_WRITE,
 					line_write_interrupt, flags,
-					driver->write_irq_name, tty);
+					driver->write_irq_name, data);
 	line->have_irq = 1;
 	return err;
 }
 
-void line_disable(struct tty_struct *tty, int current_irq)
-{
-	struct line *line = tty->driver_data;
-
-	if(!line->have_irq)
-		return;
-
-	if(line->driver->read_irq == current_irq)
-		free_irq_later(line->driver->read_irq, tty);
-	else {
-		free_irq(line->driver->read_irq, tty);
-	}
-
-	if(line->driver->write_irq == current_irq)
-		free_irq_later(line->driver->write_irq, tty);
-	else {
-		free_irq(line->driver->write_irq, tty);
-	}
-
-	line->have_irq = 0;
-}
-
 int line_open(struct line *lines, struct tty_struct *tty)
 {
 	struct line *line;
-	int err = 0;
+	int err = -ENODEV;
 
 	line = &lines[tty->index];
 	tty->driver_data = line;
@@ -430,29 +409,29 @@ int line_open(struct line *lines, struct
 	/* The IRQ which takes this lock is not yet enabled and won't be run
 	 * before the end, so we don't need to use spin_lock_irq.*/
 	spin_lock(&line->lock);
-	if (tty->count == 1) {
-		if (!line->valid) {
-			err = -ENODEV;
-			goto out;
-		}
 
-		err = open_chan(&line->chan_list);
- 		if(err)
-			goto out;
+	tty->driver_data = line;
+	line->tty = tty;
+	if(!line->valid)
+		goto out;
 
-		/* Here the interrupt is registered.*/
-		enable_chan(&line->chan_list, tty);
-		INIT_WORK(&line->task, line_timer_cb, tty);
-	}
+	if(tty->count == 1){
+		/* Here the device is opened, if necessary, and interrupt
+		 * is registered.
+		 */
+		enable_chan(line);
+		INIT_WORK(&line->task, line_timer_cb, line);
+
+		if(!line->sigio){
+			chan_enable_winch(&line->chan_list, tty);
+			line->sigio = 1;
+		}
 
-	if(!line->sigio){
-		chan_enable_winch(&line->chan_list, tty);
-		line->sigio = 1;
-	}
-	chan_window_size(&line->chan_list, &tty->winsize.ws_row,
-			 &tty->winsize.ws_col);
-	line->count++;
+		chan_window_size(&line->chan_list, &tty->winsize.ws_row,
+				 &tty->winsize.ws_col);
+	}
 
+	err = 0;
 out:
 	spin_unlock(&line->lock);
 	return err;
@@ -472,15 +451,14 @@ void line_close(struct tty_struct *tty, 
 	/* We ignore the error anyway! */
 	flush_buffer(line);
 
-	line->count--;
-	if (tty->count == 1) {
-		line_disable(tty, -1);
+	if(tty->count == 1){
+		line->tty = NULL;
 		tty->driver_data = NULL;
-	}
 
-        if((line->count == 0) && line->sigio){
-                unregister_winch(tty);
-                line->sigio = 0;
+		if(line->sigio){
+			unregister_winch(tty);
+			line->sigio = 0;
+		}
         }
 
 	spin_unlock_irq(&line->lock);
@@ -491,7 +469,7 @@ void close_lines(struct line *lines, int
 	int i;
 
 	for(i = 0; i < nlines; i++)
-		close_chan(&lines[i].chan_list);
+		close_chan(&lines[i].chan_list, 0);
 }
 
 /* Common setup code for both startup command line and mconsole initialization.
@@ -526,7 +504,7 @@ int line_setup(struct line *lines, unsig
 		return 0;
 	}
 	else if (n >= 0){
-		if (lines[n].count > 0) {
+		if (lines[n].tty != NULL) {
 			printk("line_setup - device %d is open\n", n);
 			return 0;
 		}
@@ -537,7 +515,7 @@ int line_setup(struct line *lines, unsig
 			else {
 				lines[n].init_str = init;
 				lines[n].valid = 1;
-			}	
+			}
 		}
 	}
 	else {
@@ -578,7 +556,7 @@ int line_config(struct line *lines, unsi
 		return 1;
 
 	line = &lines[n];
-	return parse_chan_pair(line->init_str, &line->chan_list, n, opts);
+	return parse_chan_pair(line->init_str, line, n, opts);
 }
 
 int line_get_config(char *name, struct line *lines, unsigned int num, char *str,
@@ -604,7 +582,7 @@ int line_get_config(char *name, struct l
 	spin_lock(&line->lock);
 	if(!line->valid)
 		CONFIG_CHUNK(str, size, n, "none", 1);
-	else if(line->count == 0)
+	else if(line->tty == NULL)
 		CONFIG_CHUNK(str, size, n, line->init_str, 1);
 	else n = chan_config_string(&line->chan_list, str, size, error_out);
 	spin_unlock(&line->lock);
@@ -696,7 +674,7 @@ void lines_init(struct line *lines, int 
 		if(line->init_str == NULL)
 			printk("lines_init - kstrdup returned NULL\n");
 
-		if(parse_chan_pair(line->init_str, &line->chan_list, i, opts)){
+		if(parse_chan_pair(line->init_str, line, i, opts)){
 			printk("parse_chan_pair failed for device %d\n", i);
 			line->valid = 0;
 		}
@@ -831,7 +809,7 @@ char *add_xterm_umid(char *base)
 	umid = get_umid(1);
 	if(umid == NULL)
 		return base;
-	
+
 	len = strlen(base) + strlen(" ()") + strlen(umid) + 1;
 	title = kmalloc(len, GFP_KERNEL);
 	if(title == NULL){
Index: linux-2.6.15/arch/um/include/irq_user.h
===================================================================
--- linux-2.6.15.orig/arch/um/include/irq_user.h	2006-01-03 17:17:16.000000000 -0500
+++ linux-2.6.15/arch/um/include/irq_user.h	2006-01-03 17:33:23.000000000 -0500
@@ -18,19 +18,8 @@ extern int deactivate_all_fds(void);
 extern void forward_interrupts(int pid);
 extern void init_irq_signals(int on_sigstack);
 extern void forward_ipi(int fd, int pid);
-extern void free_irq_later(int irq, void *dev_id);
 extern int activate_ipi(int fd, int pid);
 extern unsigned long irq_lock(void);
 extern void irq_unlock(unsigned long flags);
-#endif
 
-/*
- * Overrides for Emacs so that we follow Linus's tabbing style.
- * Emacs will notice this stuff at the end of the file and automatically
- * adjust the settings for this buffer only.  This must remain at the end
- * of the file.
- * ---------------------------------------------------------------------------
- * Local variables:
- * c-file-style: "linux"
- * End:
- */
+#endif
Index: linux-2.6.15/arch/um/include/line.h
===================================================================
--- linux-2.6.15.orig/arch/um/include/line.h	2006-01-03 17:32:45.000000000 -0500
+++ linux-2.6.15/arch/um/include/line.h	2006-01-03 17:33:23.000000000 -0500
@@ -32,6 +32,7 @@ struct line_driver {
 };
 
 struct line {
+	struct tty_struct *tty;
 	char *init_str;
 	int init_pri;
 	struct list_head chan_list;
@@ -89,10 +90,9 @@ extern int line_ioctl(struct tty_struct 
 		      unsigned int cmd, unsigned long arg);
 
 extern char *add_xterm_umid(char *base);
-extern int line_setup_irq(int fd, int input, int output,
-			  struct tty_struct *tty);
+extern int line_setup_irq(int fd, int input, int output, struct line *line,
+			  void *data);
 extern void line_close_chan(struct line *line);
-extern void line_disable(struct tty_struct *tty, int current_irq);
 extern struct tty_driver * line_register_devfs(struct lines *set,
 				struct line_driver *line_driver,
 				struct tty_operations *driver,
Index: linux-2.6.15/arch/um/kernel/irq_user.c
===================================================================
--- linux-2.6.15.orig/arch/um/kernel/irq_user.c	2006-01-03 17:17:16.000000000 -0500
+++ linux-2.6.15/arch/um/kernel/irq_user.c	2006-01-03 17:33:23.000000000 -0500
@@ -29,7 +29,6 @@ struct irq_fd {
 	int pid;
 	int events;
 	int current_events;
-	int freed;
 };
 
 static struct irq_fd *active_fds = NULL;
@@ -41,9 +40,11 @@ static int pollfds_size = 0;
 
 extern int io_count, intr_count;
 
+extern void free_irqs(void);
+
 void sigio_handler(int sig, union uml_pt_regs *regs)
 {
-	struct irq_fd *irq_fd, *next;
+	struct irq_fd *irq_fd;
 	int i, n;
 
 	if(smp_sigio_handler()) return;
@@ -66,29 +67,15 @@ void sigio_handler(int sig, union uml_pt
 			irq_fd = irq_fd->next;
 		}
 
-		for(irq_fd = active_fds; irq_fd != NULL; irq_fd = next){
-			next = irq_fd->next;
+		for(irq_fd = active_fds; irq_fd != NULL; irq_fd = irq_fd->next){
 			if(irq_fd->current_events != 0){
 				irq_fd->current_events = 0;
 				do_IRQ(irq_fd->irq, regs);
-
-				/* This is here because the next irq may be
-				 * freed in the handler.  If a console goes
-				 * away, both the read and write irqs will be
-				 * freed.  After do_IRQ, ->next will point to
-				 * a good IRQ.
-				 * Irqs can't be freed inside their handlers,
-				 * so the next best thing is to have them
-				 * marked as needing freeing, so that they
-				 * can be freed here.
-				 */
-				next = irq_fd->next;
-				if(irq_fd->freed){
-					free_irq(irq_fd->irq, irq_fd->id);
-				}
 			}
 		}
 	}
+
+	free_irqs();
 }
 
 int activate_ipi(int fd, int pid)
@@ -136,8 +123,7 @@ int activate_fd(int irq, int fd, int typ
 				     .irq 		= irq,
 				     .pid  		= pid,
 				     .events 		= events,
-				     .current_events 	= 0,
-				     .freed 		= 0  } );
+				     .current_events 	= 0 } );
 
 	/* Critical section - locked by a spinlock because this stuff can
 	 * be changed from interrupt handlers.  The stuff above is done 
@@ -313,26 +299,6 @@ static struct irq_fd *find_irq_by_fd(int
 	return(irq);
 }
 
-void free_irq_later(int irq, void *dev_id)
-{
-	struct irq_fd *irq_fd;
-	unsigned long flags;
-
-	flags = irq_lock();
-	for(irq_fd = active_fds; irq_fd != NULL; irq_fd = irq_fd->next){
-		if((irq_fd->irq == irq) && (irq_fd->id == dev_id))
-			break;
-	}
-	if(irq_fd == NULL){
-		printk("free_irq_later found no irq, irq = %d, "
-		       "dev_id = 0x%p\n", irq, dev_id);
-		goto out;
-	}
-	irq_fd->freed = 1;
- out:
-	irq_unlock(flags);
-}
-
 void reactivate_fd(int fd, int irqnum)
 {
 	struct irq_fd *irq;
Index: linux-2.6.15/arch/um/include/chan_kern.h
===================================================================
--- linux-2.6.15.orig/arch/um/include/chan_kern.h	2006-01-03 17:29:31.000000000 -0500
+++ linux-2.6.15/arch/um/include/chan_kern.h	2006-01-03 17:33:23.000000000 -0500
@@ -14,11 +14,14 @@
 
 struct chan {
 	struct list_head list;
+	struct list_head free_list;
+	struct line *line;
 	char *dev;
 	unsigned int primary:1;
 	unsigned int input:1;
 	unsigned int output:1;
 	unsigned int opened:1;
+	unsigned int enabled:1;
 	int fd;
 	struct chan_ops *ops;
 	void *data;
@@ -26,7 +29,7 @@ struct chan {
 
 extern void chan_interrupt(struct list_head *chans, struct work_struct *task,
 			   struct tty_struct *tty, int irq);
-extern int parse_chan_pair(char *str, struct list_head *chans, int device,
+extern int parse_chan_pair(char *str, struct line *line, int device,
 			   struct chan_opts *opts);
 extern int open_chan(struct list_head *chans);
 extern int write_chan(struct list_head *chans, const char *buf, int len,
@@ -35,9 +38,9 @@ extern int console_write_chan(struct lis
 			      int len);
 extern int console_open_chan(struct line *line, struct console *co,
 			     struct chan_opts *opts);
-extern void close_chan(struct list_head *chans);
 extern void chan_enable_winch(struct list_head *chans, struct tty_struct *tty);
-extern void enable_chan(struct list_head *chans, struct tty_struct *tty);
+extern void enable_chan(struct line *line);
+extern void close_chan(struct list_head *chans, int delay_free_irq);
 extern int chan_window_size(struct list_head *chans, 
 			     unsigned short *rows_out, 
 			     unsigned short *cols_out);

