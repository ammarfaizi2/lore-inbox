Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267383AbUBSB30 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 20:29:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267378AbUBSB30
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 20:29:26 -0500
Received: from mail-02.iinet.net.au ([203.59.3.34]:452 "HELO mail.iinet.net.au")
	by vger.kernel.org with SMTP id S267383AbUBSB3X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 20:29:23 -0500
Message-ID: <4034104F.5040002@cyberone.com.au>
Date: Thu, 19 Feb 2004 12:24:31 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040122 Debian/1.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Miquel van Smoorenburg <miquels@cistron.nl>
CC: Jens Axboe <axboe@suse.de>, linux-lvm@sistina.com,
       linux-kernel@vger.kernel.org, Joe Thornber <thornber@redhat.com>
Subject: Re: IO scheduler, queue depth, nr_requests
References: <20040216131609.GA21974@cistron.nl> <20040216133047.GA9330@suse.de> <20040217145716.GE30438@traveler.cistron.net> <20040218235243.GA30621@drinkel.cistron.nl>
In-Reply-To: <20040218235243.GA30621@drinkel.cistron.nl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Miquel van Smoorenburg wrote:

>On Tue, 17 Feb 2004 15:57:16, Miquel van Smoorenburg wrote:
>
>>For some reason, when using LVM, write requests get queued out
>>of order to the 3ware controller, which results in quite a bit
>>of seeking and thus performance loss.
>>
>[..]
>
>>Okay I repeated some earlier tests, and I added some debug code in
>>several places.
>>
>>I added logging to tw_scsi_queue() in the 3ware driver to log the
>>start sector and length of each request. It logs something like:
>>3wdbg: id 119, lba = 0x2330bc33, num_sectors = 256
>>
>>With a perl script, I can check if the requests are sent to the
>>host in order. That outputs something like this:
>>
>>Consecutive: start 1180906348, length 7936 sec (3968 KB), requests: 31
>>Consecutive: start 1180906340, length 8 sec (4 KB), requests: 1
>>Consecutive: start 1180914292, length 7936 sec (3968 KB), requests: 31
>>Consecutive: start 1180914284, length 8 sec (4 KB), requests: 1
>>Consecutive: start 1180922236, length 7936 sec (3968 KB), requests: 31
>>Consecutive: start 1180922228, length 8 sec (4 KB), requests: 1
>>Consecutive: start 1180930180, length 7936 sec (3968 KB), requests: 31
>>
>>See, 31 requests in order, then one request "backwards", then 31 in order, etc.
>>
>
>I found out what causes this. It's get_request_wait().
>
>When the request queue is full, and a new request needs to be created,
>__make_request() blocks in get_request_wait().
>
>Another process wakes up first (pdflush / process submitting I/O itself /
>xfsdatad / etc) and sends the next bio's to __make_request().
>In the mean time some free requests have become available, and the bios
>are merged into a new request. Those requests are submitted to the device.
>
>Then, get_request_wait() returns but the bio is not mergeable anymore -
>and that results in a backwards seek, severely limiting the I/O rate.
>
>Wouldn't it be better to allow the request allocation and queue the
>request, and /then/ put the process to sleep ? The queue will grow larger
>than nr_requests, but it does that anyway.
>
>

The "batching" logic there should allow a process to submit
a number of requests even above the nr_requests limit to
prevent this interleave and context switching.

Are you using tagged command queueing? What depth?

