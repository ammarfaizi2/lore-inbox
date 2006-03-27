Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751228AbWC0BUn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751228AbWC0BUn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Mar 2006 20:20:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751242AbWC0BUm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Mar 2006 20:20:42 -0500
Received: from pproxy.gmail.com ([64.233.166.178]:10142 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751228AbWC0BUm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Mar 2006 20:20:42 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=KufZVuLmI9YN4v31kSgC0Z1shgHMl8Xkhj8VsOeaj9xfV8VGzOdL3mTk4fnXyyD3HS9h9mxRSF1BJ7hqSKHUz92lOuzCsfsmA4o94DYeGHVwl8IsvJyshsLOqBTyaEX8IeIEHzRQi6GKFUeGcHXfwxlu8SqnTwM7zWrQOA0LsCY=
Message-ID: <44273DBB.9070207@gmail.com>
Date: Mon, 27 Mar 2006 09:19:55 +0800
From: "Antonino A. Daplas" <adaplas@gmail.com>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       linux-fbdev-devel@lists.sourceforge.net,
       Linux Kernel ML <linux-kernel@vger.kernel.org>
Subject: Re: funny framebuffer fonts on PowerBook with radeonfb
References: <20060327004741.GA19187@MAIL.13thfloor.at>
In-Reply-To: <20060327004741.GA19187@MAIL.13thfloor.at>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Herbert Poetzl wrote:
> Hey Ben!
> 
> 2.6.16 and 2.6.15-something show a funny behaviour
> when using the radeonfb driver (for text mode), they
> kind of twist and break the fonts in various places
> some characters or parts seem to be mirrored like
> '[' becoming ']' but not on character boundary but
> more on N pixels, colors seem to be correct for the
> characters, and sometimes the font is perfectly fine
> for larger runs, e.g. I can read the logon prompt
> fine, but everything I type is garbled ...
> 
> just for an example, when I type 'echo "Test"' then
> all characters are mirrored and cut off on the right
> side but the locations are as shown above, on enter
> the T is only a few pixels wide, but the est part is
> written perfectly fine ... this is a new behaviour
> and going back to 2.6.13.3 doesn't show this ...
> 
> if there is some testing I can do for you, or when
> you need more info, please let me know. here a few
> details for the machine:
> 

What font are you using? I presume the dimensions are
not divisible by 8.  Can you try this patch?

Tony

diff --git a/drivers/video/cfbimgblt.c b/drivers/video/cfbimgblt.c
index 910e233..8ba6152 100644
--- a/drivers/video/cfbimgblt.c
+++ b/drivers/video/cfbimgblt.c
@@ -169,7 +169,7 @@ static inline void slow_imageblit(const 
 
 		while (j--) {
 			l--;
-			color = (*s & 1 << (FB_BIT_NR(l))) ? fgcolor : bgcolor;
+			color = (*s & (1 << l)) ? fgcolor : bgcolor;
 			val |= FB_SHIFT_HIGH(color, shift);
 			
 			/* Did the bitshift spill bits to the next long? */
diff --git a/include/linux/fb.h b/include/linux/fb.h
index 17fc771..4fe1d2d 100644
--- a/include/linux/fb.h
+++ b/include/linux/fb.h
@@ -841,12 +841,10 @@ struct fb_info {
 #define FB_LEFT_POS(bpp)          (32 - bpp)
 #define FB_SHIFT_HIGH(val, bits)  ((val) >> (bits))
 #define FB_SHIFT_LOW(val, bits)   ((val) << (bits))
-#define FB_BIT_NR(b)              (7 - (b))
 #else
 #define FB_LEFT_POS(bpp)          (0)
 #define FB_SHIFT_HIGH(val, bits)  ((val) << (bits))
 #define FB_SHIFT_LOW(val, bits)   ((val) >> (bits))
-#define FB_BIT_NR(b)              (b)
 #endif
 
     /*
