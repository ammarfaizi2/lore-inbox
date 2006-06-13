Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932141AbWFMTyY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932141AbWFMTyY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jun 2006 15:54:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932137AbWFMTyX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jun 2006 15:54:23 -0400
Received: from rhlx01.fht-esslingen.de ([129.143.116.10]:991 "EHLO
	rhlx01.fht-esslingen.de") by vger.kernel.org with ESMTP
	id S932127AbWFMTyU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jun 2006 15:54:20 -0400
Date: Tue, 13 Jun 2006 21:54:18 +0200
From: Andreas Mohr <andi@rhlx01.fht-esslingen.de>
To: Andrew Morton <akpm@osdl.org>
Cc: len.brown@intel.com, linux-acpi@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: [PATCH -mm] ACPI lock: cpu_relax() (was: [RFC -mm] more cpu_relax() places?)
Message-ID: <20060613195418.GB24167@rhlx01.fht-esslingen.de>
References: <20060612183743.GA28610@rhlx01.fht-esslingen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060612183743.GA28610@rhlx01.fht-esslingen.de>
User-Agent: Mutt/1.4.2.1i
X-Priority: none
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

On Mon, Jun 12, 2006 at 08:37:43PM +0200, Andreas Mohr wrote:
> Hi all,
> 
> while reviewing 2.6.17-rc6-mm1, I found some places that might
> want to make use of cpu_relax() in order to not block secondary
> pipelines while busy-polling (probably especially useful on SMT CPUs):

Patch no. 2 of 3.

This could be considered overkill given the previous unlikely(),
but it is busy-looping on failure after all...

Signed-off-by: Andreas Mohr <andi@lisas.de>


diff -urN linux-2.6.17-rc6-mm2.orig/include/asm-i386/acpi.h linux-2.6.17-rc6-mm2.my/include/asm-i386/acpi.h
--- linux-2.6.17-rc6-mm2.orig/include/asm-i386/acpi.h	2006-06-08 10:38:10.000000000 +0200
+++ linux-2.6.17-rc6-mm2.my/include/asm-i386/acpi.h	2006-06-13 19:35:41.000000000 +0200
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
 
