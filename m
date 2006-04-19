Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750774AbWDSOCT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750774AbWDSOCT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 10:02:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750783AbWDSOCT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 10:02:19 -0400
Received: from uucp.cistron.nl ([62.216.30.38]:25832 "EHLO ncc1701.cistron.net")
	by vger.kernel.org with ESMTP id S1750774AbWDSOCT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 10:02:19 -0400
From: "Miquel van Smoorenburg" <miquels@cistron.nl>
Subject: Re: 3w-9xxx status in kernel
Date: Wed, 19 Apr 2006 14:02:13 +0000 (UTC)
Organization: Cistron
Message-ID: <e25ft5$grl$1@news.cistron.nl>
References: <4444D1D5.6070903@rubis.org> <e2558p$o5f$2@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: ncc1701.cistron.net 1145455333 17269 194.109.0.112 (19 Apr 2006 14:02:13 GMT)
X-Complaints-To: abuse@cistron.nl
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: mikevs@n2o.xs4all.nl (Miquel van Smoorenburg)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <e2558p$o5f$2@sea.gmane.org>,
Martin Honermeyer  <maze@strahlungsfrei.de> wrote:
>Hi,
>
>same problem over here. Why does the newest kernel contain an old version of
>the 3w-9xxx driver? 
>
>We are having performance problems using a 9550SX controller. Read
>throughput (measured with hdparm) is worse than on a Desktop system. We are
>considering trying to replace it with the newest driver from 3ware.com.

The default settings for the 3w9xxx cards suck.

You need to make sure that the nr_requests (kernel request queue)
is at least twice the size of queue_depth (hardware requests queue).
Also the deadline or cfq i/o schedulers work a bit better for
database-like workloads.

Try something like this, replacing sda with the device name
of your 3ware controller.

	# Limit queue depth somewhat
	echo 128 > /sys/block/sda/device/queue_depth

	# Increase nr_requests
	echo 256 > /sys/block/sda/queue/nr_requests

	# Don't use as for database-like loads
	echo deadline > /sys/block/sda/queue/scheduler

CFQ seems to like larger nr_requests, so if you use CFQ, try 254
(maximum hardware size) for queue_depth and 512 or 1024 for nr_requests.

Oh, remember, if you have just created a RAID array on
the disks, wait with testing until the whole array has been
rebuild..

Mike.

