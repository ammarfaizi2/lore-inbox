Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751017AbWFNT3S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751017AbWFNT3S (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jun 2006 15:29:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751062AbWFNT3R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jun 2006 15:29:17 -0400
Received: from rhlx01.fht-esslingen.de ([129.143.116.10]:33450 "EHLO
	rhlx01.fht-esslingen.de") by vger.kernel.org with ESMTP
	id S1751017AbWFNT3O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jun 2006 15:29:14 -0400
Date: Wed, 14 Jun 2006 21:29:13 +0200
From: Andreas Mohr <andi@rhlx01.fht-esslingen.de>
To: Andrew Morton <akpm@osdl.org>
Cc: len.brown@intel.com, linux-acpi@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH -mm] ACPI lock: cpu_relax() (was: [RFC -mm] more cpu_relax() places?)
Message-ID: <20060614192913.GC19938@rhlx01.fht-esslingen.de>
References: <20060612183743.GA28610@rhlx01.fht-esslingen.de> <20060613195418.GB24167@rhlx01.fht-esslingen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060613195418.GB24167@rhlx01.fht-esslingen.de>
User-Agent: Mutt/1.4.2.1i
X-Priority: none
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

just realized that x86_64 has the same thing. (patch untested here!)

Signed-off-by: Andreas Mohr <andi@lisas.de>


--- linux-2.6.17-rc6-mm2.orig/include/asm-x86_64/acpi.h	2006-06-13 19:28:16.000000000 +0200
+++ linux-2.6.17-rc6-mm2.my/include/asm-x86_64/acpi.h	2006-06-14 21:21:15.000000000 +0200
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
 
@@ -71,11 +74,14 @@
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
 
