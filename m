Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279842AbRKIMF3>; Fri, 9 Nov 2001 07:05:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279853AbRKIMFT>; Fri, 9 Nov 2001 07:05:19 -0500
Received: from drama.obuda.kando.hu ([193.224.41.14]:53694 "EHLO drama.koli")
	by vger.kernel.org with ESMTP id <S279842AbRKIMFM>;
	Fri, 9 Nov 2001 07:05:12 -0500
Date: Fri, 9 Nov 2001 13:04:33 +0100 (CET)
From: Bakonyi Ferenc <fero@drama.obuda.kando.hu>
X-X-Sender: fero@drama.koli
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] hgafb oopses
Message-ID: <Pine.LNX.4.40.0111091302580.16816-100000@drama.koli>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


	Hi!

Somebody submitted a patch against 2.4.13 which broke hgafb. That patch
called isa_memset() and isa_writeb() with an _already_ mapped address.
So that address was mapped twice -> oops.

The patch below is against 2.4.15-pre1. It resolves the ISA address
confusion, replaces scr_{read|write} functions with isa_{read|write},
and elimiates a cosmetic compiler warning about suggested parens.

Best regards:
	Ferenc Bakonyi



--- linux-2.4.15-pre1/drivers/video/hgafb.c	Fri Nov  9 12:22:42 2001
+++ linux/drivers/video/hgafb.c	Fri Nov  9 12:26:33 2001
@@ -312,10 +312,10 @@
 static int __init hga_card_detect(void)
 {
 	int count=0;
-	u16 *p, p_save;
-	u16 *q, q_save;
+	unsigned char p, p_save;
+	unsigned char q, q_save;

-	hga_vram_base = VGA_MAP_MEM(0xb0000);
+	hga_vram_base = 0xb0000;
 	hga_vram_len  = 0x08000;

 	if (request_region(0x3b0, 12, "hgafb"))
@@ -325,14 +325,14 @@

 	/* do a memory check */

-	p = (u16 *) hga_vram_base;
-	q = (u16 *) (hga_vram_base + 0x01000);
+	p = hga_vram_base;
+	q = hga_vram_base + 0x01000;

-	p_save = scr_readw(p); q_save = scr_readw(q);
+	p_save = isa_readw(p); q_save = isa_readw(q);

-	scr_writew(0xaa55, p); if (scr_readw(p) == 0xaa55) count++;
-	scr_writew(0x55aa, p); if (scr_readw(p) == 0x55aa) count++;
-	scr_writew(p_save, p);
+	isa_writew(0xaa55, p); if (isa_readw(p) == 0xaa55) count++;
+	isa_writew(0x55aa, p); if (isa_readw(p) == 0x55aa) count++;
+	isa_writew(p_save, p);

 	if (count != 2) {
 		return 0;
@@ -717,7 +717,7 @@
 	if (!nologo) hga_show_logo();
 #endif /* MODULE */

-	hga_fix.smem_start = hga_vram_base;
+	hga_fix.smem_start = VGA_MAP_MEM(hga_vram_base);
 	hga_fix.smem_len = hga_vram_len;

 	disp.var = hga_default_var;
@@ -795,7 +795,7 @@
 	if (!options || !*options)
 		return 0;

-	while (this_opt = strsep(&options, ",")) {
+	while ((this_opt = strsep(&options, ","))) {
 		if (!strncmp(this_opt, "font:", 5))
 			strcpy(fb_info.fontname, this_opt+5);
 	}

