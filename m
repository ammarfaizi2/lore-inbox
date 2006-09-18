Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751812AbWIRQD2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751812AbWIRQD2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Sep 2006 12:03:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751814AbWIRQD1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Sep 2006 12:03:27 -0400
Received: from smtp.osdl.org ([65.172.181.4]:36009 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751812AbWIRQD1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Sep 2006 12:03:27 -0400
Date: Mon, 18 Sep 2006 09:02:51 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Andi Kleen <ak@suse.de>
cc: Andrew Morton <akpm@osdl.org>, Chuck Ebbert <76306.1226@compuserve.com>,
       In Cognito <defend.the.world@gmail.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>, bcrl@kvack.org
Subject: Re: Sysenter crash with Nested Task Bit set
In-Reply-To: <200609181729.23934.ak@suse.de>
Message-ID: <Pine.LNX.4.64.0609180841520.4388@g5.osdl.org>
References: <200609172354_MC3-1-CB7A-58ED@compuserve.com>
 <20060917222537.55241d19.akpm@osdl.org> <Pine.LNX.4.64.0609180741520.4388@g5.osdl.org>
 <200609181729.23934.ak@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 18 Sep 2006, Andi Kleen wrote:
> 
> > If we fix it in the task-switch code, we shouldn't need any other changes 
> > (ie Chuck's change is unnecessary too), because then the process that sets 
> > NT will happily die (with NT set), but switch away to something else and 
> > nobody else will be affected.
> 
> Won't it die in the kernel with an oops on the next interrupt?

No. As mentioned, "sysenter" is really special. It should really be the 
_only_ entry into the kernel that doesn't change eflags. Everything else 
clears NT (and most of them do other things too).

So if a process already runs in kernel mode (or used mode, for that 
matter) with NT set, and an interrupt happens, the act of taking the 
interrupt will clear NT, and nothing bad happens at all. In fact, we very 
much depend on this, exactly because otherwise user mode could just set NT 
and just wait for an interrupt, and bad things would happen. They 
obviously don't.

So it's literally _only_ the path of

	set NT
	sysenter
	...
	iret

that causes problems, because all other paths will clear NT on entry into 
the kernel.

> > So if I'm right, then this patch _should_ fix it. UNTESTED (and the 
> > "ref_from_fork" special case doesn't clear NT, so it's strictly incompete, 
> > but maybe somebody can test this?)
> 
> Are you sure this handles interrupts or nested syscalls 
> before the context switch correctly?

Yeah, see above. And I have now even tested it slightly (ie I ran one of 
my x86 machines with that patch).

> I think it really needs to be handled in the sysenter path.

It really would be much more expensive there (well, the expense would be 
the same, but any load that have any amount of either would tend to have 
many more system calls than context switches).

The only way to have more context switches than system calls is to run 
entirely in user space all the time, and then we don't care - the context 
switches will also be so rare that the extra cycles simply don't matter.

> > Andi? I don't know if x86-64 honors NT in 64-bit mode, but if it does, it 
> > needs something similar (assuming this works).
> 
> It doesn't task switch, but you would get a #GP in IRET at least.
> Leaking that to another process is definitely not good.

Right. Then you need that exact same thing on x86-64 too.

One final note: as I already mentioned, this isn't actually entirely 
sufficient. There's the magic special case of "switch to a newly created 
thread", which jumps to "ret_from_fork" rather than staying within that 
small area. We'll need to add "clear NT" there.

So this (UNTESTED - I tested the previous version, and it works, but this 
extends on it) second patch should be more complete. It handles the case 
where the NT-dirty task context switches to a newly created task, by just 
forcing "eflags" to a known value in the newly created task, rather than 
whatever value it had at the time of the context switch.

The addition is fairly obvious, but maybe I screwed something up, so buyer 
beware...

		Linus

---
diff --git a/arch/i386/kernel/entry.S b/arch/i386/kernel/entry.S
index 37a7d2e..87f9f60 100644
--- a/arch/i386/kernel/entry.S
+++ b/arch/i386/kernel/entry.S
@@ -209,6 +209,10 @@ ENTRY(ret_from_fork)
 	GET_THREAD_INFO(%ebp)
 	popl %eax
 	CFI_ADJUST_CFA_OFFSET -4
+	pushl $0x0202			# Reset kernel eflags
+	CFI_ADJUST_CFA_OFFSET 4
+	popfl
+	CFI_ADJUST_CFA_OFFSET -4
 	jmp syscall_exit
 	CFI_ENDPROC
 
diff --git a/include/asm-i386/system.h b/include/asm-i386/system.h
index 49928eb..defbf12 100644
--- a/include/asm-i386/system.h
+++ b/include/asm-i386/system.h
@@ -13,7 +13,8 @@ extern struct task_struct * FASTCALL(__s
 
 #define switch_to(prev,next,last) do {					\
 	unsigned long esi,edi;						\
-	asm volatile("pushl %%ebp\n\t"					\
+	asm volatile("pushfl\n\t"		/* Save flags */	\
+		     "pushl %%ebp\n\t"					\
 		     "movl %%esp,%0\n\t"	/* save ESP */		\
 		     "movl %5,%%esp\n\t"	/* restore ESP */	\
 		     "movl $1f,%1\n\t"		/* save EIP */		\
@@ -21,6 +22,7 @@ #define switch_to(prev,next,last) do {		
 		     "jmp __switch_to\n"				\
 		     "1:\t"						\
 		     "popl %%ebp\n\t"					\
+		     "popfl"						\
 		     :"=m" (prev->thread.esp),"=m" (prev->thread.eip),	\
 		      "=a" (last),"=S" (esi),"=D" (edi)			\
 		     :"m" (next->thread.esp),"m" (next->thread.eip),	\
