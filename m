Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932261AbVHKE50@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932261AbVHKE50 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 00:57:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932262AbVHKE5Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 00:57:25 -0400
Received: from mailout1.vmware.com ([65.113.40.130]:47110 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP id S932261AbVHKE5Y
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 00:57:24 -0400
Date: Wed, 10 Aug 2005 21:57:20 -0700
From: zach@vmware.com
Message-Id: <200508110457.j7B4vKFb019603@zach-dev.vmware.com>
To: akpm@osdl.org, chrisl@vmware.com, chrisw@osdl.org, hpa@zytor.com,
       Keir.Fraser@cl.cam.ac.uk, linux-kernel@vger.kernel.org,
       m+Ian.Pratt@cl.cam.ac.uk, mbligh@mbligh.org, pratap@vmware.com,
       virtualization@lists.osdl.org, zach@vmware.com, zwane@arm.linux.org.uk
Subject: [PATCH 10/14] i386 / Move descriptor accessors into desc h
X-OriginalArrivalTime: 11 Aug 2005 04:57:36.0014 (UTC) FILETIME=[30DA82E0:01C59E31]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Move base / limit accessors into desc.h, where they properly belong.

Patch-base: 2.6.13-rc5-mm1
Patch-keys: i386 desc cleanup
Signed-off-by: Zachary Amsden <zach@vmware.com>
Index: linux-2.6.13/include/asm-i386/system.h
===================================================================
--- linux-2.6.13.orig/include/asm-i386/system.h	2005-08-09 20:17:26.000000000 -0700
+++ linux-2.6.13/include/asm-i386/system.h	2005-08-09 20:17:27.000000000 -0700
@@ -29,40 +29,6 @@
 		      "2" (prev), "d" (next));				\
 } while (0)
 
-#define _set_base(desc,base) do {					\
-	unsigned long __tmp;						\
-	typecheck(struct desc_struct *, desc);				\
-	asm volatile("movw %w5,%2\n\t"					\
-		     "rorl $16,%5\n\t"					\
-		     "movb %b5,%3\n\t"					\
-		     "movb %h5,%4"					\
-		     :"=m"(*(desc)),					\
-		      "=&q" (__tmp)					\
-		     :"m" (*((char *)(desc)+2)),			\
-		      "m" (*((char *)(desc)+4)),			\
-		      "m" (*((char *)(desc)+7)),			\
-		      "1" (base));					\
-} while(0)
-
-#define _set_limit(desc,limit) do {					\
-	unsigned long __tmp;						\
-	typecheck(struct desc_struct *, desc);				\
-	asm volatile("movw %w4,%2\n\t"					\
-		     "rorl $16,%4\n\t"					\
-		     "movb %3,%h4\n\t"					\
-		     "andb $0xf0,%h4\n\t"				\
-		     "orb %h4,%b4\n\t"					\
-		     "movb %b4,%3"					\
-		     :"=m"(*(desc)),					\
-		      "=&q" (__tmp)					\
-		     :"m" (*(desc)),					\
-		      "m" (*((char *)(desc)+6)),			\
-		      "1" (limit));					\
-} while(0)
-
-#define set_base(desc,base) _set_base((desc), (base))
-#define set_limit(desc,limit) _set_limit((desc), ((limit)-1)>>12)
-
 /*
  * Load a segment. Fall back on loading the zero
  * segment if something goes wrong..
Index: linux-2.6.13/include/asm-i386/desc.h
===================================================================
--- linux-2.6.13.orig/include/asm-i386/desc.h	2005-08-09 20:17:26.000000000 -0700
+++ linux-2.6.13/include/asm-i386/desc.h	2005-08-10 20:40:51.000000000 -0700
@@ -73,6 +73,40 @@
 		      : "1" (addr), "r"(desc), "ir"(limit), "i"(type)); \
 } while (0)
   
+#define _set_base(desc,base) do {					\
+	unsigned long __tmp;						\
+	typecheck(struct desc_struct *, desc);				\
+	asm volatile("movw %w5,%2\n\t"					\
+		     "rorl $16,%5\n\t"					\
+		     "movb %b5,%3\n\t"					\
+		     "movb %h5,%4"					\
+		     :"=m"(*(desc)),					\
+		      "=&q" (__tmp)					\
+		     :"m" (*((char *)(desc)+2)),			\
+		      "m" (*((char *)(desc)+4)),			\
+ 		      "m" (*((char *)(desc)+7)),			\
+		      "1" (base));					\
+} while(0)
+
+#define _set_limit(desc,limit) do {					\
+	unsigned long __tmp;						\
+	typecheck(struct desc_struct *, desc);				\
+	asm volatile("movw %w4,%2\n\t"					\
+		     "rorl $16,%4\n\t"					\
+		     "movb %3,%h4\n\t"					\
+		     "andb $0xf0,%h4\n\t"				\
+		     "orb %h4,%b4\n\t"					\
+		     "movb %b4,%3"					\
+		     :"=m"(*(desc)),					\
+		      "=&q" (__tmp)					\
+		     :"m" (*(desc)),					\
+		      "m" (*((char *)(desc)+6)),			\
+		      "1" (limit));					\
+} while(0)
+
+#define set_base(desc,base) _set_base((desc), (base))
+#define set_limit(desc,limit) _set_limit((desc), ((limit)-1)>>12)
+
 #include <mach_desc.h>
 
 #define set_tss_desc(cpu,addr) __set_tss_desc(cpu, GDT_ENTRY_TSS, addr)
