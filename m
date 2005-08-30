Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932195AbVH3QM2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932195AbVH3QM2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Aug 2005 12:12:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932196AbVH3QM2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Aug 2005 12:12:28 -0400
Received: from mailout11.sul.t-online.com ([194.25.134.85]:64689 "EHLO
	mailout11.sul.t-online.com") by vger.kernel.org with ESMTP
	id S932195AbVH3QM2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Aug 2005 12:12:28 -0400
Message-ID: <43148610.70406@t-online.de>
Date: Tue, 30 Aug 2005 18:15:12 +0200
From: Knut Petersen <Knut_Petersen@t-online.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de-AT; rv:1.7.7) Gecko/20050414
X-Accept-Language: de, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: "Antonino A. Daplas" <adaplas@gmail.com>,
       linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       Jochen Hein <jochen@jochen.org>
Subject: [PATCH 1/1 2.6.13] framebuffer: bit_putcs() optimization for 8x*
 fonts
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
X-ID: JbQYSsZFYeDUcTmcVNMRCcSUcYTQoZh4ml8Pm40yD+79s3xqe25-sG@t-dialin.net
X-TOI-MSGID: 9256a54a-3c6e-441d-815c-c45815219b3f
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This trivial patch gives a performance boost to the framebuffer console

Constructing the bitmaps that are given to the bitblit functions of the 
framebuffer
drivers is time consuming. Here we avoide a call to the slow 
fb_pad_aligned_buffer().
The patch replaces that call with a simple but much more efficient 
bytewise copy.

The kernel spends a significant time at this place if you use 8x* fonts. 
Every
pixel displayed on your screen is prepared here.

Some benchmark results:

Displaying a file of 2000 lines with 160 characters each takes 889 ms 
system
time using  cyblafb on my system  (I´m using a 1280x1024 video mode,
resulting in a 160x64 character console)

Displaying the same file with the enclosed patch applied to 2.6.13 only 
takes
760 ms system time, saving 129 ms or 14.5%.

Font widths other than 8 are not affected.

The advantage and correctness of this patch should be obvious.

Signed-off-by: Knut Petersen <Knut_Petersen@t-online.de>

diff -uprN -X linux/Documentation/dontdiff -x '*.bak' -x '*.ctx' linuxorig/drivers/video/console/bitblit.c linux/drivers/video/console/bitblit.c
--- linuxorig/drivers/video/console/bitblit.c	2005-08-29 01:41:01.000000000 +0200
+++ linux/drivers/video/console/bitblit.c	2005-08-30 17:19:57.000000000 +0200
@@ -114,7 +114,7 @@ static void bit_putcs(struct vc_data *vc
 	unsigned int scan_align = info->pixmap.scan_align - 1;
 	unsigned int buf_align = info->pixmap.buf_align - 1;
 	unsigned int shift_low = 0, mod = vc->vc_font.width % 8;
-	unsigned int shift_high = 8, pitch, cnt, size, k;
+	unsigned int shift_high = 8, pitch, cnt, size, i, k;
 	unsigned int idx = vc->vc_font.width >> 3;
 	unsigned int attribute = get_attribute(info, scr_readw(s));
 	struct fb_image image;
@@ -175,7 +175,11 @@ static void bit_putcs(struct vc_data *vc
 					src = buf;
 				}
 
-				fb_pad_aligned_buffer(dst, pitch, src, idx, image.height);
+				if (idx == 1)
+					for(i=0; i < image.height; i++)
+						dst[pitch*i] = src[i];
+				else
+					fb_pad_aligned_buffer(dst, pitch, src, idx, image.height);
 				dst += width;
 			}
 		}


