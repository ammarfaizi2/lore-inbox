Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751907AbWGAO56@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751907AbWGAO56 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Jul 2006 10:57:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751392AbWGAO54
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Jul 2006 10:57:56 -0400
Received: from www.osadl.org ([213.239.205.134]:44708 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S1751878AbWGAO5P (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Jul 2006 10:57:15 -0400
Message-Id: <20060701145225.762011000@cruncher.tec.linutronix.de>
References: <20060701145211.856500000@cruncher.tec.linutronix.de>
Date: Sat, 01 Jul 2006 14:54:45 -0000
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       David Miller <davem@davemloft.net>, jdike@karaya.com
Subject: [RFC][patch 22/44] UM: Use the new IRQF_ constansts
Content-Disposition: inline; filename=irqflags-um.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Use the new IRQF_ constants and remove the SA_INTERRUPT define

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
 arch/um/drivers/line.c          |    6 +++---
 arch/um/drivers/mconsole_kern.c |    2 +-
 arch/um/drivers/net_kern.c      |    2 +-
 arch/um/drivers/port_kern.c     |    4 ++--
 arch/um/drivers/ubd_kern.c      |    2 +-
 arch/um/drivers/xterm_kern.c    |    2 +-
 arch/um/kernel/irq.c            |    2 +-
 arch/um/kernel/sigio_kern.c     |    2 +-
 arch/um/kernel/time_kern.c      |    2 +-
 9 files changed, 12 insertions(+), 12 deletions(-)

Index: linux-2.6.git/arch/um/drivers/line.c
===================================================================
--- linux-2.6.git.orig/arch/um/drivers/line.c	2006-07-01 16:51:21.000000000 +0200
+++ linux-2.6.git/arch/um/drivers/line.c	2006-07-01 16:51:38.000000000 +0200
@@ -373,7 +373,7 @@ static irqreturn_t line_write_interrupt(
 	int err;
 
 	/* Interrupts are enabled here because we registered the interrupt with
-	 * SA_INTERRUPT (see line_setup_irq).*/
+	 * IRQF_DISABLED (see line_setup_irq).*/
 
 	spin_lock_irq(&line->lock);
 	err = flush_buffer(line);
@@ -406,7 +406,7 @@ static irqreturn_t line_write_interrupt(
 int line_setup_irq(int fd, int input, int output, struct line *line, void *data)
 {
 	struct line_driver *driver = line->driver;
-	int err = 0, flags = SA_INTERRUPT | SA_SHIRQ | SA_SAMPLE_RANDOM;
+	int err = 0, flags = IRQF_DISABLED | IRQF_SHARED | IRQF_SAMPLE_RANDOM;
 
 	if (input)
 		err = um_request_irq(driver->read_irq, fd, IRQ_READ,
@@ -767,7 +767,7 @@ void register_winch_irq(int fd, int tty_
 	spin_unlock(&winch_handler_lock);
 
 	if(um_request_irq(WINCH_IRQ, fd, IRQ_READ, winch_interrupt,
-			  SA_INTERRUPT | SA_SHIRQ | SA_SAMPLE_RANDOM,
+			  IRQF_DISABLED | IRQF_SHARED | IRQF_SAMPLE_RANDOM,
 			  "winch", winch) < 0)
 		printk("register_winch_irq - failed to register IRQ\n");
 }
Index: linux-2.6.git/arch/um/drivers/mconsole_kern.c
===================================================================
--- linux-2.6.git.orig/arch/um/drivers/mconsole_kern.c	2006-07-01 16:51:21.000000000 +0200
+++ linux-2.6.git/arch/um/drivers/mconsole_kern.c	2006-07-01 16:51:38.000000000 +0200
@@ -777,7 +777,7 @@ static int mconsole_init(void)
 	register_reboot_notifier(&reboot_notifier);
 
 	err = um_request_irq(MCONSOLE_IRQ, sock, IRQ_READ, mconsole_interrupt,
-			     SA_INTERRUPT | SA_SHIRQ | SA_SAMPLE_RANDOM,
+			     IRQF_DISABLED | IRQF_SHARED | IRQF_SAMPLE_RANDOM,
 			     "mconsole", (void *)sock);
 	if (err){
 		printk("Failed to get IRQ for management console\n");
Index: linux-2.6.git/arch/um/drivers/net_kern.c
===================================================================
--- linux-2.6.git.orig/arch/um/drivers/net_kern.c	2006-07-01 16:51:21.000000000 +0200
+++ linux-2.6.git/arch/um/drivers/net_kern.c	2006-07-01 16:51:38.000000000 +0200
@@ -128,7 +128,7 @@ static int uml_net_open(struct net_devic
 	}
 
 	err = um_request_irq(dev->irq, lp->fd, IRQ_READ, uml_net_interrupt,
-			     SA_INTERRUPT | SA_SHIRQ, dev->name, dev);
+			     IRQF_DISABLED | IRQF_SHARED, dev->name, dev);
 	if(err != 0){
 		printk(KERN_ERR "uml_net_open: failed to get irq(%d)\n", err);
 		err = -ENETUNREACH;
Index: linux-2.6.git/arch/um/drivers/port_kern.c
===================================================================
--- linux-2.6.git.orig/arch/um/drivers/port_kern.c	2006-07-01 16:51:21.000000000 +0200
+++ linux-2.6.git/arch/um/drivers/port_kern.c	2006-07-01 16:51:38.000000000 +0200
@@ -105,7 +105,7 @@ static int port_accept(struct port_list 
 		  .port 	= port });
 
 	if(um_request_irq(TELNETD_IRQ, socket[0], IRQ_READ, pipe_interrupt, 
-			  SA_INTERRUPT | SA_SHIRQ | SA_SAMPLE_RANDOM, 
+			  IRQF_DISABLED | IRQF_SHARED | IRQF_SAMPLE_RANDOM, 
 			  "telnetd", conn)){
 		printk(KERN_ERR "port_accept : failed to get IRQ for "
 		       "telnetd\n");
@@ -186,7 +186,7 @@ void *port_data(int port_num)
 		goto out_free;
 	}
 	if(um_request_irq(ACCEPT_IRQ, fd, IRQ_READ, port_interrupt, 
-			  SA_INTERRUPT | SA_SHIRQ | SA_SAMPLE_RANDOM, "port",
+			  IRQF_DISABLED | IRQF_SHARED | IRQF_SAMPLE_RANDOM, "port",
 			  port)){
 		printk(KERN_ERR "Failed to get IRQ for port %d\n", port_num);
 		goto out_close;
Index: linux-2.6.git/arch/um/drivers/ubd_kern.c
===================================================================
--- linux-2.6.git.orig/arch/um/drivers/ubd_kern.c	2006-07-01 16:51:21.000000000 +0200
+++ linux-2.6.git/arch/um/drivers/ubd_kern.c	2006-07-01 16:51:38.000000000 +0200
@@ -874,7 +874,7 @@ int ubd_driver_init(void){
 		return(0);
 	}
 	err = um_request_irq(UBD_IRQ, thread_fd, IRQ_READ, ubd_intr,
-			     SA_INTERRUPT, "ubd", ubd_dev);
+			     IRQF_DISABLED, "ubd", ubd_dev);
 	if(err != 0)
 		printk(KERN_ERR "um_request_irq failed - errno = %d\n", -err);
 	return 0;
Index: linux-2.6.git/arch/um/drivers/xterm_kern.c
===================================================================
--- linux-2.6.git.orig/arch/um/drivers/xterm_kern.c	2006-07-01 16:51:21.000000000 +0200
+++ linux-2.6.git/arch/um/drivers/xterm_kern.c	2006-07-01 16:51:38.000000000 +0200
@@ -54,7 +54,7 @@ int xterm_fd(int socket, int *pid_out)
 	init_completion(&data->ready);
 
 	err = um_request_irq(XTERM_IRQ, socket, IRQ_READ, xterm_interrupt, 
-			     SA_INTERRUPT | SA_SHIRQ | SA_SAMPLE_RANDOM, 
+			     IRQF_DISABLED | IRQF_SHARED | IRQF_SAMPLE_RANDOM, 
 			     "xterm", data);
 	if (err){
 		printk(KERN_ERR "xterm_fd : failed to get IRQ for xterm, "
Index: linux-2.6.git/arch/um/kernel/irq.c
===================================================================
--- linux-2.6.git.orig/arch/um/kernel/irq.c	2006-07-01 16:51:21.000000000 +0200
+++ linux-2.6.git/arch/um/kernel/irq.c	2006-07-01 16:51:38.000000000 +0200
@@ -474,7 +474,7 @@ int init_aio_irq(int irq, char *name, ir
 	}
 
 	err = um_request_irq(irq, fds[0], IRQ_READ, handler,
-			     SA_INTERRUPT | SA_SAMPLE_RANDOM, name,
+			     IRQF_DISABLED | IRQF_SAMPLE_RANDOM, name,
 			     (void *) (long) fds[0]);
 	if (err) {
 		printk("init_aio_irq - : um_request_irq failed, err = %d\n",
Index: linux-2.6.git/arch/um/kernel/sigio_kern.c
===================================================================
--- linux-2.6.git.orig/arch/um/kernel/sigio_kern.c	2006-07-01 16:51:21.000000000 +0200
+++ linux-2.6.git/arch/um/kernel/sigio_kern.c	2006-07-01 16:51:38.000000000 +0200
@@ -31,7 +31,7 @@ int write_sigio_irq(int fd)
 	int err;
 
 	err = um_request_irq(SIGIO_WRITE_IRQ, fd, IRQ_READ, sigio_interrupt,
-			     SA_INTERRUPT | SA_SAMPLE_RANDOM, "write sigio",
+			     IRQF_DISABLED | IRQF_SAMPLE_RANDOM, "write sigio",
 			     NULL);
 	if(err){
 		printk("write_sigio_irq : um_request_irq failed, err = %d\n",
Index: linux-2.6.git/arch/um/kernel/time_kern.c
===================================================================
--- linux-2.6.git.orig/arch/um/kernel/time_kern.c	2006-07-01 16:51:21.000000000 +0200
+++ linux-2.6.git/arch/um/kernel/time_kern.c	2006-07-01 16:51:38.000000000 +0200
@@ -195,7 +195,7 @@ int __init timer_init(void)
 	int err;
 
 	user_time_init();
-	err = request_irq(TIMER_IRQ, um_timer, SA_INTERRUPT, "timer", NULL);
+	err = request_irq(TIMER_IRQ, um_timer, IRQF_DISABLED, "timer", NULL);
 	if(err != 0)
 		printk(KERN_ERR "timer_init : request_irq failed - "
 		       "errno = %d\n", -err);

--

