Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268860AbSIRTdI>; Wed, 18 Sep 2002 15:33:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268915AbSIRTdI>; Wed, 18 Sep 2002 15:33:08 -0400
Received: from nuevo.divinia.com ([216.32.176.4]:15750 "HELO nuevo.divinia.com")
	by vger.kernel.org with SMTP id <S268860AbSIRTdG>;
	Wed, 18 Sep 2002 15:33:06 -0400
Date: Wed, 18 Sep 2002 12:32:15 -0700 (PDT)
From: Aaron Gowatch <aarong@divinia.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: disass kfree_s (was: Oops in 2.2.19)
Message-ID: <Pine.LNX.4.44.0209181217410.13536-100000@nuevo.divinia.com>
X-Favorite-Cola: Coke
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dean helped me track down the NULL pointer from the oops I posted 
yesterday.  It looks like someone ran across the same or similar issue in 
1999:

http://marc.theaimsgroup.com/?l=linux-kernel&m=94277765400609&w=2

I dont know much about kernel mm, but if someone who does or has seen this
before is willing to help me track this down, it'd be much appreciated.

Thanks in advance,
Aa.

---------- Forwarded message ----------
Date: Tue, 17 Sep 2002 20:35:25 -0700 (PDT)
From: dean gaudet <dean@arctic.org>
To: Aaron Gowatch <aarong@divinia.com>
Subject: Re: disass kfree_s

On Tue, 17 Sep 2002, Aaron Gowatch wrote:

> 0x8012353c <kfree_s+148>:	mov    0x8(%ecx),%ebp
> 0x8012353f <kfree_s+151>:	cmp    $0xa5c32f2b,%ebp
> 0x80123545 <kfree_s+157>:	jne    0x80123630 <kfree_s+392>

well that magic number up there is SLAB_MAGIC_ALLOC ... and the test here
is the check_magic label in __kfree_cache_free ... but i dunno why slabp
is NULL at that point.

you might want to play with the completely untested patch below... it
should at least stop the system from oopsing -- and it'll log a message
when the bug occurs.  then you can see what you're doing which triggers it
maybe.

-dean

--- slab.c.orig	Fri Nov  2 08:39:16 2001
+++ slab.c	Tue Sep 17 20:34:05 2002
@@ -1555,6 +1555,8 @@
 		slabp = bufp->buf_slabp;

 check_magic:
+	if (slabp == NULL)
+		goto bad_slab;
 	if (slabp->s_magic != SLAB_MAGIC_ALLOC)		/* Sanity check. */
 		goto bad_slab;

@@ -1636,7 +1638,9 @@

 bad_slab:
 	/* Slab doesn't contain the correct magic num. */
-	if (slabp->s_magic == SLAB_MAGIC_DESTROYED) {
+	if (slabp == NULL) {
+		kmem_report_free_err("null slabp", objp, cachep);
+	} else if (slabp->s_magic == SLAB_MAGIC_DESTROYED) {
 		/* Magic num says this is a destroyed slab. */
 		kmem_report_free_err("free from inactive slab", objp, cachep);
 	} else



