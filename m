Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262822AbUKXT7M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262822AbUKXT7M (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 14:59:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262823AbUKXT7M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 14:59:12 -0500
Received: from elch.in-berlin.de ([192.109.42.5]:33717 "EHLO elch.in-berlin.de")
	by vger.kernel.org with ESMTP id S262822AbUKXT5M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 14:57:12 -0500
X-Envelope-From: kraxel@bytesex.org
Date: Wed, 24 Nov 2004 19:53:41 +0100
From: Gerd Knorr <kraxel@bytesex.org>
To: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       uml devel <user-mode-linux-devel@lists.sourceforge.net>
Subject: [patch] uml: terminal cleanup
Message-ID: <20041124185341.GA26773@bytesex>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi,

This is a major cleanup of the uml terminal drivers and console handling
(console as in "where the kernel messages go to", not as in "linux
virtual terminals").  The changes in detail:

 (1) There is a new console driver calles "stderr" which (as the name
     implies) simply dumps all kernel messages to stderr.  That one
     is registered very early in the boot process via console_initcall()
     and will print every almost kernel message instantly: Both very
     early in the boot process and very late in shutdown.
     Note that this is not enabled by default, see below for details.

 (2) Ditched the early-console-init hackery in stdio_console.c
     (open_console(NULL) + related stuff) into the waste basket, not
     needed any more as you can use the new stderr console driver to
     get the kernel messages if your kernel crashes very early in the
     boot process.

 (3) Handle console initialitation for the uml stdio console and
     virtual serial lines the normal way using the console->setup()
     function.  Now all kernel messages appear on your console device
     once it is initialized without any dirty tricks.

 (4) The (2) changes allow a number of further cleanups:  As we don't
     open a line without a tty_struct any more we can ...
      * hook struct line into tty->driver_data
      * pass around tty_struct instead of struct line everythere
      * get rid of some trivial wrappers in ssl.c and stdio_console.c
        because we can get struct line via tty_struct all the time now.

 (5) Change the ordering in the arch/um/drivers/Makefile and thus
     the link and initialization order to make sure the stdio console
     and not the virtual serial line is the default console device.

 (6) Fixed a number of Documentation/CodingStyle issues within the
     code (not systematically, but usually just the places I was
     touching anyway or where it bugged me while browsing the code
     because it was hard to read).

Looks like that cleanup also fixed some strange tty issues I've seen in
the past (like console getty not responding to input sometimes, suse's
/sbin/blogd causing trouble).

Finally some usage notes for using the new stderr console:

If the stderr console is enabled, then it is the default console device
because it registeres very early in the boot process.  But as it isn't
linked to a tty device this makes init unhappy, you'll see "can't open
initial console" error messages.  Because you usually don't want that
the stderr console is turned off by default.  That also maintains the
behavior that /dev/tty0 is the first console device registered and thus
the default console.

There are basically two useful use cases for the stderr console:

 (1) Your kernel dies before the normal console device is initialized
     and thus you don't see any messages.  Just enable the stderr
     console to see them by adding "stderr=1" to the kernel command line.

 (2) You want to have the kernel messages on both stderr and your
     console terminal device.  Try something like this:

	$ ./linux stderr=1 console=stderr console=ttyS0 ssl0=xterm

     This example sets up the console on a virtual serial line and
     pops up an xterm for that.

Enjoy!

  Gerd

Signed-off-by: Gerd Knorr <kraxel@bytesex.org>
---
 arch/um/Kconfig_char             |    6 
 arch/um/drivers/Makefile         |    7 
 arch/um/drivers/chan_kern.c      |   42 +++-
 arch/um/drivers/chan_user.c      |   10 -
 arch/um/drivers/line.c           |  265 +++++++++++++++++++------------
 arch/um/drivers/pty.c            |    3 
 arch/um/drivers/ssl.c            |  126 ++++----------
 arch/um/drivers/stderr_console.c |   45 +++++
 arch/um/drivers/stdio_console.c  |  148 +++++------------
 arch/um/drivers/xterm.c          |    4 
 arch/um/include/chan_kern.h      |   10 -
 arch/um/include/chan_user.h      |    5 
 arch/um/include/line.h           |   16 +
 13 files changed, 364 insertions(+), 323 deletions(-)

Index: linux-2004-11-23/arch/um/Kconfig_char
===================================================================
--- linux-2004-11-23.orig/arch/um/Kconfig_char	2004-11-24 12:52:29.136355847 +0100
+++ linux-2004-11-23/arch/um/Kconfig_char	2004-11-24 18:15:00.021154578 +0100
@@ -1,6 +1,12 @@
 
 menu "Character Devices"
 
+config STDERR_CONSOLE
+	bool "stderr console"
+	default y
+	help
+	console driver which dumps all printk messages to stderr.
+
 config STDIO_CONSOLE
 	bool
 	default y
Index: linux-2004-11-23/arch/um/drivers/Makefile
===================================================================
--- linux-2004-11-23.orig/arch/um/drivers/Makefile	2004-11-24 12:54:41.704006841 +0100
+++ linux-2004-11-23/arch/um/drivers/Makefile	2004-11-24 18:15:00.022154416 +0100
@@ -20,8 +20,10 @@ ubd-objs := ubd_kern.o ubd_user.o
 port-objs := port_kern.o port_user.o
 harddog-objs := harddog_kern.o harddog_user.o
 
-obj-y = 
-obj-$(CONFIG_SSL) += ssl.o 
+obj-y := stdio_console.o $(CHAN_OBJS)
+obj-$(CONFIG_SSL) += ssl.o
+obj-$(CONFIG_STDERR_CONSOLE) += stderr_console.o
+
 obj-$(CONFIG_UML_NET_SLIP) += slip.o
 obj-$(CONFIG_UML_NET_SLIRP) += slirp.o
 obj-$(CONFIG_UML_NET_DAEMON) += daemon.o 
@@ -41,7 +43,6 @@ obj-$(CONFIG_XTERM_CHAN) += xterm.o xter
 obj-$(CONFIG_UML_WATCHDOG) += harddog.o
 obj-$(CONFIG_BLK_DEV_COW_COMMON) += cow_user.o
 
-obj-y += stdio_console.o $(CHAN_OBJS)
 
 USER_SINGLE_OBJS = $(foreach f,$(patsubst %.o,%,$(obj-y) $(obj-m)),$($(f)-objs))
 
Index: linux-2004-11-23/arch/um/drivers/chan_kern.c
===================================================================
--- linux-2004-11-23.orig/arch/um/drivers/chan_kern.c	2004-11-24 12:54:28.113199088 +0100
+++ linux-2004-11-23/arch/um/drivers/chan_kern.c	2004-11-24 18:15:00.025153929 +0100
@@ -189,7 +189,7 @@ int open_chan(struct list_head *chans)
 	return(err);
 }
 
-void chan_enable_winch(struct list_head *chans, void *line)
+void chan_enable_winch(struct list_head *chans, struct tty_struct *tty)
 {
 	struct list_head *ele;
 	struct chan *chan;
@@ -197,13 +197,13 @@ void chan_enable_winch(struct list_head 
 	list_for_each(ele, chans){
 		chan = list_entry(ele, struct chan, list);
 		if(chan->primary && chan->output && chan->ops->winch){
-			register_winch(chan->fd, line);
+			register_winch(chan->fd, tty);
 			return;
 		}
 	}
 }
 
-void enable_chan(struct list_head *chans, void *data)
+void enable_chan(struct list_head *chans, struct tty_struct *tty)
 {
 	struct list_head *ele;
 	struct chan *chan;
@@ -212,7 +212,7 @@ void enable_chan(struct list_head *chans
 		chan = list_entry(ele, struct chan, list);
 		if(!chan->opened) continue;
 
-		line_setup_irq(chan->fd, chan->input, chan->output, data);
+		line_setup_irq(chan->fd, chan->input, chan->output, tty);
 	}
 }
 
@@ -240,21 +240,23 @@ int write_chan(struct list_head *chans, 
 	       int write_irq)
 {
 	struct list_head *ele;
-	struct chan *chan;
+	struct chan *chan = NULL;
 	int n, ret = 0;
 
-	list_for_each(ele, chans){
+	list_for_each(ele, chans) {
 		chan = list_entry(ele, struct chan, list);
-		if(!chan->output || (chan->ops->write == NULL)) continue;
+		if (!chan->output || (chan->ops->write == NULL))
+			continue;
 		n = chan->ops->write(chan->fd, buf, len, chan->data);
-		if(chan->primary){
+		if (chan->primary) {
 			ret = n;
-			if((ret == -EAGAIN) || ((ret >= 0) && (ret < len))){
+			if ((ret == -EAGAIN) || ((ret >= 0) && (ret < len))){
 				reactivate_fd(chan->fd, write_irq);
-				if(ret == -EAGAIN) ret = 0;
+				if (ret == -EAGAIN)
+					ret = 0;
 			}
 		}
-	}
+	}	
 	return(ret);
 }
 
@@ -274,6 +276,20 @@ int console_write_chan(struct list_head 
 	return(ret);
 }
 
+int console_open_chan(struct line *line, struct console *co, struct chan_opts *opts)
+{
+	if (!list_empty(&line->chan_list))
+		return 0;
+
+	if (0 != parse_chan_pair(line->init_str, &line->chan_list,
+				 line->init_pri, co->index, opts))
+		return -1;
+	if (0 != open_chan(&line->chan_list))
+		return -1;
+	printk("Console initialized on /dev/%s%d\n",co->name,co->index);
+	return 0;
+}
+
 int chan_window_size(struct list_head *chans, unsigned short *rows_out,
 		      unsigned short *cols_out)
 {
@@ -516,7 +532,7 @@ int chan_out_fd(struct list_head *chans)
 }
 
 void chan_interrupt(struct list_head *chans, struct work_struct *task,
-		    struct tty_struct *tty, int irq, void *dev)
+		    struct tty_struct *tty, int irq)
 {
 	struct list_head *ele, *next;
 	struct chan *chan;
@@ -542,7 +558,7 @@ void chan_interrupt(struct list_head *ch
 			if(chan->primary){
 				if(tty != NULL)
 					tty_hangup(tty);
-				line_disable(dev, irq);
+				line_disable(tty, irq);
 				close_chan(chans);
 				free_chan(chans);
 				return;
Index: linux-2004-11-23/arch/um/drivers/chan_user.c
===================================================================
--- linux-2004-11-23.orig/arch/um/drivers/chan_user.c	2004-11-24 12:50:38.560153813 +0100
+++ linux-2004-11-23/arch/um/drivers/chan_user.c	2004-11-24 18:15:00.027153605 +0100
@@ -110,7 +110,7 @@ static int winch_thread(void *arg)
 	}
 }
 
-static int winch_tramp(int fd, void *device_data, int *fd_out)
+static int winch_tramp(int fd, struct tty_struct *tty, int *fd_out)
 {
 	struct winch_data data;
 	unsigned long stack;
@@ -144,7 +144,7 @@ static int winch_tramp(int fd, void *dev
 	return(pid);
 }
 
-void register_winch(int fd, void *device_data)
+void register_winch(int fd, struct tty_struct *tty)
 {
 	int pid, thread, thread_fd;
 	int count;
@@ -155,10 +155,10 @@ void register_winch(int fd, void *device
 
 	pid = tcgetpgrp(fd);
 	if(!CHOOSE_MODE_PROC(is_tracer_winch, is_skas_winch, pid, fd,
-			     device_data) && (pid == -1)){
-		thread = winch_tramp(fd, device_data, &thread_fd);
+			     tty) && (pid == -1)){
+		thread = winch_tramp(fd, tty, &thread_fd);
 		if(fd != -1){
-			register_winch_irq(thread_fd, fd, thread, device_data);
+			register_winch_irq(thread_fd, fd, thread, tty);
 
 			count = os_write_file(thread_fd, &c, sizeof(c));
 			if(count != sizeof(c))
Index: linux-2004-11-23/arch/um/drivers/line.c
===================================================================
--- linux-2004-11-23.orig/arch/um/drivers/line.c	2004-11-24 12:54:20.774382554 +0100
+++ linux-2004-11-23/arch/um/drivers/line.c	2004-11-24 18:15:00.032152794 +0100
@@ -6,6 +6,7 @@
 #include "linux/sched.h"
 #include "linux/slab.h"
 #include "linux/list.h"
+#include "linux/kd.h"
 #include "linux/interrupt.h"
 #include "linux/devfs_fs_kernel.h"
 #include "asm/uaccess.h"
@@ -22,30 +23,33 @@
 
 static irqreturn_t line_interrupt(int irq, void *data, struct pt_regs *unused)
 {
-	struct line *dev = data;
+	struct tty_struct *tty = data;
+	struct line *line = tty->driver_data;
 
-	if(dev->count > 0) 
-		chan_interrupt(&dev->chan_list, &dev->task, dev->tty, irq, 
-			       dev);
+	if (line) 
+		chan_interrupt(&line->chan_list, &line->task, tty, irq);
 	return IRQ_HANDLED;
 }
 
 static void line_timer_cb(void *arg)
 {
-	struct line *dev = arg;
-
-	line_interrupt(dev->driver->read_irq, dev, NULL);
+	struct tty_struct *tty = arg;
+	struct line *line = tty->driver_data;
+	
+	line_interrupt(line->driver->read_irq, arg, NULL);
 }
 
 static int write_room(struct line *dev)
 {
 	int n;
 
-	if(dev->buffer == NULL) return(LINE_BUFSIZE - 1);
+	if (dev->buffer == NULL)
+		return (LINE_BUFSIZE - 1);
 
 	n = dev->head - dev->tail;
-	if(n <= 0) n = LINE_BUFSIZE + n;
-	return(n - 1);
+	if (n <= 0)
+		n = LINE_BUFSIZE + n;
+	return (n - 1);
 }
 
 static int buffer_data(struct line *line, const char *buf, int len)
@@ -54,7 +58,7 @@ static int buffer_data(struct line *line
 
 	if(line->buffer == NULL){
 		line->buffer = kmalloc(LINE_BUFSIZE, GFP_ATOMIC);
-		if(line->buffer == NULL){
+		if (line->buffer == NULL) {
 			printk("buffer_data - atomic allocation failed\n");
 			return(0);
 		}
@@ -84,14 +88,17 @@ static int flush_buffer(struct line *lin
 {
 	int n, count;
 
-	if((line->buffer == NULL) || (line->head == line->tail)) return(1);
+	if ((line->buffer == NULL) || (line->head == line->tail))
+		return(1);
 
-	if(line->tail < line->head){
+	if (line->tail < line->head) {
 		count = line->buffer + LINE_BUFSIZE - line->head;
 		n = write_chan(&line->chan_list, line->head, count,
 			       line->driver->write_irq);
-		if(n < 0) return(n);
-		if(n == count) line->head = line->buffer;
+		if (n < 0)
+			return(n);
+		if (n == count)
+			line->head = line->buffer;
 		else {
 			line->head += n;
 			return(0);
@@ -107,25 +114,22 @@ static int flush_buffer(struct line *lin
 	return(line->head == line->tail);
 }
 
-int line_write(struct line *lines, struct tty_struct *tty, const char *buf, int len)
+int line_write(struct tty_struct *tty, const unsigned char *buf, int len)
 {
-	struct line *line;
+	struct line *line = tty->driver_data;
 	unsigned long flags;
-	int n, err, i, ret = 0;
+	int n, err, ret = 0;
 
 	if(tty->stopped) return 0;
 
-	i = tty->index;
-	line = &lines[i];
-
 	down(&line->sem);
 	if(line->head != line->tail){
 		local_irq_save(flags);
-		ret += buffer_data(line, buf, len);
+		ret = buffer_data(line, buf, len);
 		err = flush_buffer(line);
 		local_irq_restore(flags);
 		if(err <= 0)
-			goto out_up;
+			ret = err;
 	}
 	else {
 		n = write_chan(&line->chan_list, buf, len, 
@@ -145,19 +149,92 @@ int line_write(struct line *lines, struc
 	return(ret);
 }
 
+void line_put_char(struct tty_struct *tty, unsigned char ch)
+{
+	line_write(tty, &ch, sizeof(ch));
+}
+
+void line_set_termios(struct tty_struct *tty, struct termios * old)
+{
+	/* nothing */
+}
+
+int line_chars_in_buffer(struct tty_struct *tty)
+{
+	return 0;
+}
+
+static struct {
+	int  cmd;
+	char *level;
+	char *name;
+} tty_ioctls[] = {
+	/* don't print these, they flood the log ... */
+	{ TCGETS,      NULL,       "TCGETS"      },
+        { TCSETS,      NULL,       "TCSETS"      },
+        { TCSETSW,     NULL,       "TCSETSW"     },
+        { TCFLSH,      NULL,       "TCFLSH"      },
+        { TCSBRK,      NULL,       "TCSBRK"      },
+
+	/* general tty stuff */
+        { TCSETSF,     KERN_DEBUG, "TCSETSF"     },
+        { TCGETA,      KERN_DEBUG, "TCGETA"      },
+        { TIOCMGET,    KERN_DEBUG, "TIOCMGET"    },
+        { TCSBRKP,     KERN_DEBUG, "TCSBRKP"     },
+        { TIOCMSET,    KERN_DEBUG, "TIOCMSET"    },
+
+	/* linux-specific ones */
+	{ TIOCLINUX,   KERN_INFO,  "TIOCLINUX"   },
+	{ KDGKBMODE,   KERN_INFO,  "KDGKBMODE"   },
+	{ KDGKBTYPE,   KERN_INFO,  "KDGKBTYPE"   },
+	{ KDSIGACCEPT, KERN_INFO,  "KDSIGACCEPT" },
+};
+
+int line_ioctl(struct tty_struct *tty, struct file * file,
+	       unsigned int cmd, unsigned long arg)
+{
+	int ret;
+	int i;
+
+	ret = 0;
+	switch(cmd) {
+#if 0
+	case TCwhatever:
+		/* do something */
+		break;
+#endif
+	default:
+		for (i = 0; i < ARRAY_SIZE(tty_ioctls); i++)
+			if (cmd == tty_ioctls[i].cmd)
+				break;
+		if (i < ARRAY_SIZE(tty_ioctls)) {
+			if (NULL != tty_ioctls[i].level)
+				printk("%s%s: %s: ioctl %s called\n",
+				       tty_ioctls[i].level, __FUNCTION__,
+				       tty->name, tty_ioctls[i].name);
+		} else {
+			printk(KERN_ERR "%s: %s: unknown ioctl: 0x%x\n",
+			       __FUNCTION__, tty->name, cmd);
+		}
+		ret = -ENOIOCTLCMD;
+		break;
+	}
+	return(ret);
+}
+
 static irqreturn_t line_write_interrupt(int irq, void *data,
 					struct pt_regs *unused)
 {
-	struct line *dev = data;
-	struct tty_struct *tty = dev->tty;
+	struct tty_struct *tty = data;
+	struct line *line = tty->driver_data;
 	int err;
 
-	err = flush_buffer(dev);
+	err = flush_buffer(line);
 	if(err == 0)
 		return(IRQ_NONE);
 	else if(err < 0){
-		dev->head = dev->buffer;
-		dev->tail = dev->buffer;
+		line->head = line->buffer;
+		line->tail = line->buffer;
 	}
 
 	if(tty == NULL)
@@ -178,39 +255,42 @@ static irqreturn_t line_write_interrupt(
 	return(IRQ_HANDLED);
 }
 
-int line_setup_irq(int fd, int input, int output, void *data)
+int line_setup_irq(int fd, int input, int output, struct tty_struct *tty)
 {
-	struct line *line = data;
+	struct line *line = tty->driver_data;
 	struct line_driver *driver = line->driver;
 	int err = 0, flags = SA_INTERRUPT | SA_SHIRQ | SA_SAMPLE_RANDOM;
 
 	if(input) err = um_request_irq(driver->read_irq, fd, IRQ_READ, 
 				       line_interrupt, flags, 
-				       driver->read_irq_name, line);
+				       driver->read_irq_name, tty);
 	if(err) return(err);
 	if(output) err = um_request_irq(driver->write_irq, fd, IRQ_WRITE, 
 					line_write_interrupt, flags, 
-					driver->write_irq_name, line);
+					driver->write_irq_name, tty);
 	line->have_irq = 1;
 	return(err);
 }
 
-void line_disable(struct line *line, int current_irq)
+void line_disable(struct tty_struct *tty, int current_irq)
 {
-	if(!line->have_irq) return;
+	struct line *line = tty->driver_data;
+
+	if(!line->have_irq)
+		return;
 
 	if(line->driver->read_irq == current_irq)
-		free_irq_later(line->driver->read_irq, line);
+		free_irq_later(line->driver->read_irq, tty);
 	else {
-		free_irq_by_irq_and_dev(line->driver->read_irq, line);
-		free_irq(line->driver->read_irq, line);
+		free_irq_by_irq_and_dev(line->driver->read_irq, tty);
+		free_irq(line->driver->read_irq, tty);
 	}
 
 	if(line->driver->write_irq == current_irq)
-		free_irq_later(line->driver->write_irq, line);
+		free_irq_later(line->driver->write_irq, tty);
 	else {
-		free_irq_by_irq_and_dev(line->driver->write_irq, line);
-		free_irq(line->driver->write_irq, line);
+		free_irq_by_irq_and_dev(line->driver->write_irq, tty);
+		free_irq(line->driver->write_irq, tty);
 	}
 
 	line->have_irq = 0;
@@ -220,73 +300,51 @@ int line_open(struct line *lines, struct
 	      struct chan_opts *opts)
 {
 	struct line *line;
-	int n, err = 0;
+	int err = 0;
 
-	if(tty == NULL) n = 0;
-	else n = tty->index;
-	line = &lines[n];
+	line = &lines[tty->index];
+	tty->driver_data = line;
 
 	down(&line->sem);
-	if(line->count == 0){
-		if(!line->valid){
+	if (tty->count == 1) {
+		if (!line->valid) {
 			err = -ENODEV;
 			goto out;
 		}
-		if(list_empty(&line->chan_list)){
+		if (list_empty(&line->chan_list)) {
 			err = parse_chan_pair(line->init_str, &line->chan_list,
-					      line->init_pri, n, opts);
+					      line->init_pri, tty->index, opts);
 			if(err) goto out;
 			err = open_chan(&line->chan_list);
 			if(err) goto out;
 		}
-		enable_chan(&line->chan_list, line);
-		INIT_WORK(&line->task, line_timer_cb, line);
+		enable_chan(&line->chan_list, tty);
+		INIT_WORK(&line->task, line_timer_cb, tty);
 	}
 
 	if(!line->sigio){
-		chan_enable_winch(&line->chan_list, line);
+		chan_enable_winch(&line->chan_list, tty);
 		line->sigio = 1;
 	}
-
-	/* This is outside the if because the initial console is opened
-	 * with tty == NULL
-	 */
-	line->tty = tty;
-
-	if(tty != NULL){
-		tty->driver_data = line;
-		chan_window_size(&line->chan_list, &tty->winsize.ws_row, 
-				 &tty->winsize.ws_col);
-	}
-
+	chan_window_size(&line->chan_list, &tty->winsize.ws_row, 
+			 &tty->winsize.ws_col);
 	line->count++;
- out:
+
+out:
 	up(&line->sem);
 	return(err);
 }
 
-void line_close(struct line *lines, struct tty_struct *tty)
+void line_close(struct tty_struct *tty, struct file * filp)
 {
-	struct line *line;
-	int n;
-
-	if(tty == NULL) n = 0;
-	else n = tty->index;
-	line = &lines[n];
+	struct line *line = tty->driver_data;
 
 	down(&line->sem);
 	line->count--;
-
-	/* I don't like this, but I can't think of anything better.  What's
-	 * going on is that the tty is in the process of being closed for
-	 * the last time.  Its count hasn't been dropped yet, so it's still
-	 * at 1.  This may happen when line->count != 0 because of the initial
-	 * console open (without a tty) bumping it up to 1.
-	 */
-	if((line->tty != NULL) && (line->tty->count == 1))
-		line->tty = NULL;
-	if(line->count == 0)
-		line_disable(line, -1);
+	if (tty->count == 1) {
+		line_disable(tty, -1);
+		tty->driver_data = NULL;
+	}
 	up(&line->sem);
 }
 
@@ -319,14 +377,15 @@ int line_setup(struct line *lines, int n
 		       n, num - 1);
 		return(0);
 	}
-	else if(n >= 0){
-		if(lines[n].count > 0){
+	else if (n >= 0){
+		if (lines[n].count > 0) {
 			printk("line_setup - device %d is open\n", n);
 			return(0);
 		}
-		if(lines[n].init_pri <= INIT_ONE){
+		if (lines[n].init_pri <= INIT_ONE){
 			lines[n].init_pri = INIT_ONE;
-			if(!strcmp(init, "none")) lines[n].valid = 0;
+			if (!strcmp(init, "none"))
+				lines[n].valid = 0;
 			else {
 				lines[n].init_str = init;
 				lines[n].valid = 1;
@@ -406,8 +465,15 @@ int line_remove(struct line *lines, int 
 int line_write_room(struct tty_struct *tty)
 {
 	struct line *dev = tty->driver_data;
+	int room;
 
-	return(write_room(dev));
+	if (tty->stopped)
+		return 0;
+	room = write_room(dev);
+	if (0 == room)
+		printk(KERN_DEBUG "%s: %s: no room left in buffer\n",
+		       __FUNCTION__,tty->name);
+	return room;
 }
 
 struct tty_driver *line_register_devfs(struct lines *set,
@@ -433,8 +499,12 @@ struct tty_driver *line_register_devfs(s
 	driver->init_termios = tty_std_termios;
 	tty_set_operations(driver, ops);
 
-	if (tty_register_driver(driver))
-		panic("line_register_devfs : Couldn't register driver\n");
+	if (tty_register_driver(driver)) {
+		printk("%s: can't register %s driver\n",
+		       __FUNCTION__,line_driver->name);
+		put_tty_driver(driver);
+		return NULL;
+	}
 
 	from = line_driver->symlink_from;
 	to = line_driver->symlink_to;
@@ -474,13 +544,14 @@ struct winch {
 	int fd;
 	int tty_fd;
 	int pid;
-	struct line *line;
+	struct tty_struct *tty;
 };
 
 irqreturn_t winch_interrupt(int irq, void *data, struct pt_regs *unused)
 {
 	struct winch *winch = data;
 	struct tty_struct *tty;
+	struct line *line;
 	int err;
 	char c;
 
@@ -497,9 +568,10 @@ irqreturn_t winch_interrupt(int irq, voi
 			goto out;
 		}
 	}
-	tty = winch->line->tty;
-	if(tty != NULL){
-		chan_window_size(&winch->line->chan_list, 
+	tty  = winch->tty;
+	line = tty->driver_data;
+	if (tty != NULL) {
+		chan_window_size(&line->chan_list, 
 				 &tty->winsize.ws_row, 
 				 &tty->winsize.ws_col);
 		kill_pg(tty->pgrp, SIGWINCH, 1);
@@ -513,13 +585,13 @@ irqreturn_t winch_interrupt(int irq, voi
 DECLARE_MUTEX(winch_handler_sem);
 LIST_HEAD(winch_handlers);
 
-void register_winch_irq(int fd, int tty_fd, int pid, void *line)
+void register_winch_irq(int fd, int tty_fd, int pid, struct tty_struct *tty)
 {
 	struct winch *winch;
 
 	down(&winch_handler_sem);
 	winch = kmalloc(sizeof(*winch), GFP_KERNEL);
-	if(winch == NULL){
+	if (winch == NULL) {
 		printk("register_winch_irq - kmalloc failed\n");
 		goto out;
 	}
@@ -527,7 +599,7 @@ void register_winch_irq(int fd, int tty_
 				   .fd  	= fd,
 				   .tty_fd 	= tty_fd,
 				   .pid  	= pid,
-				   .line 	= line });
+				   .tty 	= tty });
 	list_add(&winch->list, &winch_handlers);
 	if(um_request_irq(WINCH_IRQ, fd, IRQ_READ, winch_interrupt, 
 			  SA_INTERRUPT | SA_SHIRQ | SA_SAMPLE_RANDOM, 
@@ -552,7 +624,6 @@ static void winch_cleanup(void)
 			os_kill_process(winch->pid, 1);
 	}
 }
-
 __uml_exitcall(winch_cleanup);
 
 char *add_xterm_umid(char *base)
Index: linux-2004-11-23/arch/um/drivers/pty.c
===================================================================
--- linux-2004-11-23.orig/arch/um/drivers/pty.c	2004-11-24 12:54:20.394443817 +0100
+++ linux-2004-11-23/arch/um/drivers/pty.c	2004-11-24 18:15:00.033152632 +0100
@@ -58,7 +58,8 @@ int pts_open(int input, int output, int 
 	dev = ptsname(fd);
 	sprintf(data->dev_name, "%s", dev);
 	*dev_out = data->dev_name;
-	if(data->announce) (*data->announce)(dev, data->dev);
+	if (data->announce)
+		(*data->announce)(dev, data->dev);
 	return(fd);
 }
 
Index: linux-2004-11-23/arch/um/drivers/ssl.c
===================================================================
--- linux-2004-11-23.orig/arch/um/drivers/ssl.c	2004-11-24 12:52:40.460535410 +0100
+++ linux-2004-11-23/arch/um/drivers/ssl.c	2004-11-24 18:56:46.659413614 +0100
@@ -54,7 +54,7 @@ static int ssl_remove(char *str);
 
 static struct line_driver driver = {
 	.name 			= "UML serial line",
-	.device_name 		= "ttS",
+	.device_name 		= "ttyS",
 	.devfs_name 		= "tts/",
 	.major 			= TTY_MAJOR,
 	.minor_start 		= 64,
@@ -103,30 +103,10 @@ static int ssl_remove(char *str)
 
 int ssl_open(struct tty_struct *tty, struct file *filp)
 {
-	return(line_open(serial_lines, tty, &opts));
-}
-
-static void ssl_close(struct tty_struct *tty, struct file * filp)
-{
-	line_close(serial_lines, tty);
-}
-
-static int ssl_write(struct tty_struct * tty,
-		     const unsigned char *buf, int count)
-{
-	return(line_write(serial_lines, tty, buf, count));
-}
-
-static void ssl_put_char(struct tty_struct *tty, unsigned char ch)
-{
-	line_write(serial_lines, tty, &ch, sizeof(ch));
-}
-
-static void ssl_flush_chars(struct tty_struct *tty)
-{
-	return;
+	return line_open(serial_lines, tty, &opts);
 }
 
+#if 0
 static int ssl_chars_in_buffer(struct tty_struct *tty)
 {
 	return(0);
@@ -137,34 +117,6 @@ static void ssl_flush_buffer(struct tty_
 	return;
 }
 
-static int ssl_ioctl(struct tty_struct *tty, struct file * file,
-		     unsigned int cmd, unsigned long arg)
-{
-	int ret;
-
-	ret = 0;
-	switch(cmd){
-	case TCGETS:
-	case TCSETS:
-	case TCFLSH:
-	case TCSETSF:
-	case TCSETSW:
-	case TCGETA:
-	case TIOCMGET:
-	case TCSBRK:
-	case TCSBRKP:
-	case TIOCMSET:
-		ret = -ENOIOCTLCMD;
-		break;
-	default:
-		printk(KERN_ERR 
-		       "Unimplemented ioctl in ssl_ioctl : 0x%x\n", cmd);
-		ret = -ENOIOCTLCMD;
-		break;
-	}
-	return(ret);
-}
-
 static void ssl_throttle(struct tty_struct * tty)
 {
 	printk(KERN_ERR "Someone should implement ssl_throttle\n");
@@ -175,11 +127,6 @@ static void ssl_unthrottle(struct tty_st
 	printk(KERN_ERR "Someone should implement ssl_unthrottle\n");
 }
 
-static void ssl_set_termios(struct tty_struct *tty, 
-			    struct termios *old_termios)
-{
-}
-
 static void ssl_stop(struct tty_struct *tty)
 {
 	printk(KERN_ERR "Someone should implement ssl_stop\n");
@@ -193,23 +140,26 @@ static void ssl_start(struct tty_struct 
 void ssl_hangup(struct tty_struct *tty)
 {
 }
+#endif
 
 static struct tty_operations ssl_ops = {
 	.open 	 		= ssl_open,
-	.close 	 		= ssl_close,
-	.write 	 		= ssl_write,
-	.put_char 		= ssl_put_char,
+	.close 	 		= line_close,
+	.write 	 		= line_write,
+	.put_char 		= line_put_char,
+	.write_room		= line_write_room,
+	.chars_in_buffer 	= line_chars_in_buffer,
+	.set_termios 		= line_set_termios,
+	.ioctl 	 		= line_ioctl,
+#if 0
 	.flush_chars 		= ssl_flush_chars,
-	.chars_in_buffer 	= ssl_chars_in_buffer,
 	.flush_buffer 		= ssl_flush_buffer,
-	.ioctl 	 		= ssl_ioctl,
 	.throttle 		= ssl_throttle,
 	.unthrottle 		= ssl_unthrottle,
-	.set_termios 		= ssl_set_termios,
 	.stop 	 		= ssl_stop,
 	.start 	 		= ssl_start,
 	.hangup 	 	= ssl_hangup,
-	.write_room		= line_write_room,
+#endif
 };
 
 /* Changed by ssl_init and referenced by ssl_exit, which are both serialized
@@ -221,11 +171,10 @@ static void ssl_console_write(struct con
 			      unsigned len)
 {
 	struct line *line = &serial_lines[c->index];
-	if(ssl_init_done)
-		down(&line->sem);
+
+	down(&line->sem);
 	console_write_chan(&line->chan_list, string, len);
-	if(ssl_init_done)
-		up(&line->sem);
+	up(&line->sem);
 }
 
 static struct tty_driver *ssl_console_device(struct console *c, int *index)
@@ -236,16 +185,18 @@ static struct tty_driver *ssl_console_de
 
 static int ssl_console_setup(struct console *co, char *options)
 {
-	return(0);
+	struct line *line = &serial_lines[co->index];
+
+	return console_open_chan(line,co,&opts);
 }
 
 static struct console ssl_cons = {
-	name:		"ttyS",
-	write:		ssl_console_write,
-	device:		ssl_console_device,
-	setup:		ssl_console_setup,
-	flags:		CON_PRINTBUFFER,
-	index:		-1,
+	.name		= "ttyS",
+	.write		= ssl_console_write,
+	.device		= ssl_console_device,
+	.setup		= ssl_console_setup,
+	.flags		= CON_PRINTBUFFER,
+	.index		= -1,
 };
 
 int ssl_init(void)
@@ -254,22 +205,30 @@ int ssl_init(void)
 
 	printk(KERN_INFO "Initializing software serial port version %d\n", 
 	       ssl_version);
-
 	ssl_driver = line_register_devfs(&lines, &driver, &ssl_ops,
-		serial_lines, sizeof(serial_lines)/sizeof(serial_lines[0]));
+					 serial_lines, ARRAY_SIZE(serial_lines));
 
 	lines_init(serial_lines, sizeof(serial_lines)/sizeof(serial_lines[0]));
 
 	new_title = add_xterm_umid(opts.xterm_title);
-	if(new_title != NULL) opts.xterm_title = new_title;
+	if (new_title != NULL)
+		opts.xterm_title = new_title;
 
-	register_console(&ssl_cons);
 	ssl_init_done = 1;
+	register_console(&ssl_cons);
 	return(0);
 }
-
 late_initcall(ssl_init);
 
+static void ssl_exit(void)
+{
+	if (!ssl_init_done)
+		return;
+	close_lines(serial_lines, 
+		    sizeof(serial_lines)/sizeof(serial_lines[0]));
+}
+__uml_exitcall(ssl_exit);
+
 static int ssl_chan_setup(char *str)
 {
 	return(line_setup(serial_lines,
@@ -280,15 +239,6 @@ static int ssl_chan_setup(char *str)
 __setup("ssl", ssl_chan_setup);
 __channel_help(ssl_chan_setup, "ssl");
 
-static void ssl_exit(void)
-{
-	if(!ssl_init_done) return;
-	close_lines(serial_lines, 
-		    sizeof(serial_lines)/sizeof(serial_lines[0]));
-}
-
-__uml_exitcall(ssl_exit);
-
 /*
  * Overrides for Emacs so that we follow Linus's tabbing style.
  * Emacs will notice this stuff at the end of the file and automatically
Index: linux-2004-11-23/arch/um/drivers/stderr_console.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2004-11-23/arch/um/drivers/stderr_console.c	2004-11-24 18:15:00.037151983 +0100
@@ -0,0 +1,45 @@
+#include <linux/init.h>
+#include <linux/console.h>
+
+#include "chan_user.h"
+
+/* ----------------------------------------------------------------------------- */
+/* trivial console driver -- simply dump everything to stderr                    */
+
+/*
+ * Don't register by default -- as this registeres very early in the
+ * boot process it becomes the default console.  And as this isn't a
+ * real tty driver init isn't able to open /dev/console then.
+ *
+ * In most cases this isn't what you want ...
+ */
+static int use_stderr_console = 0;
+
+static void stderr_console_write(struct console *console, const char *string, 
+				 unsigned len)
+{
+	generic_write(2 /* stderr */, string, len, NULL);
+}
+
+static struct console stderr_console = {
+	.name		"stderr",
+	.write		stderr_console_write,
+	.flags		CON_PRINTBUFFER,
+};
+
+static int __init stderr_console_init(void)
+{
+	if (use_stderr_console)
+		register_console(&stderr_console);
+	return 0;
+}
+console_initcall(stderr_console_init);
+
+static int stderr_setup(char *str)
+{
+	if (!str)
+		return 0;
+	use_stderr_console = simple_strtoul(str,&str,0);
+	return 1;
+}
+__setup("stderr=", stderr_setup);
Index: linux-2004-11-23/arch/um/drivers/stdio_console.c
===================================================================
--- linux-2004-11-23.orig/arch/um/drivers/stdio_console.c	2004-11-24 18:14:59.421251899 +0100
+++ linux-2004-11-23/arch/um/drivers/stdio_console.c	2004-11-24 18:56:31.966798181 +0100
@@ -32,37 +32,14 @@
 
 #define MAX_TTYS (16)
 
+/* ----------------------------------------------------------------------------- */
+
 /* Referenced only by tty_driver below - presumably it's locked correctly
  * by the tty driver.
  */
 
 static struct tty_driver *console_driver;
 
-static struct chan_ops init_console_ops = {
-	.type		= "you shouldn't see this",
-	.init  		= NULL,
-	.open  		= NULL,
-	.close 		= NULL,
-	.read  		= NULL,
-	.write 		= NULL,
-	.console_write 	= generic_write,
-	.window_size 	= NULL,
-	.free  		= NULL,
-	.winch		= 0,
-};
-
-static struct chan init_console_chan = {
-	.list  		= { },
-	.primary 	= 1,
-	.input 		= 0,
-	.output 	= 1,
-	.opened 	= 1,
-	.fd 		= 1,
-	.pri 		= INIT_STATIC,
-	.ops 		= &init_console_ops,
-	.data 		= NULL
-};
-
 void stdio_announce(char *dev_name, int dev)
 {
 	printk(KERN_INFO "Virtual console %d assigned device '%s'\n", dev,
@@ -128,79 +105,31 @@ static int con_remove(char *str)
 	return(line_remove(vts, sizeof(vts)/sizeof(vts[0]), str));
 }
 
-static int open_console(struct tty_struct *tty)
-{
-	return(line_open(vts, tty, &opts));
-}
-
 static int con_open(struct tty_struct *tty, struct file *filp)
 {
-	return(open_console(tty));
-}
-
-static void con_close(struct tty_struct *tty, struct file *filp)
-{
-	line_close(vts, tty);
-}
-
-static int con_write(struct tty_struct *tty, 
-		     const unsigned char *buf, int count)
-{
-	 return(line_write(vts, tty, buf, count));
-}
-
-static void set_termios(struct tty_struct *tty, struct termios * old)
-{
-}
-
-static int chars_in_buffer(struct tty_struct *tty)
-{
-	return(0);
+	return line_open(vts, tty, &opts);
 }
 
 static int con_init_done = 0;
 
 static struct tty_operations console_ops = {
 	.open 	 		= con_open,
-	.close 	 		= con_close,
-	.write 	 		= con_write,
-	.chars_in_buffer 	= chars_in_buffer,
-	.set_termios 		= set_termios,
-	.write_room		= line_write_room,
+	.close 	 		= line_close,
+	.write 	 		= line_write,
+ 	.write_room		= line_write_room,
+	.chars_in_buffer 	= line_chars_in_buffer,
+	.set_termios 		= line_set_termios,
+	.ioctl 	 		= line_ioctl,
 };
 
-int stdio_init(void)
-{
-	char *new_title;
-
-	printk(KERN_INFO "Initializing stdio console driver\n");
-
-	console_driver = line_register_devfs(&console_lines, &driver,
-					     &console_ops, vts,
-					     sizeof(vts)/sizeof(vts[0]));
-
-	lines_init(vts, sizeof(vts)/sizeof(vts[0]));
-
-	new_title = add_xterm_umid(opts.xterm_title);
-	if(new_title != NULL) opts.xterm_title = new_title;
-
-	open_console(NULL);
-	con_init_done = 1;
-	return(0);
-}
-
-late_initcall(stdio_init);
-
 static void uml_console_write(struct console *console, const char *string,
 			  unsigned len)
 {
 	struct line *line = &vts[console->index];
 
-	if(con_init_done)
-		down(&line->sem);
+	down(&line->sem);
 	console_write_chan(&line->chan_list, string, len);
-	if(con_init_done)
-		up(&line->sem);
+	up(&line->sem);
 }
 
 static struct tty_driver *uml_console_device(struct console *c, int *index)
@@ -211,44 +140,59 @@ static struct tty_driver *uml_console_de
 
 static int uml_console_setup(struct console *co, char *options)
 {
-	return(0);
+	struct line *line = &vts[co->index];
+
+	return console_open_chan(line,co,&opts);
 }
 
 static struct console stdiocons = {
-	name:		"tty",
-	write:		uml_console_write,
-	device:		uml_console_device,
-	setup:		uml_console_setup,
-	flags:		CON_PRINTBUFFER,
-	index:		-1,
+	.name		= "tty",
+	.write		= uml_console_write,
+	.device		= uml_console_device,
+	.setup		= uml_console_setup,
+	.flags		= CON_PRINTBUFFER,
+	.index		= -1,
+	.data           = &vts,
 };
 
-static int __init stdio_console_init(void)
+int stdio_init(void)
 {
-	INIT_LIST_HEAD(&vts[0].chan_list);
-	list_add(&init_console_chan.list, &vts[0].chan_list);
+	char *new_title;
+
+	console_driver = line_register_devfs(&console_lines, &driver,
+					     &console_ops, vts,
+					     ARRAY_SIZE(vts));
+	if (NULL == console_driver)
+		return -1;
+	printk(KERN_INFO "Initialized stdio console driver\n");
+
+	lines_init(vts, sizeof(vts)/sizeof(vts[0]));
+
+	new_title = add_xterm_umid(opts.xterm_title);
+	if(new_title != NULL)
+		opts.xterm_title = new_title;
+
+	con_init_done = 1;
 	register_console(&stdiocons);
 	return(0);
 }
+late_initcall(stdio_init);
 
-console_initcall(stdio_console_init);
+static void console_exit(void)
+{
+	if (!con_init_done)
+		return;
+	close_lines(vts, sizeof(vts)/sizeof(vts[0]));
+}
+__uml_exitcall(console_exit);
 
 static int console_chan_setup(char *str)
 {
 	return(line_setup(vts, sizeof(vts)/sizeof(vts[0]), str, 1));
 }
-
 __setup("con", console_chan_setup);
 __channel_help(console_chan_setup, "con");
 
-static void console_exit(void)
-{
-	if(!con_init_done) return;
-	close_lines(vts, sizeof(vts)/sizeof(vts[0]));
-}
-
-__uml_exitcall(console_exit);
-
 /*
  * Overrides for Emacs so that we follow Linus's tabbing style.
  * Emacs will notice this stuff at the end of the file and automatically
Index: linux-2004-11-23/arch/um/drivers/xterm.c
===================================================================
--- linux-2004-11-23.orig/arch/um/drivers/xterm.c	2004-11-24 12:50:53.318779420 +0100
+++ linux-2004-11-23/arch/um/drivers/xterm.c	2004-11-24 18:15:00.041151334 +0100
@@ -126,9 +126,9 @@ int xterm_open(int input, int output, in
 
 	if(data->stack == 0) free_stack(stack, 0);
 
-	if(data->direct_rcv)
+	if (data->direct_rcv) {
 		new = os_rcv_fd(fd, &data->helper_pid);
-	else {
+	} else {
 		err = os_set_fd_block(fd, 0);
 		if(err < 0){
 			printk("xterm_open : failed to set descriptor "
Index: linux-2004-11-23/arch/um/include/chan_kern.h
===================================================================
--- linux-2004-11-23.orig/arch/um/include/chan_kern.h	2004-11-24 12:52:39.096754681 +0100
+++ linux-2004-11-23/arch/um/include/chan_kern.h	2004-11-24 18:15:00.042151172 +0100
@@ -8,7 +8,9 @@
 
 #include "linux/tty.h"
 #include "linux/list.h"
+#include "linux/console.h"
 #include "chan_user.h"
+#include "line.h"
 
 struct chan {
 	struct list_head list;
@@ -24,7 +26,7 @@ struct chan {
 };
 
 extern void chan_interrupt(struct list_head *chans, struct work_struct *task,
-			   struct tty_struct *tty, int irq, void *dev);
+			   struct tty_struct *tty, int irq);
 extern int parse_chan_pair(char *str, struct list_head *chans, int pri, 
 			   int device, struct chan_opts *opts);
 extern int open_chan(struct list_head *chans);
@@ -32,9 +34,11 @@ extern int write_chan(struct list_head *
 			     int write_irq);
 extern int console_write_chan(struct list_head *chans, const char *buf, 
 			      int len);
+extern int console_open_chan(struct line *line, struct console *co,
+			     struct chan_opts *opts);
 extern void close_chan(struct list_head *chans);
-extern void chan_enable_winch(struct list_head *chans, void *line);
-extern void enable_chan(struct list_head *chans, void *data);
+extern void chan_enable_winch(struct list_head *chans, struct tty_struct *tty);
+extern void enable_chan(struct list_head *chans, struct tty_struct *tty);
 extern int chan_window_size(struct list_head *chans, 
 			     unsigned short *rows_out, 
 			     unsigned short *cols_out);
Index: linux-2004-11-23/arch/um/include/chan_user.h
===================================================================
--- linux-2004-11-23.orig/arch/um/include/chan_user.h	2004-11-24 12:52:44.966810815 +0100
+++ linux-2004-11-23/arch/um/include/chan_user.h	2004-11-24 18:15:00.043151010 +0100
@@ -42,8 +42,9 @@ extern int generic_window_size(int fd, v
 			       unsigned short *cols_out);
 extern void generic_free(void *data);
 
-extern void register_winch(int fd, void *device_data);
-extern void register_winch_irq(int fd, int tty_fd, int pid, void *line);
+struct tty_struct;
+extern void register_winch(int fd,  struct tty_struct *tty);
+extern void register_winch_irq(int fd, int tty_fd, int pid, struct tty_struct *tty);
 
 #define __channel_help(fn, prefix) \
 __uml_help(fn, prefix "[0-9]*=<channel description>\n" \
Index: linux-2004-11-23/arch/um/include/line.h
===================================================================
--- linux-2004-11-23.orig/arch/um/include/line.h	2004-11-24 12:53:50.485264605 +0100
+++ linux-2004-11-23/arch/um/include/line.h	2004-11-24 18:15:00.045150685 +0100
@@ -37,7 +37,6 @@ struct line {
 	struct list_head chan_list;
 	int valid;
 	int count;
-	struct tty_struct *tty;
 	struct semaphore sem;
 	char *buffer;
 	char *head;
@@ -53,8 +52,6 @@ struct line {
 	  init_pri :	INIT_STATIC, \
 	  chan_list : 	{ }, \
 	  valid :	1, \
-	  count :	0, \
-	  tty :		NULL, \
 	  sem : 	{ }, \
 	  buffer :	NULL, \
 	  head :	NULL, \
@@ -69,17 +66,22 @@ struct lines {
 
 #define LINES_INIT(n) {  num :		n }
 
-extern void line_close(struct line *lines, struct tty_struct *tty);
+extern void line_close(struct tty_struct *tty, struct file * filp);
 extern int line_open(struct line *lines, struct tty_struct *tty, 
 		     struct chan_opts *opts);
 extern int line_setup(struct line *lines, int num, char *init, 
 		      int all_allowed);
-extern int line_write(struct line *line, struct tty_struct *tty, const char *buf, int len);
+extern int line_write(struct tty_struct *tty, const unsigned char *buf, int len);
+extern void line_put_char(struct tty_struct *tty, unsigned char ch);
+extern void line_set_termios(struct tty_struct *tty, struct termios * old);
+extern int line_chars_in_buffer(struct tty_struct *tty);
 extern int line_write_room(struct tty_struct *tty);
+extern int line_ioctl(struct tty_struct *tty, struct file * file,
+		      unsigned int cmd, unsigned long arg);
 extern char *add_xterm_umid(char *base);
-extern int line_setup_irq(int fd, int input, int output, void *data);
+extern int line_setup_irq(int fd, int input, int output, struct tty_struct *tty);
 extern void line_close_chan(struct line *line);
-extern void line_disable(struct line *line, int current_irq);
+extern void line_disable(struct tty_struct *tty, int current_irq);
 extern struct tty_driver * line_register_devfs(struct lines *set, 
 				struct line_driver *line_driver, 
 				struct tty_operations *driver,

-- 
#define printk(args...) fprintf(stderr, ## args)
