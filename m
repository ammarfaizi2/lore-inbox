Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284793AbRLRT2D>; Tue, 18 Dec 2001 14:28:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284786AbRLRT0l>; Tue, 18 Dec 2001 14:26:41 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:27920 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S284557AbRLRTZy>; Tue, 18 Dec 2001 14:25:54 -0500
Message-ID: <3C1F9803.73A03973@zip.com.au>
Date: Tue, 18 Dec 2001 11:24:51 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.17-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: BURJAN Gabor <burjang@elte.hu>
CC: LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.17-rc1 kernel panic at boot
In-Reply-To: <3C1E2B61.3F9A685E@zip.com.au> <2375.1008649127@kao2.melbourne.sgi.com>,
		<2375.1008649127@kao2.melbourne.sgi.com> <20011218142339.GA12011@csoma.elte.hu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

BURJAN Gabor wrote:
> 
> Hello,
> 
> On Tue, Dec 18, Keith Owens wrote:
> 
> > Not need to go quite that far.  It is not necessary to recompile the
> > entire kernel nor do you need to boot a kernel to get the source code
> > for an instruction.
> >
> > cd linux
> > rm drivers/net/3c59x.o
> > make CFLAGS_3c59x.o=-g vmlinux
> > s=$(sed -ne '/vortex_probe1/s/ .*//p' System.map | tr '[a-z]' '[A-Z]')
> > e=$(echo -e "obase=16\nibase=16\n$s+500" | bc)
> > objdump -S --start-address=0x$s --stop-address=0x$e vmlinux
> 
> I did this.
> 
> c0264048:       39 32 00 0e     addi    r9,r18,14
> c026404c:       7d 29 52 14     add     r9,r9,r10
> c0264050:       91 7d 01 90     stw     r11,400(r29)    <==
>         vp->options = option;
> c0264054:       93 fd 01 8c     stw     r31,396(r29)
> 
> Full output: http://www.csoma.elte.hu/~burjang/objdump-2001-12-18.out

That particular statement looks OK.  I'd be suspecting the
next line:

    EL3WINDOW(0);

which is a rather sickly macro which does an outw(N, ioaddr), where
ioaddr was passed into the probe function from the PCI layer.

It seems that this is the first IO instruction which the driver
executes, and that's a likely place for it to crash.

My guess would be that something has gone wrong with the PPC
emulation of `outw' to this PCI device's IO space.

What I suggest you do is to add a

	printk("ioaddr=%lx\n", ioaddr);

immediately before that EL3WINDOW statement, then take it up
on the appropriate PPC mailing list.

-
