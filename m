Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261229AbVCIXyy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261229AbVCIXyy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 18:54:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262553AbVCIXx0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 18:53:26 -0500
Received: from lakshmi.addtoit.com ([198.99.130.6]:17422 "EHLO
	lakshmi.solana.com") by vger.kernel.org with ESMTP id S262007AbVCIXpo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 18:45:44 -0500
Message-Id: <200503100216.j2A2G6DN015238@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.1-RC1
To: torvalds@osdl.org
cc: simlo@phys.au.dk, akpm@osdl.org, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
Subject: [PATCH 5/9] UML - change semaphores to completions
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 09 Mar 2005 21:16:06 -0500
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Esben Nielsen <simlo at phys au dk>

One of the problems was use of direct architecture specific semaphores
(which doesn't work under PREEMPT_REALTIME) and in places where a quick
(maybe too quick) look at the code told me that completions ought to be
used. Therefore I changed two semaphores to completions which compiled
fine. I have tried the change on 2.6.11-rc2, and it seemed to work, but I
have not tested it heavily.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.11/arch/um/drivers/port_kern.c
===================================================================
--- linux-2.6.11.orig/arch/um/drivers/port_kern.c	2005-03-08 20:17:34.000000000 -0500
+++ linux-2.6.11/arch/um/drivers/port_kern.c	2005-03-08 22:16:48.000000000 -0500
@@ -25,7 +25,7 @@
 	struct list_head list;
 	atomic_t wait_count;
 	int has_connection;
-	struct semaphore sem;
+	struct completion done;
 	int port;
 	int fd;
 	spinlock_t lock;
@@ -68,7 +68,7 @@
 	conn->fd = fd;
 	list_add(&conn->list, &conn->port->connections);
 
-	up(&conn->port->sem);
+	complete(&conn->port->done);
 	return(IRQ_HANDLED);
 }
 
@@ -197,13 +197,14 @@
 		{ .list 	 	= LIST_HEAD_INIT(port->list),
 		  .wait_count		= ATOMIC_INIT(0),
 		  .has_connection 	= 0,
-		  .sem 			= __SEMAPHORE_INITIALIZER(port->sem, 
-								  0),
 		  .lock 		= SPIN_LOCK_UNLOCKED,
 		  .port 	 	= port_num,
 		  .fd  			= fd,
 		  .pending 		= LIST_HEAD_INIT(port->pending),
 		  .connections 		= LIST_HEAD_INIT(port->connections) });
+
+	init_completion(&port->done), 
+
 	list_add(&port->list, &ports);
 
  found:
@@ -237,7 +238,7 @@
         atomic_inc(&port->wait_count);
 	while(1){
 		fd = -ERESTARTSYS;
-		if(down_interruptible(&port->sem))
+                if(wait_for_completion_interruptible(&port->done))
                         goto out;
 
 		spin_lock(&port->lock);
@@ -308,14 +309,3 @@
 }
 
 __uml_exitcall(free_port);
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
Index: linux-2.6.11/arch/um/drivers/xterm_kern.c
===================================================================
--- linux-2.6.11.orig/arch/um/drivers/xterm_kern.c	2005-03-08 20:17:34.000000000 -0500
+++ linux-2.6.11/arch/um/drivers/xterm_kern.c	2005-03-08 22:16:48.000000000 -0500
@@ -16,7 +16,7 @@
 #include "xterm.h"
 
 struct xterm_wait {
-	struct semaphore sem;
+	struct completion ready;
 	int fd;
 	int pid;
 	int new_fd;
@@ -32,7 +32,7 @@
 		return(IRQ_NONE);
 
 	xterm->new_fd = fd;
-	up(&xterm->sem);
+	complete(&xterm->ready);
 	return(IRQ_HANDLED);
 }
 
@@ -49,10 +49,10 @@
 
 	/* This is a locked semaphore... */
 	*data = ((struct xterm_wait) 
-		{ .sem  	= __SEMAPHORE_INITIALIZER(data->sem, 0),
-		  .fd 		= socket,
+		{ .fd 		= socket,
 		  .pid 		= -1,
 		  .new_fd 	= -1 });
+	init_completion(&data->ready);
 
 	err = um_request_irq(XTERM_IRQ, socket, IRQ_READ, xterm_interrupt, 
 			     SA_INTERRUPT | SA_SHIRQ | SA_SAMPLE_RANDOM, 
@@ -68,7 +68,7 @@
 	 *
 	 * XXX Note, if the xterm doesn't work for some reason (eg. DISPLAY
 	 * isn't set) this will hang... */
-	down(&data->sem);
+	wait_for_completion(&data->ready);
 
 	free_irq_by_irq_and_dev(XTERM_IRQ, data);
 	free_irq(XTERM_IRQ, data);

