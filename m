Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261327AbULXRi7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261327AbULXRi7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Dec 2004 12:38:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261404AbULXRhw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Dec 2004 12:37:52 -0500
Received: from mail-relay-1.tiscali.it ([213.205.33.41]:17574 "EHLO
	mail-relay-1.tiscali.it") by vger.kernel.org with ESMTP
	id S261239AbULXRgR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Dec 2004 12:36:17 -0500
Date: Fri, 24 Dec 2004 18:36:07 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: linux-kernel@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@osdl.org>
Subject: VM fixes [3/4]
Message-ID: <20041224173607.GD13747@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is Con's disable_thrash_control he posted on l-k some day ago and
that I already acknowledged.

Signed-off-by: Andrea Arcangeli <andrea@suse.de>

Index: linux-2.6.10-rc3/mm/rmap.c
===================================================================
--- linux-2.6.10-rc3.orig/mm/rmap.c	2004-12-06 13:14:01.000000000 +1100
+++ linux-2.6.10-rc3/mm/rmap.c	2004-12-20 19:54:42.416058897 +1100
@@ -395,6 +395,9 @@ int page_referenced(struct page *page, i
 {
 	int referenced = 0;
 
+	if (!swap_token_default_timeout)
+		ignore_token = 1;
+
 	if (page_test_and_clear_young(page))
 		referenced++;
 
Index: linux-2.6.10-rc3/mm/thrash.c
===================================================================
--- linux-2.6.10-rc3.orig/mm/thrash.c	2004-12-06 13:14:01.000000000 +1100
+++ linux-2.6.10-rc3/mm/thrash.c	2004-12-20 19:56:01.594602700 +1100
@@ -19,7 +19,10 @@ unsigned long swap_token_check;
 struct mm_struct * swap_token_mm = &init_mm;
 
 #define SWAP_TOKEN_CHECK_INTERVAL (HZ * 2)
-#define SWAP_TOKEN_TIMEOUT (HZ * 300)
+#define SWAP_TOKEN_TIMEOUT	0
+/*
+ * Currently disabled; Needs further code to work at HZ * 300.
+ */
 unsigned long swap_token_default_timeout = SWAP_TOKEN_TIMEOUT;
 
 /*
