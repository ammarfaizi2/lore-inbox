Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266259AbSL1SQy>; Sat, 28 Dec 2002 13:16:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266278AbSL1SQy>; Sat, 28 Dec 2002 13:16:54 -0500
Received: from dbl.q-ag.de ([80.146.160.66]:17320 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id <S266259AbSL1SQx>;
	Sat, 28 Dec 2002 13:16:53 -0500
Message-ID: <3E0DEC83.2070900@colorfullife.com>
Date: Sat, 28 Dec 2002 19:25:07 +0100
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021202
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: James Bottomley <James.Bottomley@steeleye.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [RFT][PATCH] generic device DMA implementation
References: <200212281813.gBSIDNP02885@localhost.localdomain>
In-Reply-To: <200212281813.gBSIDNP02885@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Bottomley wrote:

>The problem really only occurs if the CPU can modify part of a cache line 
>while a device has modified memory belonging to another part.  Now a flush 
>from the CPU will destroy the device data (or an invalidate from the driver 
>destroy the CPU's data).  The problem is effectively rendered harmless if only 
>data going in the same direction shares a cache line (even if it is for 
>different devices).  It strikes me that this is probably true for network data 
>and would explain the fact that I haven't seen any obvious network related 
>corruption.
>  
>
Yes. Networking usually generates exclusive cachelines.
I'm aware of two special cases:
If multiple kmalloc buffers fit into one cacheline, then it can happen 
all the time. But the smallest kmalloc buffer is 64 bytes [assuming page 
size > 4096].
Is your cache line >= 128 bytes?

Or sendfile() of a mmap'ed file that is modified by userspace. That is 
the recommended approach for zerocopy tx, but I'm not sure which apps 
actually use that. IIRC DaveM mentioned the approach.

Additionally, the TCP checksum could catch the corruption and resent the 
packet - you wouldn't notice the corruptions, unless you use hw checksums.

--
    Manfred

