Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265227AbUFMRRa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265227AbUFMRRa (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Jun 2004 13:17:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265232AbUFMRQH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Jun 2004 13:16:07 -0400
Received: from gate.crashing.org ([63.228.1.57]:12995 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S265227AbUFMRPe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Jun 2004 13:15:34 -0400
Subject: Re: [PATCH] Fix ppc64 out_be64
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Roland Dreier <roland@topspin.com>, Andrew Morton <akpm@osdl.org>
Cc: anton@au.ibm.com, linuxppc64-dev <linuxppc64-dev@lists.linuxppc.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <52llir5rr2.fsf@topspin.com>
References: <521xkk77xh.fsf@topspin.com> <1087141822.8210.176.camel@gaston>
	 <52llir5rr2.fsf@topspin.com>
Content-Type: text/plain
Message-Id: <1087146682.8697.184.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sun, 13 Jun 2004 12:11:23 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Yes, that looks fine (after fixing val to be unsigned long in
> out_be64).  You know infinitely more about ppc64 asm than I do so I'm
> sure your version is better.

Well, I may know ppc asm, but gcc inline asm still drives me nuts :)

Here's a fixed version (Andrew, please apply)

----

Patch fixes out_be64 implementation on ppc64 along with a glich in
out_be32 (inconsistent) use of barrier.

Signed-off-by: Roland Dreier <roland@topspin.com>
Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

===== include/asm-ppc64/io.h 1.18 vs edited =====
--- 1.18/include/asm-ppc64/io.h	2004-05-21 02:50:11 -05:00
+++ edited/include/asm-ppc64/io.h	2004-06-13 12:09:16 -05:00
@@ -307,7 +307,7 @@
 
 static inline void out_be32(volatile unsigned *addr, int val)
 {
-	__asm__ __volatile__("stw%U0%X0 %1,%0; eieio"
+	__asm__ __volatile__("stw%U0%X0 %1,%0; sync"
 			     : "=m" (*addr) : "r" (val));
 }
 
@@ -356,9 +356,9 @@
 			     : "=&r" (tmp) , "=&r" (val) : "1" (val) , "b" (addr) , "m" (*addr));
 }
 
-static inline void out_be64(volatile unsigned long *addr, int val)
+static inline void out_be64(volatile unsigned long *addr, unsigned long val)
 {
-	__asm__ __volatile__("std %1,0(%0); sync" : "=m" (*addr) : "r" (val));
+	__asm__ __volatile__("std%U0%X0 %1,%0; sync" : "=m" (*addr) : "r" (val));
 }
 
 #ifndef CONFIG_PPC_ISERIES 


