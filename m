Return-Path: <linux-kernel-owner+w=401wt.eu-S932746AbWLSKEv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932746AbWLSKEv (ORCPT <rfc822;w@1wt.eu>);
	Tue, 19 Dec 2006 05:04:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932721AbWLSKEv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Dec 2006 05:04:51 -0500
Received: from 1-1-8-31a.gmt.gbg.bostream.se ([82.182.75.118]:61832 "EHLO
	lin5.shipmail.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932749AbWLSKEu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Dec 2006 05:04:50 -0500
X-Greylist: delayed 1216 seconds by postgrey-1.27 at vger.kernel.org; Tue, 19 Dec 2006 05:04:49 EST
Message-ID: <4587B47F.20008@tungstengraphics.com>
Date: Tue, 19 Dec 2006 10:44:31 +0100
From: =?UTF-8?B?VGhvbWFzIEhlbGxzdHLDtm0=?= <thomas@tungstengraphics.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.8) Gecko/20050511
X-Accept-Language: sv, en-us, en
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
CC: Dave Jones <davej@redhat.com>, Dave Airlie <airlied@linux.ie>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [patch 1/2] agpgart - allow user-populated memory types.
References: <4579ADE3.6040609@tungstengraphics.com>	 <1165616236.27217.108.camel@laptopd505.fenrus.org>	 <1095.213.114.71.166.1165619148.squirrel@www.shipmail.org> <1166518064.3365.1188.camel@laptopd505.fenrus.org>
In-Reply-To: <1166518064.3365.1188.camel@laptopd505.fenrus.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:

>On Sat, 2006-12-09 at 00:05 +0100, Thomas Hellström wrote:
>  
>
>>>On Fri, 2006-12-08 at 19:24 +0100, Thomas HellstrÃ¶m wrote:
>>>      
>>>
>>>>+       }
>>>>+
>>>>+       if (alloc_size <= PAGE_SIZE) {
>>>>+               new->memory = kmalloc(alloc_size, GFP_KERNEL);
>>>>+       }
>>>>+       if (new->memory == NULL) {
>>>>+               new->memory = vmalloc(alloc_size);
>>>>        
>>>>
>>>this bit is more or less evil as well...
>>>
>>>1) vmalloc is expensive all the way, higher tlb use etc etc
>>>2) mixing allocation types is just a recipe for disaster
>>>3) if this isn't a frequent operation, kmalloc is fine upto at least 2
>>>pages; I doubt you'll ever want more
>>>      
>>>
>>I understand your feelings about this, and as you probably understand, the
>>kfree / vfree thingy is a result of the above allocation scheme.
>>    
>>
>
>the kfree/vfree thing at MINIMUM should be changed though. Even if you
>need both kfree and vfree, you should key it off of a flag that you
>store, not off the address of the memory, that's just unportable and
>highly fragile. You *know* which allocator you used, so store it and use
>THAT info.
>
>
>
>  
>
>>The allocated memory holds an array of struct page pointers. The number of
>>struct page pointers will range from 1 to about 8192, so the alloc size
>>will range from 4bytes to 64K, but could go higher depending on
>>architecture.
>>    
>>
>
>hmm 64Kb is a bit much indeed. You can't do an array of upto 16 entries
>with one page in each array entry? 
>
>  
>
Arjan,
Thanks for taking time to review this.

A short background:
The current code uses vmalloc only. The potential use of kmalloc was 
introduced
to save memory and cpu-speed.
All agp drivers expect to see a single memory chunk, so I'm not sure we 
want to have an array of pages. That may require rewriting a lot of code.

If it's acceptable I'd like to go for the vmalloc / kmalloc flag, or at 
worst keep the current vmalloc only but that's such a _huge_ memory 
waste for small buffers. The flag was the original idea, but 
unfortunately the agp_memory struct is part of the drm interface, and I 
wasn't sure we could add a variable to it.

DaveJ, is it possible to extend struct agp_memory with a flags field?

Regards,
Thomas

