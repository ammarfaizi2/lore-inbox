Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131050AbRAZOeM>; Fri, 26 Jan 2001 09:34:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131155AbRAZOeD>; Fri, 26 Jan 2001 09:34:03 -0500
Received: from zikova.cvut.cz ([147.32.235.100]:65292 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S131050AbRAZOdp>;
	Fri, 26 Jan 2001 09:33:45 -0500
Date: Fri, 26 Jan 2001 15:32:47 +0100
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: bero@redhat.de
Cc: alan@lxorguk.ukuu.org.uk, torvalds@transmeta.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH] Re: MatroxFB support can't be compiled into kernel
Message-ID: <20010126153247.A24714@vana.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 26 Jan 01 at 14:29, Bernhard Rosenkraenzer wrote:
> 
> Subject says it all - works as a module, but can't be compiled into the
> kernel because of duplicate definitions, caused by several files including
> matroxfb_base.h which in turn defines global_disp.
> 
> Patch attached.

Oops. I did not tried matroxfb without multihead for so long... But...
Should not (1) compiler optimize them out, as global_disp is used only
by matroxfb_base.c and (2) linker merge them together? I was under
impression that kernel uses common storage for uninitialized variables...
I'm sure that it worked sometime in the past...

Anyway, I preffer patch bellow, as global_disp is used only by 
matroxfb_base.c, and only if CONFIG_FB_MATROX_MULTIHEAD is not set... 

Linus, original complaint was against 2.4.0-ac11 - I do not know, whether
Alan uses some new linker scripts or what's going on. In any case, can you
apply this too? There is no reason why matrox's 'global_disp' should polute
global namespace.
                                                Best regards,
                                                    Petr Vandrovec
                                                    vandrove@vc.cvut.cz
                                                    

diff -urN linux/drivers/video/matrox/matroxfb_base.c linux/drivers/video/matrox/matroxfb_base.c
--- linux/drivers/video/matrox/matroxfb_base.c	Fri Dec 29 23:07:23 2000
+++ linux/drivers/video/matrox/matroxfb_base.c	Fri Jan 26 15:23:46 2001
@@ -2005,6 +2005,7 @@
 	u_int32_t cmd;
 #ifndef CONFIG_FB_MATROX_MULTIHEAD
 	static int registered = 0;
+	static struct display global_disp;
 #endif
 	DBG("matroxfb_probe")
 
diff -urN linux/drivers/video/matrox/matroxfb_base.h linux/drivers/video/matrox/matroxfb_base.h
--- linux/drivers/video/matrox/matroxfb_base.h	Fri Dec 29 23:07:23 2000
+++ linux/drivers/video/matrox/matroxfb_base.h	Fri Jan 26 15:22:53 2001
@@ -589,7 +589,6 @@
 #else
 
 extern struct matrox_fb_info matroxfb_global_mxinfo;
-struct display global_disp;
 
 #define ACCESS_FBINFO(x) (matroxfb_global_mxinfo.x)
 #define ACCESS_FBINFO2(info, x) (matroxfb_global_mxinfo.x)


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
