Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267410AbSLLDhm>; Wed, 11 Dec 2002 22:37:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267413AbSLLDhl>; Wed, 11 Dec 2002 22:37:41 -0500
Received: from dp.samba.org ([66.70.73.150]:48868 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S267410AbSLLDhk>;
	Wed, 11 Dec 2002 22:37:40 -0500
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15864.1043.611813.567678@argo.ozlabs.ibm.com>
Date: Thu, 12 Dec 2002 14:35:47 +1100
To: James Simmons <jsimmons@infradead.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>
Subject: [PATCH] fix text console redrawing
X-Mailer: VM 7.07 under Emacs 20.7.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I found out why the text console wasn't getting redrawn when switching
from X back to tty1.  It was because the vc->vc_font.width and .height
for tty1 had been reset to 0 by fbcon_set_display().  The font-setting
logic in there looks wrong to me, and this patch should fix it.
Without this patch, we find the first console on this fb which appears
to have valid font data and then copy the width and height *to* that
console rather than *from* that console.  This patch changes it to
copy from that console to the new console that we are initializing.

Paul.

diff -urN linux-2.5/drivers/video/console/fbcon.c pmac-2.5/drivers/video/console/fbcon.c
--- linux-2.5/drivers/video/console/fbcon.c	2002-12-10 15:20:32.000000000 +1100
+++ pmac-2.5/drivers/video/console/fbcon.c	2002-12-12 13:46:21.000000000 +1100
@@ -926,11 +926,11 @@
 		struct display *q = &fb_display[i];
 		struct vc_data *tmp = vc_cons[i].d;
 		
-		if (fontwidthvalid(p, vc->vc_font.width)) {
+		if (!fontwidthvalid(p, vc->vc_font.width)) {
 			/* If we are not the first console on this
 			   fb, copy the font from that console */
-			tmp->vc_font.width = vc->vc_font.width;
-			tmp->vc_font.height = vc->vc_font.height;
+			vc->vc_font.width = tmp->vc_font.width;
+			vc->vc_font.height = tmp->vc_font.height;
 			p->fontdata = q->fontdata;
 			p->userfont = q->userfont;
 			if (p->userfont) {

