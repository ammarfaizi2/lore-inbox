Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265493AbUFOPEC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265493AbUFOPEC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jun 2004 11:04:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265681AbUFOPEC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jun 2004 11:04:02 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.106]:59107 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S265493AbUFOPCl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jun 2004 11:02:41 -0400
Date: Tue, 15 Jun 2004 08:02:15 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Ingo Molnar <mingo@elte.hu>, Con Kolivas <kernel@kolivas.org>
cc: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
       Nick Piggin <piggin@cyberone.com.au>, Andrew Morton <akpm@osdl.org>,
       William Lee Irwin III <wli@holomorphy.com>,
       Linus Torvalds <torvalds@osdl.org>, markw@osdl.org
Subject: Re: [PATCH] Performance regression in 2.6.7-rc3
Message-ID: <30410000.1087311734@[10.10.2.4]>
In-Reply-To: <20040615045616.GA2006@elte.hu>
References: <200406121028.06812.kernel@kolivas.org> <20040615045616.GA2006@elte.hu>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Well, I found where at least half my regression on kernel compiles came 
from. It's sched_balance_context. Which makes no sense to me ... given 
that it seems to switch on CLONE_VM, and otherwise make no changes.
But I went and double-checked my results ... so ... confused.

The patch adds find_idlest_cpu and wake_up_forked_thread, but
otherwise just seems to do:

-               if (!(clone_flags & CLONE_STOPPED))
-                       wake_up_forked_process(p);      /* do this last */
-               else
+               if (!(clone_flags & CLONE_STOPPED)) {
+                       /*
+                        * Do the wakeup last. On SMP we treat fork() and
+                        * CLONE_VM separately, because fork() has already
+                        * created cache footprint on this CPU (due to
+                        * copying the pagetables), hence migration would
+                        * probably be costy. Threads on the other hand
+                        * have less traction to the current CPU, and if
+                        * there's an imbalance then the scheduler can
+                        * migrate this fresh thread now, before it
+                        * accumulates a larger cache footprint:
+                        */
+                       if (clone_flags & CLONE_VM)
+                               wake_up_forked_thread(p);
+                       else
+                               wake_up_forked_process(p);
+               } else
                        p->state = TASK_STOPPED;
                ++total_forks;

How the hell can that have any effect on non-threaded workloads? Perhaps
some part of kernel compile *is* multi-threaded. It does seem to get 
called somehow ... from the profile:

129 find_idlest_cpu
83 wake_up_forked_thread

Here's the diffprofile between the two:


      5835     4.0% total
      1100    27.1% __copy_from_user_ll
       627     3.6% do_anonymous_page
       363     6.8% page_add_rmap
       357    79.5% strnlen_user
       338    43.3% finish_task_switch
       308  3080.0% flush_signal_handlers
       272     7.0% zap_pte_range
       239     2.1% page_remove_rmap
       230    16.9% free_hot_cold_page
       224     9.7% buffered_rmqueue
       196    44.9% pte_alloc_one
       171    40.4% copy_process
       162   450.0% complete
       155     9.2% do_no_page
       147    19.5% set_page_dirty
       133    17.9% clear_page_tables
       131    13.8% do_wp_page
       129     0.0% find_idlest_cpu
       121     3.4% find_trylock_page
...
      -113    -7.0% atomic_dec_and_lock
     -1062    -2.2% default_idle

Which looks to me just like worse task affinity.

I still think balance on clone is the wrong thing to do by default. On
anything but a benchmark, you have more than one process running on the
system, and you WANT to keep threads of that process on the same node,
not scatter them to the winds.

M.

