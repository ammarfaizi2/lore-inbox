Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751262AbWDFT51@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751262AbWDFT51 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Apr 2006 15:57:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751289AbWDFT51
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Apr 2006 15:57:27 -0400
Received: from atlrel8.hp.com ([156.153.255.206]:45762 "EHLO atlrel8.hp.com")
	by vger.kernel.org with ESMTP id S1751262AbWDFT50 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Apr 2006 15:57:26 -0400
Subject: [PATCH 2.6.17-rc1-mm1] sched_domain-handle-kmalloc-failure-fix
From: Lee Schermerhorn <Lee.Schermerhorn@hp.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, Eric Whitney <eric.whitney@hp.com>
Content-Type: text/plain
Organization: HP/OSLO
Date: Thu, 06 Apr 2006 15:58:47 -0400
Message-Id: <1144353528.5162.190.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] sched_domain-handle-kmalloc-failure-fix

2.6.17-rc1-mm1 hangs during boot on HP rx8620 and dl585 -- both 4 node
NUMA platforms.  Problem is in build_sched_domains() setting up the
sched_group_nodes[] lists, resulting from patch:
sched_domain-handle-kmalloc-failure.patch

The referenced patch does not propagate the "next" pointer from the head
of the list, resulting in a loop between the last 2 groups in the list.
This causes a tight loop/hang in init_numa_sched_groups_power() because 
'sg->next' never == 'group_head' when you have > 2 nodes.

This patch seems to fix the problem.  

Signed-off-by:  Lee Schermerhorn <lee.schermerhorn@hp.com>

Index: linux-2.6.17-rc1-mm1/kernel/sched.c
===================================================================
--- linux-2.6.17-rc1-mm1.orig/kernel/sched.c	2006-04-06 15:18:32.000000000 -0400
+++ linux-2.6.17-rc1-mm1/kernel/sched.c	2006-04-06 15:20:49.000000000 -0400
@@ -6360,7 +6360,7 @@ static int build_sched_domains(const cpu
 			}
 			sg->cpu_power = 0;
 			sg->cpumask = tmp;
-			sg->next = prev;
+			sg->next = prev->next;
 			cpus_or(covered, covered, tmp);
 			prev->next = sg;
 			prev = sg;


