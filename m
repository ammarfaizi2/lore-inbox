Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264914AbUFLUOa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264914AbUFLUOa (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Jun 2004 16:14:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264915AbUFLUO3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Jun 2004 16:14:29 -0400
Received: from sziami.cs.bme.hu ([152.66.242.225]:12211 "EHLO sziami.cs.bme.hu")
	by vger.kernel.org with ESMTP id S264914AbUFLUO2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Jun 2004 16:14:28 -0400
Date: Sat, 12 Jun 2004 22:14:15 +0200 (CEST)
From: Egmont Koblinger <egmont@uhulinux.hu>
X-X-Sender: egmont@sziami.cs.bme.hu
To: linux-kernel@vger.kernel.org
Cc: Stepan Koltsov <yozh@island.mx1.ru>
Subject: [PATCH] Shift+PgUp if nr of scrolled lines is < 4
Message-ID: <Pine.LNX.4.58L0.0406122201550.20424@sziami.cs.bme.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Using the vga console driver, if the number of the lines scrolled out is
less than four, then Shift+PageUp doesn't work.

The bug is closely related to the 'margin' feature of scrolling, which
means that if less than four lines should remain unvisible in the
direction we are scrolling to, then we scroll a little bit more just to
see those few lines. Kind of two small magnets at the borders of the
buffer.

This bug was also reported with maybe a less clear description by Stepan
Koltsov (cc'ed just for fun) back in 2001 and he got no answer. I found it
at  http://seclists.org/lists/linux-kernel/2001/Nov/0080.html

His patch simply disables margin support and hence everythings becomes
okay, but you lose a nice feature.

Here's a patch that retains margin support and fixes the bug. Works for
me, tested for a week. No guarantee. As I don't fully understand the code
(see also my previous mail) I'm not 100% sure that I'm doing the right
thing, so I'd prefer if someone would take a closer look at it.

At least 2.4 and 2.6 are affected, maybe older ones too.


--- linux-2.6.7-rc2.orig/drivers/video/console/vgacon.c	2004-05-30 08:26:09.000000000 +0200
+++ linux-2.6.7-rc2/drivers/video/console/vgacon.c	2004-06-06 00:31:29.829267377 +0200
@@ -963,6 +963,7 @@
 		p = (c->vc_visible_origin - vga_vram_base - ul + we) % we +
 		    lines * c->vc_size_row;
 		st = (c->vc_origin - vga_vram_base - ul + we) % we;
+		if (st < 2 * margin) margin = 0;
 		if (p < margin)
 			p = 0;
 		if (p > st - margin)



bye,

Egmont
