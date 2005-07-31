Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261859AbVGaJ4F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261859AbVGaJ4F (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Jul 2005 05:56:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261861AbVGaJ4F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Jul 2005 05:56:05 -0400
Received: from mailout05.sul.t-online.com ([194.25.134.82]:19589 "EHLO
	mailout05.sul.t-online.com") by vger.kernel.org with ESMTP
	id S261859AbVGaJzx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Jul 2005 05:55:53 -0400
Message-ID: <42ECA05F.40401@t-online.de>
Date: Sun, 31 Jul 2005 11:56:47 +0200
From: Knut Petersen <Knut_Petersen@t-online.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de-AT; rv:1.7.7) Gecko/20050414
X-Accept-Language: de, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH 1/1 2.6.13-rc4] framebuffer: new driver for cyberblade/i1
 core
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-ID: XNxp6MZpZeQfHtqyqRs51TqF1YfOHOdr1eMnVDk+6a+Bndqa96hkUM@t-dialin.net
X-TOI-MSGID: 82cfefab-337e-4af3-9bf6-037735d746ab
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Currently tridenfb claims to support the cyberblade/i1 graphics core.
This is of very limited truth. There is a great number of bugs, even
vesafb is faster and provides more working modes and much better
quality of the video signal.

Tridentfb seems to be unmaintained,and documentation for most of the
supported chips is not available. Fixing cyberblade/i1 support inside
of tridentfb was not an option, it would have caused numerous
if(CYBERBLADEi1) else ... cases and would have rendered the code
to be almost unmaintainable.

This code does support the graphics core of a single north bridge
and has been tested and developed on a system equipped with that
chip. It cannot break anything but the broken cyberblade/i1 support
of tridentfb, and even if that would be the case, there is still
vesafb as a working alternative. On the other hand it provides
significant improvements. Because of this I believe that there is
no reason to keep it out of 2.6.13 just because it is presented a
bit late in the development cycle.


Signed-off-by: Knut Petersen <Knut_Petersen@t-online.de>

diff -urN linux-2.6.13-rc4/Documentation/fb/cyblafb.txt linux-2.6.13-rc4-tfix/Documentation/fb/cyblafb.txt
--- linux-2.6.13-rc4/Documentation/fb/cyblafb.txt	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.13-rc4-tfix/Documentation/fb/cyblafb.txt	2005-07-31 09:38:44.000000000 +0200
@@ -0,0 +1,354 @@
+CyBlaFB is a framebuffer driver for the Cyberblade/i1 graphics core integrated
+into the VIA Apollo PLE133 (aka vt8601) south bridge. It is developed and
+tested using a VIA EPIA 5000 board.
+
+
+Why CyBlaFB?
+============
+
+I tried the following framebuffer drivers:
+
+	- TRIDENTFB is full of bugs. Acceleration is broken for Blade3D
+	  graphics cores like the cyberblade/i1. It claims to support a great
+	  number of devices, but documentation for most of these devices is
+	  unfortunately not available. There is _no_ reason to use tridentfb
+	  for cyberblade/i1 + CRT users. VESAFB is faster, and the one
+	  advantage, mode switching, is broken in tridentfb.
+
+	- VESAFB is used by many distributions as a standard. Vesafb does
+	  not support mode switching. VESAFB is a bit faster than the working
+	  configurations of TRIDENTFB, but it is still too slow, even if you
+	  use ypan.
+
+	- EPIAFB (you'll find it on sourceforge) supports the Cyberblade/i1
+	  graphics core, but it still has serious bugs and developement seems
+	  to have stopped. This is the one driver with TV-out support. If you
+	  do need this feature, use epiafb.
+
+None of these drivers was a real option for me.
+
+I believe that is unreasonable to change code that announces to support 20
+devices if I only have more or less sufficient documentation for exactly one
+of these. The risk of breaking device foo while fixing device bar is too high.
+
+So I decided to start CyBlaFB as a stripped down tridentfb.
+
+All code specific to other Trident chips has been removed. After that there
+were a lot of cosmetic changes to increase the readability of the code. All
+register names were changed to those mnemonics used in the datasheet. Function
+and macro names were changed if they hindered easy understanding of the code.
+
+After that I debugged the code and implemented some new features. I'll try to
+give a little summary of the main changes:
+
+	- calculation of vertical and horizontal timings was fixed
+
+	- video signal quality has been improved dramatically
+
+	- acceleration:
+
+		- fillrect and copyarea were fixed and reenabled
+
+		- color expanding imageblit was newly implemented, color
+		  imageblit (only used to draw the penguine) still uses the
+		  generic code.
+
+		- init of the acceleration engine was improved and moved to a
+		  place where it really works ...
+
+		- sync function has a timeout now and tries to reset and
+		  reinit the accel engine if necessary
+
+		- fewer slow copyarea calls when doing ypan scrolling by using
+		  undocumented bit d21 of screen start address stored in
+		  CR2B[5]. BIOS does use it also, so this should be safe.
+
+	- cyblafb rejects any attempt to set modes that would cause vclk
+	  values above reasonable 230 MHz. 32bit modes use a clock
+	  multiplicator of 2, so fbset does show the correct values for
+	  pixclock but not for vclk in this case. The fbset limit is 115 MHz
+	  for 32 bpp modes.
+
+	- cyblafb rejects modes known to be broken or unimplemented (all
+	  interlaced modes, all doublescan modes for now)
+
+	- cyblafb now works independant of the video mode in effect at startup
+	  time (tridentfb does not init all needed registers to reasonable
+	  values)
+
+	- switching between video modes does work reliably now
+
+	- the first video mode now is the one selected on startup using the
+	  vga=???? mechanism or any of
+		- 640x480, 800x600, 1024x768, 1280x1024
+		- 8, 16, 24 or 32 bpp
+		- refresh between 50 Hz and 85 Hz, 1 Hz steps (1280x1024-32
+		  is limited to 63Hz)
+
+	- pci retry and pci burst mode are settable (try to disable if you
+	  experience latency problems)
+
+	- built as a module cyblafb might be unloaded and reloaded using
+	  the vfb module and con2vt or might be used together with vesafb
+
+Speed
+=====
+
+CyBlaFB is much faster than tridentfb and vesafb. Compare the performance data
+for mode 1280x1024-[8,16,32]@61 Hz.
+
+Test 1: Cat a file with 2000 lines of 0 characters.
+Test 2: Cat a file with 2000 lines of 80 characters.
+Test 3: Cat a file with 2000 lines of 160 characters.
+
+All values show system time use in seconds, kernel 2.6.12 was used for
+the measurements. 2.6.13-rc4 is much slower, but this problem has been
+solved, and 2.6.13 should be actually faster than 2.6.12.
+
++-----------+-----------------------------------------------------+
+|	    |			not accelerated 		  |
+| TRIDENTFB +-----------------+-----------------+-----------------+
+| of 2.6.12 |	   8 bpp      |     16 bpp	|     32 bpp	  |
+|	    | noypan |	 ypan | noypan |   ypan | noypan |   ypan |
++-----------+--------+--------+--------+--------+--------+--------+
+|    Test 1 |	4.31 |	 4.33 |   6.05 |  12.81 |  ----  |  ----  |
+|    Test 2 |  67.94 |	 5.44 | 123.16 |  14.79 |  ----  |  ----  |
+|    Test 3 | 131.36 |	 6.55 | 240.12 |  16.76 |  ----  |  ----  |
++-----------+--------+--------+--------+--------+--------+--------+
+|  Comments |		      | 		| completely bro- |
+|	    |		      | 		| ken, monitor	  |
+|	    |		      | 		| switches off	  |
++-----------+-----------------+-----------------+-----------------+
+
+
++-----------+-----------------------------------------------------+
+|	    |			  accelerated			  |
+| TRIDENTFB +-----------------+-----------------+-----------------+
+| of 2.6.12 |	   8 bpp      |     16 bpp	|     32 bpp	  |
+|	    | noypan |	 ypan | noypan |   ypan | noypan |   ypan |
++-----------+--------+--------+--------+--------+--------+--------+
+|    Test 1 |  ----  |	----  |  20.62 |   1.22 |  ----  |  ----  |
+|    Test 2 |  ----  |	----  |  22.61 |   3.19 |  ----  |  ----  |
+|    Test 3 |  ----  |	----  |  24.59 |   5.16 |  ----  |  ----  |
++-----------+--------+--------+--------+--------+--------+--------+
+|  Comments | broken, writing | broken, ok only | completely bro- |
+|	    | to wrong places | if bgcolor is	| ken, monitor	  |
+|	    | on screen + bug | black, bug in	| switches off	  |
+|	    | in fillrect()   | fillrect()	|		  |
++-----------+-----------------+-----------------+-----------------+
+
+
++-----------+-----------------------------------------------------+
+|	    |			not accelerated 		  |
+|   VESAFB  +-----------------+-----------------+-----------------+
+| of 2.6.12 |	   8 bpp      |     16 bpp	|     32 bpp	  |
+|	    | noypan |	 ypan | noypan |   ypan | noypan |   ypan |
++-----------+--------+--------+--------+--------+--------+--------+
+|    Test 1 |	4.26 |	 3.76 |   5.99 |   7.23 |  ----  |  ----  |
+|    Test 2 |  65.65 |	 4.89 | 120.88 |   9.08 |  ----  |  ----  |
+|    Test 3 | 126.91 |	 5.94 | 235.77 |  11.03 |  ----  |  ----  |
++-----------+--------+--------+--------+--------+--------+--------+
+|  Comments | vga=0x307       | vga=0x31a	| vga=0x31b not   |
+|	    | fh=80kHz	      | fh=80kHz	| supported by	  |
+|	    | fv=75kHz	      | fv=75kHz	| video BIOS and  |
+|	    |		      | 		| hardware	  |
++-----------+-----------------+-----------------+-----------------+
+
+
++-----------+-----------------------------------------------------+
+|	    |			  accelerated			  |
+|  CYBLAFB  +-----------------+-----------------+-----------------+
+|	    |	   8 bpp      |     16 bpp	|     32 bpp	  |
+|	    | noypan |	 ypan | noypan |   ypan | noypan |   ypan |
++-----------+--------+--------+--------+--------+--------+--------+
+|    Test 1 |	8.02 |	 0.23 |  19.04 |   0.61 |  57.12 |   2.74 |
+|    Test 2 |	8.38 |	 0.55 |  19.39 |   0.92 |  57.54 |   3.13 |
+|    Test 3 |	8.73 |	 0.86 |  19.74 |   1.24 |  57.95 |   3.51 |
++-----------+--------+--------+--------+--------+--------+--------+
+|  Comments |		      | 		|		  |
+|	    |		      | 		|		  |
+|	    |		      | 		|		  |
+|	    |		      | 		|		  |
++-----------+-----------------+-----------------+-----------------+
+
+Startup Mode
+============
+
+Tridentfb uses modedb.c to allow the user to specify a startup video mode.
+Unfortunately a lot of the video mode specifyed there do not display
+correctly, including the default video mode. My first idea was to implement
+some code in check_var() to alter these modes to values acceptable for the
+graphics core. I wrote some code, but I dumped it completely. If you tweak the
+modes, you need to provide at least kernel parameters to disable those
+helpers. If you don't want to force the user to reboot in those cases you have
+to provide some ioctls and a special control program as fbset etc do not know
+about the new ioctls. No, this is not the perfect solution. But we already
+have a video mode selection mechanism in the kernel. Why shouldn't we use
+vga=xxx to select an initial video mode? This way we get a reasonable
+collection of startup modes (every mode the bios supports) and those people
+who really need to use fbset are not hindered by some magic in check_var()
+that alters the parameters they provide. You might also specify an inital
+video mode, see section "parameters"
+
+
+Untested features
+=================
+
+All LCD stuff is untested. If it worked in tridentfb, it should work in
+cyblafb. Please test and report the results
+
+
+known BUGS
+==========
+
+I don't know of any bug, but please do send reports to both LKML and
+Knut_Petersen@t-online.de.
+
+
+TODO / Missing features
+=======================
+
+Interlaced video modes		The reason that interleaved
+				modes are disabled is that I do not know
+				the meaning of the vertical interlace
+				parameter. Also the datasheet mentions a
+				bit d8 of a horizontal interlace parameter,
+				but nowhere the lower 8 bits. Please help
+				if you can.
+
+low-res double scan modes	Who needs it?
+
+accelerated color blitting	Who needs it? The console driver does use color
+				blitting for nothing but drawing the penguine,
+				everything else is done using color expanding
+				blitting of 1bpp character bitmaps.
+
+xpanning			Who needs it?
+
+ioctls				Who needs it?
+
+TV-out				Will be done later
+
+
+Available Documentation
+=======================
+
+Apollo PLE 133 Chipset VT8601A North Bridge Datasheet, Rev. 1.82, October 22,
+2001, available from VIA. The datasheet is incomplete, some registers that
+need to be programmed are not explained at all or important bits are listed
+as "reserved". But you really need the datasheet to understand the code.
+"p. xxx comments refer to page numbers of this document."
+
+XFree/XOrg drivers are available and of good quality, looking at the code
+there is a good idea if the documentation does not provide enough information
+or if the documentation seems to be wrong.
+
+Parameters
+==========
+
+
+crt		don't autodetect, assume monitor connected to
+		standard VGA connector
+
+fp		don't autodetect, assume flat panel display
+		connected to flat panel monitor interface
+
+nativex 	inform driver about native x resolution of
+		flat panel monitor connected to special
+		interface
+
+stretch 	stretch image to adapt low resolution modes to
+		higer resolutions of flat panel monitors
+		connected to special interface
+
+center		center image to adapt low resolution modes to
+		higer resolutions of flat panel monitors
+		connected to special interface
+
+memsize 	use if autodetected memsize is wrong ...
+		should never be necessary
+
+nopcirr 	disable PCI read retry
+nopciwr 	disable PCI write retry
+nopcirb 	disable PCI read bursts
+nopciwb 	disable PCI write bursts
+
+regdumps	This will print a listing of the contents of
+		most registers to syslog immediately after startup
+		and after a new mode is set. Please do include if
+		you send a bugreport
+
+bpp		bpp for specified modes
+
+ref		refresh rate for specified mode
+
+mode		640x480 or 800x600 or 1024x768 or 1280x1024
+		if not specified, the startup mode will be detected
+		and used, so you might also use the vga=??? parameter
+		described in vesafb.txt. If you do not specify a mode,
+		bpp and ref parameters are ignored.
+
+verbosity	0 is the default, increase to at least 2 for every
+		bug report!
+
+vesafb		allows cyblafb to be loaded after vesafb has been
+		loaded. See sections "Module unloading ...".
+
+Module unloading, the vfb method
+================================
+
+If you want to unload/reload cyblafb, you need to enable vfb support in the
+kernel first. After that, load the modules as shown below:
+
+	modprobe vfb vfb_enable=1
+	modprobe fbcon
+	modprobe cyblafb
+	fbset -fb /dev/fb1 1280x1024-60 -vyres 2662
+	con2fb /dev/fb1 /dev/tty1
+	...
+
+If you now made some changes to cyblafb and want to reload it, you might do it
+as show below:
+
+	con2fb /dev/fb0 /dev/tty1
+	...
+	rmmod cyblafb
+	modprobe cyblafb
+	con2fb /dev/fb1 /dev/tty1
+	...
+
+Of course, you might choose another mode, and most certainly you also want to
+map some other /dev/tty* to the real framebuffer device. You might also choose
+to compile fbcon as a kernel module or place it permanently in the kernel.
+
+I do not know of any way to unload fbcon, and fbcon will prevent the
+framebuffer device loaded first from unloading. [If there is a way, then
+please add a description here!]
+
+Module unloading, the vesafb method
+===================================
+
+Configure the kernel:
+
+	<*> Support for frame buffer devices
+	[*]   VESA VGA graphics support
+	<M>   Cyberblade/i1 support
+
+Add e.g. "video=vesafb:ypan vga=0x307" to the kernel parameters. The ypan
+parameter is important, choose any vga parameter you like as long as it is
+a graphics mode.
+
+After booting, load cyblafb without any mode and bpp parameter and assign
+cyblafb to individual ttys using con2fb, e.g.:
+
+	modprobe cyblafb vesafb=1
+	con2fb /dev/fb1 /dev/tty1
+
+Unloading cyblafb works without problems after you assign vesafb to all
+ttys again, e.g.:
+
+	con2fb /dev/fb0 /dev/tty1
+	rmmod cyblafb
+
+
+
diff -urN linux-2.6.13-rc4/MAINTAINERS linux-2.6.13-rc4-tfix/MAINTAINERS
--- linux-2.6.13-rc4/MAINTAINERS	2005-07-29 10:00:26.000000000 +0200
+++ linux-2.6.13-rc4-tfix/MAINTAINERS	2005-07-29 10:22:21.000000000 +0200
@@ -627,6 +627,12 @@
 W:	http://www.arm.linux.org.uk/
 S:	Maintained
 
+CYBLAFB FRAMEBUFFER DRIVER
+P:	Knut Petersen
+M:	Knut_Petersen@t-online.de
+L:	linux-fbdev-devel@lists.sourceforge.net
+S:	Maintained
+
 CYCLADES 2X SYNC CARD DRIVER
 P:	Arnaldo Carvalho de Melo
 M:	acme@conectiva.com.br
diff -urN linux-2.6.13-rc4/drivers/video/Kconfig linux-2.6.13-rc4-tfix/drivers/video/Kconfig
--- linux-2.6.13-rc4/drivers/video/Kconfig	2005-07-29 10:01:01.000000000 +0200
+++ linux-2.6.13-rc4-tfix/drivers/video/Kconfig	2005-07-31 10:21:13.000000000 +0200
@@ -1180,6 +1180,32 @@
 	  Please read the <file:Documentation/fb/README-sstfb.txt> for supported
 	  options and other important info  support.
 
+config FB_CYBLA
+	tristate "Cyberblade/i1 support"
+	depends on FB && PCI
+	select FB_CFB_IMAGEBLIT
+	select FB_SOFT_CURSOR
+	select VIDEO_SELECT
+	---help---
+	  This driver is supposed to support the Trident Cyberblade/i1 
+	  graphics core integrated in the VIA VT8601A North Bridge,
+	  also known als VIA Apollo PLE133.
+	  
+	  Status:
+	   - Developed, tested and working on EPIA 5000 and EPIA 800.
+	   - Does work reliable on all systems with CRT/LCD connected to
+	     normal VGA ports. 
+	   - Should work on systems that do use the internal LCD port, but
+	     this is absolutely not tested.
+
+	  Character imageblit, copyarea and rectangle fill are hw accelerated,
+	  ypan scrolling is used by default.
+
+	  Please do read <file:Documentation/fb/cyblafb.txt>.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called cyblafb.
+
 config FB_TRIDENT
 	tristate "Trident support"
 	depends on FB && PCI
@@ -1193,8 +1219,12 @@
 	  but also on some motherboards. For more information, read
 	  <file:Documentation/fb/tridentfb.txt>
 
+	  Attention: Cyberblade/i1 support has been removed, choose the 
+	  cyblafb driver instead.
+
 	  Say Y if you have such a graphics board.
 
+
 	  To compile this driver as a module, choose M here: the
 	  module will be called tridentfb.
 
@@ -1205,7 +1235,6 @@
 	This will compile the Trident frame buffer device with
 	acceleration functions.
 
-
 config FB_PM3
 	tristate "Permedia3 support"
 	depends on FB && PCI && BROKEN
diff -urN linux-2.6.13-rc4/drivers/video/Makefile linux-2.6.13-rc4-tfix/drivers/video/Makefile
--- linux-2.6.13-rc4/drivers/video/Makefile	2005-07-29 10:01:01.000000000 +0200
+++ linux-2.6.13-rc4-tfix/drivers/video/Makefile	2005-07-29 10:25:58.000000000 +0200
@@ -50,7 +50,8 @@
 obj-$(CONFIG_FB_IMSTT)            += imsttfb.o
 obj-$(CONFIG_FB_S3TRIO)           += S3triofb.o
 obj-$(CONFIG_FB_FM2)              += fm2fb.o
-obj-$(CONFIG_FB_TRIDENT)	  += tridentfb.o
+obj-$(CONFIG_FB_CYBLA)            += cyblafb.o
+obj-$(CONFIG_FB_TRIDENT)          += tridentfb.o
 obj-$(CONFIG_FB_STI)              += stifb.o
 obj-$(CONFIG_FB_FFB)              += ffb.o sbuslib.o
 obj-$(CONFIG_FB_CG6)              += cg6.o sbuslib.o
diff -urN linux-2.6.13-rc4/drivers/video/cyblafb.c linux-2.6.13-rc4-tfix/drivers/video/cyblafb.c
--- linux-2.6.13-rc4/drivers/video/cyblafb.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.13-rc4-tfix/drivers/video/cyblafb.c	2005-07-31 09:43:42.000000000 +0200
@@ -0,0 +1,1438 @@
+/*
+ * Frame buffer driver for Trident Cyberblade/i1 graphics core
+ *
+ * Copyright 2005 Knut Petersen <Knut_Petersen@t-online.de>
+ *
+ * CREDITS:
+ *	tridentfb.c by Jani Monoses
+ *	see files above for further credits
+ *
+ * TODO:
+ *
+ */
+
+#define CYBLAFB_DEBUG 0
+
+#include <linux/config.h>
+#include <linux/module.h>
+#include <linux/string.h>
+#include <linux/fb.h>
+#include <linux/init.h>
+#include <linux/pci.h>
+#include <asm/types.h>
+#include <video/cyblafb.h>
+
+#define VERSION "0.50"
+
+struct cyblafb_par {
+	void __iomem * io_virt; //iospace virtual memory address
+};
+
+static struct cyblafb_par default_par;
+static struct fb_ops cyblafb_ops;
+static struct fb_info fb_info;
+static struct fb_var_screeninfo default_var;
+static struct fb_fix_screeninfo cyblafb_fix = {
+	.id = "CyBla",
+	.type = FB_TYPE_PACKED_PIXELS,
+	.ypanstep = 1,
+	.visual = FB_VISUAL_PSEUDOCOLOR,
+	.accel = FB_ACCEL_NONE,
+};
+
+static u32 pseudo_pal[16];
+
+static int displaytype;
+
+static char *mode = NULL;
+static int bpp = 8;
+static int ref = 75;
+static int fp;
+static int crt;
+static int nativex;
+static int center;
+static int stretch;
+static int pciwb = 1;
+static int pcirb = 1;
+static int pciwr = 1;
+static int pcirr = 1;
+static int memsize;
+static int verbosity;
+static int vesafb;
+
+module_param(mode, charp, 0);
+module_param(bpp, int, 0);
+module_param(ref, int, 0);
+module_param(fp, int, 0);
+module_param(crt, int, 0);
+module_param(nativex, int, 0);
+module_param(center, int, 0);
+module_param(stretch, int, 0);
+module_param(pciwb, int, 0);
+module_param(pcirb, int, 0);
+module_param(pciwr, int, 0);
+module_param(pcirr, int, 0);
+module_param(memsize, int, 0);
+module_param(verbosity, int, 0);
+module_param(vesafb, int, 0);
+
+
+//=========================================
+//
+// Port access macros for memory mapped io
+//
+//=========================================
+
+#define out8(r,v)    writeb(v,((struct cyblafb_par *)fb_info.par)->io_virt+r)
+#define out32(r,v)   writel(v,((struct cyblafb_par *)fb_info.par)->io_virt+r)
+#define in8(r)	     readb(((struct cyblafb_par *)fb_info.par)->io_virt+r)
+#define in32(r)      readl(((struct cyblafb_par *)fb_info.par)->io_virt+r)
+
+//#define out8(r,v)    outb(v,r)
+//#define out32(r,v)   outl(v,r)
+//#define in8(r)       inb(r)
+//#define in32(r)      inl(r)
+
+//======================================
+//
+// Hardware access inline functions
+//
+//======================================
+
+static inline unsigned char read3X4(int reg)
+{
+	out8(0x3D4,reg);
+	return in8(0x3D5);
+}
+static inline unsigned char read3C4(int reg)
+{
+	out8(0x3C4,reg);
+	return in8(0x3C5);
+}
+static inline unsigned char read3CE(int reg)
+{
+	out8(0x3CE,reg);
+	return in8(0x3CF);
+}
+
+static inline void write3X4(int reg, unsigned char val)
+{
+	out8(0x3D4,reg);
+	out8(0x3D5,val);
+}
+
+static inline void write3C4(int reg, unsigned char val)
+{
+	out8(0x3C4,reg);
+	out8(0x3C5,val);
+}
+
+static inline void write3CE(int reg, unsigned char val)
+{
+	out8(0x3CE,reg);
+	out8(0x3CF,val);
+}
+
+static inline void write3C0(int reg, unsigned char val)
+{
+	in8(0x3DA);			// read to reset index
+	out8(0x3C0,reg);
+	out8(0x3C0,val);
+}
+
+//================================================
+//
+// Cyberblade specific Graphics Engine (GE) setup
+//
+//================================================
+
+static void cyblafb_setup_GE(int pitch,int bpp)
+{
+	int base = (pitch>>3)<<20;
+
+	switch (bpp) {
+		case  8: base |= (0<<29); break;
+		case 15: base |= (5<<29); break;
+		case 16: base |= (1<<29); break;
+		case 24:
+		case 32: base |= (2<<29); break;
+	}
+
+	write3X4(CR36, 0x90);	// reset GE
+	write3X4(CR36, 0x80);	// enable GE
+
+	out32(GE24,1<<7);	// reset all GE pointers
+	out32(GE24,0);
+
+	write3X4(CR2D, 0x00);	// GE Timinigs, no delays
+
+	out32(GEB8,base); // Destination Stride / Buffer Base 0, p 133
+	out32(GEBC,base); // Destination Stride / Buffer Base 1, p 133
+	out32(GEC0,base); // Destination Stride / Buffer Base 2, p 133
+	out32(GEC4,base); // Destination Stride / Buffer Base 3, p 133
+	out32(GEC8,base); // Source Stride / Buffer Base 0, p 133
+	out32(GECC,base); // Source Stride / Buffer Base 1, p 133
+	out32(GED0,base); // Source Stride / Buffer Base 2, p 133
+	out32(GED4,base); // Source Stride / Buffer Base 3, p 133
+	out32(GE6C,0);	  // Pattern and Style, p 129, ok
+}
+
+//=====================================================================
+//
+// Although this is a .fb_sync function that could be enabled in
+// cyblafb_ops, we do not include it there. We sync immediately before
+// new GE operations to improve performance.
+//
+//=====================================================================
+
+static int cyblafb_sync(struct fb_info *info)
+{
+	int status, i=10000000;
+	while( ((status=in32(GE20)) & 0xFA800000) && i != 0)
+		i--;
+
+	if (i == 0) {
+		output("Sync Timeout, status: %x, resetting GE\n",status);
+		if(status & 0x80000000) output("Bresenham Engine : Busy\n");
+		if(status & 0x40000000) output("Setup Engine     : Busy\n");
+		if(status & 0x20000000) output("SP / DPE         : Busy\n");
+		if(status & 0x10000000) output("Memory Interface : Busy\n");
+		if(status & 0x08000000) output("Com Lst Proc     : Busy\n");
+		if(status & 0x04000000) output("Block Write      : Busy\n");
+		if(status & 0x02000000) output("Command Buffer   : Full\n");
+		if(status & 0x01000000) output("RESERVED         : Busy\n");
+		if(status & 0x00800000) output("PCI Write Buffer : Busy\n");
+
+		cyblafb_setup_GE(info->var.xres,info->var.bits_per_pixel);
+	}
+
+	return 0;
+}
+
+//==============================
+//
+// Cyberblade specific fillrect
+//
+//==============================
+
+static void cyblafb_fillrect(struct fb_info * info,
+			     const struct fb_fillrect *fr)
+{
+	int bpp = info->var.bits_per_pixel;
+	int col;
+
+	switch (bpp) {
+		default:
+		case 8: col = fr->color;
+			col |= col <<8;
+			col |= col <<16;
+			break;
+		case 16: col = ((u32 *)(info->pseudo_palette))[fr->color];
+			 col |= col <<16;
+			 break;
+		case 32: col = ((u32 *)(info->pseudo_palette))[fr->color];
+			 break;
+	}
+
+	cyblafb_sync(info);
+
+	out32(GE60,col);
+	out32(GE48,fr->rop ? 0x66:ROP_S);
+	out32(GE44,0x20000000|1<<19|1<<4|2<<2);
+	out32(GE08,point(fr->dx,fr->dy));
+	out32(GE0C,point(fr->dx+fr->width-1,fr->dy+fr->height-1));
+
+}
+
+//==============================
+//
+// Cyberblade specific copyarea
+//
+//==============================
+
+static void cyblafb_copyarea(struct fb_info *info,
+			     const struct fb_copyarea *ca)
+{
+	__u32 s1,s2,d1,d2;
+	int direction;
+
+	s1 = point(ca->sx,ca->sy);
+	s2 = point(ca->sx+ca->width-1,ca->sy+ca->height-1);
+	d1 = point(ca->dx,ca->dy);
+	d2 = point(ca->dx+ca->width-1,ca->dy+ca->height-1);
+	if ((ca->sy > ca->dy) || ((ca->sy == ca->dy) && (ca->sx > ca->dx)))
+		direction = 0;
+	else
+		direction = 2;
+
+	cyblafb_sync(info);
+
+	out32(GE44,0xa0000000|1<<19|1<<2|direction);
+	out32(GE00,direction?s2:s1);
+	out32(GE04,direction?s1:s2);
+	out32(GE08,direction?d2:d1);
+	out32(GE0C,direction?d1:d2);
+
+}
+
+//=======================================================================
+//
+// Cyberblade specific imageblit
+//
+// Accelerated for the most usual case, blitting 1-bit deep character
+// character images. Everything else is passed to the generic imageblit.
+//
+//=======================================================================
+
+void cyblafb_imageblit(struct fb_info *info, const struct fb_image *image)
+{
+
+	u32 fgcol, bgcol;
+
+	int i;
+	int bpp = info->var.bits_per_pixel;
+	int index = 0;
+	int index_end=image->height * image->width / 8;
+	int width_dds=image->width / 32;
+	int width_dbs=image->width % 32;
+
+	if (image->depth != 1 ||
+	    bpp < 8 || bpp > 32 || bpp % 8 != 0 ||
+	    image->width % 8 != 0 || image->width == 0 ||
+	    image->height == 0) {
+		cfb_imageblit(info,image);
+		return;
+	}
+
+	if (info->fix.visual == FB_VISUAL_TRUECOLOR ||
+	    info->fix.visual == FB_VISUAL_DIRECTCOLOR) {
+		fgcol = ((u32*)(info->pseudo_palette))[image->fg_color];
+		bgcol = ((u32*)(info->pseudo_palette))[image->bg_color];
+	} else {
+		fgcol = image->fg_color;
+		bgcol = image->bg_color;
+	}
+
+	switch (bpp) {
+		case 8:
+			fgcol |= fgcol <<8; fgcol |= fgcol <<16;
+			bgcol |= bgcol <<8; bgcol |= bgcol <<16;
+			break;
+		case 16:
+			fgcol |= fgcol <<16;
+			bgcol |= bgcol <<16;
+			break;
+		default:
+			 break;
+	}
+
+	cyblafb_sync(info);
+
+	out32(GE60,fgcol);
+	out32(GE64,bgcol);
+	out32(GE44,0xa0000000 | 1<<20 | 1<<19);
+	out32(GE08,point(image->dx,image->dy));
+	out32(GE0C,point(image->dx+image->width-1,image->dy+image->height-1));
+
+	while(index < index_end) {
+		for(i=0;i<width_dds;i++) {
+			out32(GE9C, *((u32*) ((u32) image->data + index)) );
+			index+=4;
+		}
+		switch(width_dbs) {
+			case 0:  break;
+			case 8:  out32(GE9C,*((u8*)((u32)image->data+index)));
+				 index+=1;
+				 break;
+			case 16: out32(GE9C,*((u16*)((u32)image->data+index)));
+				 index+=2;
+				 break;
+			case 24: out32(GE9C,(u32)(*((u16*)((u32)image->data
+				 + index))) | (u32)(*((u8*)((u32)image->data
+				 + index+2)))<<16);
+				 index+=3;
+				 break;
+		}
+	}
+}
+
+//=================================================
+//
+// Enable memory mapped io and unprotect registers
+//
+//=================================================
+
+static inline void enable_mmio(void)
+{
+	int tmp;
+
+	outb(0x0B,0x3C4);
+	inb(0x3C5);		// Set NEW mode
+	outb(SR0E,0x3C4);	// write enable a lot of extended ports
+	outb(0x80,0x3C5);
+
+	outb(SR11,0x3C4);	// write enable those extended ports that
+	outb(0x87,0x3C5);	// are not affected by SR0E_New
+
+	outb(CR1E,0x3d4);	// clear write protect bit for port 0x3c2
+	tmp=inb(0x3d5) & 0xBF;
+	outb(CR1E,0x3d4);
+	outb(tmp,0x3d5);
+
+	outb(CR39,0x3D4);
+	outb(inb(0x3D5)|0x01,0x3D5); // Enable mmio, everything else untouched
+}
+
+//=====================================
+//
+// Get native resolution of flat panel
+//
+//=====================================
+
+static int __init get_nativex(void)
+{
+	int x,y,tmp;
+
+	if (nativex)
+		return nativex;
+
+	tmp = (read3CE(GR52) >> 4) & 3;
+
+	switch (tmp) {
+		case 0:  x = 1280; y = 1024; break;
+		case 2:  x = 1024; y = 768;  break;
+		case 3:  x = 800;  y = 600;  break;
+		case 4:  x = 1400; y = 1050; break;
+		case 1:
+		default: x = 640;  y = 480;  break;
+	}
+
+	if (verbosity > 0)
+		output("%dx%d flat panel found\n", x, y);
+	return x;
+}
+
+//=================================================
+//
+// Set pixel clock VCLK1
+//   - multipliers set elswhere
+//   - freq in units of 0.01 MHz
+//
+//=================================================
+
+static void set_vclk(int freq)
+{
+	u32 m,n,k;
+	int f,fi,d,di;
+	u8 lo=0,hi=0;
+
+	d = 2000;
+	k = freq >= 10000 ? 0 : freq >= 5000 ? 1 : freq >= 2500 ? 2 : 3;
+	for(m = 0;m<64;m++)
+	for(n = 0;n<250;n++) { // max 249 is a hardware limit for cybla/i1 !
+		fi = (int)(((5864727*(n+8))/((m+2)*(1<<k)))>>12);
+		if ((di = abs(fi - freq)) < d) {
+			d = di;
+			f = fi;
+			lo = (u8) n;
+			hi = (u8) ((k<<6) | m);
+		}
+	}
+	write3C4(SR19,hi);
+	write3C4(SR18,lo);
+	if(verbosity > 1)
+		output("pixclock = %d.%02d MHz, k/m/n %x %x %x\n",
+		freq/100,freq%100,(hi&0xc0)>>6,hi&0x3f,lo);
+}
+
+//=========================================================
+//
+// Detect if a flat panel monitor connected to the special
+// interface is active. Override is possible by fp and crt
+// parameters.
+//
+//=========================================================
+
+static unsigned int __init get_displaytype(void)
+{
+	if (fp)
+		return DISPLAY_FP;
+	if (crt)
+		return DISPLAY_CRT;
+	return (read3CE(GR33) & 0x10)?DISPLAY_FP:DISPLAY_CRT;
+}
+
+//========================================================
+//
+// Detect activated memory size. Undefined values require
+// memsize parameter.
+//
+//========================================================
+
+static unsigned int __init get_memsize(void)
+{
+	unsigned char tmp;
+	unsigned int k;
+
+	if (memsize)
+		k = memsize * Kb;
+	else {
+		tmp = read3X4(CR1F) & 0x0F;
+		switch (tmp) {
+			case 0x03: k = 1 * Mb; break;
+			case 0x07: k = 2 * Mb; break;
+			case 0x0F: k = 4 * Mb; break;
+			case 0x04: k = 8 * Mb; break;
+			default:
+				k = 1 * Mb;
+				output("Unknown memory size code %x in CR1F."
+				       " We default to 1 Mb for now, please"
+				       " do provide a memsize parameter!\n",
+				       tmp);
+		}
+	}
+
+	if (verbosity > 0)
+		output("framebuffer size = %d Kb\n", k/Kb);
+	return k;
+}
+
+//==========================================================
+//
+// Check if video mode is acceptable. We change var->??? if
+// video mode is slightly off or return error otherwise.
+// info->??? must not be changed!
+//
+//==========================================================
+
+static int cyblafb_check_var(struct fb_var_screeninfo *var,
+			     struct fb_info *info)
+{
+	int bpp = var->bits_per_pixel;
+	int s,t,maxvyres;
+
+	//
+	// we try to support 8, 16, 24 and 32 bpp modes,
+	// default to 8
+	//
+	// there is a 24 bpp mode, but for now we change requests to 32 bpp
+	// (This is what tridentfb does ... will be changed in the future)
+	//
+	//
+	if ( bpp % 8 != 0 || bpp < 8 || bpp >32)
+		bpp = 8;
+	if (bpp == 24 )
+		bpp = var->bits_per_pixel = 32;
+
+
+	//
+	// interlaced modes are broken, fail if one is requested
+	//
+	if (var->vmode & FB_VMODE_INTERLACED)
+		return -EINVAL;
+
+	//
+	// fail if requested resolution is higher than physical
+	// flatpanel resolution
+	//
+	if (flatpanel && nativex && var->xres > nativex)
+		return -EINVAL;
+
+	//
+	// xres != xres_virtual is broken, fail if such an
+	// unusual mode is requested
+	//
+	if (var->xres != var->xres_virtual)
+		return -EINVAL;
+
+	//
+	// we do not allow vclk to exceed 230 MHz
+	//
+	if ((bpp==32 ? 200000000 : 100000000) / var->pixclock > 23000)
+		return -EINVAL;
+
+	//
+	// calc max yres_virtual that would fit in memory
+	// and max yres_virtual that could be used for scrolling
+	// and use minimum of the results as maxvyres
+	//
+	// adjust vyres_virtual to maxvyres if necessary
+	// fail if requested yres is bigger than maxvyres
+	//
+	s = (0x1fffff / (var->xres * bpp/8)) + var->yres;
+	t = info->fix.smem_len / (var->xres * bpp/8);
+	maxvyres = t < s ? t : s;
+	if (maxvyres < var->yres_virtual)
+		var->yres_virtual=maxvyres;
+	if (maxvyres < var->yres)
+		return -EINVAL;
+
+	switch (bpp) {
+		case 8:
+			var->red.offset = 0;
+			var->green.offset = 0;
+			var->blue.offset = 0;
+			var->red.length = 6;
+			var->green.length = 6;
+			var->blue.length = 6;
+			break;
+		case 16:
+			var->red.offset = 11;
+			var->green.offset = 5;
+			var->blue.offset = 0;
+			var->red.length = 5;
+			var->green.length = 6;
+			var->blue.length = 5;
+			break;
+		case 32:
+			var->red.offset = 16;
+			var->green.offset = 8;
+			var->blue.offset = 0;
+			var->red.length = 8;
+			var->green.length = 8;
+			var->blue.length = 8;
+			break;
+		default:
+			return -EINVAL;
+	}
+
+	return 0;
+
+}
+//=====================================================================
+//
+// Pan the display
+//
+// The datasheets defines crt start address to be 20 bits wide and
+// to be programmed to CR0C, CR0D, CR1E and CR27. Actually there is
+// CR2B[5] as an undocumented extension bit. Epia BIOS 2.07 does use
+// it, so it is also safe to be used here. BTW: datasheet CR0E on page
+// 90 really is CR1E, the real CRE is documented on page 72.
+//
+//=====================================================================
+
+static int cyblafb_pan_display(struct fb_var_screeninfo *var,
+				   struct fb_info *info)
+{
+	unsigned int offset;
+
+	offset = (var->xoffset + (var->yoffset * var->xres)) *
+		 var->bits_per_pixel/32;
+	info->var.xoffset = var->xoffset;
+	info->var.yoffset = var->yoffset;
+
+	write3X4(CR0D, offset & 0xFF);
+	write3X4(CR0C, (offset & 0xFF00) >> 8);
+	write3X4(CR1E, (read3X4(CR1E) & 0xDF) | ((offset & 0x10000) >> 11));
+	write3X4(CR27, (read3X4(CR27) & 0xF8) | ((offset & 0xE0000) >> 17));
+	write3X4(CR2B, (read3X4(CR2B) & 0xDF) | ((offset & 0x100000) >> 15));
+
+	return 0;
+}
+
+//============================================
+//
+// This will really help in case of a bug ...
+// dump most gaphics core registers.
+//
+//============================================
+
+static void regdump(void)
+{
+	int i;
+
+	if (verbosity < 2)
+		return;
+
+	printk("\n");
+	for(i=0; i<=0xff; i++) {
+		outb(i,0x3d4);
+		printk("CR%02x=%02x ", i, inb(0x3d5));
+		if (i%16==15)
+			printk("\n");
+	}
+
+	outb(0x30,0x3ce);
+	outb(inb(0x3cf) | 0x40,0x3cf);
+	for(i=0; i<=0x1f; i++) {
+		if (i==0 || (i>2 && i<8) || i==0x10 || i==0x11 || i==0x16) {
+			outb(i,0x3d4);
+			printk("CR%02x=%02x ", i, inb(0x3d5));
+		} else
+			printk("------- ");
+		if (i%16==15)
+			printk("\n");
+	}
+	outb(0x30,0x3ce);
+	outb(inb(0x3cf) & 0xbf,0x3cf);
+
+	printk("\n");
+	for(i=0; i<=0x7f; i++) {
+		outb(i,0x3ce);
+		printk("GR%02x=%02x ", i, inb(0x3cf));
+		if (i%16==15)
+			printk("\n");
+	}
+
+	printk("\n");
+	for(i=0; i<=0xff; i++) {
+		outb(i,0x3c4);
+		printk("SR%02x=%02x ", i, inb(0x3c5));
+		if (i%16==15)
+			printk("\n");
+	}
+
+	printk("\n");
+	for(i=0; i <= 0x1F; i++) {
+		inb(0x3da); // next access is index!
+		outb(i,0x3c0);
+		printk("AR%02x=%02x ", i, inb(0x3c1));
+		if (i%16==15)
+			printk("\n");
+	}
+	printk("\n");
+
+	inb(0x3DA);			//reset internal flag to 3c0 index
+	outb(0x20,0x3C0);		//enable attr
+
+	return;
+}
+
+//==========================================================================
+//
+// getstartupmode() decides about the inital video mode
+//
+// There is no reason to use modedb, a lot of video modes there would
+// need altered timings to display correctly. So I decided that it is much
+// better to provide a limited optimized set of modes plus the option of
+// using the mode in effect at startup time (might be selected using the
+// vga=??? paramter). After that the user might use fbset to select any
+// mode he likes, check_var will not try to alter geometry parameters as
+// it would be necessary otherwise.
+//
+//==========================================================================
+
+static int __init getstartupmode(void)
+{
+	u32	htotal,hdispend,hsyncstart,hsyncend,hblankstart,hblankend,
+		vtotal,vdispend,vsyncstart,vsyncend,vblankstart,vblankend,
+		cr00,cr01,cr02,cr03,cr04,cr05,cr2b,
+		cr06,cr07,cr09,cr10,cr11,cr12,cr15,cr16,cr27,
+		cr38,
+		sr0d,sr18,sr19,
+		gr0f,
+		fi,pxclkdiv,vclkdiv,tmp,i;
+
+	struct modus {
+		int xres; int yres; int vyres; int bpp; int pxclk;
+		int left_margin; int right_margin; int upper_margin;
+		int lower_margin; int hsync_len; int vsync_len;
+	}  modedb[5] = {
+		{   0,	  0, 8000, 0, 0,   0,  0,  0, 0,   0,  0},
+		{ 640,	480, 3756, 0, 0, -40, 24, 17, 0, 216,  3},
+		{ 800,	600, 3221, 0, 0,  96, 24, 14, 0, 136, 11},
+		{1024,	768, 2815, 0, 0, 144, 24, 29, 0, 120,  3},
+		{1280, 1024, 2662, 0, 0, 232, 16, 39, 0, 160,  3}
+	};
+
+	outb(0x00,0x3d4); cr00=inb(0x3d5); outb(0x01,0x3d4); cr01=inb(0x3d5);
+	outb(0x02,0x3d4); cr02=inb(0x3d5); outb(0x03,0x3d4); cr03=inb(0x3d5);
+	outb(0x04,0x3d4); cr04=inb(0x3d5); outb(0x05,0x3d4); cr05=inb(0x3d5);
+	outb(0x06,0x3d4); cr06=inb(0x3d5); outb(0x07,0x3d4); cr07=inb(0x3d5);
+	outb(0x09,0x3d4); cr09=inb(0x3d5); outb(0x10,0x3d4); cr10=inb(0x3d5);
+	outb(0x11,0x3d4); cr11=inb(0x3d5); outb(0x12,0x3d4); cr12=inb(0x3d5);
+	outb(0x15,0x3d4); cr15=inb(0x3d5); outb(0x16,0x3d4); cr16=inb(0x3d5);
+	outb(0x27,0x3d4); cr27=inb(0x3d5); outb(0x2b,0x3d4); cr2b=inb(0x3d5);
+	outb(0x38,0x3d4); cr38=inb(0x3d5); outb(0x0b,0x3c4); inb(0x3c5);
+	outb(0x0d,0x3c4); sr0d=inb(0x3c5); outb(0x18,0x3c4); sr18=inb(0x3c5);
+	outb(0x19,0x3c4); sr19=inb(0x3c5); outb(0x0f,0x3ce); gr0f=inb(0x3cf);
+
+	htotal	    = cr00 | (cr2b & 0x01) << 8;
+	hdispend    = cr01 | (cr2b & 0x02) << 7;
+	hblankstart = cr02 | (cr2b & 0x10) << 4;
+	hblankend   = (cr03 & 0x1f) | (cr05 & 0x80) >> 2;
+	hsyncstart  = cr04 | (cr2b & 0x08) << 5;
+	hsyncend    = cr05 & 0x1f;
+
+	modedb[0].xres = hblankstart * 8;
+	modedb[0].hsync_len = hsyncend * 8;
+	modedb[0].right_margin = hsyncstart * 8 - modedb[0].xres;
+	modedb[0].left_margin = (htotal + 5) * 8 - modedb[0].xres -
+		modedb[0].right_margin - modedb[0].hsync_len;
+
+	vtotal	    = cr06 | (cr07 & 0x01) << 8 | (cr07 & 0x20) << 4
+			   | (cr27 & 0x80) << 3;
+	vdispend    = cr12 | (cr07 & 0x02) << 7 | (cr07 & 0x40) << 3
+			   | (cr27 & 0x10) << 6;
+	vsyncstart  = cr10 | (cr07 & 0x04) << 6 | (cr07 & 0x80) << 2
+			   | (cr27 & 0x20) << 5;
+	vsyncend    = cr11 & 0x0f;
+	vblankstart = cr15 | (cr07 & 0x08) << 5 | (cr09 & 0x20) << 4
+			   | (cr27 & 0x40) << 4;
+	vblankend   = cr16;
+
+	modedb[0].yres	       = vdispend + 1;
+	modedb[0].vsync_len    = vsyncend;
+	modedb[0].lower_margin = vsyncstart - modedb[0].yres;
+	modedb[0].upper_margin = vtotal - modedb[0].yres -
+		modedb[0].lower_margin - modedb[0].vsync_len + 2;
+
+	tmp = cr38 & 0x3c;
+	modedb[0].bpp = tmp == 0 ? 8 : tmp == 4 ? 16 : tmp == 28 ? 24 :
+			tmp == 8 ? 32 : 8;
+
+	fi = ((5864727*(sr18+8))/(((sr19&0x3f)+2)*(1<<((sr19&0xc0)>>6))))>>12;
+	pxclkdiv = ((gr0f & 0x08) >> 3 | (gr0f & 0x40) >> 5) + 1;
+	tmp = sr0d & 0x06;
+	vclkdiv = tmp == 0 ? 2 : tmp == 2 ? 4 : tmp == 4 ? 8 : 3; // * 2 !
+	modedb[0].pxclk = ((100000000 * pxclkdiv * vclkdiv) >> 1) / fi;
+
+	if (verbosity > 0)
+		output("detected startup mode: "
+		       "fbset -g %d %d %d ??? %d -t %d %d %d %d %d %d %d\n",
+		       modedb[0].xres,modedb[0].yres,modedb[0].xres,
+		       modedb[0].bpp,modedb[0].pxclk,modedb[0].left_margin,
+		       modedb[0].right_margin,modedb[0].upper_margin,
+		       modedb[0].lower_margin,modedb[0].hsync_len,
+		       modedb[0].vsync_len);
+
+	//
+	// We use this goto target in case of a failed check_var. No, I really
+	// do not want to do it in another way!
+	//
+
+	tryagain:
+
+	i = (mode == NULL) ? 0 :
+	    !strncmp(mode,"640x480",7) ? 1 :
+	    !strncmp(mode,"800x600",7) ? 2 :
+	    !strncmp(mode,"1024x768",8) ? 3 :
+	    !strncmp(mode,"1280x1024",9) ? 4 : 0;
+
+	ref = (ref < 50) ? 50 : (ref > 85) ? 85 : ref;
+
+	if(i==0) {
+		default_var.pixclock = modedb[i].pxclk;
+		default_var.bits_per_pixel = modedb[i].bpp;
+	} else {
+		default_var.pixclock = (100000000 /
+			((modedb[i].left_margin + modedb[i].xres +
+			  modedb[i].right_margin + modedb[i].hsync_len
+			 ) * (
+			  modedb[i].upper_margin + modedb[i].yres +
+			  modedb[i].lower_margin + modedb[i].vsync_len
+			 ) *
+			  ref / 10000
+			));
+		default_var.bits_per_pixel = bpp;
+	}
+
+	default_var.left_margin = modedb[i].left_margin;
+	default_var.right_margin = modedb[i].right_margin;
+	default_var.xres = modedb[i].xres;
+	default_var.xres_virtual = modedb[i].xres;
+	default_var.xoffset = 0;
+	default_var.hsync_len = modedb[i].hsync_len;
+	default_var.upper_margin = modedb[i].upper_margin;
+	default_var.yres = modedb[i].yres;
+	default_var.yres_virtual = modedb[i].vyres;
+	default_var.yoffset = 0;
+	default_var.lower_margin = modedb[i].lower_margin;
+	default_var.vsync_len = modedb[i].vsync_len;
+	default_var.sync = 0;
+	default_var.vmode = FB_VMODE_NONINTERLACED;
+
+	if(cyblafb_check_var(&default_var,&fb_info)) {
+		// 640x480-8@75 should really never fail. One case would
+		// be fp == 1 and nativex < 640 ... give up then
+		if(i==1 && bpp == 8 && ref == 75){
+			output("Can't find a valid mode :-(\n");
+			return -EINVAL;
+		}
+		// Our detected mode is unlikely to fail. If it does,
+		// try 640x480-8@75 ...
+		if(i==0) {
+			mode="640x480";
+			bpp=8;
+			ref=75;
+			output("Detected mode failed check_var! "
+			       "Trying 640x480-8@75\n");
+			goto tryagain;
+		}
+		// A specified video mode failed for some reason.
+		// Try the startup mode first
+		output("Specified mode '%s' failed check! "
+			"Falling back to startup mode.\n",mode);
+		mode=NULL;
+		goto tryagain;
+	}
+
+	return 0;
+
+}
+
+//======================================
+//
+// Set hardware to requested video mode
+//
+//======================================
+
+static int cyblafb_set_par(struct fb_info *info)
+{
+	u32
+	htotal,hdispend,hsyncstart,hsyncend,hblankstart,hblankend,preendfetch,
+		vtotal,vdispend,vsyncstart,vsyncend,vblankstart,vblankend;
+	struct fb_var_screeninfo *var = &info->var;
+	int bpp = var->bits_per_pixel;
+	int i;
+
+	if (verbosity > 0)
+		output("Switching to new mode: "
+		       "fbset -g %d %d %d %d %d -t %d %d %d %d %d %d %d\n",
+			var->xres,var->yres,var->xres_virtual,
+			var->yres_virtual,var->bits_per_pixel,var->pixclock,
+			var->left_margin,var->right_margin,var->upper_margin,
+			var->lower_margin,var->hsync_len, var->vsync_len);
+
+	htotal = (var->xres + var->left_margin + var->right_margin +
+		 var->hsync_len)/8 - 5;
+	hdispend = var->xres/8 - 1;
+	hsyncstart = (var->xres + var->right_margin)/8;
+	hsyncend = var->hsync_len/8;
+	hblankstart = hdispend + 1;
+	hblankend = htotal + 3; // should be htotal + 5, bios does it this way
+	preendfetch = ((var->xres >> 3) + 1) * ((bpp+1) >> 3);
+
+	vtotal = var->yres + var->upper_margin + var->lower_margin +
+		 var->vsync_len - 2;
+	vdispend = var->yres - 1;
+	vsyncstart = var->yres + var->lower_margin;
+	vblankstart = var->yres;
+	vblankend = vtotal; // should be vtotal + 2, but bios does it this way
+	vsyncend = var->vsync_len;
+
+	enable_mmio();		// necessary! ... check X ...
+
+	write3X4(CR11, read3X4(CR11) & 0x7F); // unlock cr00 .. cr07
+
+	write3CE(GR30,8);
+
+	if (flatpanel && var->xres < nativex) {
+		/*
+		 * on flat panels with native size larger
+		 * than requested resolution decide whether
+		 * we stretch or center
+		 */
+		out8(0x3C2,0xEB);
+
+		write3CE(GR30,read3CE(GR30) | 0x81); // shadow mode on
+
+		if (center) {
+			write3CE(GR52,(read3CE(GR52) & 0x7C) | 0x80);
+			write3CE(GR53,(read3CE(GR53) & 0x7C) | 0x80);
+		}
+		else if (stretch) {
+			write3CE(GR5D,0);
+			write3CE(GR52,(read3CE(GR52) & 0x7C) | 1);
+			write3CE(GR53,(read3CE(GR53) & 0x7C) | 1);
+		}
+
+	} else {
+		out8(0x3C2,0x2B);
+		write3CE(GR30,8);
+	}
+
+	//
+	// Setup CRxx regs
+	//
+
+	write3X4(CR00, htotal & 0xFF);
+	write3X4(CR01, hdispend & 0xFF);
+	write3X4(CR02, hblankstart & 0xFF);
+	write3X4(CR03, hblankend & 0x1F);
+	write3X4(CR04, hsyncstart & 0xFF);
+	write3X4(CR05, (hsyncend & 0x1F) | ((hblankend & 0x20)<<2));
+	write3X4(CR06, vtotal & 0xFF);
+	write3X4(CR07, (vtotal & 0x100) >> 8 |
+		       (vdispend & 0x100) >> 7 |
+		       (vsyncstart & 0x100) >> 6 |
+		       (vblankstart & 0x100) >> 5 |
+		       0x10 |
+		       (vtotal & 0x200) >> 4 |
+		       (vdispend & 0x200) >> 3 |
+		       (vsyncstart & 0x200) >> 2);
+	write3X4(CR08, 0);
+	write3X4(CR09, (vblankstart & 0x200) >> 4 | 0x40 |  // FIX !!!
+		       ((info->var.vmode & FB_VMODE_DOUBLE) ? 0x80 : 0));
+	write3X4(CR0A, 0);  // Init to some reasonable default
+	write3X4(CR0B, 0);  // Init to some reasonable default
+	write3X4(CR0C, 0);  // Offset 0
+	write3X4(CR0D, 0);  // Offset 0
+	write3X4(CR0E, 0);  // Init to some reasonable default
+	write3X4(CR0F, 0);  // Init to some reasonable default
+	write3X4(CR10, vsyncstart & 0xFF);
+	write3X4(CR11, (vsyncend & 0x0F));
+	write3X4(CR12, vdispend & 0xFF);
+	write3X4(CR13, ((info->var.xres * bpp)/(4*16)) & 0xFF);
+	write3X4(CR14, 0x40);  // double word mode
+	write3X4(CR15, vblankstart & 0xFF);
+	write3X4(CR16, vblankend & 0xFF);
+	write3X4(CR17, 0xC3);
+	write3X4(CR18, 0xFF);
+	// CR19: needed for interlaced modes ... ignore it for now
+	write3X4(CR1A, 0x07); // Arbitration Control Counter 1
+	write3X4(CR1B, 0x07); // Arbitration Control Counter 2
+	write3X4(CR1C, 0x07); // Arbitration Control Counter 3
+	write3X4(CR1D, 0x00); // Don't know, doesn't hurt ;-)
+	write3X4(CR1E, (info->var.vmode & FB_VMODE_INTERLACED) ? 0x84 : 0x80);
+	// CR1F: do not set, contains BIOS info about memsize
+	write3X4(CR20, 0x20); // enabe wr buf, disable 16bit planar mode
+	write3X4(CR21, 0x20); // enable linear memory access
+	// CR22: RO cpu latch readback
+	// CR23: ???
+	// CR24: RO AR flag state
+	// CR25: RAMDAC read write timing, pclk buffer tristate control ????
+	// CR26: ???
+	write3X4(CR27, (vdispend & 0x400) >> 6 |
+		       (vsyncstart & 0x400) >> 5 |
+		       (vblankstart & 0x400) >> 4 |
+		       (vtotal & 0x400) >> 3 |
+		       0x8);
+	// CR28: ???
+	write3X4(CR29, (read3X4(CR29) & 0xCF) |
+		       ((((info->var.xres * bpp) / (4*16)) & 0x300) >>4));
+	write3X4(CR2A, read3X4(CR2A) | 0x40);
+	write3X4(CR2B, (htotal & 0x100) >> 8 |
+		       (hdispend & 0x100) >> 7 |
+		       // (0x00 & 0x100) >> 6 |   hinterlace para bit 8 ???
+		       (hsyncstart & 0x100) >> 5 |
+		       (hblankstart & 0x100) >> 4);
+	// CR2C: ???
+	// CR2D: initialized in cyblafb_setup_GE()
+	write3X4(CR2F, 0x92); // conservative, better signal quality
+	// CR30: reserved
+	// CR31: reserved
+	// CR32: reserved
+	// CR33: reserved
+	// CR34: disabled in CR36
+	// CR35: disabled in CR36
+	// CR36: initialized in cyblafb_setup_GE
+	// CR37: i2c, ignore for now
+	write3X4(CR38, (bpp ==	8) ? 0x00 :	 //
+		       (bpp == 16) ? 0x05 :	 // highcolor
+		       (bpp == 24) ? 0x29 :	 // packed 24bit truecolor
+		       (bpp == 32) ? 0x09 : 0);  // truecolor, 16 bit pixelbus
+	write3X4(CR39, 0x01 |			 // MMIO enable
+		       (pcirb ? 0x02 : 0) |	 // pci read burst enable
+		       (pciwb ? 0x04 : 0));	 // pci write burst enable
+	write3X4(CR55, 0x1F | // pci clocks * 2 for STOP# during 1st data phase
+		       (pcirr ? 0x40 : 0) |	 // pci read retry enable
+		       (pciwr ? 0x80 : 0));	 // pci write retry enable
+	write3X4(CR56, preendfetch >> 8 < 2 ? (preendfetch >> 8 & 0x01)|2 : 0);
+	write3X4(CR57, preendfetch >> 8 < 2 ? preendfetch & 0xff : 0);
+
+	write3X4(CR58, 0x82); // Bios does this .... don't know more
+	//
+	// Setup SRxx regs
+	//
+	write3C4(SR00,3);
+	write3C4(SR01,1);	//set char clock 8 dots wide
+	write3C4(SR02,0x0F);	//enable 4 maps needed in chain4 mode
+	write3C4(SR03,0);	//no character map select
+	write3C4(SR04,0x0E);	//memory mode: ext mem, even, chain4
+
+	out8(0x3C4,0x0b);
+	in8(0x3C5);		// Set NEW mode
+	write3C4(SR0D,0x00);	// test ... check
+
+	set_vclk((bpp==32?200000000:100000000)/info->var.pixclock); //SR18,SR19
+
+	//
+	// Setup GRxx regs
+	//
+	write3CE(GR00,0x00);  // test ... check
+	write3CE(GR01,0x00);  // test ... check
+	write3CE(GR02,0x00);  // test ... check
+	write3CE(GR03,0x00);  // test ... check
+	write3CE(GR04,0x00);  // test ... check
+	write3CE(GR05,0x40);  //no CGA compat,allow 256 col
+	write3CE(GR06,0x05);  //graphics mode
+	write3CE(GR07,0x0F);  //planes?
+	write3CE(GR08,0xFF);  // test ... check
+	write3CE(GR0F,(bpp==32)?0x1A:0x12); // div vclk by 2 if 32bpp, chain4
+	write3CE(GR20,0xC0);	// test ... check
+	write3CE(GR2F,0xA0);	// PCLK = VCLK, no skew,
+
+	//
+	// Setup ARxx regs
+	//
+	for(i = 0;i < 0x10;i++) // set AR00 .. AR0f
+		write3C0(i,i);
+	write3C0(AR10,0x41);	// graphics mode and support 256 color modes
+	write3C0(AR12,0x0F);	// planes
+	write3C0(AR13,0);	// horizontal pel panning
+	in8(0x3DA);		// reset internal flag to 3c0 index
+	out8(0x3C0,0x20);	// enable attr
+
+	//
+	// Setup hidden RAMDAC command register
+	//
+	in8(0x3C8);  // these reads are
+	in8(0x3C6);  // necessary to
+	in8(0x3C6);  // unmask the RAMDAC
+	in8(0x3C6);  // command reg, otherwise
+	in8(0x3C6);  // we would write the pixelmask reg!
+	out8(0x3C6,(bpp ==  8) ? 0x00 : 	// 256 colors
+		   (bpp == 15) ? 0x10 : 	//
+		   (bpp == 16) ? 0x30 : 	// hicolor
+		   (bpp == 24) ? 0xD0 : 	// truecolor
+		   (bpp == 32) ? 0xD0 : 0);	// truecolor
+	in8(0x3C8);
+
+	//
+	// GR31 is not mentioned in the datasheet
+	//
+	if (flatpanel)
+		write3CE(GR31, (read3CE(GR31) & 0x8F) |
+			 ((info->var.yres > 1024) ? 0x50 :
+			 (info->var.yres >   768) ? 0x30 :
+			 (info->var.yres >   600) ? 0x20 :
+			 (info->var.yres >   480) ? 0x10 : 0));
+
+	info->fix.visual = (bpp == 8) ? FB_VISUAL_PSEUDOCOLOR
+				      : FB_VISUAL_TRUECOLOR;
+	info->fix.line_length = info->var.xres * (bpp >> 3);
+	info->cmap.len = (bpp == 8) ? 256: 16;
+
+	//
+	// init acceleration engine
+	//
+	cyblafb_setup_GE(info->var.xres,info->var.bits_per_pixel);
+
+	regdump();
+
+	return 0;
+}
+
+//========================
+//
+// Set one color register
+//
+//========================
+
+static int cyblafb_setcolreg(unsigned regno, unsigned red, unsigned green,
+				 unsigned blue, unsigned transp,
+				 struct fb_info *info)
+{
+	int bpp = info->var.bits_per_pixel;
+
+	if (regno >= info->cmap.len)
+		return 1;
+
+	if (bpp == 8) {
+		out8(0x3C6,0xFF);
+		out8(0x3C8,regno);
+		out8(0x3C9,red>>10);
+		out8(0x3C9,green>>10);
+		out8(0x3C9,blue>>10);
+
+	} else if (bpp == 16)			/* RGB 565 */
+		((u32*)info->pseudo_palette)[regno] =
+			(red & 0xF800) |
+			((green & 0xFC00) >> 5) |
+			((blue & 0xF800) >> 11);
+	else if (bpp == 32)			/* ARGB 8888 */
+		((u32*)info->pseudo_palette)[regno] =
+			((transp & 0xFF00) <<16) |
+			((red & 0xFF00) << 8) |
+			((green & 0xFF00)) |
+			((blue & 0xFF00)>>8);
+
+	return 0;
+}
+
+//==========================================================
+//
+// Try blanking the screen. For flat panels it does nothing
+//
+//==========================================================
+
+static int cyblafb_blank(int blank_mode, struct fb_info *info)
+{
+	unsigned char PMCont,DPMSCont;
+
+	if (flatpanel)
+		return 0;
+
+	out8(0x83C8,0x04); /* Read DPMS Control */
+
+	PMCont = in8(0x83C6) & 0xFC;
+
+	DPMSCont = read3CE(GR23) & 0xFC;
+
+	switch (blank_mode)
+	{
+	case FB_BLANK_UNBLANK:
+		/* Screen: On, HSync: On, VSync: On */
+	case FB_BLANK_NORMAL:
+		/* Screen: Off, HSync: On, VSync: On */
+		PMCont |= 0x03;
+		DPMSCont |= 0x00;
+		break;
+	case FB_BLANK_HSYNC_SUSPEND:
+		/* Screen: Off, HSync: Off, VSync: On */
+		PMCont |= 0x02;
+		DPMSCont |= 0x01;
+		break;
+	case FB_BLANK_VSYNC_SUSPEND:
+		/* Screen: Off, HSync: On, VSync: Off */
+		PMCont |= 0x02;
+		DPMSCont |= 0x02;
+		break;
+	case FB_BLANK_POWERDOWN:
+		/* Screen: Off, HSync: Off, VSync: Off */
+		PMCont |= 0x00;
+		DPMSCont |= 0x03;
+		break;
+	}
+
+	write3CE(GR23,DPMSCont);
+	out8(0x83C8,4);
+	out8(0x83C6,PMCont);
+
+	/* let fbcon do a softblank for us */
+	return (blank_mode == FB_BLANK_NORMAL) ? 1 : 0;
+}
+
+
+static int __devinit cybla_pci_probe(struct pci_dev * dev,
+				     const struct pci_device_id * id)
+{
+
+	fb_info.par = &default_par;
+
+	if (pci_enable_device(dev)) {
+		output("could not enable device!\n");
+		goto errout_enable;
+	}
+
+	// might already be requested by vga console or vesafb,
+	// so we do care about success
+	request_region(0x3c0, 32, "cyblafb");
+
+	//
+	// Graphics Engine Registers
+	//
+	request_region(GEBase, 0x100, "cyblafb");
+
+	regdump();
+
+	enable_mmio();
+
+	/* setup MMIO region */
+	cyblafb_fix.mmio_start = pci_resource_start(dev,1);
+	cyblafb_fix.mmio_len = 0x20000;
+
+	if (!request_mem_region(cyblafb_fix.mmio_start,
+				cyblafb_fix.mmio_len, "cyblafb")) {
+		output("request_mem_region failed for mmio region!\n");
+		goto errout_mmio_reqmem;
+	}
+
+	default_par.io_virt = ioremap_nocache(cyblafb_fix.mmio_start,
+			      cyblafb_fix.mmio_len);
+
+	if (!default_par.io_virt) {
+		output("ioremap failed for mmio region\n");
+		goto errout_mmio_remap;
+	}
+
+	// setup framebuffer memory ... might already be requested
+	// by vesafb. Not to fail in case of an unsuccessful request
+	// is useful for the development cycle
+	cyblafb_fix.smem_start = pci_resource_start(dev,0);
+	cyblafb_fix.smem_len = get_memsize();
+
+	if (!request_mem_region(cyblafb_fix.smem_start,
+				cyblafb_fix.smem_len, "cyblafb")) {
+		output("request_mem_region failed for smem region!\n");
+		if (!vesafb)
+			goto errout_smem_req;
+	}
+
+	fb_info.screen_base = ioremap_nocache(cyblafb_fix.smem_start,
+					cyblafb_fix.smem_len);
+
+	if (!fb_info.screen_base) {
+		output("ioremap failed for smem region\n");
+		goto errout_smem_remap;
+	}
+
+	displaytype = get_displaytype();
+
+	if(flatpanel)
+		nativex = get_nativex();
+
+	fb_info.fix = cyblafb_fix;
+	fb_info.fbops = &cyblafb_ops;
+
+	//
+	// FBINFO_HWACCEL_YWRAP    .... does not work (could be made to work)
+	// FBINFO_PARTIAL_PAN_OK   .... is not ok
+	// FBINFO_READS_FAST	   .... is necessary for optimal scrolling
+	//
+	fb_info.flags = FBINFO_DEFAULT | FBINFO_HWACCEL_YPAN
+		      | FBINFO_HWACCEL_COPYAREA | FBINFO_HWACCEL_FILLRECT
+		      | FBINFO_HWACCEL_IMAGEBLIT | FBINFO_READS_FAST;
+
+	fb_info.pseudo_palette = pseudo_pal;
+
+	if(getstartupmode())
+		goto errout_findmode;
+
+	fb_alloc_cmap(&fb_info.cmap,256,0);
+
+	fb_info.var = default_var;
+	fb_info.device = &dev->dev;
+
+	if (register_framebuffer(&fb_info)) {
+		output("Could not register CyBla framebuffer\n");
+		goto errout_register;
+	}
+
+	return 0;
+
+	//
+	// error paths
+	//
+
+	errout_register:
+	errout_findmode:
+		iounmap(fb_info.screen_base);
+	errout_smem_remap:
+		release_mem_region(cyblafb_fix.smem_start,
+		                     cyblafb_fix.smem_len);
+	errout_smem_req:
+		iounmap(default_par.io_virt);
+	errout_mmio_remap:
+		release_mem_region(cyblafb_fix.mmio_start,
+		                     cyblafb_fix.mmio_len);
+	errout_mmio_reqmem:
+//		release_region(0x3c0, 32);
+	errout_enable:
+
+	output("CyblaFB version %s aborting init.\n", VERSION);
+	return -ENODEV;
+}
+
+static void __devexit cybla_pci_remove(struct pci_dev * dev)
+{
+	struct cyblafb_par *par = (struct cyblafb_par*)fb_info.par;
+
+	unregister_framebuffer(&fb_info);
+	iounmap(par->io_virt);
+	iounmap(fb_info.screen_base);
+	release_mem_region(cyblafb_fix.smem_start, cyblafb_fix.smem_len);
+	release_mem_region(cyblafb_fix.mmio_start, cyblafb_fix.mmio_len);
+	output("CyblaFB version %s normal exit.\n", VERSION);
+}
+
+/* List of boards that we are trying to support */
+static struct pci_device_id cybla_devices[] = {
+	{PCI_VENDOR_ID_TRIDENT, CYBERBLADEi1, PCI_ANY_ID,PCI_ANY_ID,0,0,0},
+	{0,}
+};
+
+MODULE_DEVICE_TABLE(pci,cybla_devices);
+
+static struct pci_driver cyblafb_pci_driver = {
+	.name		= "cyblafb",
+	.id_table	= cybla_devices,
+	.probe		= cybla_pci_probe,
+	.remove 	= __devexit_p(cybla_pci_remove)
+};
+
+//=============================================================
+//
+// kernel command line example:
+//
+//	video=cyblafb:1280x1024,bpp=16,ref=50 ...
+//
+// modprobe command line example:
+//
+//	modprobe cyblafb mode=1280x1024 bpp=16 ref=50 ...
+//
+//=============================================================
+
+int __init cyblafb_init(void)
+{
+#ifndef MODULE
+	char *options = NULL;
+	char *opt;
+
+	if (fb_get_options("cyblafb", &options))
+		return -ENODEV;
+
+	if (options && *options)
+		while((opt = strsep(&options,",")) != NULL ) {
+			if (!*opt) continue;
+			else if (!strncmp(opt,"bpp=",4))
+				bpp = simple_strtoul(opt+4,NULL,0);
+			else if (!strncmp(opt,"ref=",4))
+				ref = simple_strtoul(opt+4,NULL,0);
+			else if (!strncmp(opt,"fp",2))
+				displaytype = DISPLAY_FP;
+			else if (!strncmp(opt,"crt",3))
+				displaytype = DISPLAY_CRT;
+			else if (!strncmp(opt,"nativex=",8))
+				nativex = simple_strtoul(opt+8,NULL,0);
+			else if (!strncmp(opt,"center",6))
+				center = 1;
+			else if (!strncmp(opt,"stretch",7))
+				stretch = 1;
+			else if (!strncmp(opt,"pciwb=",6))
+				pciwb = simple_strtoul(opt+8,NULL,0);
+			else if (!strncmp(opt,"pcirb=",6))
+				pcirb = simple_strtoul(opt+8,NULL,0);
+			else if (!strncmp(opt,"pciwr=",6))
+				pciwr = simple_strtoul(opt+8,NULL,0);
+			else if (!strncmp(opt,"pcirr=",6))
+				pcirr = simple_strtoul(opt+8,NULL,0);
+			else if (!strncmp(opt,"memsize=",8))
+				memsize = simple_strtoul(opt+8,NULL,0);
+			else if (!strncmp(opt,"verbosity=",10))
+				verbosity = simple_strtoul(opt+8,NULL,0);
+			else if (!strncmp(opt,"vesafb",6))
+				vesafb = 1;
+			else
+				mode = opt;
+		}
+#endif
+	output("CyblaFB version %s initializing\n",VERSION);
+	return pci_module_init(&cyblafb_pci_driver);
+}
+
+void __exit cyblafb_exit(void)
+{
+	pci_unregister_driver(&cyblafb_pci_driver);
+}
+
+static struct fb_ops cyblafb_ops = {
+	.owner	= THIS_MODULE,
+	.fb_setcolreg = cyblafb_setcolreg,
+	.fb_pan_display = cyblafb_pan_display,
+	.fb_blank = cyblafb_blank,
+	.fb_check_var = cyblafb_check_var,
+	.fb_set_par = cyblafb_set_par,
+	.fb_fillrect = cyblafb_fillrect,
+	.fb_copyarea= cyblafb_copyarea,
+	.fb_imageblit = cyblafb_imageblit,
+	.fb_cursor = soft_cursor,
+};
+
+module_init(cyblafb_init);
+module_exit(cyblafb_exit);
+
+MODULE_AUTHOR("Knut Petersen <knut_petersen@t-online.de>");
+MODULE_DESCRIPTION("Framebuffer driver for Cyberblade/i1 graphics core");
+MODULE_LICENSE("GPL");
diff -urN linux-2.6.13-rc4/drivers/video/tridentfb.c linux-2.6.13-rc4-tfix/drivers/video/tridentfb.c
--- linux-2.6.13-rc4/drivers/video/tridentfb.c	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6.13-rc4-tfix/drivers/video/tridentfb.c	2005-07-31 10:03:08.000000000 +0200
@@ -98,7 +98,7 @@
 		 (id == CYBER9397) || (id == CYBER9397DVD) ||
 		 (id == CYBER9520) || (id == CYBER9525DVD) ||
 		 (id == IMAGE975) || (id == IMAGE985) ||
-		 (id == CYBERBLADEi1) || (id == CYBERBLADEi1D) ||
+		 (id == CYBERBLADEi1D) ||
 		 (id ==	CYBERBLADEAi1) || (id == CYBERBLADEAi1D) ||
 		 (id ==	CYBERBLADEXPm8) || (id == CYBERBLADEXPm16) ||
 		 (id ==	CYBERBLADEXPAi1));
@@ -116,7 +116,6 @@
 		case CYBER9525DVD:
 		case CYBERBLADEE4:
 		case CYBERBLADEi7D:
-		case CYBERBLADEi1:
 		case CYBERBLADEi1D: 
 		case CYBERBLADEAi1: 
 		case CYBERBLADEAi1D:
@@ -1187,7 +1186,6 @@
 	{PCI_VENDOR_ID_TRIDENT,	BLADE3D, PCI_ANY_ID,PCI_ANY_ID,0,0,0},
 	{PCI_VENDOR_ID_TRIDENT,	CYBERBLADEi7, PCI_ANY_ID,PCI_ANY_ID,0,0,0},
 	{PCI_VENDOR_ID_TRIDENT,	CYBERBLADEi7D, PCI_ANY_ID,PCI_ANY_ID,0,0,0},
-	{PCI_VENDOR_ID_TRIDENT,	CYBERBLADEi1, PCI_ANY_ID,PCI_ANY_ID,0,0,0},
 	{PCI_VENDOR_ID_TRIDENT,	CYBERBLADEi1D, PCI_ANY_ID,PCI_ANY_ID,0,0,0},
 	{PCI_VENDOR_ID_TRIDENT,	CYBERBLADEAi1, PCI_ANY_ID,PCI_ANY_ID,0,0,0},
 	{PCI_VENDOR_ID_TRIDENT,	CYBERBLADEAi1D, PCI_ANY_ID,PCI_ANY_ID,0,0,0},
diff -urN linux-2.6.13-rc4/include/video/cyblafb.h linux-2.6.13-rc4-tfix/include/video/cyblafb.h
--- linux-2.6.13-rc4/include/video/cyblafb.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.13-rc4-tfix/include/video/cyblafb.h	2005-07-31 09:56:37.000000000 +0200
@@ -0,0 +1,174 @@
+
+#ifndef CYBLAFB_DEBUG
+#define CYBLAFB_DEBUG 0
+#endif
+
+#if CYBLAFB_DEBUG
+#define debug(f,a...)	printk("%s:" f,  __FUNCTION__ , ## a);
+#else
+#define debug(f,a...)
+#endif
+
+#define output(f, a...) printk("cyblafb: " f, ## a)
+
+#define Kb	(1024)
+#define Mb	(Kb*Kb)
+
+/* PCI IDS of supported cards temporarily here */
+
+#define CYBERBLADEi1	0x8500
+
+/* these defines are for 'lcd' variable */
+#define LCD_STRETCH	0
+#define LCD_CENTER	1
+#define LCD_BIOS	2
+
+/* display types */
+#define DISPLAY_CRT	0
+#define DISPLAY_FP	1
+
+#define flatpanel (displaytype == DISPLAY_FP)
+
+
+#define ROP_S	0xCC
+
+#define point(x,y) ((y)<<16|(x))
+
+//
+// Attribute Regs, ARxx, 3c0/3c1
+//
+#define AR00	0x00
+#define AR01	0x01
+#define AR02	0x02
+#define AR03	0x03
+#define AR04	0x04
+#define AR05	0x05
+#define AR06	0x06
+#define AR07	0x07
+#define AR08	0x08
+#define AR09	0x09
+#define AR0A	0x0A
+#define AR0B	0x0B
+#define AR0C	0x0C
+#define AR0D	0x0D
+#define AR0E	0x0E
+#define AR0F	0x0F
+#define AR10	0x10
+#define AR12	0x12
+#define AR13	0x13
+
+//
+// Sequencer Regs, SRxx, 3c4/3c5
+//
+#define SR00	0x00
+#define SR01	0x01
+#define SR02	0x02
+#define SR03	0x03
+#define SR04	0x04
+#define SR0D	0x0D
+#define SR0E	0x0E
+#define SR11	0x11
+#define SR18	0x18
+#define SR19	0x19
+
+//
+//
+//
+#define CR00	0x00
+#define CR01	0x01
+#define CR02	0x02
+#define CR03	0x03
+#define CR04	0x04
+#define CR05	0x05
+#define CR06	0x06
+#define CR07	0x07
+#define CR08	0x08
+#define CR09	0x09
+#define CR0A	0x0A
+#define CR0B	0x0B
+#define CR0C	0x0C
+#define CR0D	0x0D
+#define CR0E	0x0E
+#define CR0F	0x0F
+#define CR10	0x10
+#define CR11	0x11
+#define CR12	0x12
+#define CR13	0x13
+#define CR14	0x14
+#define CR15	0x15
+#define CR16	0x16
+#define CR17	0x17
+#define CR18	0x18
+#define CR19	0x19
+#define CR1A	0x1A
+#define CR1B	0x1B
+#define CR1C	0x1C
+#define CR1D	0x1D
+#define CR1E	0x1E
+#define CR1F	0x1F
+#define CR20	0x20
+#define CR21	0x21
+#define CR27	0x27
+#define CR29	0x29
+#define CR2A	0x2A
+#define CR2B	0x2B
+#define CR2D	0x2D
+#define CR2F	0x2F
+#define CR36	0x36
+#define CR38	0x38
+#define CR39	0x39
+#define CR3A	0x3A
+#define CR55	0x55
+#define CR56	0x56
+#define CR57	0x57
+#define CR58	0x58
+
+//
+//
+//
+
+#define GR00	0x01
+#define GR01	0x01
+#define GR02	0x02
+#define GR03	0x03
+#define GR04	0x04
+#define GR05	0x05
+#define GR06	0x06
+#define GR07	0x07
+#define GR08	0x08
+#define GR0F	0x0F
+#define GR20	0x20
+#define GR23	0x23
+#define GR2F	0x2F
+#define GR30	0x30
+#define GR31	0x31
+#define GR33	0x33
+#define GR52	0x52
+#define GR53	0x53
+#define GR5D	0x5d
+
+
+//
+// Graphics Engine
+//
+#define GEBase	0x2100		// could be mapped elsewhere if we like it
+#define GE00	(GEBase+0x00)	// source 1, p 111
+#define GE04	(GEBase+0x04)	// source 2, p 111
+#define GE08	(GEBase+0x08)	// destination 1, p 111
+#define GE0C	(GEBase+0x0C)	// destination 2, p 112
+#define GE20	(GEBase+0x20)	// engine status, p 113
+#define GE24	(GEBase+0x24)	// reset all GE pointers
+#define GE44	(GEBase+0x44)	// command register, p 126
+#define GE48	(GEBase+0x48)	// raster operation, p 127
+#define GE60	(GEBase+0x60)	// foreground color, p 128
+#define GE64	(GEBase+0x64)	// background color, p 128
+#define GE6C	(GEBase+0x6C)	// Pattern and Style, p 129, ok
+#define GE9C	(GEBase+0x9C)	// pixel engine data port, p 125
+#define GEB8	(GEBase+0xB8)	// Destination Stride / Buffer Base 0, p 133
+#define GEBC	(GEBase+0xBC)	// Destination Stride / Buffer Base 1, p 133
+#define GEC0	(GEBase+0xC0)	// Destination Stride / Buffer Base 2, p 133
+#define GEC4	(GEBase+0xC4)	// Destination Stride / Buffer Base 3, p 133
+#define GEC8	(GEBase+0xC8)	// Source Stride / Buffer Base 0, p 133
+#define GECC	(GEBase+0xCC)	// Source Stride / Buffer Base 1, p 133
+#define GED0	(GEBase+0xD0)	// Source Stride / Buffer Base 2, p 133
+#define GED4	(GEBase+0xD4)	// Source Stride / Buffer Base 3, p 133


