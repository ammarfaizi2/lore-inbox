Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751741AbVLBGB4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751741AbVLBGB4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Dec 2005 01:01:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751744AbVLBGB4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Dec 2005 01:01:56 -0500
Received: from rtsoft2.corbina.net ([85.21.88.2]:51648 "HELO
	mail.dev.rtsoft.ru") by vger.kernel.org with SMTP id S1751740AbVLBGB4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Dec 2005 01:01:56 -0500
Message-ID: <438FE350.1010106@ru.mvista.com>
Date: Fri, 02 Dec 2005 09:01:52 +0300
From: Vitaly Wool <vwool@ru.mvista.com>
User-Agent: Mozilla Thunderbird 0.8 (Windows/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David Brownell <david-b@pacbell.net>
CC: linux-kernel@vger.kernel.org, dpervushin@gmail.com, akpm@osdl.org,
       greg@kroah.com, basicmark@yahoo.com, komal_shah802003@yahoo.com,
       stephen@streetfiresound.com, spi-devel-general@lists.sourceforge.net,
       Joachim_Jaeger@digi.com
Subject: Re: [PATCH 2.6-git] MTD/SPI dataflash driver
References: <20051201191109.40f2d04b.vwool@ru.mvista.com> <20051201191837.222fe0b3.vwool@ru.mvista.com> <200512011033.41627.david-b@pacbell.net>
In-Reply-To: <200512011033.41627.david-b@pacbell.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Brownell wrote:

>On Thursday 01 December 2005 8:18 am, Vitaly Wool wrote:
> 
>  
>
>>It took about fifteen minutes of mindwork to port the MTD dataflash driver
>>posted by David Brownell 11/23 to our SPI core from David's,
>>    
>>
>
>Interesting and informative; +1!
>
>Did you have a chance to test this?  There are some post-2.6.15-rc3-mm1
>updates to this code, mostly to catch startup fauults better but also to
>hotplug reasonably.  The glitches I saw may as easily be JFFS2 integration
>issues for the DataFlash code as bitbang adapter problems.  (I think you
>started more or less from what's in rc3-mm1.)
>
>  
>
Very basically. I've make a note that it was a mindwork.I also didn't 
make the attempt to make it a clean MTD driver.
However, it would be nice if someone compared the performance of both 
variants.

>  
>
>>reducing both 
>>the size of the source code and the footprint of the object code.
>>I'd also like to mention that now it looks significatnly easier to understand
>>due to no more use of complicated SPI message structures. The number of variables
>>used was also decreased
>>    
>>
>
>I think that's all the same issue.  Other than "spi_driver" replacing
>"device_driver" (I'd like to see a patch doing that to rc3-mm1), the
>main changes seem to be:
>
>  - Move from original atomic requests like this
>
>	{ write command, read response }
>
>    over to two separate requests
>
>	{ write command, and leave CS active }
>	{ read response, and leave CS off }
>
> - Lower the per-request performance ceiling on this driver
>
>      * original code could be implemented in a single DMA chain on
>        at least two systems I happen to have handy ... one IRQ.
>  
>
Whoops. Lemme express my thoughts here.
First, the DMA controller that can handle chained requests which are 
working with different devices (i.e. write then read does that - first 
mem2per, then per2mem) are *very* rare thing.
Then, what _really_ can happen in a single DMA chain? 99,9999% cases of 
such will be "read x bytes to get aware of the length of the packet, 
then read the data packet". Here you won't have any noticable 
performance gain as the first transfer is to small. It's soooo small 
that the overhead of having a linked list for DMA will probably be 
bigger than that of having two transfers. A smart controller driver may 
even want to have a PIO read on first x bytes (as x will be equal to 2 
or 4, I guess :)

>      * this version requires two separate chains, with an intervening
>        task schedule.  (More than twice the cost.)
>  
>
See above.

>      * in your framework I still can't be _sure_ it never does memcpy
>        for those buffers (the last version I looked at did so).  the
>        original code just used normal DMA models, so it "obviously"
>        doesn't risk memcpy.
>  
>
You can be sure if you set SPI_M_DNA flag. I'll update the Doc accordingly.

> - I might agree with this being "easier to understand" code, though
>   it's debatable.  (The device sees one transaction, why should the
>   driver writer have to split it up into two?)  But that doesn't
>   matter much:  filesystems are better with "faster to run" code.
>  
>
Your clains that the originl code is faster are arguable.

> - Chipselect works differently in your code.  You're giving one
>   driver control over all the devices sharing a controller, by
>   blocking requests going to other devices until your driver yields
>   the chipselect.  
>  
>
The controllers we were working with are _not_ able to handle 
simultaneous requests to different devices on the same bus.
Can you please tell me what specific controller you're referring to?

>So the way I see it, this is a good example of why my original I/O model
>is better.  It provides _flexibility_ in the API so that some drivers
>can be really smart, if they want to.  You haven't liked the consequence
>of that though:  controller drivers being able to choose how they
>represent and manage I/O queues, rather than doing that in your "core".
>
>  
>
Not that I agreed to your vision, for the reasons listed above. ;-)

Vitaly
