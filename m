Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319161AbSH2JmZ>; Thu, 29 Aug 2002 05:42:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319156AbSH2JmZ>; Thu, 29 Aug 2002 05:42:25 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:35335 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S319161AbSH2JmW>;
	Thu, 29 Aug 2002 05:42:22 -0400
Message-ID: <3D6DF03A.127DD087@zip.com.au>
Date: Thu, 29 Aug 2002 02:58:18 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jordan Breeding <jordan.breeding@attbi.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Problems with 2.5.23-mm1
References: <3D6DCEC1.7020102@attbi.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jordan Breeding wrote:
> 
> Hello,
> 
>    I am trying to run 2.5.32-mm1.  The first problem that I have is that
> if SMP, Preempt and Highmem are all turned on I get lots of problems at
> boot including a BUG in highmem.c, I can get the line number later if
> someone wants it (later tomorrow night).  I then disabled highmem and
> got the system to boot.  I have a few weird problems, one is that every
> once in a while I see the message "bad: schedule() with irqs disabled!"
> and then there is a code trace.  I am attaching the decoded output of
> some of the traces.  Another problem I am having is that I get this
> message on bootup: "mtrr: SMP support incomplete for this vendor".  It
> seems that this would be a problem however the box works fine as far as
> I can tell.  Thanks for any light anyone can shed on any of this and
> please let me know whether anyone needs to know more about this box or
> about the highmem line number to figure and of these problems out.
> 

Well there are a couple of dopey bugs in swap.c which this patch fixes.

--- 2.5.32/mm/swap.c~preempt-fix	Thu Aug 29 02:00:44 2002
+++ 2.5.32-akpm/mm/swap.c	Thu Aug 29 02:06:21 2002
@@ -54,14 +54,14 @@ static struct pagevec lru_add_pvecs[NR_C
 void lru_cache_add(struct page *page)
 {
 	unsigned long flags;
-	struct pagevec *pvec;
+	struct pagevec *pvec = &lru_add_pvecs[get_cpu()];
 
 	local_irq_save(flags);
-	pvec = &lru_add_pvecs[smp_processor_id()];
 	page_cache_get(page);
 	if (!pagevec_add(pvec, page))
 		__pagevec_lru_add(pvec);
 	local_irq_restore(flags);
+	put_cpu();
 }
 
 void lru_add_drain(void)
@@ -210,6 +210,7 @@ void pagevec_deactivate_inactive(struct 
 void __pagevec_lru_add(struct pagevec *pvec)
 {
 	int i;
+	unsigned long flags = 0;
 	struct zone *zone = NULL;
 
 	for (i = 0; i < pagevec_count(pvec); i++) {
@@ -218,16 +219,16 @@ void __pagevec_lru_add(struct pagevec *p
 
 		if (pagezone != zone) {
 			if (zone)
-				spin_unlock_irq(&zone->lru_lock);
+				spin_unlock_irqrestore(&zone->lru_lock, flags);
 			zone = pagezone;
-			spin_lock_irq(&zone->lru_lock);
+			spin_lock_irqsave(&zone->lru_lock, flags);
 		}
 		if (TestSetPageLRU(page))
 			BUG();
 		add_page_to_inactive_list(zone, page);
 	}
 	if (zone)
-		spin_unlock_irq(&zone->lru_lock);
+		spin_unlock_irqrestore(&zone->lru_lock, flags);
 	pagevec_release(pvec);
 }
 

But the slab.c one is trickier.  The code is, basically:

	local_irq_save(flags);
	spin_lock(lock);
	...
	spin_unlock(lock);

and sure, if another CPU sets need_resched against this task and sends
a reschedule IPI then we can hit the spin_unlock() with need_resched
set, and this task will reschedule with interrupts off.

So there's a slab.c patch here which tries to fix that up too, but it's
really rather nasty, and it doesn't work, and I've had enough for the day.

There are other code paths in there which I missed, such the second
spin_unlock in __kmem_cache_alloc().   I think it would be cleaner
and saner to just use a local_irq_save_and_preempt_disable(flags)
throughout slab.

--- 2.5.32/mm/slab.c~preempt-fix	Thu Aug 29 02:32:53 2002
+++ 2.5.32-akpm/mm/slab.c	Thu Aug 29 02:51:03 2002
@@ -998,6 +998,7 @@ static void drain_cpu_caches(kmem_cache_
 		local_irq_disable();
 		free_block(cachep, cc_entry(ccold), ccold->avail);
 		local_irq_enable();
+		preempt_enable();
 		ccold->avail = 0;
 	}
 	smp_call_function_all_cpus(do_ccupdate_local, (void *)&new);
@@ -1610,11 +1611,14 @@ static inline void __free_block (kmem_ca
 		kmem_cache_free_one(cachep, *objpp);
 }
 
+/*
+ * Returns with preemption disabled - caller must perform preempt_enable().
+ */
 static void free_block (kmem_cache_t* cachep, void** objpp, int len)
 {
 	spin_lock(&cachep->spinlock);
 	__free_block(cachep, objpp, len);
-	spin_unlock(&cachep->spinlock);
+	_raw_spin_unlock(&cachep->spinlock);
 }
 #endif
 
@@ -1716,6 +1720,9 @@ void kmem_cache_free (kmem_cache_t *cach
 	local_irq_save(flags);
 	__kmem_cache_free(cachep, objp);
 	local_irq_restore(flags);
+#ifdef CONFIG_SMP
+	preempt_enable();
+#endif
 }
 
 /**
@@ -1737,6 +1744,9 @@ void kfree (const void *objp)
 	c = GET_PAGE_CACHE(virt_to_page(objp));
 	__kmem_cache_free(c, (void*)objp);
 	local_irq_restore(flags);
+#ifdef CONFIG_SMP
+	preempt_enable();
+#endif
 }
 
 unsigned int kmem_cache_size(kmem_cache_t *cachep)
@@ -1814,6 +1824,7 @@ static int kmem_tune_cpucache (kmem_cach
 		local_irq_disable();
 		free_block(cachep, cc_entry(ccold), ccold->avail);
 		local_irq_enable();
+		preempt_enable();
 		kfree(ccold);
 	}
 	return 0;

.
