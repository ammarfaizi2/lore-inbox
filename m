Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132580AbREDTFe>; Fri, 4 May 2001 15:05:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135540AbREDTFZ>; Fri, 4 May 2001 15:05:25 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:5385 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S132580AbREDTFO>;
	Fri, 4 May 2001 15:05:14 -0400
Date: Fri, 4 May 2001 21:04:23 +0200
From: Jens Axboe <axboe@suse.de>
To: Richard Gooch <rgooch@ras.ucalgary.ca>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Rogier Wolff <R.E.Wolff@BitWizard.nl>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, volodya@mindspring.com,
        Alexander Viro <viro@math.psu.edu>, Andrea Arcangeli <andrea@suse.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] SMP race in ext2 - metadata corruption.
Message-ID: <20010504210423.E16507@suse.de>
In-Reply-To: <200105041140.NAA03391@cave.bitwizard.nl> <Pine.LNX.4.21.0105041015520.521-100000@penguin.transmeta.com> <200105041820.f44IKec11204@vindaloo.ras.ucalgary.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200105041820.f44IKec11204@vindaloo.ras.ucalgary.ca>; from rgooch@ras.ucalgary.ca on Fri, May 04, 2001 at 12:20:40PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 04 2001, Richard Gooch wrote:
> The idea I had (motivated by the desire to eliminate random disc
> seeks, which is the limiting factor in how fast my boxes boot) was:
> 
> - init(8) issues an ioctl(2) on the root FS block device which turns
>   on recording of block reads (it records block numbers)
> 
> - at the end of the bootup process, init(8) issues another ioctl(2) to
>   grab the buffered block numbers, and turn off recording
> 
> - init(8) then sorts this list in ascending order and saves the result
>   in a file
> 
> - next boot, init(8) checks the file, and if it exists, opens the root
>   FS block device and reads in each block listed in the file. The
>   effect is to warm the buffer cache extremely quickly. The head will
>   move in one direction, grabbing data as it flys by. I expect this
>   will take around 1 second
> 
> - init(8) now continues the boot process (starting the magic ioctl(2)
>   again so as to get a fresh list of blocks, in case something has
>   changed)
> 
> - booting is now super fast, thanks to no disc activity.

I did 95% of what you need sometime last year, to do I/O scheduler
profiling (blocks requested, merge stats, request sent to disk). It was
a pretty gross hack, requiring a pretty big ring buffer of kernel memory
to be able to log at a sufficiently fast rate (you'd be amazed how much
output a single dbench 48 run produces :-). A user space app would read
data from a simple char device, save for later inspection.

A better approach would be to map the ring buffer from the user app, but
it was just a quick fix.

-- 
Jens Axboe

