Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293743AbSCAUpA>; Fri, 1 Mar 2002 15:45:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293744AbSCAUou>; Fri, 1 Mar 2002 15:44:50 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:30478 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S293743AbSCAUom>;
	Fri, 1 Mar 2002 15:44:42 -0500
Message-ID: <3C7FE7DD.98121E87@zip.com.au>
Date: Fri, 01 Mar 2002 12:43:09 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.18-rc2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: queue_nr_requests needs to be selective
In-Reply-To: <20020301132254.A11528@vger.timpanogas.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Jeff V. Merkey" wrote:
> 
> Linus/Alan/Linux,
> 
> Performance numbers can be increased dramatically (> 300 MB/S)
> by increasing queue_nr_requests in ll_rw_blk.c on large RAID
> controllers that are hosting a lot of drives.

I don't immediately see why increasing the queue length should
increase bandwidth in this manner.  One possibility is that
the shorter queue results in tasks sleeping in __get_request_wait
more often, and the real problem is the "request starvation" thing.

The "request starvation" thing could conceivably result in more
seeky behaviour.  In your kernel, disk writeouts come from
two places:

- Off the tail of the dirty buffer LRU

- Basically random guess, from the page LRU.

It's competition between these two writeout sources which causes
decreased bandwidth - I've seen kernels in which ext2 writeback
performance was down 40% due to this.

Anyway.   You definitely need to try 2.4.19-pre1.   Max sleep times
in __get_request_wait will be improved, and it's possible that the
bandwidth will improve.  Or not.  My gut feel is that it won't
help.

And yes, 128 requests is too few.  It used to be ~1000.  I think
this change was made in a (misguided, unsuccessful) attempt to
manage latency for readers.  The request queue is the only mechanism
we have for realigning out-of-order requests and it needs to be
larger so it can do this better. I've seen 15-25% throughput
improvements from a 1024-slot request queue.

And if a return to a large request queue damages latency (it doesn't)
then we need to fix that latency *without* damaging request merging.

First step: please test 2.4.19-pre1 or -pre2.  Also 2.4.19-pre1-ac2
may provide some surprises..

-
