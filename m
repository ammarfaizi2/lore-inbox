Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751943AbWI3Uai@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751943AbWI3Uai (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Sep 2006 16:30:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751946AbWI3Uai
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Sep 2006 16:30:38 -0400
Received: from ns2.suse.de ([195.135.220.15]:59873 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751943AbWI3Uag (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Sep 2006 16:30:36 -0400
From: Andi Kleen <ak@suse.de>
To: Linus Torvalds <torvalds@osdl.org>
Subject: Re: BUG-lockdep and freeze (was: Arrr! Linux 2.6.18)
Date: Sat, 30 Sep 2006 22:30:24 +0200
User-Agent: KMail/1.9.3
Cc: Eric Rannaud <eric.rannaud@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       nagar@watson.ibm.com, Chandra Seetharaman <sekharan@us.ibm.com>,
       Jan Beulich <jbeulich@novell.com>
References: <5f3c152b0609301220p7a487c7dw456d007298578cd7@mail.gmail.com> <Pine.LNX.4.64.0609301237460.3952@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0609301237460.3952@g5.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609302230.24070.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 30 September 2006 21:54, Linus Torvalds wrote:
> 
> On Sat, 30 Sep 2006, Eric Rannaud wrote:
> > 
> > (2) is introduced by d94a041519f3ab1ac023bf917619cd8c4a7d3c01
> > [PATCH] taskstats: free skb, avoid returns in send_cpu_listeners,
> > Signed-off-by: Shailabh Nagar.
> > The kernel freezes after a BUG (no sysrq magic).
> 
> This one looks like the real problem is that totally broken stack unwinder 
> again. 
> 
> The lockdep warning in itself is probably valid, but the reason for the 
> _hang_ is the
> 
> 	[  138.831385] Unable to handle kernel paging request at ffffffff82800000 RIP:
> 	[  138.831439]  [<ffffffff8020b491>] show_trace+0x311/0x380  
> 
> and that code is just a total mess. 


The code decides to do a fallback at the top of stack space for some reason.

Hmm, i've seen this working on other kernel threads, but maybe 
that was luck. Kernel threads don't end up in user space 
so the normal check for that doesn't work.
I guess we just need another termination for the kernel threads
by pushing a 0 there explicitely. Jan, do you agree?

> 
> Andi, I really think that Dwarf unwinder needs to go. The code is totally 
> unreadable, and it's clearly fragile as hell. It doesn't check that the 
> pointers it gets are even remotely valid, but just follows them as if they 
> were.

It assumes the dwarf2 information is correct, but stack is normally checked
(actually it doesn't even follow any pointers on the stack unlike a frame pointer
unwinder) 

> 
> The whole unwinder seems buggier than any bug it can ever unwind would be. 

We didn't so far find any bug in the unwinder code itself (ok if you don't
count the performance issue Ingo found) just lots in the annotations and one
bug in the dwarf2 standard. There were a couple of bugs in the fallback
code I added later, but that was added only because the annotations were
so buggy and we were afraid to lose information. 

> Really. Let's go back to the sane "try our best, don't guarantee anything, 
> but at least don't make things worse!" old code.

If you kick the people who add more than three levels of callback
to core driver code to get their acts together too that's fine 
to me. Unfortunately I don't think that's realistic. So we clearly
need better unwinding.

> The people who wrote that crap (and yes, Andi, I mean apparently you and 
> Jan Beulich) really _have_ to get his act together. It's not just 
> unreadable and obviously buggy, it's so scarily that it's hard to even 
> talk about it. Lookie here:
> 
> 	#define HANDLE_STACK(cond) \
> 	        do while (cond) { \
> 	                unsigned long addr = *stack++; \

> What the F*CK! "do while(cond) {" ???? 

That is because while () alone doesn't tolerate a semicolon without
breaking if () MACRO; else ... Given I don't think it's used in a 
else context here, but there are valid reasons for this convention.

[of course if C had a non crappy preprocessor this all wouldn't be needed,
but we're stuck with it now]

> > [  138.430973] Call Trace:
> > [  138.431190]  [<ffffffff8020b22d>] show_trace+0xad/0x380
> > [  138.431264]  [<ffffffff8020b745>] dump_stack+0x15/0x20
> > [  138.431337]  [<ffffffff8024bc1d>] print_infinite_recursion_bug+0x3d/0x50
> > [  138.431465]  [<ffffffff8024bd2f>] find_usage_backwards+0x2f/0xd0
> > [  138.431591]  [<ffffffff8024bd93>] find_usage_backwards+0x93/0xd0
> > [  138.431718]  [<ffffffff8024bd93>] find_usage_backwards+0x93/0xd0

... lots of recursive calls snipped ...

Scary. That code really seems to be quite deeply recursive. 
Linus, why don't you flame code like this? @) Actually I guess the
real culprit here is not even lockdep, but too complex locking 
in XFRM.

Actually I wonder if the stack didn't just overflow. Unfortunately it can't
be seen because the tail is in a interrupt stack.

> > [  138.751306]  [<ffffffff8021ecc0>] search_extable+0x40/0x70

After here the unwinder seems to become a bit and it shouldn't print
multiple entries. Jan any ideas why?

> > [  138.763697]  [<ffffffff8020efeb>] show_cpuinfo+0x18b/0x360
> > [  138.763765]  [<ffffffff8020efef>] show_cpuinfo+0x18f/0x360
> > [  138.763828]  [<ffffffff8020f0e6>] show_cpuinfo+0x286/0x360
> > [  138.763889]  [<ffffffff8020f0ed>] show_cpuinfo+0x28d/0x360
> > [  138.764152]  [<ffffffff8021de9f>] show_mem+0xbf/0x170
> > [  138.764211]  [<ffffffff8021dea1>] show_mem+0xc1/0x170
> > [  138.764275]  [<ffffffff8021dec0>] show_mem+0xe0/0x170
> > [  138.764334]  [<ffffffff8021dec2>] show_mem+0xe2/0x170
> > [  138.764394]  [<ffffffff8021ded7>] show_mem+0xf7/0x170
> > [  138.764453]  [<ffffffff8021ded9>] show_mem+0xf9/0x170
> > [  138.764514]  [<ffffffff8021dfc0>] __add_pages+0x40/0xd0
> > [  138.764576]  [<ffffffff8021e089>] vmalloc_sync_all+0x39/0x170
> > [  138.799966]  [<ffffffff8049ee60>] xfrm_state_netlink+0x0/0xa0
> > [  138.800034]  [<ffffffff8049ee69>] xfrm_state_netlink+0x9/0xa0
> > [  138.800100]  [<ffffffff8049ee86>] xfrm_state_netlink+0x26/0xa0
> > [  138.800161]  [<ffffffff8049ee8f>] xfrm_state_netlink+0x2f/0xa0
> > [  138.800230]  [<ffffffff8049f182>] xfrm_send_state_notify+0x282/0x6c0
> > [  138.800292]  [<ffffffff8049f195>] xfrm_send_state_notify+0x295/0x6c0
> > [  138.800370]  [<ffffffff8022ad33>] find_busiest_group+0x5d3/0x6f0
> > [  138.800431]  [<ffffffff8022ad3c>] find_busiest_group+0x5dc/0x6f0
> > [  138.800499]  [<ffffffff8049f23c>] xfrm_send_state_notify+0x33c/0x6c0
> > [  138.800562]  [<ffffffff8049f243>] xfrm_send_state_notify+0x343/0x6c0
> > [  138.800628]  [<ffffffff8022ae75>] migration_thread+0x25/0x2e0
> > [  138.800689]  [<ffffffff8022ae7e>] migration_thread+0x2e/0x2e0
> > [  138.800752]  [<ffffffff8022aea0>] migration_thread+0x50/0x2e0
> > [  138.800813]  [<ffffffff8022aea9>] migration_thread+0x59/0x2e0
> > [  138.831385] Unable to handle kernel paging request at ffffffff82800000 RIP:
> > [  138.831439]  [<ffffffff8020b491>] show_trace+0x311/0x380

When show_trace faults it is actually not the unwinder itself
(which would be unwind()/processCFI() etc.), but fallback code
which is actually just the old unwinder. So most of your accusations 
are hitting the wrong piece of code, Linus.

I bet it would have worked with call_trace=new (then it won't do 
any fallbacks)

Anyways, I guess we need even more validation in the fallback code,
but just terminating the kernel thread stacks should fix that particular case.

Proposed patch appended. Jan, what do you think?

-Andi

Index: linux/arch/i386/kernel/process.c
===================================================================
--- linux.orig/arch/i386/kernel/process.c
+++ linux/arch/i386/kernel/process.c
@@ -328,6 +328,7 @@ extern void kernel_thread_helper(void);
 int kernel_thread(int (*fn)(void *), void * arg, unsigned long flags)
 {
 	struct pt_regs regs;
+	int err;
 
 	memset(&regs, 0, sizeof(regs));
 
@@ -342,7 +343,9 @@ int kernel_thread(int (*fn)(void *), voi
 	regs.eflags = X86_EFLAGS_IF | X86_EFLAGS_SF | X86_EFLAGS_PF | 0x2;
 
 	/* Ok, create the new process.. */
-	return do_fork(flags | CLONE_VM | CLONE_UNTRACED, 0, &regs, 0, NULL, NULL);
+	err = do_fork(flags | CLONE_VM | CLONE_UNTRACED, 0, &regs, 0, NULL, NULL);
+	if (err == 0) /* terminate kernel stack */
+		task_pt_regs(current)->eip = 0;
 }
 EXPORT_SYMBOL(kernel_thread);
 
Index: linux/arch/x86_64/kernel/entry.S
===================================================================
--- linux.orig/arch/x86_64/kernel/entry.S
+++ linux/arch/x86_64/kernel/entry.S
@@ -978,6 +978,11 @@ ENTRY(kernel_thread)
 	call do_fork
 	movq %rax,RAX(%rsp)
 	xorl %edi,%edi
+	test %rax,%rax
+	jnz  1f
+	/* terminate stack in child */
+	movq %rdi,RIP(%rsp)
+1:
 
 	/*
 	 * It isn't worth to check for reschedule here,
