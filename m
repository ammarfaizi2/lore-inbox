Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964793AbWAZQkl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964793AbWAZQkl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 11:40:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964802AbWAZQkk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 11:40:40 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:59150 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S964793AbWAZQkh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 11:40:37 -0500
Date: Thu, 26 Jan 2006 16:40:21 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Grant Grundler <grundler@parisc-linux.org>
Cc: Akinobu Mita <mita@miraclelinux.com>, linux-kernel@vger.kernel.org,
       Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Ian Molton <spyro@f2s.com>,
       dev-etrax@axis.com, David Howells <dhowells@redhat.com>,
       Yoshinori Sato <ysato@users.sourceforge.jp>,
       Linus Torvalds <torvalds@osdl.org>, linux-ia64@vger.kernel.org,
       Hirokazu Takata <takata@linux-m32r.org>, linux-m68k@vger.kernel.org,
       Greg Ungerer <gerg@uclinux.org>, linux-mips@linux-mips.org,
       parisc-linux@parisc-linux.org, linuxppc-dev@ozlabs.org,
       linux390@de.ibm.com, linuxsh-dev@lists.sourceforge.net,
       linuxsh-shmedia-dev@lists.sourceforge.net, sparclinux@vger.kernel.org,
       ultralinux@vger.kernel.org, Miles Bader <uclinux-v850@lsi.nec.co.jp>,
       Andi Kleen <ak@suse.de>, Chris Zankel <chris@zankel.net>
Subject: Re: [parisc-linux] Re: [PATCH 3/6] C-language equivalents of include/asm-*/bitops.h
Message-ID: <20060126164020.GA27222@flint.arm.linux.org.uk>
Mail-Followup-To: Grant Grundler <grundler@parisc-linux.org>,
	Akinobu Mita <mita@miraclelinux.com>, linux-kernel@vger.kernel.org,
	Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
	Ian Molton <spyro@f2s.com>, dev-etrax@axis.com,
	David Howells <dhowells@redhat.com>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Linus Torvalds <torvalds@osdl.org>, linux-ia64@vger.kernel.org,
	Hirokazu Takata <takata@linux-m32r.org>,
	linux-m68k@lists.linux-m68k.org, Greg Ungerer <gerg@uclinux.org>,
	linux-mips@linux-mips.org, parisc-linux@parisc-linux.org,
	linuxppc-dev@ozlabs.org, linux390@de.ibm.com,
	linuxsh-dev@lists.sourceforge.net,
	linuxsh-shmedia-dev@lists.sourceforge.net,
	sparclinux@vger.kernel.org, ultralinux@vger.kernel.org,
	Miles Bader <uclinux-v850@lsi.nec.co.jp>, Andi Kleen <ak@suse.de>,
	Chris Zankel <chris@zankel.net>
References: <20060125112625.GA18584@miraclelinux.com> <20060125113206.GD18584@miraclelinux.com> <20060125200250.GA26443@flint.arm.linux.org.uk> <20060126000618.GA5592@twiddle.net> <20060126085540.GA15377@flint.arm.linux.org.uk> <20060126161849.GA13632@colo.lackof.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060126161849.GA13632@colo.lackof.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 26, 2006 at 09:18:49AM -0700, Grant Grundler wrote:
> On Thu, Jan 26, 2006 at 08:55:41AM +0000, Russell King wrote:
> > Unfortunately that's not correct.  You do not appear to have checked
> > the compiler output like I did - this code does _not_ generate
> > constant shifts.
> 
> Russell,
> By "written stupidly", I thought Richard meant they could have
> used constants instead of "s".  e.g.:
> 	if (word << 16 == 0) { b += 16; word >>= 16); }
> 	if (word << 24 == 0) { b +=  8; word >>=  8); }
> 	if (word << 28 == 0) { b +=  4; word >>=  4); }
> 
> But I prefer what Edgar Toernig suggested.

Ok, I can see I'm going to lose this, but what the hell.

Firstly though, an out of line function call on ARM clobbers six out
of 11 CPU registers.

Let's compare the implementations, which are:

int toernig_ffs(unsigned long word)
{
    int bit = 0;
    word &= -word; // only keep the lsb.
    if (word & 0xffff0000) bit |= 16;
    if (word & 0xff00ff00) bit |=  8;
    if (word & 0xf0f0f0f0) bit |=  4;
    if (word & 0xcccccccc) bit |=  2;
    if (word & 0xaaaaaaaa) bit |=  1;
    return bit;
}

toernig_ffs:
        rsb     r3, r0, #0
        and     r0, r0, r3
        mov     r3, r0, lsr #16
        bic     r2, r0, #16711680
        str     lr, [sp, #-4]!
        mov     r3, r3, asl #16
        ldr     lr, .L7
        ldr     r1, .L7+4
        ldr     ip, .L7+8
        cmp     r3, #0
        bic     r2, r2, #255
        and     lr, r0, lr
        and     r1, r0, r1
        and     ip, r0, ip
        movne   r0, #16
        moveq   r0, #0
        cmp     r2, #0
        orrne   r0, r0, #8
        cmp     r1, #0
        orrne   r0, r0, #4
        cmp     ip, #0
        orrne   r0, r0, #2
        cmp     lr, #0
        orrne   r0, r0, #1
        ldr     pc, [sp], #4
.L8:
        .align  2
.L7:
        .word   -1431655766
        .word   -252645136
        .word   -858993460

25 instructions.  3 words of additional data.  5 registers.  0 register
based shifts.

I feel that this is far too expensive to sanely inline - at least three
words of additional data for a use in a function, and has a high register
usage comparable to that of an out of line function.

int mita_ffs(unsigned long word)
{
     int b = 0, s;
     s = 16; if (word << 16 != 0) s = 0; b += s; word >>= s;
     s =  8; if (word << 24 != 0) s = 0; b += s; word >>= s;
     s =  4; if (word << 28 != 0) s = 0; b += s; word >>= s;
     s =  2; if (word << 30 != 0) s = 0; b += s; word >>= s;
     s =  1; if (word << 31 != 0) s = 0; b += s;
     return b;
}

mita_ffs:
        movs    r1, r0, asl #16
        moveq   r2, #16
        movne   r2, #0
        mov     r0, r0, lsr r2		@ register-based shift
        mov     r3, r2
        movs    r2, r0, asl #24
        moveq   r2, #8
        movne   r2, #0
        mov     r0, r0, lsr r2		@ register-based shift
        movs    r1, r0, asl #28
        add     r3, r3, r2
        moveq   r2, #4
        movne   r2, #0
        mov     r0, r0, lsr r2		@ register-based shift
        movs    r1, r0, asl #30
        add     r3, r3, r2
        moveq   r2, #2
        movne   r2, #0
        mov     r0, r0, lsr r2		@ register-based shift
        tst     r0, #1
        add     r3, r3, r2
        moveq   r2, #1
        movne   r2, #0
        add     r3, r3, r2
        mov     r0, r3
        mov     pc, lr

26 instructions.  4 registers used.  4 unconditional register-based
shifts (expensive).

Better, but uses inefficient register based shifts (which can take twice
as many cycles as non-register based shifts depending on the CPU).  Still
has a high usage on CPU registers though.  Could possibly be a candidate
for inlining.

int arm_ffs(unsigned long word)
{
     int k = 31;
     if (word & 0x0000ffff) { k -= 16; word <<= 16; }
     if (word & 0x00ff0000) { k -= 8;  word <<= 8;  }
     if (word & 0x0f000000) { k -= 4;  word <<= 4;  }
     if (word & 0x30000000) { k -= 2;  word <<= 2;  }
     if (word & 0x40000000) { k -= 1; }
     return k;
}

arm_ffs:
        mov     r3, r0, asl #16
        mov     r3, r3, lsr #16
        cmp     r3, #0
        movne   r0, r0, asl #16
        mov     r3, #31
        movne   r3, #15
        tst     r0, #16711680
        movne   r0, r0, asl #8
        subne   r3, r3, #8
        tst     r0, #251658240
        movne   r0, r0, asl #4
        subne   r3, r3, #4
        tst     r0, #805306368
        movne   r0, r0, asl #2
        subne   r3, r3, #2
        tst     r0, #1073741824
        subne   r3, r3, #1
        mov     r0, r3
        mov     pc, lr

19 instructions.  2 registers.  0 register based shifts.  More reasonable
for inlining.

Clearly the smallest of the lot with the smallest register pressure,
being the best candidate out of the lot, whether we inline it or not.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
