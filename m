Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1761299AbWLIACl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761299AbWLIACl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Dec 2006 19:02:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1947549AbWLIACI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 19:02:08 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:37656 "EHLO
	sous-sol.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1947540AbWLIABu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 19:01:50 -0500
Message-Id: <20061209000303.850378000@sous-sol.org>
References: <20061208235751.890503000@sous-sol.org>
User-Agent: quilt/0.45-1
Date: Fri, 08 Dec 2006 15:58:20 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org, torvalds@osdl.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, zach@vmware.com, mingo@elte.hu,
       caglar@pardus.org.tr
Subject: [patch 29/32] softirq: remove BUG_ONs which can incorrectly trigger
Content-Disposition: inline; filename=softirq-remove-bug_ons-which-can-incorrectly-trigger.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

From: Zachary Amsden <zach@vmware.com>

It is possible to have tasklets get scheduled before softirqd has had a chance
to spawn on all CPUs.  This is totally harmless; after success during action
CPU_UP_PREPARE, action CPU_ONLINE will be called, which immediately wakes
softirqd on the appropriate CPU to process the already pending tasklets.  So
there is no danger of having a missed wakeup for any tasklets that were
already pending.

In particular, i386 is affected by this during startup, and is visible when
using a very large initrd; during the time it takes for the initrd to be
decompressed, a timer IRQ can come in and schedule RCU callbacks.  It is also
possible that resending of a hardware IRQ via a softirq triggers the same bug.

Because of different timing conditions, this shows up in all emulators and
virtual machines tested, including Xen, VMware, Virtual PC, and Qemu.  It is
also possible to trigger on native hardware with a large enough initrd,
although I don't have a reliable case demonstrating that.

Signed-off-by: Zachary Amsden <zach@vmware.com>
Cc: <caglar@pardus.org.tr>
Cc: Ingo Molnar <mingo@elte.hu>
Cc: <stable@kernel.org>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
---

 kernel/softirq.c |    2 --
 1 file changed, 2 deletions(-)

--- linux-2.6.19.orig/kernel/softirq.c
+++ linux-2.6.19/kernel/softirq.c
@@ -574,8 +574,6 @@ static int __cpuinit cpu_callback(struct
 
 	switch (action) {
 	case CPU_UP_PREPARE:
-		BUG_ON(per_cpu(tasklet_vec, hotcpu).list);
-		BUG_ON(per_cpu(tasklet_hi_vec, hotcpu).list);
 		p = kthread_create(ksoftirqd, hcpu, "ksoftirqd/%d", hotcpu);
 		if (IS_ERR(p)) {
 			printk("ksoftirqd for %i failed\n", hotcpu);

--
