Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261350AbVCHD3s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261350AbVCHD3s (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 22:29:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261304AbVCGUWr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 15:22:47 -0500
Received: from 209-204-138-32.dsl.static.sonic.net ([209.204.138.32]:464 "EHLO
	graphe.net") by vger.kernel.org with ESMTP id S261350AbVCGTrc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 14:47:32 -0500
Date: Mon, 7 Mar 2005 11:47:26 -0800 (PST)
From: Christoph Lameter <christoph@graphe.net>
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org
Subject: Support HPET with a single timer for system time
Message-ID: <Pine.LNX.4.58.0503071146070.7840@server.graphe.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Score: -5.5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes the check for the existence of multiple HPET timers.
It allows the use of HPET with only a single timer for system time if
HPET_EMULATE_RTC is not set.

Signed-off-by: Christoph Lameter <christoph@lameter.com>
Signed-off-by: Shai Fultheim <Shai@Scalex86.org>

Index: linux-2.6.10/arch/i386/kernel/time_hpet.c
===================================================================
--- linux-2.6.10.orig/arch/i386/kernel/time_hpet.c	2005-02-28 13:04:28.000000000 -0800
+++ linux-2.6.10/arch/i386/kernel/time_hpet.c	2005-03-01 12:11:18.702195056 -0800
@@ -121,11 +121,16 @@ int __init hpet_enable(void)
 	id = hpet_readl(HPET_ID);

 	/*
-	 * We are checking for value '1' or more in number field.
-	 * So, we are OK with HPET_EMULATE_RTC part too, where we need
-	 * to have atleast 2 timers.
+	 * We are checking for value '1' or more in number field if
+	 * CONFIG_HPET_EMULATE_RTC is set because we will need an
+	 * additional timer for RTC emulation.
+	 * However, we can do with one timer otherwise using the
+	 * the single HPET timer for system time.
 	 */
-	if (!(id & HPET_ID_NUMBER) ||
+	if (
+#ifdef CONFIG_HPET_EMULATE_RTC
+		!(id & HPET_ID_NUMBER) ||
+#endif
 	    !(id & HPET_ID_LEGSUP))
 		return -1;

