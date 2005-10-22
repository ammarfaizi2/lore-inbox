Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932116AbVJVBsL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932116AbVJVBsL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Oct 2005 21:48:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932117AbVJVBsL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Oct 2005 21:48:11 -0400
Received: from mail27.syd.optusnet.com.au ([211.29.133.168]:49826 "EHLO
	mail27.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S932116AbVJVBsJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Oct 2005 21:48:09 -0400
From: Con Kolivas <kernel@kolivas.org>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm - swap prefetch magnify
Date: Sat, 22 Oct 2005 11:47:58 +1000
User-Agent: KMail/1.8.3
Cc: Andrew Morton <akpm@osdl.org>, ck list <ck@vds.kolivas.org>
References: <200510221120.44473.kernel@kolivas.org>
In-Reply-To: <200510221120.44473.kernel@kolivas.org>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_PpZWDYahsN/c6hv"
Message-Id: <200510221147.59059.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_PpZWDYahsN/c6hv
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Sat, 22 Oct 2005 11:20, Con Kolivas wrote:
> Testing has confirmed much larger prefetch values work well.

Bah.. Sorry take this one instead. Just make sure that no matter how little 
ram we have prefetch is enabled.

Con
---



--Boundary-00=_PpZWDYahsN/c6hv
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="mm-swap_prefetch_magnify-1.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="mm-swap_prefetch_magnify-1.patch"

The current number of pages prefetched by swap_prefetch is very gentle, and
we are very cautious about whether prefetching is appropriate or not so we
can increase the size substantially.

Make the prefetch size magnitudes larger, being proportional to memory size
instead of the square root of it.

Fix the last_free calculation to work better with larger prefetch sizes.

Signed-off-by: Con Kolivas <kernel@kolivas.org>

Index: linux-2.6.14-rc5-ck1/mm/swap_prefetch.c
===================================================================
--- linux-2.6.14-rc5-ck1.orig/mm/swap_prefetch.c	2005-10-22 10:14:26.000000000 +1000
+++ linux-2.6.14-rc5-ck1/mm/swap_prefetch.c	2005-10-22 10:36:30.000000000 +1000
@@ -24,7 +24,7 @@
 #define PREFETCH_INTERVAL (HZ)
 
 /* sysctl - how many SWAP_CLUSTER_MAX pages to prefetch at a time */
-int swap_prefetch = 1;
+int swap_prefetch;
 
 struct swapped_root {
 	unsigned long		busy;		/* vm busy */
@@ -71,9 +71,7 @@ void __init prepare_prefetch(void)
 	mapped_limit = mem / 3 * 2;
 
 	/* Set initial swap_prefetch value according to memory size */
-	mem /= SWAP_CLUSTER_MAX * 1000;
-	while ((mem >>= 1))
-		swap_prefetch++;
+	swap_prefetch = mem / 10000 ? : 1;
 }
 
 /*
@@ -307,10 +305,9 @@ static int prefetch_suitable(void)
 	 * (eg during file reads)
 	 */
 	if (last_free) {
-		if (temp_free + SWAP_CLUSTER_MAX + prefetch_pages() <
-			last_free) {
-				last_free = temp_free;
-				goto out;
+		if (temp_free + SWAP_CLUSTER_MAX < last_free) {
+			last_free = temp_free;
+			goto out;
 		}
 	} else
 		last_free = temp_free;
@@ -375,6 +372,7 @@ static enum trickle_return trickle_swap(
 		case TRICKLE_FAILED:
 			break;
 		case TRICKLE_SUCCESS:
+			last_free--;
 			pages++;
 			break;
 		case TRICKLE_DELAY:

--Boundary-00=_PpZWDYahsN/c6hv--
