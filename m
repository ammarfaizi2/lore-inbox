Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267828AbUH2Nj1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267828AbUH2Nj1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Aug 2004 09:39:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267830AbUH2Nj1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Aug 2004 09:39:27 -0400
Received: from stat16.steeleye.com ([209.192.50.48]:18359 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S267828AbUH2NjR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Aug 2004 09:39:17 -0400
Subject: SMP Panic caused by [PATCH] sched: consolidate sched domains
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Matthew Dobson <colpatch@us.ibm.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 29 Aug 2004 09:39:06 -0400
Message-Id: <1093786747.1708.8.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch causes an immediate panic when the secondary processors come
on-line because sd->next is NULL.

The fix is to use cpu_possible_map instead of nodemask (which expands,
probably erroneously, to cpu_online_map in the non-numa case).

Any use of cpu_online_map in initialisation code is almost invariably
wrong, so please don't do it in future.

I know I'm sounding like a broken record, but it would be a lot easier
to spot mistakes like this immediately if every arch used the hotplug
paths to bring SMP up.

Anyway, the attached fixes our panic.

James

===== kernel/sched.c 1.329 vs edited =====
--- 1.329/kernel/sched.c	2004-08-24 02:08:09 -07:00
+++ edited/kernel/sched.c	2004-08-29 06:17:26 -07:00
@@ -3756,7 +3756,7 @@
 		sd = &per_cpu(phys_domains, i);
 		group = cpu_to_phys_group(i);
 		*sd = SD_CPU_INIT;
-		sd->span = nodemask;
+		sd->span = cpu_possible_map;
 		sd->parent = p;
 		sd->groups = &sched_group_phys[group];
 
@@ -3790,7 +3790,7 @@
 		if (cpus_empty(nodemask))
 			continue;
 
-		init_sched_build_groups(sched_group_phys, nodemask,
+		init_sched_build_groups(sched_group_phys, cpu_possible_map,
 						&cpu_to_phys_group);
 	}
 

