Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161005AbVLHGeN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161005AbVLHGeN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Dec 2005 01:34:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030474AbVLHGeM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Dec 2005 01:34:12 -0500
Received: from smtp1.pochta.ru ([81.211.64.6]:37418 "EHLO smtp1.pochta.ru")
	by vger.kernel.org with ESMTP id S1030473AbVLHGeL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Dec 2005 01:34:11 -0500
X-Author: vitalhome@rbcmail.ru from [10.1.27.2] ([82.179.192.198]) via Free Mail POCHTA.RU
Message-ID: <4397D3AA.6050804@ru.mvista.com>
Date: Thu, 08 Dec 2005 09:33:14 +0300
From: Vitaly Wool <vwool@ru.mvista.com>
User-Agent: Mozilla Thunderbird 0.8 (Windows/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David Brownell <david-b@pacbell.net>
CC: linux-kernel@vger.kernel.org, dpervushin@gmail.com, akpm@osdl.org,
       greg@kroah.com, basicmark@yahoo.com, komal_shah802003@yahoo.com,
       stephen@streetfiresound.com, spi-devel-general@lists.sourceforge.net,
       Joachim_Jaeger@digi.com
Subject: Re: [PATCH 2.6-git] SPI core refresh
References: <20051201191109.40f2d04b.vwool@ru.mvista.com> <20051205210110.44a3ba4c.vwool@ru.mvista.com> <200512071759.56782.david-b@pacbell.net>
In-Reply-To: <200512071759.56782.david-b@pacbell.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Brownell wrote:

>On Monday 05 December 2005 10:01 am, Vitaly Wool wrote:
>  
>
>>Again, some advantages of our core compared to David's I'd like to mention
>>
>>- it can be compiled as a module (as opposed to basic David's core w/o Mark Underwood's patch)
>>- it is less priority inversion-exposed
>>    
>>
>
>These are actually minor issues, with almost trivial fixes.  (Pending.)
>
>And I'd argue about the priority inversion thing ... the inversions in
>your stuff come from the API, not the implementation.  Which makes the
>problems inherent, rather than fixable:  "more" exposed, not "less".
>  
>
I don't think it's  true any more (with this new patch).

>>2. We still think that thread-based async messages processing will be the most
>>commonly used option so we didn't remove it from core but made it a compication
>>option whether to include it or not. In any case it can be overridden by a
>>specific bus driver, so even when compiled in, thread-based handling won't
>>necessarily _start_ the threads, so the overhead is minimal even in that case.    
>>    
>>
>
>Whereas I've just said such threading policies don't belong in a "core" at
>all.  You may have noticed the bitbanging adapter I posted ... oddly, that
>implementation allocates a thread.  Hmm ...
>  
>
Please remember that using threads is just a default option which may be 
even turned off at the kernel configuration stage.
Using threads for async transfers is reasonable _default_ assumption. It 
can save time for controller driver dev'ers as well as reduce overall 
kernel footprint (as opposed to different controller drivers each 
implementing thread-based async messages handling).

>That is:  you're not talking about capabilities that aren't already in
>the SPI patches already circulating in 2.6.15-rc5-mm1 (from Sunday).
>They're just layered differently ... the core is _minimal_ and those
>implementation policies can be chosen without adding to the core.
>(Or impacting drivers that want different implementation policies.)
>  
>
Hmm, how are we impacting drivers that want different implementation 
policies? Please look at the latest core :)

>
>  
>
>>3. We still don't feel comportable with complicated structure of SPI message in
>>David's core being exposed to all over the world. On the other hand, chaining
>>SPI messages can really be helpful,
>>    
>>
>
>The point has been made that such chaining is actually "essential", since
>device interaction protocols have constraints like "chipselect must be
>asserted during all these transfers" or contrariwise "between these transfers,
>chipselect must be dropped for N microseconds".  If the async messages didn't
>cover such linked message, then two activities could interfere with each other
>quite badly ... they'd break hardware protocol requirements.
>
>  
>
I don't argue about the need of chaining.
But don't you want to agree that things like this

+	struct spi_transfer	x[1] = { { .tx_dma = 0, }, };
...more initialization follows, spread around the code...


are not well-readable and may shadow what's going on and even lead to 
errors during support/extension of the functionality?
Exposing SPI message structure doesn't look good to me also because 
you're making it a part of the interface (and thus unlikely to change).
We're hiding spi_msg internals what allows us to be more flexible in 
implementation (for instance, implement our own allocation technique for 
spi_msg (more lightweight as the size is always the same).

Yeah thus we don't have an ability to allocate SPI messages on stack as 
you do, that's what votes for your approach. Yours is thus a bit faster, 
though I suspect that this method is a possible *danger* for really 
high-speed devices with data bursts on the SPI bus like WiFi adapters: 
stack's gonna suffer from large amounts of data allocated.

>>so we added this option to our core (yeeeep, 
>>convergence is gong on :)) but
>>    
>>
>
>My preferred level of convergence would be changes to make your code look
>more like mine, especially where you're providing a mechanism that's been
>in mine all along ... hmm, like spi_driver is the same now.  I made one
>such change; maybe it's your turn now.  ;)
>  
>
Okay :)

Vitaly
