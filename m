Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265894AbUFDRxO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265894AbUFDRxO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jun 2004 13:53:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265889AbUFDRxO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jun 2004 13:53:14 -0400
Received: from holomorphy.com ([207.189.100.168]:37543 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S265894AbUFDRxJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jun 2004 13:53:09 -0400
Date: Fri, 4 Jun 2004 10:52:55 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Paul Jackson <pj@sgi.com>
Cc: mikpe@csd.uu.se, nickpiggin@yahoo.com.au, rusty@rustcorp.com.au,
       linux-kernel@vger.kernel.org, akpm@osdl.org, ak@muc.de,
       ashok.raj@intel.com, hch@infradead.org, jbarnes@sgi.com,
       joe.korty@ccur.com, manfred@colorfullife.com, colpatch@us.ibm.com,
       Simon.Derr@bull.net
Subject: Re: [PATCH] cpumask 5/10 rewrite cpumask.h - single bitmap based implementation
Message-ID: <20040604175255.GD21007@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Paul Jackson <pj@sgi.com>, mikpe@csd.uu.se, nickpiggin@yahoo.com.au,
	rusty@rustcorp.com.au, linux-kernel@vger.kernel.org, akpm@osdl.org,
	ak@muc.de, ashok.raj@intel.com, hch@infradead.org, jbarnes@sgi.com,
	joe.korty@ccur.com, manfred@colorfullife.com, colpatch@us.ibm.com,
	Simon.Derr@bull.net
References: <20040603094339.03ddfd42.pj@sgi.com> <20040603101010.4b15734a.pj@sgi.com> <1086313667.29381.897.camel@bach> <40BFD839.7060101@yahoo.com.au> <20040603221854.25d80f5a.pj@sgi.com> <16576.16748.771295.988065@alkaid.it.uu.se> <20040604090314.56d64f4d.pj@sgi.com> <20040604165601.GC21007@holomorphy.com> <20040604102946.1d501953.pj@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040604102946.1d501953.pj@sgi.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 04, 2004 at 10:29:46AM -0700, Paul Jackson wrote:
> I'd vote to have the documented form that Andrew speaks of be arrays
> of 32-bit words, which is what I understood Mikael was doing.  I agree
> with Andrew's suggested to/from canonical functions.
> I'd prefer not copying arrays of unsigned longs, due to the confusions
> of coding to them across 32/64 bit and big/little endian architectures.
> At times I have wished the kernel had chosen u32 arrays instead of
> unsigned long arrays for bitmaps, for the same reason.  The cpumask
> sprintf and parse format is intentionally 32-bit chunk friendly.

Index: irqaction-2.6.7-rc2/include/linux/bitmap.h
===================================================================
--- irqaction-2.6.7-rc2.orig/include/linux/bitmap.h	2004-05-29 23:26:49.000000000 -0700
+++ irqaction-2.6.7-rc2/include/linux/bitmap.h	2004-06-04 10:35:31.982041000 -0700
@@ -46,6 +46,7 @@
 			const unsigned long *maskp, int bits);
 int bitmap_parse(const char __user *ubuf, unsigned int ubuflen,
 			unsigned long *maskp, int bits);
+void bitmap_to_u32_array(u32 *dst, unsigned long *src, int nlongs);
 
 #endif /* __ASSEMBLY__ */
 
Index: irqaction-2.6.7-rc2/lib/bitmap.c
===================================================================
--- irqaction-2.6.7-rc2.orig/lib/bitmap.c	2004-05-29 23:26:27.000000000 -0700
+++ irqaction-2.6.7-rc2/lib/bitmap.c	2004-06-04 10:51:46.878834000 -0700
@@ -330,3 +330,22 @@
 	return 0;
 }
 EXPORT_SYMBOL(bitmap_parse);
+
+#if defined(__BIG_ENDIAN) && BITS_PER_LONG == 64
+void bitmap_to_u32_array(u32 *dst, unsigned long *src, int nwords)
+{
+	int i;
+
+	for (i = 0; i < nwords; ++i) {
+		u64 word = src[i];
+		dst[2*i] = word >> 32;
+		dst[2*i+1] = word;
+	}
+}
+#else
+void bitmap_to_u32_array(u32 *dst, unsigned long *src, int nwords)
+{
+	memcpy(dst, src, nwords*sizeof(unsigned long));
+}
+#endif
+EXPORT_SYMBOL(bitmap_to_u32_array);
