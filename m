Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286293AbRLTRGM>; Thu, 20 Dec 2001 12:06:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286296AbRLTRGC>; Thu, 20 Dec 2001 12:06:02 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:19836 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S286293AbRLTRF4>; Thu, 20 Dec 2001 12:05:56 -0500
Date: Thu, 20 Dec 2001 18:05:47 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: simon@baydel.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: raw devices
Message-ID: <20011220180547.C1395@athlon.random>
In-Reply-To: <3C21D809.6787.13E19F@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <3C21D809.6787.13E19F@localhost>; from simon@baydel.com on Thu, Dec 20, 2001 at 12:22:33PM -0000
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 20, 2001 at 12:22:33PM -0000, simon@baydel.com wrote:
> I have been performing some tests on raw devices, the results of 
> which I do not understand. I have 4 FC busses, each with one  
> SCSI disk, connect to a Linux system running 2.4.16. I use the raw 
> command to bind /dev/raw1 - /dev/raw4 to each of the devices. 
> With one process per raw device, running large sequential reads, I 
> got a total throughput  of 340 Megabytes per second. I also 
> observed 85% CPU idle. Following this I performed some more 
> tests and then returned to this one. This time the total had gone 
> down to 180 and there was no free CPU. I realized that the first 
> time I ran the tests, each of the disks that the raw devices were 
> mapped to were mounted. I then verified that this data was being 
> transferred along the FC bus using an analyzer while the devices 
> were mounted. Can anyone explain this to me ? I find it hard to 
> believe that the disk should be permitted to be mounted when 
> using raw device mappings. If the disks should not be mounted 
> why is there such a great performance difference ?

because when mounted rawio uses a blocksize larger than the
softblocksize (for no good reason, but that's another issue).

in short when the disk is mouned a single bh was doing I/O on a page (I
guess you were using 4k blocksize in the fs), while when it was
unmounted it was doing I/O on only 512bytes, so you needed 8 times more
bh and CPU to do the same I/O. 

there are many ways to fix this, I guess it would be nice to get the bio
stuff optimized in 2.5 first (bio will be even faster than your rawio
with the fs mounted, because a single metadata entity will be able to do
I/O on more than one page, that's the whole point of the bio design
changes). Then in 2.5 rawio can also be obsoleted and modularized.
O_DIRECT will have to relax its granularity requirements for both fs and
blkdev and so then it will overlap enterely the rawio chardevice
functionality.

btw, if you try to use O_DIRECT on the fs with your current kernel, you
should be just able to read at 340mbyte/sec with most of the CPU idle.

Andrea
