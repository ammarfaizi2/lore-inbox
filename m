Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130008AbRABN5Y>; Tue, 2 Jan 2001 08:57:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130336AbRABN5E>; Tue, 2 Jan 2001 08:57:04 -0500
Received: from hood.tvd.be ([195.162.196.21]:49118 "EHLO hood.tvd.be")
	by vger.kernel.org with ESMTP id <S130008AbRABN4z>;
	Tue, 2 Jan 2001 08:56:55 -0500
Date: Tue, 2 Jan 2001 14:25:58 +0100 (CET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
        Linux Frame Buffer Device Development 
	<linux-fbdev@vuser.vu.union.edu>
Subject: Re: Linux 2.4.0-prerelease-ac1
In-Reply-To: <E14CtEH-0000Iq-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.05.10101021420390.611-100000@callisto.of.borg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 1 Jan 2001, Alan Cox wrote:
> 2.4.0test13pre7-ac1
> o	Update logo palette handling			(Geert Uytterhoeven)

I forgot to fix one case: for DIRECTCOLOR visuals with 15 <= depth <= 23, the
pixel values no longer have to be offset by 16 since we use colors 0-15 now.
In addition it should work for depths starting at 12 now as well.

I'll send the full patch (including this fix) to Linus.

--- logo16-2.4.0-current/drivers/video/fbcon.c.orig	Mon Jan  1 23:35:27 2001
+++ logo16-2.4.0-current/drivers/video/fbcon.c	Tue Jan  2 13:42:14 2001
@@ -2143,15 +2143,15 @@
 		    }
 		}
 	    }
-	    else if (depth >= 15 && depth <= 23) {
-	        /* have 5..7 bits per color, using 16 color image */
+	    else if (depth >= 12 && depth <= 23) {
+	        /* have 4..7 bits per color, using 16 color image */
 		unsigned int pix;
 		src = linux_logo16;
 		bdepth = (depth+7)/8;
 		for( y1 = 0; y1 < LOGO_H; y1++ ) {
 		    dst = fb + y1*line + x*bdepth;
 		    for( x1 = 0; x1 < LOGO_W/2; x1++, src++ ) {
-			pix = (*src >> 4) | 0x10; /* upper nibble */
+			pix = *src >> 4; /* upper nibble */
 			val = (pix << redshift) |
 			      (pix << greenshift) |
 			      (pix << blueshift);
@@ -2161,7 +2161,7 @@
 			for( i = bdepth-1; i >= 0; --i )
 #endif
 			    fb_writeb (val >> (i*8), dst++);
-			pix = (*src & 0x0f) | 0x10; /* lower nibble */
+			pix = *src & 0x0f; /* lower nibble */
 			val = (pix << redshift) |
 			      (pix << greenshift) |
 			      (pix << blueshift);

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
