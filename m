Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131613AbRBJSBm>; Sat, 10 Feb 2001 13:01:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131614AbRBJSBc>; Sat, 10 Feb 2001 13:01:32 -0500
Received: from colorfullife.com ([216.156.138.34]:43525 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S131613AbRBJSB2>;
	Sat, 10 Feb 2001 13:01:28 -0500
Message-ID: <3A8581C2.4C0ECC05@colorfullife.com>
Date: Sat, 10 Feb 2001 19:00:34 +0100
From: Manfred Spraul <manfred@colorfullife.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.1-ac9 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Doug Ledford <dledford@redhat.com>
CC: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [beta patch] SSE copy_page() / clear_page()
In-Reply-To: <3A846C84.109F1D7D@colorfullife.com> <961rkk$fgm$1@penguin.transmeta.com> <3A847729.2C868879@redhat.com> <3A850555.488DE444@colorfullife.com> <3A8577FD.AEFDBB56@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Doug Ledford wrote:
> 
> It's not whether or not your particular code does it.  It's whether or not it
> can happen in the framework within which you are using the FPU regs.  No, with
> just copy/clear page using these things it won't happen.  But if you add an
> SSE zero page function, who's to say that we shouldn't add a memset routine,
> or a copy_*_user routines, or copy_csum* routines that also use the SSE regs?
> And once you add those various routines, are they all going to be safe with
> respect to each other (the tricky one's here are if you add the copy_*_user
> stuff since they can pagefault in the middle of the operation)?

copy_*_user is probably not worth the effort for a Pentium III, but even
for that function I don't see a problem with SSE, as long as
* the clobbered registers are stored on the stack (and not in
thread.i387.fxsave)
* the SSE/SSE2 instructions can't cause SIMD exceptions.
* noone saves the fpu state into thread.i387.fxsave from interrupts /
softirq's. Currently it's impossible, but I haven't checked Montavista's
preemptive kernel scheduler.

> So, that's the policy decision that
> needs to be made (and Linus typically has made it very difficult to get this
> stuff accepted into the kernel, which is an implicit statement of that policy)
> before a person can decide if your patch is sufficient, or if it needs
> additional protection from other possible SSE/MMX using routines.
>

The policy decision was already done: someone added SSE support for
raid5 xor - and that's part of 2.4.1, whereas I proposed a beta patch.

Now back to raid5: in which context are the xor functions called?

If they are called from irq or softirq context then the MMX
implementation would contain a bug:
>>>
#define FPU_SAVE                                                       
\
  do {                                                                 
\
        if (!(current->flags & PF_USEDFPU))                            
\
                __asm__ __volatile__ (" clts;\n");                     
\
        __asm__ __volatile__ ("fsave %0; fwait": "=m"(fpu_save[0]));   
\
  } while (0)
<<<<<<<
FP_USEDFPU is not atomically following the bit in %%cr0.

The SSE code is not affected: it relies on %%cr0 and doesn't use
current->flags.

OTHO if they are called from process context then these functions might
cause bugs with Montavista's preemptive kernel scheduling: what if the
scheduler is called in the middle of a raid checksum?

--
	Manfred

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
