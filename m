Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262332AbTIUEzC (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Sep 2003 00:55:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262333AbTIUEzB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Sep 2003 00:55:01 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:21461 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262332AbTIUEyM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Sep 2003 00:54:12 -0400
Date: Sun, 21 Sep 2003 05:54:11 +0100
From: Matthew Wilcox <willy@debian.org>
To: Matthew Wilcox <willy@debian.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: What's the point of __KERNEL_SYSCALLS__?
Message-ID: <20030921045411.GC13172@parcelfarce.linux.theplanet.co.uk>
References: <20030919164044.GF21596@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030919164044.GF21596@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 19, 2003 at 05:40:44PM +0100, Matthew Wilcox wrote:
> This doesn't seem like a big list to clean up.  Any objections to
> getting rid of them and making the calls directly?

Here's a patch that removes them for i386 and parisc.  Other arches can
catch up as they see fit.  Comments?  I've compiled the files that aren't
completely arch-specific (eg sparc or m68k).

 arch/i386/kernel/process.c                  |    2 
 arch/parisc/Kconfig                         |    2 
 arch/parisc/kernel/process.c                |    2 
 arch/parisc/kernel/smp.c                    |    2 
 drivers/char/h8.c                           |    3 -
 drivers/isdn/capi/kcapi.c                   |    4 +
 drivers/isdn/hardware/eicon/Kconfig         |    2 
 drivers/isdn/hardware/eicon/divasmain.c     |    2 
 drivers/macintosh/mediabay.c                |    2 
 drivers/md/md.c                             |    5 -
 drivers/media/dvb/dvb-core/dvb_ringbuffer.c |    1 
 drivers/media/dvb/frontends/alps_tdlb7.c    |   13 +----
 drivers/media/dvb/frontends/tda1004x.c      |    2 
 drivers/media/dvb/ttpci/av7110.c            |    2 
 drivers/media/video/msp3400.c               |    4 -
 drivers/net/hamradio/baycom_epp.c           |    3 -
 drivers/sbus/char/bbc_envctrl.c             |    6 --
 drivers/sbus/char/envctrl.c                 |    7 --
 drivers/scsi/cpqfcTSinit.c                  |    4 -
 drivers/scsi/cpqfcTSworker.c                |    4 -
 drivers/scsi/oktagon_esp.c                  |    3 -
 fs/jffs2/background.c                       |    3 -
 fs/lockd/clntlock.c                         |    3 -
 fs/lockd/svc.c                              |    2 
 include/asm-i386/unistd.h                   |   28 ----------
 include/asm-parisc/unistd.h                 |   72 ----------------------------
 include/linux/syscalls.h                    |   31 ++++++++++++
 init/do_mounts.c                            |   22 ++++----
 init/do_mounts.h                            |   16 ------
 init/do_mounts_initrd.c                     |   28 +++++-----
 init/do_mounts_md.c                         |   10 +--
 init/do_mounts_rd.c                         |   30 +++++------
 init/initramfs.c                            |    2 
 init/main.c                                 |   20 +++----
 kernel/kmod.c                               |    6 +-
 kernel/signal.c                             |    3 -
 kernel/workqueue.c                          |    5 -
 net/bluetooth/bnep/core.c                   |    2 
 net/bluetooth/rfcomm/core.c                 |    2 
 net/core/netfilter.c                        |    3 -
 net/ipv4/ipvs/ip_vs_sync.c                  |    7 --
 net/sunrpc/sched.c                          |    2 
 net/sunrpc/svc.c                            |    2 
 net/sunrpc/xprt.c                           |    3 -
 sound/isa/wavefront/wavefront_synth.c       |   15 ++---
 sound/oss/wavfront.c                        |   12 +---
 46 files changed, 117 insertions(+), 287 deletions(-)

Index: arch/i386/kernel/process.c
===================================================================
RCS file: /var/cvs/linux-2.6/arch/i386/kernel/process.c,v
retrieving revision 1.4
diff -u -p -r1.4 process.c
--- arch/i386/kernel/process.c	8 Sep 2003 21:41:30 -0000	1.4
+++ arch/i386/kernel/process.c	21 Sep 2003 04:18:45 -0000
@@ -11,7 +11,6 @@
  * This file handles the architecture-dependent parts of process handling..
  */
 
-#define __KERNEL_SYSCALLS__
 #include <stdarg.h>
 
 #include <linux/errno.h>
@@ -23,7 +22,6 @@
 #include <linux/smp.h>
 #include <linux/smp_lock.h>
 #include <linux/stddef.h>
-#include <linux/unistd.h>
 #include <linux/slab.h>
 #include <linux/vmalloc.h>
 #include <linux/user.h>
Index: arch/parisc/Kconfig
===================================================================
RCS file: /var/cvs/linux-2.6/arch/parisc/Kconfig,v
retrieving revision 1.10
diff -u -p -r1.10 Kconfig
--- arch/parisc/Kconfig	20 Sep 2003 22:48:34 -0000	1.10
+++ arch/parisc/Kconfig	21 Sep 2003 01:19:35 -0000
@@ -197,7 +197,7 @@ source "net/ax25/Kconfig"
 
 source "net/irda/Kconfig"
 
-#source "drivers/isdn/Kconfig"
+source "drivers/isdn/Kconfig"
 
 #source "drivers/telephony/Kconfig"
 
Index: arch/parisc/kernel/process.c
===================================================================
RCS file: /var/cvs/linux-2.6/arch/parisc/kernel/process.c,v
retrieving revision 1.4
diff -u -p -r1.4 process.c
--- arch/parisc/kernel/process.c	8 Sep 2003 22:00:21 -0000	1.4
+++ arch/parisc/kernel/process.c	21 Sep 2003 03:26:26 -0000
@@ -7,7 +7,6 @@
  * This file handles the architecture-dependent parts of process handling..
  */
 
-#define __KERNEL_SYSCALLS__
 #include <stdarg.h>
 
 #include <linux/elf.h>
@@ -18,7 +17,6 @@
 #include <linux/ptrace.h>
 #include <linux/sched.h>
 #include <linux/stddef.h>
-#include <linux/unistd.h>
 
 #include <asm/io.h>
 #include <asm/offsets.h>
Index: arch/parisc/kernel/smp.c
===================================================================
RCS file: /var/cvs/linux-2.6/arch/parisc/kernel/smp.c,v
retrieving revision 1.2
diff -u -p -r1.2 smp.c
--- arch/parisc/kernel/smp.c	23 Aug 2003 02:46:29 -0000	1.2
+++ arch/parisc/kernel/smp.c	20 Sep 2003 00:28:55 -0000
@@ -16,7 +16,6 @@
 **      the Free Software Foundation; either version 2 of the License, or
 **      (at your option) any later version.
 */
-#define __KERNEL_SYSCALLS__
 #undef ENTRY_SYS_CPUS	/* syscall support for iCOD-like functionality */
 
 #include <linux/autoconf.h>
@@ -49,7 +48,6 @@
 #include <asm/pgalloc.h>
 #include <asm/processor.h>
 #include <asm/ptrace.h>
-#include <asm/unistd.h>
 #include <asm/cacheflush.h>
 
 #define kDEBUG 0
Index: drivers/char/h8.c
===================================================================
RCS file: /var/cvs/linux-2.6/drivers/char/h8.c,v
retrieving revision 1.1
diff -u -p -r1.1 h8.c
--- drivers/char/h8.c	29 Jul 2003 17:01:02 -0000	1.1
+++ drivers/char/h8.c	21 Sep 2003 01:17:20 -0000
@@ -30,9 +30,6 @@
 #include <linux/init.h>
 #include <linux/slab.h>
 
-#define __KERNEL_SYSCALLS__
-#include <asm/unistd.h>
-
 #include "h8.h"
 
 #define DEBUG_H8
Index: drivers/isdn/capi/kcapi.c
===================================================================
RCS file: /var/cvs/linux-2.6/drivers/isdn/capi/kcapi.c,v
retrieving revision 1.2
diff -u -p -r1.2 kcapi.c
--- drivers/isdn/capi/kcapi.c	8 Sep 2003 21:42:06 -0000	1.2
+++ drivers/isdn/capi/kcapi.c	21 Sep 2003 01:38:13 -0000
@@ -79,7 +79,9 @@ capi_ctr_get(struct capi_ctr *card)
 {
 	if (!try_module_get(card->owner))
 		return NULL;
+#ifdef CONFIG_MODULES
 	DBG("Reserve module: %s", card->owner->name);
+#endif
 	return card;
 }
 
@@ -87,7 +89,9 @@ static inline void
 capi_ctr_put(struct capi_ctr *card)
 {
 	module_put(card->owner);
+#ifdef CONFIG_MODULES
 	DBG("Release module: %s", card->owner->name);
+#endif
 }
 
 /* ------------------------------------------------------------- */
Index: drivers/isdn/hardware/eicon/Kconfig
===================================================================
RCS file: /var/cvs/linux-2.6/drivers/isdn/hardware/eicon/Kconfig,v
retrieving revision 1.1
diff -u -p -r1.1 Kconfig
--- drivers/isdn/hardware/eicon/Kconfig	29 Jul 2003 17:01:11 -0000	1.1
+++ drivers/isdn/hardware/eicon/Kconfig	21 Sep 2003 01:47:32 -0000
@@ -12,7 +12,7 @@ config CAPI_EICON
 
 config ISDN_DIVAS
 	tristate "Support Eicon DIVA Server cards"
-	depends on CAPI_EICON && PROC_FS && PCI && m
+	depends on CAPI_EICON && PROC_FS && PCI
 	help
 	  Say Y here if you have an Eicon Networks DIVA Server PCI ISDN card.
 	  In order to use this card, additional firmware is necessary, which
Index: drivers/isdn/hardware/eicon/divasmain.c
===================================================================
RCS file: /var/cvs/linux-2.6/drivers/isdn/hardware/eicon/divasmain.c,v
retrieving revision 1.3
diff -u -p -r1.3 divasmain.c
--- drivers/isdn/hardware/eicon/divasmain.c	12 Aug 2003 19:11:05 -0000	1.3
+++ drivers/isdn/hardware/eicon/divasmain.c	21 Sep 2003 01:18:38 -0000
@@ -9,13 +9,11 @@
  * of the GNU General Public License, incorporated herein by reference.
  */
 
-#define __KERNEL_SYSCALLS__
 #include <linux/config.h>
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/sched.h>
-#include <linux/unistd.h>
 #include <linux/vmalloc.h>
 #include <linux/devfs_fs_kernel.h>
 #include <asm/uaccess.h>
Index: drivers/macintosh/mediabay.c
===================================================================
RCS file: /var/cvs/linux-2.6/drivers/macintosh/mediabay.c,v
retrieving revision 1.2
diff -u -p -r1.2 mediabay.c
--- drivers/macintosh/mediabay.c	8 Sep 2003 21:42:08 -0000	1.2
+++ drivers/macintosh/mediabay.c	21 Sep 2003 02:09:34 -0000
@@ -10,7 +10,6 @@
  *  as published by the Free Software Foundation; either version
  *  2 of the License, or (at your option) any later version.
  */
-#define __KERNEL_SYSCALLS__
 
 #include <linux/config.h>
 #include <linux/types.h>
@@ -21,7 +20,6 @@
 #include <linux/timer.h>
 #include <linux/hdreg.h>
 #include <linux/stddef.h>
-#include <linux/unistd.h>
 #include <linux/init.h>
 #include <linux/ide.h>
 #include <asm/prom.h>
Index: drivers/md/md.c
===================================================================
RCS file: /var/cvs/linux-2.6/drivers/md/md.c,v
retrieving revision 1.4
diff -u -p -r1.4 md.c
--- drivers/md/md.c	8 Sep 2003 21:42:08 -0000	1.4
+++ drivers/md/md.c	21 Sep 2003 02:31:10 -0000
@@ -39,12 +39,7 @@
 
 #include <linux/init.h>
 
-#ifdef CONFIG_KMOD
 #include <linux/kmod.h>
-#endif
-
-#define __KERNEL_SYSCALLS__
-#include <linux/unistd.h>
 
 #include <asm/unaligned.h>
 
Index: drivers/media/dvb/dvb-core/dvb_ringbuffer.c
===================================================================
RCS file: /var/cvs/linux-2.6/drivers/media/dvb/dvb-core/dvb_ringbuffer.c,v
retrieving revision 1.1
diff -u -p -r1.1 dvb_ringbuffer.c
--- drivers/media/dvb/dvb-core/dvb_ringbuffer.c	29 Jul 2003 17:01:13 -0000	1.1
+++ drivers/media/dvb/dvb-core/dvb_ringbuffer.c	21 Sep 2003 02:09:42 -0000
@@ -31,7 +31,6 @@
 
 
 
-#define __KERNEL_SYSCALLS__
 #include <linux/errno.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
Index: drivers/media/dvb/frontends/alps_tdlb7.c
===================================================================
RCS file: /var/cvs/linux-2.6/drivers/media/dvb/frontends/alps_tdlb7.c,v
retrieving revision 1.2
diff -u -p -r1.2 alps_tdlb7.c
--- drivers/media/dvb/frontends/alps_tdlb7.c	29 Jul 2003 17:25:42 -0000	1.2
+++ drivers/media/dvb/frontends/alps_tdlb7.c	21 Sep 2003 04:01:52 -0000
@@ -44,12 +44,11 @@
 
 
 
-#define __KERNEL_SYSCALLS__
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/vmalloc.h>
 #include <linux/fs.h>
-#include <linux/unistd.h>
+#include <linux/syscalls.h>
 
 #include "dvb_frontend.h"
 
@@ -68,8 +67,6 @@ static char * mcfile = "/usr/lib/DVB/dri
 #define SP8870_CODE_OFFSET 0x0A
 
 
-static int errno;
-
 static struct dvb_frontend_info tdlb7_info = {
 	.name			 = "Alps TDLB7",
 	.type			 = FE_OFDM,
@@ -161,25 +158,25 @@ static int sp8870_read_code(const char *
 	loff_t l;
 	char *dp;
 
-	fd = open(fn, 0, 0);
+	fd = sys_open(fn, 0, 0);
 	if (fd == -1) {
                 printk(KERN_INFO "%s: Unable to load '%s'.\n", __FUNCTION__, fn);
 		return -1;
 	}
-	l = lseek(fd, 0L, 2);
+	l = sys_lseek(fd, 0L, 2);
 	if (l <= 0 || l < SP8870_CODE_OFFSET+SP8870_CODE_SIZE) {
 	        printk(KERN_INFO "%s: code file too small '%s'\n", __FUNCTION__, fn);
 		sys_close(fd);
 		return -1;
 	}
-	lseek(fd, SP8870_CODE_OFFSET, 0);
+	sys_lseek(fd, SP8870_CODE_OFFSET, 0);
 	*fp= dp = vmalloc(SP8870_CODE_SIZE);
 	if (dp == NULL)	{
 		printk(KERN_INFO "%s: Out of memory loading '%s'.\n", __FUNCTION__, fn);
 		sys_close(fd);
 		return -1;
 	}
-	if (read(fd, dp, SP8870_CODE_SIZE) != SP8870_CODE_SIZE) {
+	if (sys_read(fd, dp, SP8870_CODE_SIZE) != SP8870_CODE_SIZE) {
 		printk(KERN_INFO "%s: Failed to read '%s'.\n",__FUNCTION__, fn);
 		vfree(dp);
 		sys_close(fd);
Index: drivers/media/dvb/frontends/tda1004x.c
===================================================================
RCS file: /var/cvs/linux-2.6/drivers/media/dvb/frontends/tda1004x.c,v
retrieving revision 1.1
diff -u -p -r1.1 tda1004x.c
--- drivers/media/dvb/frontends/tda1004x.c	29 Jul 2003 17:25:42 -0000	1.1
+++ drivers/media/dvb/frontends/tda1004x.c	21 Sep 2003 02:09:47 -0000
@@ -30,7 +30,6 @@
  */
 
 
-#define __KERNEL_SYSCALLS__
 #include <linux/kernel.h>
 #include <linux/vmalloc.h>
 #include <linux/module.h>
@@ -38,7 +37,6 @@
 #include <linux/string.h>
 #include <linux/slab.h>
 #include <linux/fs.h>
-#include <linux/unistd.h>
 #include <linux/fcntl.h>
 #include <linux/errno.h>
 #include "dvb_frontend.h"
Index: drivers/media/dvb/ttpci/av7110.c
===================================================================
RCS file: /var/cvs/linux-2.6/drivers/media/dvb/ttpci/av7110.c,v
retrieving revision 1.3
diff -u -p -r1.3 av7110.c
--- drivers/media/dvb/ttpci/av7110.c	21 Sep 2003 01:09:35 -0000	1.3
+++ drivers/media/dvb/ttpci/av7110.c	21 Sep 2003 02:09:52 -0000
@@ -33,14 +33,12 @@
 /* for debugging ARM communication: */
 //#define COM_DEBUG
 
-#define __KERNEL_SYSCALLS__
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/kmod.h>
 #include <linux/delay.h>
 #include <linux/fs.h>
 #include <linux/timer.h>
-#include <linux/unistd.h>
 #include <linux/byteorder/swabb.h>
 #include <linux/poll.h>
 #include <linux/slab.h>
Index: drivers/media/video/msp3400.c
===================================================================
RCS file: /var/cvs/linux-2.6/drivers/media/video/msp3400.c,v
retrieving revision 1.2
diff -u -p -r1.2 msp3400.c
--- drivers/media/video/msp3400.c	12 Aug 2003 19:11:06 -0000	1.2
+++ drivers/media/video/msp3400.c	21 Sep 2003 02:09:59 -0000
@@ -50,10 +50,6 @@
 #include <asm/semaphore.h>
 #include <asm/pgtable.h>
 
-/* kernel_thread */
-#define __KERNEL_SYSCALLS__
-#include <linux/unistd.h>
-
 #include <media/audiochip.h>
 #include "msp3400.h"
 
Index: drivers/net/hamradio/baycom_epp.c
===================================================================
RCS file: /var/cvs/linux-2.6/drivers/net/hamradio/baycom_epp.c,v
retrieving revision 1.1
diff -u -p -r1.1 baycom_epp.c
--- drivers/net/hamradio/baycom_epp.c	29 Jul 2003 17:01:19 -0000	1.1
+++ drivers/net/hamradio/baycom_epp.c	19 Sep 2003 23:24:43 -0000
@@ -59,9 +59,6 @@
 #include <net/ax25.h> 
 #endif /* CONFIG_AX25 || CONFIG_AX25_MODULE */
 
-#define __KERNEL_SYSCALLS__
-#include <linux/unistd.h>
-
 /* --------------------------------------------------------------------- */
 
 #define BAYCOM_DEBUG
Index: drivers/sbus/char/bbc_envctrl.c
===================================================================
RCS file: /var/cvs/linux-2.6/drivers/sbus/char/bbc_envctrl.c,v
retrieving revision 1.1
diff -u -p -r1.1 bbc_envctrl.c
--- drivers/sbus/char/bbc_envctrl.c	29 Jul 2003 17:01:28 -0000	1.1
+++ drivers/sbus/char/bbc_envctrl.c	21 Sep 2003 04:10:52 -0000
@@ -7,11 +7,9 @@
 #include <linux/kernel.h>
 #include <linux/sched.h>
 #include <linux/slab.h>
+#include <linux/syscalls.h>
 #include <asm/oplib.h>
 #include <asm/ebus.h>
-#define __KERNEL_SYSCALLS__
-static int errno;
-#include <asm/unistd.h>
 
 #include "bbc_i2c.h"
 #include "max1617.h"
@@ -198,7 +196,7 @@ static void do_envctrl_shutdown(struct b
 	printk(KERN_CRIT "kenvctrld: Shutting down the system now.\n");
 
 	shutting_down = 1;
-	if (execve("/sbin/shutdown", argv, envp) < 0)
+	if (sys_execve("/sbin/shutdown", argv, envp) < 0)
 		printk(KERN_CRIT "envctrl: shutdown execution failed\n");
 }
 
Index: drivers/sbus/char/envctrl.c
===================================================================
RCS file: /var/cvs/linux-2.6/drivers/sbus/char/envctrl.c,v
retrieving revision 1.2
diff -u -p -r1.2 envctrl.c
--- drivers/sbus/char/envctrl.c	29 Jul 2003 17:25:45 -0000	1.2
+++ drivers/sbus/char/envctrl.c	21 Sep 2003 04:11:40 -0000
@@ -29,16 +29,13 @@
 #include <linux/miscdevice.h>
 #include <linux/mm.h>
 #include <linux/slab.h>
+#include <linux/syscalls.h>
 #include <linux/kernel.h>
 
 #include <asm/ebus.h>
 #include <asm/uaccess.h>
 #include <asm/envctrl.h>
 
-#define __KERNEL_SYSCALLS__
-static int errno;
-#include <asm/unistd.h>
-
 #define ENVCTRL_MINOR	162
 
 #define PCF8584_ADDRESS	0x55
@@ -1004,7 +1001,7 @@ static void envctrl_do_shutdown(void)
 
 	inprog = 1;
 	printk(KERN_CRIT "kenvctrld: WARNING: Shutting down the system now.\n");
-	if (0 > execve("/sbin/shutdown", argv, envp)) {
+	if (0 > sys_execve("/sbin/shutdown", argv, envp)) {
 		printk(KERN_CRIT "kenvctrld: WARNING: system shutdown failed!\n"); 
 		inprog = 0;  /* unlikely to succeed, but we could try again */
 	}
Index: drivers/scsi/cpqfcTSinit.c
===================================================================
RCS file: /var/cvs/linux-2.6/drivers/scsi/cpqfcTSinit.c,v
retrieving revision 1.4
diff -u -p -r1.4 cpqfcTSinit.c
--- drivers/scsi/cpqfcTSinit.c	8 Sep 2003 21:42:19 -0000	1.4
+++ drivers/scsi/cpqfcTSinit.c	21 Sep 2003 01:13:45 -0000
@@ -46,10 +46,6 @@
 #include <linux/ioport.h>  // request_region() prototype
 #include <linux/completion.h>
 
-#ifdef __alpha__
-#define __KERNEL_SYSCALLS__
-#endif
-#include <asm/unistd.h>
 #include <asm/io.h>
 #include <asm/uaccess.h>   // ioctl related
 #include <asm/irq.h>
Index: drivers/scsi/cpqfcTSworker.c
===================================================================
RCS file: /var/cvs/linux-2.6/drivers/scsi/cpqfcTSworker.c,v
retrieving revision 1.4
diff -u -p -r1.4 cpqfcTSworker.c
--- drivers/scsi/cpqfcTSworker.c	8 Sep 2003 21:42:19 -0000	1.4
+++ drivers/scsi/cpqfcTSworker.c	21 Sep 2003 01:13:57 -0000
@@ -32,11 +32,7 @@
 #include <linux/smp_lock.h>
 #include <linux/pci.h>
 
-#define __KERNEL_SYSCALLS__
-
 #define SHUTDOWN_SIGS	(sigmask(SIGKILL)|sigmask(SIGINT)|sigmask(SIGTERM))
-
-#include <linux/unistd.h>
 
 #include <asm/system.h>
 #include <asm/irq.h>
Index: drivers/scsi/oktagon_esp.c
===================================================================
RCS file: /var/cvs/linux-2.6/drivers/scsi/oktagon_esp.c,v
retrieving revision 1.2
diff -u -p -r1.2 oktagon_esp.c
--- drivers/scsi/oktagon_esp.c	29 Jul 2003 17:25:47 -0000	1.2
+++ drivers/scsi/oktagon_esp.c	21 Sep 2003 01:14:12 -0000
@@ -12,7 +12,6 @@
 #define USE_BOTTOM_HALF
 #endif
 
-#define __KERNEL_SYSCALLS__
 #include <linux/module.h>
 
 #include <linux/kernel.h>
@@ -42,8 +41,6 @@
 #include <linux/workqueue.h>
 #include <linux/interrupt.h>
 #endif
-
-#include <linux/unistd.h>
 
 /* The controller registers can be found in the Z2 config area at these
  * offsets:
Index: fs/jffs2/background.c
===================================================================
RCS file: /var/cvs/linux-2.6/fs/jffs2/background.c,v
retrieving revision 1.1
diff -u -p -r1.1 background.c
--- fs/jffs2/background.c	29 Jul 2003 17:01:41 -0000	1.1
+++ fs/jffs2/background.c	20 Sep 2003 00:26:40 -0000
@@ -11,14 +11,11 @@
  *
  */
 
-#define __KERNEL_SYSCALLS__
-
 #include <linux/kernel.h>
 #include <linux/jffs2.h>
 #include <linux/mtd/mtd.h>
 #include <linux/completion.h>
 #include <linux/sched.h>
-#include <linux/unistd.h>
 #include "nodelist.h"
 
 
Index: fs/lockd/clntlock.c
===================================================================
RCS file: /var/cvs/linux-2.6/fs/lockd/clntlock.c,v
retrieving revision 1.2
diff -u -p -r1.2 clntlock.c
--- fs/lockd/clntlock.c	29 Jul 2003 17:25:52 -0000	1.2
+++ fs/lockd/clntlock.c	20 Sep 2003 00:26:46 -0000
@@ -6,13 +6,10 @@
  * Copyright (C) 1996, Olaf Kirch <okir@monad.swb.de>
  */
 
-#define __KERNEL_SYSCALLS__
-
 #include <linux/module.h>
 #include <linux/types.h>
 #include <linux/time.h>
 #include <linux/nfs_fs.h>
-#include <linux/unistd.h>
 #include <linux/sunrpc/clnt.h>
 #include <linux/sunrpc/svc.h>
 #include <linux/lockd/lockd.h>
Index: fs/lockd/svc.c
===================================================================
RCS file: /var/cvs/linux-2.6/fs/lockd/svc.c,v
retrieving revision 1.5
diff -u -p -r1.5 svc.c
--- fs/lockd/svc.c	8 Sep 2003 21:42:35 -0000	1.5
+++ fs/lockd/svc.c	20 Sep 2003 00:26:51 -0000
@@ -12,7 +12,6 @@
  * Copyright (C) 1995, 1996 Olaf Kirch <okir@monad.swb.de>
  */
 
-#define __KERNEL_SYSCALLS__
 #include <linux/config.h>
 #include <linux/module.h>
 #include <linux/init.h>
@@ -23,7 +22,6 @@
 #include <linux/errno.h>
 #include <linux/in.h>
 #include <linux/uio.h>
-#include <linux/unistd.h>
 #include <linux/slab.h>
 #include <linux/smp.h>
 #include <linux/smp_lock.h>
Index: include/asm-i386/unistd.h
===================================================================
RCS file: /var/cvs/linux-2.6/include/asm-i386/unistd.h,v
retrieving revision 1.2
diff -u -p -r1.2 unistd.h
--- include/asm-i386/unistd.h	23 Aug 2003 02:47:17 -0000	1.2
+++ include/asm-i386/unistd.h	21 Sep 2003 04:18:12 -0000
@@ -370,34 +370,6 @@ __asm__ volatile ("push %%ebp ; movl %%e
 __syscall_return(type,__res); \
 }
 
-#ifdef __KERNEL_SYSCALLS__
-
-/*
- * we need this inline - forking from kernel space will result
- * in NO COPY ON WRITE (!!!), until an execve is executed. This
- * is no problem, but for the stack. This is handled by not letting
- * main() use the stack at all after fork(). Thus, no function
- * calls - which means inline code for fork too, as otherwise we
- * would use the stack upon exit from 'fork()'.
- *
- * Actually only pause and fork are needed inline, so that there
- * won't be any messing with the stack from main(), but we define
- * some others too.
- */
-#define __NR__exit __NR_exit
-static inline _syscall0(pid_t,setsid)
-static inline _syscall3(int,write,int,fd,const char *,buf,off_t,count)
-static inline _syscall3(int,read,int,fd,char *,buf,off_t,count)
-static inline _syscall3(off_t,lseek,int,fd,off_t,offset,int,count)
-static inline _syscall1(int,dup,int,fd)
-static inline _syscall3(int,execve,const char *,file,char **,argv,char **,envp)
-static inline _syscall3(int,open,const char *,file,int,flag,int,mode)
-static inline _syscall1(int,close,int,fd)
-static inline _syscall1(int,_exit,int,exitcode)
-static inline _syscall3(pid_t,waitpid,pid_t,pid,int *,wait_stat,int,options)
-
-#endif
-
 /*
  * "Conditional" syscalls
  *
Index: include/asm-parisc/unistd.h
===================================================================
RCS file: /var/cvs/linux-2.6/include/asm-parisc/unistd.h,v
retrieving revision 1.1
diff -u -p -r1.1 unistd.h
--- include/asm-parisc/unistd.h	29 Jul 2003 17:02:04 -0000	1.1
+++ include/asm-parisc/unistd.h	21 Sep 2003 04:05:10 -0000
@@ -836,79 +836,7 @@ type name(type1 arg1, type2 arg2, type3 
     return K_INLINE_SYSCALL(name, 6, arg1, arg2, arg3, arg4, arg5, arg6);	\
 }
 
-
-#ifdef __KERNEL_SYSCALLS__
-
-#include <asm/current.h>
-
-static inline pid_t setsid(void)
-{
-	extern long sys_setsid(void);
-	return sys_setsid();
-}
-
-static inline int write(int fd, const char *buf, off_t count)
-{
-	extern long sys_write(int, const char *, int);
-	return sys_write(fd, buf, count);
-}
-
-static inline int read(int fd, char *buf, off_t count)
-{
-	extern long sys_read(int, char *, int);
-	return sys_read(fd, buf, count);
-}
-
-static inline off_t lseek(int fd, off_t offset, int count)
-{
-	extern off_t sys_lseek(int, off_t, int);
-	return sys_lseek(fd, offset, count);
-}
-
-static inline int dup(int fd)
-{
-	extern long sys_dup(int);
-	return sys_dup(fd);
-}
-
-static inline int execve(char *filename, char * argv [],
-	char * envp[])
-{
-	extern int __execve(char *, char **, char **, struct task_struct *);
-	return __execve(filename, argv, envp, current);
-}
-
-static inline int open(const char *file, int flag, int mode)
-{
-	extern long sys_open(const char *, int, int);
-	return sys_open(file, flag, mode);
-}
-
-static inline int close(int fd)
-{
-	extern asmlinkage long sys_close(unsigned int);
-	return sys_close(fd);
-}
-
-static inline int _exit(int exitcode)
-{
-	extern long sys_exit(int) __attribute__((noreturn));
-	return sys_exit(exitcode);
-}
-
-struct rusage;
-extern asmlinkage long sys_wait4(pid_t, unsigned int *, int, struct rusage *);
-
-static inline pid_t waitpid(pid_t pid, int *wait_stat, int options)
-{
-	return sys_wait4(pid, wait_stat, options, NULL);
-}
-
-#endif	/* __KERNEL_SYSCALLS__ */
-
 #endif /* __ASSEMBLY__ */
-
-#undef STR
 
 /*
  * "Conditional" syscalls
Index: include/linux/syscalls.h
===================================================================
RCS file: include/linux/syscalls.h
diff -N include/linux/syscalls.h
--- /dev/null	1 Jan 1970 00:00:00 -0000
+++ include/linux/syscalls.h	21 Sep 2003 03:17:01 -0000
@@ -0,0 +1,31 @@
+/*
+ * linux/syscall.h
+ *
+ * Prototypes for syscalls that get called by various bits of the kernel
+ */
+
+#ifndef _LINUX_SYSCALL_H
+#define _LINUX_SYSCALL_H
+
+#include <linux/linkage.h>
+
+asmlinkage long sys_unlink(const char *name);
+asmlinkage long sys_mknod(const char *name, int mode, dev_t dev);
+asmlinkage long sys_newstat(char * filename, struct stat * statbuf);
+asmlinkage long sys_ioctl(int fd, int cmd, unsigned long arg);
+asmlinkage long sys_mkdir(const char *name, int mode);
+asmlinkage long sys_rmdir(const char *name);
+asmlinkage long sys_chdir(const char *name);
+asmlinkage long sys_fchdir(int fd);
+asmlinkage long sys_chroot(const char *name);
+asmlinkage long sys_mount(char *dev_name, char *dir_name, char *type,
+				 unsigned long flags, void *data);
+asmlinkage long sys_umount(char *name, int flags);
+asmlinkage long sys_execve(char *file, char **argv, char **envp);
+asmlinkage long sys_dup(int fd);
+asmlinkage long sys_read(int fd, char * buf, off_t count);
+asmlinkage long sys_write(int fd, const char * buf, off_t count);
+asmlinkage long sys_lseek(int fd, off_t offset, unsigned int origin);
+asmlinkage long sys_setsid(void);
+
+#endif /* _LINUX_SYSCALL_H */
Index: init/do_mounts.c
===================================================================
RCS file: /var/cvs/linux-2.6/init/do_mounts.c,v
retrieving revision 1.3
diff -u -p -r1.3 do_mounts.c
--- init/do_mounts.c	23 Aug 2003 02:47:25 -0000	1.3
+++ init/do_mounts.c	20 Sep 2003 15:00:17 -0000
@@ -63,11 +63,11 @@ static dev_t __init try_name(char *name,
 	/* read device number from .../dev */
 
 	sprintf(path, "/sys/block/%s/dev", name);
-	fd = open(path, 0, 0);
+	fd = sys_open(path, 0, 0);
 	if (fd < 0)
 		goto fail;
-	len = read(fd, buf, 32);
-	close(fd);
+	len = sys_read(fd, buf, 32);
+	sys_close(fd);
 	if (len <= 0 || len == 32 || buf[len - 1] != '\n')
 		goto fail;
 	buf[len - 1] = '\0';
@@ -91,11 +91,11 @@ static dev_t __init try_name(char *name,
 
 	/* otherwise read range from .../range */
 	sprintf(path, "/sys/block/%s/range", name);
-	fd = open(path, 0, 0);
+	fd = sys_open(path, 0, 0);
 	if (fd < 0)
 		goto fail;
-	len = read(fd, buf, 32);
-	close(fd);
+	len = sys_read(fd, buf, 32);
+	sys_close(fd);
 	if (len <= 0 || len == 32 || buf[len - 1] != '\n')
 		goto fail;
 	buf[len - 1] = '\0';
@@ -317,21 +317,21 @@ void __init change_floppy(char *fmt, ...
 	va_start(args, fmt);
 	vsprintf(buf, fmt, args);
 	va_end(args);
-	fd = open("/dev/root", O_RDWR | O_NDELAY, 0);
+	fd = sys_open("/dev/root", O_RDWR | O_NDELAY, 0);
 	if (fd >= 0) {
 		sys_ioctl(fd, FDEJECT, 0);
-		close(fd);
+		sys_close(fd);
 	}
 	printk(KERN_NOTICE "VFS: Insert %s and press ENTER\n", buf);
-	fd = open("/dev/console", O_RDWR, 0);
+	fd = sys_open("/dev/console", O_RDWR, 0);
 	if (fd >= 0) {
 		sys_ioctl(fd, TCGETS, (long)&termios);
 		termios.c_lflag &= ~ICANON;
 		sys_ioctl(fd, TCSETSF, (long)&termios);
-		read(fd, &c, 1);
+		sys_read(fd, &c, 1);
 		termios.c_lflag |= ICANON;
 		sys_ioctl(fd, TCSETSF, (long)&termios);
-		close(fd);
+		sys_close(fd);
 	}
 }
 #endif
Index: init/do_mounts.h
===================================================================
RCS file: /var/cvs/linux-2.6/init/do_mounts.h,v
retrieving revision 1.3
diff -u -p -r1.3 do_mounts.h
--- init/do_mounts.h	23 Aug 2003 02:47:25 -0000	1.3
+++ init/do_mounts.h	21 Sep 2003 03:08:05 -0000
@@ -1,26 +1,12 @@
-#define __KERNEL_SYSCALLS__
 #include <linux/config.h>
 #include <linux/kernel.h>
 #include <linux/devfs_fs_kernel.h>
 #include <linux/init.h>
-#include <linux/unistd.h>
 #include <linux/slab.h>
 #include <linux/mount.h>
 #include <linux/major.h>
 #include <linux/root_dev.h>
-
-asmlinkage long sys_unlink(const char *name);
-asmlinkage long sys_mknod(const char *name, int mode, dev_t dev);
-asmlinkage long sys_newstat(char * filename, struct stat * statbuf);
-asmlinkage long sys_ioctl(int fd, int cmd, unsigned long arg);
-asmlinkage long sys_mkdir(const char *name, int mode);
-asmlinkage long sys_rmdir(const char *name);
-asmlinkage long sys_chdir(const char *name);
-asmlinkage long sys_fchdir(int fd);
-asmlinkage long sys_chroot(const char *name);
-asmlinkage long sys_mount(char *dev_name, char *dir_name, char *type,
-				 unsigned long flags, void *data);
-asmlinkage long sys_umount(char *name, int flags);
+#include <linux/syscalls.h>
 
 dev_t name_to_dev_t(char *name);
 void  change_floppy(char *fmt, ...);
Index: init/do_mounts_initrd.c
===================================================================
RCS file: /var/cvs/linux-2.6/init/do_mounts_initrd.c,v
retrieving revision 1.2
diff -u -p -r1.2 do_mounts_initrd.c
--- init/do_mounts_initrd.c	29 Jul 2003 17:25:55 -0000	1.2
+++ init/do_mounts_initrd.c	20 Sep 2003 15:05:43 -0000
@@ -26,13 +26,13 @@ static int __init do_linuxrc(void * shel
 	static char *argv[] = { "linuxrc", NULL, };
 	extern char * envp_init[];
 
-	close(old_fd);close(root_fd);
-	close(0);close(1);close(2);
-	setsid();
-	(void) open("/dev/console",O_RDWR,0);
-	(void) dup(0);
-	(void) dup(0);
-	return execve(shell, argv, envp_init);
+	sys_close(old_fd);sys_close(root_fd);
+	sys_close(0);sys_close(1);sys_close(2);
+	sys_setsid();
+	(void) sys_open("/dev/console",O_RDWR,0);
+	(void) sys_dup(0);
+	(void) sys_dup(0);
+	return sys_execve(shell, argv, envp_init);
 }
 
 static void __init handle_initrd(void)
@@ -45,8 +45,8 @@ static void __init handle_initrd(void)
 	/* mount initrd on rootfs' /root */
 	mount_block_root("/dev/root.old", root_mountflags & ~MS_RDONLY);
 	sys_mkdir("/old", 0700);
-	root_fd = open("/", 0, 0);
-	old_fd = open("/old", 0, 0);
+	root_fd = sys_open("/", 0, 0);
+	old_fd = sys_open("/old", 0, 0);
 	/* move initrd over / and chdir/chroot in initrd root */
 	sys_chdir("/root");
 	sys_mount(".", "/", NULL, MS_MOVE, NULL);
@@ -55,7 +55,7 @@ static void __init handle_initrd(void)
 
 	pid = kernel_thread(do_linuxrc, "/linuxrc", SIGCHLD);
 	if (pid > 0) {
-		while (pid != waitpid(-1, &i, 0))
+		while (pid != sys_wait4(-1, &i, 0, NULL))
 			yield();
 	}
 
@@ -65,8 +65,8 @@ static void __init handle_initrd(void)
 	/* switch root and cwd back to / of rootfs */
 	sys_fchdir(root_fd);
 	sys_chroot(".");
-	close(old_fd);
-	close(root_fd);
+	sys_close(old_fd);
+	sys_close(root_fd);
 	umount_devfs("/old/dev");
 
 	if (real_root_dev == Root_RAM0) {
@@ -82,7 +82,7 @@ static void __init handle_initrd(void)
 	if (!error)
 		printk("okay\n");
 	else {
-		int fd = open("/dev/root.old", O_RDWR, 0);
+		int fd = sys_open("/dev/root.old", O_RDWR, 0);
 		printk("failed\n");
 		printk(KERN_NOTICE "Unmounting old root\n");
 		sys_umount("/old", MNT_DETACH);
@@ -91,7 +91,7 @@ static void __init handle_initrd(void)
 			error = fd;
 		} else {
 			error = sys_ioctl(fd, BLKFLSBUF, 0);
-			close(fd);
+			sys_close(fd);
 		}
 		printk(!error ? "okay\n" : "failed\n");
 	}
Index: init/do_mounts_md.c
===================================================================
RCS file: /var/cvs/linux-2.6/init/do_mounts_md.c,v
retrieving revision 1.1
diff -u -p -r1.1 do_mounts_md.c
--- init/do_mounts_md.c	29 Jul 2003 17:02:19 -0000	1.1
+++ init/do_mounts_md.c	20 Sep 2003 15:06:51 -0000
@@ -154,7 +154,7 @@ static void __init md_setup_drive(void)
 
 		printk(KERN_INFO "md: Loading md%d: %s\n", minor, md_setup_args.device_names[minor]);
 
-		fd = open(name, 0, 0);
+		fd = sys_open(name, 0, 0);
 		if (fd < 0) {
 			printk(KERN_ERR "md: open failed - cannot start array %d\n", minor);
 			continue;
@@ -163,7 +163,7 @@ static void __init md_setup_drive(void)
 			printk(KERN_WARNING
 			       "md: Ignoring md=%d, already autodetected. (Use raid=noautodetect)\n",
 			       minor);
-			close(fd);
+			sys_close(fd);
 			continue;
 		}
 
@@ -209,7 +209,7 @@ static void __init md_setup_drive(void)
 			err = sys_ioctl(fd, RUN_ARRAY, 0);
 		if (err)
 			printk(KERN_WARNING "md: starting md%d failed\n", minor);
-		close(fd);
+		sys_close(fd);
 	}
 }
 
@@ -243,10 +243,10 @@ void __init md_run_setup(void)
 	if (raid_noautodetect)
 		printk(KERN_INFO "md: Skipping autodetection of RAID arrays. (raid=noautodetect)\n");
 	else {
-		int fd = open("/dev/md0", 0, 0);
+		int fd = sys_open("/dev/md0", 0, 0);
 		if (fd >= 0) {
 			sys_ioctl(fd, RAID_AUTORUN, 0);
-			close(fd);
+			sys_close(fd);
 		}
 	}
 	md_setup_drive();
Index: init/do_mounts_rd.c
===================================================================
RCS file: /var/cvs/linux-2.6/init/do_mounts_rd.c,v
retrieving revision 1.2
diff -u -p -r1.2 do_mounts_rd.c
--- init/do_mounts_rd.c	29 Jul 2003 17:25:55 -0000	1.2
+++ init/do_mounts_rd.c	20 Sep 2003 15:03:13 -0000
@@ -65,8 +65,8 @@ identify_ramdisk_image(int fd, int start
 	/*
 	 * Read block 0 to test for gzipped kernel
 	 */
-	lseek(fd, start_block * BLOCK_SIZE, 0);
-	read(fd, buf, size);
+	sys_lseek(fd, start_block * BLOCK_SIZE, 0);
+	sys_read(fd, buf, size);
 
 	/*
 	 * If it matches the gzip magic numbers, return -1
@@ -92,8 +92,8 @@ identify_ramdisk_image(int fd, int start
 	/*
 	 * Read block 1 to test for minix and ext2 superblock
 	 */
-	lseek(fd, (start_block+1) * BLOCK_SIZE, 0);
-	read(fd, buf, size);
+	sys_lseek(fd, (start_block+1) * BLOCK_SIZE, 0);
+	sys_read(fd, buf, size);
 
 	/* Try minix */
 	if (minixsb->s_magic == MINIX_SUPER_MAGIC ||
@@ -119,7 +119,7 @@ identify_ramdisk_image(int fd, int start
 	       start_block);
 	
 done:
-	lseek(fd, start_block * BLOCK_SIZE, 0);
+	sys_lseek(fd, start_block * BLOCK_SIZE, 0);
 	kfree(buf);
 	return nblocks;
 }
@@ -136,11 +136,11 @@ int __init rd_load_image(char *from)
 	char rotator[4] = { '|' , '/' , '-' , '\\' };
 #endif
 
-	out_fd = open("/dev/ram", O_RDWR, 0);
+	out_fd = sys_open("/dev/ram", O_RDWR, 0);
 	if (out_fd < 0)
 		goto out;
 
-	in_fd = open(from, O_RDONLY, 0);
+	in_fd = sys_open(from, O_RDONLY, 0);
 	if (in_fd < 0)
 		goto noclose_input;
 
@@ -205,20 +205,20 @@ int __init rd_load_image(char *from)
 		if (i && (i % devblocks == 0)) {
 			printk("done disk #%d.\n", disk++);
 			rotate = 0;
-			if (close(in_fd)) {
+			if (sys_close(in_fd)) {
 				printk("Error closing the disk.\n");
 				goto noclose_input;
 			}
 			change_floppy("disk #%d", disk);
-			in_fd = open(from, O_RDONLY, 0);
+			in_fd = sys_open(from, O_RDONLY, 0);
 			if (in_fd < 0)  {
 				printk("Error opening disk.\n");
 				goto noclose_input;
 			}
 			printk("Loading disk #%d... ", disk);
 		}
-		read(in_fd, buf, BLOCK_SIZE);
-		write(out_fd, buf, BLOCK_SIZE);
+		sys_read(in_fd, buf, BLOCK_SIZE);
+		sys_write(out_fd, buf, BLOCK_SIZE);
 #if !defined(CONFIG_ARCH_S390) && !defined(CONFIG_PPC_ISERIES)
 		if (!(i % 16)) {
 			printk("%c\b", rotator[rotate & 0x3]);
@@ -231,9 +231,9 @@ int __init rd_load_image(char *from)
 successful_load:
 	res = 1;
 done:
-	close(in_fd);
+	sys_close(in_fd);
 noclose_input:
-	close(out_fd);
+	sys_close(out_fd);
 out:
 	kfree(buf);
 	sys_unlink("/dev/ram");
@@ -330,7 +330,7 @@ static int __init fill_inbuf(void)
 {
 	if (exit_code) return -1;
 	
-	insize = read(crd_infd, inbuf, INBUFSIZ);
+	insize = sys_read(crd_infd, inbuf, INBUFSIZ);
 	if (insize == 0) {
 		error("RAMDISK: ran out of compressed data\n");
 		return -1;
@@ -351,7 +351,7 @@ static void __init flush_window(void)
     unsigned n, written;
     uch *in, ch;
     
-    written = write(crd_outfd, window, outcnt);
+    written = sys_write(crd_outfd, window, outcnt);
     if (written != outcnt && unzip_error == 0) {
 	printk(KERN_ERR "RAMDISK: incomplete write (%d != %d) %ld\n",
 	       written, outcnt, bytes_out);
Index: init/initramfs.c
===================================================================
RCS file: /var/cvs/linux-2.6/init/initramfs.c,v
retrieving revision 1.1
diff -u -p -r1.1 initramfs.c
--- init/initramfs.c	29 Jul 2003 17:02:19 -0000	1.1
+++ init/initramfs.c	20 Sep 2003 00:26:58 -0000
@@ -1,10 +1,8 @@
-#define __KERNEL_SYSCALLS__
 #include <linux/init.h>
 #include <linux/fs.h>
 #include <linux/slab.h>
 #include <linux/types.h>
 #include <linux/fcntl.h>
-#include <linux/unistd.h>
 #include <linux/delay.h>
 #include <linux/string.h>
 
Index: init/main.c
===================================================================
RCS file: /var/cvs/linux-2.6/init/main.c,v
retrieving revision 1.3
diff -u -p -r1.3 main.c
--- init/main.c	8 Sep 2003 21:42:53 -0000	1.3
+++ init/main.c	21 Sep 2003 03:24:06 -0000
@@ -9,13 +9,10 @@
  *  Simplified starting of init:  Michael A. Griffith <grif@acm.org> 
  */
 
-#define __KERNEL_SYSCALLS__
-
 #include <linux/config.h>
 #include <linux/proc_fs.h>
 #include <linux/devfs_fs_kernel.h>
 #include <linux/kernel.h>
-#include <linux/unistd.h>
 #include <linux/string.h>
 #include <linux/ctype.h>
 #include <linux/delay.h>
@@ -37,6 +34,7 @@
 #include <linux/moduleparam.h>
 #include <linux/writeback.h>
 #include <linux/cpu.h>
+#include <linux/syscalls.h>
 
 #include <asm/io.h>
 #include <asm/bugs.h>
@@ -578,11 +576,11 @@ static int init(void * unused)
 	unlock_kernel();
 	system_running = 1;
 
-	if (open("/dev/console", O_RDWR, 0) < 0)
+	if (sys_open("/dev/console", O_RDWR, 0) < 0)
 		printk("Warning: unable to open an initial console.\n");
 
-	(void) dup(0);
-	(void) dup(0);
+	(void) sys_dup(0);
+	(void) sys_dup(0);
 	
 	/*
 	 * We try each of these until one succeeds.
@@ -592,10 +590,10 @@ static int init(void * unused)
 	 */
 
 	if (execute_command)
-		execve(execute_command,argv_init,envp_init);
-	execve("/sbin/init",argv_init,envp_init);
-	execve("/etc/init",argv_init,envp_init);
-	execve("/bin/init",argv_init,envp_init);
-	execve("/bin/sh",argv_sh,envp_init);
+		sys_execve(execute_command, argv_init, envp_init);
+	sys_execve("/sbin/init", argv_init, envp_init);
+	sys_execve("/etc/init" , argv_init, envp_init);
+	sys_execve("/bin/init" , argv_init, envp_init);
+	sys_execve("/bin/sh"   , argv_sh  , envp_init);
 	panic("No init found.  Try passing init= option to kernel.");
 }
Index: kernel/kmod.c
===================================================================
RCS file: /var/cvs/linux-2.6/kernel/kmod.c,v
retrieving revision 1.2
diff -u -p -r1.2 kmod.c
--- kernel/kmod.c	8 Sep 2003 21:42:53 -0000	1.2
+++ kernel/kmod.c	21 Sep 2003 03:24:41 -0000
@@ -18,12 +18,10 @@
 	call_usermodehelper wait flag, and remove exec_usermodehelper.
 	Rusty Russell <rusty@rustcorp.com.au>  Jan 2003
 */
-#define __KERNEL_SYSCALLS__
 
 #include <linux/config.h>
 #include <linux/module.h>
 #include <linux/sched.h>
-#include <linux/unistd.h>
 #include <linux/kmod.h>
 #include <linux/smp_lock.h>
 #include <linux/slab.h>
@@ -34,6 +32,7 @@
 #include <linux/security.h>
 #include <linux/mount.h>
 #include <linux/kernel.h>
+#include <linux/syscalls.h>
 #include <asm/uaccess.h>
 
 extern int max_threads, system_running;
@@ -169,7 +168,8 @@ static int ____call_usermodehelper(void 
 
 	retval = -EPERM;
 	if (current->fs->root)
-		retval = execve(sub_info->path, sub_info->argv,sub_info->envp);
+		retval = sys_execve(sub_info->path, sub_info->argv,
+				sub_info->envp);
 
 	/* Exec failed? */
 	sub_info->retval = retval;
Index: kernel/signal.c
===================================================================
RCS file: /var/cvs/linux-2.6/kernel/signal.c,v
retrieving revision 1.4
diff -u -p -r1.4 signal.c
--- kernel/signal.c	23 Aug 2003 02:47:26 -0000	1.4
+++ kernel/signal.c	20 Sep 2003 00:30:04 -0000
@@ -10,12 +10,9 @@
  *		to allow signals to be sent reliably.
  */
 
-#define __KERNEL_SYSCALLS__
-
 #include <linux/config.h>
 #include <linux/slab.h>
 #include <linux/module.h>
-#include <linux/unistd.h>
 #include <linux/smp_lock.h>
 #include <linux/init.h>
 #include <linux/sched.h>
Index: kernel/workqueue.c
===================================================================
RCS file: /var/cvs/linux-2.6/kernel/workqueue.c,v
retrieving revision 1.2
diff -u -p -r1.2 workqueue.c
--- kernel/workqueue.c	23 Aug 2003 02:47:26 -0000	1.2
+++ kernel/workqueue.c	20 Sep 2003 00:33:31 -0000
@@ -14,13 +14,10 @@
  *   Theodore Ts'o <tytso@mit.edu>
  */
 
-#define __KERNEL_SYSCALLS__
-
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/sched.h>
 #include <linux/init.h>
-#include <linux/unistd.h>
 #include <linux/signal.h>
 #include <linux/completion.h>
 #include <linux/workqueue.h>
@@ -202,7 +199,7 @@ static int worker_thread(void *__startup
 			run_workqueue(cwq);
 
 		if (signal_pending(current)) {
-			while (waitpid(-1, NULL, __WALL|WNOHANG) > 0)
+			while (sys_wait4(-1, NULL, __WALL|WNOHANG, NULL) > 0)
 				/* SIGCHLD - auto-reaping */ ;
 
 			/* zap all other signals */
Index: net/bluetooth/bnep/core.c
===================================================================
RCS file: /var/cvs/linux-2.6/net/bluetooth/bnep/core.c,v
retrieving revision 1.2
diff -u -p -r1.2 core.c
--- net/bluetooth/bnep/core.c	8 Sep 2003 21:42:55 -0000	1.2
+++ net/bluetooth/bnep/core.c	19 Sep 2003 23:24:51 -0000
@@ -29,8 +29,6 @@
  * $Id: core.c,v 1.20 2002/08/04 21:23:58 maxk Exp $
  */ 
 
-#define __KERNEL_SYSCALLS__
-
 #include <linux/config.h>
 #include <linux/module.h>
 
Index: net/bluetooth/rfcomm/core.c
===================================================================
RCS file: /var/cvs/linux-2.6/net/bluetooth/rfcomm/core.c,v
retrieving revision 1.2
diff -u -p -r1.2 core.c
--- net/bluetooth/rfcomm/core.c	8 Sep 2003 21:42:56 -0000	1.2
+++ net/bluetooth/rfcomm/core.c	19 Sep 2003 23:24:58 -0000
@@ -31,8 +31,6 @@
  * $Id: core.c,v 1.42 2002/10/01 23:26:25 maxk Exp $
  */
 
-#define __KERNEL_SYSCALLS__
-
 #include <linux/config.h>
 #include <linux/module.h>
 #include <linux/errno.h>
Index: net/core/netfilter.c
===================================================================
RCS file: /var/cvs/linux-2.6/net/core/netfilter.c,v
retrieving revision 1.4
diff -u -p -r1.4 netfilter.c
--- net/core/netfilter.c	8 Sep 2003 21:42:57 -0000	1.4
+++ net/core/netfilter.c	19 Sep 2003 23:25:03 -0000
@@ -27,9 +27,6 @@
 #include <net/route.h>
 #include <linux/ip.h>
 
-#define __KERNEL_SYSCALLS__
-#include <linux/unistd.h>
-
 /* In this code, we can be waiting indefinitely for userspace to
  * service a packet if a hook returns NF_QUEUE.  We could keep a count
  * of skbuffs queued for userspace, and not deregister a hook unless
Index: net/ipv4/ipvs/ip_vs_sync.c
===================================================================
RCS file: /var/cvs/linux-2.6/net/ipv4/ipvs/ip_vs_sync.c,v
retrieving revision 1.2
diff -u -p -r1.2 ip_vs_sync.c
--- net/ipv4/ipvs/ip_vs_sync.c	8 Sep 2003 21:42:58 -0000	1.2
+++ net/ipv4/ipvs/ip_vs_sync.c	20 Sep 2003 00:24:28 -0000
@@ -18,8 +18,6 @@
  *					messages filtering.
  */
 
-#define __KERNEL_SYSCALLS__             /*  for waitpid */
-
 #include <linux/config.h>
 #include <linux/module.h>
 #include <linux/kernel.h>
@@ -28,7 +26,6 @@
 #include <linux/net.h>
 #include <linux/sched.h>
 #include <linux/wait.h>
-#include <linux/unistd.h>
 #include <linux/completion.h>
 
 #include <linux/skbuff.h>
@@ -621,8 +618,6 @@ ip_vs_receive(struct socket *sock, char 
 }
 
 
-static int errno;
-
 static DECLARE_WAIT_QUEUE_HEAD(sync_wait);
 static pid_t sync_master_pid = 0;
 static pid_t sync_backup_pid = 0;
@@ -866,7 +861,7 @@ int start_sync_thread(int state, char *m
 	if ((pid = kernel_thread(fork_sync_thread, &startup, 0)) < 0)
 		IP_VS_BUG();
 
-	if ((waitpid_result = waitpid(pid, NULL, __WCLONE)) != pid) {
+	if ((waitpid_result = sys_wait4(pid, NULL, __WCLONE, NULL)) != pid) {
 		IP_VS_ERR("%s: waitpid(%d,...) failed, errno %d\n",
 			  __FUNCTION__, pid, -waitpid_result);
 	}
Index: net/sunrpc/sched.c
===================================================================
RCS file: /var/cvs/linux-2.6/net/sunrpc/sched.c,v
retrieving revision 1.1
diff -u -p -r1.1 sched.c
--- net/sunrpc/sched.c	29 Jul 2003 17:02:26 -0000	1.1
+++ net/sunrpc/sched.c	19 Sep 2003 23:22:25 -0000
@@ -11,12 +11,10 @@
 
 #include <linux/module.h>
 
-#define __KERNEL_SYSCALLS__
 #include <linux/sched.h>
 #include <linux/interrupt.h>
 #include <linux/slab.h>
 #include <linux/mempool.h>
-#include <linux/unistd.h>
 #include <linux/smp.h>
 #include <linux/smp_lock.h>
 #include <linux/spinlock.h>
Index: net/sunrpc/svc.c
===================================================================
RCS file: /var/cvs/linux-2.6/net/sunrpc/svc.c,v
retrieving revision 1.1
diff -u -p -r1.1 svc.c
--- net/sunrpc/svc.c	29 Jul 2003 17:02:26 -0000	1.1
+++ net/sunrpc/svc.c	19 Sep 2003 23:22:31 -0000
@@ -6,13 +6,11 @@
  * Copyright (C) 1995, 1996 Olaf Kirch <okir@monad.swb.de>
  */
 
-#define __KERNEL_SYSCALLS__
 #include <linux/linkage.h>
 #include <linux/sched.h>
 #include <linux/errno.h>
 #include <linux/net.h>
 #include <linux/in.h>
-#include <linux/unistd.h>
 #include <linux/mm.h>
 
 #include <linux/sunrpc/types.h>
Index: net/sunrpc/xprt.c
===================================================================
RCS file: /var/cvs/linux-2.6/net/sunrpc/xprt.c,v
retrieving revision 1.5
diff -u -p -r1.5 xprt.c
--- net/sunrpc/xprt.c	8 Sep 2003 21:43:03 -0000	1.5
+++ net/sunrpc/xprt.c	19 Sep 2003 23:22:39 -0000
@@ -43,8 +43,6 @@
  *   (C) 1999 Trond Myklebust <trond.myklebust@fys.uio.no>
  */
 
-#define __KERNEL_SYSCALLS__
-
 #include <linux/types.h>
 #include <linux/slab.h>
 #include <linux/capability.h>
@@ -56,7 +54,6 @@
 #include <linux/mm.h>
 #include <linux/udp.h>
 #include <linux/tcp.h>
-#include <linux/unistd.h>
 #include <linux/sunrpc/clnt.h>
 #include <linux/file.h>
 
Index: sound/isa/wavefront/wavefront_synth.c
===================================================================
RCS file: /var/cvs/linux-2.6/sound/isa/wavefront/wavefront_synth.c,v
retrieving revision 1.1
diff -u -p -r1.1 wavefront_synth.c
--- sound/isa/wavefront/wavefront_synth.c	29 Jul 2003 17:02:31 -0000	1.1
+++ sound/isa/wavefront/wavefront_synth.c	21 Sep 2003 04:02:38 -0000
@@ -25,6 +25,7 @@
 #include <linux/interrupt.h>
 #include <linux/init.h>
 #include <linux/delay.h>
+#include <linux/syscalls.h>
 #include <linux/time.h>
 #include <linux/wait.h>
 #include <sound/core.h>
@@ -1913,15 +1914,11 @@ wavefront_reset_to_cleanliness (snd_wave
 	return (1);
 }
 
-#define __KERNEL_SYSCALLS__
 #include <linux/fs.h>
 #include <linux/mm.h>
 #include <linux/slab.h>
-#include <linux/unistd.h>
 #include <asm/uaccess.h>
 
-static int errno;
-
 static int __init
 wavefront_download_firmware (snd_wavefront_t *dev, char *path)
 
@@ -1947,7 +1944,7 @@ wavefront_download_firmware (snd_wavefro
 	fs = get_fs();
 	set_fs (get_ds());
 
-	if ((fd = open (path, 0, 0)) < 0) {
+	if ((fd = sys_open (path, 0, 0)) < 0) {
 		snd_printk ("Unable to load \"%s\".\n",
 			path);
 		return 1;
@@ -1956,7 +1953,7 @@ wavefront_download_firmware (snd_wavefro
 	while (1) {
 		int x;
 
-		if ((x = read (fd, &section_length, sizeof (section_length))) !=
+		if ((x = sys_read (fd, &section_length, sizeof (section_length))) !=
 		    sizeof (section_length)) {
 			snd_printk ("firmware read error.\n");
 			goto failure;
@@ -1966,7 +1963,7 @@ wavefront_download_firmware (snd_wavefro
 			break;
 		}
 
-		if (read (fd, section, section_length) != section_length) {
+		if (sys_read (fd, section, section_length) != section_length) {
 			snd_printk ("firmware section "
 				"read error.\n");
 			goto failure;
@@ -2005,12 +2002,12 @@ wavefront_download_firmware (snd_wavefro
 
 	}
 
-	close (fd);
+	sys_close (fd);
 	set_fs (fs);
 	return 0;
 
  failure:
-	close (fd);
+	sys_close (fd);
 	set_fs (fs);
 	snd_printk ("firmware download failed!!!\n");
 	return 1;
Index: sound/oss/wavfront.c
===================================================================
RCS file: /var/cvs/linux-2.6/sound/oss/wavfront.c,v
retrieving revision 1.1
diff -u -p -r1.1 wavfront.c
--- sound/oss/wavfront.c	29 Jul 2003 17:02:31 -0000	1.1
+++ sound/oss/wavfront.c	20 Sep 2003 21:52:56 -0000
@@ -2489,12 +2489,10 @@ static int __init detect_wavefront (int 
 }
 
 #include "os.h"
-#define __KERNEL_SYSCALLS__
 #include <linux/fs.h>
 #include <linux/mm.h>
 #include <linux/slab.h>
 #include <linux/unistd.h>
-#include <asm/uaccess.h>
 
 static int errno; 
 
@@ -2523,7 +2521,7 @@ wavefront_download_firmware (char *path)
 	fs = get_fs();
 	set_fs (get_ds());
 
-	if ((fd = open (path, 0, 0)) < 0) {
+	if ((fd = sys_open (path, 0, 0)) < 0) {
 		printk (KERN_WARNING LOGNAME "Unable to load \"%s\".\n",
 			path);
 		return 1;
@@ -2532,7 +2530,7 @@ wavefront_download_firmware (char *path)
 	while (1) {
 		int x;
 
-		if ((x = read (fd, &section_length, sizeof (section_length))) !=
+		if ((x = sys_read (fd, &section_length, sizeof (section_length))) !=
 		    sizeof (section_length)) {
 			printk (KERN_ERR LOGNAME "firmware read error.\n");
 			goto failure;
@@ -2542,7 +2540,7 @@ wavefront_download_firmware (char *path)
 			break;
 		}
 
-		if (read (fd, section, section_length) != section_length) {
+		if (sys_read (fd, section, section_length) != section_length) {
 			printk (KERN_ERR LOGNAME "firmware section "
 				"read error.\n");
 			goto failure;
@@ -2581,12 +2579,12 @@ wavefront_download_firmware (char *path)
 
 	}
 
-	close (fd);
+	sys_close (fd);
 	set_fs (fs);
 	return 0;
 
  failure:
-	close (fd);
+	sys_close (fd);
 	set_fs (fs);
 	printk (KERN_ERR "\nWaveFront: firmware download failed!!!\n");
 	return 1;

-- 
"It's not Hollywood.  War is real, war is primarily not about defeat or
victory, it is about death.  I've seen thousands and thousands of dead bodies.
Do you think I want to have an academic debate on this subject?" -- Robert Fisk
