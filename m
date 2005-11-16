Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161029AbVKPXwf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161029AbVKPXwf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 18:52:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161030AbVKPXwf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 18:52:35 -0500
Received: from mailfe04.tele2.fr ([212.247.154.108]:7379 "EHLO swip.net")
	by vger.kernel.org with ESMTP id S1161029AbVKPXwe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 18:52:34 -0500
X-T2-Posting-ID: dCnToGxhL58ot4EWY8b+QGwMembwLoz1X2yB7MdtIiA=
Date: Thu, 17 Nov 2005 00:52:16 +0100
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
To: Jason Dravet <dravet@hotmail.com>
Cc: 7eggert@gmx.de, adaplas@gmail.com, torvalds@osdl.org, akpm@osdl.org,
       davej@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vgacon: Workaround for resize bug in some chipsets
Message-ID: <20051116235216.GB7573@bouh.residence.ens-lyon.fr>
Mail-Followup-To: Samuel Thibault <samuel.thibault@ens-lyon.org>,
	Jason Dravet <dravet@hotmail.com>, 7eggert@gmx.de,
	adaplas@gmail.com, torvalds@osdl.org, akpm@osdl.org,
	davej@redhat.com, linux-kernel@vger.kernel.org
References: <BAY103-F17B16A3E9D5B3E06ACB57CDF5C0@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BAY103-F17B16A3E9D5B3E06ACB57CDF5C0@phx.gbl>
User-Agent: Mutt/1.5.9i-nntp
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The following patch should correct the issue:

When doublescan mode is in use, scanlines must be doubled.

Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>

--- drivers/video/console/vgacon.c.orig	2005-11-17 00:40:02.000000000 +0100
+++ drivers/video/console/vgacon.c	2005-11-17 00:42:27.000000000 +0100
@@ -502,10 +502,16 @@
 {
 	unsigned long flags;
 	unsigned int scanlines = height * c->vc_font.height;
-	u8 scanlines_lo, r7, vsync_end, mode;
+	u8 scanlines_lo, r7, vsync_end, mode, max_scan;
 
 	spin_lock_irqsave(&vga_lock, flags);
 
+	outb_p(VGA_CRTC_MAX_SCAN, vga_video_port_reg);
+	max_scan = inb_p(vga_video_port_val);
+
+	if (max_scan & 0x80)
+		scanlines <<= 1;
+
 	outb_p(VGA_CRTC_MODE, vga_video_port_reg);
 	mode = inb_p(vga_video_port_val);
 
