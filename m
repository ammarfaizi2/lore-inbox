Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263786AbRFCWQg>; Sun, 3 Jun 2001 18:16:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263773AbRFCV2t>; Sun, 3 Jun 2001 17:28:49 -0400
Received: from cheviot1.ncl.ac.uk ([128.240.233.15]:2716 "EHLO
	cheviot1.ncl.ac.uk") by vger.kernel.org with ESMTP
	id <S263760AbRFCVWg>; Sun, 3 Jun 2001 17:22:36 -0400
Date: Sun, 3 Jun 2001 22:22:33 +0100 (GMT)
From: James Slater <J.C.K.Slater@newcastle.ac.uk>
To: linux-kernel@vger.kernel.org
Subject: Cache size calculation on Athlon/Duron
Message-ID: <Pine.SOL.4.21.0106032218350.17006-100000@aidan.ncl.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Filter-Version: 2.1 (cheviot1.ncl.ac.uk)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Reading through arch/i386/kernel/setup.c in 2.4.5, I noticed that the code
which sets x86_cache_size sets it to the size of the chip's L2 cache if
present.

Which is fine for everything except the Athlon/Duron, which have exclusive
L1/L2 caches, so surely they should be added together in this case to give
the total cache size? Or am I just missing something stupid?

--- arch/i386/kernel/setup.c.orig	Sun Jun  3 21:49:45 2001
+++ arch/i386/kernel/setup.c	Sun Jun  3 22:16:58 2001
@@ -1098,7 +1098,15 @@
 	if ( l2size == 0 )
 		return;		/* Again, no L2 cache is possible */
 
-	c->x86_cache_size = l2size;
+	/*
+	 * Athlon/Duron have exclusive L1/L2 cache, so sum them,
+	 * for everyone else set cache size to be L2 only.
+	 */
+	if (c->x86_vendor == X86_VENDOR_AMD && c->x86 == 6) {
+		c->x86_cache_size += l2size;
+	} else {
+		c->x86_cache_size = l2size;
+	}
 
 	printk(KERN_INFO "CPU: L2 Cache: %dK (%d bytes/line)\n",
 	       l2size, ecx & 0xFF);

-- 
James Slater
j.c.k.slater@ncl.ac.uk

