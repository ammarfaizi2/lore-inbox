Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317232AbSHJStG>; Sat, 10 Aug 2002 14:49:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317251AbSHJStG>; Sat, 10 Aug 2002 14:49:06 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:41743 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S317232AbSHJStF>;
	Sat, 10 Aug 2002 14:49:05 -0400
Message-ID: <3D556101.8080006@mandrakesoft.com>
Date: Sat, 10 Aug 2002 14:52:49 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Jamie Lokier <lk@tantalophile.demon.co.uk>,
       Andrew Morton <akpm@zip.com.au>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch 6/12] hold atomic kmaps across generic_file_read
References: <Pine.LNX.4.44.0208101134510.2197-100000@home.transmeta.com>
X-Enigmail-Version: 0.65.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> And read() is often the much nicer interface, simply because you don't
> need to worry about the size of the file up-front etc.
> 
> Also, because of the delayed nature of mmap()/fault, it has some strange
> behaviour if somebody is editing your file in the middle of the compile -
> with read() you might get strange syntax errors if somebody changes the
> file half-way, but with mmap() your preprocessor may get a SIGSEGV in the
> middle just because the file was truncated..
> 
> In general, I think read() tends to be the right (and simpler) interface
> to use if you don't explicitly want to take advantage of the things mmap
> offers (on-demand mappings, no-write-back pageouts, VM coherency etc).



While working on a race-free rewrite of cp/mv/rm (suggested by Al), I 
did overall-time benchmarks on read+write versus sendfile/stat versus 
mmap/stat, and found that pretty much the fastest way under Linux 2.2, 
2.4, and solaris was read+write of PAGE_SIZE, or PAGE_SIZE*2 chunks. 
[obviously, 2.2 and solaris didn't do sendfile test]

The overhead of the extra stat and mmap/munmap syscalls seemed to be the 
thing that slowed things down.  sendfile was pretty fast, but still an 
extra syscall, with an annoyingly large error handling case [only 
certain files can be sendfile'd]

I sure would like an O_STREAMING flag, though...  let a user app hint to 
the system that the pages it is reading or writing are perhaps less 
likely to be reused, or access randomly....  A copy-file syscall would 
be nice, too, but that's just laziness talking....

	Jeff



