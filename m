Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281188AbRKLXXS>; Mon, 12 Nov 2001 18:23:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281189AbRKLXXL>; Mon, 12 Nov 2001 18:23:11 -0500
Received: from ausxc10.us.dell.com ([143.166.98.229]:24840 "EHLO
	ausxc10.us.dell.com") by vger.kernel.org with ESMTP
	id <S281188AbRKLXWz>; Mon, 12 Nov 2001 18:22:55 -0500
Message-ID: <71714C04806CD5119352009027289217022C3F15@ausxmrr502.us.dell.com>
From: Matt_Domsch@Dell.com
To: linux-kernel@vger.kernel.org
Cc: jgarzik@mandrakesoft.com, kaos@ocs.com.au
Subject: [CFT][PATCH] crc32 cleanups
Date: Mon, 12 Nov 2001 17:22:28 -0600
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

More crc32 cleanups.  I think this is pretty close to being finished, and
would appreciate people taking a look at the drivers they use regularly.
I've built all the drivers I can on x86, and have hand-verified the rest.

Changes since last time:
* remove all the request_module() calls I added last time.  If a driver
needs crc32.o and it's a module, modprobe pulls it in automatically.
* Create {fs,drivers/net,drivers/usb}/Makefile.lib.  In each, list modules
as obj-$(CONFIG_FOO) += crc32.o.  In lib/Makefile, include each
Makefile.lib.  This allows drivers to update the list local to themselves
and not have to patch lib/Makefile.  This should satisfy Keith Owens'
concern in this regard.
* Added a whole new set of drivers, those based on 8390.o, to the list.
* MOD_INC_USE_COUNT in crc32_init().  Since this is a set of library
functions (albiet sometimes built in a module), there's no good reason to
unload crc32.o.  This keeps a user from 'modprobe driver; rmmod crc32'
without changing each driver to increment/decrement its usage of crc32.
* additional cleanups, documentation

Patch at
http://domsch.com/linux/patches/crc32/linux-2.4.15-pre4-crc32-20011112.patch
includes the former crc32-lib and crc32-drivers patch all as one.

 Documentation/Configure.help         |    7
 Makefile                             |    4
 arch/alpha/config.in                 |    2
 arch/arm/config.in                   |    2
 arch/cris/config.in                  |    2
 arch/i386/config.in                  |    2
 arch/ia64/config.in                  |    2
 arch/m68k/config.in                  |    2
 arch/mips/config.in                  |    2
 arch/mips64/config.in                |    2
 arch/parisc/config.in                |    1
 arch/ppc/config.in                   |    2
 arch/s390/config.in                  |    1
 arch/s390x/config.in                 |    1
 arch/sh/config.in                    |    2
 arch/sparc/config.in                 |    2
 arch/sparc64/config.in               |    2
 drivers/net/7990.c                   |   19 -
 drivers/net/7990.h                   |    3
 drivers/net/8139cp.c                 |   17 -
 drivers/net/8139too.c                |   19 -
 drivers/net/8390.c                   |   27 -
 drivers/net/Makefile.lib             |   67 ++++
 drivers/net/a2065.c                  |   20 -
 drivers/net/a2065.h                  |    3
 drivers/net/am79c961a.c              |   25 -
 drivers/net/at1700.c                 |   22 -
 drivers/net/atp.c                    |   21 -
 drivers/net/au1000_eth.c             |   17 -
 drivers/net/bmac.c                   |   17 -
 drivers/net/de4x5.c                  |   15
 drivers/net/declance.c               |   20 -
 drivers/net/depca.c                  |   16
 drivers/net/dl2k.c                   |   24 -
 drivers/net/dl2k.h                   |    1
 drivers/net/dmfe.c                   |   84 -----
 drivers/net/epic100.c                |   22 -
 drivers/net/ewrk3.c                  |   17 -
 drivers/net/fealnx.c                 |   22 -
 drivers/net/gmac.c                   |   18 -
 drivers/net/ioc3-eth.c               |   18 -
 drivers/net/mace.c                   |   22 -
 drivers/net/macmace.c                |   22 -
 drivers/net/myri_sbus.c              |    3
 drivers/net/natsemi.c                |   48 --
 drivers/net/pci-skeleton.c           |   23 -
 drivers/net/pcmcia/fmvj18x_cs.c      |   22 -
 drivers/net/pcmcia/smc91c92_cs.c     |   26 -
 drivers/net/pcmcia/xircom_tulip_cb.c |   38 --
 drivers/net/pcnet32.c                |   21 -
 drivers/net/sk98lin/h/skdrv1st.h     |    1
 drivers/net/sk98lin/skaddr.c         |   16
 drivers/net/smc9194.c                |   35 --
 drivers/net/starfire.c               |   26 -
 drivers/net/sunbmac.c                |   18 -
 drivers/net/sundance.c               |   27 -
 drivers/net/sungem.c                 |   35 --
 drivers/net/sunhme.c                 |   36 --
 drivers/net/sunlance.c               |   25 -
 drivers/net/sunqe.c                  |   19 -
 drivers/net/tulip/tulip_core.c       |   36 --
 drivers/net/via-rhine.c              |   21 -
 drivers/net/winbond-840.c            |   17 -
 drivers/net/yellowfin.c              |   24 -
 drivers/usb/Makefile.lib             |    1
 drivers/usb/catc.c                   |    9
 fs/Makefile.lib                      |    2
 fs/jffs2/Makefile                    |    2
 fs/jffs2/crc32.c                     |   97 -----
 fs/jffs2/crc32.h                     |   21 -
 fs/jffs2/dir.c                       |    2
 fs/jffs2/erase.c                     |    2
 fs/jffs2/file.c                      |    2
 fs/jffs2/gc.c                        |    2
 fs/jffs2/read.c                      |    2
 fs/jffs2/readinode.c                 |    2
 fs/jffs2/scan.c                      |    2
 fs/jffs2/write.c                     |    2
 include/linux/crc32.h                |   17 +
 lib/Config.in                        |    8
 lib/Makefile                         |    7
 lib/crc32.c                          |  571 ++++++++++++++++++++++++++++++
 82 files changed, 848 insertions, 1036 deletions


Feedback welcome.

Thanks,
Matt

--
Matt Domsch
Sr. Software Engineer
Dell Linux Solutions
www.dell.com/linux
#1 US Linux Server provider with 24% (IDC Sept 2001)
#2 Worldwide Linux Server provider with 17% (IDC Sept 2001)
#3 Unix provider with 18% in the US (Dataquest)!
