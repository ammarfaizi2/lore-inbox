Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272718AbTHPKJ5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Aug 2003 06:09:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272729AbTHPKJ5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Aug 2003 06:09:57 -0400
Received: from dbl.q-ag.de ([80.146.160.66]:8153 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S272718AbTHPKJz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Aug 2003 06:09:55 -0400
Message-ID: <3F3E02EE.8080909@colorfullife.com>
Date: Sat, 16 Aug 2003 12:09:50 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030701
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
CC: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] slab debug vs. L1 alignement
References: <3F3D558D.5050803@colorfullife.com>	 <1060990883.581.87.camel@gaston>  <3F3D8D3B.3020708@colorfullife.com> <1061026667.881.100.camel@gaston>
In-Reply-To: <1061026667.881.100.camel@gaston>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin Herrenschmidt wrote:

>>>Yes, I understand that, but that is wrong for GFP_DMA imho. Also, 
>>>SLAB_MUST_HWCACHE_ALIGN just disables redzoning, which is not smart,
>>>I'd rather allocate more and keep both redzoning and cache alignement,
>>>that would help catch some of those subtle problems when a chip DMA
>>>engine plays funny tricks.
>>>
>>>      
>>>
>>I don't want to upgrade SLAB_HWCACHE_ALIGN to SLAB_MUST_HWCACHE_ALIGN 
>>depending on GFP_DMA: IIRC one arch (ppc64?) marks everything as 
>>GFP_DMA, because all memory is DMA capable.
>>    
>>
>
>Same for ppc32. Anyway, I don't like MUST_HWCACHE_ALIGN because it
>just disables redzoning, I'd rather allocate more and do both redzoning
>and cache alignement.
>  
>
I have a patch that creates helper functions that make that simple. The 
patch is stuck right now, because it exposes a bug in the i386 debug 
register handling. I'll add it redzoning with MUST_HWCACHE_ALIGN after 
that one is in.

>Anyway, I _still_ think it's stupid to return non-aligned buffers, both
>for performances, and because that prevents from dealing with such cases,
>typically the SCSI layer assumes alignement here among others...
>  
>
I don't care about performance with slab debugging on. kmalloc(4096,) 
usually takes ~40 cpu ticks on i386. With debugging on, it includes a 
memset and an open coded memcmp - my guess is a few thousand cpu ticks, 
and that's intentional. Do not enable it on production systems.

>Regarding O_DIRECT with an unaligned pointer, I haven't looked at this
>case yet, I suppose it will be broken in a whole lot of cases.
>  
>
Hmm. That means slab debugging did it's job: The driver contains the 
wrong assumption that all pointers are cache line aligned. Without slab 
debugging, this would result in rare data corruptions in O_DIRECT apps. 
With slab debugging on, it's exposed immediately.

--
    Manfred

