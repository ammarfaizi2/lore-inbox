Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263193AbRFGVLU>; Thu, 7 Jun 2001 17:11:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263175AbRFGVLN>; Thu, 7 Jun 2001 17:11:13 -0400
Received: from hera.cwi.nl ([192.16.191.8]:25087 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S263173AbRFGVKz>;
	Thu, 7 Jun 2001 17:10:55 -0400
Date: Thu, 7 Jun 2001 23:10:52 +0200 (MET DST)
From: Andries.Brouwer@cwi.nl
Message-Id: <UTC200106072110.XAA227393.aeb@vlet.cwi.nl>
To: COTTE@de.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: BUG: race-cond with partition-check and ll_rw_blk (all platforms, 2.4.*!)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    From: COTTE@de.ibm.com

    We just had a problem when running some formatting-utils on
    a large amount of disks synchronously: We got a NULL-pointer
    violation when accessig blk_size[major] for our major number.
    Further research showed, that grok_partitions was running at
    that time, which has been called by register_disk, which our
    device driver issues after a disk has been formatted.
    Grok_partitions first initializes blk_size[major] with a NULL
    pointer, detects the partitions and then assigns the original
    value to blk_size[major] again.
    Here's the interresting code from these functions, I cut some
    irrelevant things out:
    From grok_paritions:
         blk_size[dev->major] = NULL;
         check_partition(dev, MKDEV(dev->major, first_minor), 1 + first_minor);
         if (dev->sizes != NULL) {
              blk_size[dev->major] = dev->sizes;
         };
    From generic_make_request:
         if (blk_size[major]) {
                   if (blk_size[major][MINOR(bh->b_rdev)]) {

    Can anyone explain to me, why grok_partitions has to clear
    this pointer?

Well, among the irrelevant details you left out is the fact that
it is not
	blk_size[dev->major] = NULL;
but
	if(!dev->sizes)
		blk_size[dev->major] = NULL;
	...
	if (dev->sizes)
		blk_size[dev->major] = dev->sizes;

So, the idea is that either this major has an array with sizes,
and then one can find it in blk_size[dev->major], or it hasn't.
You seem to have a situation where dev->sizes is NULL but
blk_size[dev->major] is not? What device is this?

Andries
