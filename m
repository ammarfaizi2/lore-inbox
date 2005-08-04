Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262637AbVHDS0a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262637AbVHDS0a (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Aug 2005 14:26:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262636AbVHDS0L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Aug 2005 14:26:11 -0400
Received: from gw2.cosmosbay.com ([195.115.130.129]:23984 "EHLO
	gw2.cosmosbay.com") by vger.kernel.org with ESMTP id S262646AbVHDSXu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Aug 2005 14:23:50 -0400
Message-ID: <42F25D33.7080607@cosmosbay.com>
Date: Thu, 04 Aug 2005 20:23:47 +0200
From: Eric Dumazet <dada1@cosmosbay.com>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [RFC] : SLAB : Could we have a process context only versions of 
 kmem_cache_alloc(), and kmem_cache_free()
References: <42EDDE50.6050800@winch-hebergement.net> <20050804033329.GA14501@gondor.apana.org.au> <20050804103523.GA11381@gondor.apana.org.au> <42F25352.8050805@winch-hebergement.net>
In-Reply-To: <42F25352.8050805@winch-hebergement.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.6 (gw2.cosmosbay.com [172.16.0.156]); Thu, 04 Aug 2005 20:23:48 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

The cost of local_irq_save(flags)/local_irq_restore(flags) in slab functions is very high
  popf, cli, pushf do stress the modern processors.

Maybe we could provide special functions for caches that are known to be used only from process context ?


These functions may use the local_irq_save(flags)/local_irq_restore(flags) only if needed (cache_alloc_refill() or cache_flusharray())

Something like :

void *kmem_cache_alloc_noirq(kmem_cache_t *cachep, unsigned int __nocast flags)
{
         unsigned long save_flags;
         void* objp;
         struct array_cache *ac;

         cache_alloc_debugcheck_before(cachep, flags);
	check_irq_on();
         preempt_disable();
         ac = ac_data(cachep);
         if (likely(ac->avail)) {
                 STATS_INC_ALLOCHIT(cachep);
                 ac->touched = 1;
                 objp = ac_entry(ac)[--ac->avail];
         } else {
                 STATS_INC_ALLOCMISS(cachep);
		local_irq_save(save_flags);
                 objp = cache_alloc_refill(cachep, flags);
		local_irq_restore(save_flags);
         }
         preempt_enable();
         objp = cache_alloc_debugcheck_after(cachep, flags, objp, __builtin_return_address(0));
	prefetchw(objp);
         return objp;
}


void kmem_cache_free_noirq(kmem_cache_t *cachep, void *objp)
{
         struct array_cache *ac;

	check_irq_on();
	preempt_disable();
	ac  = ac_data(cachep);

         objp = cache_free_debugcheck(cachep, objp, __builtin_return_address(0));

         if (likely(ac->avail < ac->limit)) {
                 STATS_INC_FREEHIT(cachep);
         } else {
		unsigned long flags;
                 STATS_INC_FREEMISS(cachep);
		local_irq_save(flags);
                 cache_flusharray(cachep, ac);
		local_irq_restore(flags);
         }
         ac_entry(ac)[ac->avail++] = objp;
	preempt_disable();
}

Thank you

Eric Dumazet

