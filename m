Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265196AbUEZB2j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265196AbUEZB2j (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 May 2004 21:28:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265260AbUEZB2j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 May 2004 21:28:39 -0400
Received: from av4-2-sn3.vrr.skanova.net ([81.228.9.112]:54992 "EHLO
	av4-2-sn3.vrr.skanova.net") by vger.kernel.org with ESMTP
	id S265196AbUEZB2f convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 May 2004 21:28:35 -0400
From: Roger Larsson <roger.larsson@norran.net>
To: linux-kernel@vger.kernel.org
Subject: (Found?) Re: Hard Hang with __alloc_pages: 0-order allocation failed (gfp=0x20/1) - Not out of memory
Date: Wed, 26 May 2004 03:22:58 +0200
User-Agent: KMail/1.6.52
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Message-Id: <200405260322.58571.roger.larsson@norran.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Since I read linux-kernel via achieves, this might be found already - but 
anyway... (CONFIG_SMP problem? Oh, noticed that this is 2.4.21...)

decode "(gfp=0x20/1)"  and you find that
	current->flags is PF_MEMALLOC 
	gfp is __GFP_HIGH (== GFP_ATOMIC)
and the backtrace says we are in_interrupt()

So I guess this is the key line...
	if (current->flags & PF_MEMALLOC && !in_interrupt()) {

* Less than (.min >> 2) of memory left.
* In interrupt
=> Not allowed to allocate anything more

Does the caller understand that repeating requests will not help?

In e1000_main.c
		skb = dev_alloc_skb(adapter->rx_buffer_len + reserve_len);

___skbuff.h___
static inline struct sk_buff *dev_alloc_skb(unsigned int length)
{
	return __dev_alloc_skb(length, GFP_ATOMIC);
}

static inline struct sk_buff *__dev_alloc_skb(unsigned int length,
					      int gfp_mask)
{
	struct sk_buff *skb;

	skb = alloc_skb(length+16, gfp_mask);
	if (skb)
		skb_reserve(skb,16);
	return skb;
}

And the rather big alloc_skb calls kmalloc

void * kmalloc (size_t size, int flags)
{
	cache_sizes_t *csizep = cache_sizes;

	for (; csizep->cs_size; csizep++) {
		if (size > csizep->cs_size)
			continue;
		return __kmem_cache_alloc(flags & GFP_DMA ?
			 csizep->cs_dmacachep : csizep->cs_cachep, flags);
	}
	return NULL;
}

- - - now take a close look at the try_again path - - -

static inline void * __kmem_cache_alloc (kmem_cache_t *cachep, int flags)
{
	unsigned long save_flags;
	void* objp;

	kmem_cache_alloc_head(cachep, flags);
try_again:
	local_irq_save(save_flags);

#ifdef CONFIG_SMP
	{
		cpucache_t *cc = cc_data(cachep);

		if (cc) {
			if (cc->avail) {
				STATS_INC_ALLOCHIT(cachep);
				objp = cc_entry(cc)[--cc->avail];
			} else {
				STATS_INC_ALLOCMISS(cachep);
				objp = kmem_cache_alloc_batch(cachep,cc,flags);
				if (!objp)
					goto alloc_new_slab_nolock;

- - -
alloc_new_slab_nolock:
#endif
	local_irq_restore(save_flags);
	if (kmem_cache_grow(cachep, flags))
		/* Someone may have stolen our objs.  Doesn't matter, we'll
		 * just come back here again.
		 */
		goto try_again;

But kmem_cache_grow will return failed...
	-> kmem_getpages ->  _get_free_pages -> alloc_pages

Or have I missed something?

/RogerL

-- 
Roger Larsson
Skellefteå
Sweden
