Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267727AbUG3QHp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267727AbUG3QHp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jul 2004 12:07:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267730AbUG3QHp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jul 2004 12:07:45 -0400
Received: from b1.ovh.net ([213.186.33.51]:46992 "EHLO mail12.ha.ovh.net")
	by vger.kernel.org with ESMTP id S267727AbUG3QHk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jul 2004 12:07:40 -0400
Subject: Re: Compile error in 2.6.8-rc2-mm1 - rivafb related
From: Nicolas Boichat <nicolas@boichat.ch>
To: Adrian Bunk <bunk@fs.tum.de>, Andrew Morton <akpm@osdl.org>
Cc: Grega Fajdiga <Gregor.Fajdiga@guest.arnes.si>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20040730141441.GA685@fs.tum.de>
References: <1091105305.11537.6.camel@cable155-82.ljk.voljatel.net>
	 <20040730141441.GA685@fs.tum.de>
Content-Type: multipart/mixed; boundary="=-PamA2S1x2fbTyyep2LF9"
Message-Id: <1091203618.6583.7.camel@tom>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 30 Jul 2004 18:06:58 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-PamA2S1x2fbTyyep2LF9
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hello,


On Fri, 2004-07-30 at 16:14, Adrian Bunk wrote:
> On Thu, Jul 29, 2004 at 02:52:25PM +0200, Grega Fajdiga wrote:
> 
> > Good day,
> 
> Hi Grega,
> 
> > Please CC me, since I'm not subscribed. 
> > I just tried to compile 2.6.8-rc2-mm1 and got this error:
> > drivers/built-in.o(.text+0x7e369): In function `rivafb_probe'::
> > undefined reference to `riva_create_i2c_busses'
> > drivers/built-in.o(.text+0x7e4c1): In function `rivafb_probe'::
> > undefined reference to `riva_delete_i2c_busses'
> > drivers/built-in.o(.exit.text+0x1ca): In function `rivafb_remove'::
> > undefined reference to `riva_delete_i2c_busses'
> > make: *** [.tmp_vmlinux1] Error 1
> >...
> 
> thanks for this report.
> 
> @Nicolas:
> Your rivafb-i2c-fixes patch in -mm causes this with CONFIG_FB_RIVA_I2C=n 
> (it moves i2c code from inside an #ifdef CONFIG_FB_RIVA_I2C to a place 
> where it isn't guarded by such an #ifdef).

It seems that a wrong patch (an older one) has been integrated in -mm.

I attached the right patch, that I already sent on July 14.

Best regards,

Nicolas

--=-PamA2S1x2fbTyyep2LF9
Content-Disposition: attachment; filename=rivafb-i2c-bus-fix.patch
Content-Type: text/x-patch; name=rivafb-i2c-bus-fix.patch; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 7bit

From: Nicolas Boichat <nicolas@boichat.ch>

The I2C busses opened by rivafb were deleted immediately after
reading the EDID, but they should be kept open, so user-space
applications can use them.

They are now deleted when the driver is unloaded.

---

 linux/drivers/video/riva/fbdev.c |   13 +++++++++++--
 1 files changed, 11 insertions(+), 2 deletions(-)

diff -puN linux/drivers/video/riva/fbdev.c.old  linux/drivers/video/riva/fbdev.c
--- linux/drivers/video/riva/fbdev.c.old	2004-07-13 02:05:47.000000000 +0200
+++ linux/drivers/video/riva/fbdev.c	2004-07-13 23:34:27.023199272 +0200
@@ -1773,7 +1773,6 @@ static void riva_get_EDID(struct fb_info
 	struct riva_par *par = (struct riva_par *) info->par;
 	int i;
 
-	riva_create_i2c_busses(par);
 	for (i = par->bus; i >= 1; i--) {
 		riva_probe_i2c_connector(par, i, &par->EDID);
 		if (par->EDID) {
@@ -1781,7 +1780,6 @@ static void riva_get_EDID(struct fb_info
 			break;
 		}
 	}
-	riva_delete_i2c_busses(par);
 #endif
 #endif
 }
@@ -1933,6 +1931,10 @@ static int __devinit rivafb_probe(struct
 	}
 #endif /* CONFIG_MTRR */
 
+#ifdef CONFIG_FB_RIVA_I2C
+	riva_create_i2c_busses((struct riva_par *) info->par);
+#endif
+
 	info->fbops = &riva_fb_ops;
 	info->fix = rivafb_fix;
 	riva_get_EDID(info, pd);
@@ -1961,6 +1963,9 @@ static int __devinit rivafb_probe(struct
 	return 0;
 
 err_out_iounmap_fb:
+#ifdef CONFIG_FB_RIVA_I2C
+	riva_delete_i2c_busses((struct riva_par *) info->par);
+#endif
 	iounmap(info->screen_base);
 err_out_free_base1:
 	if (default_par->riva.Architecture == NV_ARCH_03) 
@@ -1989,6 +1994,10 @@ static void __exit rivafb_remove(struct 
 	if (!info)
 		return;
 
+#ifdef CONFIG_FB_RIVA_I2C
+	riva_delete_i2c_busses(par);
+#endif
+
 	unregister_framebuffer(info);
 #ifdef CONFIG_MTRR
 	if (par->mtrr.vram_valid)

--=-PamA2S1x2fbTyyep2LF9--

