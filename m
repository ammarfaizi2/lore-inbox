Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263486AbUACPcI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jan 2004 10:32:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263497AbUACPcI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jan 2004 10:32:08 -0500
Received: from gprs214-81.eurotel.cz ([160.218.214.81]:11648 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S263486AbUACPcE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jan 2004 10:32:04 -0500
Date: Sat, 3 Jan 2004 16:33:11 +0100
From: Pavel Machek <pavel@ucw.cz>
To: kernel list <linux-kernel@vger.kernel.org>, jgarzik@pobox.com,
       Rusty trivial patch monkey Russell 
	<trivial@rustcorp.com.au>,
       Andrew Morton <akpm@zip.com.au>
Subject: Fix softcursor in 2.6.X
Message-ID: <20040103153310.GA617@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Softcursor was broken for half of 2.5 series. This fixes it by first
hiding cursor _then_ hiding softcursor. Very simple mistake... Please
apply,

								Pavel

--- tmp/linux/drivers/char/vt.c	2003-10-18 20:26:33.000000000 +0200
+++ linux/drivers/char/vt.c	2004-01-03 16:08:44.000000000 +0100
@@ -530,17 +530,22 @@
 		sw->con_putc(vc_cons[currcons].d, i, y, x);
 }
 
-static void hide_cursor(int currcons)
+static void hide_softcursor(int currcons)
 {
-	if (currcons == sel_cons)
-		clear_selection();
 	if (softcursor_original != -1) {
 		scr_writew(softcursor_original,(u16 *) pos);
 		if (DO_UPDATE)
 			sw->con_putc(vc_cons[currcons].d, softcursor_original, y, x);
 		softcursor_original = -1;
 	}
+}
+
+static void hide_cursor(int currcons)
+{
+	if (currcons == sel_cons)
+		clear_selection();
 	sw->con_cursor(vc_cons[currcons].d,CM_ERASE);
+	hide_softcursor(currcons);
 }
 
 static void set_cursor(int currcons)

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
