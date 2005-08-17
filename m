Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750835AbVHQEzH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750835AbVHQEzH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Aug 2005 00:55:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750836AbVHQEzG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Aug 2005 00:55:06 -0400
Received: from ns.miraclelinux.com ([219.118.163.66]:21447 "EHLO
	mail01.miraclelinux.com") by vger.kernel.org with ESMTP
	id S1750835AbVHQEzF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Aug 2005 00:55:05 -0400
Date: Wed, 17 Aug 2005 13:50:22 +0900 (JST)
Message-Id: <20050817.135022.596527188.hyoshiok@miraclelinux.com>
To: 76306.1226@compuserve.com
Cc: lkml.hyoshiok@gmail.com, taka@valinux.co.jp, arjan@infradead.org,
       linux-kernel@vger.kernel.org, hyoshiok@miraclelinux.com,
       hyoshiok@miraclelinux.com
Subject: Re: [RFC] [PATCH] cache pollution aware __copy_from_user_ll()
From: Hiro Yoshioka <hyoshiok@miraclelinux.com>
In-Reply-To: <20050817.082153.719902707.hyoshiok@miraclelinux.com>
References: <200508161412_MC3-1-A759-465F@compuserve.com>
	<20050817.082153.719902707.hyoshiok@miraclelinux.com>
X-Mailer: Mew version 3.3 on XEmacs 21.4.13 (Rational FORTRAN)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hiro Yoshioka <hyoshiok@miraclelinux.com>
Subject: Re: [RFC] [PATCH] cache pollution aware __copy_from_user_ll()
Date: Wed, 17 Aug 2005 08:21:53 +0900 (JST)
Message-ID: <20050817.082153.719902707.hyoshiok@miraclelinux.com>

> Chuck,
> 
> From: Chuck Ebbert <76306.1226@compuserve.com>
> > On Tue, 16 Aug 2005 at 19:16:17 +0900 (JST), Hiro Yoshioka wrote:
> > > oh, really? Does the linux kernel take care of
> > > SSE save/restore on a task switch?
> > 
> >  Check out XMMS_SAVE and XMMS_RESTORE in include/asm-i386/xor.h
> 
> Thanks for your suggestion. But it seems to me it won't help
> when we have a page fault or other exeptions.

Hi,

Let me understand what the kernel does save/resfore FPU/MMX/XMM
registers. Please let me know if I'm wrong.

1) kernel_fpu_begin()
     preempt_disable()
     if TS_USEDFPU then
       __save_init_fpu()
        ... save to tsk->thread.i387.f*save
        clear TS_USEDFPU flag of tsk->thread_info->status
     else
        clts() --- clear TS flag of CR0

2) copy 
     MMX/XMM registers are used.

3) page faults/exceptions/...
3-1  TS flag is set by the CPU (Am I right?)
     if nobody uses MMX/XMM
3-2     it's fine. we don't need save/restore
     else
3-3     MMX/XMM is used

          When TS flag is set, the CPU monitors the instruction stream
of X87 FPU/MMX/SSE/SSE2 instructions. When the CPU detects one of
these instruction, it raises a device-not-available exception (#NM)
prior to executing the instruction. (IA32 Software Developer's Manual,
Vol. 3, 12.5.1)

          math_state_restore() is the device-not-available exception
             clts()
             if (!tsk_used_math(tsk))
                    init_fpu(tsk);
             restore_fpu(tsk);
             set TS_USEDFPU;

4) kernel_fpu_end()
     stts(); set TS flag of CR0
     preempt_enable();

It seems to me that the kernel automatically save/restore FPU/MMX/XMM
registers.

What's wrong with it? Do I misunderstand it?

Regards,
  Hiro
