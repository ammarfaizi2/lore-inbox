Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751050AbWGZLQJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751050AbWGZLQJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jul 2006 07:16:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932241AbWGZLQJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jul 2006 07:16:09 -0400
Received: from courier.cs.helsinki.fi ([128.214.9.1]:31184 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP
	id S1751050AbWGZLQI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jul 2006 07:16:08 -0400
Date: Wed, 26 Jul 2006 14:16:06 +0300 (EEST)
From: Pekka J Enberg <penberg@cs.Helsinki.FI>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
cc: Christoph Lameter <clameter@sgi.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org,
       Martin Schwidefsky <schwidefsky@de.ibm.com>, manfred@colorfullife.com
Subject: Re: [patch 2/2] slab: always consider arch mandated alignment
In-Reply-To: <20060726105204.GF9592@osiris.boeblingen.de.ibm.com>
Message-ID: <Pine.LNX.4.58.0607261411420.17986@sbz-30.cs.Helsinki.FI>
References: <Pine.LNX.4.64.0607220748160.13737@schroedinger.engr.sgi.com>
 <20060722162607.GA10550@osiris.ibm.com> <Pine.LNX.4.64.0607221241130.14513@schroedinger.engr.sgi.com>
 <20060723073500.GA10556@osiris.ibm.com> <Pine.LNX.4.64.0607230558560.15651@schroedinger.engr.sgi.com>
 <20060723162427.GA10553@osiris.ibm.com> <20060726085113.GD9592@osiris.boeblingen.de.ibm.com>
 <Pine.LNX.4.58.0607261303270.17613@sbz-30.cs.Helsinki.FI>
 <20060726101340.GE9592@osiris.boeblingen.de.ibm.com>
 <Pine.LNX.4.58.0607261325070.17986@sbz-30.cs.Helsinki.FI>
 <20060726105204.GF9592@osiris.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Jul 2006, Heiko Carstens wrote:
> We only specify ARCH_KMALLOC_MINALIGN, since that aligns only the kmalloc
> caches, but it doesn't disable debugging on other caches that are created
> via kmem_cache_create() where an alignment of e.g. 0 is specified.
> 
> The point of the first patch is: why should the slab cache be allowed to chose
> an aligment that is less than what the caller specified? This does very likely
> break things.

Ah, yes, you are absolutely right. We need to respect caller mandated 
alignment too. How about this?

			Pekka

[PATCH] slab: respect architecture and caller mandated alignment

Ensure cache alignment is always at minimum what the architecture or 
caller mandates even if slab debugging is enabled.

Signed-off-by: Pekka Enberg <penberg@cs.helsinki.fi>
---

diff --git a/mm/slab.c b/mm/slab.c
index 0f20843..3767460 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -2097,6 +2097,15 @@ #endif
 	} else {
 		ralign = BYTES_PER_WORD;
 	}
+
+	/*
+	 * Redzoning and user store require word alignment. Note this will be
+	 * overridden by architecture or caller mandated alignment if either
+	 * is greater than BYTES_PER_WORD.
+	 */
+	if (flags & SLAB_RED_ZONE || flags & SLAB_STORE_USER)
+		ralign = BYTES_PER_WORD;
+
 	/* 2) arch mandated alignment: disables debug if necessary */
 	if (ralign < ARCH_SLAB_MINALIGN) {
 		ralign = ARCH_SLAB_MINALIGN;
@@ -2123,20 +2132,19 @@ #endif
 #if DEBUG
 	cachep->obj_size = size;
 
+	/*
+	 * Both debugging options require word-alignment which is calculated
+	 * into align above.
+	 */
 	if (flags & SLAB_RED_ZONE) {
-		/* redzoning only works with word aligned caches */
-		align = BYTES_PER_WORD;
-
 		/* add space for red zone words */
 		cachep->obj_offset += BYTES_PER_WORD;
 		size += 2 * BYTES_PER_WORD;
 	}
 	if (flags & SLAB_STORE_USER) {
-		/* user store requires word alignment and
-		 * one word storage behind the end of the real
-		 * object.
+		/* user store requires one word storage behind the end of
+		 * the real object.
 		 */
-		align = BYTES_PER_WORD;
 		size += BYTES_PER_WORD;
 	}
 #if FORCED_DEBUG && defined(CONFIG_DEBUG_PAGEALLOC)
