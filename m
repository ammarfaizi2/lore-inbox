Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261456AbUCAW2Z (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Mar 2004 17:28:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261460AbUCAW2Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Mar 2004 17:28:25 -0500
Received: from hermes.py.intel.com ([146.152.216.3]:64454 "EHLO
	hermes.py.intel.com") by vger.kernel.org with ESMTP id S261456AbUCAW2W convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Mar 2004 17:28:22 -0500
Content-Class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Subject: RE: per-cpu blk_plug_list
Date: Mon, 1 Mar 2004 14:28:12 -0800
Message-ID: <B05667366EE6204181EABE9C1B1C0EB501F2AB4F@scsmsx401.sc.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: per-cpu blk_plug_list
Thread-Index: AcP/2rg581RRDez6QBe+TRqjvUfBTQAADCqg
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "Andrew Morton" <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 01 Mar 2004 22:28:12.0770 (UTC) FILETIME=[7B942420:01C3FFDC]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
>>
>> We were surprised to find global lock in I/O path still exists on 2.6
>> kernel.
>
> Well I'm surprised that nobody has complained about it yet ;)

We are now, very loudly :-)


> How on earth do you know that when direct-io calls
blk_run_queues_cpu(),
> it is still running on the cpu which initially plugged the queue(s)?
>
> And your patch might have made the much-more-frequently-called
> blk_run_queues() more expensive.
>
> There are minor issues with lack of preemption safety and not using
the
> percpu data infrastructure, but they can wait.

Absolutely, these are the details need to be worked out.  And we are
working on that at the moment.


> You haven't told us how many disks are in use?  At 100k IO's per
second it
> would be 500 to 1000 disks, yes?

Right again!!, we are using 16 fiber-channel controllers connect to just
over 1000 disks.

> I assume you tried it, but does this help?
> 
> diff -puN drivers/block/ll_rw_blk.c~a drivers/block/ll_rw_blk.c
> --- 25/drivers/block/ll_rw_blk.c~a	Mon Mar  1 13:52:37 2004
> +++ 25-akpm/drivers/block/ll_rw_blk.c	Mon Mar  1 13:52:45 2004
> @@ -1251,6 +1251,9 @@ void blk_run_queues(void)
> {
> 	LIST_HEAD(local_plug_list);
>  
> +	if (list_empty(&blk_plug_list))
> +		return;
> +
> 	spin_lock_irq(&blk_plug_lock);
> 
> 	/*

Yeah, that's first thing we tried, didn't do a dent to the lock at all.

