Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161011AbWA0U3E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161011AbWA0U3E (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 15:29:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161012AbWA0U3E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 15:29:04 -0500
Received: from [85.8.13.51] ([85.8.13.51]:37593 "EHLO smtp.drzeus.cx")
	by vger.kernel.org with ESMTP id S1161011AbWA0U3C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 15:29:02 -0500
Message-ID: <43DA828B.6020500@drzeus.cx>
Date: Fri, 27 Jan 2006 21:28:59 +0100
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Thunderbird 1.5 (X11/20060112)
MIME-Version: 1.0
To: Russell King <rmk+lkml@arm.linux.org.uk>, Jens Axboe <axboe@suse.de>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: How to map high memory for block io
References: <43D9C19F.7090707@drzeus.cx> <20060127102611.GC4311@suse.de> <43D9F705.5000403@drzeus.cx> <20060127104321.GE4311@suse.de> <43DA0E97.5030504@drzeus.cx> <20060127194318.GA1433@flint.arm.linux.org.uk> <43DA7CD1.4040301@drzeus.cx> <20060127201458.GA2767@flint.arm.linux.org.uk>
In-Reply-To: <20060127201458.GA2767@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:
> On Fri, Jan 27, 2006 at 09:04:33PM +0100, Pierre Ossman wrote:
>   
>> Russell King wrote:
>>     
>>> I don't see what the problem is.  A sg entry is a list of struct page
>>> pointers, an offset, and a size.  As such, it can't describe a transfer
>>> which crosses a page because such a structure does not imply that one
>>> struct page follows another struct page.
>>>       
>> If the pages do not strictly follow each other then there is a lot of
>> broken code in the kernel. drivers/mmc/mmci.c and drivers/block/ub.c
>> being two occurences since both assume they can access the entire entry
>> through a single mapping.
>>     
>
> We don't make that assumption.  What we do is:
>
> - map the current sg using kmap_atomic()
> - copy up to sg->length into or out of that mapping
> - unmap current sg
> - if we have reached the end of this sg, move on to the next
>   

This it the algorithm I've been following, but...

> What this means is that we assume sg->offset + sg->length <= PAGE_SIZE
>   

This doesn't seem to be true. Since when tracking this problem I added
the following:

    BUG_ON((host->cur_sg->length + host->cur_sg->offset) > PAGE_SIZE);


which subsequently triggered. That was the start of my quest for how to
do highmem properly.

Rgds
Pierre


