Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266932AbSKOXV3>; Fri, 15 Nov 2002 18:21:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266933AbSKOXV3>; Fri, 15 Nov 2002 18:21:29 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:30726 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S266930AbSKOXVZ>;
	Fri, 15 Nov 2002 18:21:25 -0500
Date: Fri, 15 Nov 2002 23:28:18 +0000
From: Matthew Wilcox <willy@debian.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org,
       Janitors <kernel-janitor-discuss@lists.sourceforge.net>,
       Trivial Kernel Patches <trivial@rustcorp.com.au>
Subject: [PATCH] Move request_irq & free_irq from sched.h to interrupt.h
Message-ID: <20021115232818.O20070@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


It really makes no sense to have request_irq and free_irq in sched.h
Let's move them to interrupt.h instead.  Note that I also remove sched.h
from interrupt.h since it's not needed.

Fix up a few drivers... there are probably others that need to be fixed,
but it's obvious what needs to be done.

diff -urpNX dontdiff linux-2.5.47/arch/i386/kernel/vm86.c linux-2.5.47-wait/arch/i386/kernel/vm86.c
--- linux-2.5.47/arch/i386/kernel/vm86.c	2002-10-14 14:37:14.000000000 -0700
+++ linux-2.5.47-wait/arch/i386/kernel/vm86.c	2002-11-15 14:32:24.000000000 -0800
@@ -31,6 +31,7 @@
  */
 
 #include <linux/errno.h>
+#include <linux/interrupt.h>
 #include <linux/sched.h>
 #include <linux/kernel.h>
 #include <linux/signal.h>
diff -urpNX dontdiff linux-2.5.47/drivers/input/serio/i8042.c linux-2.5.47-wait/drivers/input/serio/i8042.c
--- linux-2.5.47/drivers/input/serio/i8042.c	2002-11-15 05:42:18.000000000 -0800
+++ linux-2.5.47-wait/drivers/input/serio/i8042.c	2002-11-15 14:34:57.000000000 -0800
@@ -10,16 +10,16 @@
  * the Free Software Foundation.
  */
 
-#include <asm/io.h>
-
 #include <linux/delay.h>
 #include <linux/module.h>
+#include <linux/interrupt.h>
 #include <linux/ioport.h>
 #include <linux/config.h>
 #include <linux/reboot.h>
 #include <linux/init.h>
 #include <linux/serio.h>
-#include <linux/sched.h>
+
+#include <asm/io.h>
 
 MODULE_AUTHOR("Vojtech Pavlik <vojtech@suse.cz>");
 MODULE_DESCRIPTION("i8042 keyboard and mouse controller driver");
diff -urpNX dontdiff linux-2.5.47/drivers/pcmcia/cs.c linux-2.5.47-wait/drivers/pcmcia/cs.c
--- linux-2.5.47/drivers/pcmcia/cs.c	2002-10-11 05:24:00.000000000 -0700
+++ linux-2.5.47-wait/drivers/pcmcia/cs.c	2002-11-15 14:39:01.000000000 -0800
@@ -40,7 +40,7 @@
 #include <linux/errno.h>
 #include <linux/slab.h>
 #include <linux/mm.h>
-#include <linux/sched.h>
+#include <linux/interrupt.h>
 #include <linux/timer.h>
 #include <linux/ioport.h>
 #include <linux/delay.h>
diff -urpNX dontdiff linux-2.5.47/drivers/pcmcia/rsrc_mgr.c linux-2.5.47-wait/drivers/pcmcia/rsrc_mgr.c
--- linux-2.5.47/drivers/pcmcia/rsrc_mgr.c	2002-11-15 05:42:00.000000000 -0800
+++ linux-2.5.47-wait/drivers/pcmcia/rsrc_mgr.c	2002-11-15 14:35:45.000000000 -0800
@@ -36,7 +36,7 @@
 #include <linux/config.h>
 #include <linux/module.h>
 #include <linux/init.h>
-#include <linux/sched.h>
+#include <linux/interrupt.h>
 #include <linux/kernel.h>
 #include <linux/errno.h>
 #include <linux/types.h>
diff -urpNX dontdiff linux-2.5.47/drivers/pnp/resource.c linux-2.5.47-wait/drivers/pnp/resource.c
--- linux-2.5.47/drivers/pnp/resource.c	2002-11-15 05:42:00.000000000 -0800
+++ linux-2.5.47-wait/drivers/pnp/resource.c	2002-11-15 14:39:46.000000000 -0800
@@ -9,6 +9,7 @@
 #include <linux/config.h>
 #include <linux/module.h>
 #include <linux/errno.h>
+#include <linux/interrupt.h>
 #include <linux/pci.h>
 #include <linux/kernel.h>
 #include <asm/io.h>
diff -urpNX dontdiff linux-2.5.47/drivers/scsi/aic7xxx/aic7xxx_osm.h linux-2.5.47-wait/drivers/scsi/aic7xxx/aic7xxx_osm.h
--- linux-2.5.47/drivers/scsi/aic7xxx/aic7xxx_osm.h	2002-08-01 14:16:20.000000000 -0700
+++ linux-2.5.47-wait/drivers/scsi/aic7xxx/aic7xxx_osm.h	2002-11-15 14:49:38.000000000 -0800
@@ -65,6 +65,7 @@
 #include <linux/blk.h>
 #include <linux/blkdev.h>
 #include <linux/delay.h>
+#include <linux/interrupt.h>
 #include <linux/ioport.h>
 #include <linux/slab.h>
 #include <linux/pci.h>
diff -urpNX dontdiff linux-2.5.47/drivers/scsi/hosts.c linux-2.5.47-wait/drivers/scsi/hosts.c
--- linux-2.5.47/drivers/scsi/hosts.c	2002-11-15 05:42:20.000000000 -0800
+++ linux-2.5.47-wait/drivers/scsi/hosts.c	2002-11-15 14:36:55.000000000 -0800
@@ -34,6 +34,7 @@
 #include <linux/mm.h>
 #include <linux/proc_fs.h>
 #include <linux/init.h>
+#include <linux/interrupt.h>
 #include <linux/list.h>
 #include <linux/smp_lock.h>
 
diff -urpNX dontdiff linux-2.5.47/drivers/scsi/qla1280.c linux-2.5.47-wait/drivers/scsi/qla1280.c
--- linux-2.5.47/drivers/scsi/qla1280.c	2002-11-15 05:42:02.000000000 -0800
+++ linux-2.5.47-wait/drivers/scsi/qla1280.c	2002-11-15 15:01:07.000000000 -0800
@@ -246,10 +246,10 @@
 #include <linux/string.h>
 #include <linux/errno.h>
 #include <linux/kernel.h>
+#include <linux/interrupt.h>
 #include <linux/ioport.h>
 #include <linux/delay.h>
 #include <linux/timer.h>
-#include <linux/sched.h>
 #include <linux/pci.h>
 #include <linux/proc_fs.h>
 #include <linux/blk.h>
diff -urpNX dontdiff linux-2.5.47/include/linux/interrupt.h linux-2.5.47-wait/include/linux/interrupt.h
--- linux-2.5.47/include/linux/interrupt.h	2002-10-01 06:13:25.000000000 -0700
+++ linux-2.5.47-wait/include/linux/interrupt.h	2002-11-15 14:41:37.000000000 -0800
@@ -3,15 +3,11 @@
 #define _LINUX_INTERRUPT_H
 
 #include <linux/config.h>
-#include <linux/sched.h>
-#include <linux/kernel.h>
-#include <linux/smp.h>
-#include <linux/cache.h>
 #include <linux/bitops.h>
-
 #include <asm/atomic.h>
-#include <asm/system.h>
+#include <asm/hardirq.h>
 #include <asm/ptrace.h>
+#include <asm/softirq.h>
 
 struct irqaction {
 	void (*handler)(int, void *, struct pt_regs *);
@@ -22,8 +18,10 @@ struct irqaction {
 	struct irqaction *next;
 };
 
-#include <asm/hardirq.h>
-#include <asm/softirq.h>
+extern int request_irq(unsigned int,
+		       void (*handler)(int, void *, struct pt_regs *),
+		       unsigned long, const char *, void *);
+extern void free_irq(unsigned int, void *);
 
 /*
  * Temporary defines for UP kernels, until all code gets fixed.
diff -urpNX dontdiff linux-2.5.47/include/linux/sched.h linux-2.5.47-wait/include/linux/sched.h
--- linux-2.5.47/include/linux/sched.h	2002-11-15 05:42:21.000000000 -0800
+++ linux-2.5.47-wait/include/linux/sched.h	2002-11-15 15:03:30.000000000 -0800
@@ -588,11 +567,6 @@ static inline int sas_ss_flags(unsigned 
 		: on_sig_stack(sp) ? SS_ONSTACK : 0);
 }
 
-extern int request_irq(unsigned int,
-		       void (*handler)(int, void *, struct pt_regs *),
-		       unsigned long, const char *, void *);
-extern void free_irq(unsigned int, void *);
-
 /* capable prototype and code moved to security.[hc] */
 #include <linux/security.h>
 #if 0
diff -urpNX dontdiff linux-2.5.47/sound/drivers/mpu401/mpu401_uart.c linux-2.5.47-wait/sound/drivers/mpu401/mpu401_uart.c
--- linux-2.5.47/sound/drivers/mpu401/mpu401_uart.c	2002-10-11 05:24:04.000000000 -0700
+++ linux-2.5.47-wait/sound/drivers/mpu401/mpu401_uart.c	2002-11-15 14:38:12.000000000 -0800
@@ -29,7 +29,7 @@
 #include <linux/init.h>
 #include <linux/slab.h>
 #include <linux/ioport.h>
-#include <linux/sched.h>
+#include <linux/interrupt.h>
 #include <linux/errno.h>
 #include <sound/core.h>
 #include <sound/mpu401.h>

-- 
Revolutions do not require corporate support.
