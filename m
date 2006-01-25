Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751093AbWAYJyT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751093AbWAYJyT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 04:54:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751096AbWAYJyT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 04:54:19 -0500
Received: from gw1.cosmosbay.com ([62.23.185.226]:48030 "EHLO
	gw1.cosmosbay.com") by vger.kernel.org with ESMTP id S1751093AbWAYJyT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 04:54:19 -0500
Message-ID: <43D74AC0.9020002@cosmosbay.com>
Date: Wed, 25 Jan 2006 10:54:08 +0100
From: Eric Dumazet <dada1@cosmosbay.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Nick Piggin <npiggin@suse.de>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Memory Management List <linux-mm@kvack.org>
Subject: Re: [RFC] non-refcounted pages, application to slab?
References: <20060125093909.GE32653@wotan.suse.de>
In-Reply-To: <20060125093909.GE32653@wotan.suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.6 (gw1.cosmosbay.com [172.16.8.80]); Wed, 25 Jan 2006 10:54:07 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin a écrit :

> @@ -2604,10 +2604,10 @@ static inline void *__cache_alloc(kmem_c
>  
>  	local_irq_save(save_flags);
>  	objp = ____cache_alloc(cachep, flags);
> +	prefetchw(objp);
>  	local_irq_restore(save_flags);
>  	objp = cache_alloc_debugcheck_after(cachep, flags, objp,
>  					    __builtin_return_address(0));
> -	prefetchw(objp);
>  	return objp;
>  }

I'm not sure why you moved this prefetchw(obj) : This is not related to your 
'non-refcounting' part, is it ?

When I added this prefetchw in slab code, I did place it *after* the 
local_irq_restore(save_flags); because I was not sure if the 
serialization/barrier (popf) would force the cpu (x86/x86_64 in mind) to either :
- finish all the loads (even if they are speculative/hints) (so giving a bad 
latency)
- cancel the speculative loads (so prefetchw() *before* the 
local_irq_restore() would be useless.

Thank you
Eric
