Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263480AbTJQOtX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Oct 2003 10:49:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263478AbTJQOtW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Oct 2003 10:49:22 -0400
Received: from mail-5.tiscali.it ([195.130.225.151]:54249 "EHLO
	mail-5.tiscali.it") by vger.kernel.org with ESMTP id S263480AbTJQOtN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Oct 2003 10:49:13 -0400
Date: Fri, 17 Oct 2003 16:44:30 +0200
From: Kronos <kronos@kronoz.cjb.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: "Carlo E. Prelz" <fluido@fluido.as>,
       James Simmons <jsimmons@infradead.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [Linux-fbdev-devel] Re: FBDEV 2.6.0-test7 updates.
Message-ID: <20031017144430.GB463@dreamland.darkstar.lan>
Reply-To: kronos@kronoz.cjb.net
References: <20031015162056.018737f1.akpm@osdl.org> <Pine.LNX.4.44.0310160022210.13660-100000@phoenix.infradead.org> <20031016091918.GA1002@casa.fluido.as> <1066298431.1407.119.camel@gaston> <20031016101905.GA7454@casa.fluido.as> <1066300935.646.136.camel@gaston> <20031017100412.GA1639@casa.fluido.as> <1066387778.661.226.camel@gaston> <20031017111032.GB1639@casa.fluido.as> <1066389397.662.228.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1066389397.662.228.camel@gaston>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Il Fri, Oct 17, 2003 at 01:16:37PM +0200, Benjamin Herrenschmidt ha scritto: 
> 
> > Aha... So, from what you know, is there any possibility (fb, X, X with
> > ATI drivers, anything else) to use the video output (or the second
> > head) of radeon cards under Linux? And have you tried your drivers
> > with 2 cards (one PCI and one AGP)?
> 
> I haven't tried with 2 cards, no. It's possible to do dual head
> with XFree.
> 
> > And in all cases, why is parameter "mode" not working? If I could set
> > 1280x1024-32@60 from Lilo, most of my problems would be solved...
> 
> I'll check that out. The new module parameter thing isn't that good,
> I think I'll revive the old stuff for a while.

The following patch restores the setup  function so that radeonfb can be
given  options like  other fb  drivers. There's  also a  small typo  fix
(force_dfp -> panel_yres).

===== drivers/video/fbmem.c 1.71 vs edited =====
--- 1.71/drivers/video/fbmem.c	Sun Sep  7 23:07:57 2003
+++ edited/drivers/video/fbmem.c	Fri Oct 17 16:37:55 2003
@@ -220,7 +220,7 @@
 	{ "tdfxfb", tdfxfb_init, tdfxfb_setup },
 #endif
 #ifdef CONFIG_FB_RADEON
-	{ "radeonfb", radeonfb_init, NULL },
+	{ "radeonfb", radeonfb_init, radeonfb_setup },
 #endif
 #ifdef CONFIG_FB_CONTROL
 	{ "controlfb", control_init, control_setup },
===== drivers/video/aty/radeon_base.c 1.11 vs edited =====
--- 1.11/drivers/video/aty/radeon_base.c	Mon Oct 13 17:47:12 2003
+++ edited/drivers/video/aty/radeon_base.c	Fri Oct 17 16:37:31 2003
@@ -2378,6 +2378,40 @@
 	pci_unregister_driver (&radeonfb_driver);
 }
 
+int __init radeonfb_setup (char *options)
+{
+	char *this_opt;
+
+	if (!options || !*options)
+		return 0;
+
+	while ((this_opt = strsep (&options, ",")) != NULL) {
+		if (!*this_opt)
+			continue;
+
+		if (!strncmp(this_opt, "noaccel", 7)) {
+			noaccel = 1;
+		} else if (!strncmp(this_opt, "mirror", 6)) {
+			mirror = 1;
+		} else if (!strncmp(this_opt, "force_dfp", 9)) {
+			force_dfp = 1;
+		} else if (!strncmp(this_opt, "panel_yres:", 11)) {
+			panel_yres = simple_strtoul((this_opt+11), NULL, 0);
+		} else if (!strncmp(this_opt, "nomtrr", 6)) {
+			nomtrr = 1;
+		} else if (!strncmp(this_opt, "nomodeset", 9)) {
+			nomodeset = 1;
+		} else if (!strncmp(this_opt, "force_measure_pll", 17)) {
+			force_measure_pll = 1;
+		} else if (!strncmp(this_opt, "ignore_edid", 11)) {
+			ignore_edid = 1;
+		} else
+			mode_option = this_opt;
+	}
+	return 0;
+}
+
+
 #ifdef MODULE
 module_init(radeonfb_init);
 module_exit(radeonfb_exit);
@@ -2405,6 +2439,6 @@
 MODULE_PARM_DESC(nomtrr, "bool: disable use of MTRR registers");
 #endif
 module_param(panel_yres, int, 0);
-MODULE_PARM_DESC(force_dfp, "int: set panel yres");
+MODULE_PARM_DESC(panel_yres, "int: set panel yres");
 module_param(mode_option, charp, 0);
 MODULE_PARM_DESC(mode_option, "Specify resolution as \"<xres>x<yres>[-<bpp>][@<refresh>]\" ");


Luca
-- 
Reply-To: kronos@kronoz.cjb.net
Home: http://kronoz.cjb.net
I went to God just to see
And I was looking at me
Saw heaven and hell were lies
When I'm God everyone dies
