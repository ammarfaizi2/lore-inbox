Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266512AbUBLQbn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Feb 2004 11:31:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266513AbUBLQbm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Feb 2004 11:31:42 -0500
Received: from delerium.kernelslacker.org ([81.187.208.145]:36269 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S266512AbUBLQb1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Feb 2004 11:31:27 -0500
Date: Thu, 12 Feb 2004 16:28:57 +0000
From: Dave Jones <davej@redhat.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH] bogus __KERNEL_SYSCALLS__ usage
Message-ID: <20040212162856.GU12634@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just did a mini-audit of users of __KERNEL_SYSCALLS and turned
up a bunch of uglies. The patch below is the easy ones
(nothing to fix, they were defining it and including unistd.h for no reason).
The remainders will need more work.

	arch/ppc/platforms/chrp_smp.c:#define __KERNEL_SYSCALLS__
	arch/ppc/platforms/pmac_smp.c:#define __KERNEL_SYSCALLS__
	arch/ppc/kernel/smp.c:#define __KERNEL_SYSCALLS__
	arch/ppc/kernel/ppc_ksyms.c:#define __KERNEL_SYSCALLS__
	arch/cris/kernel/process.c:#define __KERNEL_SYSCALLS__
	arch/ia64/kernel/smp.c:#define __KERNEL_SYSCALLS__
	arch/ia64/kernel/smpboot.c:#define __KERNEL_SYSCALLS__
	arch/ia64/kernel/process.c:#define __KERNEL_SYSCALLS__  /* see <asm/unistd.h> */
	arch/alpha/kernel/smp.c:#define __KERNEL_SYSCALLS__
	arch/alpha/kernel/alpha_ksyms.c:#define __KERNEL_SYSCALLS__
	arch/ppc64/kernel/pmac_smp.c:#define __KERNEL_SYSCALLS__
	arch/sparc/kernel/smp.c:#define __KERNEL_SYSCALLS__
	arch/sparc/kernel/sun4m_smp.c:#define __KERNEL_SYSCALLS__
	arch/sparc/kernel/process.c:#define __KERNEL_SYSCALLS__
	arch/sparc/kernel/sun4d_smp.c:#define __KERNEL_SYSCALLS__
	arch/sparc64/kernel/smp.c:#define __KERNEL_SYSCALLS__
	arch/sparc64/kernel/process.c:#define __KERNEL_SYSCALLS__
	arch/sparc64/kernel/power.c:#define __KERNEL_SYSCALLS__
	arch/parisc/kernel/smp.c:#define __KERNEL_SYSCALLS__
	arch/parisc/kernel/process.c:#define __KERNEL_SYSCALLS__
	arch/x86_64/kernel/process.c:#define __KERNEL_SYSCALLS__

These can probably all go, but I don't have all the archs/toolchains
to testbuild them.

	drivers/sbus/char/bbc_envctrl.c:#define __KERNEL_SYSCALLS__
	drivers/sbus/char/envctrl.c:#define __KERNEL_SYSCALLS__

Ditto. Probably a hangover from when kernel_thread was in unistd.h on some archs.

	drivers/scsi/cpqfcTSinit.c:#define __KERNEL_SYSCALLS__
Can probably go. wrapped in an ifdef __alpha__. Probably the
same reason as previous.  Alpha folks?

	drivers/scsi/oktagon_esp.c:#define __KERNEL_SYSCALLS__
m68k

	drivers/media/dvb/frontends/tda1004x.c:#define __KERNEL_SYSCALLS__
	drivers/media/dvb/frontends/sp887x.c:#define __KERNEL_SYSCALLS__
	drivers/media/dvb/frontends/alps_tdlb7.c:#define __KERNEL_SYSCALLS__

Joy joy. Implementing their own firmware loaders by directly
reading files into kernel space. Icky.

	drivers/macintosh/mediabay.c:#define __KERNEL_SYSCALLS__
ppc. can probably go.

	init/do_mounts.h:#define __KERNEL_SYSCALLS__
	init/do_mounts.h~:#define __KERNEL_SYSCALLS__
	init/main.c:#define __KERNEL_SYSCALLS__
	init/initramfs.c:#define __KERNEL_SYSCALLS__
	kernel/kmod.c:#define __KERNEL_SYSCALLS__

various magick. I'll leave these alone.

	net/ipv4/ipvs/ip_vs_sync.c:#define __KERNEL_SYSCALLS__             /*  for waitpid */

Icky. I've already pinging maintainers about this, as this one is
totally broken on amd64 (whose waitpid calls sys_wait4 -- oops).

	sound/isa/wavefront/wavefront_synth.c:#define __KERNEL_SYSCALLS__
	sound/oss/wavfront.c:#define __KERNEL_SYSCALLS__

Firmware loaders again.

Patch below fixes up the 'easy' cases. In case I've broken something on non-x86
arch, this should probably go for a spin in -mm before mainline.

		Dave


--- linux-2.6.2/drivers/md/md.c~	2004-02-12 15:59:59.000000000 +0000
+++ linux-2.6.2/drivers/md/md.c	2004-02-12 16:00:18.000000000 +0000
@@ -45,9 +45,6 @@
 #include <linux/kmod.h>
 #endif
 
-#define __KERNEL_SYSCALLS__
-#include <linux/unistd.h>
-
 #include <asm/unaligned.h>
 
 #define MAJOR_NR MD_MAJOR
--- linux-2.6.2/drivers/net/hamradio/baycom_epp.c~	2004-02-12 16:00:35.000000000 +0000
+++ linux-2.6.2/drivers/net/hamradio/baycom_epp.c	2004-02-12 16:01:01.000000000 +0000
@@ -59,9 +59,6 @@
 #include <net/ax25.h> 
 #endif /* CONFIG_AX25 || CONFIG_AX25_MODULE */
 
-#define __KERNEL_SYSCALLS__
-#include <linux/unistd.h>
-
 /* --------------------------------------------------------------------- */
 
 #define BAYCOM_DEBUG
--- linux-2.6.2/drivers/char/h8.c~	2004-02-12 16:01:08.000000000 +0000
+++ linux-2.6.2/drivers/char/h8.c	2004-02-12 16:01:32.000000000 +0000
@@ -30,9 +30,6 @@
 #include <linux/init.h>
 #include <linux/slab.h>
 
-#define __KERNEL_SYSCALLS__
-#include <asm/unistd.h>
-
 #include "h8.h"
 
 #define DEBUG_H8
--- linux-2.6.2/drivers/scsi/qla2xxx/qla_os.h~	2004-02-12 16:02:48.000000000 +0000
+++ linux-2.6.2/drivers/scsi/qla2xxx/qla_os.h	2004-02-12 16:03:35.000000000 +0000
@@ -41,8 +41,6 @@
 #include <linux/slab.h>
 #include <linux/mempool.h>
 #include <linux/vmalloc.h>
-#define __KERNEL_SYSCALLS__
-#include <linux/unistd.h>
 #include <linux/smp_lock.h>
 #include <linux/bio.h>
 #include <linux/moduleparam.h>
--- linux-2.6.2/drivers/scsi/cpqfcTSworker.c~	2004-02-12 16:04:14.000000000 +0000
+++ linux-2.6.2/drivers/scsi/cpqfcTSworker.c	2004-02-12 16:04:40.000000000 +0000
@@ -32,12 +32,8 @@
 #include <linux/smp_lock.h>
 #include <linux/pci.h>
 
-#define __KERNEL_SYSCALLS__
-
 #define SHUTDOWN_SIGS	(sigmask(SIGKILL)|sigmask(SIGINT)|sigmask(SIGTERM))
 
-#include <linux/unistd.h>
-
 #include <asm/system.h>
 #include <asm/irq.h>
 #include <asm/dma.h>
--- linux-2.6.2/net/core/netfilter.c~	2004-02-12 16:05:36.000000000 +0000
+++ linux-2.6.2/net/core/netfilter.c	2004-02-12 16:05:46.000000000 +0000
@@ -27,9 +27,6 @@
 #include <net/route.h>
 #include <linux/ip.h>
 
-#define __KERNEL_SYSCALLS__
-#include <linux/unistd.h>
-
 /* In this code, we can be waiting indefinitely for userspace to
  * service a packet if a hook returns NF_QUEUE.  We could keep a count
  * of skbuffs queued for userspace, and not deregister a hook unless
--- linux-2.6.2/net/sunrpc/svc.c~	2004-02-12 16:05:56.000000000 +0000
+++ linux-2.6.2/net/sunrpc/svc.c	2004-02-12 16:06:10.000000000 +0000
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
--- linux-2.6.2/net/sunrpc/sched.c~	2004-02-12 16:06:16.000000000 +0000
+++ linux-2.6.2/net/sunrpc/sched.c	2004-02-12 16:06:28.000000000 +0000
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
--- linux-2.6.2/net/sunrpc/xprt.c~	2004-02-12 16:06:39.000000000 +0000
+++ linux-2.6.2/net/sunrpc/xprt.c	2004-02-12 16:06:44.000000000 +0000
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
 #include <linux/workqueue.h>
--- linux-2.6.2/net/bluetooth/bnep/core.c~	2004-02-12 16:06:59.000000000 +0000
+++ linux-2.6.2/net/bluetooth/bnep/core.c	2004-02-12 16:07:13.000000000 +0000
@@ -29,8 +29,6 @@
  * $Id: core.c,v 1.20 2002/08/04 21:23:58 maxk Exp $
  */ 
 
-#define __KERNEL_SYSCALLS__
-
 #include <linux/config.h>
 #include <linux/module.h>
 
--- linux-2.6.2/net/bluetooth/rfcomm/core.c~	2004-02-12 16:07:24.000000000 +0000
+++ linux-2.6.2/net/bluetooth/rfcomm/core.c	2004-02-12 16:07:28.000000000 +0000
@@ -31,8 +31,6 @@
  * $Id: core.c,v 1.42 2002/10/01 23:26:25 maxk Exp $
  */
 
-#define __KERNEL_SYSCALLS__
-
 #include <linux/config.h>
 #include <linux/module.h>
 #include <linux/errno.h>
--- linux-2.6.2/arch/i386/kernel/process.c~	2004-02-12 16:09:12.000000000 +0000
+++ linux-2.6.2/arch/i386/kernel/process.c	2004-02-12 16:09:48.000000000 +0000
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
--- linux-2.6.2/fs/jffs/inode-v23.c~	2004-02-12 16:10:17.000000000 +0000
+++ linux-2.6.2/fs/jffs/inode-v23.c	2004-02-12 16:11:20.000000000 +0000
@@ -26,14 +26,7 @@
  * maybe other stuff do to.
  */
 
-/* Argh. Some architectures have kernel_thread in asm/processor.h
-   Some have it in unistd.h and you need to define __KERNEL_SYSCALLS__
-   Pass me a baseball bat and the person responsible.
-   dwmw2
-*/
-#define __KERNEL_SYSCALLS__
 #include <linux/time.h>
-#include <linux/unistd.h>
 
 #include <linux/module.h>
 #include <linux/init.h>
--- linux-2.6.2/fs/jffs2/background.c~	2004-02-12 16:11:42.000000000 +0000
+++ linux-2.6.2/fs/jffs2/background.c	2004-02-12 16:12:06.000000000 +0000
@@ -11,14 +11,10 @@
  *
  */
 
-#define __KERNEL_SYSCALLS__
-
 #include <linux/kernel.h>
 #include <linux/jffs2.h>
 #include <linux/mtd/mtd.h>
 #include <linux/completion.h>
-#include <linux/sched.h>
-#include <linux/unistd.h>
 #include <linux/suspend.h>
 #include "nodelist.h"
 
--- linux-2.6.2/fs/lockd/svc.c~	2004-02-12 16:12:16.000000000 +0000
+++ linux-2.6.2/fs/lockd/svc.c	2004-02-12 16:12:36.000000000 +0000
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
--- linux-2.6.2/fs/lockd/clntlock.c~	2004-02-12 16:12:40.000000000 +0000
+++ linux-2.6.2/fs/lockd/clntlock.c	2004-02-12 16:12:53.000000000 +0000
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
--- linux-2.6.2/kernel/signal.c~	2004-02-12 16:14:57.000000000 +0000
+++ linux-2.6.2/kernel/signal.c	2004-02-12 16:15:11.000000000 +0000
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
--- linux-2.6.2/drivers/media/dvb/dvb-core/dvb_ringbuffer.c~	2004-02-12 16:25:00.000000000 +0000
+++ linux-2.6.2/drivers/media/dvb/dvb-core/dvb_ringbuffer.c	2004-02-12 16:25:05.000000000 +0000
@@ -24,8 +24,6 @@
  */
 
 
-
-#define __KERNEL_SYSCALLS__
 #include <linux/errno.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
