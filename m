Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423183AbWKFJ1n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423183AbWKFJ1n (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Nov 2006 04:27:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423561AbWKFJ1n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Nov 2006 04:27:43 -0500
Received: from nf-out-0910.google.com ([64.233.182.190]:31314 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1423183AbWKFJ1m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Nov 2006 04:27:42 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:reply-to:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        b=JTqMRAkHrE8YgIHDlDWw/G27XVMFguG5REbfq1d6Y9mbUP0m8j4P0Xkakt0CAAKJ6oD+faWAVMDO3gbLDgD9cLHXu+TIhXalKCaUSInVpc/9gvk/A7XYcWQ9V5jQbpZQ9a9yIvjiY4LEiN36m8tBDewTxGK+E1+lNgeTVwQsZsk=
Message-ID: <454F0030.80101@innova-card.com>
Date: Mon, 06 Nov 2006 10:28:16 +0100
Reply-To: Franck <vagabon.xyz@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net,
       adaplas@pol.net, gregkh@suse.de
Subject: [PATCH] fbcon: ReRe-fix little-endian bogosity in slow_imageblit()
References: <454B5866.6000207@innova-card.com>	 <20061103105857.874f566c.akpm@osdl.org> <cda58cb80611040122w6cf42014vf17f48edda97e797@mail.gmail.com>
In-Reply-To: <cda58cb80611040122w6cf42014vf17f48edda97e797@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
From: Franck Bui-Huu <vagabon.xyz@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Franck Bui-Huu <fbuihuu@gmail.com>

It seems that this piece of code has already been fixed twice...

The first fix has been made by the following commit:

	81d3e147ec9ffc6ef04b5f05afa4bef22487b32b

by introducing FB_BIT_NR() macro to fix a 'potential' endianess
bug. It appears that change was broken for big endian platforms,
but I suspect it was for little-endian ones too.

Then a second fix has been made to fix the previous change for
big-endian platform, see commit:

	a536093a2f07007aa572e922752b7491b9ea8ff2

This commit actually reverted the first fix and thus makes the
big-endian case works but leaves the little-endian case broken.
Therefore it seems that the very first state was broken only
on little-endian platform...

This patch is the third and hopefully the last attempt to fix
this bug correctly. It restores the first fix _and_ swaps the
little-endian and bit-endian implementations of FB_BIT_NR().

Now, it should work for both endianness but has been tested on
little-endian machine only.

Signed-off-by: Franck Bui-Huu <fbuihuu@gmail.com>
---

 Same patch with change log updated.

 drivers/video/cfbimgblt.c |    4 ++--
 include/linux/fb.h        |    2 ++
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/video/cfbimgblt.c b/drivers/video/cfbimgblt.c
index 51d3538..8f47bf4 100644
--- a/drivers/video/cfbimgblt.c
+++ b/drivers/video/cfbimgblt.c
@@ -168,7 +168,7 @@ static inline void slow_imageblit(const
 
 		while (j--) {
 			l--;
-			color = (*s & (1 << l)) ? fgcolor : bgcolor;
+			color = (*s & (1 << FB_BIT_NR(l))) ? fgcolor : bgcolor;
 			val |= FB_SHIFT_HIGH(color, shift);
 			
 			/* Did the bitshift spill bits to the next long? */
@@ -258,7 +258,7 @@ static inline void fast_imageblit(const
 		s += spitch;
 	}
 }	
-	
+
 void cfb_imageblit(struct fb_info *p, const struct fb_image *image)
 {
 	u32 fgcolor, bgcolor, start_index, bitstart, pitch_index = 0;
diff --git a/include/linux/fb.h b/include/linux/fb.h
index 3e69241..6ca18b8 100644
--- a/include/linux/fb.h
+++ b/include/linux/fb.h
@@ -854,10 +854,12 @@ struct fb_info {
 #endif
 
 #if defined (__BIG_ENDIAN)
+#define FB_BIT_NR(b)              (b)
 #define FB_LEFT_POS(bpp)          (32 - bpp)
 #define FB_SHIFT_HIGH(val, bits)  ((val) >> (bits))
 #define FB_SHIFT_LOW(val, bits)   ((val) << (bits))
 #else
+#define FB_BIT_NR(b)              (7 - (b))
 #define FB_LEFT_POS(bpp)          (0)
 #define FB_SHIFT_HIGH(val, bits)  ((val) << (bits))
 #define FB_SHIFT_LOW(val, bits)   ((val) >> (bits))
-- 
1.4.3.4
