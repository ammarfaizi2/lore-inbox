Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271990AbRHVMBV>; Wed, 22 Aug 2001 08:01:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271992AbRHVMBL>; Wed, 22 Aug 2001 08:01:11 -0400
Received: from femail27.sdc1.sfba.home.com ([24.254.60.17]:48780 "EHLO
	femail27.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S271990AbRHVMBD>; Wed, 22 Aug 2001 08:01:03 -0400
Message-ID: <3B839E47.874F8F64@didntduck.org>
Date: Wed, 22 Aug 2001 07:57:59 -0400
From: Brian Gerst <bgerst@didntduck.org>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.9-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: linux-kernel@vger.kernel.org, set@pobox.com, alan@lxorguk.ukuu.org.uk,
        Wilfried.Weissmann@gmx.at
Subject: Re: [OOPS] repeatable 2.4.8-ac7, 2.4.7-ac6 just run xdos
In-Reply-To: <20010819004703.A226@squish.home.loc.suse.lists.linux.kernel> <3B831CDF.4CC930A7@didntduck.org.suse.lists.linux.kernel> <oupn14sny4f.fsf@pigdrop.muc.suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> 
> Brian Gerst <bgerst@didntduck.org> writes:
> 
> > >
> > > CPU:    0
> > > EIP:    0010:[<c0180a18>]
> > > Using defaults from ksymoops -t elf32-i386 -a i386
> > > EFLAGS: 00010002
> > > eax: 00001000   ebx: c4562368   ecx: 00000000   edx: 00000001
> > > esi: c4562368   edi: c4a954d4   ebp: 00000001   esp: c6887d88
> > > ds: 008   es: 0000   ss: 0018
> >                 ^^^^
> > Here is your problem.  %es is set to the null segment.  I had my
> > suspicions about the segment reload optimisation in the -ac kernels, and
> > this proves it.  Try backing out the changes to arch/i386/kernel/entry.S
> > and include/asm-i386/hw_irq.h and see if that fixes the problem.
> 
> This patch should fix the problem. One assumption coded into the reload
> optimization is violated by vm86 mode. Please test.

Yes.  What happened here is that %ds and %es were not being updated
atomically.  Under normal operation, this would just leave %es with
USER_DS, which is sufficiently equivalent to KERNEL_DS to not cause a
fault.  Coming out of vm86 mode however forces the data segment
registers to null after saving the real mode values on the stack.  If an
interrupt happened between setting %ds and %es (what are the odds?) then
that assumption would fail and leave %es null, causing the next string
instruction to go boom.  The same fix should be applied to entry.S as
well.

-- 

						Brian Gerst
