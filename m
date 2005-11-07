Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932337AbVKGMVX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932337AbVKGMVX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 07:21:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932474AbVKGMVW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 07:21:22 -0500
Received: from gw02.mail.saunalahti.fi ([195.197.172.116]:24248 "EHLO
	gw02.mail.saunalahti.fi") by vger.kernel.org with ESMTP
	id S932337AbVKGMVV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 07:21:21 -0500
From: Ville =?ISO-8859-1?Q?=20Syrj=E4l=E4?= <syrjala@sci.fi>
To: linux-kernel@vger.kernel.org
Cc: linux-fbdev-devel@lists.sourceforge.net
Subject: [PATCH] Fix console blanking
Content-Type: text
Message-Id: <20051107122117.24DB32EB@kuori.saunalahti.fi>
Date: Mon,  7 Nov 2005 14:21:17 +0200 (EET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Current console blanking code is broken. It will first do a normal 
blank, then start the VESA blank timer if vesa_off_interval != 0, and 
then proceed to do the VESA blanking directly. After the timer expires 
it will do the VESA blanking a second time. Also the vesa_powerdown() 
function doesn't allow all VESA modes to be used.

With this patch the behaviour is:
1. Blank: vesa_off_interval != 0 -> Do normal blank
          vesa_off_interval == 0 -> Do VESA blank
2. Start the VESA blank timer if vesa_off_interval != 0 and
   vesa_power_mode != 0.

It also gets rid of the limiting vesa_powerdown() function.

Signed-off-by: Ville Syrjälä <syrjala@sci.fi>
---

 vt.c |   33 +++------------------------------
 1 file changed, 3 insertions(+), 30 deletions(-)

diff -uprN linux-2.6.14-0/drivers/char/vt.c linux-2.6.14-1/drivers/char/vt.c
--- linux-2.6.14-0/drivers/char/vt.c	2005-11-05 19:10:14.000000000 +0200
+++ linux-2.6.14-1/drivers/char/vt.c	2005-11-07 13:24:01.000000000 +0200
@@ -2758,29 +2758,6 @@ static void set_vesa_blanking(char __use
     vesa_blank_mode = (mode < 4) ? mode : 0;
 }
 
-/*
- * This is called by a timer handler
- */
-static void vesa_powerdown(void)
-{
-    struct vc_data *c = vc_cons[fg_console].d;
-    /*
-     *  Power down if currently suspended (1 or 2),
-     *  suspend if currently blanked (0),
-     *  else do nothing (i.e. already powered down (3)).
-     *  Called only if powerdown features are allowed.
-     */
-    switch (vesa_blank_mode) {
-    case VESA_NO_BLANKING:
-	    c->vc_sw->con_blank(c, VESA_VSYNC_SUSPEND+1, 0);
-	    break;
-    case VESA_VSYNC_SUSPEND:
-    case VESA_HSYNC_SUSPEND:
-	    c->vc_sw->con_blank(c, VESA_POWERDOWN+1, 0);
-	    break;
-    }
-}
-
 void do_blank_screen(int entering_gfx)
 {
 	struct vc_data *vc = vc_cons[fg_console].d;
@@ -2791,8 +2768,7 @@ void do_blank_screen(int entering_gfx)
 	if (console_blanked) {
 		if (blank_state == blank_vesa_wait) {
 			blank_state = blank_off;
-			vesa_powerdown();
-
+			vc->vc_sw->con_blank(vc, vesa_blank_mode + 1, 0);
 		}
 		return;
 	}
@@ -2822,7 +2798,7 @@ void do_blank_screen(int entering_gfx)
 
 	save_screen(vc);
 	/* In case we need to reset origin, blanking hook returns 1 */
-	i = vc->vc_sw->con_blank(vc, 1, 0);
+	i = vc->vc_sw->con_blank(vc, vesa_off_interval ? 1 : (vesa_blank_mode + 1), 0);
 	console_blanked = fg_console + 1;
 	if (i)
 		set_origin(vc);
@@ -2830,13 +2806,10 @@ void do_blank_screen(int entering_gfx)
 	if (console_blank_hook && console_blank_hook(1))
 		return;
 
-	if (vesa_off_interval) {
+	if (vesa_off_interval && vesa_blank_mode) {
 		blank_state = blank_vesa_wait;
 		mod_timer(&console_timer, jiffies + vesa_off_interval);
 	}
-
-    	if (vesa_blank_mode)
-		vc->vc_sw->con_blank(vc, vesa_blank_mode + 1, 0);
 }
 EXPORT_SYMBOL(do_blank_screen);
 

