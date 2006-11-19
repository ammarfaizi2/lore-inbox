Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933279AbWKSU4l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933279AbWKSU4l (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Nov 2006 15:56:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933283AbWKSU4l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Nov 2006 15:56:41 -0500
Received: from mout2.freenet.de ([194.97.50.155]:48317 "EHLO mout2.freenet.de")
	by vger.kernel.org with ESMTP id S933279AbWKSU4k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Nov 2006 15:56:40 -0500
From: Karsten Wiese <fzu@wemgehoertderstaat.de>
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: 2.6.19-rc6-rt4, changed yum repository
Date: Sun, 19 Nov 2006 21:56:39 +0100
User-Agent: KMail/1.9.5
Cc: linux-kernel@vger.kernel.org
References: <20061118163032.GA14625@elte.hu> <200611191539.42023.fzu@wemgehoertderstaat.de> <20061119134301.GA2792@elte.hu>
In-Reply-To: <20061119134301.GA2792@elte.hu>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200611192156.39981.fzu@wemgehoertderstaat.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Sonntag, 19. November 2006 14:43 schrieb Ingo Molnar:
> 
> * Karsten Wiese <fzu@wemgehoertderstaat.de> wrote:
> 
> > work_resched:
> > 	DISABLE_INTERRUPTS
> > 	call __schedule
> > 					# make sure we don't miss an interrupt
> > 					# setting need_resched or sigpending
> > 					# between sampling and the iret
> > 	movl TI_flags(%ebp), %ecx
> > 	andl $_TIF_WORK_MASK, %ecx	# is there any work to be done other
> > 					# than syscall tracing?
> > 	jz restore_all
> > 	testl $(_TIF_NEED_RESCHED|_TIF_NEED_RESCHED_DELAYED), %ecx
> > 	jnz work_resched
> > 
> > The hwclock page_fault happens at the
> >  	movl TI_flags(%ebp), %ecx
> > line.
> 
> hm, weird - maybe something corrupts %ebp here? Could you try to add 
> this to before the faulting instruction:
> 
> 	GET_THREAD_INFO(%ebp)
> 
> this will make sure %ebp has the right contents.

Doesn't make a difference:
clock is still set an hour early during boot occasionally.
An hour offset I also get when I comment out the hwclock call in
rc.sysinit.

The Sysrq+T output with GET_THREAD_INFO(%ebp) has:
  =======================
 hwclock       R [f7f76550] C1B07224 [on rq #0]     0   329    304                     (NOTLB)
        f7f6efb4 00003086 c1907434 c1b07224 c1907434 c02d320f 00000000 00000000
        00000001 f7f7667c f7f76550 ad91991e 00000008 001349cd c02ef1fe 00000004
        d1292e17 00000000 000cc113 00000000 00000000 f7f6e000 c0102f22 000cc113
 Call Trace:
  [<c02d320f>] do_page_fault+0x2b9/0x552
  [<c0102f22>] work_resched+0x6/0x20
  =======================

The  [<c0102f22>] work_resched+0x6/0x20 corresponds to
	mov    $0xfffff000,%ebp
in:
(gdb) disassemble work_resched
Dump of assembler code for function work_resched:
0x000001c0 <work_resched+0>:    cli
0x000001c1 <work_resched+1>:    call   0x1c2 <work_resched+2>
0x000001c6 <work_resched+6>:    mov    $0xfffff000,%ebp
0x000001cb <work_resched+11>:   and    %esp,%ebp
0x000001cd <work_resched+13>:   mov    0x8(%ebp),%ecx
0x000001d0 <work_resched+16>:   and    $0xfe3e,%ecx
0x000001d6 <work_resched+22>:   je     0x16a <restore_all>
0x000001d8 <work_resched+24>:   test   $0x80008,%ecx
0x000001de <work_resched+30>:   jne    0x1c0 <work_resched>
End of assembler dump.

But "mov    $0xfffff000,%ebp" can't cause a pagefault.
So either the Sysrq+T output is wrong or the actual page_fault happens
inside the "call __schedule" with __schedule missing from the
Call Trace.

Your yum-repo kernel seams to stay clear of above problem.
Obvious differences to my .config are SMP <> UP
and M686+X86_GENERIC <> MK8.

      Karsten


