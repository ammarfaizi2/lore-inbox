Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279277AbRLUL2C>; Fri, 21 Dec 2001 06:28:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279307AbRLUL1x>; Fri, 21 Dec 2001 06:27:53 -0500
Received: from finch-post-11.mail.demon.net ([194.217.242.39]:25363 "EHLO
	finch-post-11.mail.demon.net") by vger.kernel.org with ESMTP
	id <S279277AbRLUL1j>; Fri, 21 Dec 2001 06:27:39 -0500
From: "" <simon@baydel.com>
To: Andrea Arcangeli <andrea@suse.de>
Date: Fri, 21 Dec 2001 07:26:42 -0000
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: raw devices
CC: linux-kernel@vger.kernel.org
Message-ID: <3C22E432.18861.639267@localhost>
In-Reply-To: <20011220180547.C1395@athlon.random>
In-Reply-To: <3C21D809.6787.13E19F@localhost>; from simon@baydel.com on Thu, Dec 20, 2001 at 12:22:33PM -0000
X-mailer: Pegasus Mail for Win32 (v3.12c)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea,

This clears this up, thanks very much. I have tried using the 
O_DIRECT and it is almost as fast as the mounted raw devices.
It sounds like 2.5 is set to improve on this. Do you know if there 
have been any suggestions regarding using mounting options on a 
filesystem so that none of the files on that filesystem are cached ?

Thanks again 

Simon. 


On 20 Dec 2001, at 18:05, Andrea Arcangeli wrote:

> On Thu, Dec 20, 2001 at 12:22:33PM -0000, simon@baydel.com wrote:
> > I have been performing some tests on raw devices, the results of 
> > which I do not understand. I have 4 FC busses, each with one  
> > SCSI disk, connect to a Linux system running 2.4.16. I use the raw 
> > command to bind /dev/raw1 - /dev/raw4 to each of the devices. 
> > With one process per raw device, running large sequential reads, I 
> > got a total throughput  of 340 Megabytes per second. I also 
> > observed 85% CPU idle. Following this I performed some more 
> > tests and then returned to this one. This time the total had gone 
> > down to 180 and there was no free CPU. I realized that the first 
> > time I ran the tests, each of the disks that the raw devices were 
> > mapped to were mounted. I then verified that this data was being 
> > transferred along the FC bus using an analyzer while the devices 
> > were mounted. Can anyone explain this to me ? I find it hard to 
> > believe that the disk should be permitted to be mounted when 
> > using raw device mappings. If the disks should not be mounted 
> > why is there such a great performance difference ?
> 
> because when mounted rawio uses a blocksize larger than the
> softblocksize (for no good reason, but that's another issue).
> 
> in short when the disk is mouned a single bh was doing I/O on a page (I
> guess you were using 4k blocksize in the fs), while when it was
> unmounted it was doing I/O on only 512bytes, so you needed 8 times more
> bh and CPU to do the same I/O. 
> 
> there are many ways to fix this, I guess it would be nice to get the bio
> stuff optimized in 2.5 first (bio will be even faster than your rawio
> with the fs mounted, because a single metadata entity will be able to do
> I/O on more than one page, that's the whole point of the bio design
> changes). Then in 2.5 rawio can also be obsoleted and modularized.
> O_DIRECT will have to relax its granularity requirements for both fs and
> blkdev and so then it will overlap enterely the rawio chardevice
> functionality.
> 
> btw, if you try to use O_DIRECT on the fs with your current kernel, you
> should be just able to read at 340mbyte/sec with most of the CPU idle.
> 
> Andrea


__________________________

Simon Haynes - Baydel 
Phone : 44 (0) 1372 378811
Email : simon@baydel.com
__________________________
