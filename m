Return-Path: <linux-kernel-owner+w=401wt.eu-S932785AbXAATxi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932785AbXAATxi (ORCPT <rfc822;w@1wt.eu>);
	Mon, 1 Jan 2007 14:53:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932069AbXAATxC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Jan 2007 14:53:02 -0500
Received: from saraswathi.solana.com ([198.99.130.12]:52690 "EHLO
	saraswathi.solana.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754695AbXAATwo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Jan 2007 14:52:44 -0500
Message-Id: <200701011947.l01Jl7vp020746@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
Subject: [PATCH 1/8] UML - watchdog driver locking
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 01 Jan 2007 14:47:07 -0500
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Replace BKL use with a spinlock.

Also fix the control so that open doesn't return holding a lock.

Signed-off-by: Jeff Dike <jdike@addtoit.com>
--
 arch/um/drivers/harddog_kern.c |   23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

Index: linux-2.6.18-mm/arch/um/drivers/harddog_kern.c
===================================================================
--- linux-2.6.18-mm.orig/arch/um/drivers/harddog_kern.c	2006-12-29 18:25:36.000000000 -0500
+++ linux-2.6.18-mm/arch/um/drivers/harddog_kern.c	2006-12-29 21:02:50.000000000 -0500
@@ -44,12 +44,13 @@
 #include <linux/reboot.h>
 #include <linux/smp_lock.h>
 #include <linux/init.h>
+#include <linux/spinlock.h>
 #include <asm/uaccess.h>
 #include "mconsole.h"
 
 MODULE_LICENSE("GPL");
 
-/* Locked by the BKL in harddog_open and harddog_release */
+static DEFINE_SPINLOCK(lock);
 static int timer_alive;
 static int harddog_in_fd = -1;
 static int harddog_out_fd = -1;
@@ -62,12 +63,12 @@ extern int start_watchdog(int *in_fd_ret
 
 static int harddog_open(struct inode *inode, struct file *file)
 {
-	int err;
+	int err = -EBUSY;
 	char *sock = NULL;
 
-	lock_kernel();
+	spin_lock(&lock);
 	if(timer_alive)
-		return -EBUSY;
+		goto err;
 #ifdef CONFIG_HARDDOG_NOWAYOUT	 
 	__module_get(THIS_MODULE);
 #endif
@@ -76,11 +77,15 @@ static int harddog_open(struct inode *in
 	sock = mconsole_notify_socket();
 #endif
 	err = start_watchdog(&harddog_in_fd, &harddog_out_fd, sock);
-	if(err) return(err);
+	if(err)
+		goto err;
 
 	timer_alive = 1;
-	unlock_kernel();
+	spin_unlock(&lock);
 	return nonseekable_open(inode, file);
+err:
+	spin_unlock(&lock);
+	return err;
 }
 
 extern void stop_watchdog(int in_fd, int out_fd);
@@ -90,14 +95,16 @@ static int harddog_release(struct inode 
 	/*
 	 *	Shut off the timer.
 	 */
-	lock_kernel();
+
+	spin_lock(&lock);
 
 	stop_watchdog(harddog_in_fd, harddog_out_fd);
 	harddog_in_fd = -1;
 	harddog_out_fd = -1;
 
 	timer_alive=0;
-	unlock_kernel();
+	spin_unlock(&lock);
+
 	return 0;
 }
 

