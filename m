Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282413AbRLFTEe>; Thu, 6 Dec 2001 14:04:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282499AbRLFTE1>; Thu, 6 Dec 2001 14:04:27 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:48900 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S282413AbRLFTCJ>; Thu, 6 Dec 2001 14:02:09 -0500
Date: Thu, 6 Dec 2001 10:55:26 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Linux/Pro  -- clusters
In-Reply-To: <E16C3Kn-0002XC-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.33.0112061044150.10877-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 6 Dec 2001, Alan Cox wrote:
>
> The scsi controller is akin to a network driver. The stuff that matters is
> stuff like the scsi disk, scsi cd and scsi tape drivers. Scsi disk and CD
> need to do a lot of error recovery (especially CD-ROM).

Ok, we agree here.

The problem is that we've done things the "wrong way around". If you think
of the problem as a network controller, together with "packets" that have
SCSI commands in them, then it is clear how you should NOT have

 - read/write ->
	- driver IO request ->
		SCSI layer ->
			driver

because that is equivalent to doing TCP with

 - read/write ->
	driver request ->
		TCP layer ->
			driver

which is bogus.

However, what's bogus about it is not that the old SCSI layer was above
the driver, but the fact that it was _below_ the "ll_rw_block" and request
queueing interface. That's the _packet_ interface. You don't do TCP or UDP
below the packet interface.

We should try to have some of the error recovery etc at a really _high_
level, preferably in user space. Especially the "complicated" cases are
hard to do any other way, as some IO errors require you to start sending
magic "unlock drive using this key" packets to the drive, and just
stupidly retrying simply will not work.

But that is not something that the SCSI layer should really care about.

> It would be nice if a lot of the CD error/recovery logic could be in the
> cdrom libraries because the logic (close the door, lock the door, try
> half speed, ..) is the same in scsi and ide.

Not CD-ROM library.

Instead, what I and Jens have been talking about, and what the next
pre-patch will actually have is to move some of the higher-level logic
_up_, to above the "packet interface".

Think of "struct request" as a packet, and think of a disk driver as
nothing but a specialized network driver.

So what do you get? Rip out all of drivers/scsi/scsi_ioctl.c, and replace
it with a much higher-level interface that parses the ioctl and passes
down the appropriate packets.

So "close door" is equivalent to a ICMP packet.

Normal read/write is TCP - we do merging, sorting, re-ordering etc, again
at a higher level. The packet that makes it to the low-level driver is
just a packet. This is the only layer that does retransmit etc.

And then you have the old "raw packet" interface, where user-level apps
can send commands down to the disk.

> For those of us who want to run a standards based operating system can
> you do the 32bit dev_t.

You asked for an _internal_ data structure. dev_t is the external
representation, and has _nothing_ to do with any drivers at all.

		Linus

