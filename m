Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932156AbVJCGTR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932156AbVJCGTR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Oct 2005 02:19:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932157AbVJCGTR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Oct 2005 02:19:17 -0400
Received: from [85.21.88.2] ([85.21.88.2]:22980 "HELO mail.dev.rtsoft.ru")
	by vger.kernel.org with SMTP id S932156AbVJCGTQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Oct 2005 02:19:16 -0400
Message-ID: <4340CDB8.2060204@ru.mvista.com>
Date: Mon, 03 Oct 2005 10:20:40 +0400
From: Vitaly Wool <vwool@ru.mvista.com>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David Brownell <david-b@pacbell.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] SPI
References: <20051003050130.EE003EA55B@adsl-69-107-32-110.dsl.pltn13.pacbell.net>
In-Reply-To: <20051003050130.EE003EA55B@adsl-69-107-32-110.dsl.pltn13.pacbell.net>
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Brownell wrote:

>>>You're imposing the same implementation strategy Mark Underwood was.
>>>I believe I persuaded him not to want that, pointing out three other
>>>implementation strategies that can be just as reasonable:
>>>
>>>  http://marc.theaimsgroup.com/?l=linux-kernel&m=112684135722116&w=2
>>>
>>>It'd be fine if for example your PNX controller driver worked that way
>>>internally.  But other drivers shouldn't be forced to allocate kernel
>>>threads when they don't need them.
>>>      
>>>
>>Hm, so does that imply that the whole -rt patches from 
>>Ingo/Sven/Daniel/etc. are implementing wrong strategy (interrupts in 
>>threads)?
>>    
>>
>
>In an RT context, it may make sense to impose a policy like that.
>
>But I recall those folk have said they're making things so that sanely
>behaved kernel code will work with no changes.  And also that not all
>kernels should be enabling RT support ...
>
>  
>
FYI in brief: for PREEMPT_RT case all the interrupt handlers are working 
in a separate thread each unless explicitly specified otherwise.
This strategy proven itself to be quite functional and not significantly 
impacting the performance.
So, typically this means allocation of five to eight threads for 
interrupt handlers.
We will definitely have less SPI busses => less kernel threads, so I 
doubt there's a rationale in your opinion.

>>How will your strategy work with that BTW?
>>    
>>
>
>If they meet their goals, it'll work just fine.  Sanely behaved
>implementations will continue to work, and not even notice.
>  
>
Hm. How are you going to call something from an interrupt context? I 
guess that's gonna happen from an interrupt handler.
So there're 2 ways for PREEMPT_RT:
1) you're playing according to the rules  and don't specify SA_NODELAY 
=> the interrupt handler is in thread => bigger latencies for SPI than 
if we had separate kernel threads for each bus
2) you're not following the rules as specify SA_NODELAY => you're 
working in interrupt context creating a significant load to the 
interrupt context and slowing down everything that *is* following the rules.
So either SPI performance suffers, or RT performance does. :(

>
>
>  
>
>>>>+  [ picture deleted ]
>>>>        
>>>>
>>>That seems wierd even if I assume "platform_bus" is just an example.
>>>For example there are two rather different "spi bus" notions there,
>>>and it looks like neither one is the physical parent of any SPI device ...
>>>      
>>>
>>Not sure if I understand you :(
>>    
>>
>
>Why couldn't for example SPI sit on a PCI bus?
>
>And call the two boxes different things, if they're really different.
>The framework I've posted has "spi_master" as a class implmented
>by certain controller drivers.  (Others might use "spi_slave", and
>both would be types of "SPI bus".)  That would at least clarify
>the confusion on the left half of that picture.
>
>
>
>  
>
>>>>+3.2 How do the SPI devices gets discovered and probed ?
>>>>   
>>>>        
>>>>
>>>Better IMO to have tables that get consulted when the SPI master controller
>>>drivers register the parent ... tables that are initialized by the board
>>>specific __init section code, early on.  (Or maybe by __setup commandline
>>>parameters.)
>>>
>>>Doing it the way you are prevents you from declaring all the SPI devices in
>>>a single out-of-the-way location like the arch/.../board-specific.c file,
>>>which is normally responsible for declaring devices that are hard-wired on
>>>a given board and can't be probed.
>>> 
>>>
>>>      
>>>
>>By what means does it prevent that?
>>    
>>
>
>Well "prevent" may be a bit strong, if you like hopping levels in
>the software stack.  I don't; without such hopping (or without a
>separate out-of-band mechanism like device tables), I don't see
>a way to solve that problem.
>  
>
Aren't the tables you're suggesting also kinda out-of-band stuff?

>
>  
>
>>>>+#define SPI_MAJOR	153
>>>>+
>>>>+...
>>>>+
>>>>+#define SPI_DEV_CHAR "spi-char"
>>>>   
>>>>
>>>>        
>>>>
>>I thought 153 was the official SPI device number.
>>    
>>
>
>So it is (at least for minors 0..15, so long as they use some
>API I can't find a spec for), but that wasn't the point.  The
>point is to keep that sort of driver-specific information from
>cluttering headers which are addressed to _every_ driver.
>  
>
Yup, thanks for clarifications.

Vitaly
