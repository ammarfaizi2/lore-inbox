Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261614AbVEBBqM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261614AbVEBBqM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 May 2005 21:46:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261621AbVEBBqM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 May 2005 21:46:12 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:18448 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261614AbVEBBpx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 May 2005 21:45:53 -0400
Date: Mon, 2 May 2005 03:45:51 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andi Kleen <ak@muc.de>, Christoph Hellwig <hch@lst.de>,
       Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] {,un}register_ioctl32_conversion should have been removed last month
Message-ID: <20050502014550.GG3592@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This removal should have happened last month.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 Documentation/feature-removal-schedule.txt |    8 -
 fs/compat.c                                |   90 ---------------------
 include/linux/ioctl32.h                    |   22 -----
 3 files changed, 120 deletions(-)

--- linux-2.6.12-rc3-mm2-full/Documentation/feature-removal-schedule.txt.old	2005-05-01 23:55:12.000000000 +0200
+++ linux-2.6.12-rc3-mm2-full/Documentation/feature-removal-schedule.txt	2005-05-01 23:55:23.000000000 +0200
@@ -43,14 +43,6 @@
 
 ---------------------------
 
-What:	register_ioctl32_conversion() / unregister_ioctl32_conversion()
-When:	April 2005
-Why:	Replaced by ->compat_ioctl in file_operations and other method
-	vecors.
-Who:	Andi Kleen <ak@muc.de>, Christoph Hellwig <hch@lst.de>
-
----------------------------
-
 What:	RCU API moves to EXPORT_SYMBOL_GPL
 When:	April 2006
 Files:	include/linux/rcupdate.h, kernel/rcupdate.c
--- linux-2.6.12-rc3-mm2-full/include/linux/ioctl32.h.old	2005-05-01 23:55:43.000000000 +0200
+++ linux-2.6.12-rc3-mm2-full/include/linux/ioctl32.h	2005-05-01 23:56:08.000000000 +0200
@@ -14,26 +14,4 @@
 	struct ioctl_trans *next;
 };
 
-/* 
- * Register an 32bit ioctl translation handler for ioctl cmd.
- *
- * handler == NULL: use 64bit ioctl handler.
- * arguments to handler:  fd: file descriptor
- *                        cmd: ioctl command.
- *                        arg: ioctl argument
- *                        struct file *file: file descriptor pointer.
- */ 
-
-#ifdef CONFIG_COMPAT
-extern int __deprecated register_ioctl32_conversion(unsigned int cmd,
-				ioctl_trans_handler_t handler);
-extern int __deprecated unregister_ioctl32_conversion(unsigned int cmd);
-
-#else
-
-#define register_ioctl32_conversion(cmd, handler)	({ 0; })
-#define unregister_ioctl32_conversion(cmd)		({ 0; })
-
-#endif
-
 #endif
--- linux-2.6.12-rc3-mm2-full/fs/compat.c.old	2005-05-01 23:56:17.000000000 +0200
+++ linux-2.6.12-rc3-mm2-full/fs/compat.c	2005-05-01 23:57:45.000000000 +0200
@@ -310,96 +310,6 @@
 
 __initcall(init_sys32_ioctl);
 
-int register_ioctl32_conversion(unsigned int cmd,
-				ioctl_trans_handler_t handler)
-{
-	struct ioctl_trans *t;
-	struct ioctl_trans *new_t;
-	unsigned long hash = ioctl32_hash(cmd);
-
-	new_t = kmalloc(sizeof(*new_t), GFP_KERNEL);
-	if (!new_t)
-		return -ENOMEM;
-
-	down_write(&ioctl32_sem);
-	for (t = ioctl32_hash_table[hash]; t; t = t->next) {
-		if (t->cmd == cmd) {
-			printk(KERN_ERR "Trying to register duplicated ioctl32 "
-					"handler %x\n", cmd);
-			up_write(&ioctl32_sem);
-			kfree(new_t);
-			return -EINVAL; 
-		}
-	}
-	new_t->next = NULL;
-	new_t->cmd = cmd;
-	new_t->handler = handler;
-	ioctl32_insert_translation(new_t);
-
-	up_write(&ioctl32_sem);
-	return 0;
-}
-EXPORT_SYMBOL(register_ioctl32_conversion);
-
-static inline int builtin_ioctl(struct ioctl_trans *t)
-{ 
-	return t >= ioctl_start && t < (ioctl_start + ioctl_table_size);
-} 
-
-/* Problem: 
-   This function cannot unregister duplicate ioctls, because they are not
-   unique.
-   When they happen we need to extend the prototype to pass the handler too. */
-
-int unregister_ioctl32_conversion(unsigned int cmd)
-{
-	unsigned long hash = ioctl32_hash(cmd);
-	struct ioctl_trans *t, *t1;
-
-	down_write(&ioctl32_sem);
-
-	t = ioctl32_hash_table[hash];
-	if (!t) { 
-		up_write(&ioctl32_sem);
-		return -EINVAL;
-	} 
-
-	if (t->cmd == cmd) { 
-		if (builtin_ioctl(t)) {
-			printk("%p tried to unregister builtin ioctl %x\n",
-			       __builtin_return_address(0), cmd);
-		} else { 
-			ioctl32_hash_table[hash] = t->next;
-			up_write(&ioctl32_sem);
-			kfree(t);
-			return 0;
-		}
-	} 
-	while (t->next) {
-		t1 = t->next;
-		if (t1->cmd == cmd) { 
-			if (builtin_ioctl(t1)) {
-				printk("%p tried to unregister builtin "
-					"ioctl %x\n",
-					__builtin_return_address(0), cmd);
-				goto out;
-			} else { 
-				t->next = t1->next;
-				up_write(&ioctl32_sem);
-				kfree(t1);
-				return 0;
-			}
-		}
-		t = t1;
-	}
-	printk(KERN_ERR "Trying to free unknown 32bit ioctl handler %x\n",
-				cmd);
-out:
-	up_write(&ioctl32_sem);
-	return -EINVAL;
-}
-EXPORT_SYMBOL(unregister_ioctl32_conversion); 
-
 static void compat_ioctl_error(struct file *filp, unsigned int fd,
 		unsigned int cmd, unsigned long arg)
 {

