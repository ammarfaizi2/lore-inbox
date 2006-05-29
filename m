Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751344AbWE2VZF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751344AbWE2VZF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 May 2006 17:25:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751348AbWE2VZA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 May 2006 17:25:00 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:37304 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751337AbWE2VY4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 May 2006 17:24:56 -0400
Date: Mon, 29 May 2006 23:25:14 +0200
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Arjan van de Ven <arjan@infradead.org>, Andrew Morton <akpm@osdl.org>
Subject: [patch 25/61] lock validator: design docs
Message-ID: <20060529212514.GY3155@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060529212109.GA2058@elte.hu>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ingo Molnar <mingo@elte.hu>

lock validator design documentation.

Signed-off-by: Ingo Molnar <mingo@elte.hu>
Signed-off-by: Arjan van de Ven <arjan@linux.intel.com>
---
 Documentation/lockdep-design.txt |  224 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 224 insertions(+)

Index: linux/Documentation/lockdep-design.txt
===================================================================
--- /dev/null
+++ linux/Documentation/lockdep-design.txt
@@ -0,0 +1,224 @@
+Runtime locking correctness validator
+=====================================
+
+started by Ingo Molnar <mingo@redhat.com>
+additions by Arjan van de Ven <arjan@linux.intel.com>
+
+Lock-type
+---------
+
+The basic object the validator operates upon is the 'type' or 'class' of
+locks.
+
+A class of locks is a group of locks that are logically the same with
+respect to locking rules, even if the locks may have multiple (possibly
+tens of thousands of) instantiations. For example a lock in the inode
+struct is one class, while each inode has its own instantiation of that
+lock class.
+
+The validator tracks the 'state' of lock-types, and it tracks
+dependencies between different lock-types. The validator maintains a
+rolling proof that the state and the dependencies are correct.
+
+Unlike an lock instantiation, the lock-type itself never goes away: when
+a lock-type is used for the first time after bootup it gets registered,
+and all subsequent uses of that lock-type will be attached to this
+lock-type.
+
+State
+-----
+
+The validator tracks lock-type usage history into 5 separate state bits:
+
+- 'ever held in hardirq context'                    [ == hardirq-safe   ]
+- 'ever held in softirq context'                    [ == softirq-safe   ]
+- 'ever held with hardirqs enabled'                 [ == hardirq-unsafe ]
+- 'ever held with softirqs and hardirqs enabled'    [ == softirq-unsafe ]
+
+- 'ever used'                                       [ == !unused        ]
+
+Single-lock state rules:
+------------------------
+
+A softirq-unsafe lock-type is automatically hardirq-unsafe as well. The
+following states are exclusive, and only one of them is allowed to be
+set for any lock-type:
+
+ <hardirq-safe> and <hardirq-unsafe>
+ <softirq-safe> and <softirq-unsafe>
+
+The validator detects and reports lock usage that violate these
+single-lock state rules.
+
+Multi-lock dependency rules:
+----------------------------
+
+The same lock-type must not be acquired twice, because this could lead
+to lock recursion deadlocks.
+
+Furthermore, two locks may not be taken in different order:
+
+ <L1> -> <L2>
+ <L2> -> <L1>
+
+because this could lead to lock inversion deadlocks. (The validator
+finds such dependencies in arbitrary complexity, i.e. there can be any
+other locking sequence between the acquire-lock operations, the
+validator will still track all dependencies between locks.)
+
+Furthermore, the following usage based lock dependencies are not allowed
+between any two lock-types:
+
+   <hardirq-safe>   ->  <hardirq-unsafe>
+   <softirq-safe>   ->  <softirq-unsafe>
+
+The first rule comes from the fact the a hardirq-safe lock could be
+taken by a hardirq context, interrupting a hardirq-unsafe lock - and
+thus could result in a lock inversion deadlock. Likewise, a softirq-safe
+lock could be taken by an softirq context, interrupting a softirq-unsafe
+lock.
+
+The above rules are enforced for any locking sequence that occurs in the
+kernel: when acquiring a new lock, the validator checks whether there is
+any rule violation between the new lock and any of the held locks.
+
+When a lock-type changes its state, the following aspects of the above
+dependency rules are enforced:
+
+- if a new hardirq-safe lock is discovered, we check whether it
+  took any hardirq-unsafe lock in the past.
+
+- if a new softirq-safe lock is discovered, we check whether it took
+  any softirq-unsafe lock in the past.
+
+- if a new hardirq-unsafe lock is discovered, we check whether any
+  hardirq-safe lock took it in the past.
+
+- if a new softirq-unsafe lock is discovered, we check whether any
+  softirq-safe lock took it in the past.
+
+(Again, we do these checks too on the basis that an interrupt context
+could interrupt _any_ of the irq-unsafe or hardirq-unsafe locks, which
+could lead to a lock inversion deadlock - even if that lock scenario did
+not trigger in practice yet.)
+
+Exception 1: Nested data types leading to nested locking
+--------------------------------------------------------
+
+There are a few cases where the Linux kernel acquires more than one
+instance of the same lock-type. Such cases typically happen when there
+is some sort of hierarchy within objects of the same type. In these
+cases there is an inherent "natural" ordering between the two objects
+(defined by the properties of the hierarchy), and the kernel grabs the
+locks in this fixed order on each of the objects.
+
+An example of such an object hieararchy that results in "nested locking"
+is that of a "whole disk" block-dev object and a "partition" block-dev
+object; the partition is "part of" the whole device and as long as one
+always takes the whole disk lock as a higher lock than the partition
+lock, the lock ordering is fully correct. The validator does not
+automatically detect this natural ordering, as the locking rule behind
+the ordering is not static.
+
+In order to teach the validator about this correct usage model, new
+versions of the various locking primitives were added that allow you to
+specify a "nesting level". An example call, for the block device mutex,
+looks like this:
+
+enum bdev_bd_mutex_lock_type
+{
+       BD_MUTEX_NORMAL,
+       BD_MUTEX_WHOLE,
+       BD_MUTEX_PARTITION
+};
+
+ mutex_lock_nested(&bdev->bd_contains->bd_mutex, BD_MUTEX_PARTITION);
+
+In this case the locking is done on a bdev object that is known to be a
+partition.
+
+The validator treats a lock that is taken in such a nested fasion as a
+separate (sub)class for the purposes of validation.
+
+Note: When changing code to use the _nested() primitives, be careful and
+check really thoroughly that the hiearchy is correctly mapped; otherwise
+you can get false positives or false negatives.
+
+Exception 2: Out of order unlocking
+-----------------------------------
+
+In the Linux kernel, locks are released in the opposite order in which
+they were taken, with a few exceptions. The validator is optimized for
+the common case, and in fact treats an "out of order" unlock as a
+locking bug. (the rationale is that the code is doing something rare,
+which can be a sign of a bug)
+
+There are some cases where releasing the locks out of order is
+unavoidable and dictated by the algorithm that is being implemented.
+Therefore, the validator can be told about this, using a special
+unlocking variant of the primitives. An example call looks like this:
+
+ spin_unlock_non_nested(&target->d_lock);
+
+Here the d_lock is released by the VFS in a different order than it was
+taken, as required by the d_move() algorithm.
+
+Note: the _non_nested() primitives are more expensive than the "normal"
+primitives, and in almost all cases it's trivial to use the natural
+unlock order. There are gains in doing this that are outside the realm
+of the validator regardless so it's strongly suggested to make sure that
+unlocking always happens in the natural order whenever reasonable,
+rather than blindly changing code to use the _non_nested() variants.
+
+Proof of 100% correctness:
+--------------------------
+
+The validator achieves perfect, mathematical 'closure' (proof of locking
+correctness) in the sense that for every simple, standalone single-task
+locking sequence that occured at least once during the lifetime of the
+kernel, the validator proves it with a 100% certainty that no
+combination and timing of these locking sequences can cause any type of
+lock related deadlock. [*]
+
+I.e. complex multi-CPU and multi-task locking scenarios do not have to
+occur in practice to prove a deadlock: only the simple 'component'
+locking chains have to occur at least once (anytime, in any
+task/context) for the validator to be able to prove correctness. (For
+example, complex deadlocks that would normally need more than 3 CPUs and
+a very unlikely constellation of tasks, irq-contexts and timings to
+occur, can be detected on a plain, lightly loaded single-CPU system as
+well!)
+
+This radically decreases the complexity of locking related QA of the
+kernel: what has to be done during QA is to trigger as many "simple"
+single-task locking dependencies in the kernel as possible, at least
+once, to prove locking correctness - instead of having to trigger every
+possible combination of locking interaction between CPUs, combined with
+every possible hardirq and softirq nesting scenario (which is impossible
+to do in practice).
+
+[*] assuming that the validator itself is 100% correct, and no other
+    part of the system corrupts the state of the validator in any way.
+    We also assume that all NMI/SMM paths [which could interrupt
+    even hardirq-disabled codepaths] are correct and do not interfere
+    with the validator. We also assume that the 64-bit 'chain hash'
+    value is unique for every lock-chain in the system. Also, lock
+    recursion must not be higher than 20.
+
+Performance:
+------------
+
+The above rules require _massive_ amounts of runtime checking. If we did
+that for every lock taken and for every irqs-enable event, it would
+render the system practically unusably slow. The complexity of checking
+is O(N^2), so even with just a few hundred lock-types we'd have to do
+tens of thousands of checks for every event.
+
+This problem is solved by checking any given 'locking scenario' (unique
+sequence of locks taken after each other) only once. A simple stack of
+held locks is maintained, and a lightweight 64-bit hash value is
+calculated, which hash is unique for every lock chain. The hash value,
+when the chain is validated for the first time, is then put into a hash
+table, which hash-table can be checked in a lockfree manner. If the
+locking chain occurs again later on, the hash table tells us that we
+dont have to validate the chain again.
