Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266851AbSKOWYr>; Fri, 15 Nov 2002 17:24:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266852AbSKOWY3>; Fri, 15 Nov 2002 17:24:29 -0500
Received: from are.twiddle.net ([64.81.246.98]:7814 "EHLO are.twiddle.net")
	by vger.kernel.org with ESMTP id <S266851AbSKOWXv>;
	Fri, 15 Nov 2002 17:23:51 -0500
Date: Fri, 15 Nov 2002 14:30:45 -0800
From: Richard Henderson <rth@twiddle.net>
To: Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org
Subject: Re: in-kernel linking issues
Message-ID: <20021115143045.C25624@twiddle.net>
Mail-Followup-To: Rusty Russell <rusty@rustcorp.com.au>,
	linux-kernel@vger.kernel.org
References: <p73wunfv5b0.fsf@oldwotan.suse.de> <20021115084757.A640A2C145@lists.samba.org> <20021115045146.A23944@twiddle.net> <20021115131645.A2168@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021115131645.A2168@flint.arm.linux.org.uk>; from rmk@arm.linux.org.uk on Fri, Nov 15, 2002 at 01:16:45PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 15, 2002 at 01:16:45PM +0000, Russell King wrote:
> I'm slightly worried about this.  For things like shared libraries to be
> relocatable on ARM on current toolchains, you need to build with -fPIC.

Err, no you don't.  You only need that if you want to share pages,
which is clearly not an issue with kernel modules.  There are no
restrictions of which I am aware that require ARM to build with -fpic.

My test case,

	int i;
	int foo() { return bar() + i; }
	int j __attribute__((section(".init.data")));
	int __attribute__((section(".init.text")))
	baz() { return i + j; }

works exactly as desired on ARM:

Disassembly of section .text:

00000000 <foo>:
   0:   e52de004        str     lr, [sp, -#4]!
   4:   ebfffffe        bl      4 <foo+0x4>
   8:   e59f3008        ldr     r3, [pc, #8]    ; 18 <foo+0x18>
   c:   e5933000        ldr     r3, [r3]
  10:   e0800003        add     r0, r0, r3
  14:   e49df004        ldr     pc, [sp], #4

Disassembly of section .init.text:

00001000 <baz>:
    1000:       e59f3010        ldr     r3, [pc, #16]   ; 1018 <baz+0x18>
    1004:       e5930000        ldr     r0, [r3]
    1008:       e59f300c        ldr     r3, [pc, #12]   ; 101c <baz+0x1c>
    100c:       e5933000        ldr     r3, [r3]
    1010:       e0800003        add     r0, r0, r3
    1014:       e1a0f00e        mov     pc, lr

Relocation section '.rel.dyn' at offset 0x11258 contains 4 entries:
 Offset     Info    Type            Sym.Value  Sym. Name
00000004  00001501 R_ARM_PC24        00000000   bar
00000018  00001202 R_ARM_ABS32       00000040   i
00001018  00001202 R_ARM_ABS32       00000040   i
0000101c  00000f02 R_ARM_ABS32       00001020   j



r~
