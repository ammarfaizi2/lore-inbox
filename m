Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261341AbUKSKEc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261341AbUKSKEc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 05:04:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261340AbUKSKEO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 05:04:14 -0500
Received: from igel.cyberlink.ch ([62.12.136.3]:15034 "HELO igel.cyberlink.ch")
	by vger.kernel.org with SMTP id S261339AbUKSKEE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 05:04:04 -0500
X-Qmail-Scanner-Mail-From: manfred99@gmx.ch via igel
X-Qmail-Scanner: 1.16 (Clear:. Processed in 0.049817 secs)
From: Manfred Schwarb <manfred99@gmx.ch>
To: linux-kernel@vger.kernel.org
Cc: Tigran Aivazian <tigran@veritas.com>, Manfred Schwarb <manfred99@gmx.ch>
Message-Id: <20041119100403.32522.90565.83940@tp-meteodat6.cyberlink.ch>
Subject: [PATCH 2.4.28] backport sigmatch() issue in microcode.c
Date: Fri, 19 Nov 2004 05:04:04 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

some weeks ago, Tigran Aivazian sent this patch to Marcelo
in a private email, I am unaware of the reasons why it is not included.

Just for public documentation, here is the 2.6.7 backport of the patch, which
allows the use of microcode updates also for old Pentium II machines.

Original explanation from Tigran:
	[PATCH] fix to microcode driver for the old CPUs.

	Here is a patch against Linux 2.6.7 which fixes the sigmatch() macro to
	work for the relatively old processors as well, which have 'pf == 0'
	(processor flags as read from MSR 0x17), For example, the processors
	failing without this patch are Pentium II 300 MHz (Klamath) with
	family/model/stepping 6/3/4 and 6/3/3.

It works for me.
Regards,
Manfred


--- linux-2.4.28/arch/i386/kernel/microcode.c.orig	2004-09-11 15:30:13.000000000 +0200
+++ linux-2.4.28/arch/i386/kernel/microcode.c	2004-09-11 16:36:43.000000000 +0200
@@ -109,7 +109,10 @@
 #define get_datasize(mc) \
 	(((microcode_t *)mc)->hdr.datasize ? \
 	 ((microcode_t *)mc)->hdr.datasize : DEFAULT_UCODE_DATASIZE)
-#define sigmatch(s1, s2, p1, p2) (((s1) == (s2)) && ((p1) & (p2)))
+
+#define sigmatch(s1, s2, p1, p2) \
+	(((s1) == (s2)) && (((p1) & (p2)) || (((p1) == 0) && ((p2) == 0))))
+
 #define exttable_size(et) ((et)->count * EXT_SIGNATURE_SIZE + EXT_HEADER_SIZE)
 
 /* serialize access to the physical write to MSR 0x79 */
