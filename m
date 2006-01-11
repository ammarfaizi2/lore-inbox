Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751703AbWAKReO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751703AbWAKReO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 12:34:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751702AbWAKReN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 12:34:13 -0500
Received: from cabal.ca ([134.117.69.58]:46247 "EHLO fattire.cabal.ca")
	by vger.kernel.org with ESMTP id S1751700AbWAKReN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 12:34:13 -0500
Date: Wed, 11 Jan 2006 12:33:21 -0500
From: Kyle McMartin <kyle@parisc-linux.org>
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Move read_mostly definition to asm/cache.h
Message-ID: <20060111173321.GC28018@quicksilver.road.mcmartin.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kyle McMartin <kyle@parisc-linux.org>

Seems like needless clutter having a bunch of #if
defined(CONFIG_$ARCH) in include/linux/cache.h. Move the per
architecture section definition to asm/cache.h, and keep the
if-not-defined dummy case in linux/cache.h to catch architectures
which don't implement the section.

Verified that symbols still go in .data.read_mostly on parisc,
and the compile doesn't break.

Signed-off-by: Kyle McMartin <kyle@parisc-linux.org>

---

I accidently committed this to an up-to-date master branch, as
I forgot to check out the temporary branch I was going to commit
it on. Swapping the sums from .git/refs/heads/{master,read_mostly}
wouldn't break anything, if the only different between the two was
this commit, right?

 include/asm-i386/cache.h    |    2 ++
 include/asm-ia64/cache.h    |    2 ++
 include/asm-parisc/cache.h  |    2 ++
 include/asm-sparc64/cache.h |    2 ++
 include/asm-x86_64/cache.h  |    2 ++
 include/linux/cache.h       |    4 +---
 6 files changed, 11 insertions(+), 3 deletions(-)

b7b3d524ba7fae865789ecc49b8ff660f5ef928b
diff --git a/include/asm-i386/cache.h b/include/asm-i386/cache.h
index 615911e..ca15c9c 100644
--- a/include/asm-i386/cache.h
+++ b/include/asm-i386/cache.h
@@ -10,4 +10,6 @@
 #define L1_CACHE_SHIFT	(CONFIG_X86_L1_CACHE_SHIFT)
 #define L1_CACHE_BYTES	(1 << L1_CACHE_SHIFT)
 
+#define __read_mostly __attribute__((__section__(".data.read_mostly")))
+
 #endif
diff --git a/include/asm-ia64/cache.h b/include/asm-ia64/cache.h
index 40dd251..f0a104d 100644
--- a/include/asm-ia64/cache.h
+++ b/include/asm-ia64/cache.h
@@ -25,4 +25,6 @@
 # define SMP_CACHE_BYTES	(1 << 3)
 #endif
 
+#define __read_mostly __attribute__((__section__(".data.read_mostly")))
+
 #endif /* _ASM_IA64_CACHE_H */
diff --git a/include/asm-parisc/cache.h b/include/asm-parisc/cache.h
index 93f179f..ae50f8e 100644
--- a/include/asm-parisc/cache.h
+++ b/include/asm-parisc/cache.h
@@ -29,6 +29,8 @@
 
 #define SMP_CACHE_BYTES L1_CACHE_BYTES
 
+#define __read_mostly __attribute__((__section__(".data.read_mostly")))
+
 extern void flush_data_cache_local(void *);  /* flushes local data-cache only */
 extern void flush_instruction_cache_local(void *); /* flushes local code-cache only */
 #ifdef CONFIG_SMP
diff --git a/include/asm-sparc64/cache.h b/include/asm-sparc64/cache.h
index f7d35a2..e9df17a 100644
--- a/include/asm-sparc64/cache.h
+++ b/include/asm-sparc64/cache.h
@@ -13,4 +13,6 @@
 #define        SMP_CACHE_BYTES_SHIFT	6
 #define        SMP_CACHE_BYTES		(1 << SMP_CACHE_BYTES_SHIFT) /* L2 cache line size. */
 
+#define __read_mostly __attribute__((__section__(".data.read_mostly")))
+
 #endif
diff --git a/include/asm-x86_64/cache.h b/include/asm-x86_64/cache.h
index b4a2401..f06f33a 100644
--- a/include/asm-x86_64/cache.h
+++ b/include/asm-x86_64/cache.h
@@ -10,4 +10,6 @@
 #define L1_CACHE_SHIFT	(CONFIG_X86_L1_CACHE_SHIFT)
 #define L1_CACHE_BYTES	(1 << L1_CACHE_SHIFT)
 
+#define __read_mostly __attribute__((__section__(".data.read_mostly")))
+
 #endif
diff --git a/include/linux/cache.h b/include/linux/cache.h
index d22e632..cc4b3aa 100644
--- a/include/linux/cache.h
+++ b/include/linux/cache.h
@@ -13,9 +13,7 @@
 #define SMP_CACHE_BYTES L1_CACHE_BYTES
 #endif
 
-#if defined(CONFIG_X86) || defined(CONFIG_SPARC64) || defined(CONFIG_IA64) || defined(CONFIG_PARISC)
-#define __read_mostly __attribute__((__section__(".data.read_mostly")))
-#else
+#ifndef __read_mostly
 #define __read_mostly
 #endif
 
-- 
1.0.GIT
