Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423086AbWCUSfo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423086AbWCUSfo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 13:35:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423088AbWCUSfn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 13:35:43 -0500
Received: from dbl.q-ag.de ([213.172.117.3]:49580 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S1423086AbWCUSfl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 13:35:41 -0500
Message-ID: <44204754.8070401@colorfullife.com>
Date: Tue, 21 Mar 2006 19:35:00 +0100
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.7.12) Gecko/20060202 Fedora/1.7.12-1.5.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pekka J Enberg <penberg@cs.Helsinki.FI>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] slab: introduce kmem_cache_zalloc allocator
References: <Pine.LNX.4.58.0603201506140.19005@sbz-30.cs.Helsinki.FI> <20060321023654.389dc572.akpm@osdl.org> <Pine.LNX.4.58.0603211250530.22577@sbz-30.cs.Helsinki.FI>
In-Reply-To: <Pine.LNX.4.58.0603211250530.22577@sbz-30.cs.Helsinki.FI>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pekka J Enberg wrote:

>On Tue, 21 Mar 2006, Andrew Morton wrote:
>  
>
>>I've always felt that this was an odd design.  Because
>>
>>a) All that cache-warmth which we get from the constructor's zeroing can
>>   be lost by the time we get around to using an individual object and
>>
>>b) The object may be cache-cold by the time we free it, and we'll take
>>   cache misses just putting it back into a constructed state for
>>   kmem_cache_free().  And we'll lose that cache warmth by the time we use
>>   this object again.
>>
>>So from that POV I think (in my simple way) that this is a good patch.  But
>>IIRC, Manfred has reasons why it might not be?
>>    
>>
>
>I assume the design comes from Bonwick's paper which states that the 
>purpose of object constructor is to support one-time initialization of 
>objects which we're _not_ doing in this case.
>
>  
>
I agree - memset just before use is the Right Thing (tm).

One minor point: There are two cache_alloc entry points: __cache_alloc, 
which is a forced inline function, and kmem_cache_alloc, which is just a 
wrapper for __cache_alloc. Is it really necessary to call __cache_alloc?
The idea is that __cache_alloc is used just by the two high-performance 
paths: kmem_cache_alloc and kmalloc. Noone else should use __cache_alloc 
directly.

--
    Manfred
