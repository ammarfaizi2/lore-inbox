Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750966AbWGMDtP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750966AbWGMDtP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 23:49:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750881AbWGMDtP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 23:49:15 -0400
Received: from smtp.osdl.org ([65.172.181.4]:8156 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750791AbWGMDtO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 23:49:14 -0400
Date: Wed, 12 Jul 2006 20:49:09 -0700
From: Andrew Morton <akpm@osdl.org>
To: Paul Drynoff <pauldrynoff@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [BUG] 2.6.18-rc1-mm1: the simple way to reproduce it
Message-Id: <20060712204909.9d27a3d8.akpm@osdl.org>
In-Reply-To: <20060712132701.6d504979.pauldrynoff@gmail.com>
References: <20060712095933.57d2a595.pauldrynoff@gmail.com>
	<20060712001232.a31285e3.akpm@osdl.org>
	<20060712132701.6d504979.pauldrynoff@gmail.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Jul 2006 13:27:01 +0400
Paul Drynoff <pauldrynoff@gmail.com> wrote:

> I found that bug can be simply reproducible.
> if take
> gcc-3.3.6 or gcc-4.1.1
> qemu - 0.8.1
> 
> $qemu-img create test.img 1M
> $cd linux-2.6.18-rc1-mm1
> $qemu -kernel arch/i386/boot/bzImage -hda test.img

That helps heaps, thanks.

Bisection shows that the crash (which seems to be a BUG) is due to
reduce-max_nr_zones-*.patch, and testing on the current -mm lineup
indicates that one of the two patches which Christoph sent
post-2.6.18-rc1-mm1 has fixed it.


From: Christoph Lameter <clameter@sgi.com>

We sometimes do comparisons like

xx & (__GFP_x| __GFP_y)) == GFP_y

This becomes a problem if GFP_y is redefined to be zero.

Both __GFP_HIGHMEM (caused by me) and __GFP_DMA32 (was this way before) can
become zero in order to cause a fall back to ZONE_NORMAL.

We also have a GFP_MASK that is applied before indexing into the nodelists
array.  We can use that mask to avoid having both become zero and instead
use the GFP_MASK to clear the respective bits before retrieving the
zonelist.

- Remove #ifdefs that cause __GFP_HIGHMEM or __GFP_DMA32 to become zero.

- GFP_MASK works nicely to cause fall back to ZONE_NORMAL except if
  CONFIG_ZONE_DMA32 and !CONFIG_HIGHMEM are set. In that case the
  fallback to ZONE_NORMAL does not work. So add a special case
  to mmzone.h to define a special mask that switches off the highmem
  bit for this particular configuration.

Signed-off-by: Christoph Lameter <clameter@sgi.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 include/linux/gfp.h    |    9 +--------
 include/linux/mmzone.h |   21 ++++++++++++++++++---
 2 files changed, 19 insertions(+), 11 deletions(-)

diff -puN include/linux/gfp.h~reduce-max_nr_zones-make-zone_highmem-optional-fix include/linux/gfp.h
--- a/include/linux/gfp.h~reduce-max_nr_zones-make-zone_highmem-optional-fix
+++ a/include/linux/gfp.h
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
diff -puN include/linux/mmzone.h~reduce-max_nr_zones-make-zone_highmem-optional-fix include/linux/mmzone.h
--- a/include/linux/mmzone.h~reduce-max_nr_zones-make-zone_highmem-optional-fix
+++ a/include/linux/mmzone.h
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
 
_



From: Christoph Lameter <clameter@sgi.com>

The __GFP_xx definitions in include/linux/gfp.h are used to refer to
individual bits in the GFP bitmasks.  I think they should not be
conditional via ifdef.  If a conditional definition is required then a
version without the underscore should be used.

My patch from yesterday cleared up the definitions that resulted in zero
values.  This one removes the #ifdef around __GFP_DMA32.

The x86_64 arch code is the only user of __GFP_DMA32 and x86_64 sets
CONFIG_ZONE_DMA32.  No driver is using DMA32.  So we do not really need
fall back behavior for ZONE_DMA32 at this point.

If ZONE_DMA32 would be used by a device driver in the future on a platform
that has not set CONFIG_ZONE_DMA32 then we will fall back to ZONE_NORMAL
because the __GFP_DMA32 bit is not set in GFP_ZONEMASK.  I think if
different behavior is desired then the device driver would have to take
care of falling back to a different allocation.  The absence of DMA32 slab
support may already force the device driver to deal with this case anyways.

Another solution would be to make the definition of GFP_DMA32 conditional
on CONFIG_ZONE_DMA32 and 32/64 bit.  That would leave the __GFP_xx
untouched.

Signed-off-by: Christoph Lameter <clameter@sgi.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 include/linux/gfp.h |   17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff -puN include/linux/gfp.h~reduce-max_nr_zones-make-zone_highmem-optional-fix-fix include/linux/gfp.h
--- a/include/linux/gfp.h~reduce-max_nr_zones-make-zone_highmem-optional-fix-fix
+++ a/include/linux/gfp.h
@@ -9,16 +9,19 @@ struct vm_area_struct;
 
 /*
  * GFP bitmasks..
+ *
+ * Zone modifiers (see linux/mmzone.h - low three bits)
+ *
+ * These may be masked by GFP_ZONEMASK to make allocations with this bit
+ * set fall back to ZONE_NORMAL.
+ *
+ * Do not put any conditional on these. If necessary modify the definitions
+ * without the underscores and use the consistently. The definitions here may
+ * be used in bit comparisons.
  */
-/* Zone modifiers in GFP_ZONEMASK (see linux/mmzone.h - low three bits) */
 #define __GFP_DMA	((__force gfp_t)0x01u)
 #define __GFP_HIGHMEM	((__force gfp_t)0x02u)
-
-#if !defined(CONFIG_ZONE_DMA32) && BITS_PER_LONG >= 64
-#define __GFP_DMA32	((__force gfp_t)0x01)	/* ZONE_DMA is ZONE_DMA32 */
-#else
-#define __GFP_DMA32	((__force gfp_t)0x04)	/* Has own ZONE_DMA32 */
-#endif
+#define __GFP_DMA32	((__force gfp_t)0x04u)
 
 /*
  * Action modifiers - doesn't change the zoning
_

