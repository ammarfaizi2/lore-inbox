Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263998AbTKTBws (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Nov 2003 20:52:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264178AbTKTBwr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Nov 2003 20:52:47 -0500
Received: from fw.osdl.org ([65.172.181.6]:12517 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263998AbTKTBwc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Nov 2003 20:52:32 -0500
Date: Wed, 19 Nov 2003 17:58:03 -0800
From: Andrew Morton <akpm@osdl.org>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: linux-kernel@24x7linux.com, linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test9-mm4 (only) and vmware
Message-Id: <20031119175803.65d7dc99.akpm@osdl.org>
In-Reply-To: <20031120011209.GZ22764@holomorphy.com>
References: <20031119181518.0a43c673.vmlinuz386@yahoo.com.ar>
	<20031120002119.GA7875@localhost>
	<20031119170233.2619ba81.akpm@osdl.org>
	<20031120011209.GZ22764@holomorphy.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III <wli@holomorphy.com> wrote:
>
> > Bill, can we take those BUGs out of there and just do some sane default
>  > thing?
> 
>  Here it is.

All the world's an x86 ;)

This whole patch is getting rather large.

ARM is doing weird stuff.




 arch/alpha/mm/fault.c     |    7 +++----
 arch/arm26/mm/fault.c     |    9 ++++++---
 arch/cris/mm/fault.c      |    9 +++++----
 arch/h8300/mm/fault.c     |    0 
 arch/i386/mm/fault.c      |    7 +++----
 arch/ia64/mm/fault.c      |    3 +--
 arch/m68k/mm/fault.c      |    9 +++++----
 arch/m68knommu/mm/fault.c |    0 
 arch/mips/mm/fault.c      |    3 +--
 arch/parisc/mm/fault.c    |    9 +++++----
 arch/ppc/mm/fault.c       |    3 +--
 arch/ppc64/mm/fault.c     |    4 +---
 arch/s390/mm/fault.c      |    3 +--
 arch/sh/mm/fault.c        |    9 +++++----
 arch/sparc/mm/fault.c     |    9 +++++----
 arch/sparc64/mm/fault.c   |    9 +++++----
 arch/x86_64/mm/fault.c    |    9 +++++----
 mm/memory.c               |    7 +++----
 18 files changed, 55 insertions(+), 54 deletions(-)

diff -puN arch/i386/mm/fault.c~pagefault-accounting-fix-fix-fix arch/i386/mm/fault.c
--- 25/arch/i386/mm/fault.c~pagefault-accounting-fix-fix-fix	2003-11-19 17:48:24.000000000 -0800
+++ 25-akpm/arch/i386/mm/fault.c	2003-11-19 17:48:24.000000000 -0800
@@ -316,9 +316,6 @@ good_area:
 	 * the fault.
 	 */
 	switch (handle_mm_fault(mm, vma, address, write)) {
-		case VM_FAULT_MINOR:
-			tsk->min_flt++;
-			break;
 		case VM_FAULT_MAJOR:
 			tsk->maj_flt++;
 			break;
@@ -326,8 +323,10 @@ good_area:
 			goto do_sigbus;
 		case VM_FAULT_OOM:
 			goto out_of_memory;
+		case VM_FAULT_MINOR:
 		default:
-			BUG();
+			tsk->min_flt++;
+			break;
 	}
 
 	/*
diff -puN mm/memory.c~pagefault-accounting-fix-fix-fix mm/memory.c
--- 25/mm/memory.c~pagefault-accounting-fix-fix-fix	2003-11-19 17:48:24.000000000 -0800
+++ 25-akpm/mm/memory.c	2003-11-19 17:48:24.000000000 -0800
@@ -772,9 +772,6 @@ int get_user_pages(struct task_struct *t
 			while (!(map = follow_page(mm, start, write))) {
 				spin_unlock(&mm->page_table_lock);
 				switch (handle_mm_fault(mm,vma,start,write)) {
-				case VM_FAULT_MINOR:
-					tsk->min_flt++;
-					break;
 				case VM_FAULT_MAJOR:
 					tsk->maj_flt++;
 					break;
@@ -782,8 +779,10 @@ int get_user_pages(struct task_struct *t
 					return i ? i : -EFAULT;
 				case VM_FAULT_OOM:
 					return i ? i : -ENOMEM;
+				case VM_FAULT_MINOR:
 				default:
-					BUG();
+					tsk->min_flt++;
+					break;
 				}
 				spin_lock(&mm->page_table_lock);
 			}
diff -puN arch/alpha/mm/fault.c~pagefault-accounting-fix-fix-fix arch/alpha/mm/fault.c
--- 25/arch/alpha/mm/fault.c~pagefault-accounting-fix-fix-fix	2003-11-19 17:48:45.000000000 -0800
+++ 25-akpm/arch/alpha/mm/fault.c	2003-11-19 17:49:32.000000000 -0800
@@ -152,9 +152,6 @@ do_page_fault(unsigned long address, uns
 	up_read(&mm->mmap_sem);
 
 	switch (fault) {
-	      case VM_FAULT_MINOR:
-		current->min_flt++;
-		break;
 	      case VM_FAULT_MAJOR:
 		current->maj_flt++;
 		break;
@@ -162,8 +159,10 @@ do_page_fault(unsigned long address, uns
 		goto do_sigbus;
 	      case VM_FAULT_OOM:
 		goto out_of_memory;
+	      case VM_FAULT_MINOR:
 	      default:
-		BUG();
+		current->min_flt++;
+		break;
 	}
 	return;
 
diff -puN arch/arm26/mm/fault.c~pagefault-accounting-fix-fix-fix arch/arm26/mm/fault.c
--- 25/arch/arm26/mm/fault.c~pagefault-accounting-fix-fix-fix	2003-11-19 17:48:45.000000000 -0800
+++ 25-akpm/arch/arm26/mm/fault.c	2003-11-19 17:52:34.000000000 -0800
@@ -176,13 +176,16 @@ survive:
 	 * Handle the "normal" cases first - successful and sigbus
 	 */
 	switch (fault) {
-	case 2:
+	case VM_FAULT_MAJOR:
+	default:
 		tsk->maj_flt++;
 		return fault;
-	case 1:
+	case VM_FAULT_MINOR:
 		tsk->min_flt++;
-	case 0:
+	case VM_FAULT_SIGBUS:
 		return fault;
+	case VM_FAULT_OOM:
+		break;
 	}
 
 	fault = -3; /* out of memory */
diff -puN arch/cris/mm/fault.c~pagefault-accounting-fix-fix-fix arch/cris/mm/fault.c
--- 25/arch/cris/mm/fault.c~pagefault-accounting-fix-fix-fix	2003-11-19 17:48:45.000000000 -0800
+++ 25-akpm/arch/cris/mm/fault.c	2003-11-19 17:53:15.000000000 -0800
@@ -229,15 +229,16 @@ do_page_fault(unsigned long address, str
 	 */
 
 	switch (handle_mm_fault(mm, vma, address, writeaccess)) {
-	case 1:
+	case VM_FAULT_MINOR:
+	default:
 		tsk->min_flt++;
 		break;
-	case 2:
+	case VM_FAULT_MAJOR:
 		tsk->maj_flt++;
 		break;
-	case 0:
+	case VM_FAULT_SIGBUS:
 		goto do_sigbus;
-	default:
+	case VM_FAULT_OOM:
 		goto out_of_memory;
 	}
 
diff -puN arch/h8300/mm/fault.c~pagefault-accounting-fix-fix-fix arch/h8300/mm/fault.c
diff -puN arch/ia64/mm/fault.c~pagefault-accounting-fix-fix-fix arch/ia64/mm/fault.c
--- 25/arch/ia64/mm/fault.c~pagefault-accounting-fix-fix-fix	2003-11-19 17:48:45.000000000 -0800
+++ 25-akpm/arch/ia64/mm/fault.c	2003-11-19 17:53:34.000000000 -0800
@@ -136,6 +136,7 @@ ia64_do_page_fault (unsigned long addres
 	 */
 	switch (handle_mm_fault(mm, vma, address, (mask & VM_WRITE) != 0)) {
 	      case VM_FAULT_MINOR:
+	      default:
 		++current->min_flt;
 		break;
 	      case VM_FAULT_MAJOR:
@@ -151,8 +152,6 @@ ia64_do_page_fault (unsigned long addres
 		goto bad_area;
 	      case VM_FAULT_OOM:
 		goto out_of_memory;
-	      default:
-		BUG();
 	}
 	up_read(&mm->mmap_sem);
 	return;
diff -puN arch/m68k/mm/fault.c~pagefault-accounting-fix-fix-fix arch/m68k/mm/fault.c
--- 25/arch/m68k/mm/fault.c~pagefault-accounting-fix-fix-fix	2003-11-19 17:48:45.000000000 -0800
+++ 25-akpm/arch/m68k/mm/fault.c	2003-11-19 17:54:09.000000000 -0800
@@ -160,15 +160,16 @@ good_area:
  	printk("handle_mm_fault returns %d\n",fault);
 #endif
 	switch (fault) {
-	case 1:
+	case VM_FAULT_MINOR:
+	default:
 		current->min_flt++;
 		break;
-	case 2:
+	case VM_FAULT_MAJOR:
 		current->maj_flt++;
 		break;
-	case 0:
+	case VM_FAULT_SIGBUS:
 		goto bus_err;
-	default:
+	case VM_FAULT_OOM:
 		goto out_of_memory;
 	}
 
diff -puN arch/m68knommu/mm/fault.c~pagefault-accounting-fix-fix-fix arch/m68knommu/mm/fault.c
diff -puN arch/mips/mm/fault.c~pagefault-accounting-fix-fix-fix arch/mips/mm/fault.c
--- 25/arch/mips/mm/fault.c~pagefault-accounting-fix-fix-fix	2003-11-19 17:48:45.000000000 -0800
+++ 25-akpm/arch/mips/mm/fault.c	2003-11-19 17:54:19.000000000 -0800
@@ -111,6 +111,7 @@ survive:
 	 */
 	switch (handle_mm_fault(mm, vma, address, write)) {
 	case VM_FAULT_MINOR:
+	default:
 		tsk->min_flt++;
 		break;
 	case VM_FAULT_MAJOR:
@@ -120,8 +121,6 @@ survive:
 		goto do_sigbus;
 	case VM_FAULT_OOM:
 		goto out_of_memory;
-	default:
-		BUG();
 	}
 
 	up_read(&mm->mmap_sem);
diff -puN arch/parisc/mm/fault.c~pagefault-accounting-fix-fix-fix arch/parisc/mm/fault.c
--- 25/arch/parisc/mm/fault.c~pagefault-accounting-fix-fix-fix	2003-11-19 17:48:45.000000000 -0800
+++ 25-akpm/arch/parisc/mm/fault.c	2003-11-19 17:54:56.000000000 -0800
@@ -175,20 +175,21 @@ good_area:
 	 */
 
 	switch (handle_mm_fault(mm, vma, address, (acc_type & VM_WRITE) != 0)) {
-	      case 1:
+	      case VM_FAULT_MINOR:
+	      default:
 		++current->min_flt;
 		break;
-	      case 2:
+	      case VM_FAULT_MAJOR:
 		++current->maj_flt;
 		break;
-	      case 0:
+	      case VM_FAULT_SIGBUS:
 		/*
 		 * We ran out of memory, or some other thing happened
 		 * to us that made us unable to handle the page fault
 		 * gracefully.
 		 */
 		goto bad_area;
-	      default:
+	      case VM_FAULT_OOM:
 		goto out_of_memory;
 	}
 	up_read(&mm->mmap_sem);
diff -puN arch/ppc64/mm/fault.c~pagefault-accounting-fix-fix-fix arch/ppc64/mm/fault.c
--- 25/arch/ppc64/mm/fault.c~pagefault-accounting-fix-fix-fix	2003-11-19 17:48:45.000000000 -0800
+++ 25-akpm/arch/ppc64/mm/fault.c	2003-11-19 17:55:04.000000000 -0800
@@ -122,8 +122,8 @@ good_area:
 	 * the fault.
 	 */
 	switch (handle_mm_fault(mm, vma, address, is_write)) {
-
 	case VM_FAULT_MINOR:
+	default:
 		current->min_flt++;
 		break;
 	case VM_FAULT_MAJOR:
@@ -133,8 +133,6 @@ good_area:
 		goto do_sigbus;
 	case VM_FAULT_OOM:
 		goto out_of_memory;
-	default:
-		BUG();
 	}
 
 	up_read(&mm->mmap_sem);
diff -puN arch/ppc/mm/fault.c~pagefault-accounting-fix-fix-fix arch/ppc/mm/fault.c
--- 25/arch/ppc/mm/fault.c~pagefault-accounting-fix-fix-fix	2003-11-19 17:48:45.000000000 -0800
+++ 25-akpm/arch/ppc/mm/fault.c	2003-11-19 17:55:13.000000000 -0800
@@ -257,6 +257,7 @@ good_area:
  survive:
         switch (handle_mm_fault(mm, vma, address, is_write)) {
         case VM_FAULT_MINOR:
+	default:
                 current->min_flt++;
                 break;
         case VM_FAULT_MAJOR:
@@ -266,8 +267,6 @@ good_area:
                 goto do_sigbus;
         case VM_FAULT_OOM:
                 goto out_of_memory;
-	default:
-		BUG();
 	}
 
 	up_read(&mm->mmap_sem);
diff -puN arch/s390/mm/fault.c~pagefault-accounting-fix-fix-fix arch/s390/mm/fault.c
--- 25/arch/s390/mm/fault.c~pagefault-accounting-fix-fix-fix	2003-11-19 17:48:45.000000000 -0800
+++ 25-akpm/arch/s390/mm/fault.c	2003-11-19 17:55:21.000000000 -0800
@@ -247,6 +247,7 @@ survive:
 	 */
 	switch (handle_mm_fault(mm, vma, address, error_code == 4)) {
 	case VM_FAULT_MINOR:
+	default:
 		tsk->min_flt++;
 		break;
 	case VM_FAULT_MAJOR:
@@ -256,8 +257,6 @@ survive:
 		goto do_sigbus;
 	case VM_FAULT_OOM:
 		goto out_of_memory;
-	default:
-		BUG();
 	}
 
         up_read(&mm->mmap_sem);
diff -puN arch/sh/mm/fault.c~pagefault-accounting-fix-fix-fix arch/sh/mm/fault.c
--- 25/arch/sh/mm/fault.c~pagefault-accounting-fix-fix-fix	2003-11-19 17:48:45.000000000 -0800
+++ 25-akpm/arch/sh/mm/fault.c	2003-11-19 17:55:51.000000000 -0800
@@ -95,15 +95,16 @@ good_area:
 	 */
 survive:
 	switch (handle_mm_fault(mm, vma, address, writeaccess)) {
-	case 1:
+	case VM_FAULT_MINOR:
+	default:
 		tsk->min_flt++;
 		break;
-	case 2:
+	case VM_FAULT_MAJOR:
 		tsk->maj_flt++;
 		break;
-	case 0:
+	case VM_FAULT_SIGBUS:
 		goto do_sigbus;
-	default:
+	case VM_FAULT_OOM:
 		goto out_of_memory;
 	}
 
diff -puN arch/sparc64/mm/fault.c~pagefault-accounting-fix-fix-fix arch/sparc64/mm/fault.c
--- 25/arch/sparc64/mm/fault.c~pagefault-accounting-fix-fix-fix	2003-11-19 17:48:46.000000000 -0800
+++ 25-akpm/arch/sparc64/mm/fault.c	2003-11-19 17:56:18.000000000 -0800
@@ -419,15 +419,16 @@ good_area:
 	}
 
 	switch (handle_mm_fault(mm, vma, address, (fault_code & FAULT_CODE_WRITE))) {
-	case 1:
+	case VM_FAULT_MINOR:
+	default:
 		current->min_flt++;
 		break;
-	case 2:
+	case VM_FAULT_MAJOR:
 		current->maj_flt++;
 		break;
-	case 0:
+	case VM_FAULT_SIGBUS:
 		goto do_sigbus;
-	default:
+	case VM_FAULT_OOM:
 		goto out_of_memory;
 	}
 
diff -puN arch/sparc/mm/fault.c~pagefault-accounting-fix-fix-fix arch/sparc/mm/fault.c
--- 25/arch/sparc/mm/fault.c~pagefault-accounting-fix-fix-fix	2003-11-19 17:48:46.000000000 -0800
+++ 25-akpm/arch/sparc/mm/fault.c	2003-11-19 17:56:40.000000000 -0800
@@ -276,15 +276,16 @@ good_area:
 	 * the fault.
 	 */
 	switch (handle_mm_fault(mm, vma, address, write)) {
-	case 1:
+	case VM_FAULT_MINOR:
+	default:
 		current->min_flt++;
 		break;
-	case 2:
+	case VM_FAULT_MAJOR:
 		current->maj_flt++;
 		break;
-	case 0:
+	case VM_FAULT_SIGBUS:
 		goto do_sigbus;
-	default:
+	case VM_FAULT_OOM:
 		goto out_of_memory;
 	}
 	up_read(&mm->mmap_sem);
diff -puN arch/x86_64/mm/fault.c~pagefault-accounting-fix-fix-fix arch/x86_64/mm/fault.c
--- 25/arch/x86_64/mm/fault.c~pagefault-accounting-fix-fix-fix	2003-11-19 17:48:46.000000000 -0800
+++ 25-akpm/arch/x86_64/mm/fault.c	2003-11-19 17:57:08.000000000 -0800
@@ -289,15 +289,16 @@ good_area:
 	 * the fault.
 	 */
 	switch (handle_mm_fault(mm, vma, address, write)) {
-	case 1:
+	case VM_FAULT_MINOR:
+	default:
 		tsk->min_flt++;
 		break;
-	case 2:
+	case VM_FAULT_MAJOR:
 		tsk->maj_flt++;
 		break;
-	case 0:
+	case VM_FAULT_SIGBUS:
 		goto do_sigbus;
-	default:
+	case VM_FAULT_OOM:
 		goto out_of_memory;
 	}
 

_

