Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317083AbSHJRdF>; Sat, 10 Aug 2002 13:33:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317091AbSHJRdF>; Sat, 10 Aug 2002 13:33:05 -0400
Received: from pc-62-30-255-50-az.blueyonder.co.uk ([62.30.255.50]:60868 "EHLO
	kushida.apsleyroad.org") by vger.kernel.org with ESMTP
	id <S317083AbSHJRdF>; Sat, 10 Aug 2002 13:33:05 -0400
Date: Sat, 10 Aug 2002 18:36:04 +0100
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Andrew Morton <akpm@zip.com.au>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch 6/12] hold atomic kmaps across generic_file_read
Message-ID: <20020810183604.B306@kushida.apsleyroad.org>
References: <3D54AED6.708F247F@zip.com.au> <Pine.LNX.4.44.0208100005070.1474-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0208100005070.1474-100000@home.transmeta.com>; from torvalds@transmeta.com on Sat, Aug 10, 2002 at 12:25:38AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> Imagine doing a
> 
> 	fstat(fd..)
> 	buf = aligned_malloc(st->st_size)
> 	read(fd, buf, st->st_size);
> 
> and having it magically populate the VM directly with the whole file
> mapping, with _one_ failed page fault. And the above is actually a fairly
> common thing. See how many people have tried to optimize using mmap vs
> read, and what they _all_ really wanted was this "populate the pages in
> one go" thing. 

This will only provide the performance benefic when `aligned_malloc'
return "fresh" memory, i.e. memory that has never been written to.

Assuming most programs use plain old `malloc', which could be taught to
align nicely, then the optimisation might occur when a program starts
up, but later on it's more likely to return memory which has been
written to and previously freed.  So the performance becomes unpredictable.

But it's a nice way to optimise if you are _deliberately_ optimising a
user space program.  First call mmap() to get some fresh pages, then
call read() to fill them.  Slower on kernels without the optimisation,
fast on kernels with it. :-)

-- Jamie
