Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261763AbUC1S4V (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Mar 2004 13:56:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262361AbUC1S4T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Mar 2004 13:56:19 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:62425 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261763AbUC1S4B
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Mar 2004 13:56:01 -0500
Message-ID: <40671FAF.6080501@pobox.com>
Date: Sun, 28 Mar 2004 13:55:43 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: Jamie Lokier <jamie@shareable.org>, Nick Piggin <nickpiggin@yahoo.com.au>,
       linux-ide@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] speed up SATA
References: <40661049.1050004@yahoo.com.au> <406611CA.3050804@pobox.com> <406612AA.1090406@yahoo.com.au> <4066156F.1000805@pobox.com> <20040328141014.GE24370@suse.de> <40670BD9.9020707@pobox.com> <20040328173508.GI24370@suse.de> <40670FDB.6080409@pobox.com> <20040328175436.GL24370@suse.de> <20040328180809.GB1087@mail.shareable.org> <20040328181502.GO24370@suse.de>
In-Reply-To: <20040328181502.GO24370@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
> On Sun, Mar 28 2004, Jamie Lokier wrote:
> 
>>Jens Axboe wrote:
>>
>>>Sorry, but I cannot disagree more. You think an artificial limit at
>>>the block layer is better than one imposed at the driver end, which
>>>actually has a lot more of an understanding of what hardware it is
>>>driving?  This makes zero sense to me. Take floppy.c for instance, I
>>>really don't want 1MB requests there, since that would take a minute
>>>to complete. And I might not want 1MB requests on my Super-ZXY
>>>storage, because that beast completes io easily at an iorate of
>>>200MB/sec.
>>
>>The driver doesn't know how fast the drive is either.
>>
>>Without timing the drive, interface, and for different request sizes,
>>neither the block layer _nor_ the driver know a suitable size.

Nod, this is pretty much my objection to hardcoding an artificial limit 
in the driver...


> The driver may not know exactly, but it does know a ball park figure.
> You know if you are driving floppy (sucky transfer and latency), hard
> drive, cdrom (decent transfer, sucky seeks), etc.

Agreed.  Really we have two types of information:
* the device's hard limit
* the default limit that should be applied to that class of devices

I would much rather do something like

	blk_queue_set_class(q, CLASS_DISK)

and have that default per-class policy

	switch (class) {
	case CLASS_DISK:
	q->max_sectors = min(q->max_sectors, CLASS_DISK_MAX_SECTORS);
	...

than hardcode the limit in the driver.  That's easy and quick.  That's a 
minimal solution that gives me what I want -- don't hardcode generic 
limits in the driver -- while IMO giving you what you want, a sane limit 
in an easy way.

Right now we are hardcoding the same per-class limits into each floppy 
driver, each disk driver, etc.  At the very least devices that act the 
same way should all be using the same tunable, whether it's a 
compile-time tunable (CLASS_xxx_MAX_SECTORS) or a runtime tunable.

Long term, the IO scheduler and the VM should really be figuring out the 
best request size, from zero to <hardware limit>.

	Jeff



