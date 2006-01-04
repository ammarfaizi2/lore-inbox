Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964993AbWACXs2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964993AbWACXs2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 18:48:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964930AbWACXqH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 18:46:07 -0500
Received: from saraswathi.solana.com ([198.99.130.12]:38549 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S964993AbWACXpv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 18:45:51 -0500
Message-Id: <200601040037.k040bo1L012582@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
Subject: [PATCH 12/12] UML - Add throttling to console driver
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 03 Jan 2006 19:37:50 -0500
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds support for throttling and unthrottling input when
the tty driver can't handle it.

Index: linux-2.6.15/arch/um/drivers/ssl.c
===================================================================
--- linux-2.6.15.orig/arch/um/drivers/ssl.c	2006-01-03 17:32:45.000000000 -0500
+++ linux-2.6.15/arch/um/drivers/ssl.c	2006-01-03 17:35:00.000000000 -0500
@@ -109,16 +109,6 @@ static void ssl_flush_buffer(struct tty_
 	return;
 }
 
-static void ssl_throttle(struct tty_struct * tty)
-{
-	printk(KERN_ERR "Someone should implement ssl_throttle\n");
-}
-
-static void ssl_unthrottle(struct tty_struct * tty)
-{
-	printk(KERN_ERR "Someone should implement ssl_unthrottle\n");
-}
-
 static void ssl_stop(struct tty_struct *tty)
 {
 	printk(KERN_ERR "Someone should implement ssl_stop\n");
@@ -145,9 +135,9 @@ static struct tty_operations ssl_ops = {
 	.flush_chars 		= line_flush_chars,
 	.set_termios 		= line_set_termios,
 	.ioctl 	 		= line_ioctl,
+	.throttle 		= line_throttle,
+	.unthrottle 		= line_unthrottle,
 #if 0
-	.throttle 		= ssl_throttle,
-	.unthrottle 		= ssl_unthrottle,
 	.stop 	 		= ssl_stop,
 	.start 	 		= ssl_start,
 	.hangup 	 	= ssl_hangup,
Index: linux-2.6.15/arch/um/drivers/stdio_console.c
===================================================================
--- linux-2.6.15.orig/arch/um/drivers/stdio_console.c	2006-01-03 17:32:45.000000000 -0500
+++ linux-2.6.15/arch/um/drivers/stdio_console.c	2006-01-03 17:35:00.000000000 -0500
@@ -122,6 +122,8 @@ static struct tty_operations console_ops
 	.flush_chars 		= line_flush_chars,
 	.set_termios 		= line_set_termios,
 	.ioctl 	 		= line_ioctl,
+	.throttle 		= line_throttle,
+	.unthrottle 		= line_unthrottle,
 };
 
 static void uml_console_write(struct console *console, const char *string,
Index: linux-2.6.15/arch/um/include/line.h
===================================================================
--- linux-2.6.15.orig/arch/um/include/line.h	2006-01-03 17:33:23.000000000 -0500
+++ linux-2.6.15/arch/um/include/line.h	2006-01-03 17:35:00.000000000 -0500
@@ -38,6 +38,7 @@ struct line {
 	struct list_head chan_list;
 	int valid;
 	int count;
+	int throttled;
 	/*This lock is actually, mostly, local to*/
 	spinlock_t lock;
 
@@ -60,6 +61,7 @@ struct line {
 	{ init_str :	str, \
 	  init_pri :	INIT_STATIC, \
 	  valid :	1, \
+	  throttled :	0, \
 	  lock :	SPIN_LOCK_UNLOCKED, \
 	  buffer :	NULL, \
 	  head :	NULL, \
@@ -88,6 +90,8 @@ extern void line_flush_chars(struct tty_
 extern int line_write_room(struct tty_struct *tty);
 extern int line_ioctl(struct tty_struct *tty, struct file * file,
 		      unsigned int cmd, unsigned long arg);
+extern void line_throttle(struct tty_struct *tty);
+extern void line_unthrottle(struct tty_struct *tty);
 
 extern char *add_xterm_umid(char *base);
 extern int line_setup_irq(int fd, int input, int output, struct line *line,
Index: linux-2.6.15/arch/um/drivers/line.c
===================================================================
--- linux-2.6.15.orig/arch/um/drivers/line.c	2006-01-03 17:33:23.000000000 -0500
+++ linux-2.6.15/arch/um/drivers/line.c	2006-01-03 17:35:00.000000000 -0500
@@ -36,8 +36,9 @@ static void line_timer_cb(void *arg)
 {
 	struct line *line = arg;
 
-	chan_interrupt(&line->chan_list, &line->task, line->tty,
-		       line->driver->read_irq);
+	if(!line->throttled)
+		chan_interrupt(&line->chan_list, &line->task, line->tty,
+			       line->driver->read_irq);
 }
 
 /* Returns the free space inside the ring buffer of this line.
@@ -340,6 +341,30 @@ int line_ioctl(struct tty_struct *tty, s
 	return ret;
 }
 
+void line_throttle(struct tty_struct *tty)
+{
+	struct line *line = tty->driver_data;
+
+	deactivate_chan(&line->chan_list, line->driver->read_irq);
+	line->throttled = 1;
+}
+
+void line_unthrottle(struct tty_struct *tty)
+{
+	struct line *line = tty->driver_data;
+
+	line->throttled = 0;
+	chan_interrupt(&line->chan_list, &line->task, tty,
+		       line->driver->read_irq);
+
+	/* Maybe there is enough stuff pending that calling the interrupt
+	 * throttles us again.  In this case, line->throttled will be 1
+	 * again and we shouldn't turn the interrupt back on.
+	 */
+	if(!line->throttled)
+		reactivate_chan(&line->chan_list, line->driver->read_irq);
+}
+
 static irqreturn_t line_write_interrupt(int irq, void *data,
 					struct pt_regs *unused)
 {
Index: linux-2.6.15/arch/um/drivers/chan_kern.c
===================================================================
--- linux-2.6.15.orig/arch/um/drivers/chan_kern.c	2006-01-03 17:34:49.000000000 -0500
+++ linux-2.6.15/arch/um/drivers/chan_kern.c	2006-01-03 17:35:00.000000000 -0500
@@ -312,6 +312,32 @@ void close_chan(struct list_head *chans,
 	}
 }
 
+void deactivate_chan(struct list_head *chans, int irq)
+{
+	struct list_head *ele;
+
+	struct chan *chan;
+	list_for_each(ele, chans) {
+		chan = list_entry(ele, struct chan, list);
+
+		if(chan->enabled && chan->input)
+			deactivate_fd(chan->fd, irq);
+	}
+}
+
+void reactivate_chan(struct list_head *chans, int irq)
+{
+	struct list_head *ele;
+	struct chan *chan;
+
+	list_for_each(ele, chans) {
+		chan = list_entry(ele, struct chan, list);
+
+		if(chan->enabled && chan->input)
+			reactivate_fd(chan->fd, irq);
+	}
+}
+
 int write_chan(struct list_head *chans, const char *buf, int len,
 	       int write_irq)
 {
Index: linux-2.6.15/arch/um/include/chan_kern.h
===================================================================
--- linux-2.6.15.orig/arch/um/include/chan_kern.h	2006-01-03 17:33:23.000000000 -0500
+++ linux-2.6.15/arch/um/include/chan_kern.h	2006-01-03 17:35:00.000000000 -0500
@@ -38,6 +38,8 @@ extern int console_write_chan(struct lis
 			      int len);
 extern int console_open_chan(struct line *line, struct console *co,
 			     struct chan_opts *opts);
+extern void deactivate_chan(struct list_head *chans, int irq);
+extern void reactivate_chan(struct list_head *chans, int irq);
 extern void chan_enable_winch(struct list_head *chans, struct tty_struct *tty);
 extern void enable_chan(struct line *line);
 extern void close_chan(struct list_head *chans, int delay_free_irq);

