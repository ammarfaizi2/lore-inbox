Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267467AbUBSCCo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 21:02:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267469AbUBSCCo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 21:02:44 -0500
Received: from mail-02.iinet.net.au ([203.59.3.34]:31124 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S267467AbUBSCBl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 21:01:41 -0500
Message-ID: <403418FA.2070202@cyberone.com.au>
Date: Thu, 19 Feb 2004 13:01:30 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040122 Debian/1.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Miquel van Smoorenburg <miquels@cistron.nl>
CC: Jens Axboe <axboe@suse.de>, linux-lvm@sistina.com,
       linux-kernel@vger.kernel.org, Joe Thornber <thornber@redhat.com>
Subject: Re: IO scheduler, queue depth, nr_requests
References: <20040216131609.GA21974@cistron.nl> <20040216133047.GA9330@suse.de> <20040217145716.GE30438@traveler.cistron.net> <20040218235243.GA30621@drinkel.cistron.nl> <4034104F.5040002@cyberone.com.au> <20040219015207.GC30621@drinkel.cistron.nl>
In-Reply-To: <20040219015207.GC30621@drinkel.cistron.nl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Miquel van Smoorenburg wrote:

>On Thu, 19 Feb 2004 02:24:31, Nick Piggin wrote:
>
>>Miquel van Smoorenburg wrote:
>>
>>
>>>I found out what causes this. It's get_request_wait().
>>>
>>>When the request queue is full, and a new request needs to be created,
>>>__make_request() blocks in get_request_wait().
>>>
>>>Another process wakes up first (pdflush / process submitting I/O itself /
>>>xfsdatad / etc) and sends the next bio's to __make_request().
>>>In the mean time some free requests have become available, and the bios
>>>are merged into a new request. Those requests are submitted to the device.
>>>
>>>Then, get_request_wait() returns but the bio is not mergeable anymore -
>>>and that results in a backwards seek, severely limiting the I/O rate.
>>>
>>>
>>The "batching" logic there should allow a process to submit
>>a number of requests even above the nr_requests limit to
>>prevent this interleave and context switching.
>>
>>Are you using tagged command queueing? What depth?
>>
>
>No, I'm not using tagged command queueing. The 3ware controller is not a
>real scsi controller, the driver just emulates one. It's a raid5 controller
>that drives SATA disks. It has an internal request queue ("can_queu")
>of 254 outstanding commands.
>

This is what I mean by tagged command queueing.

> Because that is way bigger than nr_requests
>this happens - if I set nr_requests to 512, the problem goes away. But
>that shouldn't happen ;)
>
>

What shouldn't happen?

>I'm preparing a proof-of-concept patch now, if it works and I don't wedge
>the remote machine I'm testing this on I'll post it in a few minutes.
>
>

I'm not very happy with forcing a process to sleep _after_ it
has submitted a request... but I'd be interested to see exactly
what your patch does.

By far the best option is to use appropriately sized queues.
The below patch is a start, but it unfortunately doesn't help
drivers which use private queueing implementations.

http://www.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.3/2.6.3-mm1/broken-out/scale-nr_requests.patch

