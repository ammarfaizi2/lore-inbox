Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132220AbRDFSCw>; Fri, 6 Apr 2001 14:02:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131724AbRDFSCn>; Fri, 6 Apr 2001 14:02:43 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:31608 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S132281AbRDFSCd>; Fri, 6 Apr 2001 14:02:33 -0400
Date: Fri, 6 Apr 2001 20:22:05 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Andi Kleen <ak@suse.de>
Cc: "Stephen C. Tweedie" <sct@redhat.com>,
        Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: 2 times faster rawio and several fixes (2.4.3aa3)
Message-ID: <20010406202205.N28118@athlon.random>
In-Reply-To: <20010406183440.B28118@athlon.random> <20010406190701.H28118@athlon.random> <20010406190232.A20258@gruyere.muc.suse.de> <20010406193621.M28118@athlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010406193621.M28118@athlon.random>; from andrea@suse.de on Fri, Apr 06, 2001 at 07:36:21PM +0200
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 06, 2001 at 07:36:21PM +0200, Andrea Arcangeli wrote:
> 2/4Mbytes naturally aligned area). so probably I will take the vmalloc way

As expected vmalloc additional 2 tlbs aren't visible in the numbers (that
are mostly dominated by I/O anyways), I think it's the best solution to avoid
the order 2 multipage:

alpha:/home/andrea # time ./rawio-bench 
Opening /dev/raw1
Allocating 50MB of memory
Reading from /dev/raw1
Writing data to /dev/raw1

real    0m5.241s
user    0m0.002s
sys     0m1.119s
alpha:/home/andrea # time ./rawio-bench 
Opening /dev/raw1
Allocating 50MB of memory
Reading from /dev/raw1
Writing data to /dev/raw1

real    0m5.176s
user    0m0.003s
sys     0m1.128s
alpha:/home/andrea # time ./rawio-bench 
Opening /dev/raw1
Allocating 50MB of memory
Reading from /dev/raw1
Writing data to /dev/raw1

real    0m5.196s
user    0m0.002s
sys     0m1.132s
alpha:/home/andrea # time ./rawio-bench 
Opening /dev/raw1
Allocating 50MB of memory
Reading from /dev/raw1
Writing data to /dev/raw1

real    0m5.477s
user    0m0.004s
sys     0m1.146s
alpha:/home/andrea # time ./rawio-bench 
Opening /dev/raw1
Allocating 50MB of memory
Reading from /dev/raw1
Writing data to /dev/raw1

real    0m5.217s
user    0m0.004s
sys     0m1.149s
alpha:/home/andrea # 

Tomorrow maybe I will try to speed it up furhter using the desing described in
the first email.

The s/kmem_cache_alloc/vmalloc/ change is here for now and it is rock solid
for me (regression testing is still happy):

	ftp://ftp.us.kernel.org/pub/linux/kernel/people/andrea/patches/v2.4/2.4.3/rawio-2

I think it's ok for inclusion.

Andrea
