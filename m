Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261161AbUB0CeF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Feb 2004 21:34:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261207AbUB0CeF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Feb 2004 21:34:05 -0500
Received: from gate.crashing.org ([63.228.1.57]:56505 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261161AbUB0Cdy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Feb 2004 21:33:54 -0500
Subject: [PATCH] ppc64: Fix a sleeping with spinlock bug in ioremap
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1077848737.22397.159.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Fri, 27 Feb 2004 13:25:37 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

ppc64 uses it's own range allocator for ioremap (in order to allocate
things in a different space than normal vmalloc). This is historic
stuff, we may get rid of it, but in the meantime, here's a patch
turning the spinlock in there into a semaphore so it doesn't blow
up when doing kmalloc's

===== arch/ppc64/mm/imalloc.c 1.3 vs edited =====
--- 1.3/arch/ppc64/mm/imalloc.c	Mon Jan 19 17:28:15 2004
+++ edited/arch/ppc64/mm/imalloc.c	Fri Feb 27 13:05:06 2004
@@ -9,13 +9,13 @@
 
 #include <linux/slab.h>
 #include <linux/vmalloc.h>
-#include <linux/spinlock.h>
 
 #include <asm/uaccess.h>
 #include <asm/pgalloc.h>
 #include <asm/pgtable.h>
+#include <asm/semaphore.h>
 
-rwlock_t imlist_lock = RW_LOCK_UNLOCKED;
+static DECLARE_MUTEX(imlist_sem);
 struct vm_struct * imlist = NULL;
 
 static int get_free_im_addr(unsigned long size, unsigned long *im_addr)
@@ -223,7 +223,7 @@
 	struct vm_struct *area;
 	unsigned long addr;
 	
-	write_lock(&imlist_lock);
+	down(&imlist_sem);
 	if (get_free_im_addr(size, &addr)) {
 		printk(KERN_ERR "%s() cannot obtain addr for size 0x%lx\n",
 				__FUNCTION__, size);
@@ -238,7 +238,7 @@
 			__FUNCTION__, addr, size);
 	}
 next_im_done:
-	write_unlock(&imlist_lock);
+	up(&imlist_sem);
 	return area;
 }
 
@@ -247,9 +247,9 @@
 {
 	struct vm_struct *area;
 
-	write_lock(&imlist_lock);
+	down(&imlist_sem);
 	area = __im_get_area(v_addr, size, criteria);
-	write_unlock(&imlist_lock);
+	up(&imlist_sem);
 	return area;
 }
 
@@ -264,17 +264,17 @@
 		printk(KERN_ERR "Trying to %s bad address (%p)\n", __FUNCTION__,			addr);
 		return ret_size;
 	}
-	write_lock(&imlist_lock);
+	down(&imlist_sem);
 	for (p = &imlist ; (tmp = *p) ; p = &tmp->next) {
 		if (tmp->addr == addr) {
 			ret_size = tmp->size;
 			*p = tmp->next;
 			kfree(tmp);
-			write_unlock(&imlist_lock);
+			up(&imlist_sem);
 			return ret_size;
 		}
 	}
-	write_unlock(&imlist_lock);
+	up(&imlist_sem);
 	printk(KERN_ERR "Trying to %s nonexistent area (%p)\n", __FUNCTION__,
 			addr);
 	return ret_size;


