Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262705AbUBZGxk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Feb 2004 01:53:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262701AbUBZGxk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Feb 2004 01:53:40 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:64479 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262707AbUBZGxg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Feb 2004 01:53:36 -0500
Date: Thu, 26 Feb 2004 06:53:35 +0000
From: viro@parcelfarce.linux.theplanet.co.uk
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: akpm@osdl.org, torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] __cacheline_aligned always in own section
Message-ID: <20040226065335.GG31035@parcelfarce.linux.theplanet.co.uk>
References: <20040226064551.1E44B2C57E@lists.samba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040226064551.1E44B2C57E@lists.samba.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 26, 2004 at 05:44:47PM +1100, Rusty Russell wrote:
> Name: Always Put Cache Aligned Code in Own Section: Even Modules
> Status: Tested on 2.6.3-bk7
> 
> We put ____cacheline_aligned things in their own section, simply
> because we waste less space that way.  Otherwise we end up padding
> innocent variables to the next cacheline to get the required
> alignment.
> 
> There's no reason not to do this in modules, too.

[snip]

while we are at it, arm-26, ppc, sparc, sparc64 and sh have per-arch
definitions of __cacheline_aligned that are identical to default.
And yes, removal is safe - all users of __cacheline_aligned actually
pull linux/cache.h in.

diff -urN RC3-bk1/include/asm-arm26/cache.h RC3-bk1-current/include/asm-arm26/cache.h
--- RC3-bk1/include/asm-arm26/cache.h	Sun Jun 15 03:00:39 2003
+++ RC3-bk1-current/include/asm-arm26/cache.h	Thu Feb 26 01:37:23 2004
@@ -8,12 +8,4 @@
 #define        L1_CACHE_ALIGN(x)       (((x)+(L1_CACHE_BYTES-1))&~(L1_CACHE_BYTES-1))
 #define        SMP_CACHE_BYTES L1_CACHE_BYTES
 
-#ifdef MODULE
-#define __cacheline_aligned __attribute__((__aligned__(L1_CACHE_BYTES)))
-#else
-#define __cacheline_aligned					\
-  __attribute__((__aligned__(L1_CACHE_BYTES),			\
-		 __section__(".data.cacheline_aligned")))
-#endif
-
 #endif
diff -urN RC3-bk1/include/asm-ppc/cache.h RC3-bk1-current/include/asm-ppc/cache.h
--- RC3-bk1/include/asm-ppc/cache.h	Sat Sep 27 22:04:59 2003
+++ RC3-bk1-current/include/asm-ppc/cache.h	Thu Feb 26 01:39:41 2004
@@ -30,14 +30,6 @@
 #define	L1_CACHE_ALIGN(x)       (((x)+(L1_CACHE_BYTES-1))&~(L1_CACHE_BYTES-1))
 #define	L1_CACHE_PAGES		8
 
-#ifdef MODULE
-#define __cacheline_aligned __attribute__((__aligned__(L1_CACHE_BYTES)))
-#else
-#define __cacheline_aligned					\
-  __attribute__((__aligned__(L1_CACHE_BYTES),			\
-		 __section__(".data.cacheline_aligned")))
-#endif
-
 #ifndef __ASSEMBLY__
 extern void clean_dcache_range(unsigned long start, unsigned long stop);
 extern void flush_dcache_range(unsigned long start, unsigned long stop);
diff -urN RC3-bk1/include/asm-sh/cache.h RC3-bk1-current/include/asm-sh/cache.h
--- RC3-bk1/include/asm-sh/cache.h	Wed Feb  4 05:23:24 2004
+++ RC3-bk1-current/include/asm-sh/cache.h	Thu Feb 26 01:39:50 2004
@@ -21,14 +21,6 @@
 
 #define L1_CACHE_ALIGN(x)	(((x)+(L1_CACHE_BYTES-1))&~(L1_CACHE_BYTES-1))
 
-#ifdef MODULE
-#define __cacheline_aligned __attribute__((__aligned__(L1_CACHE_BYTES)))
-#else
-#define __cacheline_aligned					\
-  __attribute__((__aligned__(L1_CACHE_BYTES),			\
-		 __section__(".data.cacheline_aligned")))
-#endif
-
 #define L1_CACHE_SHIFT_MAX 	5	/* largest L1 which this arch supports */
 
 struct cache_info {
diff -urN RC3-bk1/include/asm-sparc/cache.h RC3-bk1-current/include/asm-sparc/cache.h
--- RC3-bk1/include/asm-sparc/cache.h	Mon Sep  2 09:14:46 2002
+++ RC3-bk1-current/include/asm-sparc/cache.h	Thu Feb 26 01:37:00 2004
@@ -17,14 +17,6 @@
 
 #define SMP_CACHE_BYTES 32
 
-#ifdef MODULE
-#define __cacheline_aligned __attribute__((__aligned__(SMP_CACHE_BYTES)))
-#else
-#define __cacheline_aligned					\
-  __attribute__((__aligned__(SMP_CACHE_BYTES),			\
-		 __section__(".data.cacheline_aligned")))
-#endif
-
 /* Direct access to the instruction cache is provided through and
  * alternate address space.  The IDC bit must be off in the ICCR on
  * HyperSparcs for these accesses to work.  The code below does not do
diff -urN RC3-bk1/include/asm-sparc64/cache.h RC3-bk1-current/include/asm-sparc64/cache.h
--- RC3-bk1/include/asm-sparc64/cache.h	Mon Sep  2 09:14:48 2002
+++ RC3-bk1-current/include/asm-sparc64/cache.h	Thu Feb 26 01:37:06 2004
@@ -14,12 +14,4 @@
 #define        SMP_CACHE_BYTES_SHIFT	6
 #define        SMP_CACHE_BYTES		(1 << SMP_CACHE_BYTES_SHIFT) /* L2 cache line size. */
 
-#ifdef MODULE
-#define __cacheline_aligned __attribute__((__aligned__(SMP_CACHE_BYTES)))
-#else
-#define __cacheline_aligned					\
-  __attribute__((__aligned__(SMP_CACHE_BYTES),			\
-		 __section__(".data.cacheline_aligned")))
-#endif
-
 #endif
