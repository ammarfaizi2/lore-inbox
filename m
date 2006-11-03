Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753255AbWKCOzD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753255AbWKCOzD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Nov 2006 09:55:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753265AbWKCOzD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Nov 2006 09:55:03 -0500
Received: from nf-out-0910.google.com ([64.233.182.186]:56693 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1753255AbWKCOzB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Nov 2006 09:55:01 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:reply-to:user-agent:mime-version:to:cc:subject:content-type:content-transfer-encoding:from;
        b=orcete6R8c4dxEwoO3Z+KZI+lWHkLTQJ4LqaE7ocmEQ1AsN6isDZfWwBT5gmj0E7xUsuXspVV5v9TKZbeWxBQQRQKoE53Crw2l33RY3KrxlZJxu9C+0vOMlbPvU7fqTSRcQYvmdC95WMYsEsicYBfc75CdeLaztyygOc7iF58Jw=
Message-ID: <454B5866.6000207@innova-card.com>
Date: Fri, 03 Nov 2006 15:55:34 +0100
Reply-To: Franck <vagabon.xyz@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net
CC: Andrew Morton <akpm@osdl.org>, adaplas@pol.net, gregkh@suse.de
Subject: [PATCH] fbcon: Re-fix little-endian bogosity in slow_imageblit()
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
From: Franck Bui-Huu <vagabon.xyz@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Franck Bui-Huu <fbuihuu@gmail.com>

This bug has been introduced by commit:

	a536093a2f07007aa572e922752b7491b9ea8ff2

This commit fixed the big-endian case but broke the little-endian one.
This patch revert the previous change and swap the definition of
FB_BIT_NR() macro between big and little endian. It should work for
both endianess now.

Signed-off-by: Franck Bui-Huu <fbuihuu@gmail.com>
---

 This is the most obvious fix for me although it's a bit weird
 that bit ordering depend on platform endianess. I don't know
 fb code so I prefer submitting this trivial fix rather than
 breaking every thing else ;)

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
@@ -854,10 +854,12 @@ #define fb_memset memset
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
1.4.3.2

