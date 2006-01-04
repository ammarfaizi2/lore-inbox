Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965093AbWACXql@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965093AbWACXql (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 18:46:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965132AbWACXqZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 18:46:25 -0500
Received: from saraswathi.solana.com ([198.99.130.12]:41877 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S965134AbWACXpz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 18:45:55 -0500
Message-Id: <200601040037.k040bjax012566@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
Subject: [PATCH 9/12] UML - move console configuration
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 03 Jan 2006 19:37:45 -0500
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch changes when console devices are configured in order to
prepare the ground for the next patch.
parse_chan_pair is now done earlier, when initcalls are run, rather
than when the device is opened.
When a host device disappears, the channel list is closed, but not
freed.  This is required by the previous change.
line_config now takes the options structure as an argument, and
line_open doesn't.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.15/arch/um/drivers/chan_kern.c
===================================================================
--- linux-2.6.15.orig/arch/um/drivers/chan_kern.c	2006-01-03 18:04:29.000000000 -0500
+++ linux-2.6.15/arch/um/drivers/chan_kern.c	2006-01-03 18:22:36.000000000 -0500
@@ -311,14 +311,12 @@ int console_write_chan(struct list_head 
 int console_open_chan(struct line *line, struct console *co,
 		      struct chan_opts *opts)
 {
-	if (!list_empty(&line->chan_list))
-		return 0;
+	int err;
+
+	err = open_chan(&line->chan_list);
+	if(err)
+		return err;
 
-	if (0 != parse_chan_pair(line->init_str, &line->chan_list,
-				 co->index, opts))
-		return -1;
-	if (0 != open_chan(&line->chan_list))
-		return -1;
 	printk("Console initialized on /dev/%s%d\n",co->name,co->index);
 	return 0;
 }
@@ -596,13 +594,11 @@ void chan_interrupt(struct list_head *ch
 					tty_hangup(tty);
 				line_disable(tty, irq);
 				close_chan(chans);
-				free_chan(chans);
 				return;
 			}
 			else {
 				if(chan->ops->close != NULL)
 					chan->ops->close(chan->fd, chan->data);
-				free_one_chan(chan);
 			}
 		}
 	}
Index: linux-2.6.15/arch/um/drivers/line.c
===================================================================
--- linux-2.6.15.orig/arch/um/drivers/line.c	2006-01-03 18:05:06.000000000 -0500
+++ linux-2.6.15/arch/um/drivers/line.c	2006-01-03 18:23:33.000000000 -0500
@@ -419,8 +419,7 @@ void line_disable(struct tty_struct *tty
 	line->have_irq = 0;
 }
 
-int line_open(struct line *lines, struct tty_struct *tty,
-	      struct chan_opts *opts)
+int line_open(struct line *lines, struct tty_struct *tty)
 {
 	struct line *line;
 	int err = 0;
@@ -436,13 +435,11 @@ int line_open(struct line *lines, struct
 			err = -ENODEV;
 			goto out;
 		}
-		if (list_empty(&line->chan_list)) {
-			err = parse_chan_pair(line->init_str, &line->chan_list,
-					      tty->index, opts);
-			if(err) goto out;
-			err = open_chan(&line->chan_list);
-			if(err) goto out;
-		}
+
+		err = open_chan(&line->chan_list);
+		if(err)
+			goto out;
+
 		/* Here the interrupt is registered.*/
 		enable_chan(&line->chan_list, tty);
 		INIT_WORK(&line->task, line_timer_cb, tty);
@@ -558,8 +555,10 @@ int line_setup(struct line *lines, unsig
 	return n == -1 ? num : n;
 }
 
-int line_config(struct line *lines, unsigned int num, char *str)
+int line_config(struct line *lines, unsigned int num, char *str,
+		struct chan_opts *opts)
 {
+	struct line *line;
 	char *new;
 	int n;
 
@@ -572,10 +571,14 @@ int line_config(struct line *lines, unsi
 	new = kstrdup(str, GFP_KERNEL);
 	if(new == NULL){
 		printk("line_config - kstrdup failed\n");
-		return -ENOMEM;
+		return 1;
 	}
 	n = line_setup(lines, num, new);
-	return n < 0 ? n : 0;
+	if(n < 0)
+		return 1;
+
+	line = &lines[n];
+	return parse_chan_pair(line->init_str, &line->chan_list, n, opts);
 }
 
 int line_get_config(char *name, struct line *lines, unsigned int num, char *str,
@@ -677,7 +680,7 @@ struct tty_driver *line_register_devfs(s
 static DEFINE_SPINLOCK(winch_handler_lock);
 static LIST_HEAD(winch_handlers);
 
-void lines_init(struct line *lines, int nlines)
+void lines_init(struct line *lines, int nlines, struct chan_opts *opts)
 {
 	struct line *line;
 	int i;
@@ -692,6 +695,11 @@ void lines_init(struct line *lines, int 
 		line->init_str = kstrdup(line->init_str, GFP_KERNEL);
 		if(line->init_str == NULL)
 			printk("lines_init - kstrdup returned NULL\n");
+
+		if(parse_chan_pair(line->init_str, &line->chan_list, i, opts)){
+			printk("parse_chan_pair failed for device %d\n", i);
+			line->valid = 0;
+		}
 	}
 }
 
Index: linux-2.6.15/arch/um/drivers/ssl.c
===================================================================
--- linux-2.6.15.orig/arch/um/drivers/ssl.c	2006-01-03 18:04:41.000000000 -0500
+++ linux-2.6.15/arch/um/drivers/ssl.c	2006-01-03 18:22:36.000000000 -0500
@@ -84,7 +84,7 @@ static struct lines lines = LINES_INIT(N
 
 static int ssl_config(char *str)
 {
-	return line_config(serial_lines, ARRAY_SIZE(serial_lines), str);
+	return line_config(serial_lines, ARRAY_SIZE(serial_lines), str, &opts);
 }
 
 static int ssl_get_config(char *dev, char *str, int size, char **error_out)
@@ -100,7 +100,7 @@ static int ssl_remove(int n)
 
 int ssl_open(struct tty_struct *tty, struct file *filp)
 {
-	return line_open(serial_lines, tty, &opts);
+	return line_open(serial_lines, tty);
 }
 
 #if 0
@@ -202,7 +202,7 @@ int ssl_init(void)
 					 serial_lines,
 					 ARRAY_SIZE(serial_lines));
 
-	lines_init(serial_lines, ARRAY_SIZE(serial_lines));
+	lines_init(serial_lines, ARRAY_SIZE(serial_lines), &opts);
 
 	new_title = add_xterm_umid(opts.xterm_title);
 	if (new_title != NULL)
Index: linux-2.6.15/arch/um/drivers/stdio_console.c
===================================================================
--- linux-2.6.15.orig/arch/um/drivers/stdio_console.c	2006-01-03 18:04:41.000000000 -0500
+++ linux-2.6.15/arch/um/drivers/stdio_console.c	2006-01-03 18:22:36.000000000 -0500
@@ -91,7 +91,7 @@ struct line vts[MAX_TTYS] = { LINE_INIT(
 
 static int con_config(char *str)
 {
-	return line_config(vts, ARRAY_SIZE(vts), str);
+	return line_config(vts, ARRAY_SIZE(vts), str, &opts);
 }
 
 static int con_get_config(char *dev, char *str, int size, char **error_out)
@@ -106,7 +106,7 @@ static int con_remove(int n)
 
 static int con_open(struct tty_struct *tty, struct file *filp)
 {
-	return line_open(vts, tty, &opts);
+	return line_open(vts, tty);
 }
 
 static int con_init_done = 0;
@@ -169,7 +169,7 @@ int stdio_init(void)
 		return -1;
 	printk(KERN_INFO "Initialized stdio console driver\n");
 
-	lines_init(vts, ARRAY_SIZE(vts));
+	lines_init(vts, ARRAY_SIZE(vts), &opts);
 
 	new_title = add_xterm_umid(opts.xterm_title);
 	if(new_title != NULL)
Index: linux-2.6.15/arch/um/include/line.h
===================================================================
--- linux-2.6.15.orig/arch/um/include/line.h	2006-01-03 18:04:52.000000000 -0500
+++ linux-2.6.15/arch/um/include/line.h	2006-01-03 18:22:36.000000000 -0500
@@ -74,8 +74,7 @@ struct lines {
 #define LINES_INIT(n) {  num :		n }
 
 extern void line_close(struct tty_struct *tty, struct file * filp);
-extern int line_open(struct line *lines, struct tty_struct *tty,
-		     struct chan_opts *opts);
+extern int line_open(struct line *lines, struct tty_struct *tty);
 extern int line_setup(struct line *lines, unsigned int sizeof_lines,
 		      char *init);
 extern int line_write(struct tty_struct *tty, const unsigned char *buf,
@@ -99,11 +98,11 @@ extern struct tty_driver * line_register
 				struct tty_operations *driver,
 				struct line *lines,
 				int nlines);
-extern void lines_init(struct line *lines, int nlines);
+extern void lines_init(struct line *lines, int nlines, struct chan_opts *opts);
 extern void close_lines(struct line *lines, int nlines);
 
 extern int line_config(struct line *lines, unsigned int sizeof_lines,
-		       char *str);
+		       char *str, struct chan_opts *opts);
 extern int line_id(char **str, int *start_out, int *end_out);
 extern int line_remove(struct line *lines, unsigned int sizeof_lines, int n);
 extern int line_get_config(char *dev, struct line *lines,

