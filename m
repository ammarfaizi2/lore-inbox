Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263395AbTIGR5o (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Sep 2003 13:57:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263397AbTIGR5o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Sep 2003 13:57:44 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:12531 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S263395AbTIGR5l
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Sep 2003 13:57:41 -0400
Message-ID: <3F5B718E.7060007@mvista.com>
Date: Sun, 07 Sep 2003 10:57:34 -0700
From: George Anzinger <george@mvista.com>
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021202
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
CC: Andrew Morton <akpm@osdl.org>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, "Nakajima, Jun" <jun.nakajima@intel.com>
Subject: Re: [PATCHSET][2.6-test4][0/6]Support for HPET based timer - Take
 2
References: <C8C38546F90ABF408A5961FC01FDBF1902C7D245@fmsmsx405.fm.intel.com>
In-Reply-To: <C8C38546F90ABF408A5961FC01FDBF1902C7D245@fmsmsx405.fm.intel.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pallipadi, Venkatesh wrote:
> 
> 
>>-----Original Message-----
>>From: George Anzinger [mailto:george@mvista.com]
>>
>>Pallipadi, Venkatesh wrote:
>>
>>>
>>>>-----Original Message-----
>>>>From: Andrew Morton [mailto:akpm@osdl.org] 
>>>>
>>>>We seem to keep on proliferating home-grown x86 64-bit math 
>>
>>functions.
>>
>>>>Do you really need these?  Is it possible to use do_div() and 
>>>>the C 64x64
>>>>`*' operator instead?
>>>>
>>>
>>>
>>>
>>>We can change these handcoded 64 bit divs to do_div, with just an
>>>additional data copy 
>>
>>We already have this in .../include/asm-i386/div64.h.  Check usage in 
>>.../posix-timers.c to cover archs that have not yet included it in 
>>there div64.h.
>>
> 
> 
> 
> Yes. We can surely use div_long_long_rem from div64 in place of defining 
> this again. This kind of code is already there in the existing ia32 timer
> code too. I will try and come up with a cleanup patch to replace all 
> these individual asm div statements.
> 
> 
> 
>>>(as do_div changes dividend in place). But, changing mul 
>>
>>into 64x64 '*'
>>
>>>may be tricky. 
>>>Gcc seem to generate a combination of mul, 2imul and add, 
>>
>>where as we
>>
>>>are happy with 
>>>using only one mull here.
>>
>>You just need to do the right casting.  It should like 
>>u64=u32*(u64)u32  as in .../kernel/posix-timers.c.  This 
>>could also be 
>>signed with the same results.  If you really need to do a u64*u32, it 
>>will do that as well but takes two mpys.  In this case you will need 
>>to do it unsigned to eliminate the third mpy.
> 
> 
> 
> Interesting. Is this casting to generate proper mul instruction
> some sort of C standard or is it a gcc feature. I just want to
> make sure doing this way won't break on some other compiler 
> (or on some other version of gcc itself).

I don't really know, but I suspect it is a gcc thing.  Some how the 
standards folks got in and messed up the original idea of keeping the 
language close to the machine when they said that the data type in to 
and out of a C operator should be the same, thus not allowing the true 
mpy result to find expression in the language.  The same thing applies 
to the "/" and "%" operators, which to my knowledge, require either 
really messy macros/c code or asm to allow the machine u64/u32 to work.
> 
> 
> Thanks,
> -Venkatesh
> 
> 

-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml

