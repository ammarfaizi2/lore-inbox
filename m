Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964779AbVHaMnp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964779AbVHaMnp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Aug 2005 08:43:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964781AbVHaMnp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Aug 2005 08:43:45 -0400
Received: from mailout08.sul.t-online.com ([194.25.134.20]:40873 "EHLO
	mailout08.sul.t-online.com") by vger.kernel.org with ESMTP
	id S964779AbVHaMno (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Aug 2005 08:43:44 -0400
Message-ID: <4315A6AB.5090108@t-online.de>
Date: Wed, 31 Aug 2005 14:46:35 +0200
From: Knut Petersen <Knut_Petersen@t-online.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de-AT; rv:1.7.7) Gecko/20050414
X-Accept-Language: de, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Roman Zippel <zippel@linux-m68k.org>,
       linux-fbdev-devel@lists.sourceforge.net,
       "Antonino A. Daplas" <adaplas@gmail.com>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Jochen Hein <jochen@jochen.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [Linux-fbdev-devel] [PATCH 1/1 2.6.13] framebuffer: bit_putcs()
 optimization for 8x* fonts
References: <43148610.70406@t-online.de> <Pine.LNX.4.62.0508301814470.6045@numbat.sonytel.be> <43149E5B.7040006@t-online.de> <Pine.LNX.4.61.0508302039160.3743@scrub.home> <4314DD2E.7060901@t-online.de> <Pine.LNX.4.61.0508310159290.3728@scrub.home>
In-Reply-To: <Pine.LNX.4.61.0508310159290.3728@scrub.home>
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
X-ID: r1nJcwZLQefk4mlst25LyUti4CZcuSF16fi3jkRKsDl7p7I41e1R4n@t-dialin.net
X-TOI-MSGID: 45818708-13f4-42c1-b0ec-d20e6da22fda
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>Something like below, which has the advantange that there is still only 
>one implementation of the function
>
True, that´s a great advantage.

> and if it's still slower, we really need to check the compiler
>  
>
Please have a look at the following patch. It takes your idea of 
inlining but moves
the special cases into the macro, speeding things up for the very likely 
case of
s_pitch == 1 and the less likely case of s_pitch of 2. Treating s_pitch 
== 2 special
gives a still significant performance improvement of more than 10 % for 
16x30
fonts.

This way also bit_putcs looks better again ...

Andrew, as this way is better than and still as fast as my first 
approach I think
framebuffer-bit_putcs-optimization-for-8x.patch should be reverted and the
following patch should be applied instead.

Antonino, Roman, Geert, do you agree?


cu,
 knut

diff -uprN -X linux/Documentation/dontdiff -x '*.bak' -x '*.ctx' linuxorig/drivers/video/console/bitblit.c linux/drivers/video/console/bitblit.c
--- linuxorig/drivers/video/console/bitblit.c	2005-08-29 01:41:01.000000000 +0200
+++ linux/drivers/video/console/bitblit.c	2005-08-31 10:06:22.000000000 +0200
@@ -175,7 +175,7 @@ static void bit_putcs(struct vc_data *vc
 					src = buf;
 				}
 
-				fb_pad_aligned_buffer(dst, pitch, src, idx, image.height);
+				__fb_pad_aligned_buffer(dst, pitch, src, idx, image.height);
 				dst += width;
 			}
 		}
diff -uprN -X linux/Documentation/dontdiff -x '*.bak' -x '*.ctx' linuxorig/drivers/video/fbmem.c linux/drivers/video/fbmem.c
--- linuxorig/drivers/video/fbmem.c	2005-08-29 01:41:01.000000000 +0200
+++ linux/drivers/video/fbmem.c	2005-08-31 13:36:16.000000000 +0200
@@ -80,15 +80,7 @@ EXPORT_SYMBOL(fb_get_color_depth);
  */
 void fb_pad_aligned_buffer(u8 *dst, u32 d_pitch, u8 *src, u32 s_pitch, u32 height)
 {
-	int i, j;
-
-	for (i = height; i--; ) {
-		/* s_pitch is a few bytes at the most, memcpy is suboptimal */
-		for (j = 0; j < s_pitch; j++)
-			dst[j] = src[j];
-		src += s_pitch;
-		dst += d_pitch;
-	}
+	__fb_pad_aligned_buffer(dst, d_pitch, src, s_pitch, height);
 }
 EXPORT_SYMBOL(fb_pad_aligned_buffer);
 
diff -uprN -X linux/Documentation/dontdiff -x '*.bak' -x '*.ctx' linuxorig/include/linux/fb.h linux/include/linux/fb.h
--- linuxorig/include/linux/fb.h	2005-08-29 01:41:01.000000000 +0200
+++ linux/include/linux/fb.h	2005-08-31 12:45:08.000000000 +0200
@@ -824,6 +824,38 @@ extern int fb_get_color_depth(struct fb_
 extern int fb_get_options(char *name, char **option);
 extern int fb_new_modelist(struct fb_info *info);
 
+
+/*
+ * Don't change without testing performance of framebuffer
+ * bitblitting. Inlining is necessary for performance reasons.
+ * Although the code might not _look_ fast because of some
+ * multiplications, it really _is_ fast as it is easier for gcc
+ * to optimize well.
+ */
+
+static inline void __fb_pad_aligned_buffer(u8 *dst, u32 d_pitch, u8 *src, 
+						u32 s_pitch, u32 height)
+{
+	int i, j;
+
+	if (likely(s_pitch==1))
+		for(i=0; i < height; i++)
+			dst[d_pitch*i] = src[i];
+	else if (s_pitch==2)
+		for(i=0; i < height; i++) {
+			*(u16 *)dst = ((u16 *)src)[i];
+			dst += d_pitch;
+		}
+	else {
+		d_pitch -= s_pitch;
+		for (i = height; i--; ) {
+			for (j = 0; j < s_pitch; j++)
+				*dst++ = *src++;
+			dst += d_pitch;
+		}
+	}
+}
+
 extern struct fb_info *registered_fb[FB_MAX];
 extern int num_registered_fb;
 




