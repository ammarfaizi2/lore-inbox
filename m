Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261603AbVB1OIC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261603AbVB1OIC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Feb 2005 09:08:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261627AbVB1OF7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Feb 2005 09:05:59 -0500
Received: from gprs215-69.eurotel.cz ([160.218.215.69]:31363 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261622AbVB1ODW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Feb 2005 09:03:22 -0500
Date: Mon, 28 Feb 2005 12:39:00 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Morton <akpm@osdl.org>
Cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Update suspend-to-RAM vs. video documentation
Message-ID: <20050228113900.GB1312@elf.ucw.cz>
References: <20050228012218.GA2014@elf.ucw.cz> <20050227204642.17931055.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050227204642.17931055.akpm@osdl.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > We got quite long list of machines and tricks needed to get them
> >  working. Please apply,
> 
> Pavel, I'll drop this, having seen Nigel's comments.

I updated it according to Nigel. Here's new version.

++

We got quite long list of machines and tricks needed to get them
working. Please apply,
								Pavel
--- clean/Documentation/power/video.txt	2004-12-25 13:34:57.000000000 +0100
+++ linux/Documentation/power/video.txt	2005-02-28 12:36:52.000000000 +0100
@@ -1,7 +1,7 @@
 
 		Video issues with S3 resume
 		~~~~~~~~~~~~~~~~~~~~~~~~~~~
-		  2003-2004, Pavel Machek
+		  2003-2005, Pavel Machek
 
 During S3 resume, hardware needs to be reinitialized. For most
 devices, this is easy, and kernel driver knows how to do
@@ -11,33 +11,160 @@
 driver -- vesafb and vgacon are widely used).
 
 This is not problem for swsusp, because during swsusp resume, BIOS is
-run normally so video card is normally initialized.
+run normally so video card is normally initialized. S3 has absolutely
+no chance of working with SMP/HT. Be sure it to turn it off before
+testing (swsusp should work ok, OTOH).
 
-There are three types of systems where video works after S3 resume:
+There are a few types of systems where video works after S3 resume:
 
-* systems where video state is preserved over S3. (Athlon HP Omnibook xe3s)
+(1) systems where video state is preserved over S3.
 
-* systems where it is possible to call video bios during S3
-  resume. Unfortunately, it is not correct to call video BIOS at that
-  point, but it happens to work on some machines. Use
-  acpi_sleep=s3_bios (Athlon64 desktop system)
+(2) systems where it is possible to call the video BIOS during S3
+  resume. Unfortunately, it is not correct to call the video BIOS at
+  that point, but it happens to work on some machines. Use
+  acpi_sleep=s3_bios.
 
-* systems that initialize video card into vga text mode and where BIOS
-  works well enough to be able to set video mode. Use
-  acpi_sleep=s3_mode on these. (Toshiba 4030cdt)
+(3) systems that initialize video card into vga text mode and where
+  the BIOS works well enough to be able to set video mode. Use
+  acpi_sleep=s3_mode on these.
 
-* on some systems s3_bios kicks video into text mode, and
-  acpi_sleep=s3_bios,s3_mode is needed (Toshiba Satellite P10-554)
+(4) on some systems s3_bios kicks video into text mode, and
+  acpi_sleep=s3_bios,s3_mode is needed.
 
-* radeon systems, where X can soft-boot your video card. You'll need
+(5) radeon systems, where X can soft-boot your video card. You'll need
   patched X, and plain text console (no vesafb or radeonfb), see
-  http://www.doesi.gmxhome.de/linux/tm800s3/s3.html. (Acer TM 800)
+  http://www.doesi.gmxhome.de/linux/tm800s3/s3.html. Actually you
+  should probably use vbetool (6) instead.
+
+(6) other radeon systems, where vbetool is enough to bring system back
+  to life. It needs text console to be working. Do vbetool vbestate
+  save > /tmp/delme; echo 3 > /proc/acpi/sleep; vbetool post; vbetool
+  vbestate restore < /tmp/delme; setfont <whatever>, and your video
+  should work.
+
+(7) on some systems, it is possible to boot most of kernel, and then
+  POSTing bios works. Ole Rohne has patch to do just that at
+  http://dev.gentoo.org/~marineam/patch-radeonfb-2.6.11-rc2-mm2.
 
 Now, if you pass acpi_sleep=something, and it does not work with your
-bios, you'll get hard crash during resume. Be carefull.
+bios, you'll get a hard crash during resume. Be careful. Also it is
+safest to do your experiments with plain old VGA console. The vesafb
+and radeonfb (etc) drivers have a tendency to crash the machine during
+resume.
 
-You may have system where none of above works. At that point you
+You may have a system where none of above works. At that point you
 either invent another ugly hack that works, or write proper driver for
 your video card (good luck getting docs :-(). Maybe suspending from X
 (proper X, knowing your hardware, not XF68_FBcon) might have better
 chance of working.
+
+Table of known working systems:
+
+Model                           hack (or "how to do it")
+------------------------------------------------------------------------------
+Acer Aspire 1406LC		ole's late BIOS init (7), turn off DRI
+Acer TM 242FX			vbetool (6)
+Acer TM 4052LCi		        s3_bios (2)
+Acer TM 636Lci			s3_bios vga=normal (2)
+Acer TM 650 (Radeon M7)		vga=normal plus boot-radeon (5) gets text console back
+Acer TM 660			??? (*)
+Acer TM 800			vga=normal, X patches, see webpage (5)
+Arima W730a			vbetool needed (6)
+Asus L2400D                     s3_mode (3)(***) (S1 also works OK)
+Asus L3800C (Radeon M7)		s3_bios (2) (S1 also works OK)
+Asus M6NE			??? (*)
+Athlon64 desktop prototype	s3_bios (2)
+Compal CL-50			??? (*)
+Compaq Armada E500 - P3-700     none (1) (S1 also works OK)
+Dell 600m, ATI R250 Lf		none (1), but needs xorg-x11-6.8.1.902-1
+Dell D600, ATI RV250            vga=normal (**), or try vbestate (6)
+Dell Inspiron 4000		??? (*)
+Dell Inspiron 500m		??? (*)
+Dell Inspiron 600m		??? (*)
+Dell Inspiron 8200		??? (*)
+Dell Inspiron 8500		??? (*)
+Dell Inspiron 8600		??? (*)
+eMachines athlon64 machines	vbetool needed (6) (someone please get me model #s)
+HP NC6000			s3_bios, may not use radeonfb (2)
+HP NX7000			??? (*)
+HP Pavilion ZD7000		vbetool post needed, need open-source nv driver for X
+HP Omnibook XE3	athlon version	none (1)
+HP Omnibook XE3GC w/S3 Savage/IX-MV  none (1)
+IBM TP A31 / Type 2652-M5G      s3_mode (3) [works ok with BIOS 1.04 2002-08-23, but not at all with BIOS 1.11 2004-11-05 :-(]
+IBM TP R32 / Type 2658-MMG      none (1)
+IBM TP R40 2722B3G		??? (*)
+IBM TP R50p / Type 1832-22U     s3_bios (2)
+IBM TP R51			??? (*)
+IBM TP T30	236681A		??? (*)
+IBM TP T40 / Type 2373-MU4      none (1)
+IBM TP T40p			??? (*)
+IBM TP T41p			none (1)
+IBM TP T42			??? (*)
+IBM ThinkPad T42p (2373-GTG)	s3_bios (2)
+IBM TP X20			??? (*)
+IBM TP X30			??? (*)
+IBM TP X31 / Type 2672-XXH      none (1), use radeontool (http://fdd.com/software/radeon/) to turn off backlight.
+IBM TP X40			??? (*)
+Medion MD4220			??? (*)
+Samsung P35			vbetool needed (6)
+Sharp PC-AR10 (ATI rage)	none (1)
+Sony Vaio PCG-F403		??? (*)
+Sony Vaio PCG-N505SN		??? (*)
+Sony Vaio vgn-s260		X or boot-radeon can init it (5)
+Toshiba Satellite 4030CDT	s3_mode (3)
+Toshiba Satellite 4080XCDT      s3_mode (3)
+Toshiba Satellite 4090XCDT      ??? (*)
+Toshiba Satellite P10-554       s3_bios,s3_mode (4)(****)
+Uniwill 244IIO			??? (*)
+
+
+(*) from http://www.ubuntulinux.org/wiki/HoaryPMResults, not sure
+    which options to use. If you know, please tell me.
+
+(**) Text console is "strange" after resume. Backlight is switched on again
+     by the X server. X server is:
+     | X Window System Version 6.8.1.904 (6.8.2 RC 4)
+     | Release Date: 2 February 2005
+     | X Protocol Version 11, Revision 0, Release 6.8.1.904
+     | Build Operating System: SuSE Linux [ELF] SuSE
+     as present in SUSE 9.3preview3.
+
+(***) To be tested with a newer kernel.
+
+(****) Not with SMP kernel, UP only.
+
+VBEtool details
+~~~~~~~~~~~~~~~
+(with thanks to Carl-Daniel Hailfinger)
+
+First, boot into X and run the following script ONCE:
+#!/bin/bash
+statedir=/root/s3/state
+mkdir -p $statedir
+chvt 2
+sleep 1
+vbetool vbestate save >$statedir/vbe
+
+
+To suspend and resume properly, call the following script as root:
+#!/bin/bash
+statedir=/root/s3/state
+curcons=`fgconsole`
+fuser /dev/tty$curcons 2>/dev/null|xargs ps -o comm= -p|grep -q X && chvt 2
+cat /dev/vcsa >$statedir/vcsa
+sync
+echo 3 >/proc/acpi/sleep
+sync
+vbetool post
+vbetool vbestate restore <$statedir/vbe
+cat $statedir/vcsa >/dev/vcsa
+rckbd restart
+chvt $[curcons%6+1]
+chvt $curcons
+
+
+Unless you change your graphics card or other hardware configuration,
+the state once saved will be OK for every resume afterwards.
+NOTE: The "rckbd restart" command may be different for your
+distribution. Simply replace it with the command you would use to
+set the fonts on screen.



-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
