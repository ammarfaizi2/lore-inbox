Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315265AbSILK3V>; Thu, 12 Sep 2002 06:29:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315267AbSILK3V>; Thu, 12 Sep 2002 06:29:21 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:32138 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S315265AbSILK3U>;
	Thu, 12 Sep 2002 06:29:20 -0400
Message-Id: <200209121033.g8CAXHD04893@eng4.beaverton.ibm.com>
To: Alexander Viro <viro@math.psu.edu>
cc: Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] sard changes for 2.5.34 
In-reply-to: Your message of "Thu, 12 Sep 2002 06:01:37 EDT."
             <Pine.GSO.4.21.0209120546160.12770-100000@weyl.math.psu.edu> 
Date: Thu, 12 Sep 2002 03:33:16 -0700
From: Rick Lindsley <ricklind@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    OK.  First of all, I have serious problems with collecting all these
    stats to hd_struct.

I agree. They should be part of a disk statistics structure somewhere,
and that should probably be made part of this patch.
    
	a) _all_ stats you collect by request will be for entire disk.
    By the time when request had been created, we simply don't remember
    which partition it used to be.  Pretending that they are
    per-partition only obfuscates the things.  Stats by bio are
    per-partition, but... see below

Yeah, I noticed :) The best we can do now, I think, is collect
per-partition information in generic_make_request() before the
partition remap.  After that, the information is gone, and trying to
carry it along gets real ugly, especially when you remember that I/O
requests can get merged.

But it *is* still useful to know which partitions are getting hit up
with requests.  If you've got some data that is continually getting
read/written to disk in a particular area, then (for instance) you
might want to make that data reside on a memdisk, if possible. Or
mirror it, if you're using a volume manager, to spread the I/O out over
multiple copies.

	It might.  There is a big rewrite of that area going on right
    now.  In particular, we are getting to the point when _all_
    block devices are going to acquire gendisks - partitioned or not.
    Next step after that will be sane refcounting for gendisks and once
    that is done we are getting rid of get_gendisk() for good - pointer
    will be cached in struct block_device while it's open _and_ it will
    replace ->rq_dev in struct request.

In a development tree, everybody's got to adjust.  I've no problem
keeping up the patches, or in consulting with the team making the
changes you described, to make these statistic changes stick and not
look like they were glued on at the last minute.  The statistics are
valuable

    a) at a gross level to sysadmins trying to balance their disk I/O
    b) at a finer level by performance tuners, looking to maximize their
       I/O rates

and they're worth the work.

Since 10/31 looms ever closer, I presume the changes you mentioned
will be rolling out in force in the next few weeks?

Rick
