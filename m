Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271985AbRHVLQY>; Wed, 22 Aug 2001 07:16:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271984AbRHVLQO>; Wed, 22 Aug 2001 07:16:14 -0400
Received: from ns.suse.de ([213.95.15.193]:28432 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S271986AbRHVLQG>;
	Wed, 22 Aug 2001 07:16:06 -0400
To: Brian Gerst <bgerst@didntduck.org>
Cc: linux-kernel@vger.kernel.org, set@pobox.com, alan@lxorguk.ukuu.org.uk,
        Wilfried.Weissmann@gmx.at
Subject: Re: [OOPS] repeatable 2.4.8-ac7, 2.4.7-ac6 just run xdos
In-Reply-To: <20010819004703.A226@squish.home.loc.suse.lists.linux.kernel> <3B831CDF.4CC930A7@didntduck.org.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 22 Aug 2001 13:16:16 +0200
In-Reply-To: Brian Gerst's message of "22 Aug 2001 04:54:51 +0200"
Message-ID: <oupn14sny4f.fsf@pigdrop.muc.suse.de>
User-Agent: Gnus/5.0803 (Gnus v5.8.3) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brian Gerst <bgerst@didntduck.org> writes:

> > 
> > CPU:    0
> > EIP:    0010:[<c0180a18>]
> > Using defaults from ksymoops -t elf32-i386 -a i386
> > EFLAGS: 00010002
> > eax: 00001000   ebx: c4562368   ecx: 00000000   edx: 00000001
> > esi: c4562368   edi: c4a954d4   ebp: 00000001   esp: c6887d88
> > ds: 008   es: 0000   ss: 0018
>                 ^^^^
> Here is your problem.  %es is set to the null segment.  I had my
> suspicions about the segment reload optimisation in the -ac kernels, and
> this proves it.  Try backing out the changes to arch/i386/kernel/entry.S
> and include/asm-i386/hw_irq.h and see if that fixes the problem.

This patch should fix the problem. One assumption coded into the reload
optimization is violated by vm86 mode. Please test.

--- linux-2.4.8-ac7-work/include/asm-i386/hw_irq.h-SEG2	Mon Aug 20 02:54:53 2001
+++ linux-2.4.8-ac7-work/include/asm-i386/hw_irq.h	Wed Aug 22 13:02:16 2001
@@ -114,8 +114,10 @@
 	"cmpl %eax,7*4(%esp)\n\t"  \
 	"je 1f\n\t"  \
 	"movl %eax,%ds\n\t" \
+	"1: cmpl %eax,8*4(%esp)\n\t" \
+	"je 2f\n\t" \
 	"movl %eax,%es\n\t" \
-	"1:\n\t"
+	"2:\n\t"
 
 #define IRQ_NAME2(nr) nr##_interrupt(void)
 #define IRQ_NAME(nr) IRQ_NAME2(IRQ##nr)


-Andi
