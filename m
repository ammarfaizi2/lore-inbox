Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266311AbUAVTdH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jan 2004 14:33:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266332AbUAVTdH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jan 2004 14:33:07 -0500
Received: from aun.it.uu.se ([130.238.12.36]:24061 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S266311AbUAVTcx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jan 2004 14:32:53 -0500
From: Mikael Pettersson <mikpe@user.it.uu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16400.9569.745184.16182@alkaid.it.uu.se>
Date: Thu, 22 Jan 2004 20:32:49 +0100
To: torvalds@osdl.org
Subject: [PATCH][2.6] local APIC LVTT init bug
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

__setup_APIC_LVTT() incorrectly sets i82489DX-only bits
which are reserved in integrated local APICs, causing
problems in some machines. Fixed in this patch by making
this setting conditional.

It's possible these bits don't need to be set on i82489DXs,
but not having this HW for testing I elected to maintain
our current behaviour on these old machines.

/Mikael

diff -ruN linux-2.6.2-rc1/arch/i386/kernel/apic.c linux-2.6.2-rc1.apic-lvtt-init-fix/arch/i386/kernel/apic.c
--- linux-2.6.2-rc1/arch/i386/kernel/apic.c	2003-10-18 11:59:45.000000000 +0200
+++ linux-2.6.2-rc1.apic-lvtt-init-fix/arch/i386/kernel/apic.c	2004-01-22 19:57:37.691617134 +0100
@@ -834,11 +834,13 @@
 
 void __setup_APIC_LVTT(unsigned int clocks)
 {
-	unsigned int lvtt1_value, tmp_value;
+	unsigned int lvtt_value, tmp_value, ver;
 
-	lvtt1_value = SET_APIC_TIMER_BASE(APIC_TIMER_BASE_DIV) |
-			APIC_LVT_TIMER_PERIODIC | LOCAL_TIMER_VECTOR;
-	apic_write_around(APIC_LVTT, lvtt1_value);
+	ver = GET_APIC_VERSION(apic_read(APIC_LVR));
+	lvtt_value = APIC_LVT_TIMER_PERIODIC | LOCAL_TIMER_VECTOR;
+	if (!APIC_INTEGRATED(ver))
+		lvtt_value |= SET_APIC_TIMER_BASE(APIC_TIMER_BASE_DIV);
+	apic_write_around(APIC_LVTT, lvtt_value);
 
 	/*
 	 * Divide PICLK by 16
