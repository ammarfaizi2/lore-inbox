Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262174AbTEZToL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 May 2003 15:44:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262175AbTEZToL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 May 2003 15:44:11 -0400
Received: from marasystems.com ([213.150.153.194]:56472 "EHLO
	filer.marasystems.com") by vger.kernel.org with ESMTP
	id S262174AbTEZToJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 May 2003 15:44:09 -0400
Subject: [patch] slab.c ATOMIC debug check to immediately trap atomic abuse
	while debugging
From: Henrik Nordstrom <hno@marasystems.com>
To: linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="=-zsqC5F4E4vlcBiXLbkux"
Organization: MARA Systems AB
Message-Id: <1053979039.2163.52.camel@henrik.marasystems.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 26 May 2003 21:57:19 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-zsqC5F4E4vlcBiXLbkux
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit

Hi.

The attached patch extends slab debugging with an early check if ATOMIC
is required. The patch is relative to 2.4.20 but may also be interesting
for 2.5.

Normally the atomic requirement is only verified when the slab cache
needs to grow, but with this patch such errors is detected immediately
on first call if slab debugging is enabled.

This patch would have saved me from panic bug hunting after a system was
sent into production as the errors then would have been trapped
immediately during development. Probably many others would be helped by
this slab debugging to trap stupid memory allocation / locking errors
early on in development.

Regards
Henrik Nordström
MARA Systems AB, Sweden

--=-zsqC5F4E4vlcBiXLbkux
Content-Disposition: attachment; filename=slab_atomic_debug.patch
Content-Type: text/plain; name=slab_atomic_debug.patch; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

--- linux-2.4.20-uml/mm/slab.c	2003-02-27 20:56:12.000000000 +0100
+++ linux-2.4.20-uml-henrik/mm/slab.c	2003-05-26 20:57:44.000000000 +0200
@@ -1338,6 +1338,12 @@
 	unsigned long save_flags;
 	void* objp;
 
+#if DEBUG
+	/* trap atomic bugs early on when debugging */
+	if (in_interrupt() && (flags & SLAB_LEVEL_MASK) != SLAB_ATOMIC)
+		BUG();
+#endif
+
 	kmem_cache_alloc_head(cachep, flags);
 try_again:
 	local_irq_save(save_flags);

--=-zsqC5F4E4vlcBiXLbkux--

