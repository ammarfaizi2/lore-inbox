Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751429AbWEIGzA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751429AbWEIGzA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 02:55:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751430AbWEIGzA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 02:55:00 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:7104 "EHLO e36.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751429AbWEIGy7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 02:54:59 -0400
Date: Tue, 9 May 2006 12:24:55 +0530
From: Prasanna S Panchamukhi <prasanna@in.ibm.com>
To: linux-kernel@vger.kernel.org, systemtap@sources.redhat.com
Cc: akpm@osdl.org, Andi Kleen <ak@suse.de>, davem@davemloft.net,
       suparna@in.ibm.com, richardj_moore@uk.ibm.com, prasanna@in.ibm.com
Subject: [RFC] [PATCH 0/6] Kprobes: User-space probes support for i386
Message-ID: <20060509065455.GA11630@in.ibm.com>
Reply-To: prasanna@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

As requisted earlier on the mailing list, below is the detailed
description of user-space probes followed by patches.
Please review and provide your comments.

http://lkml.org/lkml/2006/3/20/2 is the earlier posting.

ChangeLog:

- Separate patches to move generic code to mm and vfs subsystem.(Nick)
- Use get_user_pages() for __copy_to_user_inatomic to succeed.(Arjan)
- Use kmap_atomic() instead of kmap().(Andrew)
- Remove __lock_page() usage.(Andrew)
- Use mmap_sem before calling find_vma().(Andrew)
- Use flush_dcache_page() in replace_original_insn().(Andrew)
- Remove docbook style comments.(Andrew)
- Use inc/dec_preempt_count() in uprobe_handlers().(Andrew)

Thanks
Prasanna
--

A. What is the problem we are trying to solve?

The primary intent is to provide a system-wide tracing framework for Linux.
This framework can be used in conjunction with (as an extension of) kprobes
to gather information both from kernel and user-space, thus mitigating the
need to collect data separately and correlating them. It provides a
system-wide view of the problem at hand.

Some use-cases could be:
- One process depletes a system-wide resource (dcache, etc)
- One process owns resources exclusively, causing others to wait
- One process hogs the CPU or I/O bandwidth.

B. Why does Linux need this feature?

As Linux gets deployed in bigger and more complicated computing environments,
more issues relating to performance are surfacing. Tools that provide a
holistic view of the system can provide invaluable insights to the problem
at hand. Some debug scenarios require system-wide instrumentation so that
thousands of active probes with low-overhead can co-exist and all the instances
of probe hits on any binary can be detected. There are situations where the
existing tools like ptrace does not scale well.

For example:
- When working on networking-related performance problems, you need to
  correlate instrumentation from multiple layers (the MAC layer
  and IP stack in the kernel up to the application in question).
- Diagnosing problems with the X-Windows server, for example, might
  require instrumenting all clients that connect to the server.
- When tackling issues relating to performance of distributed systems,
  involving, say, a filesystem, samba, apache and the like, gathering
  data independently and then correlating the same is going to be a
  difficult task.


C. Design drivers

The primary drivers in arriving at this design were:
- Dynamic instrumentation that can be created, installed and removed as
  needed without rebooting or restarting applications
- System-wide instrumentation with user having the freedom to retain or
  discard data as desired as also the ability to gather both user and
  kernel data with the same instrumentation code
- Not having to force COW on pages
- Not having to force pages into memory just to insert probes
- Not having to be concerned with evicting pages from memory under pressure
- Ability to probe shared libraries
- Ability to insert probes on applications that are yet to be started
- Probes are visible across fork() calls


D. Advantages of this approach

- No COW/privatization of pages or forcing of pages into memory just for
  the sake of probe insertion
- No restriction on evicting pages with probes from memory
- Since probes are inserted based on the inode-offset tuple, all
  instances of the program are instrumented -- user then has the
  advantage of choosing what instances of the application he'd like
  to instrument
- Probes can be inserted on applications residing on read-only mounts,
  since the text pages are discarded post execution


E. The details

At the basic level, similar to kprobes, a breakpoint instruction or
watchpoint is inserted at the instrumentation location and handlers are
run when the breakpoint/watchpoint is hit.

In order to be able to insert probes on pages that aren't in memory
during registration, the readpage(s) hooks of struct
address_space_operations are modified for the inode in question so as to
be able to first insert the probes onto the page at the time it is read
into memory. This mechanism adds some overhead, but is restricted to the
probed binaries only.

The instrumented binary should not be allowed to change for the duration
of the instrumentation. This is achieved by decrementing the
inode->i_writecount of the instrumented binary, so we get exclusive
write access for the entire instrumentation duration.

When the breakpoint is hit, similar to a kprobe, its associated pre_handler
is invoked. The original instruction is then single-stepped out-of-line
so as to prevent any possible SMP misses. Single-stepping out-of-line
requires us to find an unused area in the process address space to which
we can copy the probed instruction.

- The application stack is checked to see if there is sufficient space
  for the instruction copy. If so, the instruction is copied to the bottom
  of the page. Some architectures have stack pages with no-exec set.
  In such cases, the no-exec bit for the corresponding stack page is
  temporarily unset.
- If there is insufficient space on stack, the vma is expanded beyond
  the current stack's vma and that is used for the single-stepping.
- In cases where the vma can't be extended (the process has exhausted
  all its virtual address space), we resort to single-stepping inline by
  replacing the original instruction back at the probed location.



F. Known issues/flaws:

- Currently, applications that access the page-cache directly for I/O
  will see the breakpoint instruction in text. Similar is the case of
  text pages that are mmap'ed private.
- Arjan pointed out that tripwire-like tools can clearly detect the text
  corruption.
	- There is a way to fix these, albeit not too elegant.
		- Modify the file_read_actor() to check if the read is
		  for a probed application and remove the breakpoints on
		  the copied image. This solution has been prototyped and
		  is known to work.
- There is a possibility that probes on an executable mmap'ed shared could
  be written back to disk. The simplest solution is to disallow probes on
  shared mmap objects.

- Instrumentation data that can be gathered is limited to pages resident
  in memory when the probepoint is hit. A jprobe like approach can to
  used so as to collect the data from pages that are not present in the
  memory when the probepoint is hit.
- The instrumentation handler runs in kernel context. As Arjan pointed
  out in one of the earlier discussion threads on this topic, running a
  handler is user-space provides availability of better debug information.
	- A jprobe like approach has been prototyped using a system-call
	  interface. This provides for executing the instrumentation
	  code in the process context in userspace. Clearly this has
	  significant overhead
		- We have to take a debug trap to return back to the
		  "normal" process context from the instrumentation context.
		- The instrumentation code must be made part of the
		  address spaces of the processes that map the same
		  binary.

- Probes on text that are mapped at different addresses by different
  processes need special handling. This could be solved by tracking
  vmas that map the same text pages and insert probes on them.
- Coexistence with debuggers is another issue. The simplest solution is
  to fail registration of a breakpoint if one is already existing at the
  location to be instrumented.
- Due to the system-wide approach to instrumentation, all processes
  running the same executable end up having to pay the penalty of taking
  the debug trap. Finer-grained controls can be provided to minimze
  overhead by possibly filtering events based on pids of processes we
  are interested in.

- Its been suggested that writing a kernel module to gather user-space
  data isn't a great idea. However, with tools like systemtap, it is
  possible for application programmers and system admins to just script
  and gather data.


G. What alternative solutions were there?

As far as we know, there doesn't exist a system-wide, dynamic tracing
framework.

There are, of course, tools like ptrace(), that are suitable for per-process
instrumentation. But ptrace() has its own design/performance issues and
it's also well known that the ptrace approach won't scale well, especially
given the overhead of context switches and other issues with the current
implementation.

A short writeup on other approaches tried is available here:

http://marc.theaimsgroup.com/?l=linux-kernel&m=114344261621050&w=2
http://marc.theaimsgroup.com/?l=linux-kernel&m=114294391910100&w=2

The belief is, on Linux there is space for both types of instrumentation
to coexist, and a need for both. Hence the proposal.


H. Open questions:

1. What if the text is writably mapped?
	- Fail inserting probes on them.
2. What are the typical cases when an executable (library?) is mmap'ed
   shared?

I. Usage:
	/* Allocate a uprobe structure */
	struct uprobe p;

	/* Define pre handler */
	int handler_pre(struct kprobe *p, struct pt_regs *regs)
	{
		.............collect useful data..............
		return 0;
	}

	void handler_post(struct kprobe *p, struct pt_regs *regs,
							unsigned long flags)
	{
		.............collect useful data..............
	}

	int handler_fault(struct kprobe *p, struct pt_regs *regs, int trapnr)
	{
		........ release allocated resources & try to recover ....
		return 0;
	}

	Before inserting the probe, specify the pathname of the application
	on which the probe is to be inserted.

	/*pointer to the pathname of the application */
	p.pathname = "/home/prasanna/bin/myapp";
	p.kp.pre_handler = handler_pre;
	p.kp.post_handler = handler_post;
	p.kp.fault_handler = handler_fault;

	/* Specify the probe address */
	/* $nm appln |grep func1 */
	p.kp.addr = (kprobe_opcode_t *)0x080484d4;
	/* Specify the offset within the application/executable*/
	p.offset = (unsigned long)0x4d4;
	/* Now register the userspace probe */
	if (ret = register_uprobe(&p))
		printk("register_uprobe: unsuccessful ret= %d\n", ret);

	/* To unregister the registered probed, just call..*/
	unregister_uprobe(&p);

-- 
Prasanna S Panchamukhi
Linux Technology Center
India Software Labs, IBM Bangalore
Email: prasanna@in.ibm.com
Ph: 91-80-41776329
