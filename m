Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264092AbRFFTAE>; Wed, 6 Jun 2001 15:00:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264098AbRFFS7o>; Wed, 6 Jun 2001 14:59:44 -0400
Received: from www.wen-online.de ([212.223.88.39]:25861 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S264097AbRFFS7k>;
	Wed, 6 Jun 2001 14:59:40 -0400
Date: Wed, 6 Jun 2001 20:59:15 +0200 (CEST)
From: Mike Galbraith <mikeg@wen-online.de>
X-X-Sender: <mikeg@mikeg.weiden.de>
To: Derek Glidden <dglidden@illusionary.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Break 2.4 VM in five easy steps
In-Reply-To: <3B1D5ADE.7FA50CD0@illusionary.com>
Message-ID: <Pine.LNX.4.33.0106062048130.366-100000@mikeg.weiden.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Jun 2001, Derek Glidden wrote:

> After reading the messages to this list for the last couple of weeks and
> playing around on my machine, I'm convinced that the VM system in 2.4 is
> still severely broken.

...

Hi,

Can you try the patch below to see if it helps?  If you watch
with vmstat, you should see swap shrinking after your test.
Let is shrink a while and then see how long swapoff takes.
Under a normal load, it'll munch a handfull of them at least
once a second and keep them from getting annoying. (theory;)

	-Mike


--- linux-2.4.5.ac5/mm/vmscan.c.org	Sat Jun  2 07:37:16 2001
+++ linux-2.4.5.ac5/mm/vmscan.c	Wed Jun  6 18:29:02 2001
@@ -1005,6 +1005,53 @@
 	return ret;
 }

+int deadswap_reclaim(unsigned int priority)
+{
+	struct list_head * page_lru;
+	struct page * page;
+	int maxscan = nr_active_pages >> priority;
+	int nr_reclaim = 0;
+
+	/* Take the lock while messing with the list... */
+	spin_lock(&pagemap_lru_lock);
+	while (maxscan-- > 0 && (page_lru = active_list.prev) != &active_list) {
+		page = list_entry(page_lru, struct page, lru);
+
+		/* Wrong page on list?! (list corruption, should not happen) */
+		if (!PageActive(page)) {
+			printk("VM: refill_inactive, wrong page on list.\n");
+			list_del(page_lru);
+			nr_active_pages--;
+			continue;
+		}
+
+		if (PageSwapCache(page) &&
+				(page_count(page) - !!page->buffers) == 1 &&
+				swap_count(page) == 1) {
+			if (page->buffers || TryLockPage(page)) {
+				ClearPageReferenced(page);
+				ClearPageDirty(page);
+				page->age = 0;
+				deactivate_page_nolock(page);
+			} else {
+				page_cache_get(page);
+				spin_unlock(&pagemap_lru_lock);
+				delete_from_swap_cache_nolock(page);
+				spin_lock(&pagemap_lru_lock);
+				UnlockPage(page);
+				page_cache_release(page);
+			}
+			nr_reclaim++;
+			continue;
+		}
+		list_del(page_lru);
+		list_add(page_lru, &active_list);
+	}
+	spin_unlock(&pagemap_lru_lock);
+
+	return nr_reclaim;
+}
+
 DECLARE_WAIT_QUEUE_HEAD(kreclaimd_wait);
 /*
  * Kreclaimd will move pages from the inactive_clean list to the
@@ -1027,7 +1074,7 @@
 		 * We sleep until someone wakes us up from
 		 * page_alloc.c::__alloc_pages().
 		 */
-		interruptible_sleep_on(&kreclaimd_wait);
+		interruptible_sleep_on_timeout(&kreclaimd_wait, HZ);

 		/*
 		 * Move some pages from the inactive_clean lists to
@@ -1051,6 +1098,7 @@
 			}
 			pgdat = pgdat->node_next;
 		} while (pgdat);
+		deadswap_reclaim(4);
 	}
 }


