Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267327AbUIAQVD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267327AbUIAQVD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 12:21:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267334AbUIAP5R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 11:57:17 -0400
Received: from delerium.kernelslacker.org ([81.187.208.145]:63922 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S267327AbUIAPvp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 11:51:45 -0400
Date: Wed, 1 Sep 2004 16:51:22 +0100
Message-Id: <200409011551.i81FpMZn000650@delerium.codemonkey.org.uk>
From: Dave Jones <davej@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Fix possible leak in fbcon code.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Spotted with the source checker from Coverity.com.

Signed-off-by: Dave Jones <davej@redhat.com>


diff -urpN --exclude-from=/home/davej/.exclude bk-linus/drivers/video/console/fbcon.c linux-2.6/drivers/video/console/fbcon.c
--- bk-linus/drivers/video/console/fbcon.c	2004-08-24 00:02:40.000000000 +0100
+++ linux-2.6/drivers/video/console/fbcon.c	2004-09-01 13:31:12.000000000 +0100
@@ -983,6 +983,7 @@ static void fbcon_init(struct vc_data *v
 			vc->vc_y += logo_lines;
 			vc->vc_pos += logo_lines * vc->vc_size_row;
 			kfree(save);
+			save = NULL;
 		}
 		if (logo_lines > vc->vc_bottom) {
 			logo_shown = -1;
@@ -1004,6 +1005,8 @@ static void fbcon_init(struct vc_data *v
 			softback_top = 0;
 		}
 	}
+	if (save)
+		kfree(save);
 }
 
 static void fbcon_deinit(struct vc_data *vc)
