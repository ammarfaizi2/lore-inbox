Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317720AbSGZNyW>; Fri, 26 Jul 2002 09:54:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317724AbSGZNyW>; Fri, 26 Jul 2002 09:54:22 -0400
Received: from relay.muni.cz ([147.251.4.35]:5595 "EHLO anor.ics.muni.cz")
	by vger.kernel.org with ESMTP id <S317720AbSGZNyU>;
	Fri, 26 Jul 2002 09:54:20 -0400
Date: Fri, 26 Jul 2002 15:57:32 +0200
From: Jan Kasprzak <kas@informatics.muni.cz>
To: Jochen Suckfuell <jo-lkml@suckfuell.net>
Cc: alan@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: sard I/O accounting bug in -ac
Message-ID: <20020726155731.R23911@fi.muni.cz>
References: <20020726111520.G23911@fi.muni.cz> <20020726153710.A5368@ds217-115-141-141.dedicated.hosteurope.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020726153710.A5368@ds217-115-141-141.dedicated.hosteurope.de>; from jo-lkml@suckfuell.net on Fri, Jul 26, 2002 at 03:37:10PM +0200
X-Muni-Virus-Test: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jochen Suckfuell wrote:
: However, since you don't have SCSI disks, this will most likely not fix
: your problem. But before I was able to track down this missing lock
: issue, I could fix the problem by making the ios_in_flight variable use
: atomic operations. Let me guess, you have an SMP machine, where a race
: condition is likely to occur?

	Nope. Single-CPU Athlon 850, Via KT133 (not KT133A), ASUS
board with on-board VIA IDE and on-board promise controller, 1.1GB RAM
(CONFIG_HIGHMEM), 3c985B NIC.

: Below is my patch to use atomic operations (against 2.4.19-pre10) that
: fixed the problem for me on an SMP machine with SCSI disks. (I don't
: have a non-SCSI SMP machine to check.)
: 
: In the first chunk, I also added a check for negative ios_in_flight
: values to the function generating the /proc/partitions output, and
: eventually set them to zero. You should remove this part to see if
: values are still becoming negative.
: 
: If this patch works, there must be another place where accounting is
: done without proper spinlock handling. The atomic-patch should not be
: the final solution for this!

	I'll look at this, but I am about to leave for a holiday,
so don't expect feedback in next two weeks or so. Also I don't want to
experiment with this server more than necessary, and this is not a critical
bug.

: rio/wio are the total number of read/write requests processed, while
: rmerge/wmerge is the number of successful merges of requests.

	What does it mean "merges" and how is it related to the
mult-count of the HDD? I've tried to run "dd if=/dev/hdc bs=4k of=/dev/null"
on a drive with mult-count 16 and read-ahead 8, and the rsect count
was approximately 126.5 times bigger than rio, while the rsect/rmerge
was about 62. I've changed the "bs=4k" to "bs=64k" in the "dd" command,
but the rsect/rio and rsect/rmerge ratio was about the same.

	So how does the read() syscall from dd(1) maps to rio requests
(and rmerge requests)? Is it related to the drive multcount at all?

-Yenya

-- 
| Jan "Yenya" Kasprzak  <kas at {fi.muni.cz - work | yenya.net - private}> |
| GPG: ID 1024/D3498839      Fingerprint 0D99A7FB206605D7 8B35FCDE05B18A5E |
| http://www.fi.muni.cz/~kas/   Czech Linux Homepage: http://www.linux.cz/ |
|----------- If you want the holes in your knowledge showing up -----------|
|----------- try teaching someone.                  -- Alan Cox -----------|
