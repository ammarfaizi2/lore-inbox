Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269635AbUIRUgv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269635AbUIRUgv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Sep 2004 16:36:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269631AbUIRUfu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Sep 2004 16:35:50 -0400
Received: from vana.vc.cvut.cz ([147.32.240.58]:20356 "EHLO vana.vc.cvut.cz")
	by vger.kernel.org with ESMTP id S269630AbUIRUfb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Sep 2004 16:35:31 -0400
Date: Sat, 18 Sep 2004 22:35:29 +0200
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: Stas Sergeev <stsp@aknet.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ESP corruption bug - what CPUs are affected?
Message-ID: <20040918203529.GA4447@vana.vc.cvut.cz>
References: <3BFF2F87096@vcnet.vc.cvut.cz> <414C662D.5090607@aknet.ru> <20040918165932.GA15570@vana.vc.cvut.cz> <414C8924.1070701@aknet.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <414C8924.1070701@aknet.ru>
User-Agent: Mutt/1.5.6+20040818i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 18, 2004 at 11:14:44PM +0400, Stas Sergeev wrote:
> Hi,
> 
> Petr Vandrovec wrote:
> >>Does this look reasonable? If it does, I think I
> >>should just start implementing that.
> >Do not forget that you have to implement also return to CPL1, as
> >NMI may arrive while you are running on CPL1.  So it may not be
> >as trivial as it seemed. 
> I am not sure what special actions have to be
> taken here compared to returning to ring-3 from NMI.
> Is there anywhere in the sources an example to take
> a look at? (sorry for the newbie questions)

It means that you cannot blindly create CPL1 trampoline stack
in some static per-cpu area.  But if we can assume that there
is no other CPL1 code in the system, something like code below
could work:

/* + 20 [word 5]  SS
   + 16 [word 4]  ESP
   + 12 [word 3]  EFLAGS
   +  8 [word 2]  CS
   +  4 [word 1]  EIP
   +  0 [word 0]  ESP for popl %esp
*/
u_int32_t cpl1stacks[NUM_CPUS][6];

curCPU = smp_processor_id();
minSP = curCPU * sizeof(cpl1stacks[0]);
maxSP = minSP + sizeof(cpl1stacks[0]);
cpl1stack = cpl1stacks[curCPU];

if (cpl0stack[retCS] & 3 == 1) {
	/* Going back to our trampoline */
	/* There is no other place in kernel running on CPL1
           except our trampoline; so interrupt could occur either
           on popl %esp or on iret.  If it occured on popl %esp,
           just return, code will do proper things.  If interrupt
	   occured on iret, we have to perform popl %esp again,
	   so that upper bits of %esp are correctly restored
	   for CPL3 code */
	ASSERT(cpl0stack[retCS] == FLAT_4G_CPL1_CS);
	ASSERT(cpl0stack[retSS] == SMALL_CPL1_SS);
	if (cpl0stack[retEIP] == fixup_proc) {
		ASSERT(cpl0stack[retESP] == minSP]);
	} else if (cpl0stack[retEIP] == fixup_proc_iret) {
		ASSERT(cpl0stack[retESP] & 0xFFFF == minSP + 4);
		/* Undo popl %esp - copy value from ESP we were
                   using on CPL1 back to stack */
		cpl1stack[0] = cpl0stack[retESP];
		cpl0stack[retEIP] = fixup_proc;
		cpl0stack[retESP] = minSP;
	} else {
		/* unexpected code running on CPL1 */
		/* Probably do simple IRET and hope for the best? */
		ASSERT(0);
	}
	iret;
} else {
	cpl1Stack[5] = cpl0stack[retSS];
	cpl1Stack[4] = cpl0stack[retESP];
	cpl1Stack[3] = cpl0stack[retEFLAGS];
	cpl1Stack[2] = cpl0stack[retCS];
	cpl1Stack[1] = cpl0stack[retEIP];
	cpl1Stack[0] = (cpl0stack[retESP] & 0xFFFF0000) | minSP + 4;
	cpl0stack[retSS] = SMALL_CPL1_SS;
	cpl0stack[retESP] = minSP;
	/* 
	   Do NOT clear IF... IF flag is affected only if IOPL >= CPL, so
	   with IOPL=0 IRET on CPL1 won't reenable interrupts.  This is reason
	   why we cannot use RETF to return from CPL0 to CPL1 (retf
	   is much faster than iret on P4) (and we cannot use retf for
	   CPL1->CPL3 due to TF/RF).

	   Clear TF so we do not start tracing on CPL1 if we trace
	   userspace, and clear RF, so if somebody intentionaly pointed
	   hardware breakpoint into CPL1 handler, it will be triggered
	   (we must use this path for returns from INT1 too, so it
	   is possible that RF is set in EFLAGS on stack).
	*/
	cpl0stack[retEFLAGS] &= ~(EFLAGS_TF | EFLAGS_RF);
	cpl0stack[retCS] = FLAT_4G_CPL1_CS;
	cpl0stack[retEIP] = fixup_proc;
	iret;
}

fixup_proc:
	popl %esp
fixup_proc_iret;
	iret


It assumes that there is one new 32bit CPL1 flat CS descriptor in GDT, and
one 16bit (small) CPL1 SS descriptor (grows up, with limit 24*<num_cpus>
and base of cpl1stacks), plus <num_cpus> 24byte CPL1 stacks (max. 64KB, 
so for kernels with more than 2730 CPUs you need more than one stack 
descriptor).


> >Maybe all these programs survive that
> >their CPL3 stack changes,
> Most likely they will, I am just not sure. What
> if they disabled interrupts and are switching the
> stack by loading the SS and ESP separately? If we
> interrupt it there, there may be the problems, which
> would be almost impossible to track down later.
> It just looks a bit unsafe to me. Or maybe exploit
> a sigaltstack for that? Hmm, is implementing the
> CPL1 trampoline really that difficult after all?
> I think it is somewhat cleaner and maybe safer.

As in pseudocode above I was able to handle even NMIs with just
24 bytes of stack on CPL1, it is definitely preferred solution.

> >and AFAIK LAR is microcoded on P4.
> Where does this lead us to? Some other problems I
> am not aware about?

It is slow.  No other problems, except that doing
(((ss & 4) ? gdt[ss >> 3] : ldt[ss >> 3]) & 0x00????00) == 0x00????00;
may be faster than doing (lar(ss) & 0x00????00) == 0x00????00.
						Petr

