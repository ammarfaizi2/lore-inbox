Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266755AbSLDAdf>; Tue, 3 Dec 2002 19:33:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266761AbSLDAdf>; Tue, 3 Dec 2002 19:33:35 -0500
Received: from [203.167.79.9] ([203.167.79.9]:50697 "EHLO
	willow.compass.com.ph") by vger.kernel.org with ESMTP
	id <S266755AbSLDAde>; Tue, 3 Dec 2002 19:33:34 -0500
Subject: Re: [STATUS] fbdev api.
From: Antonino Daplas <adaplas@pol.net>
To: James Simmons <jsimmons@infradead.org>
Cc: Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux console project <linuxconsole-dev@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.33.0212031417520.10097-100000@maxwell.earthlink.net>
References: <Pine.LNX.4.33.0212031417520.10097-100000@maxwell.earthlink.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1038972718.1086.17.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 04 Dec 2002 08:32:07 +0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-12-04 at 03:18, James Simmons wrote:
> 
> > Attached is a patch against linux-2.5.50 + your fbdev.diff.
> 
> Applied :-)
> 
> > b.  Another rewrite of fbcon_show_logo() so it's more understandable
> > (hopefully).  I also added support for the rest of the visuals, but
> > untested yet.
> > Not tested:
> > static psuedocolor, mono01, and mono10.
> 
> I have a mono hga card.
> 
Can you apply the following patch to include logo drawing support for all formats :-)?

diff -Naur linux-2.5.50-js/drivers/video/cfbimgblt.c linux/drivers/video/cfbimgblt.c
--- linux-2.5.50-js/drivers/video/cfbimgblt.c	2002-12-04 03:14:19.000000000 +0000
+++ linux/drivers/video/cfbimgblt.c	2002-12-04 03:13:57.000000000 +0000
@@ -123,11 +123,11 @@
 			shift = start_index;
 		}
 		while (n--) {
-			if (p->fix.visual == FB_VISUAL_PSEUDOCOLOR)
-				color = *src & bitmask; 
 			if (p->fix.visual == FB_VISUAL_TRUECOLOR ||
 			    p->fix.visual == FB_VISUAL_DIRECTCOLOR )
 				color = palette[*src] & bitmask;
+			else
+				color = *src & bitmask; 
 			val |= SHIFT_HIGH(color, shift);
 			if (shift >= null_bits) {
 				FB_WRITEL(val, dst++);

> > c.  prevent fbcon module from loading if no fbdev is registered.  Also
> > made fbcon module unsafe to unload (for now).  This is optional, of course.
> 
> It is a good idea until we have the ability to switch back to text mode.
> 
It's not the switch back to text mode, that's very doable (see my other
reply).  It's during give_up_console() at fbcon module exit.  At this
point, the console suddenly disappears and freezes the system.  Maybe we
can save the global "conswitchp" during fbcon module init, then
something like this at fbcon module exit:

void __exit fb_console_exit(void)
{	
	give_up_console(&fbcon);
	take_over_console(saved_conswitchp, ...);	
}

Is this feasible?

Tony

