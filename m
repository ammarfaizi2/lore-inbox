Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274757AbRIZAos>; Tue, 25 Sep 2001 20:44:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274758AbRIZAoj>; Tue, 25 Sep 2001 20:44:39 -0400
Received: from atlrel7.hp.com ([192.151.27.9]:33805 "HELO atlrel7.hp.com")
	by vger.kernel.org with SMTP id <S274757AbRIZAoZ>;
	Tue, 25 Sep 2001 20:44:25 -0400
Message-ID: <C5C45572D968D411A1B500D0B74FF4A80418D54B@xfc01.fc.hp.com>
From: "DICKENS,CARY (HP-Loveland,ex2)" <cary_dickens2@hp.com>
To: "'Andrea Arcangeli'" <andrea@suse.de>,
        "DICKENS,CARY (HP-Loveland,ex2)" <cary_dickens2@hp.com>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        "HABBINGA,ERIK (HP-Loveland,ex1)" <erik_habbinga@hp.com>
Subject: RE: 2.4.10 still slow compared to 2.4.5pre1
Date: Tue, 25 Sep 2001 20:44:35 -0400
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Andrea Arcangeli [mailto:andrea@suse.de]
> Sent: Tuesday, September 25, 2001 3:57 PM
> To: DICKENS,CARY (HP-Loveland,ex2)
> Cc: 'linux-kernel@vger.kernel.org'; HABBINGA,ERIK (HP-Loveland,ex1)
> Subject: Re: 2.4.10 still slow compared to 2.4.5pre1
> 
> 
> On Tue, Sep 25, 2001 at 05:22:41PM -0400, DICKENS,CARY 
> (HP-Loveland,ex2) wrote:
> > We tried the 00_vmtweaks patch from Andrea and it failed to 
> boot.  There was
> > an issue starting kswapd and the kernel would oops.
> 
> You did something wrong then, please try it again.
> 
> Andrea
>
Andrea,

I hate to inform you that we tracked this down and nr_inactive_pages can be
zero.  This causes divide by zero in shrink_caches.

This is from the 00_vm-tweaks-1 patch:
 static int shrink_caches(int priority, zone_t * classzone, unsigned int
gfp_mask, int nr_pages)
 {
-	int max_scan = nr_inactive_pages / priority;
+	int max_scan;
+	int chunk_size = nr_pages;
+	unsigned long ratio;
 
 	nr_pages -= kmem_cache_reap(gfp_mask);
 	if (nr_pages <= 0)
 		return 0;
 
-	/* Do we want to age the active list? */
-	if (nr_inactive_pages < nr_active_pages*2)
-		refill_inactive(nr_pages);
+	spin_lock(&pagemap_lru_lock);
+	nr_pages = chunk_size;
+	/* try to keep the active list 2/3 of the size of the cache */
+	ratio = (unsigned long) nr_pages * nr_active_pages /
(nr_inactive_pages * 2);
	
^^^^^^^^^^^^^^^^^^^^^^
+	refill_inactive(ratio);
 
+	max_scan = nr_inactive_pages / priority;
 	nr_pages = shrink_cache(nr_pages, max_scan, classzone, gfp_mask);
 	if (nr_pages <= 0)
 		return 0; 

Hope this helps,
Cary
