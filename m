Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261607AbVDNTpG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261607AbVDNTpG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Apr 2005 15:45:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261611AbVDNTpF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Apr 2005 15:45:05 -0400
Received: from mx1.redhat.com ([66.187.233.31]:29107 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261607AbVDNTof (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Apr 2005 15:44:35 -0400
Date: Thu, 14 Apr 2005 15:42:39 -0400
From: Bill Nottingham <notting@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org
Subject: [PATCH] vgacon: set vc_hi_font_mask correctly
Message-ID: <20050414194239.GA29239@nostromo.devel.redhat.com>
Mail-Followup-To: linux-kernel@vger.kernel.org, akpm@osdl.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="pWyiEgJYm5f9v55/"
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--pWyiEgJYm5f9v55/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

When allocating a new VC with vgacon_init(), the font is
shared across all the VGA consoles. However, the font
mask was always set to the default value of zero in visual_init(),
even if we were using 512 character fonts at the time.

Moreover, code in vgacon.c:vga_do_font_op() didn't reset
the mask if the console driver thinks it's already in 512 character
mode. This means that to *fix* it, you'd actually have to take
the console out of 512 character mode and then set it back.

The attached sets vc_hi_font_mask in vgacon_init() for
any new consoles opened if the vgacon driver is already
in 512 character mode, solving this.

This bug goes back to 2.4.18 at least, probably earlier.

Bill

--pWyiEgJYm5f9v55/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=diff

diff -ru linux-2.6.11-orig/drivers/video/console/vgacon.c linux-2.6.11/drivers/video/console/vgacon.c
--- linux-2.6.11-orig/drivers/video/console/vgacon.c	2005-04-08 23:52:59.000000000 -0400
+++ linux-2.6.11/drivers/video/console/vgacon.c	2005-04-14 14:54:29.000000000 -0400
@@ -337,6 +337,8 @@
 	c->vc_scan_lines = vga_scan_lines;
 	c->vc_font.height = vga_video_font_height;
 	c->vc_complement_mask = 0x7700;
+	if (vga_512_chars)
+		c->vc_hi_font_mask = 0x0800;
 	p = *c->vc_uni_pagedir_loc;
 	if (c->vc_uni_pagedir_loc == &c->vc_uni_pagedir ||
 	    !--c->vc_uni_pagedir_loc[1])

--pWyiEgJYm5f9v55/--
