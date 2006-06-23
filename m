Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932926AbWFWHyb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932926AbWFWHyb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 03:54:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932925AbWFWHyb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 03:54:31 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:46761 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932926AbWFWHya (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 03:54:30 -0400
Date: Fri, 23 Jun 2006 09:49:29 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-mm1: kernel/lockdep.c: write-only variables
Message-ID: <20060623074929.GA30406@elte.hu>
References: <20060621034857.35cfe36f.akpm@osdl.org> <20060622155230.GG9111@stusta.de> <20060623072656.GC29321@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060623072656.GC29321@elte.hu>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5004]
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Ingo Molnar <mingo@elte.hu> wrote:

> 
> * Adrian Bunk <bunk@stusta.de> wrote:
> 
> > The following variables in kernel/lockdep.c are write-only:
> >   nr_hardirq_read_safe_locks
> >   nr_hardirq_read_unsafe_locks
> >   nr_hardirq_safe_locks
> >   nr_hardirq_unsafe_locks
> >   nr_softirq_read_safe_locks
> >   nr_softirq_read_unsafe_locks
> >   nr_softirq_safe_locks
> >   nr_softirq_unsafe_locks
> > 
> > Is a usage pending or should they be removed?
> 
> they are stale - i'll remove them. (there's a new calculation method 
> for them)

the patch is below. (Andrew, please dont apply this one - will be part 
of another patchset)

	Ingo

---
 kernel/lockdep.c           |   16 ----------------
 kernel/lockdep_internals.h |    8 --------
 2 files changed, 24 deletions(-)

Index: linux/kernel/lockdep.c
===================================================================
--- linux.orig/kernel/lockdep.c
+++ linux/kernel/lockdep.c
@@ -271,14 +271,6 @@ atomic_t softirqs_off_events;
 atomic_t redundant_softirqs_on;
 atomic_t redundant_softirqs_off;
 atomic_t nr_unused_locks;
-atomic_t nr_hardirq_safe_locks;
-atomic_t nr_softirq_safe_locks;
-atomic_t nr_hardirq_unsafe_locks;
-atomic_t nr_softirq_unsafe_locks;
-atomic_t nr_hardirq_read_safe_locks;
-atomic_t nr_softirq_read_safe_locks;
-atomic_t nr_hardirq_read_unsafe_locks;
-atomic_t nr_softirq_read_unsafe_locks;
 atomic_t nr_cyclic_checks;
 atomic_t nr_cyclic_check_recursions;
 atomic_t nr_find_usage_forwards_checks;
@@ -1640,7 +1632,6 @@ static int mark_lock(struct task_struct 
 				LOCK_ENABLED_HARDIRQS_READ, "hard-read"))
 			return 0;
 #endif
-		debug_atomic_inc(&nr_hardirq_safe_locks);
 		if (hardirq_verbose(this->type))
 			ret = 2;
 		break;
@@ -1666,7 +1657,6 @@ static int mark_lock(struct task_struct 
 				LOCK_ENABLED_SOFTIRQS_READ, "soft-read"))
 			return 0;
 #endif
-		debug_atomic_inc(&nr_softirq_safe_locks);
 		if (softirq_verbose(this->type))
 			ret = 2;
 		break;
@@ -1680,7 +1670,6 @@ static int mark_lock(struct task_struct 
 		if (!check_usage_forwards(curr, this,
 					  LOCK_ENABLED_HARDIRQS, "hard"))
 			return 0;
-		debug_atomic_inc(&nr_hardirq_read_safe_locks);
 		if (hardirq_verbose(this->type))
 			ret = 2;
 		break;
@@ -1694,7 +1683,6 @@ static int mark_lock(struct task_struct 
 		if (!check_usage_forwards(curr, this,
 					  LOCK_ENABLED_SOFTIRQS, "soft"))
 			return 0;
-		debug_atomic_inc(&nr_softirq_read_safe_locks);
 		if (softirq_verbose(this->type))
 			ret = 2;
 		break;
@@ -1721,7 +1709,6 @@ static int mark_lock(struct task_struct 
 				   LOCK_USED_IN_HARDIRQ_READ, "hard-read"))
 			return 0;
 #endif
-		debug_atomic_inc(&nr_hardirq_unsafe_locks);
 		if (hardirq_verbose(this->type))
 			ret = 2;
 		break;
@@ -1748,7 +1735,6 @@ static int mark_lock(struct task_struct 
 				   LOCK_USED_IN_SOFTIRQ_READ, "soft-read"))
 			return 0;
 #endif
-		debug_atomic_inc(&nr_softirq_unsafe_locks);
 		if (softirq_verbose(this->type))
 			ret = 2;
 		break;
@@ -1764,7 +1750,6 @@ static int mark_lock(struct task_struct 
 					   LOCK_USED_IN_HARDIRQ, "hard"))
 			return 0;
 #endif
-		debug_atomic_inc(&nr_hardirq_read_unsafe_locks);
 		if (hardirq_verbose(this->type))
 			ret = 2;
 		break;
@@ -1780,7 +1765,6 @@ static int mark_lock(struct task_struct 
 					   LOCK_USED_IN_SOFTIRQ, "soft"))
 			return 0;
 #endif
-		debug_atomic_inc(&nr_softirq_read_unsafe_locks);
 		if (softirq_verbose(this->type))
 			ret = 2;
 		break;
Index: linux/kernel/lockdep_internals.h
===================================================================
--- linux.orig/kernel/lockdep_internals.h
+++ linux/kernel/lockdep_internals.h
@@ -69,14 +69,6 @@ extern atomic_t softirqs_off_events;
 extern atomic_t redundant_softirqs_on;
 extern atomic_t redundant_softirqs_off;
 extern atomic_t nr_unused_locks;
-extern atomic_t nr_hardirq_safe_locks;
-extern atomic_t nr_softirq_safe_locks;
-extern atomic_t nr_hardirq_unsafe_locks;
-extern atomic_t nr_softirq_unsafe_locks;
-extern atomic_t nr_hardirq_read_safe_locks;
-extern atomic_t nr_softirq_read_safe_locks;
-extern atomic_t nr_hardirq_read_unsafe_locks;
-extern atomic_t nr_softirq_read_unsafe_locks;
 extern atomic_t nr_cyclic_checks;
 extern atomic_t nr_cyclic_check_recursions;
 extern atomic_t nr_find_usage_forwards_checks;
