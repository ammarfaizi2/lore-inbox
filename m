Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757385AbWK0Icj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757385AbWK0Icj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Nov 2006 03:32:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757386AbWK0Icj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Nov 2006 03:32:39 -0500
Received: from smtp4-g19.free.fr ([212.27.42.30]:42148 "EHLO smtp4-g19.free.fr")
	by vger.kernel.org with ESMTP id S1757385AbWK0Ici (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Nov 2006 03:32:38 -0500
From: Duncan Sands <duncan.sands@math.u-psud.fr>
To: "Ilyes Gouta" <ilyes.gouta@gmail.com>,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: [USB] urb->number_of_packets = 256 !
Date: Mon, 27 Nov 2006 09:32:30 +0100
User-Agent: KMail/1.9.5
Cc: linux-kernel@vger.kernel.org
References: <234fa2210611251242g2497f9bby2a3bf867324b73b3@mail.gmail.com>
In-Reply-To: <234fa2210611251242g2497f9bby2a3bf867324b73b3@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611270932.30564.duncan.sands@math.u-psud.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ilyes, you won't be able to allocate that much *contiguous* memory,
but you should be able to allocate enough non-contiguous memory (e.g.
by calling __get_free_page 256 times; not the same as calling
__get_free_pages(8) !).  To use that memory, you can try using the usb
scatter/gather support (see usb.h); I don't know if it works with
isochronous urbs though.  I've CC'd the usb development list - maybe
someone there can help.

Ciao,

Duncan.

On Saturday 25 November 2006 21:42, Ilyes Gouta wrote:
> Hi!
> 
> I'm working on a driver for my USB 2.0 high-speed webcam under Linux
> and I'm using a tool
> called usbsnoop, which was designed for Windows, to get an idea on the exchanged
> information between the host and the webcam. By examining the produced
> trace file, I found
> that my PC is sending a bunch of isochronous URBs to the webcam where
> each one contains
> 256 isochronous packets and each packet is 3072 bytes wide. This means
> that every URB
> points to a 256 * 3072 bytes sized buffer.
> 
> Here is an excerpt of the trace file:
> 
> [21303 ms]  >>>  URB 1640 going down  >>>
> -- URB_FUNCTION_ISOCH_TRANSFER:
>   PipeHandle           = ff27dd8c [endpoint 0x00000081]
>   TransferFlags        = 00000005 (USBD_TRANSFER_DIRECTION_IN,
> ~USBD_SHORT_TRANSFER_OK,
> USBD_START_ISO_TRANSFER_ASAP
>   TransferBufferLength = 000c0000
>   TransferBuffer       = fd319100
>   TransferBufferMDL    = 00000000
>   StartFrame           = 00000000
>   NumberOfPackets      = 00000100 // in hex
>   IsoPacket[0].Offset = 0
>   IsoPacket[0].Length = 0
>   IsoPacket[1].Offset = 3072
>   IsoPacket[1].Length = 0
>   IsoPacket[2].Offset = 6144
>   IsoPacket[2].Length = 0
> 
> I tried to program this behavior in my custom, alpha stage, kernel
> driver, however I was
> disappointed since Linux fails to allocate, using kmalloc(), such a
> huge buffer (which is
> quite normal actually) to associated to the URB through the
> transfer_buffer field. I also
> tried __get_free_pages(GFP_KERNEL, 10) without any success whatsoever.
> 
> Splitting the transfer across multiple URB doesn't seem to work (I didn't really
> investigate in depth this possibility).
> 
> Any ideas?
> 
> Thanks for your time!
> 
> P.S: Is it possible to CC me since I didn't subscribe to the mailing
> list? Thanks!
> 
> Best regards,
> Ilyes Gouta.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
