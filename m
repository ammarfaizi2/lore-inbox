Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261368AbVFMVIE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261368AbVFMVIE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Jun 2005 17:08:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261365AbVFMUze
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Jun 2005 16:55:34 -0400
Received: from fmr20.intel.com ([134.134.136.19]:52909 "EHLO
	orsfmr005.jf.intel.com") by vger.kernel.org with ESMTP
	id S261334AbVFMUwj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Jun 2005 16:52:39 -0400
Message-Id: <20050613205153.349171000@linux.jf.intel.com>
Date: Mon, 13 Jun 2005 13:51:53 -0700
From: rusty.lynch@intel.com
To: linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
       linuxppc64-dev@ozlabs.org
Subject: [patch 0/5] [kprobes] Tweak to the function return probe design 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(The following is a resend from this morning.  The various kernel mailing list
did not seem to get my email, so I am resending the patch series from another
machine.)

 From my experiences with adding return probes to x86_64 and ia64, and the
feedback on LKML to those patches, I think we can simplify the design
for return probes.

The following patch tweaks the original design such that:

* Instead of storing the stack address in the return probe instance, the
  task pointer is stored.  This gives us all we need in order to:
    - find the correct return probe instance when we enter the trampoline
      (even if we are recursing)
    - find all left-over return probe instances when the task is going away

  This has the side effect of simplifying the implementation since more
  work can be done in kernel/kprobes.c since architecture specific knowledge
  of the stack layout is no longer required.  Specifically, we no longer have:
	- arch_get_kprobe_task()
	- arch_kprobe_flush_task()
	- get_rp_inst_tsk()
	- get_rp_inst()
	- trampoline_post_handler() <see next bullet>

* Instead of splitting the return probe handling and cleanup logic across
  the pre and post trampoline handlers, all the work is pushed into the 
  pre function (trampoline_probe_handler), and then we skip single stepping
  the original function.  In this case the original instruction to be single
  stepped was just a NOP, and we can do without the extra interruption.

The new flow of events to having a return probe handler execute when a target
function exits is:

* At system initialization time, a kprobe is inserted at the beginning of
  kretprobe_trampoline.  kernel/kprobes.c use to handle this on it's own,
  but ia64 needed to do this a little differently (i.e. a function pointer
  is really a pointer to a structure containing the instruction pointer and
  a global pointer), so I added the notion of arch_init(), so that
  kernel/kprobes.c:init_kprobes() now allows architecture specific
  initialization by calling arch_init() before exiting.  Each architecture
  now registers a kprobe on it's own trampoline function.

* register_kretprobe() will insert a kprobe at the beginning of the targeted
  function with the kprobe pre_handler set to arch_prepare_kretprobe
  (still no change)

* When the target function is entered, the kprobe is fired, calling
  arch_prepare_kretprobe (still no change)

* In arch_prepare_kretprobe() we try to get a free instance and if one is
  available then we fill out the instance with a pointer to the return probe,
  the original return address, and a pointer to the task structure (instead
  of the stack address.)  Just like before we change the return address
  to the trampoline function and mark the instance as used.

  If multiple return probes are registered for a given target function,
  then arch_prepare_kretprobe() will get called multiple times for the same 
  task (since our kprobe implementation is able to handle multiple kprobes 
  at the same address.)  Past the first call to arch_prepare_kretprobe, 
  we end up with the original address stored in the return probe instance
  pointing to our trampoline function. (This is a significant difference
  from the original arch_prepare_kretprobe design.) 

* Target function executes like normal and then returns to kretprobe_trampoline.

* kprobe inserted on the first instruction of kretprobe_trampoline is fired
  and calls trampoline_probe_handler() (no change here)

* trampoline_probe_handler() consumes each of the instances associated with
  the current task by calling the registered handler function and marking 
  the instance as unused until an instance is found that has a return address
  different then the trampoline function.

  (change similar to my previous ia64 RFC)
       
* If the task is killed with some left-over return probe instances (meaning
  that a target function was entered, but never returned), then we just
  free any instances associated with the task.  (Not much different other
  then we can handle this without calling architecture specific functions.)

  There is a known problem that this patch does not yet solve where
  registering a return probe flush_old_exec or flush_thread will put us
  in a bad state.  Most likely the best way to handle this is to not allow
  registering return probes on these two functions.

  (Significant change)

This patch series applies to the 2.6.12-rc6-mm1 kernel, and provides:
  * kernel/kprobes.c changes
  * i386 patch of existing return probes implementation
  * x86_64 patch of existing return probe implementation
  * ia64 implementation 
  * ppc64 implementation (provided by Ananth)

    --rusty
