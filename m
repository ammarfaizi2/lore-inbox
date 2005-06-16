Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261855AbVFPWe2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261855AbVFPWe2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Jun 2005 18:34:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261854AbVFPWe1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Jun 2005 18:34:27 -0400
Received: from fmr18.intel.com ([134.134.136.17]:56711 "EHLO
	orsfmr003.jf.intel.com") by vger.kernel.org with ESMTP
	id S261841AbVFPWdd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Jun 2005 18:33:33 -0400
Message-Id: <20050616223139.444305000@linux.jf.intel.com>
Date: Thu, 16 Jun 2005 15:31:39 -0700
From: rusty.lynch@intel.com
To: akpm@osdl.org
Cc: systemtap@sources.redhat.com, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org, Hien Nguyen <hien@us.ibm.com>,
       Prasanna S Panchamukhi <prasanna@in.ibm.com>, Andi Kleen <ak@suse.de>,
       Ananth N Mavinakayanahalli <amavin@redhat.com>,
       linuxppc64-dev@ozlabs.org
Subject: [patch 0/5] [kprobes] Tweak to the function return probe design - take 2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following is the second version of the function return probe patches
I sent out earlier this week.  Changes since my last submission include:

* Fix in ppc64 code removing an unneeded call to re-enable preemption
* Fix a build problem in ia64 when kprobes was turned off
* Added another BUG_ON check to each of the architecture trampoline 
  handlers

My initial patch description ==>

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
