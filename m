Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268858AbRHBJL0>; Thu, 2 Aug 2001 05:11:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268857AbRHBJLR>; Thu, 2 Aug 2001 05:11:17 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:2120 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S268858AbRHBJLF>; Thu, 2 Aug 2001 05:11:05 -0400
Date: Thu, 2 Aug 2001 11:11:50 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Jeremy Higdon <jeremy@classic.engr.sgi.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: changes to kiobuf support in 2.4.(?)4
Message-ID: <20010802111150.N29065@athlon.random>
In-Reply-To: <10108012254.ZM192062@classic.engr.sgi.com> <20010802084259.H29065@athlon.random> <andrea@suse.de> <10108020031.ZM229058@classic.engr.sgi.com> <20010802094517.I29065@athlon.random> <10108020110.ZM232959@classic.engr.sgi.com> <20010802102431.L29065@athlon.random> <andrea@suse.de> <10108020142.ZM233422@classic.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <10108020142.ZM233422@classic.engr.sgi.com>; from jeremy@classic.engr.sgi.com on Thu, Aug 02, 2001 at 01:42:21AM -0700
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 02, 2001 at 01:42:21AM -0700, Jeremy Higdon wrote:
> My understanding is that databases like to have multiple outstanding
> requests to the same file, which I believe falls into the the multiple
> file descriptors, one file case.  So for us, it is interesting.  Or
> do I misunderstand what you wrote?

the databases I know open the file without sharing the fd, so they're
fine even if we share the same iobuf from multiple fd. Infact even with
threads you can open the same file multiple times.

> Actually, I want to be clear on this . . .
> 
> 	If I do
> 
> 	dd if=/dev/raw1 . . . &
> 	dd if=/dev/raw1 . . . &
> 	wait
> 
> with the O_DIRECT patch, do I get some slow path allocations?

That will work fine with the per-file iobuf ala O_DIRECT, no slow path
allocations will ever happen.

Even if you do:

	clone()
	parent:
		fd = open("/dev/raw1")
		write(fd)
		read(fd)
	child:
		fd = open("/dev/raw1")
		write(fd)
		read(fd)

you won't run into slow path allocations.

> At 13000 IOPS, when allocating and freeing on every I/O request,
> the allocate/free overhead was approximately .6% on a 2 CPU system,
> where the total overhead was about 25%.  So I would theoretically
> gain 3% (maybe a little better since there is locking involved) if
> I could avoid the alloc/free.

Ok good.

Andrea
