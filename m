Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277677AbRJIA7a>; Mon, 8 Oct 2001 20:59:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277678AbRJIA7V>; Mon, 8 Oct 2001 20:59:21 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:59658 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S277677AbRJIA7J>; Mon, 8 Oct 2001 20:59:09 -0400
Date: Tue, 9 Oct 2001 02:59:15 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Ben Smith <ben@google.com>
Cc: linux-kernel@vger.kernel.org, Gerald Aigner <gerald@google.com>
Subject: Re: kswapd problems with 2.4.{9,10}
Message-ID: <20011009025915.H726@athlon.random>
In-Reply-To: <Pine.LNX.4.21.0110051119070.19656-100000@tide.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.21.0110051119070.19656-100000@tide.corp.google.com>; from ben@google.com on Fri, Oct 05, 2001 at 11:21:34AM -0700
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 05, 2001 at 11:21:34AM -0700, Ben Smith wrote:
> I've attached the test program at the bottom of this message, as well
> as the kernel config I've used to build my kernel. Please contact me
> if you have further questions.

I entered this problem since a few minutes. thanks for the testcase, it
really helps understanding your problem.

First note is that using mlock for such purpose sounds wrong. Linux
provides madvise(start,len,MADV_WILLNEED) that will pagein the stuff
efficiently. You can just pagin the whole thing at once without the hack
you're doing of mlocking in chunks to avoid running into the ram/2
locked ram limit and to avoid turning down the machine with all locked
ram etc... if you know you've enough cache. However current madvise
implementation won't map the pagetables in (so you'll still generate
minor faults with cache hits) and the cache could be collected away if
you run other apps. But it sounds lots saner than mlock. And in theory
we could also change madvise to map the pagetables in, it wouldn't be
painful but before doing so I guess we prefer some real world number
that shows a noticeable improvement.

Anyways it would be interesting to know if the problem goes away with
madvise. While rewriting the vma lookup engine I cared about
mmap/mprotect/mremap but I didn't care about mlock, so at the moment it is
also not doing the vma merging (so you're generating many unmerged vmas
with your mlock/munmlock around the vma areas, madvise would be more
efficient in this sense too because mlock even if it would merge vmas it
would still need to create new vmsa during your pagein loop), and I
suspect not many people are stressing the code that generates the new
vma with mlock so I don't exclude you're triggering a core bug in the
mlock.c file rather than a VM problem (didn't checked the code yet, once
I'll check the code I'll implement the vma merging there too). It's too
early to be sure though.  Also make sure to run it on top of 2.4.10
based kernel where kswapd should know when it has to do useful work or
not (you said you tested 2.4.10 but your .config was for 2.4.9). You may
also want to try again on top of my next/future -aa that should provide
more reliable allocations for highmem systems, I'm still in the testing
stage on my 128mbyte ram box with an emulated very unblanaced highmem
setup (but kswapd logic is unchanged at the moment since I don't see
anything wrong there).

Andrea
