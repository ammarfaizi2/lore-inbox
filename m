Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932469AbWA0MO2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932469AbWA0MO2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 07:14:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932471AbWA0MO1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 07:14:27 -0500
Received: from [85.8.13.51] ([85.8.13.51]:11225 "EHLO smtp.drzeus.cx")
	by vger.kernel.org with ESMTP id S932469AbWA0MO1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 07:14:27 -0500
Message-ID: <43DA0E97.5030504@drzeus.cx>
Date: Fri, 27 Jan 2006 13:14:15 +0100
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Thunderbird 1.5 (X11/20060112)
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>, Russell King <rmk+lkml@arm.linux.org.uk>
CC: LKML <linux-kernel@vger.kernel.org>
Subject: Re: How to map high memory for block io
References: <43D9C19F.7090707@drzeus.cx> <20060127102611.GC4311@suse.de> <43D9F705.5000403@drzeus.cx> <20060127104321.GE4311@suse.de>
In-Reply-To: <20060127104321.GE4311@suse.de>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
> On Fri, Jan 27 2006, Pierre Ossman wrote:
>   
>> Jens Axboe wrote:
>>     
>>> On Fri, Jan 27 2006, Pierre Ossman wrote:
>>>   
>>>       
>>>> I'm having some problems getting high memory support to work smoothly in
>>>> my driver. The documentation doesn't indicate what I might be doing
>>>> wrong so I'll have to ask here.
>>>>
>>>> The problem seems to be that kmap & co maps a single page into kernel
>>>> memory. So when I happen to cross page boundaries I start corrupting
>>>> some unrelated parts of the kernel. I would prefer not having to
>>>> consider page boundaries in an already messy PIO loop, so I've been
>>>> trying to find either a routine to map an entire sg entry or some way to
>>>> force the block layer to not give me stuff crossing pages.
>>>>
>>>> As you can guess I have not found anything that can do what I want, so
>>>> some pointers would be nice.
>>>>     
>>>>         
>>> Honestly, just don't bother if you are doing PIO anyways. Just tell the
>>> block layer that you want io bounced for you instead.
>>>
>>>   
>>>       
>> This is the MMC layer so there is some separation between the block
>> layer and the drivers. Also, the transfers won't necessarily be from the
>> block layer so a generic solution is desired. I don't suppose there is
>> some way of accessing the bounce buffer routines in a non-bio context?
>>     
>
> Only the mapping routines are appropriate at that point, or things get
> complicated. You could still do a two-page mapping, if you are careful
> about using different KMAP_ types.
>
>   

That would still make things rather difficult since there is no way to
get both maps into joining vaddrs. Is there no way to say "don't cross
page boundaries"? Setting a segment size of PAGE_SIZE still causes
problems when the offset isn't 0.

Russell, would having a "highmem not supported" flag in the host
structure be an acceptable solution? mmc_block could then use that to
tell the block layer that bounce buffers are needed. As for other,
future, users they would have to take care not to give those drivers
highmem sg lists.

The current buggy code, was modeled after another MMC driver (mmci). So
I suspect there might be more occurrences like this. Perhaps an audit
should be added as a janitor project?

Rgds
Pierre

