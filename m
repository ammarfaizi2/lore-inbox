Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267098AbTA0DJj>; Sun, 26 Jan 2003 22:09:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267099AbTA0DJj>; Sun, 26 Jan 2003 22:09:39 -0500
Received: from packet.digeo.com ([12.110.80.53]:29593 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S267098AbTA0DJi>;
	Sun, 26 Jan 2003 22:09:38 -0500
Date: Sun, 26 Jan 2003 19:18:48 -0800
From: Andrew Morton <akpm@digeo.com>
To: Andries.Brouwer@cwi.nl
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH?] slab.c
Message-Id: <20030126191848.0dbbdb54.akpm@digeo.com>
In-Reply-To: <UTC200301262314.h0QNEWm00231.aeb@smtp.cwi.nl>
References: <UTC200301262314.h0QNEWm00231.aeb@smtp.cwi.nl>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 27 Jan 2003 03:18:48.0613 (UTC) FILETIME=[CEEAA550:01C2C5B2]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andries.Brouwer@cwi.nl wrote:
>
> In slab.c the routine check_poison_obj() is called.
> That routine does nothing except return 0 or 1.
> Thus it looks like the present call in slab_destroy()
> is meaningless. Perhaps something like this was meant?
> 

Sharp eyes.  It obviously got lost somewhere.

We've been moving away from generating informationless BUG()s in there,
toward emitting more info and trying to continue.  So I made this change:

diff -puN mm/slab.c~slab-poisoning-fix mm/slab.c
--- 25/mm/slab.c~slab-poisoning-fix	2003-01-26 19:10:54.000000000 -0800
+++ 25-akpm/mm/slab.c	2003-01-26 19:13:01.000000000 -0800
@@ -769,7 +769,7 @@ static void poison_obj(kmem_cache_t *cac
 	*(unsigned char *)(addr+size-1) = POISON_END;
 }
 
-static int check_poison_obj (kmem_cache_t *cachep, void *addr)
+static void check_poison_obj(kmem_cache_t *cachep, void *addr)
 {
 	int size = cachep->objsize;
 	void *end;
@@ -779,8 +779,7 @@ static int check_poison_obj (kmem_cache_
 	}
 	end = memchr(addr, POISON_END, size);
 	if (end != (addr+size-1))
-		return 1;
-	return 0;
+		slab_error(cachep, "object was modified after freeing");
 }
 #endif
 
@@ -1630,8 +1629,7 @@ cache_alloc_debugcheck_after(kmem_cache_
 	if (!objp)	
 		return objp;
 	if (cachep->flags & SLAB_POISON)
-		if (check_poison_obj(cachep, objp))
-			BUG();
+		check_poison_obj(cachep, objp);
 	if (cachep->flags & SLAB_RED_ZONE) {
 		/* Set alloc red-zone, and check old one. */
 		if (xchg((unsigned long *)objp, RED_ACTIVE) != RED_INACTIVE)


