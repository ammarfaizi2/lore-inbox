Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269693AbUICNpo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269693AbUICNpo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 09:45:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269694AbUICNpe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 09:45:34 -0400
Received: from mtagate4.de.ibm.com ([195.212.29.153]:48565 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP id S269693AbUICNpZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 09:45:25 -0400
Date: Fri, 3 Sep 2004 15:46:04 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: nickpiggin@yahoo.com.au, linux-kernel@vger.kernel.org
Subject: Bug in init_sched_build_groups?
Message-ID: <20040903134604.GA3374@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nick,
I stumbled over a problem in the sched_domain code in regard to
zSeries (s390). The problem seems to have been introduced by
ChangeSet 1.1837.3.11: [PATCH] sched: consolidate sched domains.
With z/VM it is possible to start with a small set of cpus and
later on add more if you need them. If I try to online one of
the "late" cpus the scheduler crashes in find_busiest group
because the sched_group for the late cpu is not in the linked
list of sched_groups (group->next is NULL at sched.c:4770).
I worked around that problem with the attached patch. Dunno if
this is the right way to do it but it works for me.

blue skies,
  Martin.

diffstat:
 kernel/sched.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -urN linux-2.6/kernel/sched.c linux-2.6-s390/kernel/sched.c
--- linux-2.6/kernel/sched.c	Fri Sep  3 15:26:17 2004
+++ linux-2.6-s390/kernel/sched.c	Fri Sep  3 15:26:26 2004
@@ -4358,7 +4358,7 @@
 	cpumask_t covered = CPU_MASK_NONE;
 	int i;
 
-	for_each_cpu_mask(i, span) {
+	for_each_cpu_mask(i, cpu_possible_map) {
 		int group = group_fn(i);
 		struct sched_group *sg = &groups[group];
 		int j;
