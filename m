Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262159AbVDLT46@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262159AbVDLT46 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 15:56:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262108AbVDLTzL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 15:55:11 -0400
Received: from fire.osdl.org ([65.172.181.4]:45512 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262159AbVDLKbs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 06:31:48 -0400
Message-Id: <200504121031.j3CAVXtA005340@shell0.pdx.osdl.net>
Subject: [patch 054/198] ppc64: no prefetch for NULL pointers
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, olof@austin.ibm.com
From: akpm@osdl.org
Date: Tue, 12 Apr 2005 03:31:26 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Olof Johansson <olof@austin.ibm.com>

For prefetches of NULL (as when walking a short linked list), PPC64 will in
some cases take a performance hit.  The hardware needs to do the TLB walk,
and said walk will always miss, which means (up to) two L2 misses as
penalty.  This seems to hurt overall performance, so for NULL pointers skip
the prefetch alltogether.

Signed-off-by: Olof Johansson <olof@austin.ibm.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/include/asm-ppc64/processor.h |    6 ++++++
 1 files changed, 6 insertions(+)

diff -puN include/asm-ppc64/processor.h~ppc64-no-prefetch-for-null-pointers include/asm-ppc64/processor.h
--- 25/include/asm-ppc64/processor.h~ppc64-no-prefetch-for-null-pointers	2005-04-12 03:21:16.364649096 -0700
+++ 25-akpm/include/asm-ppc64/processor.h	2005-04-12 03:21:16.367648640 -0700
@@ -642,11 +642,17 @@ static inline unsigned long __pack_fe01(
 
 static inline void prefetch(const void *x)
 {
+	if (unlikely(!x))
+		return;
+
 	__asm__ __volatile__ ("dcbt 0,%0" : : "r" (x));
 }
 
 static inline void prefetchw(const void *x)
 {
+	if (unlikely(!x))
+		return;
+
 	__asm__ __volatile__ ("dcbtst 0,%0" : : "r" (x));
 }
 
_
