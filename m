Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262210AbULMGsh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262210AbULMGsh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Dec 2004 01:48:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262212AbULMGse
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Dec 2004 01:48:34 -0500
Received: from sccrmhc12.comcast.net ([204.127.202.56]:25068 "EHLO
	sccrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S262210AbULMGsX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Dec 2004 01:48:23 -0500
Subject: [PATCH] Re: Improved console UTF-8 support for the Linux kernel?
From: Chris Heath <chris@heathens.co.nz>
To: aeb@cwi.nl
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1102920623.30543.1820.camel@linux.heathens.co.nz>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 13 Dec 2004 01:50:24 -0500
Content-Transfer-Encoding: 7bit
X-Antirelay: Good relay from local net4 192.168.0.0/16
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is the patch that makes compose keys work.  I consider it a hack...
but it's simple and effective enough that it may be worth including. 
It's a hack because:

* Compose keys are still stored as 8-bit chars internally, but get
converted to UTF-8 as they are output.  Therefore you are still
restricted to a single 8-bit character set.

* Logically, keyboard input and console display are separated in the
kernel. When you switch in and out of Unicode mode you have to switch
both the keyboard and the display separately.  However, this patch
intertwines the two because it does its 8-bit to Unicode conversion
using a table that is designed for use by the display module.  (When the
display is in Unicode mode, this conversion table is unused, so why not
use it for the keyboard module?)

As you have already figured out, Suse is using this patch in their
distribution, so I figure it has had pretty wide testing already.

I have a couple of other patches on my website, which I am happy to
submit (or you are welcome to take), but this is the simplest and the
most popular.

Chris


--- a/include/linux/consolemap.h	2003-08-03 21:10:43.000000000 -0400
+++ b/include/linux/consolemap.h	2003-08-02 10:55:33.000000000 -0400
@@ -13,3 +13,4 @@
 extern unsigned char inverse_translate(struct vc_data *conp, int
glyph);
 extern unsigned short *set_translate(int m,int currcons);
 extern int conv_uni_to_pc(struct vc_data *conp, long ucs);
+extern u32 conv_8bit_to_uni(unsigned char c);
--- a/drivers/char/consolemap.c	2003-08-03 21:10:43.000000000 -0400
+++ b/drivers/char/consolemap.c	2003-08-02 10:52:55.000000000 -0400
@@ -633,6 +633,19 @@
 	if (p) p->readonly = rdonly;
 }
 
+/* may be called during an interrupt */
+u32 conv_8bit_to_uni(unsigned char c)
+{
+	/* 
+	 * Always use USER_MAP. This function is used by the keyboard,
+	 * which shouldn't be affected by G0/G1 switching, etc.
+	 * If the user map still contains default values, i.e. the 
+	 * direct-to-font mapping, then assume user is using Latin1.
+	 */
+	unsigned short uni = translations[USER_MAP][c];
+	return uni == (0xf000 | c) ? c : uni;
+}
+
 int
 conv_uni_to_pc(struct vc_data *conp, long ucs) 
 {
--- a/drivers/char/keyboard.c	2003-08-03 21:10:43.000000000 -0400
+++ b/drivers/char/keyboard.c	2003-08-02 10:58:49.000000000 -0400
@@ -35,6 +35,7 @@
 #include <linux/init.h>
 #include <linux/slab.h>
 
+#include <linux/consolemap.h>
 #include <linux/kbd_kern.h>
 #include <linux/kbd_diacr.h>
 #include <linux/vt_kern.h>
@@ -347,6 +348,15 @@
     	}
 }
 
+static void put_8bit(struct vc_data *vc, u8 c)
+{
+	if (kbd->kbdmode != VC_UNICODE || c < 32 || c == 127) 
+		/* Don't translate control chars */
+		put_queue(vc, c);
+	else
+		to_utf8(vc, conv_8bit_to_uni(c));
+}
+
 /* 
  * Called after returning from RAW mode or when changing consoles -
recompute
  * shift_down[] and shift_state from key_down[] maybe called when
keymap is
@@ -407,7 +417,7 @@
 	if (ch == ' ' || ch == d)
 		return d;
 
-	put_queue(vc, d);
+	put_8bit(vc, d);
 	return ch;
 }
 
@@ -417,7 +427,7 @@
 static void fn_enter(struct vc_data *vc, struct pt_regs *regs)
 {
 	if (diacr) {
-		put_queue(vc, diacr);
+		put_8bit(vc, diacr);
 		diacr = 0;
 	}
 	put_queue(vc, 13);
@@ -626,7 +636,7 @@
 		diacr = value;
 		return;
 	}
-	put_queue(vc, value);
+	put_8bit(vc, value);
 }
 
 /*


