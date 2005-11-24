Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932617AbVKXDJn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932617AbVKXDJn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 22:09:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932618AbVKXDJn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 22:09:43 -0500
Received: from gate.crashing.org ([63.228.1.57]:26598 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S932617AbVKXDJm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 22:09:42 -0500
Subject: Re: Console rotation problems
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: adaplas@gmail.com
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <1132796831.26560.392.camel@gaston>
References: <1132793150.26560.357.camel@gaston>
	 <1132793556.26560.361.camel@gaston>  <1132796831.26560.392.camel@gaston>
Content-Type: text/plain
Date: Thu, 24 Nov 2005 14:05:42 +1100
Message-Id: <1132801542.26560.402.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove bogus usage of test/set_bit() from fbcon rotation code and just
manipulate the bits directly. This fixes an oops on powerpc among others
and should be faster. Seems to work fine on the G5 here.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

And here is the fix. Tony, did I miss something ?

Index: linux-serialfix/drivers/video/console/fbcon_rotate.h
===================================================================
--- linux-serialfix.orig/drivers/video/console/fbcon_rotate.h	2005-11-23 11:07:23.000000000 +1100
+++ linux-serialfix/drivers/video/console/fbcon_rotate.h	2005-11-24 14:02:22.000000000 +1100
@@ -21,21 +21,13 @@
         (s == SCROLL_REDRAW || s == SCROLL_MOVE || !(i)->fix.xpanstep) ? \
         (i)->var.xres : (i)->var.xres_virtual; })
 
-/*
- * The bitmap is always big endian
- */
-#if defined(__LITTLE_ENDIAN)
-#define FBCON_BIT(b) (7 - (b))
-#else
-#define FBCON_BIT(b) (b)
-#endif
 
 static inline int pattern_test_bit(u32 x, u32 y, u32 pitch, const char *pat)
 {
 	u32 tmp = (y * pitch) + x, index = tmp / 8,  bit = tmp % 8;
 
 	pat +=index;
-	return (test_bit(FBCON_BIT(bit), (void *)pat));
+	return (*pat) & (0x80 >> bit);
 }
 
 static inline void pattern_set_bit(u32 x, u32 y, u32 pitch, char *pat)
@@ -43,7 +35,8 @@ static inline void pattern_set_bit(u32 x
 	u32 tmp = (y * pitch) + x, index = tmp / 8, bit = tmp % 8;
 
 	pat += index;
-	set_bit(FBCON_BIT(bit), (void *)pat);
+
+	(*pat) |= 0x80 >> bit;
 }
 
 static inline void rotate_ud(const char *in, char *out, u32 width, u32 height)
Index: linux-serialfix/drivers/video/console/fbcon_ccw.c
===================================================================
--- linux-serialfix.orig/drivers/video/console/fbcon_ccw.c	2005-11-15 11:54:14.000000000 +1100
+++ linux-serialfix/drivers/video/console/fbcon_ccw.c	2005-11-24 14:03:48.000000000 +1100
@@ -34,7 +34,7 @@ static inline void ccw_update_attr(u8 *d
 		msk <<= (8 - mod);
 
 	if (offset > mod)
-		set_bit(FBCON_BIT(7), (void *)&msk1);
+		msk1 |= 0x01;
 
 	for (i = 0; i < vc->vc_font.width; i++) {
 		for (j = 0; j < width; j++) {


