Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263824AbTDUMGW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Apr 2003 08:06:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263826AbTDUMGW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Apr 2003 08:06:22 -0400
Received: from angband.namesys.com ([212.16.7.85]:23945 "HELO
	angband.namesys.com") by vger.kernel.org with SMTP id S263824AbTDUMGP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Apr 2003 08:06:15 -0400
Date: Mon, 21 Apr 2003 16:18:12 +0400
From: Oleg Drokin <green@namesys.com>
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net,
       jdike@karaya.com
Subject: Re: updates for the new IRQ API
Message-ID: <20030421161812.A6936@namesys.com>
References: <20030421042934.3728740d.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030421042934.3728740d.akpm@digeo.com>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Mon, Apr 21, 2003 at 04:29:34AM -0700, Andrew Morton wrote:

> A change was made today to the kernel's IRQ handlers.  See
> http://sourceforge.net/mailarchive/forum.php?thread_id=1999147&forum_id=2314
> for details.

Here is UML's part.
I tried it and stuff compiles and works for me. (btw, do anyone aware that
kernel/posix-timers.c can no longer be comiled with gcc 2.95, as it complains about
unknown insns?
kernel/posix-timers.c:1252: internal error--unrecognizable insn:
(insn/i 547 546 746 (parallel[
...
)

Bye,
    Oleg

===== arch/um/drivers/line.c 1.13 vs edited =====
--- 1.13/arch/um/drivers/line.c	Sat Mar 22 18:37:12 2003
+++ edited/arch/um/drivers/line.c	Mon Apr 21 16:08:47 2003
@@ -6,8 +6,8 @@
 #include "linux/sched.h"
 #include "linux/slab.h"
 #include "linux/list.h"
+#include "linux/interrupt.h"
 #include "linux/devfs_fs_kernel.h"
-#include "asm/irq.h"
 #include "asm/uaccess.h"
 #include "chan_kern.h"
 #include "irq_user.h"
@@ -19,13 +19,14 @@
 
 #define LINE_BUFSIZE 4096
 
-void line_interrupt(int irq, void *data, struct pt_regs *unused)
+irqreturn_t line_interrupt(int irq, void *data, struct pt_regs *unused)
 {
 	struct line *dev = data;
 
 	if(dev->count > 0) 
 		chan_interrupt(&dev->chan_list, &dev->task, dev->tty, irq, 
 			       dev);
+	return IRQ_HANDLED;
 }
 
 void line_timer_cb(void *arg)
@@ -136,20 +137,20 @@
 	return(len);
 }
 
-void line_write_interrupt(int irq, void *data, struct pt_regs *unused)
+irqreturn_t line_write_interrupt(int irq, void *data, struct pt_regs *unused)
 {
 	struct line *dev = data;
 	struct tty_struct *tty = dev->tty;
 	int err;
 
 	err = flush_buffer(dev);
-	if(err == 0) return;
+	if(err == 0) return IRQ_NONE;
 	else if(err < 0){
 		dev->head = dev->buffer;
 		dev->tail = dev->buffer;
 	}
 
-	if(tty == NULL) return;
+	if(tty == NULL) return IRQ_NONE;
 
 	if(test_bit(TTY_DO_WRITE_WAKEUP, &tty->flags) &&
 	   (tty->ldisc.write_wakeup != NULL))
@@ -164,6 +165,7 @@
 	if (waitqueue_active(&tty->write_wait))
 		wake_up_interruptible(&tty->write_wait);
 
+	return IRQ_HANDLED;
 }
 
 int line_write_room(struct tty_struct *tty)
@@ -476,7 +478,7 @@
 	struct line *line;
 };
 
-void winch_interrupt(int irq, void *data, struct pt_regs *unused)
+irqreturn_t winch_interrupt(int irq, void *data, struct pt_regs *unused)
 {
 	struct winch *winch = data;
 	struct tty_struct *tty;
@@ -491,7 +493,7 @@
 			printk("fd %d is losing SIGWINCH support\n", 
 			       winch->tty_fd);
 			free_irq(irq, data);
-			return;
+			return IRQ_HANDLED;
 		}
 		goto out;
 	}
@@ -504,6 +506,7 @@
 	}
  out:
 	reactivate_fd(winch->fd, WINCH_IRQ);
+	return IRQ_HANDLED;
 }
 
 DECLARE_MUTEX(winch_handler_sem);
===== arch/um/drivers/mconsole_kern.c 1.6 vs edited =====
--- 1.6/arch/um/drivers/mconsole_kern.c	Sat Dec 28 23:28:00 2002
+++ edited/arch/um/drivers/mconsole_kern.c	Mon Apr 21 16:08:47 2003
@@ -67,7 +67,7 @@
 
 DECLARE_WORK(mconsole_work, mc_work_proc, NULL);
 
-void mconsole_interrupt(int irq, void *dev_id, struct pt_regs *regs)
+irqreturn_t mconsole_interrupt(int irq, void *dev_id, struct pt_regs *regs)
 {
 	int fd;
 	struct mconsole_entry *new;
@@ -88,6 +88,7 @@
 	}
 	if(!list_empty(&mc_requests)) schedule_work(&mconsole_work);
 	reactivate_fd(fd, MCONSOLE_IRQ);
+	return IRQ_HANDLED;
 }
 
 void mconsole_version(struct mc_request *req)
===== arch/um/drivers/net_kern.c 1.9 vs edited =====
--- 1.9/arch/um/drivers/net_kern.c	Sat Dec 28 23:28:00 2002
+++ edited/arch/um/drivers/net_kern.c	Mon Apr 21 16:08:48 2003
@@ -61,14 +61,14 @@
 	return pkt_len;
 }
 
-void uml_net_interrupt(int irq, void *dev_id, struct pt_regs *regs)
+irqreturn_t uml_net_interrupt(int irq, void *dev_id, struct pt_regs *regs)
 {
 	struct net_device *dev = dev_id;
 	struct uml_net_private *lp = dev->priv;
 	int err;
 
 	if(!netif_running(dev))
-		return;
+		return IRQ_NONE;
 
 	spin_lock(&lp->lock);
 	while((err = uml_net_rx(dev)) > 0) ;
@@ -83,6 +83,7 @@
 
  out:
 	spin_unlock(&lp->lock);
+	return IRQ_HANDLED;
 }
 
 static int uml_net_open(struct net_device *dev)
===== arch/um/drivers/port_kern.c 1.15 vs edited =====
--- 1.15/arch/um/drivers/port_kern.c	Thu Feb  6 07:16:01 2003
+++ edited/arch/um/drivers/port_kern.c	Mon Apr 21 16:08:49 2003
@@ -6,6 +6,7 @@
 #include "linux/list.h"
 #include "linux/sched.h"
 #include "linux/slab.h"
+#include "linux/interrupt.h"
 #include "linux/irq.h"
 #include "linux/spinlock.h"
 #include "linux/errno.h"
@@ -44,7 +45,7 @@
 	struct port_list *port;
 };
 
-static void pipe_interrupt(int irq, void *data, struct pt_regs *regs)
+static irqreturn_t pipe_interrupt(int irq, void *data, struct pt_regs *regs)
 {
 	struct connection *conn = data;
 	int fd;
@@ -52,7 +53,7 @@
  	fd = os_rcv_fd(conn->socket[0], &conn->helper_pid);
 	if(fd < 0){
 		if(fd == -EAGAIN)
-			return;
+			return IRQ_NONE;
 
 		printk(KERN_ERR "pipe_interrupt : os_rcv_fd returned %d\n", 
 		       -fd);
@@ -65,6 +66,7 @@
 	list_add(&conn->list, &conn->port->connections);
 
 	up(&conn->port->sem);
+	return IRQ_HANDLED;
 }
 
 static int port_accept(struct port_list *port)
@@ -138,12 +140,13 @@
 
 DECLARE_WORK(port_work, port_work_proc, NULL);
 
-static void port_interrupt(int irq, void *data, struct pt_regs *regs)
+static irqreturn_t port_interrupt(int irq, void *data, struct pt_regs *regs)
 {
 	struct port_list *port = data;
 
 	port->has_connection = 1;
 	schedule_work(&port_work);
+	return IRQ_HANDLED;
 } 
 
 void *port_data(int port_num)
===== arch/um/drivers/ubd_kern.c 1.32 vs edited =====
--- 1.32/arch/um/drivers/ubd_kern.c	Sun Apr 20 01:17:05 2003
+++ edited/arch/um/drivers/ubd_kern.c	Mon Apr 21 16:08:49 2003
@@ -18,6 +18,7 @@
 #include "linux/blk.h"
 #include "linux/blkdev.h"
 #include "linux/hdreg.h"
+#include "linux/interrupt.h"
 #include "linux/init.h"
 #include "linux/devfs_fs_kernel.h"
 #include "linux/cdrom.h"
@@ -395,9 +396,10 @@
 	do_ubd_request(&ubd_queue);
 }
 
-static void ubd_intr(int irq, void *dev, struct pt_regs *unused)
+static irqreturn_t ubd_intr(int irq, void *dev, struct pt_regs *unused)
 {
 	ubd_handler();
+	return IRQ_HANDLED;
 }
 
 /* Only changed by ubd_init, which is an initcall. */
===== arch/um/drivers/xterm_kern.c 1.4 vs edited =====
--- 1.4/arch/um/drivers/xterm_kern.c	Sat Dec 28 23:28:00 2002
+++ edited/arch/um/drivers/xterm_kern.c	Mon Apr 21 16:09:34 2003
@@ -6,7 +6,7 @@
 #include "linux/errno.h"
 #include "linux/slab.h"
 #include "asm/semaphore.h"
-#include "asm/irq.h"
+#include "linux/interrupt.h"
 #include "irq_user.h"
 #include "kern_util.h"
 #include "os.h"
@@ -19,17 +19,18 @@
 	int new_fd;
 };
 
-static void xterm_interrupt(int irq, void *data, struct pt_regs *regs)
+static irqreturn_t xterm_interrupt(int irq, void *data, struct pt_regs *regs)
 {
 	struct xterm_wait *xterm = data;
 	int fd;
 
 	fd = os_rcv_fd(xterm->fd, &xterm->pid);
 	if(fd == -EAGAIN)
-		return;
+		return IRQ_NONE;
 
 	xterm->new_fd = fd;
 	up(&xterm->sem);
+	return IRQ_HANDLED;
 }
 
 int xterm_fd(int socket, int *pid_out)
===== arch/um/include/line.h 1.5 vs edited =====
--- 1.5/arch/um/include/line.h	Fri Nov 22 01:16:19 2002
+++ edited/arch/um/include/line.h	Mon Apr 21 16:08:53 2003
@@ -9,6 +9,7 @@
 #include "linux/list.h"
 #include "linux/workqueue.h"
 #include "linux/tty.h"
+#include "linux/interrupt.h"
 #include "asm/semaphore.h"
 #include "chan_user.h"
 #include "mconsole_kern.h"
@@ -67,8 +68,8 @@
 
 #define LINES_INIT(n) {  num :		n }
 
-extern void line_interrupt(int irq, void *data, struct pt_regs *unused);
-extern void line_write_interrupt(int irq, void *data, struct pt_regs *unused);
+extern irqreturn_t line_interrupt(int irq, void *data, struct pt_regs *unused);
+extern irqreturn_t line_write_interrupt(int irq, void *data, struct pt_regs *unused);
 extern void line_close(struct line *lines, struct tty_struct *tty);
 extern int line_open(struct line *lines, struct tty_struct *tty, 
 		     struct chan_opts *opts);
===== arch/um/kernel/irq.c 1.7 vs edited =====
--- 1.7/arch/um/kernel/irq.c	Tue Feb 25 12:38:50 2003
+++ edited/arch/um/kernel/irq.c	Mon Apr 21 16:08:53 2003
@@ -380,7 +380,7 @@
  */
  
 int request_irq(unsigned int irq,
-		void (*handler)(int, void *, struct pt_regs *),
+		irqreturn_t (*handler)(int, void *, struct pt_regs *),
 		unsigned long irqflags, 
 		const char * devname,
 		void *dev_id)
@@ -426,7 +426,7 @@
 }
 
 int um_request_irq(unsigned int irq, int fd, int type,
-		   void (*handler)(int, void *, struct pt_regs *),
+		   irqreturn_t (*handler)(int, void *, struct pt_regs *),
 		   unsigned long irqflags, const char * devname,
 		   void *dev_id)
 {
===== arch/um/kernel/sigio_kern.c 1.2 vs edited =====
--- 1.2/arch/um/kernel/sigio_kern.c	Mon Oct 14 17:53:49 2002
+++ edited/arch/um/kernel/sigio_kern.c	Mon Apr 21 16:10:26 2003
@@ -6,7 +6,8 @@
 #include "linux/kernel.h"
 #include "linux/list.h"
 #include "linux/slab.h"
-#include "asm/irq.h"
+#include "linux/signal.h"
+#include "linux/interrupt.h"
 #include "init.h"
 #include "sigio.h"
 #include "irq_user.h"
@@ -14,10 +15,11 @@
 /* Protected by sigio_lock() called from write_sigio_workaround */
 static int sigio_irq_fd = -1;
 
-void sigio_interrupt(int irq, void *data, struct pt_regs *unused)
+irqreturn_t sigio_interrupt(int irq, void *data, struct pt_regs *unused)
 {
 	read_sigio_fd(sigio_irq_fd);
 	reactivate_fd(sigio_irq_fd, SIGIO_WRITE_IRQ);
+	return IRQ_HANDLED;
 }
 
 int write_sigio_irq(int fd)
===== arch/um/kernel/time_kern.c 1.8 vs edited =====
--- 1.8/arch/um/kernel/time_kern.c	Thu Feb  6 07:16:02 2003
+++ edited/arch/um/kernel/time_kern.c	Mon Apr 21 16:09:03 2003
@@ -55,12 +55,13 @@
 	do_timer(&regs);
 }
 
-void um_timer(int irq, void *dev, struct pt_regs *regs)
+irqreturn_t um_timer(int irq, void *dev, struct pt_regs *regs)
 {
 	do_timer(regs);
 	write_seqlock(&xtime_lock);
 	timer();
 	write_sequnlock(&xtime_lock);
+	return IRQ_HANDLED;
 }
 
 long um_time(int * tloc)
===== include/asm-um/irq.h 1.3 vs edited =====
--- 1.3/include/asm-um/irq.h	Wed Oct 16 21:39:47 2002
+++ edited/include/asm-um/irq.h	Mon Apr 21 16:09:04 2003
@@ -6,6 +6,8 @@
  */
 struct task_struct;
 
+struct irqreturn;
+
 #include "asm/ptrace.h"
 
 #undef NR_IRQS
@@ -29,7 +31,7 @@
 #define NR_IRQS (LAST_IRQ + 1)
 
 extern int um_request_irq(unsigned int irq, int fd, int type,
-			  void (*handler)(int, void *, struct pt_regs *),
+			  struct irqreturn (*handler)(int, void *, struct pt_regs *),
 			  unsigned long irqflags,  const char * devname,
 			  void *dev_id);
 #endif
