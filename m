Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268702AbUIMScK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268702AbUIMScK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 14:32:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268834AbUIMScJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 14:32:09 -0400
Received: from vana.vc.cvut.cz ([147.32.240.58]:9344 "EHLO vana.vc.cvut.cz")
	by vger.kernel.org with ESMTP id S268702AbUIMScD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 14:32:03 -0400
Date: Mon, 13 Sep 2004 20:31:50 +0200
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: torvalds@osdl.org
Cc: adaplas@hotpop.com, linux-kernel@vger.kernel.org
Subject: [PATCH] Report capabilities properly for matrox's fbdev
Message-ID: <20040913183149.GA8883@vana.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040818i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
   fbdev devices are now supposed to provide hints to fbcon
about methods which are supported by hardware.  When Antonio
did his mass update during August, he kindly skipped over
matroxfb - so here is missing part.

   It sets (except its capabilities) also FBINFO_READS_FAST,
as fbcon treats FBINFO_READS_FAST as a prerequisite for treating
FBINFO_HWACCEL_COPYAREA seriously, and on matroxes with acceleration
copyarea is much faster than imageblit (it slows down unaccelerated
mode, but hopefully majority of users will run with acceleration 
enabled).

   Second head is dumb and unaccelerated, so only panning is reported
on it.
					Thanks,
						Petr Vandrovec


 
diff -urdN linux/drivers/video/matrox/matroxfb_base.c linux/drivers/video/matrox/matroxfb_base.c
--- linux/drivers/video/matrox/matroxfb_base.c	2004-09-13 14:10:16.000000000 +0000
+++ linux/drivers/video/matrox/matroxfb_base.c	2004-09-13 18:28:28.000000000 +0000
@@ -1750,6 +1750,15 @@
 	ACCESS_FBINFO(fbcon.pseudo_palette) = ACCESS_FBINFO(cmap);
 	/* after __init time we are like module... no logo */
 	ACCESS_FBINFO(fbcon.flags) = hotplug ? FBINFO_FLAG_MODULE : FBINFO_FLAG_DEFAULT;
+	ACCESS_FBINFO(fbcon.flags) |= FBINFO_PARTIAL_PAN_OK | 	 /* Prefer panning for scroll under MC viewer/edit */
+				      FBINFO_HWACCEL_COPYAREA |  /* We have hw-assisted bmove */
+				      FBINFO_HWACCEL_FILLRECT |  /* And fillrect */
+				      FBINFO_HWACCEL_IMAGEBLIT | /* And imageblit */
+				      FBINFO_HWACCEL_XPAN |      /* And we support both horizontal */
+				      FBINFO_HWACCEL_YPAN;       /* And vertical panning */
+	/* We must set this, otherwise fbcon will not
+	   use copyarea at all (it will insist on redraw) ! */
+	ACCESS_FBINFO(fbcon.flags) |= FBINFO_READS_FAST;
 	ACCESS_FBINFO(video.len_usable) &= PAGE_MASK;
 	fb_alloc_cmap(&ACCESS_FBINFO(fbcon.cmap), 256, 1);
 
diff -urdN linux/drivers/video/matrox/matroxfb_crtc2.c linux/drivers/video/matrox/matroxfb_crtc2.c
--- linux/drivers/video/matrox/matroxfb_crtc2.c	2004-09-13 14:10:37.000000000 +0000
+++ linux/drivers/video/matrox/matroxfb_crtc2.c	2004-09-13 18:27:56.000000000 +0000
@@ -603,6 +603,8 @@
 
 	m2info->fbcon.fbops = &matroxfb_dh_ops;
 	m2info->fbcon.flags = FBINFO_FLAG_DEFAULT;
+	m2info->fbcon.flags |= FBINFO_HWACCEL_XPAN |
+			       FBINFO_HWACCEL_YPAN;
 	m2info->fbcon.currcon = -1;
 	m2info->fbcon.pseudo_palette = m2info->cmap;
 	fb_alloc_cmap(&m2info->fbcon.cmap, 256, 1);
