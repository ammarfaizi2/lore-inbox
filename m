Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271788AbRH2BZw>; Tue, 28 Aug 2001 21:25:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271824AbRH2BZn>; Tue, 28 Aug 2001 21:25:43 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:11785 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S271788AbRH2BZ1>; Tue, 28 Aug 2001 21:25:27 -0400
Date: Tue, 28 Aug 2001 18:23:08 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Andreas Bombe <andreas.bombe@munich.netsurf.de>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] yenta resource allocation fix
In-Reply-To: <20010829013318.A16910@storm.local>
Message-ID: <Pine.LNX.4.33.0108281814470.978-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 29 Aug 2001, Andreas Bombe wrote:
>
> I'm no expert on the PCI/CardBus bridge stuff, but let's see:  The OR
> operation on the range end register with 0xfff seems pretty bogus to me.

No. The windows are supposed to be in "pages", so what the code does is to
say
 - we read the start page and the end page
 - the end is up-to-and-including the final page, so if both start and end
   were "page 1" (0x1000), that actually means that the area is from
   0x1000 to 0x1fff

> Also the "if (start && ..." was always true since start included the 32
> bit IO flag.  What my patch does is to mask out the IO flags on both
> start and end if the resource is indeed an IO resource, which seems
> correct to me.

Now, the masking off of the low bits is very possibly the right thing. I
don't have the documentation on what the low bits contain in front of me,
I'll try to find it. But I suspect that _that_ part of the patch may be
right.

Does it work for you if you do a minimal one-liner patch

-	start = config_readl(socket, offset);
+	start = config_readl(socket, offset) & ~0xfff;
 	end = config_readl(socket, offset+4) | 0xfff;
 	if (start && end > start) {
 		res->start = start;
 		res->end = end;

instead?

> Some additional data for the missed card insertions:  I put printk()s in
> yenta_interrupt() and yenta_bh() printing events (yenta_bh() just out of
> curiosity, no events get lost/delayed between interrupt and bh, all fine
> there).
>
> This showed that the first insertion after module load doesn't even
> arrive as an interrupt.  After that, with only pcmcia_core and
> yenta_socket loaded, every card removal and insertion show up as event
> 0x80 (to be more precise cb_event 0x6, csc 0x0).

This sounds like a separate problem, and might be due to not ACK'ing the
changes (ie writing the status register with all ones) always. But we _do_
do the

	cb_writel(socket, CB_SOCKET_EVENT, -1);
	cb_writel(socket, CB_SOCKET_MASK, CB_CDMASK);

at init time - I wonder if they should be done in the reverse order..

		Linus

