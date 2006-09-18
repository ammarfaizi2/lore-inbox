Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751760AbWIRPLr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751760AbWIRPLr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Sep 2006 11:11:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751761AbWIRPLr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Sep 2006 11:11:47 -0400
Received: from smtp.osdl.org ([65.172.181.4]:19095 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751760AbWIRPLq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Sep 2006 11:11:46 -0400
Date: Mon, 18 Sep 2006 08:11:22 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Andrew Morton <akpm@osdl.org>
cc: Chuck Ebbert <76306.1226@compuserve.com>,
       In Cognito <defend.the.world@gmail.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>, Andi Kleen <ak@suse.de>
Subject: Re: Sysenter crash with Nested Task Bit set
In-Reply-To: <20060917222537.55241d19.akpm@osdl.org>
Message-ID: <Pine.LNX.4.64.0609180741520.4388@g5.osdl.org>
References: <200609172354_MC3-1-CB7A-58ED@compuserve.com>
 <20060917222537.55241d19.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 17 Sep 2006, Andrew Morton wrote:
> > 
> > I'll take your word that it crashes.
> 
> It doesn't for me - I get a segfault.
> 
> That's on a PIII.  Are recenter CPUs different in this regard?

No, I don't think they are, but I think your exact machine matters. For 
example, an SMP machine will behave differently, because NT will be set 
only on one CPU.

I _think_ that the problem is that once NT gets set in kernel space (and 
sysenter is the only way to do that, since the normal fault paths will 
clear NT), it stays set, even across a context switch. Nothing ever 
reloads a kernel eflags, because we "trust" eflags in kernel space.

So Chuck's patch doesn't really fix it - because a preemptible kernel 
might context switch long before the original task that set eflags, and 
thus NT in eflags might migrate to somebody else, and while we'll 
eventually take the "invalid TSS" error and then Chuck's patch will cause 
us to clear it, we might be taking the exception for the wrong task (and 
thus kill the wrong guy).

And sysenter really is very special because of the weak trap semantics. 
Damn. We could either fix it in the sysenter code-path, or in the 
task-switch one, and both of them are timing-critical, but task switching 
perhaps just a tad less so.

If we fix it in the task-switch code, we shouldn't need any other changes 
(ie Chuck's change is unnecessary too), because then the process that sets 
NT will happily die (with NT set), but switch away to something else and 
nobody else will be affected.

So if I'm right, then this patch _should_ fix it. UNTESTED (and the 
"ref_from_fork" special case doesn't clear NT, so it's strictly incompete, 
but maybe somebody can test this?)

Hmm? Ingo? Comments?

Andi? I don't know if x86-64 honors NT in 64-bit mode, but if it does, it 
needs something similar (assuming this works).

		Linus

---
diff --git a/include/asm-i386/system.h b/include/asm-i386/system.h
index 49928eb..f6e4260 100644
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
