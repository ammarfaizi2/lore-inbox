Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264167AbTCXL65>; Mon, 24 Mar 2003 06:58:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264168AbTCXL65>; Mon, 24 Mar 2003 06:58:57 -0500
Received: from dp.samba.org ([66.70.73.150]:44210 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S264166AbTCXL6u>;
	Mon, 24 Mar 2003 06:58:50 -0500
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15998.62418.678276.238530@nanango.paulus.ozlabs.org>
Date: Mon, 24 Mar 2003 23:02:26 +1100 (EST)
To: James Simmons <jsimmons@infradead.org>
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH] update control video driver
X-Mailer: VM 6.75 under Emacs 20.7.2
Reply-To: paulus@samba.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below fixes the controlfb driver to access the
pseudo_palette as 32-bit quantities and takes out the font option
handling.

Paul.

diff -urN linux-2.5/drivers/video/controlfb.c linuxppc-2.5/drivers/video/controlfb.c
--- linux-2.5/drivers/video/controlfb.c	2003-03-23 16:29:31.000000000 +1100
+++ linuxppc-2.5/drivers/video/controlfb.c	2003-03-23 21:42:33.000000000 +1100
@@ -376,13 +376,12 @@
 		int i;
 		switch (p->par.cmode) {
 		case CMODE_16:
-			((u16 *) (info->pseudo_palette))[regno] =
+			p->pseudo_palette[regno] =
 			    (regno << 10) | (regno << 5) | regno;
 			break;
 		case CMODE_32:
 			i = (regno << 8) | regno;
-			((u32 *) (info->pseudo_palette))[regno] =
-			    (i << 16) | i;
+			p->pseudo_palette[regno] = (i << 16) | i;
 			break;
 		}
 	}
@@ -475,7 +474,6 @@
 		var.yres_virtual = vyres;
 
 	/* Apply default var */
-	p->info.var = var;
 	var.activate = FB_ACTIVATE_NOW;
 	rc = fb_set_var(&var, &p->info);
 	if (rc && (vmode != VMODE_640_480_60 || cmode != CMODE_8))
@@ -1068,17 +1066,7 @@
 		return;
 
 	while ((this_opt = strsep(&options, ",")) != NULL) {
-		if (!strncmp(this_opt, "font:", 5)) {
-			char *p;
-			int i;
-
-			p = this_opt +5;
-			for (i = 0; i < sizeof(fontname) - 1; i++)
-				if (!*p || *p == ' ' || *p == ',')
-					break;
-			memcpy(fontname, this_opt + 5, i);
-			fontname[i] = 0;
-		} else if (!strncmp(this_opt, "vmode:", 6)) {
+		if (!strncmp(this_opt, "vmode:", 6)) {
 			int vmode = simple_strtoul(this_opt+6, NULL, 0);
 			if (vmode > 0 && vmode <= VMODE_MAX &&
 			    control_mac_modes[vmode - 1].m[1] >= 0)
