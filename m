Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136534AbREDWLo>; Fri, 4 May 2001 18:11:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136536AbREDWLf>; Fri, 4 May 2001 18:11:35 -0400
Received: from colorfullife.com ([216.156.138.34]:46350 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S136534AbREDWLY>;
	Fri, 4 May 2001 18:11:24 -0400
Message-ID: <3AF32872.9137D070@colorfullife.com>
Date: Sat, 05 May 2001 00:08:50 +0200
From: Manfred Spraul <manfred@colorfullife.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.4 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: torvalds@transmeta.com
CC: linux-kernel@vger.kernel.org
Subject: [PATCH] 3 one-liner bugfixes
Content-Type: multipart/mixed;
 boundary="------------9594F5241CB3A23B440C2578"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------9594F5241CB3A23B440C2578
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hi Linus,

I found a 3 small bugs:

* mm/slab.c: the offslab_limit calculation used 2 instead of
sizeof(kmem_bufctl_t) [==4]. Cosmetic bug, since offslab_limit is never
reached.

* expand_stack is not down_read() safe, but used in the page-in path.
Fix is trivial.

* missing/wrong lock_kernel calls in fs/fcntl.c: getlk/setlk run without
the big kernel lock. The ..64 function acquire the lock.

--
	Manfred
--------------9594F5241CB3A23B440C2578
Content-Type: text/plain; charset=us-ascii;
 name="patch-slabbug-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-slabbug-2"

--- 2.4/mm/slab.c	Sat Mar  3 17:58:05 2001
+++ build-2.4/mm/slab.c	Sat Mar  3 19:57:16 2001
@@ -448,7 +448,7 @@
 		/* Inc off-slab bufctl limit until the ceiling is hit. */
 		if (!(OFF_SLAB(sizes->cs_cachep))) {
 			offslab_limit = sizes->cs_size-sizeof(slab_t);
-			offslab_limit /= 2;
+			offslab_limit /= sizeof(kmem_bufctl_t);
 		}
 		sprintf(name, "size-%Zd(DMA)",sizes->cs_size);
 		sizes->cs_dmacachep = kmem_cache_create(name, sizes->cs_size, 0,

--------------9594F5241CB3A23B440C2578
Content-Type: text/plain; charset=us-ascii;
 name="patch-expand-stack"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-expand-stack"

--- 2.4/include/linux/mm.h	Mon Apr 30 23:14:10 2001
+++ build-2.4/include/linux/mm.h	Fri May  4 23:14:35 2001
@@ -502,12 +502,14 @@
 {
 	unsigned long grow;
 
+	spin_lock(&vma->vm_mm->page_table_lock);
 	address &= PAGE_MASK;
 	grow = (vma->vm_start - address) >> PAGE_SHIFT;
 	if (vma->vm_end - address > current->rlim[RLIMIT_STACK].rlim_cur ||
-	    ((vma->vm_mm->total_vm + grow) << PAGE_SHIFT) > current->rlim[RLIMIT_AS].rlim_cur)
+	    ((vma->vm_mm->total_vm + grow) << PAGE_SHIFT) > current->rlim[RLIMIT_AS].rlim_cur) {
+		spin_unlock(&vma->vm_mm->page_table_lock);
 		return -ENOMEM;
-	spin_lock(&vma->vm_mm->page_table_lock);
+	}
 	vma->vm_start = address;
 	vma->vm_pgoff -= grow;
 	vma->vm_mm->total_vm += grow;

--------------9594F5241CB3A23B440C2578
Content-Type: text/plain; charset=us-ascii;
 name="patch-fcntl"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-fcntl"

--- 2.4/fs/fcntl.c	Thu Nov 16 07:50:25 2000
+++ build-2.4/fs/fcntl.c	Fri May  4 23:12:24 2001
@@ -254,11 +254,15 @@
 			unlock_kernel();
 			break;
 		case F_GETLK:
+			lock_kernel();
 			err = fcntl_getlk(fd, (struct flock *) arg);
+			unlock_kernel();
 			break;
 		case F_SETLK:
 		case F_SETLKW:
+			lock_kernel();
 			err = fcntl_setlk(fd, cmd, (struct flock *) arg);
+			unlock_kernel();
 			break;
 		case F_GETOWN:
 			/*
@@ -338,22 +342,26 @@
 	if (!filp)
 		goto out;
 
-	lock_kernel();
 	switch (cmd) {
 		case F_GETLK64:
+			lock_kernel();
 			err = fcntl_getlk64(fd, (struct flock64 *) arg);
+			unlock_kernel();
 			break;
 		case F_SETLK64:
+			lock_kernel();
 			err = fcntl_setlk64(fd, cmd, (struct flock64 *) arg);
+			unlock_kernel();
 			break;
 		case F_SETLKW64:
+			lock_kernel();
 			err = fcntl_setlk64(fd, cmd, (struct flock64 *) arg);
+			unlock_kernel();
 			break;
 		default:
 			err = do_fcntl(fd, cmd, arg, filp);
 			break;
 	}
-	unlock_kernel();
 	fput(filp);
 out:
 	return err;

--------------9594F5241CB3A23B440C2578--


