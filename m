Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315260AbSILJ4t>; Thu, 12 Sep 2002 05:56:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315265AbSILJ4t>; Thu, 12 Sep 2002 05:56:49 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:2187 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S315260AbSILJ4s>;
	Thu, 12 Sep 2002 05:56:48 -0400
Date: Thu, 12 Sep 2002 06:01:37 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Rick Lindsley <ricklind@us.ibm.com>
cc: Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] sard changes for 2.5.34 
In-Reply-To: <200209120918.g8C9IND03853@eng4.beaverton.ibm.com>
Message-ID: <Pine.GSO.4.21.0209120546160.12770-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 12 Sep 2002, Rick Lindsley wrote:

>     OK, that's a start.  I think there was some work done on making
>     kernel_stat percpu as well.
> 
> Yes there's work on a couple of different fronts there.  There is work
> to specifically make disk stats per cpu (actually, I have some 2.4
> patches already I could port), and there is a more general interface
> (statctr_t) which Dipankar Sarma (dipankar@in.ibm.com) is working on
> for 2.5 for stat counters in general which generalizes the per-cpu
> concept.

OK.  First of all, I have serious problems with collecting all these
stats to hd_struct.  Reasons:
	a) _all_ stats you collect by request will be for entire disk.
By the time when request had been created, we simply don't remember
which partition it used to be.  Pretending that they are per-partition
only obfuscates the things.  Stats by bio are per-partition, but... see below
	b) hd_struct had been completely removed from drivers (they neither
know nor care about it) and it will be completely gone RSN.  There will be
a replacement, obviously, but it's not even certain that it will be a
single array.
 
> That would be great ... but I want to be sure we don't take so long
> working on the polish that we miss 10/31 with the main event.  I can
> spend a few days incorporating all of these things and repost, if you
> don't think it makes it "too many changes at one time."

	It might.  There is a big rewrite of that area going on right now.
In particular, we are getting to the point when _all_ block devices are
going to acquire gendisks - partitioned or not.  Next step after that
will be sane refcounting for gendisks and once that is done we are getting
rid of get_gendisk() for good - pointer will be cached in struct block_device
while it's open _and_ it will replace ->rq_dev in struct request.

	These changes alone can cause a lot of fun, and then there is
reorganization of struct gendisk itself...

