Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264489AbTDXVjQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 17:39:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264492AbTDXVjQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 17:39:16 -0400
Received: from vana.vc.cvut.cz ([147.32.240.58]:21376 "EHLO vana.vc.cvut.cz")
	by vger.kernel.org with ESMTP id S264490AbTDXVi2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 17:38:28 -0400
Date: Thu, 24 Apr 2003 23:50:33 +0200
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: jsimmons@infradead.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Kernel crash triggered by con2fb
Message-ID: <20030424215033.GA9384@vana.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,
  it is not nice that anybody can crash my kernel by
doing con2fb with unallocated VT.
				Thanks,
					Petr Vandrovec
					vandrove@vc.cvut.cz

diff -urN linux-2.5.68-c1216.dist/drivers/video/console/fbcon.c linux-2.5.68-c1216.fb/drivers/video/console/fbcon.c
--- linux-2.5.68-c1216.dist/drivers/video/console/fbcon.c	2003-04-24 19:35:16.000000000 +0200
+++ linux-2.5.68-c1216.fb/drivers/video/console/fbcon.c	2003-04-24 23:37:24.000000000 +0200
@@ -294,13 +294,17 @@
  *	Maps a virtual console @unit to a frame buffer device
  *	@newidx.
  */
-void set_con2fb_map(int unit, int newidx)
+int set_con2fb_map(int unit, int newidx)
 {
 	struct vc_data *vc = vc_cons[unit].d;
 
+	if (!vc) {
+		return -ENODEV;
+	}
 	con2fb_map[unit] = newidx;
 	fbcon_is_default = (vc->vc_sw == &fb_con) ? 1 : 0;
 	take_over_console(&fb_con, unit, unit, fbcon_is_default);
+	return 0;
 }
 
 /*
diff -urN linux-2.5.68-c1216.dist/drivers/video/console/fbcon.h linux-2.5.68-c1216.fb/drivers/video/console/fbcon.h
--- linux-2.5.68-c1216.dist/drivers/video/console/fbcon.h	2003-04-24 19:35:21.000000000 +0200
+++ linux-2.5.68-c1216.fb/drivers/video/console/fbcon.h	2003-04-24 23:37:04.000000000 +0200
@@ -38,7 +38,7 @@
 
 /* drivers/video/console/fbcon.c */
 extern char con2fb_map[MAX_NR_CONSOLES];
-extern void set_con2fb_map(int unit, int newidx);
+extern int set_con2fb_map(int unit, int newidx);
 
     /*
      *  Attribute Decoding
diff -urN linux-2.5.68-c1216.dist/drivers/video/fbmem.c linux-2.5.68-c1216.fb/drivers/video/fbmem.c
--- linux-2.5.68-c1216.dist/drivers/video/fbmem.c	2003-04-24 19:33:03.000000000 +0200
+++ linux-2.5.68-c1216.fb/drivers/video/fbmem.c	2003-04-24 23:36:48.000000000 +0200
@@ -1035,7 +1035,7 @@
 		if (!registered_fb[con2fb.framebuffer])
 		    return -EINVAL;
 		if (con2fb.console != 0)
-			set_con2fb_map(con2fb.console-1, con2fb.framebuffer);
+			return set_con2fb_map(con2fb.console-1, con2fb.framebuffer);
 		else
 			fb_console_init();		
 		return 0;
