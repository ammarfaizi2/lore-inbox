Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030253AbWJCCrP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030253AbWJCCrP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 22:47:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030254AbWJCCrP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 22:47:15 -0400
Received: from server99.tchmachines.com ([72.9.230.178]:46002 "EHLO
	server99.tchmachines.com") by vger.kernel.org with ESMTP
	id S1030253AbWJCCrN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 22:47:13 -0400
Date: Mon, 2 Oct 2006 19:49:14 -0700
From: Ravikiran G Thirumalai <kiran@scalex86.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Alok Kataria <alok.kataria@calsoftinc.com>,
       "Shai Fultheim (Shai@scalex86.org)" <shai@scalex86.org>,
       "Benzi Galili (Benzi@ScaleMP.com)" <benzi@scalemp.com>
Subject: [patch] mm: Fix incorrect mempolicy for idle threads
Message-ID: <20061003024914.GA4071@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - server99.tchmachines.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - scalex86.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The kernel boots up on the BP with an initial memory policy of
MPOL_INTERLEAVE (start_kernel() -> numa_policy_init()).  This is
done to avoid all boot data structure allocations to be off the boot
node. Current mainline resets the memory policy to MPOL_DEFAULT at init(), 
just before calling userspace init.  But, this is too late and leaves 
the kernel idle thread with MPOL_INTERLEAVE, causing later allocations 
off interrupt/BH context to use MPOL_INTERLEAVE, rather than MPOL_DEFAULT 
(if the interrupt occurs on an idle cpu).  This can be fixed by changing 
the mempolicy to MPOL_DEFAULT just before the 'init' kernel thread is 
spawned, OR just before smp_init() (smp_init would spawn idle threads).  
The following patch uses the latter approach and moves numa_default_policy() 
to just  before smp_init().

Signed-off-by: Alok N Kataria <alok.kataria@calsoftinc.com>
Signed-off-by: Ravikiran Thirumalai <kiran@scalex86.org>
Signed-off-by: Shai Fultheim <shai@scalex86.org>

Index: linux-2.6.18/init/main.c
===================================================================
--- linux-2.6.18.orig/init/main.c	2006-09-19 20:42:06.000000000 -0700
+++ linux-2.6.18/init/main.c	2006-09-28 15:13:01.000000000 -0700
@@ -703,6 +703,8 @@ static int init(void * unused)
 
 	do_pre_smp_initcalls();
 
+	numa_default_policy();
+
 	smp_init();
 	sched_init_smp();
 
@@ -738,7 +740,6 @@ static int init(void * unused)
 	unlock_kernel();
 	mark_rodata_ro();
 	system_state = SYSTEM_RUNNING;
-	numa_default_policy();
 
 	if (sys_open((const char __user *) "/dev/console", O_RDWR, 0) < 0)
 		printk(KERN_WARNING "Warning: unable to open an initial console.\n");
