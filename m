Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264001AbRFDKzG>; Mon, 4 Jun 2001 06:55:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264185AbRFDK1o>; Mon, 4 Jun 2001 06:27:44 -0400
Received: from uvo1-93.univie.ac.at ([131.130.231.93]:10882 "EHLO server.lan")
	by vger.kernel.org with ESMTP id <S264183AbRFDK12>;
	Mon, 4 Jun 2001 06:27:28 -0400
From: Melchior FRANZ <a8603365@unet.univie.ac.at>
Message-Id: <200106041121.22749@pflug3.gphy.univie.ac.at>
To: linux-kernel@vger.kernel.org
Subject: PATCH: tdfxfb: bugfix & enable SUN12x22 font,  kernel 2.4.5
Date: Mon, 4 Jun 2001 12:26:25 +0200
X-Mailer: KMail [version 1.2.2]
Cc: linux-fbdev@vuser.vu.union.edu, Hannu MALLAT <hmallat@cc.hut.fi>
X-PGP: http://www.unet.univie.ac.at/~a8603365/melchior.franz
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_1CIE8ROK0CDEJJJ0S9A9"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_1CIE8ROK0CDEJJJ0S9A9
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit

Hi,

I'm running a Voodoo3-3000 with the tdfxfb and the SUN12x22 font since several
months now (using "video=tdfx:1280x1024-8,nomtrr,font:SUN12x22"). The tdfx
framebuffer officially supports just 8 pixels wide fonts and issues some
"No support for fontwidth 12" error messages, but apart from that it works
almost seamlessly. Using a font wider than 8 pixels uncovers a bug, though:
The cursor appears as follows:

   ###      ###
    ##     ###
    ###    ###
    ###    ###
    ###    ###
    # ##  # ##
    # ##  # ##
    # ##  # ##
    #  ## # ##
    #  ###  ##
    #  ###  ##
    #   #   ##
    #   #   ##
   ###  #  ####
              
              
   ########    ####
   ########    ####

It is 16 pixels wide and has a 4 pixels wide gap. Although I had no access to
3dfx specs, I'm quite sure that the problem is the following:
tdfxfb_createcursor() creates the cursor pattern (xline) beginning with the
LSB: 0x000000ff for a 8 bit font and 0x00000fff for the 12 bit font. This
pattern is now shuffled to little-endian order: 0xff000000 for 8 bit and
0xff0f0000 for 12 bit. The 8 bit pattern is by fortune exactly what the
3dfx-card expects: a pattern beginning at the MSB, so this bug wasn't obvious.
The 12 bit pattern, however, is broken and explains the above illustrated
outcome.

The attached patch fixes that bug and enables 8--12 bit wide fonts, thus
disabling the "No support ..." messages. I haven't found an indication that
there are any Voodoo3/Banshee cards for big endian machines. The bugfix implies
that they never could have worked. (But if they have indeed, they would be
broken after applying the patch. Could someone comment on this, please?)

I have written two emails to the author (Hannu MALLAT) but got no response.
http://www.linux-fbdev.org/ and http://www.hut.fi/~hmallat/linux/3dfx.html
don't seem to be very active since more than a year. So I'm trying my luck
here.  :-)

m.

--------------Boundary-00=_1CIE8ROK0CDEJJJ0S9A9
Content-Type: text/plain;
  charset="iso-8859-1";
  name="tdfxfb.diff"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment; filename="tdfxfb.diff"

--- linux-2.4.5/drivers/video/tdfxfb.c	Sun Jun  3 17:13:30 2001
+++ linux/drivers/video/tdfxfb.c	Sun Jun  3 20:04:42 2001
@@ -1207,7 +1207,7 @@
    revc:		tdfx_cfbX_revc,   
    cursor:		tdfx_cfbX_cursor, 
    clear_margins:	tdfx_cfbX_clear_margins,
-   fontwidthmask:	FONTWIDTH(8)
+   fontwidthmask:	FONTWIDTHRANGE(8, 12)
 };
 #endif
 #ifdef FBCON_HAS_CFB16
@@ -1220,7 +1220,7 @@
    revc:		tdfx_cfbX_revc, 
    cursor:		tdfx_cfbX_cursor, 
    clear_margins:	tdfx_cfbX_clear_margins,
-   fontwidthmask:	FONTWIDTH(8)
+   fontwidthmask:	FONTWIDTHRANGE(8, 12)
 };
 #endif
 #ifdef FBCON_HAS_CFB24
@@ -1233,7 +1233,7 @@
    revc:		tdfx_cfbX_revc, 
    cursor:		tdfx_cfbX_cursor, 
    clear_margins:	tdfx_cfbX_clear_margins,
-   fontwidthmask:	FONTWIDTH(8)
+   fontwidthmask:	FONTWIDTHRANGE(8, 12)
 };
 #endif
 #ifdef FBCON_HAS_CFB32
@@ -1246,7 +1246,7 @@
    revc:		tdfx_cfbX_revc, 
    cursor:		tdfx_cfbX_cursor, 
    clear_margins:	tdfx_cfbX_clear_margins,
-   fontwidthmask:	FONTWIDTH(8)
+   fontwidthmask:	FONTWIDTHRANGE(8, 12)
 };
 #endif
 
@@ -2314,7 +2314,12 @@
    unsigned int h,to;
 
    tdfxfb_createcursorshape(p);
-   xline = (1 << fb_info.cursor.w)-1;
+   xline = ~((1 << (32 - fb_info.cursor.w)) - 1);
+
+#ifdef __LITTLE_ENDIAN
+   xline = swab32(xline);
+#endif
+
    cursorbase=(u8*)fb_info.bufbase_virt;
    h=fb_info.cursor.cursorimage;     
    

--------------Boundary-00=_1CIE8ROK0CDEJJJ0S9A9
Content-Type: text/plain;
  charset="iso-8859-1";
  name="README"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment; filename="README"

tdfxfb.c: fix cursor bug; enable 12x22 fonts  -- Melchior FRANZ <a8603365@unet.univie.ac.at>

--------------Boundary-00=_1CIE8ROK0CDEJJJ0S9A9--
