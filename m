Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751311AbWE2VUy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751311AbWE2VUy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 May 2006 17:20:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751312AbWE2VUy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 May 2006 17:20:54 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:40642 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751311AbWE2VUx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 May 2006 17:20:53 -0400
Date: Mon, 29 May 2006 23:21:09 +0200
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Arjan van de Ven <arjan@infradead.org>, Andrew Morton <akpm@osdl.org>
Subject: [patch 00/61] ANNOUNCE: lock validator -V1
Message-ID: <20060529212109.GA2058@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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

We are pleased to announce the first release of the "lock dependency 
correctness validator" kernel debugging feature, which can be downloaded 
from:

  http://redhat.com/~mingo/lockdep-patches/

The easiest way to try lockdep on a testbox is to apply the combo patch 
to 2.6.17-rc4-mm3. The patch order is:

  http://kernel.org/pub/linux/kernel/v2.6/testing/linux-2.6.17-rc4.tar.bz2
  http://kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.17-rc4/2.6.17-rc4-mm3/2.6.17-rc4-mm3.bz2
  http://redhat.com/~mingo/lockdep-patches/lockdep-combo.patch

do 'make oldconfig' and accept all the defaults for new config options - 
reboot into the kernel and if everything goes well it should boot up 
fine and you should have /proc/lockdep and /proc/lockdep_stats files.

Typically if the lock validator finds some problem it will print out 
voluminous debug output that begins with "BUG: ..." and which syslog 
output can be used by kernel developers to figure out the precise 
locking scenario.

What does the lock validator do? It "observes" and maps all locking 
rules as they occur dynamically (as triggered by the kernel's natural 
use of spinlocks, rwlocks, mutexes and rwsems). Whenever the lock 
validator subsystem detects a new locking scenario, it validates this 
new rule against the existing set of rules. If this new rule is 
consistent with the existing set of rules then the new rule is added 
transparently and the kernel continues as normal. If the new rule could 
create a deadlock scenario then this condition is printed out.

When determining validity of locking, all possible "deadlock scenarios" 
are considered: assuming arbitrary number of CPUs, arbitrary irq context 
and task context constellations, running arbitrary combinations of all 
the existing locking scenarios. In a typical system this means millions 
of separate scenarios. This is why we call it a "locking correctness" 
validator - for all rules that are observed the lock validator proves it 
with mathematical certainty that a deadlock could not occur (assuming 
that the lock validator implementation itself is correct and its 
internal data structures are not corrupted by some other kernel 
subsystem). [see more details and conditionals of this statement in 
include/linux/lockdep.h and Documentation/lockdep-design.txt]

Furthermore, this "all possible scenarios" property of the validator 
also enables the finding of complex, highly unlikely multi-CPU 
multi-context races via single single-context rules, increasing the 
likelyhood of finding bugs drastically. In practical terms: the lock 
validator already found a bug in the upstream kernel that could only 
occur on systems with 3 or more CPUs, and which needed 3 very unlikely 
code sequences to occur at once on the 3 CPUs. That bug was found and 
reported on a single-CPU system (!). So in essence a race will be found 
"piecemail-wise", triggering all the necessary components for the race, 
without having to reproduce the race scenario itself! In its short 
existence the lock validator found and reported many bugs before they 
actually caused a real deadlock.

To further increase the efficiency of the validator, the mapping is not 
per "lock instance", but per "lock-type". For example, all struct inode 
objects in the kernel have inode->inotify_mutex. If there are 10,000 
inodes cached, then there are 10,000 lock objects. But ->inotify_mutex 
is a single "lock type", and all locking activities that occur against 
->inotify_mutex are "unified" into this single lock-type. The advantage 
of the lock-type approach is that all historical ->inotify_mutex uses 
are mapped into a single (and as narrow as possible) set of locking 
rules - regardless of how many different tasks or inode structures it 
took to build this set of rules. The set of rules persist during the 
lifetime of the kernel.

To see the rough magnitude of checking that the lock validator does, 
here's a portion of /proc/lockdep_stats, fresh after bootup:

 lock-types:                            694 [max: 2048]
 direct dependencies:                  1598 [max: 8192]
 indirect dependencies:               17896
 all direct dependencies:             16206
 dependency chains:                    1910 [max: 8192]
 in-hardirq chains:                      17
 in-softirq chains:                     105
 in-process chains:                    1065
 stack-trace entries:                 38761 [max: 131072]
 combined max dependencies:         2033928
 hardirq-safe locks:                     24
 hardirq-unsafe locks:                  176
 softirq-safe locks:                     53
 softirq-unsafe locks:                  137
 irq-safe locks:                         59
 irq-unsafe locks:                      176

The lock validator has observed 1598 actual single-thread locking 
patterns, and has validated all possible 2033928 distinct locking 
scenarios.

More details about the design of the lock validator can be found in 
Documentation/lockdep-design.txt, which can also found at:

   http://redhat.com/~mingo/lockdep-patches/lockdep-design.txt

The patchqueue consists of 61 patches, and the changes are quite 
extensive:

 215 files changed, 7693 insertions(+), 1247 deletions(-)

So be careful when testing.

We only plan to post the queue to lkml this time, we'll try to not flood 
lkml with future releases. The finegrained patch-queue can be also seen 
at:

  http://redhat.com/~mingo/lockdep-patches/patches/

(the series file, with explanations about splitup categories of the 
patches can be found attached below.)

The lock validator has been build-tested with allyesconfig, and booted 
on x86 and x86_64. (Other architectures probably dont build/work yet.)

Comments, test-results, bug fixes, and improvements are welcome!

	Ingo


# locking fixes (for bugs found by lockdep), not yet in mainline or -mm:

floppy-release-fix.patch
forcedeth-deadlock-fix.patch

# fixes for upstream that only triggers on lockdep:

sound_oss_emu10k1_midi-fix.patch
mutex-section-bug.patch

# locking subsystem debugging improvements:

warn-once.patch
add-module-address.patch

generic-lock-debugging.patch
locking-selftests.patch

spinlock-init-cleanups.patch
lock-init-improvement.patch
xfs-improve-mrinit-macro.patch

# stacktrace:

x86_64-beautify-stack-backtrace.patch
x86_64-document-stack-backtrace.patch
stacktrace.patch

x86_64-use-stacktrace-for-backtrace.patch

# irq-flags state tracing:

lockdep-fown-fixes.patch
lockdep-sk-callback-lock-fixes.patch
trace-irqflags.patch
trace-irqflags-cleanups-x86.patch
trace-irqflags-cleanups-x86_64.patch
local-irq-enable-in-hardirq.patch

# percpu subsystem feature needed for lockdep:

add-per-cpu-offset.patch

# lockdep subsystem core bits:

lockdep-core.patch
lockdep-proc.patch
lockdep-docs.patch

# make use of lockdep in locking subsystems:

lockdep-prove-rwsems.patch
lockdep-prove-spin_rwlocks.patch
lockdep-prove-mutexes.patch

# lockdep utility patches:

lockdep-print-types-in-sysrq.patch
lockdep-x86_64-early-init.patch
lockdep-i386-alternatives-off.patch
lockdep-printk-recursion.patch
lockdep-disable-nmi-watchdog.patch

# map all the locking details and quirks to lockdep:

lockdep-blockdev.patch
lockdep-direct-io.patch
lockdep-serial.patch
lockdep-dcache.patch
lockdep-namei.patch
lockdep-super.patch
lockdep-futex.patch
lockdep-genirq.patch
lockdep-kgdb.patch
lockdep-completions.patch
lockdep-waitqueue.patch
lockdep-mm.patch
lockdep-slab.patch

lockdep-skb_queue_head_init.patch
lockdep-timer.patch
lockdep-sched.patch
lockdep-hrtimer.patch
lockdep-sock.patch
lockdep-af_unix.patch
lockdep-lock_sock.patch
lockdep-mmap_sem.patch

lockdep-prune_dcache-workaround.patch
lockdep-jbd.patch
lockdep-posix-timers.patch
lockdep-sch_generic.patch
lockdep-xfrm.patch
lockdep-sound-seq-ports.patch

lockdep-enable-Kconfig.patch
