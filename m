Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267979AbRHATRc>; Wed, 1 Aug 2001 15:17:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267975AbRHATRW>; Wed, 1 Aug 2001 15:17:22 -0400
Received: from chaos.analogic.com ([204.178.40.224]:2432 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S267974AbRHATRM>; Wed, 1 Aug 2001 15:17:12 -0400
Date: Wed, 1 Aug 2001 15:16:51 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: "James W. Lake" <jim@intra.blueskylabs.com>
cc: "Linux Kernel Mailing List (E-mail)" <linux-kernel@vger.kernel.org>
Subject: Re: Memory Write Ordering Question
In-Reply-To: <32B25F556FCD9D418D73C742C9B2E36D0188CC@barney.intra.blueskylabs.com>
Message-ID: <Pine.LNX.3.95.1010801145918.530A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Aug 2001, James W. Lake wrote:

> 
> Hello,
> 
> I've run into a problem with memory write ordering on a PCI Device.  
> 
> The  card has 2 memory regions, pthis->pConfigMem (PCI Chip
> Configuration), and pthis->pDspMem (A DSP's memory on the PCI Card)
> 
> The code sequence below doesn't work out as expected.  The
> writel(temp,addr); at the bottom actually occurs in the middle of the
> memcpy_toio() operation.
[SNIPPED...]

A PCI bus master will defer writes until its cache gets full or
a read is requested. You can force the pending writes to complete
with any read. You can also configure some devices to not defer writes
(Cache-line Size register).

This "bursting" is a characteristic of PCI masters which allows
them to transfer data in groups of long-words, typically up to
16 long-words at a time.

If you need PCI access to be atomic, without disabling its cache
which slows down access, do a dummy read from anywhere within the
device address space, at places where you must guarantee that
previous data were written (like when configuring registers).

Sometimes the reads don't have to be 'dummy' sometimes you can
reorder device configuration transactions so that the required
result is achieved.

Also, make sure that you use ioremap_nocache() when setting up
access to the device. That solves another cache problem where
some reads may be read from memory rather than even accessing
the PCI bus.

Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).

    I was going to compile a list of innovations that could be
    attributed to Microsoft. Once I realized that Ctrl-Alt-Del
    was handled in the BIOS, I found that there aren't any.


