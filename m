Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932114AbVKEV0S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932114AbVKEV0S (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Nov 2005 16:26:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751068AbVKEV0S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Nov 2005 16:26:18 -0500
Received: from mailfe04.tele2.fr ([212.247.154.108]:44935 "EHLO swip.net")
	by vger.kernel.org with ESMTP id S1751065AbVKEV0R (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Nov 2005 16:26:17 -0500
X-T2-Posting-ID: dCnToGxhL58ot4EWY8b+QGwMembwLoz1X2yB7MdtIiA=
Date: Sat, 5 Nov 2005 22:26:07 +0100
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
To: linux-kernel@vger.kernel.org, marcelo.tosatti@cyclades.com
Cc: mlang@debian.org
Subject: [PATCH 2.4] Set the vga cursor even when hidden
Message-ID: <20051105212607.GN7383@bouh.residence.ens-lyon.fr>
Mail-Followup-To: Samuel Thibault <samuel.thibault@ens-lyon.org>,
	linux-kernel@vger.kernel.org, marcelo.tosatti@cyclades.com,
	mlang@debian.org
References: <20051105211949.GM7383@bouh.residence.ens-lyon.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051105211949.GM7383@bouh.residence.ens-lyon.fr>
User-Agent: Mutt/1.5.9i-nntp
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Some visually impaired people use hardware devices which directly read
the vga screen. When newt for instance asks to hide the cursor for
better visual aspect, the kernel puts the vga cursor out of the screen,
so that the cursor position can't be read by the hardware device. This
is a great loss for such people.

Here is a patch which uses the same technique as CUR_NONE for hiding the
cursor while still moving it.

Mario, you should apply it to the speakup kernel for access floppies
asap.

--- linux-2.4.31/drivers/video/vgacon.c.orig	2002-08-03 02:39:45.000000000 +0200
+++ linux-2.4.31/drivers/video/vgacon.c	2005-11-05 22:22:12.000000000 +0100
@@ -432,7 +432,8 @@ static void vgacon_cursor(struct vc_data
 	vgacon_scrolldelta(c, 0);
     switch (mode) {
 	case CM_ERASE:
-	    write_vga(14, (vga_vram_end - vga_vram_base - 1)/2);
+	    write_vga(14, (c->vc_pos-vga_vram_base)/2);
+	    vgacon_set_cursor_size(c->vc_x, 31, 30);
 	    break;
 
 	case CM_MOVE:
