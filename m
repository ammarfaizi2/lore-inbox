Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264609AbUGFWJB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264609AbUGFWJB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jul 2004 18:09:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264635AbUGFWJB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jul 2004 18:09:01 -0400
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:968 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S264609AbUGFWIy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jul 2004 18:08:54 -0400
Subject: Re: [PATCH] 1/1: Device-Mapper: Remove 1024 devices limitation
From: Jim Houston <jim.houston@comcast.net>
Reply-To: jim.houston@comcast.net
To: Andrew Morton <akpm@osdl.org>
Cc: Kevin Corry <kevcorry@us.ibm.com>, linux-kernel@vger.kernel.org,
       dm-devel@redhat.com, torvalds@osdl.org, agk@redhat.com
In-Reply-To: <20040706142335.14efcfa4.akpm@osdl.org>
References: <200407011035.13283.kevcorry@us.ibm.com>
	 <200407021233.09610.kevcorry@us.ibm.com>
	 <20040702124218.0ad27a85.akpm@osdl.org>
	 <200407061323.27066.kevcorry@us.ibm.com>
	 <20040706142335.14efcfa4.akpm@osdl.org>
Content-Type: multipart/mixed; boundary="=-P1N/EDciJH4IaY4IMRZw"
Organization: 
Message-Id: <1089151650.985.129.camel@new.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 06 Jul 2004 18:07:30 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-P1N/EDciJH4IaY4IMRZw
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, 2004-07-06 at 17:23, Andrew Morton wrote:
> Kevin Corry <kevcorry@us.ibm.com> wrote:
> >
> > After talking with Alasdair a bit, there might be one bug in the "dm-use-idr"
> > patch I submitted before. It seems (based on some comments in lib/idr.c) that
> > the idr_find() routine might not return NULL if the desired ID value is not
> > in the tree.
> 
> 
> Confused.  idr_find() returns the thing it found, or NULL.  To which
> comments do you refer?

Hi Andrew, Kevin,

Kevin is correct.  It's more of the nonsense related to having a counter
in the upper bits of the id.  If you call idr_find with an id that is
beyond the currently allocated space it ignores the upper bits and
returns one of the entries that is in the allocated space.  This
aliasing is most annoying.

I'm attaching an untested patch which removes the counter in the upper
bits of the id and makes idr_find return NULL if the requested id is
beyond the allocated space.  I suspect that there are problems with
id values which are less than zero.

Jim Houston - Concurrent Computer Corp.






--=-P1N/EDciJH4IaY4IMRZw
Content-Disposition: attachment; filename=idr_remove_counter.patch
Content-Type: text/plain; name=idr_remove_counter.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

--- lib/idr.c.orig	2004-07-06 15:19:34.301383300 -0400
+++ lib/idr.c	2004-07-06 17:41:55.749885756 -0400
@@ -28,29 +28,7 @@
  * with the slab allocator.
 
  * A word on reuse.  We reuse empty id slots as soon as we can, always
- * using the lowest one available.  But we also merge a counter in the
- * high bits of the id.  The counter is RESERVED_ID_BITS (8 at this time)
- * long.  This means that if you allocate and release the same id in a 
- * loop we will reuse an id after about 256 times around the loop.  The
- * word about is used here as we will NOT return a valid id of -1 so if
- * you loop on the largest possible id (and that is 24 bits, wow!) we
- * will kick the counter to avoid -1.  (Paranoid?  You bet!)
- *
- * What you need to do is, since we don't keep the counter as part of
- * id / ptr pair, to keep a copy of it in the pointed to structure
- * (or else where) so that when you ask for a ptr you can varify that
- * the returned ptr is correct by comparing the id it contains with the one
- * you asked for.  In other words, we only did half the reuse protection.
- * Since the code depends on your code doing this check, we ignore high
- * order bits in the id, not just the count, but bits that would, if used,
- * index outside of the allocated ids.  In other words, if the largest id
- * currently allocated is 32 a look up will only look at the low 5 bits of
- * the id.  Since you will want to keep this id in the structure anyway
- * (if for no other reason than to be able to eliminate the id when the
- * structure is found in some other way) this seems reasonable.  If you
- * really think otherwise, the code to check these bits here, it is just
- * disabled with a #if 0.
-
+ * using the lowest one available.
 
  * So here are the complete details:
 
@@ -79,6 +57,12 @@
  *   unlock and go back to the idr_pre_get() call.  ptr is the pointer
  *   you want associated with the id.  In other words:
 
+ * int idr_get_new_above(struct idr *idp, void *ptr, int starting_id)
+
+ *   The same as above but you can specify a prefered id value.  If the
+ *   starting_id value is available it will be allocated.  If it is
+ *   already the next id greater than starting_id will be allocated.
+
  * void *idr_find(struct idr *idp, int id);
  
  *   returns the "ptr", given the id.  A NULL return indicates that the
@@ -181,8 +165,6 @@
 			sh = IDR_BITS*l;
 			id = ((id >> sh) ^ n ^ m) << sh;
 		}
-		if (id >= MAX_ID_BIT)
-			return -1;
 		if (l == 0)
 			break;
 		/*
@@ -266,12 +248,6 @@
 	v = sub_alloc(idp, ptr, &id);
 	if (v == -2)
 		goto build_up;
-	if ( likely(v >= 0 )) {
-		idp->count++;
-		v += (idp->count << MAX_ID_SHIFT);
-		if ( unlikely( v == -1 ))
-		     v += (1L << MAX_ID_SHIFT);
-	}
 	return(v);
 }
 EXPORT_SYMBOL(idr_get_new_above);
@@ -342,14 +318,8 @@
 
 	n = idp->layers * IDR_BITS;
 	p = idp->top;
-#if 0
-	/*
-	 * This tests to see if bits outside the current tree are
-	 * present.  If so, tain't one of ours!
-	 */
-	if ( unlikely( (id & ~(~0 << MAX_ID_SHIFT)) >> (n + IDR_BITS)))
-	     return NULL;
-#endif
+	if (id >= (1 << n))
+		return NULL;
 	while (n > 0 && p) {
 		n -= IDR_BITS;
 		p = p->ary[(id >> n) & IDR_MASK];
--- include/linux/idr.h.orig	2004-07-06 18:04:07.388445924 -0400
+++ include/linux/idr.h	2004-07-06 18:01:24.355230740 -0400
@@ -29,12 +29,8 @@
 /* Define the size of the id's */
 #define BITS_PER_INT (sizeof(int)*8)
 
-#define MAX_ID_SHIFT (BITS_PER_INT - RESERVED_ID_BITS)
-#define MAX_ID_BIT (1 << MAX_ID_SHIFT)
-#define MAX_ID_MASK (MAX_ID_BIT - 1)
-
 /* Leave the possibility of an incomplete final layer */
-#define MAX_LEVEL (MAX_ID_SHIFT + IDR_BITS - 1) / IDR_BITS
+#define MAX_LEVEL (BITS_PER_INT + IDR_BITS - 1) / IDR_BITS
 
 /* Number of id_layer structs to leave in free list */
 #define IDR_FREE_MAX MAX_LEVEL + MAX_LEVEL

--=-P1N/EDciJH4IaY4IMRZw--

