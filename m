Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266243AbSL1Rqh>; Sat, 28 Dec 2002 12:46:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266246AbSL1Rqh>; Sat, 28 Dec 2002 12:46:37 -0500
Received: from dbl.q-ag.de ([80.146.160.66]:9128 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id <S266243AbSL1Rqg>;
	Sat, 28 Dec 2002 12:46:36 -0500
Message-ID: <3E0DE569.9070108@colorfullife.com>
Date: Sat, 28 Dec 2002 18:54:49 +0100
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021202
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: James Bottomley <James.Bottomley@steeleye.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [RFT][PATCH] generic device DMA implementation
References: <200212281626.gBSGQPT02456@localhost.localdomain>
In-Reply-To: <200212281626.gBSGQPT02456@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Bottomley wrote:

>manfred@colorfullife.com said:
>  
>
>>Your new documentation disagrees with the current implementation, and
>>that is just wrong.
>>    
>>
>
>I don't agree that protecting users from cache line overlap misuse is current 
>implementation.  It's certainly not on parisc which was the non-coherent 
>platform I chose to model this with, which platforms do it now for the pci_ 
>API?
>  
>
You are aware that "users" is not one or two drivers that noone uses, 
it's the whole networking stack.
What do you propose to fix sendfile() and networking with small network 
packets [e.g. two 64 byte packets within a 128 byte cache line]?

One platforms that handles it is Miles Bader's memcopy based 
dma_map_single() implementation.
http://marc.theaimsgroup.com/?l=linux-kernel&m=103907087825616&w=2

And obviously i386, i.e. all archs with empty dma_map_single() functions.

I see three options:
- modify the networking core, and enforce that a cache line is never 
shared between users for such archs. Big change. Often not necessary - 
some nics must double buffer internally anyway.
- modify every driver that doesn't do double buffering, and enable 
double buffering on the affected archs. Even larger change.
- do the double buffering in dma_map_single() & co.

One problem for double buffering in dma_map_single() is that it would 
double buffer too often: for example, the start of the rx buffers is 
usually misaligned by the driver, to ensure that the IP headers are 
aligned. The rest of the cacheline is unused, but it's not possible to 
give that information to dma_map_single().

--
    Manfred


