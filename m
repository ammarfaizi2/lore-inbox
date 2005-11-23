Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932518AbVKWJdT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932518AbVKWJdT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 04:33:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932522AbVKWJdT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 04:33:19 -0500
Received: from rtsoft2.corbina.net ([85.21.88.2]:54180 "HELO
	mail.dev.rtsoft.ru") by vger.kernel.org with SMTP id S932518AbVKWJdS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 04:33:18 -0500
Message-ID: <43843768.1050405@ru.mvista.com>
Date: Wed, 23 Nov 2005 12:33:28 +0300
From: Vitaly Wool <vwool@ru.mvista.com>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David Brownell <david-b@pacbell.net>
CC: Mark Underwood <basicmark@yahoo.com>,
       dmitry pervushin <dpervushin@gmail.com>, Andrew Morton <akpm@osdl.org>,
       Greg KH <greg@kroah.com>, osdl.org@ascent.mvista.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       spi-devel-general@lists.sourceforge.net
Subject: Re: [spi-devel-general] Re: SPI
References: <20051122191104.48403.qmail@web36907.mail.mud.yahoo.com> <200511221233.16634.david-b@pacbell.net>
In-Reply-To: <200511221233.16634.david-b@pacbell.net>
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Brownell wrote:

>By the way Vitaly ... I'm still not getting responses directly from you.
>
>Are you pruning me off CC lists, or is there something between us that's
>filtering out posts?  It's certainly hard to respond to comments of yours
>when I can only find them by going through some list archive I wouldn't
>normally read...
>  
>
No, definitely I'm not. I'm just responding with "Reply All" button in 
my Thunderbird, if you wanna know the details.
And I'm quite surprised to hear about the kind of problems you have as 
you're the only one who's having them.

>>>>So for example one way you know that (c) is well met is that it's the same
>>>>approach used in USB (both host and peripheral/gadget sides); that's been
>>>>working well for quite a few years now.  (Despite comments from Dmitry
>>>>and Vitaly to the contrary.)
>>>> 
>>>>
>>>>        
>>>>
>>>Lemme point you out that if somehting is "working" on a limited number 
>>>of platforms within the limited number of use cases, that's not 
>>>necessarily a correct implementation.
>>>      
>>>
>>No, but it's a good indication :).
>>    
>>
>
>And I'm not sure what a "limited number of platforms" etc is supposed
>to suggest.  In terms of platforms supporting USB on Linux, there are
>surely more of them than there are for PCI ... since every PCI platform
>can support USB, and many non-PCI platforms do also.  A better word
>for that DMA support would seem to be "extensive", not "limited".
>
>In fact, the support for non-PCI platforms was one of the things that
>led to the last DMA-related reworks for USB.  The PCI calls wouldn't
>work (of course), but USB needs things like DMA-coherent buffers (for
>transfer and queue head descriptors, used by most controllers) as well
>as bus-neutral DMA operations.  And it even works for things like
>scatterlist merging through IOMMU mappings ... that wide portability
>is **very much** a good indication that (c) is a non-issue with the
>framework I've assembled.
>
>
>Vitaly, you're really going to have to come up with some facts if you
>keep claiming the SPI framework I've posted doesn't support DMA.
>(I'm not going to let you pull a SCO on us here.)  For that matter,
>you might want to consider the fact that Stephen's pxa2xx_spi
>driver disproves your arguments (it includes DMA support).
>  
>
Again, a single working driver cannot disapprove anything.
Evidently enough for anyone more or less familiar with logic, if one 
claims that something is working, he should prove it's working 
everywhere not somewhere; on the other hand, to disapprove this 
statement it's enough to give one example.

However, your latest core should be working on the problematic target as 
opposed to the previous one. I didn't try that but I think it'll work.
The thing is that what we do in the core to provide DMA capabilities 
should be implemented in controller driver in your case.
I can agree that it might be considered an addition to the core and not 
directly included in it, but leaving rather standard operations to the 
controller driver degrades the added value of the core.

>
>  
>
>>>>>>- (A) has some assumptions on buffers that are passed down to spi
>>>>>> functions.
>>>>>>            
>>>>>>
>>>>Make that "requirements"; FWIW they're the same ones that apply to all
>>>>other kernel driver frameworks I've seen:  that buffers be DMA-safe.
>>>>It would not be helpful (IMO) to define different rules; that's also
>>>>called the "Principle of Least Astonishment".  :)
>>>>        
>>>>
>>>Yeah within this requirement it's correct. But that requirement may 
>>>really make the SPI controller driver a lot more complex if
>>>- it has to send something received from the userland
>>>      
>>>
>
>Controller drivers don't deal with userland addresses.  That's the
>responsibility of the layers on top ... e.g. the filesystem or driver
>code that accepts them.  Most just copy to/from userspace, but some
>pay the costs to support direct I/O.
>  
>
Oh no, you've got me wrong. I was tryng to say that an upper level 
driver which copies the data from the userspace should be copying it to 
GFP_DMA buffer, otherwise it won't work or will force the controller 
driver to allocate/copy.
And putting a requirement on the upper level driver to always do GFP_DMA 
kmalloc's might put too high restrictions on the memory usage.
Basically the upper level driver shouldn't give a damn whether the 
buffers should be DMA-able or not since it might be used on different 
platforms w/ and w/o DMA capabilities. Thus, it's going to be either a 
requirement for the upper level drivers that implies the SPI core not 
being transparent to the upper level, or a requirement for each 
controller driver that might be handling this situation to implement the 
same thing we did in the core. Neither of these seems reasonable to me.

>
>  
>
>>>- it needs to timely send some credentials (what is the case for the 
>>>WLAN driver, for instance).
>>>      
>>>
>
>Again, not the responsibility of the lowest level driver.   A WLAN driver
>layered on top could, of course.  That's the way such things are done in
>other driver stacks.
>
>Are you seriously suggesting that an SPI controller driver should have any
>clue whatever about credentials??   Which of the dozens of schemes should
>become that "special", then ... and why??
>
>  
>
I'm afraid that you were not reading my response attentively. 
Credentials are stored in a staic-allocated buffer in the upper level 
driver. Then they are passed down to the SPI core which will fail to 
send the buffer containing the credentials if it's not copied to DMAable 
memory somewhere in between.

Vitaly
