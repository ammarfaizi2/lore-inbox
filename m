Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267463AbUGNSuV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267463AbUGNSuV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jul 2004 14:50:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267471AbUGNSuU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jul 2004 14:50:20 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:39928 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S267463AbUGNSuB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jul 2004 14:50:01 -0400
Date: Wed, 14 Jul 2004 20:49:53 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Andrew Morton <akpm@osdl.org>, Luca Risolia <luca.risolia@studio.unibo.it>
Cc: linux-kernel@vger.kernel.org, greg@kroah.com,
       linux-usb-devel@lists.sourceforge.net
Subject: [patch] 2.6.8-rc1-mm1: USB w9968cf compile error
Message-ID: <20040714184953.GI7308@fs.tum.de>
References: <20040713182559.7534e46d.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040713182559.7534e46d.akpm@osdl.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 13, 2004 at 06:25:59PM -0700, Andrew Morton wrote:
>...
> All 252 patches:
>...
> bk-usb.patch
>...

This patch marks w9968cf_valid_depth as inline, although it's used 
before it's defined.

gcc 3.4 therefore correctly fails with:

<--  snip  -->

...
  CC      drivers/usb/media/w9968cf.o
drivers/usb/media/w9968cf.c: In function `w9968cf_set_picture':
drivers/usb/media/w9968cf.c:487: sorry, unimplemented: inlining failed 
in call to 'w9968cf_valid_depth': function body not available
drivers/usb/media/w9968cf.c:1722: sorry, unimplemented: called from here
make[3]: *** [drivers/usb/media/w9968cf.o] Error 1

<--  snip  -->


This patch moves w9968cf_valid_depth above it's first user (it also uses 
two other functions to keep the ordering of functions a bit more 
consistent).

diffstat output:
 drivers/usb/media/w9968cf.c |   92 ++++++++++++++++++------------------
 1 files changed, 46 insertions(+), 46 deletions(-)


Signed-off-by: Adrian Bunk <bunk@fs.tum.de>

--- linux-2.6.8-rc1-mm1-full-3.4/drivers/usb/media/w9968cf.c.old	2004-07-14 20:31:39.000000000 +0200
+++ linux-2.6.8-rc1-mm1-full-3.4/drivers/usb/media/w9968cf.c	2004-07-14 20:42:52.000000000 +0200
@@ -481,11 +481,11 @@
 static void w9968cf_adjust_configuration(struct w9968cf_device*);
 static int w9968cf_turn_on_led(struct w9968cf_device*);
 static int w9968cf_init_chip(struct w9968cf_device*);
-static int w9968cf_set_picture(struct w9968cf_device*, struct video_picture);
-static int w9968cf_set_window(struct w9968cf_device*, struct video_window);
 static inline u16 w9968cf_valid_palette(u16 palette);
 static inline u16 w9968cf_valid_depth(u16 palette);
 static inline u8 w9968cf_need_decompression(u16 palette);
+static int w9968cf_set_picture(struct w9968cf_device*, struct video_picture);
+static int w9968cf_set_window(struct w9968cf_device*, struct video_window);
 static int w9968cf_postprocess_frame(struct w9968cf_device*, 
                                      struct w9968cf_frame_t*);
 static int w9968cf_adjust_window_size(struct w9968cf_device*, u16* w, u16* h);
@@ -1709,6 +1709,50 @@
 
 
 /*--------------------------------------------------------------------------
+  Return non-zero if the palette is supported, 0 otherwise.
+  --------------------------------------------------------------------------*/
+static inline u16 w9968cf_valid_palette(u16 palette)
+{
+	u8 i = 0;
+	while (w9968cf_formatlist[i].palette != 0) {
+		if (palette == w9968cf_formatlist[i].palette)
+			return palette;
+		i++;
+	}
+	return 0;
+}
+
+
+/*--------------------------------------------------------------------------
+  Return the depth corresponding to the given palette.
+  Palette _must_ be supported !
+  --------------------------------------------------------------------------*/
+static inline u16 w9968cf_valid_depth(u16 palette)
+{
+	u8 i=0;
+	while (w9968cf_formatlist[i].palette != palette)
+		i++;
+
+	return w9968cf_formatlist[i].depth;
+}
+
+
+/*--------------------------------------------------------------------------
+  Return non-zero if the format requires decompression, 0 otherwise.
+  --------------------------------------------------------------------------*/
+static inline u8 w9968cf_need_decompression(u16 palette)
+{
+	u8 i = 0;
+	while (w9968cf_formatlist[i].palette != 0) {
+		if (palette == w9968cf_formatlist[i].palette)
+			return w9968cf_formatlist[i].compression;
+		i++;
+	}
+	return 0;
+}
+
+
+/*--------------------------------------------------------------------------
   Change the picture settings of the camera.
   Return 0 on success, a negative number otherwise.
   --------------------------------------------------------------------------*/
@@ -1966,50 +2010,6 @@
 }
 
 
-/*--------------------------------------------------------------------------
-  Return non-zero if the palette is supported, 0 otherwise.
-  --------------------------------------------------------------------------*/
-static inline u16 w9968cf_valid_palette(u16 palette)
-{
-	u8 i = 0;
-	while (w9968cf_formatlist[i].palette != 0) {
-		if (palette == w9968cf_formatlist[i].palette)
-			return palette;
-		i++;
-	}
-	return 0;
-}
-
-
-/*--------------------------------------------------------------------------
-  Return the depth corresponding to the given palette.
-  Palette _must_ be supported !
-  --------------------------------------------------------------------------*/
-static inline u16 w9968cf_valid_depth(u16 palette)
-{
-	u8 i=0;
-	while (w9968cf_formatlist[i].palette != palette)
-		i++;
-
-	return w9968cf_formatlist[i].depth;
-}
-
-
-/*--------------------------------------------------------------------------
-  Return non-zero if the format requires decompression, 0 otherwise.
-  --------------------------------------------------------------------------*/
-static inline u8 w9968cf_need_decompression(u16 palette)
-{
-	u8 i = 0;
-	while (w9968cf_formatlist[i].palette != 0) {
-		if (palette == w9968cf_formatlist[i].palette)
-			return w9968cf_formatlist[i].compression;
-		i++;
-	}
-	return 0;
-}
-
-
 /*-------------------------------------------------------------------------- 
   Adjust the asked values for window width and height.
   Return 0 on success, -1 otherwise.

