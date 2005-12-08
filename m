Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932705AbVLHXjr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932705AbVLHXjr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Dec 2005 18:39:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932743AbVLHXjr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Dec 2005 18:39:47 -0500
Received: from mailout02.sul.t-online.com ([194.25.134.17]:2262 "EHLO
	mailout02.sul.t-online.com") by vger.kernel.org with ESMTP
	id S932705AbVLHXjq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Dec 2005 18:39:46 -0500
Message-ID: <4398B888.50005@t-online.de>
Date: Thu, 08 Dec 2005 23:49:44 +0100
From: Knut Petersen <Knut_Petersen@t-online.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de-AT; rv:1.7.7) Gecko/20050414
X-Accept-Language: de, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: linux-fbdev-devel@lists.sourceforge.net, Andrew Morton <akpm@osdl.org>,
       "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 1/1 2.6.15-rc4-git1] Fix switching to KD_TEXT
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-ID: XjD3IgZAoejGGgGZMZg6J1wE40gXxitCh-10XKmg4Sp77dld-puisc@t-dialin.net
X-TOI-MSGID: d79cafff-2d2e-471d-ab9b-3724cdcc1021
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Every framebuffer driver relies on the assumption that the set_par() 
function
of the driver is called before drawing functions and other functions 
dependent
on the hardware state are executed.

This assumption is false in two cases, and one is a genuine linux
bug:

    1: Whenever you switch from X to a framebuffer console for the very
        first time, there is a chance that a broken X system has _not_ set
        the mode to KD_GRAPHICS, thus the vt and framebuffer code
        executes a screen redraw and several other functions before a
        set_par() is executed. This is believed to be not a bug of linux
        but a bug of X/xdm.

    2: Whenever a switch from X to a framebuffer console occures,
         the pan_display() function of the driver is called once before
         the set_par() function of the driver is called. Code path:
         complete_change_console -> redraw_screen -> fbcon_switch ->
         bit_update_start-> fb_pan_display -> xyz_pan_display.
         This is clearly a bug of linux.

Although our primary goal must be to fix linux bugs and not to work
around bugs of X, the patch fixes both of the cases.

The advantage and correctness of this patch should be obvious. Yes, it
does add a possibly slow call to the fb_set_par() function, but at this
point it is necessary.

Signed-off-by: Knut Petersen <Knut_Petersen@t-online.de>


diff -uprN -X linux/Documentation/dontdiff -x '*.bak' -x '*.ctx' linuxorig/drivers/video/console/fbcon.c linux/drivers/video/console/fbcon.c
--- linuxorig/drivers/video/console/fbcon.c	2005-12-02 12:18:04.000000000 +0100
+++ linux/drivers/video/console/fbcon.c	2005-12-06 09:06:56.000000000 +0100
@@ -2103,10 +2103,11 @@ static int fbcon_switch(struct vc_data *
 	fb_set_var(info, &var);
 	ops->var = info->var;
 
-	if (old_info != NULL && old_info != info) {
-		if (info->fbops->fb_set_par)
-			info->fbops->fb_set_par(info);
+	if (old_info != NULL && old_info != info)
 		fbcon_del_cursor_timer(old_info);
+
+	if (info->fbops->fb_set_par) {
+		info->fbops->fb_set_par(info);
 		fbcon_add_cursor_timer(info);
 	}


