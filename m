Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261555AbTCQKPZ>; Mon, 17 Mar 2003 05:15:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261559AbTCQKPZ>; Mon, 17 Mar 2003 05:15:25 -0500
Received: from mail2.sonytel.be ([195.0.45.172]:56494 "EHLO mail.sonytel.be")
	by vger.kernel.org with ESMTP id <S261555AbTCQKPY>;
	Mon, 17 Mar 2003 05:15:24 -0500
Date: Mon, 17 Mar 2003 11:25:51 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: James Bottomley <James.Bottomley@SteelEye.com>
cc: Osamu Tomita <tomita@cinet.co.jp>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Christoph Hellwig <hch@infradead.org>
Subject: Re: Complete support PC-9800 for 2.5.64-ac4 (11/11) SCSI
In-Reply-To: <1047853600.4371.40.camel@mulgrave>
Message-ID: <Pine.GSO.4.21.0303171119190.17453-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 16 Mar 2003, James Bottomley wrote:
> On Sun, 2003-03-16 at 14:00, Geert Uytterhoeven wrote:
> > On 16 Mar 2003, James Bottomley wrote:
> > > On Sun, 2003-03-16 at 12:36, Geert Uytterhoeven wrote:
> > > > Actually, it was my suggestion to remove the dereference for PIO accesses. In
> > > > that case SASR contains the I/O port register.
> > > 
> > > There's still something wrong with the implementation in this patch. 
> > > For non PIO SASR is defined as volatile unsigned char *SASR.  Its access
> > > has gone from being outb(n, *regs.SASR) to outb(n, regs.SASR).  What
> > > expansion can outb have on m68k and MIPS that makes this change
> > > idempotent?
> > 
> > outb() and friends are only used if CONFIG_WD33C93_PIO is set. In all other
> > cases, it uses the old implementation, e.g. `*regs.SASR = reg_num'.
> 
> Ah, OK, I see what it's doing.  Instead of having a single redefine of
> wd33c93_outb to be either outb or readb etc, it has a whole chunk of
> code in wd33c93.c that #ifdef's for this.
> 
> Perhaps, while you're cleaning this up, you'd like to move this into the
> header?  Shouldn't it also be using readb/writeb instead of just direct
> memory accesses?

No, readb() and friends are not defined on machines that don't have PCI. None
of the MMIO wd33c93 drivers are PCI.

However, it's fine for me to use in_8(addr) and out_8(addr,b) (cfr.
include/asm-m68k/raw_io.h) inside #if defined(__mc68000__) ||
defined(CONFIG_APUS).

On MIPS, it looks like you can use readb() and writeb(), since MIPS is less
picky than m68k about not defining PCI access primitives on machines without
PCI.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

