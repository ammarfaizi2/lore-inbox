Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130649AbRCIWac>; Fri, 9 Mar 2001 17:30:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130730AbRCIWaX>; Fri, 9 Mar 2001 17:30:23 -0500
Received: from enhanced.ppp.eticomm.net ([206.228.183.5]:15860 "EHLO
	intech19.enhanced.com") by vger.kernel.org with ESMTP
	id <S130649AbRCIWaM>; Fri, 9 Mar 2001 17:30:12 -0500
To: Russell King <rmk@arm.linux.org.uk>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.2.x kernels not filling in siginfo_t.si_addr on SEGV?
In-Reply-To: <Pine.LNX.4.30.0103081610400.31071-100000@hill.cs.ucr.edu> <54itljvcwo.fsf@intech19.enhanced.com> <20010309083035.A27596@flint.arm.linux.org.uk>
From: Camm Maguire <camm@enhanced.com>
Date: 09 Mar 2001 17:29:20 -0500
In-Reply-To: Russell King's message of "Fri, 9 Mar 2001 08:30:35 +0000"
Message-ID: <54wv9ymv9b.fsf@intech19.enhanced.com>
X-Mailer: Gnus v5.7/Emacs 20.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings, and thanks for your reply!

Russell King <rmk@arm.linux.org.uk> writes:

> On Thu, Mar 08, 2001 at 10:28:39PM -0500, Camm Maguire wrote:
> > Greetings, and thank you so much for your helpful reply!  Was this on
> > an i386?  I'm specifically looking for a way to do his on arm, alpha,
> > and sparc, and I don't believe they have the cr2 member of struct
> > sigcontext.  Any info you might have, including where you found this
> > solution, would be appreciated!
> 
> ARM does have this information available of course (its required for the
> page fault processing), but it didn't fill in the tss struct with the
> address in 2.2 kernels.  In 2.4, we use the siginfo stuff.
> 
> You're the first person to report that it doesn't.  We do have an
> "tss.address" member which should be filled in however.
> 

Thanks so much for this info.  Does this mean that given the siginfo_t
and sigcontext pointers, one cannot find this address anywhere by
poking around at a specified offset, or something?  Roman Hodek came
up with the following rather elaborate scheme for m68k:
=============================================================================
/* GET_FAULT_ADDR is a bit complicated to implement on m68k, because the fault
   address can't be found directly in the sigcontext. One has to look at the
   CPU frame, and that one is different for each CPU.
   */
#define GET_FAULT_ADDR(sig,code,sv,a) \
    ({															\
		struct sigcontext *scp = (struct sigcontext *)(sv);		\
		int format = (scp->sc_formatvec >> 12) & 0xf;			\
		unsigned long *framedata = (unsigned long *)(scp + 1);	\
		unsigned long ea;										\
		if (format == 0xa || format == 0xb)						\
			/* 68020/030 */										\
			ea = framedata[2];									\
		else if (format == 7)									\
			/* 68040 */											\
			ea = framedata[3];									\
		else if (format == 4) {									\
			/* 68060 */											\
			ea = framedata[0];									\
			if (framedata[1] & 0x08000000)						\
				/* correct addr on misaligned access */			\
				ea = (ea+4095)&(~4095);							\
		}														\
		ea;														\
	})
#endif
=============================================================================

Is there any analog for arm (or alpha, sparc, etc. for that matter)
for current 2.2.x kernels?

Thanks again!


> 

-- 
Camm Maguire			     			camm@enhanced.com
==========================================================================
"The earth is but one country, and mankind its citizens."  --  Baha'u'llah
