Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266174AbUGTSkd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266174AbUGTSkd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jul 2004 14:40:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266166AbUGTSjx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jul 2004 14:39:53 -0400
Received: from amsfep17-int.chello.nl ([213.46.243.15]:27201 "EHLO
	amsfep17-int.chello.nl") by vger.kernel.org with ESMTP
	id S266131AbUGTSiG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jul 2004 14:38:06 -0400
Date: Tue, 20 Jul 2004 20:37:57 +0200
Message-Id: <200407201837.i6KIbvQo015369@anakin.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 460] M68k 68060 errata I14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

M68k: gcc lately manages to generate the code sequence described in the 060
errata I14, so use the described workaround (from Roman Zippel)

Signed-off-by: Roman Zippel <zippel@linux-m68k.org>
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

--- linux-2.6.8-rc2/arch/m68k/kernel/setup.c	2004-05-24 11:13:22.000000000 +0200
+++ linux-m68k-2.6.8-rc2/arch/m68k/kernel/setup.c	2004-07-04 22:03:49.000000000 +0200
@@ -238,6 +238,18 @@
 	}
 #endif
 
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
 	init_mm.start_code = PAGE_OFFSET;
 	init_mm.end_code = (unsigned long) &_etext;
 	init_mm.end_data = (unsigned long) &_edata;

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
