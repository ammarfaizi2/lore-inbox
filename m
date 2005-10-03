Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932310AbVJCQYB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932310AbVJCQYB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Oct 2005 12:24:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932353AbVJCQYA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Oct 2005 12:24:00 -0400
Received: from mgw-ext04.nokia.com ([131.228.20.96]:33180 "EHLO
	mgw-ext04.nokia.com") by vger.kernel.org with ESMTP id S932310AbVJCQX7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Oct 2005 12:23:59 -0400
Date: Mon, 3 Oct 2005 19:21:22 +0300
From: Paul Mundt <paul.mundt@nokia.com>
To: Arjan van de Ven <arjan@infradead.org>
Cc: mingo@elte.hu, linux-kernel@vger.kernel.org
Subject: Re: [RFC] mempool_alloc() pre-allocated object usage
Message-ID: <20051003162122.GB1844@nokia.com>
References: <20051003143634.GA1702@nokia.com> <1128350953.17024.17.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1128350953.17024.17.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.5.6i
X-OriginalArrivalTime: 03 Oct 2005 16:23:43.0771 (UTC) FILETIME=[D2A476B0:01C5C836]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 03, 2005 at 04:49:13PM +0200, Arjan van de Ven wrote:
> On Mon, 2005-10-03 at 17:36 +0300, Paul Mundt wrote:
> > Both usage patterns seem valid from my point of view, would you be open
> > to something that would accomodate both? (ie, possibly adding in a flag
> > to determine pre-allocated object usage?) Or should I not be using
> > mempool for contiguity purposes?
> 
> a similar dillema was in the highmem bounce code in 2.4; what worked
> really well back then was to do it both; eg use half the pool for
> "immediate" use, then try a VM alloc, and use the second half of the
> pool for the really emergency cases.
> 
Unfortunately this won't work very well in our case since it's
specifically high order allocations that we are after, and we don't have
the extra RAM to allow for this.

> Technically a mempool is there ONLY for the fallback, but I can see some
> value in making it also a fastpath by means of a small scratch pool

I haven't been able to think of any really good way to implement this, so
here's my current half-assed solution..

This adds a mempool_alloc_from_pool() to do the allocation directly from
the pool first if there are elements available, otherwise it defaults to
the mempool_alloc() behaviour (and no, I haven't commented it yet, since
it would be futile if no one likes this approach). It's at least fairly
minimalistic, and saves us from doing stupid things with the gfp_mask in
mempool_alloc().

--

 include/linux/mempool.h |    2 ++
 mm/mempool.c            |   16 ++++++++++++++++
 2 files changed, 18 insertions(+)

diff --git a/include/linux/mempool.h b/include/linux/mempool.h
--- a/include/linux/mempool.h
+++ b/include/linux/mempool.h
@@ -30,6 +30,8 @@ extern int mempool_resize(mempool_t *poo
 			unsigned int __nocast gfp_mask);
 extern void mempool_destroy(mempool_t *pool);
 extern void * mempool_alloc(mempool_t *pool, unsigned int __nocast gfp_mask);
+extern void * mempool_alloc_from_pool(mempool_t *pool,
+			unsigned int __nocast gfp_mask);
 extern void mempool_free(void *element, mempool_t *pool);
 
 /*
diff --git a/mm/mempool.c b/mm/mempool.c
--- a/mm/mempool.c
+++ b/mm/mempool.c
@@ -246,6 +246,22 @@ repeat_alloc:
 }
 EXPORT_SYMBOL(mempool_alloc);
 
+void *mempool_alloc_from_pool(mempool_t *pool, unsigned int __nocast gfp_mask)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&pool->lock, flags);
+	if (likely(pool->curr_nr)) {
+		void *element = remove_element(pool);
+		spin_unlock_irqrestore(&pool->lock, flags);
+		return element;
+	}
+	spin_unlock_irqrestore(&pool->lock, flags);
+
+	return mempool_alloc(pool, gfp_mask);
+}
+EXPORT_SYMBOL(mempool_alloc_from_pool);
+
 /**
  * mempool_free - return an element to the pool.
  * @element:   pool element pointer.
