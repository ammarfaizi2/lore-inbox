Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315503AbSFJQmG>; Mon, 10 Jun 2002 12:42:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315539AbSFJQmF>; Mon, 10 Jun 2002 12:42:05 -0400
Received: from mailrelay.nefonline.de ([212.114.153.196]:17417 "EHLO
	mailrelay.nefonline.de") by vger.kernel.org with ESMTP
	id <S315503AbSFJQmD>; Mon, 10 Jun 2002 12:42:03 -0400
Message-Id: <200206101642.SAA30947@myway.myway.de>
From: "Daniela Engert" <dani@ngrt.de>
To: "Martin Wilck" <Martin.Wilck@Fujitsu-Siemens.com>
Cc: "Linux Kernel mailing list" <linux-kernel@vger.kernel.org>
Date: Mon, 10 Jun 2002 18:41:56 +0200 (CDT)
Reply-To: "Daniela Engert" <dani@ngrt.de>
X-Mailer: PMMail 2.20.2200 for OS/2 Warp 4.05
In-Reply-To: <1023724379.23630.309.camel@biker.pdb.fsc.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Subject: Re: Serverworks OSB4 in impossible state
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Martin,

On 10 Jun 2002 17:52:58 +0200, Martin Wilck wrote:

>We have a CD with a corrupt last block. If we try to read this block in
>PIO mode (hdparm -d 0 /dev/hdc) , we get errors like in the first
>attachment.

The error code returned is "check condition" with a sense key of 3
"medium error". The most appropriate driver action would have been to
issue a "request sense" command to learn the precise error and retry
only in case of a good chance of a recoverable problem - but that's a
different story.

>If we read the block in DMA mode (with dd), the machine stalls with the
>"impossible state" message.
>
>A PCI bus scan reveals that the IO register (dma_base+2) contains indeed
>0xa5 (bit 0 set), which leads to the panic. Normally the read on that
>register returns 0xa0.

The intersting bits of the DMA status register are bits 0 though 2. A
value of 5 indicates the condition "interrupt from unit, DMA state
machine active". This is a valid status! It basically means the unit
issued an interrupt before the PRD table is exhausted. This makes sense
because the CD-ROM units fails to transfer the amount of data described
by the PRD table because of the non-recoverable read error.

>We see in our PCI bus scan that a successful DMA of 4096 bytes was
>carried out ~23ms before the stall condition. Another 4096 byte request
>was scheduled but never seen. Between the successful DMA and the stall
>condition we see nothing but a few timer interrupts.
>Then an IDE interrupt occurs, which leads immediately to the panic.

What you makes sense (the next DMA transfer is scheduled but never
carried out by the CD-ROM unit) except for the panic, ofcoz. The
correct driver action in this case were stopping the DMA engine and
issuing a reset of the state machines involved (both on the host and
the unit side).

>Any ideas/comments?

I hope this clears up things a little ...

Ciao,
  Dani


