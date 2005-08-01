Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262191AbVHALif@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262191AbVHALif (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Aug 2005 07:38:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262192AbVHALie
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Aug 2005 07:38:34 -0400
Received: from mx2.elte.hu ([157.181.151.9]:35556 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S262191AbVHALib (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Aug 2005 07:38:31 -0400
Date: Mon, 1 Aug 2005 13:39:13 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: Martin Hicks <mort@sgi.com>, Linus Torvalds <torvalds@osdl.org>,
       linux-kernel@vger.kernel.org, Andi Kleen <ak@suse.de>
Subject: [patch] remove sys_set_zone_reclaim()
Message-ID: <20050801113913.GA7000@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


the patch below removes sys_set_zone_reclaim() for now. While i'm sure 
Martin is trying to solve a real problem, we must not hard-code an 
incomplete and insufficient approach into a syscall, because syscalls 
are pretty much for eternity. I am quite strongly convinced that this 
syscall must not hit v2.6.13 in its current form.

Firstly, the syscall lacks basic syscall design: e.g. it allows the 
global setting of VM policy for unprivileged users. (!) [ Imagine an 
Oracle installation and a SAP installation on the same NUMA box fighting 
over the 'optimal' setting for this flag. What will they do? Will they 
try to set the flag to their own preferred value every second or so? ]

Secondly, it was added based on a single datapoint from Martin:

 http://marc.theaimsgroup.com/?l=linux-mm&m=111763597218177&w=2

where Martin characterizes the numbers the following way:

 ' Run-to-run variability for "make -j" is huge, so these numbers aren't 
   terribly useful except to see that with reclaim the benchmark still 
   finishes in a reasonable amount of time. '

in other words: the fundamental problem has likely not been solved, only 
a tendential move into the right direction has been observed, and a 
handful of numbers were picked out of a set of hugely variable results, 
without showing the variability data. How much variance is there 
run-to-run?

I'd really suggest to first walk the walk and see what's needed to get 
stable & predictable kernel compilation numbers on that NUMA box, before 
adding random syscalls to tune a particular aspect of the VM ... which 
approach might not even matter once the whole picture has been analyzed 
and understood!

The third, most important point is that the syscall exposes VM tuning 
internals in a completely unstructured way. What sense does it make to 
have a _GLOBAL_ per-node setting for 'should we go to another node for 
reclaim'? If then it might make sense to do this per-app, via numalib or 
so.

the patch below is minimalistic in that it doesnt remove the syscall and 
the underlying infrastructure changes, only the user-visible changes. We 
could perhaps add a CAP_SYS_ADMIN-only sysctl for this hack, a'ka 
/proc/sys/vm/swappiness, but even that looks quite counterproductive 
when the generic approach is that we are trying to reduce the number of 
external factors in the VM balance picture.

	Ingo

Signed-off-by: Ingo Molnar <mingo@elte.hu>

 arch/i386/kernel/syscall_table.S |    2 +-
 arch/ia64/kernel/entry.S         |    2 +-
 kernel/sys_ni.c                  |    1 -
 3 files changed, 2 insertions(+), 3 deletions(-)

Index: linux-sched-curr/arch/i386/kernel/syscall_table.S
===================================================================
--- linux-sched-curr.orig/arch/i386/kernel/syscall_table.S
+++ linux-sched-curr/arch/i386/kernel/syscall_table.S
@@ -251,7 +251,7 @@ ENTRY(sys_call_table)
 	.long sys_io_submit
 	.long sys_io_cancel
 	.long sys_fadvise64	/* 250 */
-	.long sys_set_zone_reclaim
+	.long sys_ni_syscall
 	.long sys_exit_group
 	.long sys_lookup_dcookie
 	.long sys_epoll_create
Index: linux-sched-curr/arch/ia64/kernel/entry.S
===================================================================
--- linux-sched-curr.orig/arch/ia64/kernel/entry.S
+++ linux-sched-curr/arch/ia64/kernel/entry.S
@@ -1573,7 +1573,7 @@ sys_call_table:
 	data8 sys_keyctl
 	data8 sys_ioprio_set
 	data8 sys_ioprio_get			// 1275
-	data8 sys_set_zone_reclaim
+	data8 sys_ni_syscall
 	data8 sys_inotify_init
 	data8 sys_inotify_add_watch
 	data8 sys_inotify_rm_watch
Index: linux-sched-curr/kernel/sys_ni.c
===================================================================
--- linux-sched-curr.orig/kernel/sys_ni.c
+++ linux-sched-curr/kernel/sys_ni.c
@@ -79,7 +79,6 @@ cond_syscall(sys_request_key);
 cond_syscall(sys_keyctl);
 cond_syscall(compat_sys_keyctl);
 cond_syscall(compat_sys_socketcall);
-cond_syscall(sys_set_zone_reclaim);
 cond_syscall(sys_inotify_init);
 cond_syscall(sys_inotify_add_watch);
 cond_syscall(sys_inotify_rm_watch);
