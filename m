Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266235AbUBQPti (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 10:49:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266237AbUBQPti
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 10:49:38 -0500
Received: from galileo.bork.org ([66.11.174.156]:26003 "HELO galileo.bork.org")
	by vger.kernel.org with SMTP id S266235AbUBQPt1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 10:49:27 -0500
Date: Tue, 17 Feb 2004 10:49:26 -0500
From: Martin Hicks <mort@wildopensource.com>
To: Andrew Morton <akpm@osdl.org>
Cc: rusty@rustcorp.com.au, steiner@sgi.com, linux-kernel@vger.kernel.org
Subject: [PATCH] Reduce TLB flushing during process migration
Message-ID: <20040217154926.GI12142@localhost>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="R7Dyui215VKdTDYA"
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--R7Dyui215VKdTDYA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


Hi Andrew,

Another optimization patch from Jack Steiner, intended to reduce TLB
flushes during process migration.

CC'ed Rusty because this patch is applied on top of his cpuhotplug code.

This patch was generated against -rc4 with the rc3-mm1 patch merged on
top of it.

mh

-- 
Martin Hicks                Wild Open Source Inc.
mort@wildopensource.com     613-266-2296

--R7Dyui215VKdTDYA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="process-migration.patch"

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1680  -> 1.1681 
#	      kernel/sched.c	1.240   -> 1.241  
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 04/02/17	mort@tomahawk.engr.sgi.com	1.1681
# Process migration optimization.
# --------------------------------------------
#
diff -Nru a/kernel/sched.c b/kernel/sched.c
--- a/kernel/sched.c	Tue Feb 17 07:33:59 2004
+++ b/kernel/sched.c	Tue Feb 17 07:33:59 2004
@@ -25,6 +25,7 @@
 #include <linux/highmem.h>
 #include <linux/smp_lock.h>
 #include <asm/mmu_context.h>
+#include <asm/tlbflush.h>
 #include <linux/interrupt.h>
 #include <linux/completion.h>
 #include <linux/kernel_stat.h>
@@ -1135,6 +1136,14 @@
 		task_rq_unlock(rq, &flags);
 		wake_up_process(rq->migration_thread);
 		wait_for_completion(&req.done);
+
+		/*
+		 * we want a new context here. This eliminates TLB
+		 * flushes on the cpus where the process executed prior to
+		 * the migration.
+		 */
+		flush_tlb_mm(current->mm);
+
 		return;
 	}
 out:

--R7Dyui215VKdTDYA--
