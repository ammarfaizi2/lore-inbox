Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261476AbVBNVLs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261476AbVBNVLs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Feb 2005 16:11:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261474AbVBNVLs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Feb 2005 16:11:48 -0500
Received: from gprs214-75.eurotel.cz ([160.218.214.75]:40625 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261476AbVBNVL2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Feb 2005 16:11:28 -0500
Date: Mon, 14 Feb 2005 22:11:05 +0100
From: Pavel Machek <pavel@suse.cz>
To: ACPI mailing list <acpi-devel@lists.sourceforge.net>,
       kernel list <linux-kernel@vger.kernel.org>, seife@suse.de, rjw@sisk.pl
Subject: Call for help: list of machines with working S3
Message-ID: <20050214211105.GA12808@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Stefan provided me initial list of machines where S3 works (including
video). If you have machine that is not on the list, please send me a
diff. If you have eMachines... I'd like you to try playing with
vbetool (it worked for me), and if it works for you supplying right
model numbers.

								Pavel


		Video issues with S3 resume
		~~~~~~~~~~~~~~~~~~~~~~~~~~~
		  2003-2005, Pavel Machek

During S3 resume, hardware needs to be reinitialized. For most
devices, this is easy, and kernel driver knows how to do
it. Unfortunately there's one exception: video card. Those are usually
initialized by BIOS, and kernel does not have enough information to
boot video card. (Kernel usually does not even contain video card
driver -- vesafb and vgacon are widely used).

This is not problem for swsusp, because during swsusp resume, BIOS is
run normally so video card is normally initialized. S3 has absolutely
no change to work with SMP/HT. Be sure it to turn it off before
testing (swsusp should work ok, OTOH).

There are few types of systems where video works after S3 resume:

(1) systems where video state is preserved over S3.

(2) systems where it is possible to call video bios during S3
  resume. Unfortunately, it is not correct to call video BIOS at that
  point, but it happens to work on some machines. Use
  acpi_sleep=s3_bios.

(3) systems that initialize video card into vga text mode and where BIOS
  works well enough to be able to set video mode. Use
  acpi_sleep=s3_mode on these.

(4) on some systems s3_bios kicks video into text mode, and
  acpi_sleep=s3_bios,s3_mode is needed.

(5) radeon systems, where X can soft-boot your video card. You'll need
  patched X, and plain text console (no vesafb or radeonfb), see
  http://www.doesi.gmxhome.de/linux/tm800s3/s3.html.

(6) other radeon systems, where vbetool is enough to bring system back
  to life. Do vbetool vbestate save > /tmp/delme; echo 3 > /proc/acpi/sleep;
  vbetool post; vbetool vbestate restore < /tmp/delme; setfont
  <whatever>, and your video should work.

Now, if you pass acpi_sleep=something, and it does not work with your
bios, you'll get hard crash during resume. Be carefull. Also it is
safest to do your experiments with plain old VGA console. vesafb and
radeonfb (etc) drivers have tendency to crash the machine during resume.

You may have system where none of above works. At that point you
either invent another ugly hack that works, or write proper driver for
your video card (good luck getting docs :-(). Maybe suspending from X
(proper X, knowing your hardware, not XF68_FBcon) might have better
chance of working.

Table of known working systems:

Model                           hack (or "how to do it")
------------------------------------------------------------------------------
IBM TP R32 / Type 2658-MMG      none (1)
Athlon HP Omnibook XE3		none (1)
Compaq Armada E500 - P3-700     none (1) (S1 also works OK)
IBM t41p			none (1)
Athlon64 desktop prototype	s3_bios (2)
HP NC6000			s3_bios (2)
Toshiba Satellite 4080XCDT      s3_mode (3)
Toshiba Satellite 4030CDT	s3_mode (3)
Dell D600, ATI RV250            vga=normal (**)
Asus L2400D                     s3_mode (3)(***) (S1 also works OK)
Toshiba Satellite P10-554       s3_bios,s3_mode (4)(****)
Acer TM 800			vga=normal, X patches, see webpage (5)
Athlon64 Arima W730a		vbestate needed (6)
eMachines athlon64 machines	vbestate needed (6) (someone please get me model #s)

(**) Text console is "strange" after resume. Backlight is switched on again
     by the X server. X server is:
     | X Window System Version 6.8.1.904 (6.8.2 RC 4)
     | Release Date: 2 February 2005
     | X Protocol Version 11, Revision 0, Release 6.8.1.904
     | Build Operating System: SuSE Linux [ELF] SuSE
     as present in SUSE 9.3preview3.

(***) To be tested with a newer kernel.

(****) Not with SMP kernel, UP only.

-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
