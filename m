Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261495AbVAXNxE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261495AbVAXNxE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 08:53:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261509AbVAXNxD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 08:53:03 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:64397 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S261495AbVAXNwZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 08:52:25 -0500
Date: Mon, 24 Jan 2005 14:52:13 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.11-rc2-mm1
In-Reply-To: <20050124021516.5d1ee686.akpm@osdl.org>
Message-ID: <Pine.LNX.4.61.0501241446320.6118@scrub.home>
References: <20050124021516.5d1ee686.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 24 Jan 2005, Andrew Morton wrote:

> - On my test box there is no flashing cursor on the vga console.  Known bug,
>   please don't report it.
> 
>   Binary searching shows that the bug was introduced by
>   cleanup-vc-array-access.patch but that patch is, unfortunately, huge.

I introduced a stupid typo. The patch below should fix.
After completing rechecking and testing the patch I'll send you a rediffed 
version.

bye, Roman

diff -ur -X /home/devel/roman/nodiff linux-2.6.11-rc2-mm1.org/drivers/char/vt.c linux-2.6.11-rc2-mm1/drivers/char/vt.c
--- linux-2.6.11-rc2-mm1.org/drivers/char/vt.c	2005-01-24 14:16:18.000000000 +0100
+++ linux-2.6.11-rc2-mm1/drivers/char/vt.c	2005-01-24 14:18:25.000000000 +0100
@@ -212,6 +212,8 @@
  *	Low-Level Functions
  */
 
+#define IS_FG(vc)	((vc)->vc_num == fg_console)
+
 #ifdef VT_BUF_VRAM_ONLY
 #define DO_UPDATE(vc)	0
 #else
@@ -544,7 +546,7 @@
 
 static void set_cursor(struct vc_data *vc)
 {
-	if (!vc->vc_num != fg_console || console_blanked ||
+	if (!IS_FG(vc) || console_blanked ||
 	    vc->vc_mode == KD_GRAPHICS)
 		return;
 	if (vc->vc_deccm) {
@@ -1953,7 +1955,7 @@
 	charmask = himask ? 0x1ff : 0xff;
 
 	/* undraw cursor first */
-	if (currcons == fg_console)
+	if (IS_FG(vc))
 		hide_cursor(vc);
 
 	while (!tty->stopped && count) {
@@ -2166,7 +2168,7 @@
 		goto quit;
 
 	/* undraw cursor first */
-	if (vc->vc_num == fg_console)
+	if (IS_FG(vc))
 		hide_cursor(vc);
 
 	start = (ushort *)vc->vc_pos;
