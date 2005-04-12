Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262156AbVDLUK2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262156AbVDLUK2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 16:10:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262642AbVDLUIT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 16:08:19 -0400
Received: from fire.osdl.org ([65.172.181.4]:32200 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262148AbVDLKbh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 06:31:37 -0400
Message-Id: <200504121030.j3CAUxA1005199@shell0.pdx.osdl.net>
Subject: [patch 022/198] Fix dst_destroy() race
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, herbert@gondor.apana.org.au,
       davem@davemloft.net
From: akpm@osdl.org
Date: Tue, 12 Apr 2005 03:30:53 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Herbert Xu <herbert@gondor.apana.org.au>

When we are not the real parent of the dst (e.g., when we're xfrm_dst and
the child is an rtentry), it may already be on the GC list.

In fact the current code is buggy to, we need to check dst->flags before
the dec as dst may no longer be valid afterwards.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/net/core/dst.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff -puN net/core/dst.c~fix-dst_destroy-race net/core/dst.c
--- 25/net/core/dst.c~fix-dst_destroy-race	2005-04-12 03:21:08.534839408 -0700
+++ 25-akpm/net/core/dst.c	2005-04-12 03:21:08.537838952 -0700
@@ -198,13 +198,15 @@ again:
 
 	dst = child;
 	if (dst) {
+		int nohash = dst->flags & DST_NOHASH;
+
 		if (atomic_dec_and_test(&dst->__refcnt)) {
 			/* We were real parent of this dst, so kill child. */
-			if (dst->flags&DST_NOHASH)
+			if (nohash)
 				goto again;
 		} else {
 			/* Child is still referenced, return it for freeing. */
-			if (dst->flags&DST_NOHASH)
+			if (nohash)
 				return dst;
 			/* Child is still in his hash table */
 		}
_
