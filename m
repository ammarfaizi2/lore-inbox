Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267411AbUJBRCm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267411AbUJBRCm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Oct 2004 13:02:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267404AbUJBRAz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Oct 2004 13:00:55 -0400
Received: from nl-ams-slo-l4-01-pip-8.chellonetwork.com ([213.46.243.27]:34120
	"EHLO amsfep15-int.chello.nl") by vger.kernel.org with ESMTP
	id S267409AbUJBRA1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Oct 2004 13:00:27 -0400
Date: Sat, 2 Oct 2004 19:00:24 +0200
Message-Id: <200410021700.i92H0OgM021193@anakin.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Linux Fbdev <linux-fbdev-devel@lists.sourceforge.net>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 495] Amifb: use new amifb:off logic to enhance audio experience
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Amiga frame buffer: We used to have a local hack in fbmem.c to always call the
fbdev setup() routines, even when an fbdev was explicitly disabled on the
kernel command line (video=xxx:off). This allowed amifb to suspend the monitor,
but program the sync generator of the video controller in Denise/Lisa to a 31
kHz/70 Hz mode, increasing the maximum audio playback frequency.
Thanks to the recently introduced fb_get_options() routine, we can kill the
local hack and just use the return value of fb_get_options().

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

--- linux-2.6.9-rc3/drivers/video/amifb.c	2004-09-30 18:08:25.000000000 +0200
+++ linux-m68k-2.6.9-rc3/drivers/video/amifb.c	2004-09-30 20:11:02.000000000 +0200
@@ -1239,8 +1239,6 @@ int __init amifb_setup(char *options)
 		if (!strcmp(this_opt, "inverse")) {
 			amifb_inverse = 1;
 			fb_invert_cmaps();
-		} else if (!strcmp(this_opt, "off")) {
-			amifb_video_off();
 		} else if (!strcmp(this_opt, "ilbm"))
 			amifb_ilbm = 1;
 		else if (!strncmp(this_opt, "monitorcap:", 11))
@@ -2260,8 +2258,10 @@ int __init amifb_init(void)
 #ifndef MODULE
 	char *option = NULL;
 
-	if (fb_get_options("amifb", &option))
+	if (fb_get_options("amifb", &option)) {
+		amifb_video_off();
 		return -ENODEV;
+	}
 	amifb_setup(option);
 #endif
 	if (!MACH_IS_AMIGA || !AMIGAHW_PRESENT(AMI_VIDEO))

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
