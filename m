Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265784AbUEZUE1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265784AbUEZUE1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 May 2004 16:04:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265785AbUEZUE1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 May 2004 16:04:27 -0400
Received: from av3-2-sn4.m-sp.skanova.net ([81.228.10.113]:38099 "EHLO
	av3-2-sn4.m-sp.skanova.net") by vger.kernel.org with ESMTP
	id S265784AbUEZUEI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 May 2004 16:04:08 -0400
From: Roger Larsson <roger.larsson@norran.net>
To: linux-kernel@vger.kernel.org
Subject: Re: Hard Hang with __alloc_pages: 0-order allocation failed (gfp=0x20/1) - Not out of memory
Date: Wed, 26 May 2004 21:58:30 +0200
User-Agent: KMail/1.6.52
References: <200405260322.58571.roger.larsson@norran.net>
In-Reply-To: <200405260322.58571.roger.larsson@norran.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Message-Id: <200405262158.30747.roger.larsson@norran.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Modifying the header so you find it. And write a better summary...

* When you have little memory left __alloc_pages wont allow
   allocations from interrupt context (even if PF_MEMALLOC)

	if (current->flags & PF_MEMALLOC && !in_interrupt()) {

* But in the callchain there is a loop in __kmem_cache_alloc when running SMP

> static inline void * __kmem_cache_alloc (kmem_cache_t *cachep, int flags)
> {
> 	unsigned long save_flags;
> 	void* objp;
>
> 	kmem_cache_alloc_head(cachep, flags);
> try_again:
> 	local_irq_save(save_flags);
>
> #ifdef CONFIG_SMP
> 	{
> 		cpucache_t *cc = cc_data(cachep);
>
> 		if (cc) {
> 			if (cc->avail) {
> 				STATS_INC_ALLOCHIT(cachep);
> 				objp = cc_entry(cc)[--cc->avail];
> 			} else {
> 				STATS_INC_ALLOCMISS(cachep);
> 				objp = kmem_cache_alloc_batch(cachep,cc,flags);
> 				if (!objp)
> 					goto alloc_new_slab_nolock;
>
> - - - snip - - -
> alloc_new_slab_nolock:
> #endif
> 	local_irq_restore(save_flags);
> 	if (kmem_cache_grow(cachep, flags))
> 		/* Someone may have stolen our objs.  Doesn't matter, we'll
> 		 * just come back here again.
> 		 */
> 		goto try_again;
>
> But kmem_cache_grow will return failed...
> 	-> kmem_getpages ->  _get_free_pages -> alloc_pages

But alloc_pages WILL fail every time... => infinite loop in interrupt
context... It probably should not try again in this case...

	if (!in_interrupt())
		goto try_again;

Or it should check if GFP_WAIT is set... A _busy_ wait is also a wait...

/RogerL

-- 
Roger Larsson
Skellefteå
Sweden
