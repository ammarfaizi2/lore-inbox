Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751129AbWGGAjJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751129AbWGGAjJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 20:39:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751118AbWGGAio
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 20:38:44 -0400
Received: from saraswathi.solana.com ([198.99.130.12]:57795 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S1751117AbWGGAeQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 20:34:16 -0400
Message-Id: <200607070033.k670XhQR008707@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
Subject: [PATCH 10/19] UML - Remove spinlock wrapper functions
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 06 Jul 2006 20:33:43 -0400
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The irq_spinlock is not needed from user code any more, so the
irq_lock and irq_unlock wrappers can go away.  This also changes the
name of the lock to irq_lock.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.17/arch/um/include/irq_user.h
===================================================================
--- linux-2.6.17.orig/arch/um/include/irq_user.h	2006-07-06 13:27:58.000000000 -0400
+++ linux-2.6.17/arch/um/include/irq_user.h	2006-07-06 13:28:14.000000000 -0400
@@ -29,8 +29,6 @@ extern void reactivate_fd(int fd, int ir
 extern void deactivate_fd(int fd, int irqnum);
 extern int deactivate_all_fds(void);
 extern int activate_ipi(int fd, int pid);
-extern unsigned long irq_lock(void);
-extern void irq_unlock(unsigned long flags);
 
 #ifdef CONFIG_MODE_TT
 extern void forward_interrupts(int pid);
Index: linux-2.6.17/arch/um/kernel/irq.c
===================================================================
--- linux-2.6.17.orig/arch/um/kernel/irq.c	2006-07-06 13:27:58.000000000 -0400
+++ linux-2.6.17/arch/um/kernel/irq.c	2006-07-06 13:28:43.000000000 -0400
@@ -123,6 +123,8 @@ static void maybe_sigio_broken(int fd, i
 	}
 }
 
+static DEFINE_SPINLOCK(irq_lock);
+
 int activate_fd(int irq, int fd, int type, void *dev_id)
 {
 	struct pollfd *tmp_pfd;
@@ -166,7 +168,7 @@ int activate_fd(int irq, int fd, int typ
 	 * this is called only from process context, and can be locked with
 	 * a semaphore.
 	 */
-	flags = irq_lock();
+	spin_lock_irqsave(&irq_lock, flags);
 	for (irq_fd = active_fds; irq_fd != NULL; irq_fd = irq_fd->next) {
 		if ((irq_fd->fd == fd) && (irq_fd->type == type)) {
 			printk("Registering fd %d twice\n", fd);
@@ -199,7 +201,7 @@ int activate_fd(int irq, int fd, int typ
 		 * so we will not be able to put new pollfd struct to pollfds
 		 * then we free the buffer tmp_fds and try again.
 		 */
-		irq_unlock(flags);
+		spin_unlock_irqrestore(&irq_lock, flags);
 		kfree(tmp_pfd);
 		tmp_pfd = NULL;
 
@@ -207,14 +209,14 @@ int activate_fd(int irq, int fd, int typ
 		if (tmp_pfd == NULL)
 			goto out_kfree;
 
-		flags = irq_lock();
+		spin_lock_irqsave(&irq_lock, flags);
 	}
 	/*-------------*/
 
 	*last_irq_ptr = new_fd;
 	last_irq_ptr = &new_fd->next;
 
-	irq_unlock(flags);
+	spin_unlock_irqrestore(&irq_lock, flags);
 
 	/* This calls activate_fd, so it has to be outside the critical
 	 * section.
@@ -224,7 +226,7 @@ int activate_fd(int irq, int fd, int typ
 	return(0);
 
  out_unlock:
-	irq_unlock(flags);
+	spin_unlock_irqrestore(&irq_lock, flags);
  out_kfree:
 	kfree(new_fd);
  out:
@@ -235,9 +237,9 @@ static void free_irq_by_cb(int (*test)(s
 {
 	unsigned long flags;
 
-	flags = irq_lock();
+	spin_lock_irqsave(&irq_lock, flags);
 	os_free_irq_by_cb(test, arg, active_fds, &last_irq_ptr);
-	irq_unlock(flags);
+	spin_unlock_irqrestore(&irq_lock, flags);
 }
 
 struct irq_and_dev {
@@ -304,14 +306,14 @@ void reactivate_fd(int fd, int irqnum)
 	unsigned long flags;
 	int i;
 
-	flags = irq_lock();
+	spin_lock_irqsave(&irq_lock, flags);
 	irq = find_irq_by_fd(fd, irqnum, &i);
 	if (irq == NULL) {
-		irq_unlock(flags);
+		spin_unlock_irqrestore(&irq_lock, flags);
 		return;
 	}
 	os_set_pollfd(i, irq->fd);
-	irq_unlock(flags);
+	spin_unlock_irqrestore(&irq_lock, flags);
 
 	/* This calls activate_fd, so it has to be outside the critical
 	 * section.
@@ -325,13 +327,13 @@ void deactivate_fd(int fd, int irqnum)
 	unsigned long flags;
 	int i;
 
-	flags = irq_lock();
+	spin_lock_irqsave(&irq_lock, flags);
 	irq = find_irq_by_fd(fd, irqnum, &i);
 	if (irq == NULL)
 		goto out;
 	os_set_pollfd(i, -1);
  out:
-	irq_unlock(flags);
+	spin_unlock_irqrestore(&irq_lock, flags);
 }
 
 int deactivate_all_fds(void)
@@ -357,7 +359,7 @@ void forward_interrupts(int pid)
 	unsigned long flags;
 	int err;
 
-	flags = irq_lock();
+	spin_lock_irqsave(&irq_lock, flags);
 	for (irq = active_fds; irq != NULL; irq = irq->next) {
 		err = os_set_owner(irq->fd, pid);
 		if (err < 0) {
@@ -370,7 +372,7 @@ void forward_interrupts(int pid)
 
 		irq->pid = pid;
 	}
-	irq_unlock(flags);
+	spin_unlock_irqrestore(&irq_lock, flags);
 }
 #endif
 
@@ -405,21 +407,6 @@ int um_request_irq(unsigned int irq, int
 EXPORT_SYMBOL(um_request_irq);
 EXPORT_SYMBOL(reactivate_fd);
 
-static DEFINE_SPINLOCK(irq_spinlock);
-
-unsigned long irq_lock(void)
-{
-	unsigned long flags;
-
-	spin_lock_irqsave(&irq_spinlock, flags);
-	return flags;
-}
-
-void irq_unlock(unsigned long flags)
-{
-	spin_unlock_irqrestore(&irq_spinlock, flags);
-}
-
 /* hw_interrupt_type must define (startup || enable) &&
  * (shutdown || disable) && end */
 static void dummy(unsigned int irq)

