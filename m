Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275178AbRKDS5D>; Sun, 4 Nov 2001 13:57:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273622AbRKDS4y>; Sun, 4 Nov 2001 13:56:54 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:518 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S273588AbRKDS4m>; Sun, 4 Nov 2001 13:56:42 -0500
Date: Sun, 4 Nov 2001 10:53:43 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: <jogi@planetzork.ping.de>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux-2.4.14-pre8..
In-Reply-To: <20011104192725.A847@planetzork.spacenet>
Message-ID: <Pine.LNX.4.33.0111041047230.6919-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 4 Nov 2001 jogi@planetzork.ping.de wrote:
>
> Is there anything else I can measure during the kernel compiles?
> Are the numbers for >= -pre6 slower because of measures taken to
> increase the "interactivity" / responsivness of the kernel?

No, it's something else, possibly some of the sharing braindamage.

> The part that looks most suspicious to me is that the results
> for make -j100 vary so much ...

Indeed. I don't like that part at all. That implies that some part of the
code is unstable. One thing that Andrea points out is that the current VM
scanning is rather unfair to active pages - if we get lots of active pages
(for whatever reason), that will defeat some of the page-out aging code.

Also, Andrea also suspects that when we de-activate a page in
refill_inactive, we should activate it again if somebody touches it, and
not make it go through the whole "activate on second reference" rigamole
again. What does this patch do to the pre8 behaviour?

(The first chunk just says that we _can_ unmap active pages: it's up to
refill_inactive to perhaps de-activate them and free them on demand. The
second chunk says that when refill_inactive() moves a page to the inactive
list, it's already been "touched once", so another access will activate it
again).

		Linus

----
diff -u --recursive pre8/linux/mm/vmscan.c linux/mm/vmscan.c
--- pre8/linux/mm/vmscan.c	Sun Nov  4 09:41:04 2001
+++ linux/mm/vmscan.c	Sun Nov  4 10:41:59 2001
@@ -54,9 +54,11 @@
 		return 0;
 	}

+#if 0
 	/* Don't bother unmapping pages that are active */
 	if (PageActive(page))
 		return 0;
+#endif

 	/* Don't bother replenishing zones not under pressure.. */
 	if (!memclass(page->zone, classzone))
@@ -541,6 +543,7 @@

 		del_page_from_active_list(page);
 		add_page_to_inactive_list(page);
+		SetPageReferenced(page);
 	}
 	spin_unlock(&pagemap_lru_lock);
 }

