Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265201AbSL0Wsv>; Fri, 27 Dec 2002 17:48:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265205AbSL0Wsv>; Fri, 27 Dec 2002 17:48:51 -0500
Received: from dbl.q-ag.de ([80.146.160.66]:40614 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id <S265201AbSL0Wst>;
	Fri, 27 Dec 2002 17:48:49 -0500
Message-ID: <3E0CDABE.7000907@colorfullife.com>
Date: Fri, 27 Dec 2002 23:57:02 +0100
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021202
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: James Bottomley <James.Bottomley@SteelEye.com>
CC: linux-kernel@vger.kernel.org
Subject: Re:  [RFT][PATCH] generic device DMA implementation
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>
>+
>+Consistent memory is memory for which a write by either the device or
>+the processor can immediately be read by the processor or device
>+without having to worry about caching effects.
>
This is not entirely correct:
The driver must use the normal memory barrier instructions even in 
coherent memory. Could you copy the section about wmb() from DMA-mapping 
into your new documentation?

+
+Warnings:  Memory coherency operates at a granularity called the cache
+line width.  In order for memory mapped by this API to operate
+correctly, the mapped region must begin exactly on a cache line
+boundary and end exactly on one (to prevent two separately mapped
+regions from sharing a single cache line).  Since the cache line size
+may not be known at compile time, the API will not enforce this
+requirement.  Therefore, it is recommended that driver writers who
+don't take special care to determine the cache line size at run time
+only map virtual regions that begin and end on page boundaries (which
+are guaranteed also to be cache line boundaries).
+

Noone obeys that rule, and it's not trivial to fix it.

- kmalloc (32,GFP_KERNEL) returns a 32-byte object, even if the cache line size is 128 bytes. The 4 objects in the cache line could be used by four different users.
- sendfile() with an odd offset.

Is it really impossible to work around that in the platform specific code?
In the worst case, the arch code could memcopy to/from a cacheline aligned buffer.


--
    Manfred

