Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271641AbRIBQnb>; Sun, 2 Sep 2001 12:43:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271642AbRIBQnL>; Sun, 2 Sep 2001 12:43:11 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:27921 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S271641AbRIBQnF>; Sun, 2 Sep 2001 12:43:05 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Igor Mozetic <igor.mozetic@uni-mb.si>, linux-kernel@vger.kernel.org
Subject: Re: [2.4.9 SMP] alloc_pages failed
Date: Sun, 2 Sep 2001 18:50:16 +0200
X-Mailer: KMail [version 1.3.1]
In-Reply-To: <15250.12448.265829.457034@ravan.camtp.uni-mb.si>
In-Reply-To: <15250.12448.265829.457034@ravan.camtp.uni-mb.si>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20010902164323Z16375-32383+3004@humbolt.nl.linux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On September 2, 2001 03:14 pm, Igor Mozetic wrote:
> My box is dual Xeon 550, Intel C440GX+, 2GB RAM, AIC7XXX.
> Last night I got log full of the following:
> 
> Sep  2 04:00:46 jerolim kernel: __alloc_pages: 0-order allocation failed.
> Sep  2 04:00:47 jerolim last message repeated 208 times
> Sep  2 04:00:47 jerolim kernel: ed.

Could you please apply this patch so we can see which kind of allocation is
failing (patch -p0):

--- ../2.4.9.clean/mm/page_alloc.c	Thu Aug 16 12:43:02 2001
+++ ./mm/page_alloc.c	Wed Aug 29 23:47:39 2001
@@ -493,6 +493,9 @@
 		}
 
 		/* XXX: is pages_min/4 a good amount to reserve for this? */
+		if (z->free_pages < z->pages_min / 3 && (gfp_mask & __GFP_WAIT) &&
+				!(current->flags & PF_MEMALLOC))
+			continue;
 		if (z->free_pages < z->pages_min / 4 &&
 				!(current->flags & PF_MEMALLOC))
 			continue;


On the assumption it's an atomic allocation, chould you try this patch and 
see if it reduces the frequency:

--- 2.4.9.clean/mm/page_alloc.c	Thu Aug 16 12:43:02 2001
+++ 2.4.9/mm/page_alloc.c	Mon Aug 20 22:05:40 2001
@@ -502,7 +502,8 @@
 	}
 
 	/* No luck.. */
-	printk(KERN_ERR "__alloc_pages: %lu-order allocation failed.\n", order);
+	printk(KERN_ERR "__alloc_pages: %lu-order allocation failed 
(gfp=0x%x/%i).\n",
+		order, gfp_mask, !!(current->flags & PF_MEMALLOC));
 	return NULL;
 }
 

