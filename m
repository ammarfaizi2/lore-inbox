Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262238AbTCHVxE>; Sat, 8 Mar 2003 16:53:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262239AbTCHVxD>; Sat, 8 Mar 2003 16:53:03 -0500
Received: from pine.compass.com.ph ([202.70.96.37]:40268 "HELO
	pine.compass.com.ph") by vger.kernel.org with SMTP
	id <S262238AbTCHVxC>; Sat, 8 Mar 2003 16:53:02 -0500
Subject: Re: [Linux-fbdev-devel] [BK updates]
From: Antonino Daplas <adaplas@pol.net>
To: Antonino Daplas <adaplas@pol.net>
Cc: James Simmons <jsimmons@infradead.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1047087608.2389.31.camel@localhost.localdomain>
References: <Pine.LNX.4.44.0303080024130.20304-100000@phoenix.infradead.org> 
	<1047087608.2389.31.camel@localhost.localdomain>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1047160856.1211.72.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 09 Mar 2003 06:02:57 +0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2003-03-08 at 09:46, Antonino Daplas wrote:
> On Sat, 2003-03-08 at 08:26, James Simmons wrote:
> > 
> > Hi folks!!!
> > 
> >   More updates. Lots of fixes in drivers and in the upper layers. Its 
> > starting to really shape up. You can get the standard diff at
> > 
> 
> James, 
> 
> The ff. code is not totally correct:
> 

James, can you apply this?  Code logic is retained, it just simplifies
the calculations, removed unnecessary conditionals, and used
info->var.yres instead of var.yres.

Tony

diff -Naur linux-2.5.64-fbdev/drivers/video/console/fbcon.c linux-2.5.64/drivers/video/console/fbcon.c
--- linux-2.5.64-fbdev/drivers/video/console/fbcon.c	2003-03-08 21:33:25.000000000 +0000
+++ linux-2.5.64/drivers/video/console/fbcon.c	2003-03-08 21:47:26.000000000 +0000
@@ -1044,9 +1044,7 @@
 		vc->vc_rows = nr_rows;
 	}
 	p->vrows = info->var.yres_virtual / vc->vc_font.height;
-	if(info->var.yres > (vc->vc_font.height * (vc->vc_rows + 1))) {
-		p->vrows -= (info->var.yres - (vc->vc_font.height * vc->vc_rows)) / vc->vc_font.height;
-	}
+	p->vrows -= info->var.yres/vc->vc_font.height - vc->vc_rows;
 	if ((info->var.yres % vc->vc_font.height) &&
 	    (info->var.yres_virtual % vc->vc_font.height <
 	     info->var.yres % vc->vc_font.height))
@@ -1825,9 +1823,8 @@
 		var.activate = FB_ACTIVATE_NOW;
 		fb_set_var(&var, info);
 	}
-	p->vrows = var.yres_virtual/fh;
-	if(var.yres > (fh * (height + 1)))
-		p->vrows -= (var.yres - (fh * height)) / fh;
+	p->vrows = info->var.yres_virtual/fh;
+	p->vrows -= (info->var.yres + (fh - 1))/fh - height;
 	return 0;
 }
 
@@ -2099,11 +2096,7 @@
 		/* reset wrap/pan */
 		info->var.xoffset = info->var.yoffset = p->yscroll = 0;
 		p->vrows = info->var.yres_virtual / h;
-
-#if 0          /* INCOMPLETE - let the console gurus handle this */
-		if(info->var.yres > (h * (vc->vc_rows + 1))
-			p->vrows -= (info->var.yres - (h * vc->vc_rows)) / h;
-#endif
+		p->vrows -= info->var.yres/h  - vc->vc_rows;
 		if ((info->var.yres % h)
 		    && (info->var.yres_virtual % h < info->var.yres % h))
 			p->vrows--;

