Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750844AbVLBFsW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750844AbVLBFsW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Dec 2005 00:48:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750831AbVLBFsW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Dec 2005 00:48:22 -0500
Received: from rtsoft2.corbina.net ([85.21.88.2]:7104 "HELO mail.dev.rtsoft.ru")
	by vger.kernel.org with SMTP id S1750844AbVLBFsV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Dec 2005 00:48:21 -0500
Message-ID: <438FE01C.9070307@ru.mvista.com>
Date: Fri, 02 Dec 2005 08:48:12 +0300
From: Vitaly Wool <vwool@ru.mvista.com>
User-Agent: Mozilla Thunderbird 0.8 (Windows/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David Brownell <david-b@pacbell.net>
CC: Mark Underwood <basicmark@yahoo.com>, linux-kernel@vger.kernel.org,
       dpervushin@gmail.com, akpm@osdl.org, greg@kroah.com,
       komal_shah802003@yahoo.com, stephen@streetfiresound.com,
       spi-devel-general@lists.sourceforge.net, Joachim_Jaeger@digi.com
Subject: Re: [PATCH 2.6-git] SPI core refresh
References: <20051130202930.67776.qmail@web36914.mail.mud.yahoo.com> <438EA389.7030704@ru.mvista.com> <200512011031.12167.david-b@pacbell.net>
In-Reply-To: <200512011031.12167.david-b@pacbell.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Brownell wrote:

>On Wednesday 30 November 2005 11:17 pm, Vitaly Wool wrote:
>  
>
>>Mark Underwood wrote:
>>
>>    
>>
>>>>However, there also are some advantages of our core compared to David's I'd like to mention
>>>>
>>>>- it can be compiled as a module
>>>>        
>>>>
>>>So can David's. You can use BIOS tables in which case you must compile the SPI core into the
>>>kernel but you can also use spi_new_device which allows the SPI core to be built as a module (and
>>>is how I am using it).
>>>      
>>>
>>You limit the functionality, so it's not the case.
>>    
>>
>
>As noted in my comparison of last week (you're still ignoring that):
>
> - Mine lets board-specific device tables be declared in the
>   relevant arch_setup() thing (board-*.c).  Both frameworks allow
>   later board specific code to dynamically declare the devices,
>   with binary (Dave's) or parsed-text (Dmitry's) descriptions. 
>
>What Mark said was that in this case he used the "late" init.  You seem
>to be saying he's not allowed to do that.  Which is nonsense; there are
>distinct mechanisms for the good reason that "late" init doesn't work
>so well without dynamic discovery ... which SPI itself doesn't support.
>Hence the need for board-specific "this hardware exists" tables.
>
>  
>
Can you please clarify what you mean here? Better even if Mark describes 
what he does. The ideal situation would be if he posted a patch.

>  
>
>>If there's more than one SPI controller onboard, spi_write_then_read 
>>will serialize the transfers ...
>>    
>>
>
>Which, as has been pointed out, would be a trivial thing to fix
>if anyone were actually to have a problem.  Sure it'd incur the
>cost of a kmalloc on at least some paths -- serializing in the
>slab layer instead! -- but that's one price of using convenience
>helpers not performance oriented calls.
>  
>
Well, most of the drivers will use that helpers I guess.
The thing however is that if you try to implement this in a "clean" way 
you will come to a sport of framework we've developed for memeory 
allocations, as I've saild previously.

>
>  
>
>>	 Moreover, if, say, two  
>>kernel threads with different priorities are working with two SPI 
>>controllers respectively *priority inversion* will happen.
>>    
>>
>
>That characteristic being inherited from semaphores (or were they
>updated with RT_PREEMPT?), and being in common with most I/O queues
>in the system.  Not something to blame on any line of code I wrote.
>  
>
I think they weren't.
The whole thing doesn't seem thought out nicely to me. The solution 
exists, of course, and that is -- do somthing similar to what we did there.

>Oh, and I noticed a priority inversion in your API which shows
>up with one SPI controller managing two devices.  Whoops!  I'd
>far rather have such inversions be implementation artifacts; it's
>easy to patch an implementation, hard to change all API users.
>  
>
Not sure if I understood you. Can you please describe the situation when 
this prio inversion happens?
What priorities are you talking about? One controller is one thread, so 
it's _one_ priority, consequently there's nothing to invert.
As for your second statement, I don't argue. The fact however is that if 
you implement the mehtod which corrects priority inverstion problems 
your core will not be either so lightweight or so flexible. :)

>
>  
>
>>>>- it's more adapted for use in real-time environments
>>>>- it's not so lightweight, but it leaves less effort for the bus driver developer.
>>>>        
>>>>
>>>But also less flexibility. A core layer shouldn't _force_ a policy
>>>      
>>>
>>Nope, it's just a default policy.
>>    
>>
>
>One that every driver pays the price for.  Allocating a task even
>when it doesn't need it; every call going through a midlayer that
>wants to take over queue management policy; and more.  (Unless you
>made a big un-remarked change in a patch you called "refresh"...)
>  
>
It's not obvious that this price is high.
Anyway, it's a point I should agree with; this functionality better be a 
config option. Feel free to submit a patch, as you like to say.

>
>  
>
>>>on a bus driver. I am currently developing an adapter driver for David's system and I wouldn't say
>>>that the core is making me do things I think the core should do. Please could you provide examples
>>>of where you think Davids SPI core requires 'effort'.
>>>      
>>>
>>Main are
>>- the need to call 'complete' in controller driver
>>    
>>
>
>So you think it's better to have consistent semantics be optional?
>
>That seems to be the notion behind your spi_transfer() call, which
>can't decide whether it's going to be synchronous or asynchronous.
>Instead, it decided to be error prone and be both.  :)
>
>
>  
>
Not sure if I understood you here, sorry.

>>- the need to implement policy in controller driver
>>    
>>
>
>The "policy" in question is something that sometimes needs to
>be board-specific -- priority to THAT device, synch with THIS
>external signal, etc -- which is why I see it as a drawback
>that you insist the core implement one policy.
>  
>
Again, the policy can be overridden.

Vitaly
