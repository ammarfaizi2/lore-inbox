Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752593AbWKQS6R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752593AbWKQS6R (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 13:58:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755685AbWKQS6R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 13:58:17 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:12266 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1752261AbWKQS6Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 13:58:16 -0500
Date: Fri, 17 Nov 2006 19:57:22 +0100
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Steven Rostedt <srostedt@redhat.com>
Subject: [patch] lockdep: fix static keys in module-allocated percpu areas
Message-ID: <20061117185720.GA14689@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.2i
X-ELTE-SpamScore: -3.7
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-3.7 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_40 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	-1.1 BAYES_40               BODY: Bayesian spam probability is 20 to 40%
	[score: 0.2748]
	0.7 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Subject: [patch] lockdep: fix static keys in module-allocated percpu areas
From: Ingo Molnar <mingo@elte.hu>

lockdep got confused by certain locks in modules:

 INFO: trying to register non-static key.
 the code is fine but needs lockdep annotation.
 turning off the locking correctness validator.

 Call Trace:
  [<ffffffff8026f40d>] dump_trace+0xaa/0x3f2
  [<ffffffff8026f78f>] show_trace+0x3a/0x60
  [<ffffffff8026f9d1>] dump_stack+0x15/0x17
  [<ffffffff802abfe8>] __lock_acquire+0x724/0x9bb
  [<ffffffff802ac52b>] lock_acquire+0x4d/0x67
  [<ffffffff80267139>] rt_spin_lock+0x3d/0x41
  [<ffffffff8839ed3f>] :ip_conntrack:__ip_ct_refresh_acct+0x131/0x174
  [<ffffffff883a1334>] :ip_conntrack:udp_packet+0xbf/0xcf
  [<ffffffff8839f9af>] :ip_conntrack:ip_conntrack_in+0x394/0x4a7
  [<ffffffff8023551f>] nf_iterate+0x41/0x7f
  [<ffffffff8025946a>] nf_hook_slow+0x64/0xd5
  [<ffffffff802369a2>] ip_rcv+0x24e/0x506
  [...]

Steven Rostedt found the bug: static_obj() check did not take
PERCPU_ENOUGH_ROOM into account, so in-module DEFINE_PER_CPU-area locks 
were triggering this message.

Signed-off-by: Ingo Molnar <mingo@elte.hu>
Signed-off-by: Steven Rostedt <srostedt@redhat.com>
---
 kernel/lockdep.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

Index: linux/kernel/lockdep.c
===================================================================
--- linux.orig/kernel/lockdep.c
+++ linux/kernel/lockdep.c
@@ -1083,7 +1083,8 @@ static int static_obj(void *obj)
 	 */
 	for_each_possible_cpu(i) {
 		start = (unsigned long) &__per_cpu_start + per_cpu_offset(i);
-		end   = (unsigned long) &__per_cpu_end   + per_cpu_offset(i);
+		end   = (unsigned long) &__per_cpu_start + PERCPU_ENOUGH_ROOM
+					+ per_cpu_offset(i);
 
 		if ((addr >= start) && (addr < end))
 			return 1;
