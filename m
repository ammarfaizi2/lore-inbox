Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264933AbUFLWBE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264933AbUFLWBE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Jun 2004 18:01:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264934AbUFLWBE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Jun 2004 18:01:04 -0400
Received: from umhlanga.stratnet.net ([12.162.17.40]:54187 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S264933AbUFLWBA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Jun 2004 18:01:00 -0400
To: anton@au.ibm.com, linuxppc64-dev@lists.linuxppc.org,
       linux-kernel@vger.kernel.org
Subject: [PATCH] Fix ppc64 out_be64
X-Message-Flag: Warning: May contain useful information
From: Roland Dreier <roland@topspin.com>
Date: 12 Jun 2004 15:00:58 -0700
Message-ID: <521xkk77xh.fsf@topspin.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Common Lisp)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 12 Jun 2004 22:00:58.0916 (UTC) FILETIME=[BE460E40:01C450C8]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I notice that the latest BK has a fix for the bugs in ppc64's out_le64
that I just spent a few hours tracking down in 2.6.6, but out_be64 is
still broken.

This patch fixes two problems with out_be64:
 - The val parameter has to be unsigned long (not int), since it's 64 bits.
 - Since we're passing *addr into the asm as an output parameter, we
   should just use %0 instead of 0(%0) -- what's written won't even
   compile.

My ppc64 asm skills are nearly nonexistent but I'm pretty sure this
fix is needed and correct.

Thanks,
  Roland

Signed-off-by: Roland Dreier <roland@topspin.com>

===== include/asm-ppc64/io.h 1.18 vs edited =====
--- 1.18/include/asm-ppc64/io.h	2004-05-21 00:50:11 -07:00
+++ edited/include/asm-ppc64/io.h	2004-06-12 14:55:49 -07:00
@@ -356,9 +356,9 @@
 			     : "=&r" (tmp) , "=&r" (val) : "1" (val) , "b" (addr) , "m" (*addr));
 }
 
-static inline void out_be64(volatile unsigned long *addr, int val)
+static inline void out_be64(volatile unsigned long *addr, unsigned long val)
 {
-	__asm__ __volatile__("std %1,0(%0); sync" : "=m" (*addr) : "r" (val));
+	__asm__ __volatile__("std %1,%0; sync" : "=m" (*addr) : "r" (val));
 }
 
 #ifndef CONFIG_PPC_ISERIES 
