Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283594AbSAATzR>; Tue, 1 Jan 2002 14:55:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283310AbSAATzI>; Tue, 1 Jan 2002 14:55:08 -0500
Received: from mta6.snfc21.pbi.net ([206.13.28.240]:54697 "EHLO
	mta6.snfc21.pbi.net") by vger.kernel.org with ESMTP
	id <S283265AbSAATy6>; Tue, 1 Jan 2002 14:54:58 -0500
Date: Tue, 01 Jan 2002 11:53:31 -0800
From: David Brownell <david-b@pacbell.net>
Subject: Re: [linux-usb-devel] Re: "sr: unaligned transfer" in 2.5.2-pre1
To: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Cc: Jens Axboe <axboe@suse.de>, Matthew Dharm <mdharm@one-eyed-alien.net>,
        Greg KH <greg@kroah.com>
Message-id: <065e01c192fd$fe066e20$6800000a@brownell.org>
MIME-version: 1.0
X-MIMEOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
Content-type: text/plain; charset=iso-8859-1
Content-transfer-encoding: 7BIT
X-Priority: 3
X-MSMail-priority: Normal
In-Reply-To: <m2vgexzv90.fsf@ppro.localdomain> <20011223112249.B4493@kroah.com>
 <m23d1trr4w.fsf@pengo.localdomain> <20011230122756.L1821@suse.de>
 <20011230212700.B652@one-eyed-alien.net> <20011231125157.D1246@suse.de>
 <20011231145455.C6465@one-eyed-alien.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> (2) How do I pass a highmem address to the HCDs?  The URB structures we use
> don't seem particularly well-suited for this.

The urb->transfer_buffer is required to be normal DMA-able memory,
following the rules in Documentation/DMA-mapping.txt ... that got cleared
up somewhere around the 2.4.5 timeframe, all the HCDs now use the
pci_map_single() calls with those buffers.  kmalloc() is fine, not vmalloc(),
and so on.

Not that I've seen a writeup about highmem (linux/Documentation doesn't
seem to have one anyway) but if I infer correctly from that DMA-mapping.txt
writeup, URBs don't support it because there's no way to specify buffers as
a "struct page *" or an array of "struct scatterlist".  That's the only way that
document identifies to access "highmem memory".


> (1) Do the USB HCDs support highmem?  I seem to recall they do, but I'm not
> certain.

If URBs can't describe highmem, the HCD's won't support them per se;
you'd have to turn highmem to "lowmem" or whatever it's called, and
then let the HCDs manage the lowmem-to-dma_addr_t mappings.

Alternatively, in 2.5 we might add "highmem" support to USB.  Now that
I've looked at it a few minutes, I suspect we must -- just to support block
devices (usb-storage) fully.  Is there more to it than adding page+offset
as an alternative way to describe the transfer_buffer?  (And making all
the "single" mapping calls in the HCDs use page mappings.)

- Dave



