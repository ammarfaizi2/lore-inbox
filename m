Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263522AbTLOMoi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Dec 2003 07:44:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263544AbTLOMoi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Dec 2003 07:44:38 -0500
Received: from fmr01.intel.com ([192.55.52.18]:32945 "EHLO hermes.fm.intel.com")
	by vger.kernel.org with ESMTP id S263522AbTLOMof (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Dec 2003 07:44:35 -0500
Message-ID: <3FDDACA9.1050600@intel.com>
Date: Mon, 15 Dec 2003 14:44:25 +0200
From: Vladimir Kondratiev <vladimir.kondratiev@intel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031210
X-Accept-Language: en-us, en, ru
MIME-Version: 1.0
To: Gabriel Paubert <paubert@iram.es>
CC: linux-kernel@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>,
       Alan Cox <alan@redhat.com>, Marcelo Tosatti <marcelo@conectiva.com.br>,
       Martin Mares <mj@ucw.cz>, zaitcev@redhat.com, hch@infradead.org
Subject: Re: PCI Express support for 2.4 kernel
References: <3FDCC171.9070902@intel.com> <3FDCCC12.20808@pobox.com> <3FDD8691.80206@intel.com> <20031215103142.GA8735@iram.es>
In-Reply-To: <20031215103142.GA8735@iram.es>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gabriel Paubert wrote:

>>Sanity check do pretty good job here. If it is not PCI-E 
>>platform, this address in physical memory will not be connected to 
>>anything real. You will get 0xff's.
>>    
>>
>
>Or a machine check on some architectures which make you know that 
>they don't like a bus cycle which terminates on a master abort.
>  
>
Could you elaborate a bit? This code is for pci-pc.c, it is platform 
specific.
Are there surprises on pc platform? What is visible behavour in this case?

>The major problem I see is that using up 256 Mb of kernel virtual address 
>space for accessing PCI config space is gross. Besides that it won't
>work for 32 bit machines with 768 Mb of RAM or more.
>
>I believe that it would be better to use kmap/kunmap like tricks, especially 
>for something which is relatively infrequent. You could even reserve
>a fixmap entry for this and keep somewhere a pointer to the PTE, which 
>would be modified on every config space access (config space access was
>already properly serialized last time I looked, I believe that all you need 
>is a TLB flush after the PTE is updated).
>
>I have no strong opinion on how to handle 64 bit archs.
>  
>
I should be missing something here. You have 256M of physical address 
space at 0xe0000000 occupied.
You can do nothing with it, it is simply present. Then, ioremap maps it 
somewhere in high memory.
It should not conflict with kernel RAM, for which trivial mapping (+3G) 
used.

>  
>
>>>Further, PCI posting:  a writeb() / writew() / writel() will not be 
>>>flushed immediately to the processor.  The CPU and/or PCI bridge may 
>>>post (delay/combine) such writes.  I do not think this is a desireable 
>>>effect, for PCI config register accesses.
>>>
>>>      
>>>
>>Good point. Fixed.
>>    
>>
>
>Here I'm somehwat lost. Writes to uncacheable RAM will be in program 
>order and never combined. The bridge itself should not post writes to 
>config space. So it's a matter of pushing the write to the processor
>bus, a PCI read looks very heavy for this. Isn't there a more
>lightweight solution ?
>  
>
I am not expert here. I know that PCI-E bridge completes its transaction 
before data actually get to memory. Each intermediate bridge may do its 
own buffering. Besides read, I know nothing that will make you sure data 
reaches final destination. I'd appreciate if someone who knows better 
will step in. Config write is not very often procedure, I don't think 
extra read will make  any difference. I'll look for qualified person 
around, to consult on this issue.

Vladimir.

