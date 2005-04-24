Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262371AbVDXStq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262371AbVDXStq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Apr 2005 14:49:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262368AbVDXSt0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Apr 2005 14:49:26 -0400
Received: from mail-relay-1.tiscali.it ([213.205.33.41]:45210 "EHLO
	mail-relay-1.tiscali.it") by vger.kernel.org with ESMTP
	id S262366AbVDXSol (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Apr 2005 14:44:41 -0400
Subject: [patch 4/7] uml: redo console locking
To: akpm@osdl.org
Cc: jdike@addtoit.com, bstroesser@fujitsu-siemens.com,
       linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net, blaisorblade@yahoo.it
From: blaisorblade@yahoo.it
Date: Sun, 24 Apr 2005 20:19:17 +0200
Message-Id: <20050424181917.5601A55CFF@zion>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Fix some console locking problems (including scheduling in atomic) and various
reorderings and cleanup in that code. Not yet ready for 2.6.12 probably.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 linux-2.6.12-paolo/arch/um/drivers/chan_kern.c     |   16 -
 linux-2.6.12-paolo/arch/um/drivers/line.c          |  318 +++++++++++++--------
 linux-2.6.12-paolo/arch/um/drivers/ssl.c           |   25 -
 linux-2.6.12-paolo/arch/um/drivers/stdio_console.c |   19 -
 linux-2.6.12-paolo/arch/um/include/line.h          |   36 +-
 5 files changed, 239 insertions(+), 175 deletions(-)

diff -puN arch/um/drivers/line.c~uml-console-redo-locking arch/um/drivers/line.c
--- linux-2.6.12/arch/um/drivers/line.c~uml-console-redo-locking	2005-04-24 20:17:04.000000000 +0200
+++ linux-2.6.12-paolo/arch/um/drivers/line.c	2005-04-24 20:17:04.000000000 +0200
@@ -39,19 +39,69 @@ static void line_timer_cb(void *arg)
 	line_interrupt(line->driver->read_irq, arg, NULL);
 }
 
-static int write_room(struct line *dev)
+/* Returns the free space inside the ring buffer of this line.
+ *
+ * Should be called while holding line->lock (this does not modify datas).
+ */
+static int write_room(struct line *line)
 {
 	int n;
 
-	if (dev->buffer == NULL)
-		return (LINE_BUFSIZE - 1);
+	if (line->buffer == NULL)
+		return LINE_BUFSIZE - 1;
+
+	/* This is for the case where the buffer is wrapped! */
+	n = line->head - line->tail;
 
-	n = dev->head - dev->tail;
 	if (n <= 0)
-		n = LINE_BUFSIZE + n;
-	return (n - 1);
+		n = LINE_BUFSIZE + n; /* The other case */
+	return n - 1;
+}
+
+int line_write_room(struct tty_struct *tty)
+{
+	struct line *line = tty->driver_data;
+	unsigned long flags;
+	int room;
+
+	if (tty->stopped)
+		return 0;
+
+	spin_lock_irqsave(&line->lock, flags);
+	room = write_room(line);
+	spin_unlock_irqrestore(&line->lock, flags);
+
+	/*XXX: Warning to remove */
+	if (0 == room)
+		printk(KERN_DEBUG "%s: %s: no room left in buffer\n",
+		       __FUNCTION__,tty->name);
+	return room;
+}
+
+int line_chars_in_buffer(struct tty_struct *tty)
+{
+	struct line *line = tty->driver_data;
+	unsigned long flags;
+	int ret;
+
+	spin_lock_irqsave(&line->lock, flags);
+
+	/*write_room subtracts 1 for the needed NULL, so we readd it.*/
+	ret = LINE_BUFSIZE - (write_room(line) + 1);
+	spin_unlock_irqrestore(&line->lock, flags);
+
+	return ret;
 }
 
+/*
+ * This copies the content of buf into the circular buffer associated with
+ * this line.
+ * The return value is the number of characters actually copied, i.e. the ones
+ * for which there was space: this function is not supposed to ever flush out
+ * the circular buffer.
+ *
+ * Must be called while holding line->lock!
+ */
 static int buffer_data(struct line *line, const char *buf, int len)
 {
 	int end, room;
@@ -70,48 +120,95 @@ static int buffer_data(struct line *line
 	len = (len > room) ? room : len;
 
 	end = line->buffer + LINE_BUFSIZE - line->tail;
-	if(len < end){
+
+	if (len < end){
 		memcpy(line->tail, buf, len);
 		line->tail += len;
-	}
-	else {
+	} else {
+		/* The circular buffer is wrapping */
 		memcpy(line->tail, buf, end);
 		buf += end;
 		memcpy(line->buffer, buf, len - end);
 		line->tail = line->buffer + len - end;
 	}
 
-	return(len);
+	return len;
 }
 
+/*
+ * Flushes the ring buffer to the output channels. That is, write_chan is
+ * called, passing it line->head as buffer, and an appropriate count.
+ *
+ * On exit, returns 1 when the buffer is empty,
+ * 0 when the buffer is not empty on exit,
+ * and -errno when an error occurred.
+ *
+ * Must be called while holding line->lock!*/
 static int flush_buffer(struct line *line)
 {
 	int n, count;
 
 	if ((line->buffer == NULL) || (line->head == line->tail))
-		return(1);
+		return 1;
 
 	if (line->tail < line->head) {
+		/* line->buffer + LINE_BUFSIZE is the end of the buffer! */
 		count = line->buffer + LINE_BUFSIZE - line->head;
+
 		n = write_chan(&line->chan_list, line->head, count,
 			       line->driver->write_irq);
 		if (n < 0)
-			return(n);
-		if (n == count)
+			return n;
+		if (n == count) {
+			/* We have flushed from ->head to buffer end, now we
+			 * must flush only from the beginning to ->tail.*/
 			line->head = line->buffer;
-		else {
+		} else {
 			line->head += n;
-			return(0);
+			return 0;
 		}
 	}
 
 	count = line->tail - line->head;
 	n = write_chan(&line->chan_list, line->head, count, 
 		       line->driver->write_irq);
-	if(n < 0) return(n);
+
+	if(n < 0)
+		return n;
 
 	line->head += n;
-	return(line->head == line->tail);
+	return line->head == line->tail;
+}
+
+void line_flush_buffer(struct tty_struct *tty)
+{
+	struct line *line = tty->driver_data;
+	unsigned long flags;
+	int err;
+
+	/*XXX: copied from line_write, verify if it is correct!*/
+	if(tty->stopped)
+		return;
+		//return 0;
+
+	spin_lock_irqsave(&line->lock, flags);
+	err = flush_buffer(line);
+	/*if (err == 1)
+		err = 0;*/
+	spin_unlock_irqrestore(&line->lock, flags);
+	//return err;
+}
+
+/* We map both ->flush_chars and ->put_char (which go in pair) onto ->flush_buffer
+ * and ->write. Hope it's not that bad.*/
+void line_flush_chars(struct tty_struct *tty)
+{
+	line_flush_buffer(tty);
+}
+
+void line_put_char(struct tty_struct *tty, unsigned char ch)
+{
+	line_write(tty, &ch, sizeof(ch));
 }
 
 int line_write(struct tty_struct *tty, const unsigned char *buf, int len)
@@ -120,38 +217,31 @@ int line_write(struct tty_struct *tty, c
 	unsigned long flags;
 	int n, err, ret = 0;
 
-	if(tty->stopped) return 0;
+	if(tty->stopped)
+		return 0;
 
-	down(&line->sem);
-	if(line->head != line->tail){
-		local_irq_save(flags);
+	spin_lock_irqsave(&line->lock, flags);
+	if (line->head != line->tail) {
 		ret = buffer_data(line, buf, len);
 		err = flush_buffer(line);
-		local_irq_restore(flags);
-		if(err <= 0 && (err != -EAGAIN || !ret))
+		if (err <= 0 && (err != -EAGAIN || !ret))
 			ret = err;
-	}
-	else {
+	} else {
 		n = write_chan(&line->chan_list, buf, len, 
 			       line->driver->write_irq);
-		if(n < 0){
+		if (n < 0) {
 			ret = n;
 			goto out_up;
 		}
 
 		len -= n;
 		ret += n;
-		if(len > 0)
+		if (len > 0)
 			ret += buffer_data(line, buf + n, len);
 	}
- out_up:
-	up(&line->sem);
-	return(ret);
-}
-
-void line_put_char(struct tty_struct *tty, unsigned char ch)
-{
-	line_write(tty, &ch, sizeof(ch));
+out_up:
+	spin_unlock_irqrestore(&line->lock, flags);
+	return ret;
 }
 
 void line_set_termios(struct tty_struct *tty, struct termios * old)
@@ -159,11 +249,6 @@ void line_set_termios(struct tty_struct 
 	/* nothing */
 }
 
-int line_chars_in_buffer(struct tty_struct *tty)
-{
-	return 0;
-}
-
 static struct {
 	int  cmd;
 	char *level;
@@ -250,7 +335,7 @@ int line_ioctl(struct tty_struct *tty, s
 		ret = -ENOIOCTLCMD;
 		break;
 	}
-	return(ret);
+	return ret;
 }
 
 static irqreturn_t line_write_interrupt(int irq, void *data,
@@ -260,18 +345,23 @@ static irqreturn_t line_write_interrupt(
 	struct line *line = tty->driver_data;
 	int err;
 
+	/* Interrupts are enabled here because we registered the interrupt with
+	 * SA_INTERRUPT (see line_setup_irq).*/
+
+	spin_lock_irq(&line->lock);
 	err = flush_buffer(line);
-	if(err == 0)
-		return(IRQ_NONE);
-	else if(err < 0){
+	if (err == 0) {
+		return IRQ_NONE;
+	} else if(err < 0) {
 		line->head = line->buffer;
 		line->tail = line->buffer;
 	}
+	spin_unlock_irq(&line->lock);
 
 	if(tty == NULL)
-		return(IRQ_NONE);
+		return IRQ_NONE;
 
-	if(test_bit(TTY_DO_WRITE_WAKEUP, &tty->flags) &&
+	if (test_bit(TTY_DO_WRITE_WAKEUP, &tty->flags) &&
 	   (tty->ldisc.write_wakeup != NULL))
 		(tty->ldisc.write_wakeup)(tty);
 	
@@ -281,9 +371,9 @@ static irqreturn_t line_write_interrupt(
 	 * writes.
 	 */
 
-	if(waitqueue_active(&tty->write_wait))
+	if (waitqueue_active(&tty->write_wait))
 		wake_up_interruptible(&tty->write_wait);
-	return(IRQ_HANDLED);
+	return IRQ_HANDLED;
 }
 
 int line_setup_irq(int fd, int input, int output, struct tty_struct *tty)
@@ -292,15 +382,18 @@ int line_setup_irq(int fd, int input, in
 	struct line_driver *driver = line->driver;
 	int err = 0, flags = SA_INTERRUPT | SA_SHIRQ | SA_SAMPLE_RANDOM;
 
-	if(input) err = um_request_irq(driver->read_irq, fd, IRQ_READ, 
+	if (input)
+		err = um_request_irq(driver->read_irq, fd, IRQ_READ,
 				       line_interrupt, flags, 
 				       driver->read_irq_name, tty);
-	if(err) return(err);
-	if(output) err = um_request_irq(driver->write_irq, fd, IRQ_WRITE, 
+	if (err)
+		return err;
+	if (output)
+		err = um_request_irq(driver->write_irq, fd, IRQ_WRITE,
 					line_write_interrupt, flags, 
 					driver->write_irq_name, tty);
 	line->have_irq = 1;
-	return(err);
+	return err;
 }
 
 void line_disable(struct tty_struct *tty, int current_irq)
@@ -336,7 +429,9 @@ int line_open(struct line *lines, struct
 	line = &lines[tty->index];
 	tty->driver_data = line;
 
-	down(&line->sem);
+	/* The IRQ which takes this lock is not yet enabled and won't be run
+	 * before the end, so we don't need to use spin_lock_irq.*/
+	spin_lock(&line->lock);
 	if (tty->count == 1) {
 		if (!line->valid) {
 			err = -ENODEV;
@@ -349,6 +444,7 @@ int line_open(struct line *lines, struct
 			err = open_chan(&line->chan_list);
 			if(err) goto out;
 		}
+		/* Here the interrupt is registered.*/
 		enable_chan(&line->chan_list, tty);
 		INIT_WORK(&line->task, line_timer_cb, tty);
 	}
@@ -362,21 +458,27 @@ int line_open(struct line *lines, struct
 	line->count++;
 
 out:
-	up(&line->sem);
-	return(err);
+	spin_unlock(&line->lock);
+	return err;
 }
 
 void line_close(struct tty_struct *tty, struct file * filp)
 {
 	struct line *line = tty->driver_data;
 
-	down(&line->sem);
+	/* XXX: I assume this should be called in process context, not with interrupt
+	 * disabled!*/
+	spin_lock_irq(&line->lock);
+
+	/* We ignore the error anyway! */
+	flush_buffer(line);
+
 	line->count--;
 	if (tty->count == 1) {
 		line_disable(tty, -1);
 		tty->driver_data = NULL;
 	}
-	up(&line->sem);
+	spin_unlock_irq(&line->lock);
 }
 
 void close_lines(struct line *lines, int nlines)
@@ -387,31 +489,41 @@ void close_lines(struct line *lines, int
 		close_chan(&lines[i].chan_list);
 }
 
-int line_setup(struct line *lines, int num, char *init, int all_allowed)
+/* Common setup code for both startup command line and mconsole initialization.
+ * @lines contains the the array (of size @num) to modify;
+ * @init is the setup string;
+ * @all_allowed is a boolean saying if we can setup the whole @lines
+ * at once. For instance, it will be usually true for startup init. (where we
+ * can use con=xterm) and false for mconsole.*/
+
+int line_setup(struct line *lines, unsigned int num, char *init, int all_allowed)
 {
 	int i, n;
 	char *end;
 
-	if(*init == '=') n = -1;
-	else {
+	if(*init == '=') {
+		/* We said con=/ssl= instead of con#=, so we are configuring all
+		 * consoles at once.*/
+		n = -1;
+	} else {
 		n = simple_strtoul(init, &end, 0);
 		if(*end != '='){
 			printk(KERN_ERR "line_setup failed to parse \"%s\"\n", 
 			       init);
-			return(0);
+			return 0;
 		}
 		init = end;
 	}
 	init++;
-	if((n >= 0) && (n >= num)){
+
+	if (n >= (signed int) num) {
 		printk("line_setup - %d out of range ((0 ... %d) allowed)\n",
 		       n, num - 1);
-		return(0);
-	}
-	else if (n >= 0){
+		return 0;
+	} else if (n >= 0){
 		if (lines[n].count > 0) {
 			printk("line_setup - device %d is open\n", n);
-			return(0);
+			return 0;
 		}
 		if (lines[n].init_pri <= INIT_ONE){
 			lines[n].init_pri = INIT_ONE;
@@ -422,13 +534,11 @@ int line_setup(struct line *lines, int n
 				lines[n].valid = 1;
 			}	
 		}
-	}
-	else if(!all_allowed){
+	} else if(!all_allowed){
 		printk("line_setup - can't configure all devices from "
 		       "mconsole\n");
-		return(0);
-	}
-	else {
+		return 0;
+	} else {
 		for(i = 0; i < num; i++){
 			if(lines[i].init_pri <= INIT_ALL){
 				lines[i].init_pri = INIT_ALL;
@@ -440,21 +550,21 @@ int line_setup(struct line *lines, int n
 			}
 		}
 	}
-	return(1);
+	return 1;
 }
 
-int line_config(struct line *lines, int num, char *str)
+int line_config(struct line *lines, unsigned int num, char *str)
 {
 	char *new = uml_strdup(str);
 
 	if(new == NULL){
 		printk("line_config - uml_strdup failed\n");
-		return(-ENOMEM);
+		return -ENOMEM;
 	}
-	return(!line_setup(lines, num, new, 0));
+	return !line_setup(lines, num, new, 0);
 }
 
-int line_get_config(char *name, struct line *lines, int num, char *str, 
+int line_get_config(char *name, struct line *lines, unsigned int num, char *str,
 		    int size, char **error_out)
 {
 	struct line *line;
@@ -464,47 +574,33 @@ int line_get_config(char *name, struct l
 	dev = simple_strtoul(name, &end, 0);
 	if((*end != '\0') || (end == name)){
 		*error_out = "line_get_config failed to parse device number";
-		return(0);
+		return 0;
 	}
 
 	if((dev < 0) || (dev >= num)){
-		*error_out = "device number of of range";
-		return(0);
+		*error_out = "device number out of range";
+		return 0;
 	}
 
 	line = &lines[dev];
 
-	down(&line->sem);
+	spin_lock(&line->lock);
 	if(!line->valid)
 		CONFIG_CHUNK(str, size, n, "none", 1);
 	else if(line->count == 0)
 		CONFIG_CHUNK(str, size, n, line->init_str, 1);
 	else n = chan_config_string(&line->chan_list, str, size, error_out);
-	up(&line->sem);
+	spin_unlock(&line->lock);
 
-	return(n);
+	return n;
 }
 
-int line_remove(struct line *lines, int num, char *str)
+int line_remove(struct line *lines, unsigned int num, char *str)
 {
 	char config[sizeof("conxxxx=none\0")];
 
 	sprintf(config, "%s=none", str);
-	return(!line_setup(lines, num, config, 0));
-}
-
-int line_write_room(struct tty_struct *tty)
-{
-	struct line *dev = tty->driver_data;
-	int room;
-
-	if (tty->stopped)
-		return 0;
-	room = write_room(dev);
-	if (0 == room)
-		printk(KERN_DEBUG "%s: %s: no room left in buffer\n",
-		       __FUNCTION__,tty->name);
-	return room;
+	return !line_setup(lines, num, config, 0);
 }
 
 struct tty_driver *line_register_devfs(struct lines *set,
@@ -553,7 +649,7 @@ void lines_init(struct line *lines, int 
 	for(i = 0; i < nlines; i++){
 		line = &lines[i];
 		INIT_LIST_HEAD(&line->chan_list);
-		sema_init(&line->sem, 1);
+		spin_lock_init(&line->lock);
 		if(line->init_str != NULL){
 			line->init_str = uml_strdup(line->init_str);
 			if(line->init_str == NULL)
@@ -587,7 +683,7 @@ irqreturn_t winch_interrupt(int irq, voi
 				       "errno = %d\n", -err);
 				printk("fd %d is losing SIGWINCH support\n",
 				       winch->tty_fd);
-				return(IRQ_HANDLED);
+				return IRQ_HANDLED;
 			}
 			goto out;
 		}
@@ -603,7 +699,7 @@ irqreturn_t winch_interrupt(int irq, voi
  out:
 	if(winch->fd != -1)
 		reactivate_fd(winch->fd, WINCH_IRQ);
-	return(IRQ_HANDLED);
+	return IRQ_HANDLED;
 }
 
 DECLARE_MUTEX(winch_handler_sem);
@@ -625,7 +721,7 @@ void register_winch_irq(int fd, int tty_
 				   .pid  	= pid,
 				   .tty 	= tty });
 	list_add(&winch->list, &winch_handlers);
-	if(um_request_irq(WINCH_IRQ, fd, IRQ_READ, winch_interrupt, 
+	if(um_request_irq(WINCH_IRQ, fd, IRQ_READ, winch_interrupt,
 			  SA_INTERRUPT | SA_SHIRQ | SA_SAMPLE_RANDOM, 
 			  "winch", winch) < 0)
 		printk("register_winch_irq - failed to register IRQ\n");
@@ -656,26 +752,16 @@ char *add_xterm_umid(char *base)
 	int len;
 
 	umid = get_umid(1);
-	if(umid == NULL) return(base);
+	if(umid == NULL)
+		return base;
 	
 	len = strlen(base) + strlen(" ()") + strlen(umid) + 1;
 	title = kmalloc(len, GFP_KERNEL);
 	if(title == NULL){
 		printk("Failed to allocate buffer for xterm title\n");
-		return(base);
+		return base;
 	}
 
 	snprintf(title, len, "%s (%s)", base, umid);
-	return(title);
+	return title;
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
diff -puN arch/um/include/line.h~uml-console-redo-locking arch/um/include/line.h
--- linux-2.6.12/arch/um/include/line.h~uml-console-redo-locking	2005-04-24 20:17:04.000000000 +0200
+++ linux-2.6.12-paolo/arch/um/include/line.h	2005-04-24 20:17:04.000000000 +0200
@@ -10,7 +10,7 @@
 #include "linux/workqueue.h"
 #include "linux/tty.h"
 #include "linux/interrupt.h"
-#include "asm/semaphore.h"
+#include "linux/spinlock.h"
 #include "chan_user.h"
 #include "mconsole_kern.h"
 
@@ -37,10 +37,18 @@ struct line {
 	struct list_head chan_list;
 	int valid;
 	int count;
-	struct semaphore sem;
+	/*This lock is actually, mostly, local to*/
+	spinlock_t lock;
+
+	/* Yes, this is a real circular buffer.
+	 * XXX: And this should become a struct kfifo!
+	 *
+	 * buffer points to a buffer allocated on demand, of length
+	 * LINE_BUFSIZE, head to the start of the ring, tail to the end.*/
 	char *buffer;
 	char *head;
 	char *tail;
+
 	int sigio;
 	struct work_struct task;
 	struct line_driver *driver;
@@ -52,7 +60,6 @@ struct line {
 	  init_pri :	INIT_STATIC, \
 	  chan_list : 	{ }, \
 	  valid :	1, \
-	  sem : 	{ }, \
 	  buffer :	NULL, \
 	  head :	NULL, \
 	  tail :	NULL, \
@@ -69,15 +76,18 @@ struct lines {
 extern void line_close(struct tty_struct *tty, struct file * filp);
 extern int line_open(struct line *lines, struct tty_struct *tty, 
 		     struct chan_opts *opts);
-extern int line_setup(struct line *lines, int num, char *init, 
+extern int line_setup(struct line *lines, unsigned int sizeof_lines, char *init,
 		      int all_allowed);
 extern int line_write(struct tty_struct *tty, const unsigned char *buf, int len);
 extern void line_put_char(struct tty_struct *tty, unsigned char ch);
 extern void line_set_termios(struct tty_struct *tty, struct termios * old);
 extern int line_chars_in_buffer(struct tty_struct *tty);
+extern void line_flush_buffer(struct tty_struct *tty);
+extern void line_flush_chars(struct tty_struct *tty);
 extern int line_write_room(struct tty_struct *tty);
 extern int line_ioctl(struct tty_struct *tty, struct file * file,
 		      unsigned int cmd, unsigned long arg);
+
 extern char *add_xterm_umid(char *base);
 extern int line_setup_irq(int fd, int input, int output, struct tty_struct *tty);
 extern void line_close_chan(struct line *line);
@@ -89,20 +99,10 @@ extern struct tty_driver * line_register
 				int nlines);
 extern void lines_init(struct line *lines, int nlines);
 extern void close_lines(struct line *lines, int nlines);
-extern int line_config(struct line *lines, int num, char *str);
-extern int line_remove(struct line *lines, int num, char *str);
-extern int line_get_config(char *dev, struct line *lines, int num, char *str, 
+
+extern int line_config(struct line *lines, unsigned int sizeof_lines, char *str);
+extern int line_remove(struct line *lines, unsigned int sizeof_lines, char *str);
+extern int line_get_config(char *dev, struct line *lines, unsigned int sizeof_lines, char *str,
 			   int size, char **error_out);
 
 #endif
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
diff -puN arch/um/drivers/ssl.c~uml-console-redo-locking arch/um/drivers/ssl.c
--- linux-2.6.12/arch/um/drivers/ssl.c~uml-console-redo-locking	2005-04-24 20:17:04.000000000 +0200
+++ linux-2.6.12-paolo/arch/um/drivers/ssl.c	2005-04-24 20:17:04.000000000 +0200
@@ -107,11 +107,6 @@ int ssl_open(struct tty_struct *tty, str
 }
 
 #if 0
-static int ssl_chars_in_buffer(struct tty_struct *tty)
-{
-	return(0);
-}
-
 static void ssl_flush_buffer(struct tty_struct *tty)
 {
 	return;
@@ -149,11 +144,11 @@ static struct tty_operations ssl_ops = {
 	.put_char 		= line_put_char,
 	.write_room		= line_write_room,
 	.chars_in_buffer 	= line_chars_in_buffer,
+	.flush_buffer 		= line_flush_buffer,
+	.flush_chars 		= line_flush_chars,
 	.set_termios 		= line_set_termios,
 	.ioctl 	 		= line_ioctl,
 #if 0
-	.flush_chars 		= ssl_flush_chars,
-	.flush_buffer 		= ssl_flush_buffer,
 	.throttle 		= ssl_throttle,
 	.unthrottle 		= ssl_unthrottle,
 	.stop 	 		= ssl_stop,
@@ -171,10 +166,11 @@ static void ssl_console_write(struct con
 			      unsigned len)
 {
 	struct line *line = &serial_lines[c->index];
+	unsigned long flags;
 
-	down(&line->sem);
+	spin_lock_irqsave(&line->lock, flags);
 	console_write_chan(&line->chan_list, string, len);
-	up(&line->sem);
+	spin_unlock_irqrestore(&line->lock, flags);
 }
 
 static struct tty_driver *ssl_console_device(struct console *c, int *index)
@@ -238,14 +234,3 @@ static int ssl_chan_setup(char *str)
 
 __setup("ssl", ssl_chan_setup);
 __channel_help(ssl_chan_setup, "ssl");
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
diff -puN arch/um/drivers/stdio_console.c~uml-console-redo-locking arch/um/drivers/stdio_console.c
--- linux-2.6.12/arch/um/drivers/stdio_console.c~uml-console-redo-locking	2005-04-24 20:17:04.000000000 +0200
+++ linux-2.6.12-paolo/arch/um/drivers/stdio_console.c	2005-04-24 20:17:04.000000000 +0200
@@ -116,8 +116,11 @@ static struct tty_operations console_ops
 	.open 	 		= con_open,
 	.close 	 		= line_close,
 	.write 	 		= line_write,
+	.put_char 		= line_put_char,
  	.write_room		= line_write_room,
 	.chars_in_buffer 	= line_chars_in_buffer,
+	.flush_buffer 		= line_flush_buffer,
+	.flush_chars 		= line_flush_chars,
 	.set_termios 		= line_set_termios,
 	.ioctl 	 		= line_ioctl,
 };
@@ -126,10 +129,11 @@ static void uml_console_write(struct con
 			  unsigned len)
 {
 	struct line *line = &vts[console->index];
+	unsigned long flags;
 
-	down(&line->sem);
+	spin_lock_irqsave(&line->lock, flags);
 	console_write_chan(&line->chan_list, string, len);
-	up(&line->sem);
+	spin_unlock_irqrestore(&line->lock, flags);
 }
 
 static struct tty_driver *uml_console_device(struct console *c, int *index)
@@ -192,14 +196,3 @@ static int console_chan_setup(char *str)
 }
 __setup("con", console_chan_setup);
 __channel_help(console_chan_setup, "con");
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
diff -puN arch/um/drivers/chan_kern.c~uml-console-redo-locking arch/um/drivers/chan_kern.c
--- linux-2.6.12/arch/um/drivers/chan_kern.c~uml-console-redo-locking	2005-04-24 20:17:04.000000000 +0200
+++ linux-2.6.12-paolo/arch/um/drivers/chan_kern.c	2005-04-24 20:17:04.000000000 +0200
@@ -22,7 +22,7 @@
 #ifdef CONFIG_NOCONFIG_CHAN
 static void *not_configged_init(char *str, int device, struct chan_opts *opts)
 {
-	printk(KERN_ERR "Using a channel type which is configured out of "
+	printf(KERN_ERR "Using a channel type which is configured out of "
 	       "UML\n");
 	return(NULL);
 }
@@ -30,27 +30,27 @@ static void *not_configged_init(char *st
 static int not_configged_open(int input, int output, int primary, void *data,
 			      char **dev_out)
 {
-	printk(KERN_ERR "Using a channel type which is configured out of "
+	printf(KERN_ERR "Using a channel type which is configured out of "
 	       "UML\n");
 	return(-ENODEV);
 }
 
 static void not_configged_close(int fd, void *data)
 {
-	printk(KERN_ERR "Using a channel type which is configured out of "
+	printf(KERN_ERR "Using a channel type which is configured out of "
 	       "UML\n");
 }
 
 static int not_configged_read(int fd, char *c_out, void *data)
 {
-	printk(KERN_ERR "Using a channel type which is configured out of "
+	printf(KERN_ERR "Using a channel type which is configured out of "
 	       "UML\n");
 	return(-EIO);
 }
 
 static int not_configged_write(int fd, const char *buf, int len, void *data)
 {
-	printk(KERN_ERR "Using a channel type which is configured out of "
+	printf(KERN_ERR "Using a channel type which is configured out of "
 	       "UML\n");
 	return(-EIO);
 }
@@ -58,7 +58,7 @@ static int not_configged_write(int fd, c
 static int not_configged_console_write(int fd, const char *buf, int len,
 				       void *data)
 {
-	printk(KERN_ERR "Using a channel type which is configured out of "
+	printf(KERN_ERR "Using a channel type which is configured out of "
 	       "UML\n");
 	return(-EIO);
 }
@@ -66,14 +66,14 @@ static int not_configged_console_write(i
 static int not_configged_window_size(int fd, void *data, unsigned short *rows,
 				     unsigned short *cols)
 {
-	printk(KERN_ERR "Using a channel type which is configured out of "
+	printf(KERN_ERR "Using a channel type which is configured out of "
 	       "UML\n");
 	return(-ENODEV);
 }
 
 static void not_configged_free(void *data)
 {
-	printk(KERN_ERR "Using a channel type which is configured out of "
+	printf(KERN_ERR "Using a channel type which is configured out of "
 	       "UML\n");
 }
 
_
