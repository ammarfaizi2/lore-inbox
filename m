Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278289AbRJSDkN>; Thu, 18 Oct 2001 23:40:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278290AbRJSDkE>; Thu, 18 Oct 2001 23:40:04 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:63248 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S278289AbRJSDjy>;
	Thu, 18 Oct 2001 23:39:54 -0400
Date: Fri, 19 Oct 2001 01:40:06 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.surriel.com>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        "David S. Miller" <davem@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: [RFC][PATCH] __GFP_FAIL  (was: Re: [PATCH] fork() failing)
In-Reply-To: <Pine.LNX.4.21.0110181705150.12429-100000@freak.distro.conectiva>
Message-ID: <Pine.LNX.4.33L.0110190138110.3690-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Oct 2001, Marcelo Tosatti wrote:
> On Thu, 18 Oct 2001, Rik van Riel wrote:

> > We just need to make sure that the "wake up kswapd and maybe
> > help free memory" point is EXACTLY the same as the __GFP_FAIL
> > failure point.
>
> Ok, great, that works fine. We can do that for 2.4, no problem.

A quick (untested) patch to demonstrate my idea is below
my signature. Note the comments in __alloc_pages() ...
it's important to only fail our __GFP_FAIL allocation
_after_ having woken up kswapd.

regards,

Rik
-- 
DMCA, SSSCA, W3C?  Who cares?  http://thefreeworld.net/  (volunteers needed)

http://www.surriel.com/		http://distro.conectiva.com/



--- linux-2.4.12-ac3/mm/page_alloc.c.nofail	Thu Oct 18 23:24:50 2001
+++ linux-2.4.12-ac3/mm/page_alloc.c	Fri Oct 19 01:34:31 2001
@@ -341,18 +341,25 @@

 	/*
 	 * OK, none of the zones on our zonelist has lots
-	 * of pages free.
-	 *
-	 * We wake up kswapd, in the hope that kswapd will
-	 * resolve this situation before memory gets tight.
-	 *
-	 * We'll also help a bit trying to free pages, this
-	 * way statistics will make sure really fast allocators
-	 * are slowed down more than slow allocators and other
-	 * programs in the system shouldn't be impacted as much
-	 * by the hogs.
+	 * of pages free. Kswapd has work to do ...
 	 */
 	wakeup_kswapd();
+
+	/*
+	 * We don't want to do memory balancing work ourself,
+	 * instead we fail this allocation and hope that kswapd
+	 * will have things in a better shape next time.
+	 */
+	if (gfp_mask & __GFP_FAIL)
+		return NULL;
+
+	/*
+	 * Free some pages ourselves, rather than eating up the
+	 * last few free pages and running the system into the
+	 * ground.  Since this slows down heavy allocators more
+	 * than occasional allocators, it provides some fairness
+	 * and smoother behaviour under heavy load.
+	 */
 	if ((gfp_mask & __GFP_WAIT) && !(current->flags & PF_MEMALLOC))
 		try_to_free_pages(gfp_mask);

--- linux-2.4.12-ac3/include/linux/mm.h.nofail	Fri Oct 19 01:29:19 2001
+++ linux-2.4.12-ac3/include/linux/mm.h	Fri Oct 19 01:33:30 2001
@@ -567,12 +567,14 @@
 #define __GFP_HIGH	0x20	/* Should access emergency pools? */
 #define __GFP_IO	0x40	/* Can start physical IO? */
 #define __GFP_FS	0x80	/* Can call down to low-level FS? */
+#define __GFP_FAIL	0x100	/* Fail early when low on free pages. */

 #define GFP_NOIO	(__GFP_HIGH | __GFP_WAIT)
 #define GFP_NOFS	(__GFP_HIGH | __GFP_WAIT | __GFP_IO)
 #define GFP_ATOMIC	(__GFP_HIGH)
 #define GFP_USER	(             __GFP_WAIT | __GFP_IO | __GFP_FS)
 #define GFP_HIGHUSER	(             __GFP_WAIT | __GFP_IO | __GFP_FS | __GFP_HIGHMEM)
+#define GFP_READAHEAD	(             __GFP_WAIT | __GFP_IO | __GFP_FS | __GFP_HIGHMEM | __GFP_FAIL)
 #define GFP_KERNEL	(__GFP_HIGH | __GFP_WAIT | __GFP_IO | __GFP_FS)
 #define GFP_NFS		(__GFP_HIGH | __GFP_WAIT | __GFP_IO | __GFP_FS)
 #define GFP_KSWAPD	(                          __GFP_IO | __GFP_FS)

