Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262598AbVAPUCj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262598AbVAPUCj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jan 2005 15:02:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262593AbVAPUCi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jan 2005 15:02:38 -0500
Received: from mail.mellanox.co.il ([194.90.237.34]:219 "EHLO
	mtlex01.yok.mtl.com") by vger.kernel.org with ESMTP id S262598AbVAPUAc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jan 2005 15:00:32 -0500
Date: Sun, 16 Jan 2005 22:00:46 +0200
From: "Michael S. Tsirkin" <mst@mellanox.co.il>
To: linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net,
       zippel@linux-m68k.org
Subject: [PATCH] split UTS_RELEASE to a separate header.
Message-ID: <20050116200046.GB5276@mellanox.co.il>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
References: <20050116152242.GA4537@mellanox.co.il> <20050116161622.GC3090@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050116161622.GC3090@mars.ravnborg.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!
Quoting r. Sam Ravnborg (sam@ravnborg.org) "Re: changing local version requires full rebuild":
> On Sun, Jan 16, 2005 at 05:22:42PM +0200, Michael S. Tsirkin wrote:
> > Hi!
> > Is it just me, or does changing the local version always require
> > a full kernel rebuild?
> > 
> > If so, I'd like to fix it, since I like copying
> > my kernel source with --preserve and changing the
> > local version, then going back to the old version in case of
> > a crash.
> > Its important to change the local version to force 
> > make install and make modules_install to put things in a separate
> > directory.
> 
> Just tried it out here.
> After cp -Ra only a limited part of the kernel rebuilds.
> o oiu.c in ieee directory - because it dependson the shell script
> o A number of drivers that include version.h
> 	- This should be changed so local version does not affect
> 	  the reast of version.h.
> o Other stuff that is always build if kernel has changed
> 
> Do you use "echo -mylocalver > localversion" to change the local version?
> 
> 	Sam

Well, we have
/usr/src/linux-2.6.10-gold # grep -l UTS_RELEASE -rI . | wc -l
29
grep -l version.h -rI . | fgrep -v .cmd | fgrep -v '.mod' | fgrep -e '.c' -e '.h' | wc -l
354

This means that about 300 files are compiled each time localversion changes,
which do not actually use the local version.

So, let us split UTS_RELEASE to a separate header: release.h
The following patch over 2.6.10 does that, and fixed the in-tree files that
really need to include it.
Works for me, and helps me cut down compilation time. Comments?

Signed-off-by: Michael S. Tsirkin <mst@mellanox.co.il>

diff -x '.*' -ru linux-2.6.10-orig/arch/alpha/boot/bootp.c linux-2.6.10-gold/arch/alpha/boot/bootp.c
--- linux-2.6.10-orig/arch/alpha/boot/bootp.c	2004-12-24 23:35:25.000000000 +0200
+++ linux-2.6.10-gold/arch/alpha/boot/bootp.c	2005-01-16 20:45:38.000000000 +0200
@@ -9,6 +9,7 @@
  */
 #include <linux/kernel.h>
 #include <linux/string.h>
+#include <linux/release.h>
 #include <linux/version.h>
 #include <linux/mm.h>
 
diff -x '.*' -ru linux-2.6.10-orig/arch/alpha/boot/bootpz.c linux-2.6.10-gold/arch/alpha/boot/bootpz.c
--- linux-2.6.10-orig/arch/alpha/boot/bootpz.c	2004-12-24 23:33:50.000000000 +0200
+++ linux-2.6.10-gold/arch/alpha/boot/bootpz.c	2005-01-16 20:45:25.000000000 +0200
@@ -11,6 +11,7 @@
  */
 #include <linux/kernel.h>
 #include <linux/string.h>
+#include <linux/release.h>
 #include <linux/version.h>
 #include <linux/mm.h>
 
diff -x '.*' -ru linux-2.6.10-orig/arch/alpha/boot/main.c linux-2.6.10-gold/arch/alpha/boot/main.c
--- linux-2.6.10-orig/arch/alpha/boot/main.c	2004-12-24 23:35:49.000000000 +0200
+++ linux-2.6.10-gold/arch/alpha/boot/main.c	2005-01-16 20:45:47.000000000 +0200
@@ -7,6 +7,7 @@
  */
 #include <linux/kernel.h>
 #include <linux/string.h>
+#include <linux/release.h>
 #include <linux/version.h>
 #include <linux/mm.h>
 
diff -x '.*' -ru linux-2.6.10-orig/arch/i386/boot/setup.S linux-2.6.10-gold/arch/i386/boot/setup.S
--- linux-2.6.10-orig/arch/i386/boot/setup.S	2004-12-24 23:34:58.000000000 +0200
+++ linux-2.6.10-gold/arch/i386/boot/setup.S	2005-01-16 20:44:01.000000000 +0200
@@ -48,6 +48,7 @@
 
 #include <linux/config.h>
 #include <asm/segment.h>
+#include <linux/release.h>
 #include <linux/version.h>
 #include <linux/compile.h>
 #include <asm/boot.h>
diff -x '.*' -ru linux-2.6.10-orig/arch/ppc/platforms/chrp_setup.c linux-2.6.10-gold/arch/ppc/platforms/chrp_setup.c
--- linux-2.6.10-orig/arch/ppc/platforms/chrp_setup.c	2004-12-24 23:35:24.000000000 +0200
+++ linux-2.6.10-gold/arch/ppc/platforms/chrp_setup.c	2005-01-16 20:45:20.000000000 +0200
@@ -27,6 +27,7 @@
 #include <linux/reboot.h>
 #include <linux/init.h>
 #include <linux/pci.h>
+#include <linux/release.h>
 #include <linux/version.h>
 #include <linux/adb.h>
 #include <linux/module.h>
diff -x '.*' -ru linux-2.6.10-orig/arch/ppc/syslib/btext.c linux-2.6.10-gold/arch/ppc/syslib/btext.c
--- linux-2.6.10-orig/arch/ppc/syslib/btext.c	2004-12-24 23:33:49.000000000 +0200
+++ linux-2.6.10-gold/arch/ppc/syslib/btext.c	2005-01-16 20:44:49.000000000 +0200
@@ -7,6 +7,7 @@
 #include <linux/kernel.h>
 #include <linux/string.h>
 #include <linux/init.h>
+#include <linux/release.h>
 #include <linux/version.h>
 
 #include <asm/sections.h>
diff -x '.*' -ru linux-2.6.10-orig/arch/ppc64/kernel/process.c linux-2.6.10-gold/arch/ppc64/kernel/process.c
--- linux-2.6.10-orig/arch/ppc64/kernel/process.c	2004-12-24 23:35:00.000000000 +0200
+++ linux-2.6.10-gold/arch/ppc64/kernel/process.c	2005-01-16 20:46:01.000000000 +0200
@@ -35,6 +35,7 @@
 #include <linux/ptrace.h>
 #include <linux/kallsyms.h>
 #include <linux/interrupt.h>
+#include <linux/release.h>
 #include <linux/version.h>
 
 #include <asm/pgtable.h>
diff -x '.*' -ru linux-2.6.10-orig/arch/ppc64/kernel/pSeries_setup.c linux-2.6.10-gold/arch/ppc64/kernel/pSeries_setup.c
--- linux-2.6.10-orig/arch/ppc64/kernel/pSeries_setup.c	2004-12-24 23:34:00.000000000 +0200
+++ linux-2.6.10-gold/arch/ppc64/kernel/pSeries_setup.c	2005-01-16 20:45:52.000000000 +0200
@@ -36,6 +36,7 @@
 #include <linux/ioport.h>
 #include <linux/console.h>
 #include <linux/pci.h>
+#include <linux/release.h>
 #include <linux/version.h>
 #include <linux/adb.h>
 #include <linux/module.h>
diff -x '.*' -ru linux-2.6.10-orig/arch/ppc64/kernel/setup.c linux-2.6.10-gold/arch/ppc64/kernel/setup.c
--- linux-2.6.10-orig/arch/ppc64/kernel/setup.c	2004-12-24 23:34:44.000000000 +0200
+++ linux-2.6.10-gold/arch/ppc64/kernel/setup.c	2005-01-16 20:45:57.000000000 +0200
@@ -24,6 +24,7 @@
 #include <linux/seq_file.h>
 #include <linux/ioport.h>
 #include <linux/console.h>
+#include <linux/release.h>
 #include <linux/version.h>
 #include <linux/tty.h>
 #include <linux/root_dev.h>
diff -x '.*' -ru linux-2.6.10-orig/arch/x86_64/boot/setup.S linux-2.6.10-gold/arch/x86_64/boot/setup.S
--- linux-2.6.10-orig/arch/x86_64/boot/setup.S	2004-12-24 23:35:39.000000000 +0200
+++ linux-2.6.10-gold/arch/x86_64/boot/setup.S	2005-01-16 20:46:11.000000000 +0200
@@ -47,6 +47,7 @@
 
 #include <linux/config.h>
 #include <asm/segment.h>
+#include <linux/release.h>
 #include <linux/version.h>
 #include <linux/compile.h>
 #include <asm/boot.h>
diff -x '.*' -ru linux-2.6.10-orig/arch/x86_64/kernel/process.c linux-2.6.10-gold/arch/x86_64/kernel/process.c
--- linux-2.6.10-orig/arch/x86_64/kernel/process.c	2004-12-24 23:34:58.000000000 +0200
+++ linux-2.6.10-gold/arch/x86_64/kernel/process.c	2005-01-16 20:46:06.000000000 +0200
@@ -32,6 +32,7 @@
 #include <linux/delay.h>
 #include <linux/irq.h>
 #include <linux/ptrace.h>
+#include <linux/release.h>
 #include <linux/version.h>
 
 #include <asm/uaccess.h>
diff -x '.*' -ru linux-2.6.10-orig/drivers/block/floppy.c linux-2.6.10-gold/drivers/block/floppy.c
--- linux-2.6.10-orig/drivers/block/floppy.c	2004-12-24 23:34:01.000000000 +0200
+++ linux-2.6.10-gold/drivers/block/floppy.c	2005-01-16 20:47:16.000000000 +0200
@@ -155,6 +155,7 @@
 #include <linux/kernel.h>
 #include <linux/timer.h>
 #include <linux/workqueue.h>
+#include <linux/release.h>
 #include <linux/version.h>
 #define FDPATCHES
 #include <linux/fdreg.h>
diff -x '.*' -ru linux-2.6.10-orig/drivers/cdrom/aztcd.c linux-2.6.10-gold/drivers/cdrom/aztcd.c
--- linux-2.6.10-orig/drivers/cdrom/aztcd.c	2004-12-24 23:35:28.000000000 +0200
+++ linux-2.6.10-gold/drivers/cdrom/aztcd.c	2005-01-16 20:47:25.000000000 +0200
@@ -165,6 +165,7 @@
 			 Torben Mathiasen <tmm@image.dk>
 */
 
+#include <linux/release.h>
 #include <linux/version.h>
 #include <linux/blkdev.h>
 #include "aztcd.h"
diff -x '.*' -ru linux-2.6.10-orig/drivers/cdrom/mcdx.c linux-2.6.10-gold/drivers/cdrom/mcdx.c
--- linux-2.6.10-orig/drivers/cdrom/mcdx.c	2004-12-24 23:34:44.000000000 +0200
+++ linux-2.6.10-gold/drivers/cdrom/mcdx.c	2005-01-16 20:47:20.000000000 +0200
@@ -56,6 +56,7 @@
     = "$Id: mcdx.c,v 1.21 1997/01/26 07:12:59 davem Exp $";
 #endif
 
+#include <linux/release.h>
 #include <linux/version.h>
 #include <linux/module.h>
 
diff -x '.*' -ru linux-2.6.10-orig/drivers/char/ftape/compressor/zftape-compress.c linux-2.6.10-gold/drivers/char/ftape/compressor/zftape-compress.c
--- linux-2.6.10-orig/drivers/char/ftape/compressor/zftape-compress.c	2004-12-24 23:35:25.000000000 +0200
+++ linux-2.6.10-gold/drivers/char/ftape/compressor/zftape-compress.c	2005-01-16 20:46:42.000000000 +0200
@@ -31,6 +31,7 @@
  char zftc_rev[] = "$Revision: 1.1.6.1 $";
  char zftc_dat[] = "$Date: 1997/11/16 15:15:56 $";
 
+#include <linux/release.h>
 #include <linux/version.h>
 #include <linux/errno.h>
 #include <linux/mm.h>
diff -x '.*' -ru linux-2.6.10-orig/drivers/char/ftape/lowlevel/ftape-init.c linux-2.6.10-gold/drivers/char/ftape/lowlevel/ftape-init.c
--- linux-2.6.10-orig/drivers/char/ftape/lowlevel/ftape-init.c	2004-12-24 23:35:25.000000000 +0200
+++ linux-2.6.10-gold/drivers/char/ftape/lowlevel/ftape-init.c	2005-01-16 20:46:32.000000000 +0200
@@ -23,6 +23,7 @@
 
 #include <linux/config.h>
 #include <linux/module.h>
+#include <linux/release.h>
 #include <linux/version.h>
 #include <linux/errno.h>
 #include <linux/fs.h>
diff -x '.*' -ru linux-2.6.10-orig/drivers/char/ftape/zftape/zftape-init.c linux-2.6.10-gold/drivers/char/ftape/zftape/zftape-init.c
--- linux-2.6.10-orig/drivers/char/ftape/zftape/zftape-init.c	2004-12-24 23:34:31.000000000 +0200
+++ linux-2.6.10-gold/drivers/char/ftape/zftape/zftape-init.c	2005-01-16 20:46:38.000000000 +0200
@@ -23,6 +23,7 @@
 #include <linux/config.h>
 #include <linux/module.h>
 #include <linux/errno.h>
+#include <linux/release.h>
 #include <linux/version.h>
 #include <linux/fs.h>
 #include <linux/kernel.h>
diff -x '.*' -ru linux-2.6.10-orig/drivers/parisc/led.c linux-2.6.10-gold/drivers/parisc/led.c
--- linux-2.6.10-orig/drivers/parisc/led.c	2004-12-24 23:34:30.000000000 +0200
+++ linux-2.6.10-gold/drivers/parisc/led.c	2005-01-16 20:47:29.000000000 +0200
@@ -26,6 +26,7 @@
 #include <linux/init.h>
 #include <linux/types.h>
 #include <linux/ioport.h>
+#include <linux/release.h>
 #include <linux/version.h>
 #include <linux/delay.h>
 #include <linux/netdevice.h>
diff -x '.*' -ru linux-2.6.10-orig/drivers/scsi/aic7xxx_old.c linux-2.6.10-gold/drivers/scsi/aic7xxx_old.c
--- linux-2.6.10-orig/drivers/scsi/aic7xxx_old.c	2004-12-24 23:35:50.000000000 +0200
+++ linux-2.6.10-gold/drivers/scsi/aic7xxx_old.c	2005-01-16 20:47:11.000000000 +0200
@@ -224,6 +224,7 @@
 #include <asm/io.h>
 #include <asm/irq.h>
 #include <asm/byteorder.h>
+#include <linux/release.h>
 #include <linux/version.h>
 #include <linux/string.h>
 #include <linux/errno.h>
diff -x '.*' -ru linux-2.6.10-orig/drivers/usb/core/hcd.c linux-2.6.10-gold/drivers/usb/core/hcd.c
--- linux-2.6.10-orig/drivers/usb/core/hcd.c	2004-12-24 23:34:58.000000000 +0200
+++ linux-2.6.10-gold/drivers/usb/core/hcd.c	2005-01-16 20:47:07.000000000 +0200
@@ -29,6 +29,7 @@
 #endif
 
 #include <linux/module.h>
+#include <linux/release.h>
 #include <linux/version.h>
 #include <linux/kernel.h>
 #include <linux/slab.h>
diff -x '.*' -ru linux-2.6.10-orig/drivers/usb/gadget/ether.c linux-2.6.10-gold/drivers/usb/gadget/ether.c
--- linux-2.6.10-orig/drivers/usb/gadget/ether.c	2004-12-24 23:35:39.000000000 +0200
+++ linux-2.6.10-gold/drivers/usb/gadget/ether.c	2005-01-16 20:46:57.000000000 +0200
@@ -37,6 +37,7 @@
 #include <linux/list.h>
 #include <linux/interrupt.h>
 #include <linux/uts.h>
+#include <linux/release.h>
 #include <linux/version.h>
 #include <linux/device.h>
 #include <linux/moduleparam.h>
diff -x '.*' -ru linux-2.6.10-orig/drivers/usb/gadget/file_storage.c linux-2.6.10-gold/drivers/usb/gadget/file_storage.c
--- linux-2.6.10-orig/drivers/usb/gadget/file_storage.c	2004-12-24 23:36:01.000000000 +0200
+++ linux-2.6.10-gold/drivers/usb/gadget/file_storage.c	2005-01-16 20:47:02.000000000 +0200
@@ -237,6 +237,7 @@
 #include <linux/string.h>
 #include <linux/suspend.h>
 #include <linux/uts.h>
+#include <linux/release.h>
 #include <linux/version.h>
 #include <linux/wait.h>
 
diff -x '.*' -ru linux-2.6.10-orig/drivers/usb/gadget/serial.c linux-2.6.10-gold/drivers/usb/gadget/serial.c
--- linux-2.6.10-orig/drivers/usb/gadget/serial.c	2004-12-24 23:35:24.000000000 +0200
+++ linux-2.6.10-gold/drivers/usb/gadget/serial.c	2005-01-16 20:46:53.000000000 +0200
@@ -31,6 +31,7 @@
 #include <linux/list.h>
 #include <linux/interrupt.h>
 #include <linux/uts.h>
+#include <linux/release.h>
 #include <linux/version.h>
 #include <linux/wait.h>
 #include <linux/proc_fs.h>
diff -x '.*' -ru linux-2.6.10-orig/drivers/usb/gadget/zero.c linux-2.6.10-gold/drivers/usb/gadget/zero.c
--- linux-2.6.10-orig/drivers/usb/gadget/zero.c	2004-12-24 23:34:32.000000000 +0200
+++ linux-2.6.10-gold/drivers/usb/gadget/zero.c	2005-01-16 20:46:49.000000000 +0200
@@ -76,6 +76,7 @@
 #include <linux/list.h>
 #include <linux/interrupt.h>
 #include <linux/uts.h>
+#include <linux/release.h>
 #include <linux/version.h>
 #include <linux/device.h>
 #include <linux/moduleparam.h>
diff -x '.*' -ru linux-2.6.10-orig/fs/cifs/connect.c linux-2.6.10-gold/fs/cifs/connect.c
--- linux-2.6.10-orig/fs/cifs/connect.c	2004-12-24 23:35:28.000000000 +0200
+++ linux-2.6.10-gold/fs/cifs/connect.c	2005-01-16 20:46:16.295338328 +0200
@@ -23,6 +23,7 @@
 #include <linux/string.h>
 #include <linux/list.h>
 #include <linux/wait.h>
+#include <linux/release.h>
 #include <linux/version.h>
 #include <linux/ipv6.h>
 #include <linux/pagemap.h>
diff -x '.*' -ru linux-2.6.10-orig/include/linux/vermagic.h linux-2.6.10-gold/include/linux/vermagic.h
--- linux-2.6.10-orig/include/linux/vermagic.h	2004-12-24 23:35:50.000000000 +0200
+++ linux-2.6.10-gold/include/linux/vermagic.h	2005-01-16 20:46:22.750357016 +0200
@@ -1,3 +1,4 @@
+#include <linux/release.h>
 #include <linux/version.h>
 #include <linux/module.h>
 
diff -x '.*' -ru linux-2.6.10-orig/include/linux/version.h linux-2.6.10-gold/include/linux/version.h
--- linux-2.6.10-orig/include/linux/version.h	2005-01-05 14:49:23.000000000 +0200
+++ linux-2.6.10-gold/include/linux/version.h	2005-01-16 20:48:20.000000000 +0200
@@ -1,3 +1,2 @@
-#define UTS_RELEASE "2.6.10-orig"
 #define LINUX_VERSION_CODE 132618
 #define KERNEL_VERSION(a,b,c) (((a) << 16) + ((b) << 8) + (c))
diff -x '.*' -ru linux-2.6.10-orig/init/version.c linux-2.6.10-gold/init/version.c
--- linux-2.6.10-orig/init/version.c	2004-12-24 23:34:45.000000000 +0200
+++ linux-2.6.10-gold/init/version.c	2005-01-16 20:47:34.000000000 +0200
@@ -10,6 +10,7 @@
 #include <linux/module.h>
 #include <linux/uts.h>
 #include <linux/utsname.h>
+#include <linux/release.h>
 #include <linux/version.h>
 
 #define version(a) Version_ ## a
diff -x '.*' -ru linux-2.6.10-orig/Makefile linux-2.6.10-gold/Makefile
--- linux-2.6.10-orig/Makefile	2004-12-24 23:35:01.000000000 +0200
+++ linux-2.6.10-gold/Makefile	2005-01-16 20:36:30.000000000 +0200
@@ -763,7 +763,8 @@
 # prepare1 creates a makefile if using a separate output directory
 prepare1: prepare2 outputmakefile
 
-prepare0: prepare1 include/linux/version.h include/asm include/config/MARKER
+prepare0: prepare1 include/linux/version.h include/linux/release.h \
+	  include/asm include/config/MARKER
 ifneq ($(KBUILD_MODULES),)
 	$(Q)rm -rf $(MODVERDIR)
 	$(Q)mkdir -p $(MODVERDIR)
@@ -820,18 +821,23 @@
 uts_len := 64
 
 define filechk_version.h
+	( echo \#define LINUX_VERSION_CODE `expr $(VERSION) \\* 65536 + $(PATCHLEVEL) \\* 256 + $(SUBLEVEL)`; \
+	 echo '#define KERNEL_VERSION(a,b,c) (((a) << 16) + ((b) << 8) + (c))'; \
+	)
+endef
+
+define filechk_release.h
 	if [ `echo -n "$(KERNELRELEASE)" | wc -c ` -gt $(uts_len) ]; then \
 	  echo '"$(KERNELRELEASE)" exceeds $(uts_len) characters' >&2; \
 	  exit 1; \
 	fi; \
-	(echo \#define UTS_RELEASE \"$(KERNELRELEASE)\"; \
-	  echo \#define LINUX_VERSION_CODE `expr $(VERSION) \\* 65536 + $(PATCHLEVEL) \\* 256 + $(SUBLEVEL)`; \
-	 echo '#define KERNEL_VERSION(a,b,c) (((a) << 16) + ((b) << 8) + (c))'; \
-	)
+	( echo \#define UTS_RELEASE \"$(KERNELRELEASE)\" )
 endef
 
 include/linux/version.h: $(srctree)/Makefile FORCE
 	$(call filechk,version.h)
+include/linux/release.h: $(srctree)/Makefile FORCE
+	$(call filechk,release.h)
 
 # ---------------------------------------------------------------------------
 
@@ -946,6 +952,7 @@
 MRPROPER_DIRS  += include/config include2
 MRPROPER_FILES += .config .config.old include/asm .version \
                   include/linux/autoconf.h include/linux/version.h \
+                  include/linux/release.h \
                   Module.symvers tags TAGS cscope*
 
 # clean - Delete most, but leave enough to build external modules
diff -x '.*' -ru linux-2.6.10-orig/scripts/checkversion.pl linux-2.6.10-gold/scripts/checkversion.pl
--- linux-2.6.10-orig/scripts/checkversion.pl	2004-12-24 23:34:33.000000000 +0200
+++ linux-2.6.10-gold/scripts/checkversion.pl	2005-01-16 20:42:40.000000000 +0200
@@ -1,7 +1,7 @@
 #! /usr/bin/perl
 #
-# checkversion find uses of LINUX_VERSION_CODE, KERNEL_VERSION, or
-# UTS_RELEASE without including <linux/version.h>, or cases of
+# checkversion find uses of LINUX_VERSION_CODE or KERNEL_VERSION
+# without including <linux/version.h>, or cases of
 # including <linux/version.h> that don't need it.
 # Copyright (C) 2003, Randy Dunlap <rddunlap@osdl.org>
 
@@ -40,9 +40,8 @@
 	    $iLinuxVersion      = $. if m/^\s*#\s*include\s*<linux\/version\.h>/o;
 	}
 
-	# Look for uses: LINUX_VERSION_CODE, KERNEL_VERSION, UTS_RELEASE
-	if (($_ =~ /LINUX_VERSION_CODE/) || ($_ =~ /\WKERNEL_VERSION/) ||
-		($_ =~ /UTS_RELEASE/)) {
+	# Look for uses: LINUX_VERSION_CODE, KERNEL_VERSION
+	if ( ($_ =~ /LINUX_VERSION_CODE/) || ($_ =~ /\WKERNEL_VERSION/) ) {
 	    $fUseVersion = 1;
 	    last LINE if $iLinuxVersion;
 	}
