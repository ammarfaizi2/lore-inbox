Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267412AbUBSWwp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 17:52:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267411AbUBSWwp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 17:52:45 -0500
Received: from mail-03.iinet.net.au ([203.59.3.35]:52627 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S267412AbUBSWwk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 17:52:40 -0500
Message-ID: <40353E30.6000105@cyberone.com.au>
Date: Fri, 20 Feb 2004 09:52:32 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040122 Debian/1.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Miquel van Smoorenburg <miquels@cistron.nl>
CC: Jens Axboe <axboe@suse.de>, Andrew Morton <akpm@osdl.org>,
       linux-lvm@sistina.com, linux-kernel@vger.kernel.org,
       thornber@redhat.com
Subject: Re: IO scheduler, queue depth, nr_requests
References: <20040216131609.GA21974@cistron.nl> <20040216133047.GA9330@suse.de> <20040217145716.GE30438@traveler.cistron.net> <20040218235243.GA30621@drinkel.cistron.nl> <20040218172622.52914567.akpm@osdl.org> <20040219021159.GE30621@drinkel.cistron.nl> <20040218182628.7eb63d57.akpm@osdl.org> <20040219101519.GG30621@drinkel.cistron.nl> <20040219101915.GJ27190@suse.de> <20040219205907.GE32263@drinkel.cistron.nl>
In-Reply-To: <20040219205907.GE32263@drinkel.cistron.nl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Miquel van Smoorenburg wrote:

>On Thu, 19 Feb 2004 11:19:15, Jens Axboe wrote:
>
>>On Thu, Feb 19 2004, Miquel van Smoorenburg wrote:
>>
>>
>>>>Shouldn't the controller itself be performing the insertion?
>>>>
>>>Well, you would indeed expect the 3ware hardware to be smarter than
>>>that, but in its defence, the driver doesn't set sdev->simple_tags or
>>>sdev->ordered_tags at all. It just has a large queue on the host, in
>>>hardware.
>>>
>>A too large queue. IMHO the simple and correct solution to your problem
>>is to diminish the host queue (sane solution), or bump the block layer
>>queue size (dumb solution).
>>
>
>Well, I did that. Lowering the queue size of the 3ware controller to 64
>does help a bit, but performance is still not optimal - leaving it at 254
>and increasing the nr_requests of the queue to 512 helps the most.
>
>But the patch I posted does just as well, without any tuning. I changed
>it a little though - it only has the "new" behaviour (instead of blocking
>on allocating a request, allocate it, queue it, _then_ block) for WRITEs.
>That results in the best performance I've seen, by far.
>
>

That's because you are half introducing per-process limits.

>Now the style of my patch might be ugly, but what is conceptually wrong
>with allocating the request and queueing it, then block if the queue is
>full, versus blocking on allocating the request and keeping a bio
>"stuck" for quite some time, resulting in out-of-order requests to the
>hardware ?
>
>

Conceptually? The concept that you have everything you need to
continue and yet you block anyway is wrong.

>Note that this is not an issue of '2 processes writing to 1 file', really.
>It's one process and pdflush writing the same dirty pages of the same file.
>
>

pdflush is a process though, that's all that matters.

