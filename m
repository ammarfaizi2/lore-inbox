Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964862AbVLISVu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964862AbVLISVu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Dec 2005 13:21:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964849AbVLISVl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Dec 2005 13:21:41 -0500
Received: from moutng.kundenserver.de ([212.227.126.177]:51675 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S964850AbVLISUj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Dec 2005 13:20:39 -0500
Message-Id: <20051209182054.513792000@localhost>
References: <20051209180414.872465000@localhost>
Date: Fri, 09 Dec 2005 19:04:21 +0100
From: Arnd Bergmann <arnd@arndb.de>
To: Paul Mackerras <paulus@samba.org>
Cc: linuxppc64-dev@ozlabs.org, linux-kernel@vger.kernel.org,
       David Woodhouse <dwmw2@infradead.org>, Arnd Bergmann <arndb@de.ibm.com>
Subject: [PATCH 7/8] cell: disable legacy i/o area
Content-Disposition: inline; filename=no-legacy-io.diff
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We currently crash in the fedora installer because the keyboard
driver tries to access I/O space that is not there on our hardware.

This uses the same solution as powermac by just marking all
legacy i/o as invalied.

From: David Woodhouse <dwmw2@infradead.org>
Signed-off-by: Arnd Bergmann <arndb@de.ibm.com>
Index: linux-2.6.15-rc/arch/powerpc/platforms/cell/setup.c
===================================================================
--- linux-2.6.15-rc.orig/arch/powerpc/platforms/cell/setup.c
+++ linux-2.6.15-rc/arch/powerpc/platforms/cell/setup.c
@@ -203,6 +203,15 @@ static int __init cell_probe(int platfor
 	return 1;
 }
 
+/*
+ * Cell has no legacy IO; anything calling this function has to
+ * fail or bad things will happen
+ */
+static int cell_check_legacy_ioport(unsigned int baseport)
+{
+	return -ENODEV;
+}
+
 struct machdep_calls __initdata cell_md = {
 	.probe			= cell_probe,
 	.setup_arch		= cell_setup_arch,
@@ -215,6 +224,7 @@ struct machdep_calls __initdata cell_md 
 	.get_rtc_time		= rtas_get_rtc_time,
 	.set_rtc_time		= rtas_set_rtc_time,
 	.calibrate_decr		= generic_calibrate_decr,
+	.check_legacy_ioport	= cell_check_legacy_ioport,
 	.progress		= cell_progress,
 #ifdef CONFIG_KEXEC
 	.machine_kexec		= default_machine_kexec,

--

