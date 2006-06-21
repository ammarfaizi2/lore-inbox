Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030310AbWFUVBU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030310AbWFUVBU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 17:01:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030297AbWFUVBQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 17:01:16 -0400
Received: from rhlx01.fht-esslingen.de ([129.143.116.10]:53479 "EHLO
	rhlx01.fht-esslingen.de") by vger.kernel.org with ESMTP
	id S1030300AbWFUVAg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 17:00:36 -0400
Date: Wed, 21 Jun 2006 23:00:35 +0200
From: Andreas Mohr <andi@rhlx01.fht-esslingen.de>
To: Andrew Morton <akpm@osdl.org>
Cc: len.brown@intel.com, linux-acpi@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: [PATCH -mm 5/6] cpu_relax(): use in ACPI lock
Message-ID: <20060621210035.GE22516@rhlx01.fht-esslingen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-Priority: none
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Use cpu_relax() in __acpi_acquire_global_lock() etc.


This could be considered overkill given the previous unlikely(),
but it is busy-looping in case of false condition after all...

Tested on 2.6.17-mm1, i386 only (no x86_64 here).

Signed-off-by: Andreas Mohr <andi@lisas.de>


diff -urN linux-2.6.17-mm1.orig/include/asm-i386/acpi.h linux-2.6.17-mm1.my/include/asm-i386/acpi.h
--- linux-2.6.17-mm1.orig/include/asm-i386/acpi.h	2006-06-19 10:57:27.000000000 +0200
+++ linux-2.6.17-mm1.my/include/asm-i386/acpi.h	2006-06-21 14:43:24.000000000 +0200
@@ -61,11 +61,14 @@
 __acpi_acquire_global_lock (unsigned int *lock)
 {
 	unsigned int old, new, val;
-	do {
+	while (1) {
 		old = *lock;
 		new = (((old & ~0x3) + 2) + ((old >> 1) & 0x1));
 		val = cmpxchg(lock, old, new);
-	} while (unlikely (val != old));
+		if (likely(val == old))
+			break;
+		cpu_relax();
+	}
 	return (new < 3) ? -1 : 0;
 }
 
@@ -73,11 +76,14 @@
 __acpi_release_global_lock (unsigned int *lock)
 {
 	unsigned int old, new, val;
-	do {
+	while (1) {
 		old = *lock;
 		new = old & ~0x3;
 		val = cmpxchg(lock, old, new);
-	} while (unlikely (val != old));
+		if (likely(val == old))
+			break;
+		cpu_relax();
+	}
 	return old & 0x1;
 }
 
diff -urN linux-2.6.17-mm1.orig/include/asm-x86_64/acpi.h linux-2.6.17-mm1.my/include/asm-x86_64/acpi.h
--- linux-2.6.17-mm1.orig/include/asm-x86_64/acpi.h	2006-06-21 14:28:19.000000000 +0200
+++ linux-2.6.17-mm1.my/include/asm-x86_64/acpi.h	2006-06-21 14:43:24.000000000 +0200
@@ -59,11 +59,14 @@
 __acpi_acquire_global_lock (unsigned int *lock)
 {
 	unsigned int old, new, val;
-	do {
+	while (1) {
 		old = *lock;
 		new = (((old & ~0x3) + 2) + ((old >> 1) & 0x1));
 		val = cmpxchg(lock, old, new);
-	} while (unlikely (val != old));
+		if (likely(val == old))
+			break;
+		cpu_relax();
+	}
 	return (new < 3) ? -1 : 0;
 }
 
@@ -75,7 +78,10 @@
 		old = *lock;
 		new = old & ~0x3;
 		val = cmpxchg(lock, old, new);
-	} while (unlikely (val != old));
+		if (likely(val == old))
+			break;
+		cpu_relax();
+	}
 	return old & 0x1;
 }
 
