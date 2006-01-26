Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030201AbWAZXER@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030201AbWAZXER (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 18:04:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030202AbWAZXEQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 18:04:16 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:33804 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1030201AbWAZXEP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 18:04:15 -0500
Date: Thu, 26 Jan 2006 23:03:54 +0000
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
Message-ID: <20060126230353.GC27222@flint.arm.linux.org.uk>
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
References: <20060125112625.GA18584@miraclelinux.com> <20060125113206.GD18584@miraclelinux.com> <20060125200250.GA26443@flint.arm.linux.org.uk> <20060126000618.GA5592@twiddle.net> <20060126085540.GA15377@flint.arm.linux.org.uk> <20060126161849.GA13632@colo.lackof.org> <20060126164020.GA27222@flint.arm.linux.org.uk> <20060126230443.GC13632@colo.lackof.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060126230443.GC13632@colo.lackof.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 26, 2006 at 04:04:43PM -0700, Grant Grundler wrote:
> On Thu, Jan 26, 2006 at 04:40:21PM +0000, Russell King wrote:
> > Ok, I can see I'm going to lose this, but what the hell.
> 
> Well, we agree. As Richard Henderson just pointed out, parisc
> is among those that can't load large immediate values either.
> 
> > Let's compare the implementations, which are:
> ...
> > int arm_ffs(unsigned long word)
> > {
> >      int k = 31;
> >      if (word & 0x0000ffff) { k -= 16; word <<= 16; }
> >      if (word & 0x00ff0000) { k -= 8;  word <<= 8;  }
> >      if (word & 0x0f000000) { k -= 4;  word <<= 4;  }
> >      if (word & 0x30000000) { k -= 2;  word <<= 2;  }
> >      if (word & 0x40000000) { k -= 1; }
> >      return k;
> > }
> 
> Of those suggested, arm_ffs() is closest to what parisc
> currently has in assembly (see include/asm-parisc/bitops.h:__ffs()).
> But given how unobvious the parisc instruction nullification works,
> the rough equivalent in "C" (untested!) would look something like:
> 
> 	unsigned int k = 31;
> 	if (word & 0x0000ffff) { k -= 16;} else { word >>= 16; }
> 	if (word & 0x000000ff) { k -=  8;} else { word >>= 8; }
> 	if (word & 0x0000000f) { k -=  4;} else { word >>= 4; }
> 	if (word & 0x00000003) { k -=  2;} else { word >>= 2; }
> 	if (word & 0x00000001) { k -=  1;}
> 	return k;
> 
> I doubt that's better for arm but am curious how it compares.
> You have time to try it?

This is essentially the same as arm_ffs():

grundler_ffs:
        mov     r3, r0, asl #16
        mov     r3, r3, lsr #16
        cmp     r3, #0
        moveq   r0, r0, lsr #16
        mov     r3, #31
        movne   r3, #15
        tst     r0, #255
        moveq   r0, r0, lsr #8
        subne   r3, r3, #8
        tst     r0, #15
        moveq   r0, r0, lsr #4
        subne   r3, r3, #4
        tst     r0, #3
        moveq   r0, r0, lsr #2
        subne   r3, r3, #2
        tst     r0, #1
        subne   r3, r3, #1
        mov     r0, r3
        mov     pc, lr

only that the shifts, immediate values and the sense of some of the
conditional instructions have changed.  Therefore, the parisc rough
equivalent looks like it would be suitable for ARM as well.

> > Clearly the smallest of the lot with the smallest register pressure,
> > being the best candidate out of the lot, whether we inline it or not.
> 
> Agreed. But I expect parisc will have to continue using it's asm
> sequence and ignore the generic version. AFAIK, the compiler isn't that
> good with instruction nullification and I have other issues I'd
> rather work on.

Me too - already solved this problem once.  However, I'd rather not
needlessly take a step backwards in the name of generic bitops.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
