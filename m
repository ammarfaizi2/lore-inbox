Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264161AbTCXLos>; Mon, 24 Mar 2003 06:44:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264162AbTCXLos>; Mon, 24 Mar 2003 06:44:48 -0500
Received: from dp.samba.org ([66.70.73.150]:41380 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S264161AbTCXLon>;
	Mon, 24 Mar 2003 06:44:43 -0500
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15998.61467.868276.672346@nanango.paulus.ozlabs.org>
Date: Mon, 24 Mar 2003 22:46:35 +1100 (EST)
To: James Simmons <jsimmons@infradead.org>
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH] update platinum video driver
X-Mailer: VM 6.75 under Emacs 20.7.2
Reply-To: paulus@samba.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch gets the "platinum" driver to compile, and fixes it so that
the pseudo_palette is always accessed as 32-bit quantities.  It takes
out the video=platinumfb:font:blah option since fonts aren't handled
at this level any more AFAICT (and besides, it caused compile errors).

Paul.

diff -urN linux-2.5/drivers/video/platinumfb.c linuxppc-2.5/drivers/video/platinumfb.c
--- linux-2.5/drivers/video/platinumfb.c	2003-03-23 16:29:31.000000000 +1100
+++ linuxppc-2.5/drivers/video/platinumfb.c	2003-03-23 21:42:33.000000000 +1100
@@ -36,8 +36,8 @@
 #include <asm/prom.h>
 #include <asm/pgtable.h>
 
-#include "platinumfb.h"
 #include "macmodes.h"
+#include "platinumfb.h"
 
 static int default_vmode = VMODE_NVRAM;
 static int default_cmode = CMODE_NVRAM;
@@ -219,15 +219,14 @@
 
 	if (regno < 16) {
 		int i;
+		u32 *pal = info->pseudo_palette;
 		switch (p->par.cmode) {
 		case CMODE_16:
-			((u16 *) (info->pseudo_palette))[regno] =
-			    (regno << 10) | (regno << 5) | regno;
+			pal[regno] = (regno << 10) | (regno << 5) | regno;
 			break;
 		case CMODE_32:
 			i = (regno << 8) | regno;
-			((u32 *) (info->pseudo_palette))[regno] =
-			    (i << 16) | i;
+			pal[regno] = (i << 16) | i;
 			break;
 		}
 	}
@@ -401,7 +400,7 @@
 	/* Apply default var */
 	p->info.var = var;
 	var.activate = FB_ACTIVATE_NOW;
-	rc = gen_set_var(&var, -1, &p->info);
+	rc = fb_set_var(&var, &p->info);
 	if (rc && (default_vmode != VMODE_640_480_60 || default_cmode != CMODE_8))
 		goto try_again;
 
@@ -410,7 +409,7 @@
 		return 0;
 
 	printk(KERN_INFO "fb%d: platinum frame buffer device\n",
-	       GET_FB_IDX(p->info.node));
+	       minor(p->info.node));
 
 	return 1;
 }
@@ -607,21 +606,10 @@
 		return 0;
 
 	while ((this_opt = strsep(&options, ",")) != NULL) {
-		if (!strncmp(this_opt, "font:", 5)) {
-			char *p;
-			int i;
-
-			p = this_opt + 5;
-			for (i = 0; i < sizeof(fontname) - 1; i++)
-				if (!*p || *p == ' ' || *p == ',')
-					break;
-			memcpy(fontname, this_opt + 5, i);
-			fontname[i] = 0;
-		}
 		if (!strncmp(this_opt, "vmode:", 6)) {
 	    		int vmode = simple_strtoul(this_opt+6, NULL, 0);
-	    	if (vmode > 0 && vmode <= VMODE_MAX)
-			default_vmode = vmode;
+			if (vmode > 0 && vmode <= VMODE_MAX)
+				default_vmode = vmode;
 		} else if (!strncmp(this_opt, "cmode:", 6)) {
 			int depth = simple_strtoul(this_opt+6, NULL, 0);
 			switch (depth) {
