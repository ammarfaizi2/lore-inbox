Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266511AbUGUPgS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266511AbUGUPgS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jul 2004 11:36:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266512AbUGUPgS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jul 2004 11:36:18 -0400
Received: from nl-ams-slo-l4-01-pip-5.chellonetwork.com ([213.46.243.21]:5411
	"EHLO amsfep14-int.chello.nl") by vger.kernel.org with ESMTP
	id S266511AbUGUPgK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jul 2004 11:36:10 -0400
Date: Wed, 21 Jul 2004 17:36:03 +0200
Message-Id: <200407211536.i6LFa3I7020410@anakin.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 158] M68k 68060 errata I14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

M68k: gcc lately manages to generate the code sequence described in the 060
errata I14, so use the described workaround (from Roman Zippel)

Signed-off-by: Roman Zippel <zippel@linux-m68k.org>
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

--- linux-2.4.27-rc3/arch/m68k/kernel/setup.c	2004-04-30 16:35:25.000000000 +0200
+++ linux-m68k-2.4.27-rc3/arch/m68k/kernel/setup.c	2004-07-04 21:55:44.000000000 +0200
@@ -249,6 +249,18 @@
 	else if (CPU_IS_060)
 		m68k_is040or060 = 6;
 
+	if (CPU_IS_060) {
+		u32 pcr;
+
+		asm (".chip 68060; movec %%pcr,%0; .chip 68k"
+		     : "=d" (pcr));
+		if (((pcr >> 8) & 0xff) <= 5) {
+			printk("Enabling workaround for errata I14\n");
+			asm (".chip 68060; movec %0,%%pcr; .chip 68k"
+			     : : "d" (pcr | 0x20));
+		}
+	}
+
 	/* FIXME: m68k_fputype is passed in by Penguin booter, which can
 	 * be confused by software FPU emulation. BEWARE.
 	 * We should really do our own FPU check at startup.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
