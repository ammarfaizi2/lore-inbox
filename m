Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262722AbSJOGg2>; Tue, 15 Oct 2002 02:36:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262730AbSJOGg1>; Tue, 15 Oct 2002 02:36:27 -0400
Received: from angband.namesys.com ([212.16.7.85]:5065 "HELO
	angband.namesys.com") by vger.kernel.org with SMTP
	id <S262722AbSJOGgU>; Tue, 15 Oct 2002 02:36:20 -0400
Date: Tue, 15 Oct 2002 10:42:10 +0400
From: Oleg Drokin <green@namesys.com>
To: Jeff Dike <jdike@karaya.com>
Cc: user-mode-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: uml-patch-2.5.42-1
Message-ID: <20021015104210.A1335@namesys.com>
References: <200210150058.TAA05520@ccure.karaya.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <200210150058.TAA05520@ccure.karaya.com>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Mon, Oct 14, 2002 at 07:58:28PM -0500, Jeff Dike wrote:
> UML has been updated to 2.5.42 and UML 2.4.19-12.  In non-numeric terms,

For some reason I now need this patch to make bk-current to compile
(with 2.5.42-1 patch from you applied, of course).
I do not claim this is correct fix, but at least it works for me ;)

===== drivers/char/random.c 1.24 vs edited =====
--- 1.24/drivers/char/random.c	Mon Oct  7 18:38:26 2002
+++ edited/drivers/char/random.c	Tue Oct 15 10:20:50 2002
@@ -738,7 +738,7 @@
 	__s32		delta, delta2, delta3;
 	int		entropy = 0;
 
-#if defined (__i386__) || defined (__x86_64__)
+#if (defined (__i386__) || defined (__x86_64__)) && !defined (__arch_um__)
 	if (cpu_has_tsc) {
 		__u32 high;
 		rdtsc(time, high);
===== drivers/char/mem.c 1.23 vs edited =====
--- 1.23/drivers/char/mem.c	Mon Aug  5 23:05:22 2002
+++ edited/drivers/char/mem.c	Tue Oct 15 10:18:31 2002
@@ -132,6 +132,7 @@
 {
 	unsigned long prot = pgprot_val(_prot);
 
+#if !defined(__arch_um__)
 #if defined(__i386__) || defined(__x86_64__)
 	/* On PPro and successors, PCD alone doesn't always mean 
 	    uncached because of interactions with the MTRRs. PCD | PWT
@@ -152,7 +153,7 @@
 	else if (MMU_IS_040 || MMU_IS_060)
 		prot = (prot & _CACHEMASK040) | _PAGE_NOCACHE_S;
 #endif
-
+#endif
 	return __pgprot(prot);
 }
 
@@ -164,7 +165,7 @@
  */
 static inline int noncached_address(unsigned long addr)
 {
-#if defined(__i386__)
+#if defined(__i386__) && !defined(__arch_um__)
 	/* 
 	 * On the PPro and successors, the MTRRs are used to set
 	 * memory types for physical addresses outside main memory, 
