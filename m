Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269603AbUJGBfg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269603AbUJGBfg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 21:35:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269623AbUJGBff
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 21:35:35 -0400
Received: from gate.crashing.org ([63.228.1.57]:29851 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S269603AbUJGBfQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 21:35:16 -0400
Subject: [PATCH] ppc64: Fix find_udbg_vterm()
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1097112528.11702.14.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 07 Oct 2004 11:28:48 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

The find_udbg_vterm() used to initialize the early boot console
on LPAR machines will not work properly on some recent pSeries
because the firmware is playing tricks with the "phandle" values
used to identify firmware nodes. This patch fixes that by using
the full path instead.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

===== arch/ppc64/kernel/pSeries_lpar.c 1.42 vs edited =====
--- 1.42/arch/ppc64/kernel/pSeries_lpar.c	2004-09-27 16:20:05 +10:00
+++ edited/arch/ppc64/kernel/pSeries_lpar.c	2004-10-07 11:26:19 +10:00
@@ -135,7 +135,6 @@
 int find_udbg_vterm(void)
 {
 	struct device_node *stdout_node;
-	phandle *stdout_ph;
 	u32 *termno;
 	char *name;
 	int found = 0;
@@ -143,10 +142,10 @@
 	/* find the boot console from /chosen/stdout */
 	if (!of_chosen)
 		return 0;
-	stdout_ph = (phandle *)get_property(of_chosen, "linux,stdout-package", NULL);
-	if (stdout_ph == NULL)
+	name = (char *)get_property(of_chosen, "linux,stdout-path", NULL);
+	if (name == NULL)
 		return 0;
-	stdout_node = of_find_node_by_phandle(*stdout_ph);
+	stdout_node = of_find_node_by_path(name);
 	if (!stdout_node)
 		return 0;
 


