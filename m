Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261871AbTJWXVB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Oct 2003 19:21:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261872AbTJWXVB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Oct 2003 19:21:01 -0400
Received: from mail-06.iinet.net.au ([203.59.3.38]:35249 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S261871AbTJWXU4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Oct 2003 19:20:56 -0400
Message-ID: <3F986276.4010409@cyberone.com.au>
Date: Fri, 24 Oct 2003 09:21:26 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: Daniel Phillips <phillips@arcor.de>
CC: Jens Axboe <axboe@suse.de>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ide write barrier support
References: <20031013140858.GU1107@suse.de> <200310231822.36023.phillips@arcor.de> <20031023162310.GQ6461@suse.de> <200310231920.39888.phillips@arcor.de>
In-Reply-To: <200310231920.39888.phillips@arcor.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Daniel Phillips wrote:

>On Thursday 23 October 2003 18:23, Jens Axboe wrote:
>
>>On Thu, Oct 23 2003, Daniel Phillips wrote:
>>
>>>I'm specifically interested in working out the issues related to stacked
>>>virtual devices, and there are many.  Let me start with an easy one.
>>>
>>>Consider a multipath virtual device that is doing load balancing and
>>>wants to handle write barriers efficiently, not just allow the
>>>downstream queues to drain before allowing new writes.  This device
>>>wants to send a write barrier to each of the downstream devices,
>>>however, we have only one write request to carry the barrier bit.  How
>>>do you recommend handling this situation?
>>>
>>That needs something to hold the state in, and a bio per device. As
>>they complete, mark them as such. When they all have completed, barrier
>>is done.
>>
>>That's just an idea, I'm sure there are other ways. Depending on how
>>complex it gets, it might not be a bad idea to just let the queues drain
>>though. I think I'd prefer that approach.
>>
>
>These are essentially the same, they both rely on draining the downstream 
>queues.  But if we could keep the downstream queues full, bus transfers for 
>post-barrier writes will overlap the media transfers for pre-barrier writes, 
>which would seem to be worth some extra effort.
>
>To keep the downstream queues full, we must submit write barriers to all the 
>downstream devices and not wait for completion.  That is, as soon as a 
>barrier is issued to a given downstream device we can start passing through 
>post-barrier writes to it.
>
>Assuming this is worth doing, how do we issue N barriers to the downstream 
>devices when we have only one incoming barrier write?
>

You would do this in the multipath code, wouldn't you?

Anyway, I might be missing something, but I don't think draining the
queue will guarantee that writeback caches will go to permanent storage.


