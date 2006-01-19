Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161077AbWASLkV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161077AbWASLkV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 06:40:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161147AbWASLkV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 06:40:21 -0500
Received: from [212.76.80.241] ([212.76.80.241]:50442 "EHLO raad.intranet")
	by vger.kernel.org with ESMTP id S1161077AbWASLkV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 06:40:21 -0500
From: Al Boldi <a1426z@gawab.com>
To: linux-kernel@vger.kernel.org
Subject: Re: io performance...
Date: Thu, 19 Jan 2006 14:39:22 +0300
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Disposition: inline
Cc: linux-raid@vger.kernel.org
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200601191439.22686.a1426z@gawab.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff V. Merkey wrote:
> Jens Axboe wrote:
> >On Mon, Jan 16 2006, Jeff V. Merkey wrote:
> >>Max Waterman wrote:
> >>>I've noticed that I consistently get better (read) numbers from kernel 
> >>>2.6.8 than from later kernels.
> >>
> >>To open the bottlenecks, the following works well.  Jens will shoot me
> >>-#define BLKDEV_MIN_RQ        4
> >>-#define BLKDEV_MAX_RQ        128     /* Default maximum */
> >>+#define BLKDEV_MIN_RQ        4096
> >>+#define BLKDEV_MAX_RQ        8192    /* Default maximum */
> >
> >Yeah I could shoot you. However I'm more interested in why this is
> >necessary, eg I'd like to see some numbers from you comparing:
> >
> >- Doing
> >        # echo 8192 > /sys/block/<dev>/queue/nr_requests
> >  for each drive you are accessing.
> >
> >The BLKDEV_MIN_RQ increase is just silly and wastes a huge amount of
> >memory for no good reason.
>
> Yep. I build it into the kernel to save the trouble of sending it to proc.
> Jens recommendation will work just fine. It has the same affect of
> increasing the max requests outstanding.

Your suggestion doesn't do anything here on 2.6.15, but
	echo 192 > /sys/block/<dev>/queue/max_sectors_kb 
	echo 192 > /sys/block/<dev>/queue/read_ahead_kb 
works wonders!

I don't know why, but anything less than 64 and more than 256 makes the queue 
collapse miserably, causing some strange __copy_to_user calls?!?!?

Also, it seems that changing the kernel HZ has some drastic effects on the 
queues.  A simple lilo gets delayed 400% and 200% using 100HZ and 250HZ 
respectively.

--
Al

