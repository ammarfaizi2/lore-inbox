Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264693AbUGFXNn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264693AbUGFXNn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jul 2004 19:13:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264697AbUGFXNn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jul 2004 19:13:43 -0400
Received: from fw.osdl.org ([65.172.181.6]:43184 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264693AbUGFXNh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jul 2004 19:13:37 -0400
Date: Tue, 6 Jul 2004 16:16:41 -0700
From: Andrew Morton <akpm@osdl.org>
To: jim.houston@comcast.net
Cc: kevcorry@us.ibm.com, linux-kernel@vger.kernel.org, dm-devel@redhat.com,
       torvalds@osdl.org, agk@redhat.com
Subject: Re: [PATCH] 1/1: Device-Mapper: Remove 1024 devices limitation
Message-Id: <20040706161641.01c1bbce.akpm@osdl.org>
In-Reply-To: <1089154845.985.164.camel@new.localdomain>
References: <200407011035.13283.kevcorry@us.ibm.com>
	<200407021233.09610.kevcorry@us.ibm.com>
	<20040702124218.0ad27a85.akpm@osdl.org>
	<200407061323.27066.kevcorry@us.ibm.com>
	<20040706142335.14efcfa4.akpm@osdl.org>
	<1089151650.985.129.camel@new.localdomain>
	<20040706152817.38ce1151.akpm@osdl.org>
	<1089154845.985.164.camel@new.localdomain>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jim Houston <jim.houston@comcast.net> wrote:
>
> With out the test above an id beyond the allocated space will alias
> to one that exists.  Perhaps the highest id currently allocated is 
> 100, there will be two layers in the radix tree and the while loop
> above will only look at the 10 least significant bits.  If you call
> idr_find with 1025 it will return the pointer associated with id 1.

OK.

> The patch I sent was against linux-2.6.7, so I missed the change to
> MAX_ID_SHIFT.

How about this?

diff -puN lib/idr.c~idr-stale-comment lib/idr.c
--- 25/lib/idr.c~idr-stale-comment	Tue Jul  6 16:12:45 2004
+++ 25-akpm/lib/idr.c	Tue Jul  6 16:15:41 2004
@@ -27,22 +27,6 @@
  * so you don't need to be too concerned about locking and conflicts
  * with the slab allocator.
 
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
-
  * So here are the complete details:
 
  *  include <linux/idr.h>
@@ -371,15 +355,11 @@ void *idr_find(struct idr *idp, int id)
 	struct idr_layer *p;
 
 	n = idp->layers * IDR_BITS;
+	if (id >= (1 << n))
+		return NULL;
+
 	p = idp->top;
-#if 0
-	/*
-	 * This tests to see if bits outside the current tree are
-	 * present.  If so, tain't one of ours!
-	 */
-	if ( unlikely( (id & ~(~0 << MAX_ID_SHIFT)) >> (n + IDR_BITS)))
-	     return NULL;
-#endif
+
 	/* Mask off upper bits we don't use for the search. */
 	id &= MAX_ID_MASK;
 
_

