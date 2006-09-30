Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751421AbWI3WMn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751421AbWI3WMn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Sep 2006 18:12:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751425AbWI3WMn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Sep 2006 18:12:43 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:41951 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751421AbWI3WMm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Sep 2006 18:12:42 -0400
Date: Sun, 1 Oct 2006 00:05:05 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Eric Rannaud <eric.rannaud@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Linus Torvalds <torvalds@osdl.org>, nagar@watson.ibm.com
Subject: Re: BUG-lockdep and freeze (was: Arrr! Linux 2.6.18)
Message-ID: <20060930220505.GA19338@elte.hu>
References: <5f3c152b0609301220p7a487c7dw456d007298578cd7@mail.gmail.com> <20060930131310.0d6494e7.akpm@osdl.org> <5f3c152b0609301352w5bc52653s3e2a28e482c7d69e@mail.gmail.com> <20060930140426.37918062.akpm@osdl.org> <5f3c152b0609301500l52a4c6c5o2052b88621dc7ca3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5f3c152b0609301500l52a4c6c5o2052b88621dc7ca3@mail.gmail.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.8
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.8 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.5 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	-0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Eric Rannaud <eric.rannaud@gmail.com> wrote:

> On 9/30/06, Andrew Morton <akpm@osdl.org> wrote:
> >You could set CONFIG_UNWIND_INFO=n and CONFIG_STACK_UNWIND=n and reenable
> >lockdep.  That will a) tell us if there's some lockdep problem and b) will
> >give us a clearer look at any locking problems which your kernel is
> >detecting.
> 
> 
> All right. Here is the stacktrace I get with config
> CONFIG_UNWIND_INFO=n and CONFIG_STACK_UNWIND=n and v2.6.18 (all the
> rest being equal  http://engm.ath.cx/kernel/config-2.6.18). (and no
> freeze)

hm, does the patch below solve it? In general, lockdep warnings are 
intended to be non-fatal, so i have put in various practical limits on 
internal data structure failure modes. We havent had a /single/ 
lockdep-internal crash ever since lockdep went upstream [the unwinder 
crashes are outside of lockdep], and that's largely due to the good 
internal checks it does.

Recursion within the dependency graph is currently limited to 20, that's 
probably not enough on your box - this patch doubles it to 40. I have 
written the lockdep functions to have as small stackframes as possible, 
so 40 should be OK too. (The practical recursion limit should be 
somewhere between 100 and 200 entries. If we hit that then i'll change 
the algorithm to be iteration-based. Graph walking logic is so easy to 
program via recursion, so i'd like to keep recursion as long as 
possible.)

	Ingo

---------------->
Subject: lockdep: increase max allowed recursion depth
From: Ingo Molnar <mingo@elte.hu>

With lots of CPUs there can be lots of deep dependencies. Will change 
the algorithm to iteration-based if it gets too deep.

Signed-off-by: Ingo Molnar <mingo@elte.hu>
---
 kernel/lockdep.c |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

Index: linux/kernel/lockdep.c
===================================================================
--- linux.orig/kernel/lockdep.c
+++ linux/kernel/lockdep.c
@@ -575,6 +575,8 @@ static noinline int print_circular_bug_t
 	return 0;
 }
 
+#define RECURSION_LIMIT 40
+
 static int noinline print_infinite_recursion_bug(void)
 {
 	__raw_spin_unlock(&hash_lock);
@@ -595,7 +597,7 @@ check_noncircular(struct lock_class *sou
 	debug_atomic_inc(&nr_cyclic_check_recursions);
 	if (depth > max_recursion_depth)
 		max_recursion_depth = depth;
-	if (depth >= 20)
+	if (depth >= RECURSION_LIMIT)
 		return print_infinite_recursion_bug();
 	/*
 	 * Check this lock's dependency list:
@@ -645,7 +647,7 @@ find_usage_forwards(struct lock_class *s
 
 	if (depth > max_recursion_depth)
 		max_recursion_depth = depth;
-	if (depth >= 20)
+	if (depth >= RECURSION_LIMIT)
 		return print_infinite_recursion_bug();
 
 	debug_atomic_inc(&nr_find_usage_forwards_checks);
@@ -684,7 +686,7 @@ find_usage_backwards(struct lock_class *
 
 	if (depth > max_recursion_depth)
 		max_recursion_depth = depth;
-	if (depth >= 20)
+	if (depth >= RECURSION_LIMIT)
 		return print_infinite_recursion_bug();
 
 	debug_atomic_inc(&nr_find_usage_backwards_checks);
