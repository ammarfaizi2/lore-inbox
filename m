Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270798AbUJUSmy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270798AbUJUSmy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 14:42:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270800AbUJUSjQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 14:39:16 -0400
Received: from xums.xstreme.com ([67.98.62.4]:9889 "EHLO gamx.iccur.com")
	by vger.kernel.org with ESMTP id S270798AbUJUSgd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 14:36:33 -0400
Subject: [PATCH] Re: idr in Samba4
From: Jim Houston <jim.houston@ccur.com>
To: tridge@samba.org, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <16759.16648.459393.752417@samba.org>
References: <16759.16648.459393.752417@samba.org>
Content-Type: text/plain
Organization: Concurrent Computer Corp.
Message-Id: <1098383538.987.359.camel@new.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 21 Oct 2004 14:32:18 -0400
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 21 Oct 2004 18:36:30.0302 (UTC) FILETIME=[E1B95FE0:01C4B79C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-10-21 at 00:54, tridge@samba.org wrote:

> Apart from converting idr to use our pool allocator, and some other
> minor user-space tweaks, the only significant change I've made is to
> add a idr_find() call at the top of idr_remove() to catch possible
> errors where idr_remove() is called multiple times. Obviously this is
> programmer error if it happens, but I didn't like the default
> behaviour (I saw corruption in the tree without this check).


Hi Tridge, Andrew,

Tridge, thanks for your note.  I'm glad to hear you are using idr.c.

I agree with your concerns about idr_remove().  It really should
fail gracefully and warn if the id being removed is not valid.

The attached patch against linux-2.6.9 should do the job without
additional overhead.  Andrew, I hope you will add this patch to
your tree.

With the existing code, removing an id which was not allocated
could remove a valid id which shares the same lowest layer of the 
radix tree.

I ran a kernel with this patch but have not done any tests to force
a failure.

Jim Houston - Concurrent Computer Corp.


--- linux-2.6.9/lib/idr.c.orig	2004-10-21 12:57:24.547106092 -0400
+++ linux-2.6.9/lib/idr.c	2004-10-21 13:09:28.984974796 -0400
@@ -277,24 +277,31 @@
 }
 EXPORT_SYMBOL(idr_get_new);
 
+static void idr_remove_warning(int id)
+{
+	printk("idr_remove called for id=%d which is not allocated.\n", id);
+	dump_stack();
+}
+
 static void sub_remove(struct idr *idp, int shift, int id)
 {
 	struct idr_layer *p = idp->top;
 	struct idr_layer **pa[MAX_LEVEL];
 	struct idr_layer ***paa = &pa[0];
+	int n;
 
 	*paa = NULL;
 	*++paa = &idp->top;
 
 	while ((shift > 0) && p) {
-		int n = (id >> shift) & IDR_MASK;
+		n = (id >> shift) & IDR_MASK;
 		__clear_bit(n, &p->bitmap);
 		*++paa = &p->ary[n];
 		p = p->ary[n];
 		shift -= IDR_BITS;
 	}
-	if (likely(p != NULL)){
-		int n = id & IDR_MASK;
+	n = id & IDR_MASK;
+	if (likely(p != NULL && test_bit(n, &p->bitmap))){
 		__clear_bit(n, &p->bitmap);
 		p->ary[n] = NULL;
 		while(*paa && ! --((**paa)->count)){
@@ -303,6 +310,8 @@
 		}
 		if ( ! *paa )
 			idp->layers = 0;
+	} else {
+		idr_remove_warning(id);
 	}
 }
 




