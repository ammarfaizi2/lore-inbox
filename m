Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265077AbSLBVAW>; Mon, 2 Dec 2002 16:00:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265081AbSLBVAW>; Mon, 2 Dec 2002 16:00:22 -0500
Received: from phoenix.mvhi.com ([195.224.96.167]:27918 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S265077AbSLBVAS>; Mon, 2 Dec 2002 16:00:18 -0500
Date: Mon, 2 Dec 2002 21:07:33 +0000 (GMT)
From: James Simmons <jsimmons@infradead.org>
To: Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux console project <linuxconsole-dev@lists.sourceforge.net>
Subject: [STATUS] fbdev api.
Message-ID: <Pine.LNX.4.44.0212022051320.20834-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi!

  I have a new patch avaiable. It is against 2.5.50. The patch is at 

http://phoenix.infradead.org/~jsimmons/fbdev.diff.gz

Have fun!!!!

Drivers ported are: (Give them a try)

    ATI Mach 64
    ATI 128
    VESA 
    VGA16
    HGA
    NIVIDA
    NEOMAGIC
     
The BIG changes are:

1) The seperation of the console code out of the fbdev drivers. 

2) Total modularity of the frmaebuffer console system. Yes that is 
   right. You can build it has modules. Great for testing.

The following are results of the new changes which I have tested.

   With my VIA laptop with my neomagic card I was able to build it with 
vgacon and no fbcon. Then I insmod neofb and the soft accel (cfb*.c) 
needed. It loading and did NOT change the video hardware state. At this 
point I could run fbdev apps including a X server using /dev/fb solely. 
On opening /dev/fb0 the graphics hardware state changed. In theory I could 
exit X and get vgacon back. In order to do this I have to reset the 
hardware back to vga text mode in the fb_release function. It can be done 
but I haven't done it yet.
   With the second experiment I was able to insmod the fonts and fbcon.o.
Then it switched from vgacon to fbcon. In theory I could again call the 
release function and reset the hardware back to a text mode state. All 
that is needed is the hardware specific code to do this.

Things to be done:

    1) A few bugs in fbcon to hammer out. 
 
    2) Fbcon to support changing resolution via the console layer. 

    3) Move the logo code out of fbcon.c to fbmem.c. With pure fbdev 
       you need something to let you know things worked.

    4) Software rotation.

The diffstat is:

 CREDITS                                |   10 
 Documentation/DocBook/kernel-api.tmpl  |    4 
 Documentation/fb/README-sstfb.txt      |  173 
 Documentation/fb/internals.txt         |    5 
 Documentation/fb/sstfb.txt             |  174 
 MAINTAINERS                            |    7 
 arch/alpha/Kconfig                     |   31 
 arch/arm/Kconfig                       |   21 
 arch/i386/Kconfig                      |   55 
 arch/i386/vmlinux.lds.s                |  114 
 arch/ia64/Kconfig                      |   25 
 arch/m68k/Kconfig                      |    7 
 arch/m68knommu/Kconfig                 |   35 
 arch/mips/Kconfig                      |   62 
 arch/mips64/Kconfig                    |   23 
 arch/parisc/Kconfig                    |   30 
 arch/ppc/Kconfig                       |   22 
 arch/ppc64/Kconfig                     |    7 
 arch/sh/Kconfig                        |   55 
 arch/sparc/Kconfig                     |   16 
 arch/sparc64/Kconfig                   |   11 
 arch/v850/Kconfig                      |   35 
 arch/x86_64/Kconfig                    |   55 
 drivers/Makefile                       |    3 
 drivers/char/Makefile                  |    2 
 drivers/char/consolemap.c              |    5 
 drivers/char/keyboard.c                |    1 
 drivers/char/mem.c                     |   12 
 drivers/char/selection.c               |    1 
 drivers/char/toshiba.c                 |    2 
 drivers/char/tty_io.c                  |    7 
 drivers/char/vc_screen.c               |    1 
 drivers/char/vt.c                      |  200 -
 drivers/char/vt_ioctl.c                |   58 
 drivers/video/68328fb.c                |  967 +----
 drivers/video/Kconfig                  |  411 --
 drivers/video/Makefile                 |   54 
 drivers/video/S3triofb.c               |    2 
 drivers/video/amifb.c                  |    2 
 drivers/video/anakinfb.c               |   62 
 drivers/video/atafb.c                  |    2 
 drivers/video/aty/atyfb.h              |   18 
 drivers/video/aty/atyfb_base.c         |   99 
 drivers/video/aty/mach64_ct.c          |    2 
 drivers/video/aty/mach64_cursor.c      |  157 
 drivers/video/aty/mach64_gx.c          |    2 
 drivers/video/aty128fb.c               | 3238 +++++++----------
 drivers/video/cfbcopyarea.c            |  511 +-
 drivers/video/cfbfillrect.c            |  536 ++
 drivers/video/cfbimgblt.c              |  360 +
 drivers/video/chipsfb.c                |    2 
 drivers/video/clps711xfb.c             |   16 
 drivers/video/console/Kconfig          |  221 +
 drivers/video/console/Makefile         |   61 
 drivers/video/console/dummycon.c       |   73 
 drivers/video/console/fbcon-sti.c      |  289 +
 drivers/video/console/fbcon.c          | 2725 ++++++++++++++
 drivers/video/console/fbcon.h          |  142 
 drivers/video/console/font.h           |   53 
 drivers/video/console/font_6x11.c      | 3351 +++++++++++++++++
 drivers/video/console/font_8x16.c      | 4631 ++++++++++++++++++++++++
 drivers/video/console/font_8x8.c       | 2583 +++++++++++++
 drivers/video/console/font_acorn_8x8.c |  277 +
 drivers/video/console/font_mini_4x6.c  | 2158 +++++++++++
 drivers/video/console/font_pearl_8x8.c | 2587 +++++++++++++
 drivers/video/console/font_sun12x22.c  | 6220 +++++++++++++++++++++++++++++++++
 drivers/video/console/font_sun8x16.c   |  275 +
 drivers/video/console/fonts.c          |  142 
 drivers/video/console/mdacon.c         |  631 +++
 drivers/video/console/newport_con.c    |  745 +++
 drivers/video/console/prom.uni         |   11 
 drivers/video/console/promcon.c        |  605 +++
 drivers/video/console/sti.h            |  289 +
 drivers/video/console/sticon.c         |  214 +
 drivers/video/console/sticore.c        |  601 +++
 drivers/video/console/vgacon.c         | 1066 +++++
 drivers/video/controlfb.c              |  499 --
 drivers/video/cyberfb.c                |    2 
 drivers/video/dnfb.c                   |   18 
 drivers/video/dummycon.c               |   74 
 drivers/video/epson1355fb.c            |    2 
 drivers/video/fbcmap.c                 |   92 
 drivers/video/fbcon-accel.c            |  188 
 drivers/video/fbcon-accel.h            |   34 
 drivers/video/fbcon-afb.c              |  448 --
 drivers/video/fbcon-cfb16.c            |  319 -
 drivers/video/fbcon-cfb2.c             |  225 -
 drivers/video/fbcon-cfb24.c            |  333 -
 drivers/video/fbcon-cfb32.c            |  305 -
 drivers/video/fbcon-cfb4.c             |  229 -
 drivers/video/fbcon-cfb8.c             |  294 -
 drivers/video/fbcon-hga.c              |  253 -
 drivers/video/fbcon-ilbm.c             |  296 -
 drivers/video/fbcon-iplan2p2.c         |  476 --
 drivers/video/fbcon-iplan2p4.c         |  497 --
 drivers/video/fbcon-iplan2p8.c         |  534 --
 drivers/video/fbcon-mfb.c              |  217 -
 drivers/video/fbcon-sti.c              |  337 -
 drivers/video/fbcon-vga-planes.c       |  387 --
 drivers/video/fbcon.c                  | 2509 -------------
 drivers/video/fbgen.c                  |  286 -
 drivers/video/fbmem.c                  |  233 -
 drivers/video/fm2fb.c                  |   17 
 drivers/video/font_6x11.c              | 3351 -----------------
 drivers/video/font_8x16.c              | 4631 ------------------------
 drivers/video/font_8x8.c               | 2583 -------------
 drivers/video/font_acorn_8x8.c         |  277 -
 drivers/video/font_mini_4x6.c          | 2158 -----------
 drivers/video/font_pearl_8x8.c         | 2587 -------------
 drivers/video/font_sun12x22.c          | 6220 ---------------------------------
 drivers/video/font_sun8x16.c           |  275 -
 drivers/video/fonts.c                  |  135 
 drivers/video/g364fb.c                 |   74 
 drivers/video/hgafb.c                  |  424 --
 drivers/video/hitfb.c                  |   17 
 drivers/video/hpfb.c                   |   16 
 drivers/video/igafb.c                  |    2 
 drivers/video/imsttfb.c                |   41 
 drivers/video/macfb.c                  |   22 
 drivers/video/macmodes.c               |    3 
 drivers/video/macmodes.h               |   70 
 drivers/video/matrox/i2c-matroxfb.c    |    2 
 drivers/video/matrox/matroxfb_base.c   |    4 
 drivers/video/matrox/matroxfb_crtc2.c  |    4 
 drivers/video/maxinefb.c               |   48 
 drivers/video/mdacon.c                 |  632 ---
 drivers/video/modedb.c                 |    7 
 drivers/video/neofb.c                  |  389 +-
 drivers/video/newport_con.c            |  746 ---
 drivers/video/offb.c                   |   23 
 drivers/video/platinumfb.c             |  451 --
 drivers/video/pm2fb.c                  |    2 
 drivers/video/pm3fb.c                  |    2 
 drivers/video/pmag-ba-fb.c             |   59 
 drivers/video/pmagb-b-fb.c             |   53 
 drivers/video/prom.uni                 |   11 
 drivers/video/promcon.c                |  606 ---
 drivers/video/pvr2fb.c                 |    4 
 drivers/video/q40fb.c                  |   16 
 drivers/video/radeonfb.c               | 3374 ++++++++++-------
 drivers/video/retz3fb.c                |    2 
 drivers/video/riva/Makefile            |    2 
 drivers/video/riva/accel.c             |  427 --
 drivers/video/riva/fbdev.c             | 2099 ++++-------
 drivers/video/riva/riva_hw.h           |    1 
 drivers/video/riva/rivafb.h            |   48 
 drivers/video/sa1100fb.c               |    2 
 drivers/video/sbusfb.c                 |    2 
 drivers/video/sgivwfb.c                |   62 
 drivers/video/sis/Makefile             |    2 
 drivers/video/sis/sis_accel.c          |  495 ++
 drivers/video/sis/sis_main.c           |    2 
 drivers/video/skeletonfb.c             |   28 
 drivers/video/softcursor.c             |   62 
 drivers/video/sstfb.c                  |    2 
 drivers/video/sti-bmode.h              |  287 -
 drivers/video/sti.h                    |  289 -
 drivers/video/sticon-bmode.c           |  895 ----
 drivers/video/sticon.c                 |  215 -
 drivers/video/sticore.c                |  601 ---
 drivers/video/sticore.h                |  407 ++
 drivers/video/stifb.c                  | 1403 ++++++-
 drivers/video/sun3fb.c                 |    2 
 drivers/video/tdfxfb.c                 |  531 +-
 drivers/video/tgafb.c                  |    2 
 drivers/video/tridentfb.c              |    2 
 drivers/video/tx3912fb.c               |   19 
 drivers/video/valkyriefb.c             |   27 
 drivers/video/vesafb.c                 |   24 
 drivers/video/vfb.c                    |   38 
 drivers/video/vga16fb.c                | 1368 +++++--
 drivers/video/vgacon.c                 | 1055 -----
 drivers/video/virgefb.c                |    2 
 include/linux/console.h                |    1 
 include/linux/console_struct.h         |    1 
 include/linux/fb.h                     |  207 -
 include/linux/radeon.h                 |  766 ++++
 include/linux/radeonfb.h               |   15 
 include/linux/sisfb.h                  |   58 
 include/linux/vt_kern.h                |    8 
 include/video/fbcon-afb.h              |   32 
 include/video/fbcon-cfb16.h            |   34 
 include/video/fbcon-cfb2.h             |   32 
 include/video/fbcon-cfb24.h            |   34 
 include/video/fbcon-cfb32.h            |   34 
 include/video/fbcon-cfb4.h             |   32 
 include/video/fbcon-cfb8.h             |   34 
 include/video/fbcon-hga.h              |   32 
 include/video/fbcon-ilbm.h             |   32 
 include/video/fbcon-iplan2p2.h         |   32 
 include/video/fbcon-iplan2p4.h         |   32 
 include/video/fbcon-iplan2p8.h         |   32 
 include/video/fbcon-mac.h              |   32 
 include/video/fbcon-mfb.h              |   32 
 include/video/fbcon-vga-planes.h       |   37 
 include/video/fbcon-vga.h              |   32 
 include/video/fbcon.h                  |  795 ----
 include/video/font.h                   |   53 
 include/video/macmodes.h               |   70 
 include/video/neomagic.h               |    1 
 kernel/printk.c                        |    1 
 201 files changed, 41728 insertions(+), 47259 deletions(-)
 


