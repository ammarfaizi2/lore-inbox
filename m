Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261474AbUFVIyW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261474AbUFVIyW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 04:54:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261602AbUFVIyW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 04:54:22 -0400
Received: from fw.osdl.org ([65.172.181.6]:46750 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261474AbUFVIyQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 04:54:16 -0400
Date: Tue, 22 Jun 2004 01:53:11 -0700
From: Andrew Morton <akpm@osdl.org>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH][1/6] perfctr-2.7.3 for 2.6.7-rc1-mm1: core
Message-Id: <20040622015311.561a73bf.akpm@osdl.org>
In-Reply-To: <200405312218.i4VMIISg012277@harpo.it.uu.se>
References: <200405312218.i4VMIISg012277@harpo.it.uu.se>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mikael Pettersson <mikpe@csd.uu.se> wrote:
>
> perfctr-2.7.3 for 2.6.7-rc1-mm1, part 1/6:
>

OK, I spent a couple hours on the perfctr code.  It looks sane, although a
bit hard to follow.  The above changelog (which is _all_ you gave us) makes
this large and complex patch hard to review, hard to understand, hard for
others to support.

One can look at the code, sort-of-see what it's doing, query micro-issues,
but it is hard (and a bad use of one's time) to try and reverse-engineer
the big-picture "how it all hangs together" from the implementation.

We need (especially at this stage in the kernel cycle) at least a couple of
pages of design documentation which describes

- the major data structures

- the relationships between them

- their lifetime rules.

- a general overview of how the whole thing operates (what's
  PERFCTR_INTERRUPT_SUPPORT do?  What interrupts are generated?  Describe
  the backpatching design, etc).  What is "forbidden" on p4 siblings, and
  why and what is the implication of this?  etcetera.

- the thread/process/data structure inheritance/sharing/creation models

- any known shortcomings, rejected design decisions, etc.

- the core<->arch-specific interface


Also there should be a document or a manpage or something which describes,
in detail:

- the user/kernel API  (separate document, probably)

- what's in that filesystem, and how the objects in it are used.

- the sysfs interface

- the relationship with ptrace



Random points:


- In __vperfctr_set_cpus_allowed(), is it possible for a process to
  generate that printk deliberately, thus spamming the logs?

- perfctr_set_cpus_allowed() does task_lock().  Should that be
  vperfctr_task_lock() instead?

  Please update the locking comment over task_lock() to represent this
  new usage.

  Note that printk() can call wake_up(), which takes scheduler locks.  So
  you've introduced a lock ranking here.  Looks to be OK though.

- (What is the thread/process/child inheritance model for perfctr
  anyway?)

- Why does sys_vperfctr_open() call ptrace_check_attach()?  (I suspect
  I'd know that if there was API documentation?)

- cpus_copy_to_user() has the arguments in the wrong order, and should
  have sparse annotation added, please.

- <canofworms>cannot cpus_copy_to_user() share code with
  sys_sched_getaffinity()?</canofworms>

- Sometime all the new syscalls need sparse annotation added, propagated
  into callees.

- Can perfctr_init() and perfctr_exit() have static scope?

- This

	cache = &get_cpu_cache();

  looks cumbersome.  It'd be nice to add the & to get_cpu_cache() itself.

- In perfctr_cpu_init():

	perfctr_cpu_init_one(NULL);
	smp_call_function(perfctr_cpu_init_one, NULL, 1, 1);

  use on_each_cpu() here.  Ditto perfctr_cpu_exit(), other places.

- Why does perfctr_cpu_init() do preempt_disable()?  Needs a comment. 
  Ditto perfctr_cpu_exit().

- Why does vperfctr_alloc() allocate an entire page?  (Needs comment)

- Why is that page reserved?

- The top-level Kconfig help should perhaps contain some handy URLs. 
  (Except there don't seem to be any :()

- stack space.

  struct vperfctr_control is 348 bytes, do_vperfctr_read() uses 500 bytes
  of stack and does copy_to_user(), which can cause tremendously deep
  callchains (think: it can call into XFS and then into the qlogic driver ;))

  These big structures should be dynamically allocated.

  sizeof(struct perfctr_cpu_state) is 708.

- ooh, it has a filesystem, and something can be mmapped.  API documentation? ;)

- why is the filesystem kern_mount()ed?

- why are the inodes initialised to state I_DIRTY?

- In sys_vperfctr_open(), can the `if (!vperfctr_fs_init_done())' test
  actually return true?

- Can the presence of thread_struct.perfctr be dependent upon
  CONFIG_PERFCTR?

- If task A creates itself a node in that new filesystem (what's the
  naming schema there?  What facilities does the filesystem offer?  Why was
  an fs interface chosen?) and task B opens that node, then task A exits,
  what keeps the task_struct at the node's file->f_private_data->owner
  valid?

  What happens in this situation?  Is it valid usage?  Should the read fail?

- Are functions like p5_write_control() preempt-protected?

- Is there much point in making CONFIG_PERFCTR_VIRTUAL optional?


