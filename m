Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751618AbWCTGHc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751618AbWCTGHc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 01:07:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751639AbWCTGHc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 01:07:32 -0500
Received: from e32.co.us.ibm.com ([32.97.110.150]:10885 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751612AbWCTGHb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 01:07:31 -0500
Date: Mon, 20 Mar 2006 11:37:45 +0530
From: Prasanna S Panchamukhi <prasanna@in.ibm.com>
To: akpm@osdl.org, Andi Kleen <ak@suse.de>, davem@davemloft.net,
       suparna@in.ibm.com, richardj_moore@uk.ibm.com, prasanna@in.ibm.com
Cc: linux-kernel@vger.kernel.org
Subject: [0/3] Kprobes: User space probes support
Message-ID: <20060320060745.GC31091@in.ibm.com>
Reply-To: prasanna@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set provides the basic infrastructure for user-space probes
based on IBM's Dprobes. Similar to kprobes, user-space probes uses the
breakpoint mechanism to insert probes. User has to write a kernel module
to insert probes in the executable/library and specify the handlers in
the kernel module. Using this mechanism user can not only log user-space
data structure present in the memory when probe was hit, but also log
kernel data structures, stack traces, system registers etc.

User-space tools like systemtap can use this interface to probe applications
and libraries.

Design and development of this user-space probe mechanism has been
discussed in systemtap mailing lists.

a) Features supported:

   1. Probes on application executable.
   2. Probes on libraries.
   3. Probes are visible across fork().
   4. Probes can be inserted even on executables/libraries
   that are not even started running(pages not present in memory).
   5. Multiple handlers can be inserted/removed for each probe.

b) Interfaces:

   1. register_uprobe(struct uprobe *uprobe) : accepts a pointer to uprobe.
   User has to allocate the uprobes structure and initialize following
   elements:
	pathname	- points to the application's pathname
	offset		- offset of the probe from the file beginning;
   [It's still the case that the user has to specify the offset as well
    as the address (see TODO list)]
			  In case of library calls, the offset is the
			  relative offset from the beginning of the of
			  the mapped library.
	kp.addr		- virtual address within the executable.
	kp.pre_handler	- handler to be executed when probe is fired.
	kp.post_handler	- handler to be executed after single stepping
			  the original instruction.
	kp.fault_handler- handler to be executed if fault occurs while
                          executing the original instruction or the
                          handlers.

   As with a kprobe, the user should not modify the uprobe while it is
   registered. This routine returns zero on successful registeration.

   2. unregister_uprobe(struct uprobe *uprobe) : accepts a pointer to uprobe.

c) Objects:

   struct uprobe	- Allocated per probe by the user.
   struct uprobe_module	- Allocated per application by the userspace probe
			  mechanism.
   struct uprobe {
	/* pointer to the pathname of the application */
	char *pathname;
	/* kprobe structure with user specified handlers */
	struct kprobe kp;
	/* hlist of all the userspace probes per application */
	struct hlist_node ulist;
	/* inode of the probed application */
	struct inode *inode;
	/* probe offset within the file */
	unsigned long offset;
   };

   struct uprobe_module {
	/* hlist head of all userspace probes per application */
	struct hlist_head ulist_head;
	/* list of all uprobe_module for probed application */
	struct list_head mlist;
	/* to hold path/dentry etc. */
	struct nameidata nd;
	/* original readpage operations */
	struct address_space_operations *ori_a_ops;
	/* readpage hooks added operations */
	struct address_space_operations user_a_ops;
   };

d) Usage:
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
	p.kp.pre_handler=handler_pre;
	p.kp.post_handler=handler_post;
	p.kp.fault_handler=handler_fault;

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


e) TODO List:

   1. Execution of probe handlers are serialized using a uprobe_lock,
   need to make them scalable.

   2. Provide jprobes type mechansim to allow the handlers to run in user
   mode.

   3. Insert probes on copy-on-write pages. Tracks all COW pages for the
   page containing the specified probe point and inserts/removes all
   the probe points for that page.

   4. Optimize the insertion of probes through readpage hooks. Identify
   all the probes to be inserted on the read page and insert them at
   once.

   5. A wrapper routine to calculate the offset from the probed file
   beginning. In case of dynamic shared library, the offset is
   calculated by subtracting the beginning address of the file mapped
   from the address of the probe point.

   6. Probes are visible if a copy of the probed executable is made,
   remove probes from the new copied image.

   7. Make user-space probes coexist with other debuggers like gdb etc.

   8. Support probepoints within MAX_INSN_SIZE bytes of the end of a
   vm area.  (Right now we just copy MAX_INSN_SIZE bytes and assume we
   won't read of the end of the vm area.)  This would be useful for
   return probes, where we'd like to put the trampoline between
   mm->end_code and the end of that page, if possible. Really, all we
   need is 1 byte.
-- 
Prasanna S Panchamukhi
Linux Technology Center
India Software Labs, IBM Bangalore
Email: prasanna@in.ibm.com
Ph: 91-80-51776329
