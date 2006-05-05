Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751170AbWEERJ3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751170AbWEERJ3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 May 2006 13:09:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751174AbWEERJ3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 May 2006 13:09:29 -0400
Received: from CPE-70-92-180-7.mn.res.rr.com ([70.92.180.7]:18126 "EHLO
	cinder.waste.org") by vger.kernel.org with ESMTP id S1751170AbWEERJ2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 May 2006 13:09:28 -0400
From: Matt Mackall <mpm@selenic.com>
To: Andrew Morton <akpm@osdl.org>
X-PatchBomber: http://selenic.com/scripts/mailpatches
Cc: linux-kernel@vger.kernel.org, jdike@karaya.com
In-Reply-To: <2.420169009@selenic.com>
Message-Id: <12.420169009@selenic.com>
Subject: [PATCH 11/14] random: Remove UML usage of SA_SAMPLE_RANDOM
Date: Fri, 05 May 2006 11:42:35 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove UML usage of SA_SAMPLE_RANDOM

UML can't know that its input sources are unpredictable or
unobservable and should not assume or pretend that they are. It should
instead gather entropy from the host's /dev/random.

Signed-off-by: Matt Mackall <mpm@selenic.com>

Index: 2.6/arch/um/drivers/line.c
===================================================================
--- 2.6.orig/arch/um/drivers/line.c	2006-05-02 17:29:26.000000000 -0500
+++ 2.6/arch/um/drivers/line.c	2006-05-03 13:54:29.000000000 -0500
@@ -406,7 +406,7 @@ static irqreturn_t line_write_interrupt(
 int line_setup_irq(int fd, int input, int output, struct line *line, void *data)
 {
 	struct line_driver *driver = line->driver;
-	int err = 0, flags = SA_INTERRUPT | SA_SHIRQ | SA_SAMPLE_RANDOM;
+	int err = 0, flags = SA_INTERRUPT | SA_SHIRQ;
 
 	if (input)
 		err = um_request_irq(driver->read_irq, fd, IRQ_READ,
@@ -767,8 +767,7 @@ void register_winch_irq(int fd, int tty_
 	spin_unlock(&winch_handler_lock);
 
 	if(um_request_irq(WINCH_IRQ, fd, IRQ_READ, winch_interrupt,
-			  SA_INTERRUPT | SA_SHIRQ | SA_SAMPLE_RANDOM,
-			  "winch", winch) < 0)
+			  SA_INTERRUPT | SA_SHIRQ, "winch", winch) < 0)
 		printk("register_winch_irq - failed to register IRQ\n");
 }
 
Index: 2.6/arch/um/drivers/mconsole_kern.c
===================================================================
--- 2.6.orig/arch/um/drivers/mconsole_kern.c	2006-05-02 17:28:42.000000000 -0500
+++ 2.6/arch/um/drivers/mconsole_kern.c	2006-05-03 13:52:05.000000000 -0500
@@ -779,8 +779,7 @@ static int mconsole_init(void)
 	register_reboot_notifier(&reboot_notifier);
 
 	err = um_request_irq(MCONSOLE_IRQ, sock, IRQ_READ, mconsole_interrupt,
-			     SA_INTERRUPT | SA_SHIRQ | SA_SAMPLE_RANDOM,
-			     "mconsole", (void *)sock);
+			     SA_INTERRUPT | SA_SHIRQ, "mconsole", sock);
 	if (err){
 		printk("Failed to get IRQ for management console\n");
 		return(1);
Index: 2.6/arch/um/drivers/port_kern.c
===================================================================
--- 2.6.orig/arch/um/drivers/port_kern.c	2005-10-27 19:02:08.000000000 -0500
+++ 2.6/arch/um/drivers/port_kern.c	2006-05-03 13:45:53.000000000 -0500
@@ -104,9 +104,8 @@ static int port_accept(struct port_list 
 		  .telnetd_pid 	= pid,
 		  .port 	= port });
 
-	if(um_request_irq(TELNETD_IRQ, socket[0], IRQ_READ, pipe_interrupt, 
-			  SA_INTERRUPT | SA_SHIRQ | SA_SAMPLE_RANDOM, 
-			  "telnetd", conn)){
+	if(um_request_irq(TELNETD_IRQ, socket[0], IRQ_READ, pipe_interrupt,
+			  SA_INTERRUPT | SA_SHIRQ, "telnetd", conn)){
 		printk(KERN_ERR "port_accept : failed to get IRQ for "
 		       "telnetd\n");
 		goto out_free;
@@ -185,9 +184,8 @@ void *port_data(int port_num)
 		       port_num, -fd);
 		goto out_free;
 	}
-	if(um_request_irq(ACCEPT_IRQ, fd, IRQ_READ, port_interrupt, 
-			  SA_INTERRUPT | SA_SHIRQ | SA_SAMPLE_RANDOM, "port",
-			  port)){
+	if(um_request_irq(ACCEPT_IRQ, fd, IRQ_READ, port_interrupt,
+			  SA_INTERRUPT | SA_SHIRQ, "port", port)){
 		printk(KERN_ERR "Failed to get IRQ for port %d\n", port_num);
 		goto out_close;
 	}
Index: 2.6/arch/um/drivers/xterm_kern.c
===================================================================
--- 2.6.orig/arch/um/drivers/xterm_kern.c	2005-10-27 19:02:08.000000000 -0500
+++ 2.6/arch/um/drivers/xterm_kern.c	2006-05-03 13:38:32.000000000 -0500
@@ -53,9 +53,8 @@ int xterm_fd(int socket, int *pid_out)
 		  .new_fd 	= -1 });
 	init_completion(&data->ready);
 
-	err = um_request_irq(XTERM_IRQ, socket, IRQ_READ, xterm_interrupt, 
-			     SA_INTERRUPT | SA_SHIRQ | SA_SAMPLE_RANDOM, 
-			     "xterm", data);
+	err = um_request_irq(XTERM_IRQ, socket, IRQ_READ, xterm_interrupt,
+			     SA_INTERRUPT | SA_SHIRQ, "xterm", data);
 	if (err){
 		printk(KERN_ERR "xterm_fd : failed to get IRQ for xterm, "
 		       "err = %d\n",  err);
Index: 2.6/arch/um/kernel/irq.c
===================================================================
--- 2.6.orig/arch/um/kernel/irq.c	2006-05-02 17:29:26.000000000 -0500
+++ 2.6/arch/um/kernel/irq.c	2006-05-03 13:53:22.000000000 -0500
@@ -474,8 +474,7 @@ int init_aio_irq(int irq, char *name, ir
 	}
 
 	err = um_request_irq(irq, fds[0], IRQ_READ, handler,
-			     SA_INTERRUPT | SA_SAMPLE_RANDOM, name,
-			     (void *) (long) fds[0]);
+			     SA_INTERRUPT, name, (void *) (long) fds[0]);
 	if (err) {
 		printk("init_aio_irq - : um_request_irq failed, err = %d\n",
 		       err);
Index: 2.6/arch/um/kernel/sigio_kern.c
===================================================================
--- 2.6.orig/arch/um/kernel/sigio_kern.c	2006-05-02 17:28:42.000000000 -0500
+++ 2.6/arch/um/kernel/sigio_kern.c	2006-05-03 13:52:41.000000000 -0500
@@ -31,8 +31,7 @@ int write_sigio_irq(int fd)
 	int err;
 
 	err = um_request_irq(SIGIO_WRITE_IRQ, fd, IRQ_READ, sigio_interrupt,
-			     SA_INTERRUPT | SA_SAMPLE_RANDOM, "write sigio",
-			     NULL);
+			     SA_INTERRUPT, "write sigio", NULL);
 	if(err){
 		printk("write_sigio_irq : um_request_irq failed, err = %d\n",
 		       err);
