Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268347AbTAMV2s>; Mon, 13 Jan 2003 16:28:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268348AbTAMV2s>; Mon, 13 Jan 2003 16:28:48 -0500
Received: from chaos.analogic.com ([204.178.40.224]:42885 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S268347AbTAMV2r>; Mon, 13 Jan 2003 16:28:47 -0500
Date: Mon, 13 Jan 2003 16:40:37 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Jeff Garzik <jgarzik@pobox.com>
cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Ross Biro <rossb@google.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Alan Cox <alan@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.21-pre3-ac4
In-Reply-To: <20030113212406.GA13531@gtf.org>
Message-ID: <Pine.LNX.3.95.1030113162939.30920A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Jan 2003, Jeff Garzik wrote:

> On Mon, Jan 13, 2003 at 08:03:29PM +0100, Benjamin Herrenschmidt wrote:
> > Exactly. My problem right now is with enforcing that 400ns delay on
> > non-DMA path as with PCI write posting on one side, and other fancy bus
> > store queues etc... you are really not sure when your outb for the
> > command byte will really reach the disk.
> 
> As a slight tangent, PCI write posting is quite annoying because on some
> hardware one simply cannot perform a read immediately after a write,
> without pausing for a hardware-specified amount of time.
> 
> ...but, at the same time, who knows how long the write posting may take,
> so one doesn't know how long the delay really needs to be.
> 
> It would be nice if there was an arch-specific flush-posted-writes hook
> [wmb_mmio() ?], if that was possible on write-posting CPUs.  Currently
> right now the canonical solution ("MMIO read") doesn't work in some
> situations, and I do think we have a solution at all for those "some
> situations."
> 
> 	Jeff
> 

There is a well-defined procedure for this. Any "read" anywhere
in the PCI address space, will force all posted writes to complete.
However, the "read" will not be the data one would obtain after
the write completes. Therefore, to guarantee that all posted
writes complete before you read, for instance, status that could
be affected by that write, you execute a dummy read anywhere in
PCI address space, somewhere that will not screw up your
status. In other words, you don't read your device status twice,
once to post the writes and once to get the status because some
hardware will detect the read and fail to give you the correct
status on the second read. Instead, you read some 'harmless' register
that your hardware will decode, but not muck up the status. You
don't want to read a nonexistant register because this will cause
a lonnnnnnng bus-timeout. It will work to flush pending writes, but
it's slow.


Cheers,
Dick Johnson
Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
Why is the government concerned about the lunatic fringe? Think about it.


