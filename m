Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279811AbRKDXKT>; Sun, 4 Nov 2001 18:10:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279858AbRKDXKK>; Sun, 4 Nov 2001 18:10:10 -0500
Received: from lilly.ping.de ([62.72.90.2]:27402 "HELO lilly.ping.de")
	by vger.kernel.org with SMTP id <S279811AbRKDXJt>;
	Sun, 4 Nov 2001 18:09:49 -0500
Date: 5 Nov 2001 00:07:53 +0100
Message-ID: <20011105000753.A841@planetzork.spacenet>
From: jogi@planetzork.ping.de
To: "Stephan von Krawczynski" <skraw@ithnet.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux-2.4.14-pre8..
In-Reply-To: <20011104192725.A847@planetzork.spacenet> <Pine.LNX.4.33.0111041047230.6919-100000@penguin.transmeta.com> <20011104220641.A788@planetzork.spacenet> <20011104223535.717ce40e.skraw@ithnet.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="wRRV7LY7NUeQGEoC"
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <20011104223535.717ce40e.skraw@ithnet.com>; from skraw@ithnet.com on Sun, Nov 04, 2001 at 10:35:35PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--wRRV7LY7NUeQGEoC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Nov 04, 2001 at 10:35:35PM +0100, Stephan von Krawczynski wrote:
> On 4 Nov 2001 22:06:41 +0100 jogi@planetzork.ping.de wrote:
> 
> > On Sun, Nov 04, 2001 at 10:53:43AM -0800, Linus Torvalds wrote:
> > 
> > Hello,
> > 
> > with the complete patch (s.b.) the kernel did kill processes while running
> > make -j100. So I tried only the second part of the patch (the SetPage-part)
> > and here are the results (this time only the make -j100 part:
> > 
> > 2.4.14-pre8vmscan2:   6:12.06
> > 2.4.14-pre8vmscan2:   6:41.43
> > 2.4.14-pre8vmscan2:   6:53.22
> > 2.4.14-pre8vmscan2:   7:12.03
> > 2.4.14-pre8vmscan2:   5:49.82
> 
> Hello,

Hello Stephan,

> can you try attached patch together with pre6 or pre7? I don't know if it
> applies to pre8.
> And post the results in the mailinglist please.

I tried the patch you sent me and here are the results with -pre8+patch:

2.4.14-pre8vmscan3:   6:53.11
2.4.14-pre8vmscan3:   6:40.20
2.4.14-pre8vmscan3:   9:52.39
2.4.14-pre8vmscan3:   6:16.98
2.4.14-pre8vmscan3:   6:48.35

Regards,

   Jogi

PS: The patch Stephan sent me is attached.
PPS: The second chunk did not apply cleanly so I applied it by hand.

-- 

Well, yeah ... I suppose there's no point in getting greedy, is there?

    << Calvin & Hobbes >>

--wRRV7LY7NUeQGEoC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="vmscan.patch2"

--- linux-orig/mm/vmscan.c	Thu Nov  1 15:33:58 2001
+++ linux/mm/vmscan.c	Fri Nov  2 13:50:31 2001
@@ -290,7 +290,7 @@
 static int FASTCALL(swap_out(unsigned int priority, unsigned int gfp_mask, zone_t * classzone));
 static int swap_out(unsigned int priority, unsigned int gfp_mask, zone_t * classzone)
 {
-	int counter, nr_pages = SWAP_CLUSTER_MAX;
+	int counter, nr_pages = SWAP_CLUSTER_MAX * DEF_PRIORITY / priority;
 	struct mm_struct *mm;
 
 	counter = mmlist_nr;
@@ -334,7 +334,7 @@
 {
 	struct list_head * entry;
 	int max_scan = nr_inactive_pages / priority;
-	int max_mapped = nr_pages*10;
+	int max_mapped = SWAP_CLUSTER_MAX * DEF_PRIORITY / priority;
 
 	spin_lock(&pagemap_lru_lock);
 	while (--max_scan >= 0 && (entry = inactive_list.prev) != &inactive_list) {
@@ -469,16 +469,10 @@
 			spin_unlock(&pagecache_lock);
 			UnlockPage(page);
 page_mapped:
-			if (--max_mapped >= 0)
-				continue;
+			if (max_mapped > 0)
+				max_mapped--;
+			continue;
 
-			/*
-			 * Alert! We've found too many mapped pages on the
-			 * inactive list, so we start swapping out now!
-			 */
-			spin_unlock(&pagemap_lru_lock);
-			swap_out(priority, gfp_mask, classzone);
-			return nr_pages;
 		}
 
 		/*
@@ -514,6 +508,14 @@
 		break;
 	}
 	spin_unlock(&pagemap_lru_lock);
+
+	/*
+	 * Alert! We've found too many mapped pages on the
+	 * inactive list, so we start swapping out - delayed!
+	 * -skraw
+	 */
+	if (max_mapped==0 && nr_pages>0)
+		swap_out(priority, gfp_mask, classzone);
 
 	return nr_pages;
 }

--wRRV7LY7NUeQGEoC--
