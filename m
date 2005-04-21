Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261410AbVDUOtv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261410AbVDUOtv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Apr 2005 10:49:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261411AbVDUOtv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Apr 2005 10:49:51 -0400
Received: from unicorn.rentec.com ([216.223.240.9]:62170 "EHLO
	unicorn.rentec.com") by vger.kernel.org with ESMTP id S261410AbVDUOtp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Apr 2005 10:49:45 -0400
X-Rentec: external
From: Wolfgang Wander <wwc@rentec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16999.48517.760155.615281@gargle.gargle.HOWL>
Date: Thu, 21 Apr 2005 10:49:41 -0400
To: linux-kernel@vger.kernel.org
Subject: Avoiding maps fragmentation Was: Leaks in mmap address space: 2.6.11.4 
In-Reply-To: <16992.14366.232980.673857@gargle.gargle.HOWL>
References: <200504151646.j3FGkLQ00256@troll.rentec.com>
	<16992.14366.232980.673857@gargle.gargle.HOWL>
X-Mailer: VM 7.17 under 21.4 (patch 14) "Reasonable Discussion" XEmacs Lucid
X-Logged: Logged by unicorn.rentec.com as j3LEngKv024951 at Thu Apr 21 10:49:44 2005
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Looks like I have to answer myself here with you guys all busy
gitting...

I posted two sample programs last week that showed that large
application can run out of memory a lot quicker on 2.6 than on 2.4.
The reason is that the /proc/*/maps space fragments a lot faster 
on 2.6 than with 2.4 kernels.

2.4 started searching for unused space from the mmap base up to the
stack,  2.6 starts search from the end of the last mapped area 
(mm->free_area_cache).

The difference in the two algorithms is obvious (apart from the
efficiency which is undoubtedly better in 2.6):

Whereas 2.4 naturally started to fill small holes closer to the base thus
leaving larger areas open towards the stack, 2.6 will place small maps
all over the mappable area thus closing up potential large holes inefficiently.

The attached patch is left as a hack so that you guys can come up (please;-)
with a neater solution but something ought to be done that saves large
holes from small map clutter...

     Wolfgang

PS: Patch^H^H^H^H^H Ugly_Hack is against 2.6.11.7 and only 'fixes' the
two architectures I'm interested in (i386 and x86_64)



diff -ru linux-2.6.11.7.orig/arch/x86_64/kernel/sys_x86_64.c linux-2.6.11.7/arch/x86_64/kernel/sys_x86_64.c
--- linux-2.6.11.7.orig/arch/x86_64/kernel/sys_x86_64.c	2005-03-02 02:38:13.000000000 -0500
+++ linux-2.6.11.7/arch/x86_64/kernel/sys_x86_64.c	2005-04-21 09:27:38.000000000 -0400
@@ -112,8 +112,8 @@
 		    (!vma || addr + len <= vma->vm_start))
 			return addr;
 	}
-	addr = mm->free_area_cache;
-	if (addr < begin) 
+	/* addr = mm->free_area_cache;
+	if (addr < begin)  */
 		addr = begin; 
 	start_addr = addr;
 
diff -ru linux-2.6.11.7.orig/mm/mmap.c linux-2.6.11.7/mm/mmap.c
--- linux-2.6.11.7.orig/mm/mmap.c	2005-03-02 02:38:12.000000000 -0500
+++ linux-2.6.11.7/mm/mmap.c	2005-04-21 09:32:06.000000000 -0400
@@ -1173,7 +1173,7 @@
 		    (!vma || addr + len <= vma->vm_start))
 			return addr;
 	}
-	start_addr = addr = mm->free_area_cache;
+	start_addr = addr = TASK_UNMAPPED_BASE; /* mm->free_area_cache; */
 
 full_search:
 	for (vma = find_vma(mm, addr); ; vma = vma->vm_next) {



Wolfgang Wander writes:
 > Here is another program that illustrates the problem which this time
 > in C and without using glibc allocation schemes.
 > 
 > ----------------------------------------------------------------------
 > 
 > Wolfgang Wander writes:
 >  > Hi,
 >  > 
 >  >   we are running some pretty large applications in 32bit mode on 64bit
 >  >   AMD kernels (8GB Ram, Dual AMD64 CPUs, SMP).  Kernel is 2.6.11.4 or
 >  >   2.4.21.
 >  > 
 >  >   Some of these applications run consistently out of memory but only
 >  >   on 2.6 machines.  In fact large memory allocations that libc answers
 >  >   with private mmaps seem to contribute to the problem: 2.4 kernels
 >  >   are able to combine these mmaps to large chunks whereas 2.6
 >  >   generates a rather fragmented /proc/self/maps table.
 >  > 
 >  >   The following C++ program reproduces the error (compiled statically
 >  >   on a 32bit machine to get exactly the same executable for 2.4 and
 >  >   2.6 environments):
