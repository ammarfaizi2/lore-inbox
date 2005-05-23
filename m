Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261223AbVEWXbG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261223AbVEWXbG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 May 2005 19:31:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261171AbVEWX2n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 May 2005 19:28:43 -0400
Received: from fire.osdl.org ([65.172.181.4]:4741 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261223AbVEWXWy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 May 2005 19:22:54 -0400
Date: Mon, 23 May 2005 16:22:07 -0700
From: Chris Wright <chrisw@osdl.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Chuck Wolber <chuckw@quantumlinux.com>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk, p2@mind.be,
       vandrove@vc.cvut.cz, dsd@gentoo.org
Subject: [patch 06/16] Fix matroxfb on big-endian hardware
Message-ID: <20050523232207.GR27549@shell0.pdx.osdl.net>
References: <20050523231529.GL27549@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050523231529.GL27549@shell0.pdx.osdl.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There was too much/too few byteswapping done by driver and hardware in
matroxfb on big endian hardware.  Change fixes mirrored/split/corrupted
letters seen on screen when using accelerated matroxfb mode.

Patch was tested on Mips (by Peter) and x86-64 (by Petr).

Signed-off-by: Peter 'p2' De Schrijver <p2@mind.be>
Signed-off-by: Petr Vandrovec <vandrove@vc.cvut.cz>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Linus Torvalds <torvalds@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 drivers/video/matrox/matroxfb_accel.c |   14 +++++++++++---
 drivers/video/matrox/matroxfb_base.h  |    4 ++--
 2 files changed, 13 insertions(+), 5 deletions(-)

--- linux-2.6.11.10.orig/drivers/video/matrox/matroxfb_accel.c	2005-05-16 10:50:40.000000000 -0700
+++ linux-2.6.11.10/drivers/video/matrox/matroxfb_accel.c	2005-05-20 09:36:29.666663808 -0700
@@ -438,13 +438,21 @@
 		} else if (step == 1) {
 			/* Special case for 1..8bit widths */
 			while (height--) {
-				mga_writel(mmio, 0, *chardata);
+#if defined(__BIG_ENDIAN)
+				fb_writel((*chardata) << 24, mmio.vaddr);
+#else
+				fb_writel(*chardata, mmio.vaddr);
+#endif
 				chardata++;
 			}
 		} else if (step == 2) {
 			/* Special case for 9..15bit widths */
 			while (height--) {
-				mga_writel(mmio, 0, *(u_int16_t*)chardata);
+#if defined(__BIG_ENDIAN)
+				fb_writel((*(u_int16_t*)chardata) << 16, mmio.vaddr);
+#else
+				fb_writel(*(u_int16_t*)chardata, mmio.vaddr);
+#endif
 				chardata += 2;
 			}
 		} else {
@@ -454,7 +462,7 @@
 				
 				for (i = 0; i < step; i += 4) {
 					/* Hope that there are at least three readable bytes beyond the end of bitmap */
-					mga_writel(mmio, 0, get_unaligned((u_int32_t*)(chardata + i)));
+					fb_writel(get_unaligned((u_int32_t*)(chardata + i)),mmio.vaddr);
 				}
 				chardata += step;
 			}
--- linux-2.6.11.10.orig/drivers/video/matrox/matroxfb_base.h	2005-05-16 10:50:40.000000000 -0700
+++ linux-2.6.11.10/drivers/video/matrox/matroxfb_base.h	2005-05-20 09:36:29.680661680 -0700
@@ -170,14 +170,14 @@
 
 	if ((unsigned long)src & 3) {
 		while (len >= 4) {
-			writel(get_unaligned((u32 *)src), addr);
+			fb_writel(get_unaligned((u32 *)src), addr);
 			addr++;
 			len -= 4;
 			src += 4;
 		}
 	} else {
 		while (len >= 4) {
-			writel(*(u32 *)src, addr);
+			fb_writel(*(u32 *)src, addr);
 			addr++;
 			len -= 4;
 			src += 4;
