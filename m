Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422653AbWGJRie@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422653AbWGJRie (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 13:38:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422727AbWGJRid
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 13:38:33 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:36794 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1422653AbWGJRid (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 13:38:33 -0400
Date: Mon, 10 Jul 2006 10:38:26 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Andrew Morton <akpm@osdl.org>
cc: Cedric Le Goater <clg@fr.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.18-rc1-mm1 oops on x86_64
In-Reply-To: <Pine.LNX.4.64.0607100856540.4491@schroedinger.engr.sgi.com>
Message-ID: <Pine.LNX.4.64.0607101036060.5059@schroedinger.engr.sgi.com>
References: <20060709021106.9310d4d1.akpm@osdl.org> <44B12C74.9090104@fr.ibm.com>
 <20060709132135.6c786cfb.akpm@osdl.org> <Pine.LNX.4.64.0607100856540.4491@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Jul 2006, Christoph Lameter wrote:

> Hmm... Actually we could leave __GFP_HIGHMEM at it prior value since
> GFP_ZONEMASK masks it out anyways. Need to test this though. This may
> also make some of the __GFP_DMA32 ifdefs unnecessary.

Here is the patch that fixes __GFP_DMA32 and __GFP_HIGHMEM to always
be nonzero. However, after the #ifdef in my last patch there is no
remaining instance of this left. The cure here adds some complexity:




Avoid __GFP_xx becoming 0

We sometimes do comparisons like

xx & (__GFP_x| __GFP_y)) == GFP_y

This becomes a problem if GFP_y is redefined to be zero.

Both __GFP_HIGHMEM (caused by me) and __GFP_DMA32 (was this way before)
can become zero in order to cause a fall back to ZONE_NORMAL.

We also have a GFP_MASK that is applied before indexing into the
nodelists array. We can use that mask to avoid having both become zero
and instead use the GFP_MASK to clear the respective bits before
retrieving the zonelist.

- Remove #ifdefs that cause __GFP_HIGHMEM or __GFP_DMA32 to become zero.

- GFP_MASK works nicely to cause fall back to ZONE_NORMAL except if
  CONFIG_ZONE_DMA32 and !CONFIG_HIGHMEM are set. In that case the
  fallback to ZONE_NORMAL does not work. So add a special case
  to mmzone.h to define a special mask that switches off the highmem
  bit for this particular configuration.

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.18-rc1-mm1/include/linux/gfp.h
===================================================================
--- linux-2.6.18-rc1-mm1.orig/include/linux/gfp.h	2006-07-10 09:37:56.352426085 -0700
+++ linux-2.6.18-rc1-mm1/include/linux/gfp.h	2006-07-10 09:42:44.254485171 -0700
@@ -12,17 +12,10 @@ struct vm_area_struct;
  */
 /* Zone modifiers in GFP_ZONEMASK (see linux/mmzone.h - low three bits) */
 #define __GFP_DMA	((__force gfp_t)0x01u)
-
-#ifdef CONFIG_HIGHMEM
 #define __GFP_HIGHMEM	((__force gfp_t)0x02u)
-#else
-#define __GFP_HIGHMEM	((__force gfp_t)0x00)	/* NORMAL is HIGHMEM */
-#endif
 
-#ifndef CONFIG_ZONE_DMA32
+#if !defined(CONFIG_ZONE_DMA32) && BITS_PER_LONG >= 64
 #define __GFP_DMA32	((__force gfp_t)0x01)	/* ZONE_DMA is ZONE_DMA32 */
-#elif BITS_PER_LONG < 64
-#define __GFP_DMA32	((__force gfp_t)0x00)	/* ZONE_NORMAL is ZONE_DMA32 */
 #else
 #define __GFP_DMA32	((__force gfp_t)0x04)	/* Has own ZONE_DMA32 */
 #endif
Index: linux-2.6.18-rc1-mm1/include/linux/mmzone.h
===================================================================
--- linux-2.6.18-rc1-mm1.orig/include/linux/mmzone.h	2006-07-10 09:37:56.424687226 -0700
+++ linux-2.6.18-rc1-mm1/include/linux/mmzone.h	2006-07-10 09:49:18.442923919 -0700
@@ -162,18 +162,33 @@ enum zone_type {
  *
  * NOTE! Make sure this matches the zones in <linux/gfp.h>
  */
-#define GFP_ZONETYPES		((GFP_ZONEMASK + 1) / 2 + 1)    /* Loner */
 
 #ifdef CONFIG_ZONE_DMA32
+
+#ifdef CONFIG_HIGHMEM
+#define GFP_ZONETYPES		((GFP_ZONEMASK + 1) / 2 + 1)    /* Loner */
 #define GFP_ZONEMASK		0x07
-#define	ZONES_SHIFT		2	/* ceil(log2(MAX_NR_ZONES)) */
+#define ZONES_SHIFT		2	/* ceil(log2(MAX_NR_ZONES)) */
+#else
+#define GFP_ZONETYPES		((0x07 + 1) / 2 + 1)    /* Loner */
+/* Mask __GFP_HIGHMEM */
+#define GFP_ZONEMASK		0x05
+#define ZONES_SHIFT		2
+#endif
+
 #else
 #ifdef CONFIG_HIGHMEM
+
 #define GFP_ZONEMASK		0x03
-#define	ZONES_SHIFT		2
+#define ZONES_SHIFT		2
+#define GFP_ZONETYPES		3
+
 #else
+
 #define GFP_ZONEMASK		0x01
 #define ZONES_SHIFT		1
+#define GFP_ZONETYPES		2
+
 #endif
 #endif
 
