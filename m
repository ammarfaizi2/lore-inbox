Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312938AbSERM2u>; Sat, 18 May 2002 08:28:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312973AbSERM2t>; Sat, 18 May 2002 08:28:49 -0400
Received: from gans.physik3.uni-rostock.de ([139.30.44.2]:8196 "EHLO
	gans.physik3.uni-rostock.de") by vger.kernel.org with ESMTP
	id <S312938AbSERM2p>; Sat, 18 May 2002 08:28:45 -0400
Date: Sat, 18 May 2002 14:28:27 +0200 (CEST)
From: Tim Schmielau <tim@physik3.uni-rostock.de>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Dave Jones <davej@suse.de>, lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] move jiffies from sched.h to it's own jiffies.h
In-Reply-To: <20020518033358.A15417@suse.de>
Message-ID: <Pine.LNX.4.33.0205181407370.21904-100000@gans.physik3.uni-rostock.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 18 May 2002, Dave Jones wrote:

> The 'dump everything into sched.h and friends' things really
> needs splitting up some more, but it's a lot of work, and I don't
> think kbuild2.5 alone is going to make that much difference
> in this regard. Pulling out the component parts of the bigger
> includes is probably the only way around this.
> 
> A driver that needs 'jiffies' defined should not be
> inadvertantly pulling in a hundred include files.

Yep.
As a start I made a patch that moves 'jiffies' from sched.h to their
own header.
That allowed me to pull the sched.h dependency from 40 files that
included sched.h for no apparent reason other than the jiffies 
declaration (though I might have missed obscure dependencies for 
drivers/architectures I didn't compile).

I also moved the time_[before,after}{_eq}() macros from timer.h to 
jiffies.h, since there are *no* files using them that don't also use 
jiffies.

That still leaves ~453 files that use jiffies but don't include sched.h 
directly, which obviously calls for further cleanups. Maybe it's worth
to make this dependence explicit by including jiffies.h directly?

Tim


--- linux-2.5.16/include/linux/sched.h	Sat May 18 13:45:31 2002
+++ linux-2.5.16-jc/include/linux/sched.h	Sat May 18 13:34:27 2002
@@ -13,6 +13,7 @@
 #include <linux/types.h>
 #include <linux/times.h>
 #include <linux/timex.h>
+#include <linux/jiffies.h>
 #include <linux/rbtree.h>
 #include <linux/thread_info.h>
 
@@ -476,12 +477,6 @@
 
 #include <asm/current.h>
 
-/*
- * The 64-bit value is not volatile - you MUST NOT read it
- * without holding read_lock_irq(&xtime_lock)
- */
-extern u64 jiffies_64;
-extern unsigned long volatile jiffies;
 extern unsigned long itimer_ticks;
 extern unsigned long itimer_next;
 extern void do_timer(struct pt_regs *);

--- linux-2.5.16/include/linux/timer.h	Fri May 10 00:22:36 2002
+++ linux-2.5.16-jc/include/linux/timer.h	Sat May 18 13:32:46 2002
@@ -52,23 +52,4 @@
 	return timer->list.next != NULL;
 }
 
-/*
- *	These inlines deal with timer wrapping correctly. You are 
- *	strongly encouraged to use them
- *	1. Because people otherwise forget
- *	2. Because if the timer wrap changes in future you wont have to
- *	   alter your driver code.
- *
- * time_after(a,b) returns true if the time a is after time b.
- *
- * Do this with "<0" and ">=0" to only test the sign of the result. A
- * good compiler would generate better code (and a really good compiler
- * wouldn't care). Gcc is currently neither.
- */
-#define time_after(a,b)		((long)(b) - (long)(a) < 0)
-#define time_before(a,b)	time_after(b,a)
-
-#define time_after_eq(a,b)	((long)(a) - (long)(b) >= 0)
-#define time_before_eq(a,b)	time_after_eq(b,a)
-
 #endif

--- linux-2.5.16/include/linux/jiffies.h	Sun Nov 26 21:14:43 2000
+++ linux-2.5.16-jc/include/linux/jiffies.h	Sat May 18 11:40:43 2002
@@ -0,0 +1,30 @@
+#ifndef _LINUX_JIFFIES_H
+#define _LINUX_JIFFIES_H
+
+/*
+ * The 64-bit value is not volatile - you MUST NOT read it
+ * without holding read_lock_irq(&xtime_lock)
+ */
+extern u64 jiffies_64;
+extern unsigned long volatile jiffies;
+
+/*
+ *	These inlines deal with timer wrapping correctly. You are 
+ *	strongly encouraged to use them
+ *	1. Because people otherwise forget
+ *	2. Because if the timer wrap changes in future you wont have to
+ *	   alter your driver code.
+ *
+ * time_after(a,b) returns true if the time a is after time b.
+ *
+ * Do this with "<0" and ">=0" to only test the sign of the result. A
+ * good compiler would generate better code (and a really good compiler
+ * wouldn't care). Gcc is currently neither.
+ */
+#define time_after(a,b)		((long)(b) - (long)(a) < 0)
+#define time_before(a,b)	time_after(b,a)
+
+#define time_after_eq(a,b)	((long)(a) - (long)(b) >= 0)
+#define time_before_eq(a,b)	time_after_eq(b,a)
+
+#endif

--- linux-2.5.16/include/net/inetpeer.h	Fri May 10 00:21:48 2002
+++ linux-2.5.16-jc/include/net/inetpeer.h	Sat May 18 13:03:01 2002
@@ -11,7 +11,7 @@
 
 #include <linux/types.h>
 #include <linux/init.h>
-#include <linux/sched.h>
+#include <linux/jiffies.h>
 #include <linux/spinlock.h>
 #include <asm/atomic.h>
 

--- linux-2.5.16/Documentation/DocBook/procfs_example.c	Fri May 10 00:24:46 2002
+++ linux-2.5.16-jc/Documentation/DocBook/procfs_example.c	Sat May 18 12:56:19 2002
@@ -47,7 +47,7 @@
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/proc_fs.h>
-#include <linux/sched.h>
+#include <linux/jiffies.h>
 #include <asm/uaccess.h>
 
 

--- linux-2.5.16/arch/i386/kernel/bluesmoke.c	Fri May 10 00:23:28 2002
+++ linux-2.5.16-jc/arch/i386/kernel/bluesmoke.c	Sat May 18 12:56:19 2002
@@ -5,7 +5,7 @@
 #include <linux/init.h>
 #include <linux/types.h>
 #include <linux/kernel.h>
-#include <linux/sched.h>
+#include <linux/jiffies.h>
 #include <linux/smp.h>
 #include <linux/config.h>
 #include <linux/irq.h>

--- linux-2.5.16/arch/ia64/kernel/irq_ia64.c	Fri May 10 00:23:59 2002
+++ linux-2.5.16-jc/arch/ia64/kernel/irq_ia64.c	Sat May 18 12:56:19 2002
@@ -14,7 +14,7 @@
 
 #include <linux/config.h>
 
-#include <linux/sched.h>
+#include <linux/jiffies.h>
 #include <linux/errno.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>

--- linux-2.5.16/arch/m68k/amiga/amisound.c	Fri May 10 00:25:43 2002
+++ linux-2.5.16-jc/arch/m68k/amiga/amisound.c	Sat May 18 12:56:19 2002
@@ -9,7 +9,7 @@
  */
 
 #include <linux/config.h>
-#include <linux/sched.h>
+#include <linux/jiffies.h>
 #include <linux/timer.h>
 #include <linux/init.h>
 

--- linux-2.5.16/arch/m68k/amiga/pcmcia.c	Fri May 10 00:22:38 2002
+++ linux-2.5.16-jc/arch/m68k/amiga/pcmcia.c	Sat May 18 12:56:19 2002
@@ -13,7 +13,7 @@
 */
 
 #include <linux/types.h>
-#include <linux/sched.h>
+#include <linux/jiffies.h>
 #include <linux/timer.h>
 #include <asm/amigayle.h>
 #include <asm/amipcmcia.h>

--- linux-2.5.16/arch/mips/jazz/reset.c	Fri May 10 00:23:31 2002
+++ linux-2.5.16-jc/arch/mips/jazz/reset.c	Sat May 18 12:56:19 2002
@@ -6,7 +6,7 @@
  *  $Id:$
  */
 
-#include <linux/sched.h>
+#include <linux/jiffies.h>
 #include <asm/jazz.h>
 #include <asm/io.h>
 #include <asm/system.h>

--- linux-2.5.16/arch/sparc64/kernel/central.c	Fri May 10 00:25:38 2002
+++ linux-2.5.16-jc/arch/sparc64/kernel/central.c	Sat May 18 12:56:19 2002
@@ -8,7 +8,7 @@
 #include <linux/types.h>
 #include <linux/string.h>
 #include <linux/timer.h>
-#include <linux/sched.h>
+#include <linux/jiffies.h>
 #include <linux/delay.h>
 #include <linux/init.h>
 #include <linux/bootmem.h>

--- linux-2.5.16/arch/x86_64/kernel/bluesmoke.c	Fri May 10 00:25:31 2002
+++ linux-2.5.16-jc/arch/x86_64/kernel/bluesmoke.c	Sat May 18 12:56:19 2002
@@ -5,7 +5,7 @@
 #include <linux/init.h>
 #include <linux/types.h>
 #include <linux/kernel.h>
-#include <linux/sched.h>
+#include <linux/jiffies.h>
 #include <linux/smp.h>
 #include <linux/config.h>
 #include <linux/irq.h>

--- linux-2.5.16/drivers/atm/suni.c	Fri May 10 00:22:56 2002
+++ linux-2.5.16-jc/drivers/atm/suni.c	Sat May 18 12:56:19 2002
@@ -4,7 +4,7 @@
 
 
 #include <linux/module.h>
-#include <linux/sched.h>
+#include <linux/jiffies.h>
 #include <linux/kernel.h>
 #include <linux/mm.h>
 #include <linux/errno.h>

--- linux-2.5.16/drivers/char/agp/agpgart_be.c	Fri May 10 00:22:05 2002
+++ linux-2.5.16-jc/drivers/char/agp/agpgart_be.c	Sat May 18 12:56:19 2002
@@ -28,7 +28,7 @@
 #include <linux/module.h>
 #include <linux/types.h>
 #include <linux/kernel.h>
-#include <linux/sched.h>
+#include <linux/jiffies.h>
 #include <linux/mm.h>
 #include <linux/string.h>
 #include <linux/errno.h>

--- linux-2.5.16/drivers/char/ftape/lowlevel/ftape-calibr.c	Fri May 10 00:23:12 2002
+++ linux-2.5.16-jc/drivers/char/ftape/lowlevel/ftape-calibr.c	Sat May 18 12:56:19 2002
@@ -26,7 +26,7 @@
 
 #include <linux/config.h>
 #include <linux/errno.h>
-#include <linux/sched.h>
+#include <linux/jiffies.h>
 #include <asm/system.h>
 #include <asm/io.h>
 #if defined(__alpha__)

--- linux-2.5.16/drivers/net/atari_bionet.c	Fri May 10 00:21:42 2002
+++ linux-2.5.16-jc/drivers/net/atari_bionet.c	Sat May 18 12:56:19 2002
@@ -86,7 +86,7 @@
 
 #include <linux/errno.h>
 #include <linux/kernel.h>
-#include <linux/sched.h>
+#include <linux/jiffies.h>
 #include <linux/types.h>
 #include <linux/fcntl.h>
 #include <linux/interrupt.h>

--- linux-2.5.16/drivers/net/auto_irq.c	Fri May 10 00:21:27 2002
+++ linux-2.5.16-jc/drivers/net/auto_irq.c	Sat May 18 12:56:18 2002
@@ -31,7 +31,7 @@
 #endif
 
 #include <linux/module.h>
-#include <linux/sched.h>
+#include <linux/jiffies.h>
 #include <linux/delay.h>
 #include <asm/bitops.h>
 #include <asm/io.h>

--- linux-2.5.16/drivers/net/ethertap.c	Fri May 10 00:22:51 2002
+++ linux-2.5.16-jc/drivers/net/ethertap.c	Sat May 18 12:56:19 2002
@@ -15,7 +15,7 @@
 #include <linux/module.h>
 
 #include <linux/kernel.h>
-#include <linux/sched.h>
+#include <linux/jiffies.h>
 #include <linux/slab.h>
 #include <linux/string.h>
 #include <linux/errno.h>

--- linux-2.5.16/drivers/net/loopback.c	Fri May 10 00:22:06 2002
+++ linux-2.5.16-jc/drivers/net/loopback.c	Sat May 18 12:56:19 2002
@@ -29,7 +29,7 @@
  *		2 of the License, or (at your option) any later version.
  */
 #include <linux/kernel.h>
-#include <linux/sched.h>
+#include <linux/jiffies.h>
 #include <linux/interrupt.h>
 #include <linux/fs.h>
 #include <linux/types.h>

--- linux-2.5.16/drivers/net/wan/comx-proto-fr.c	Fri May 10 00:23:13 2002
+++ linux-2.5.16-jc/drivers/net/wan/comx-proto-fr.c	Sat May 18 12:56:18 2002
@@ -39,7 +39,7 @@
 #include <linux/module.h>
 #include <linux/version.h>
 #include <linux/types.h>
-#include <linux/sched.h>
+#include <linux/jiffies.h>
 #include <linux/netdevice.h>
 #include <linux/proc_fs.h>
 #include <linux/if_arp.h>

--- linux-2.5.16/drivers/net/wan/comx-proto-ppp.c	Fri May 10 00:25:56 2002
+++ linux-2.5.16-jc/drivers/net/wan/comx-proto-ppp.c	Sat May 18 12:56:19 2002
@@ -36,7 +36,7 @@
 #include <linux/module.h>
 #include <linux/version.h>
 #include <linux/types.h>
-#include <linux/sched.h>
+#include <linux/jiffies.h>
 #include <linux/netdevice.h>
 #include <linux/proc_fs.h>
 #include <linux/if_arp.h>

--- linux-2.5.16/drivers/net/wan/comx.c	Fri May 10 00:24:14 2002
+++ linux-2.5.16-jc/drivers/net/wan/comx.c	Sat May 18 12:56:18 2002
@@ -58,7 +58,7 @@
 #include <linux/version.h>
 
 #include <linux/types.h>
-#include <linux/sched.h>
+#include <linux/jiffies.h>
 #include <linux/netdevice.h>
 #include <linux/proc_fs.h>
 #include <asm/uaccess.h>

--- linux-2.5.16/drivers/net/wan/sdladrv.c	Fri May 10 00:22:51 2002
+++ linux-2.5.16-jc/drivers/net/wan/sdladrv.c	Sat May 18 12:56:18 2002
@@ -97,7 +97,7 @@
 #include <linux/errno.h>	/* return codes */
 #include <linux/string.h>	/* inline memset(), etc. */
 #include <linux/module.h>	/* support for loadable modules */
-#include <linux/sched.h>	/* for jiffies, HZ, etc. */
+#include <linux/jiffies.h>	/* for jiffies, HZ, etc. */
 #include <linux/sdladrv.h>	/* API definitions */
 #include <linux/sdlasfm.h>	/* SDLA firmware module definitions */
 #include <linux/sdlapci.h>	/* SDLA PCI hardware definitions */

--- linux-2.5.16/drivers/scsi/i60uscsi.c	Fri May 10 00:22:37 2002
+++ linux-2.5.16-jc/drivers/scsi/i60uscsi.c	Sat May 18 12:56:19 2002
@@ -69,7 +69,7 @@
  **************************************************************************/
 
 #include <linux/version.h>
-#include <linux/sched.h>
+#include <linux/jiffies.h>
 #include <asm/io.h>
 #include "i60uscsi.h"
 

--- linux-2.5.16/drivers/scsi/i91uscsi.c	Fri May 10 00:22:44 2002
+++ linux-2.5.16-jc/drivers/scsi/i91uscsi.c	Sat May 18 12:56:19 2002
@@ -88,7 +88,7 @@
 #include <linux/version.h>
 #endif
 
-#include <linux/sched.h>
+#include <linux/jiffies.h>
 #include <linux/delay.h>
 #include <linux/blk.h>
 #include <asm/io.h>

--- linux-2.5.16/drivers/usb/net/cdc-ether.c	Sat May 18 13:45:30 2002
+++ linux-2.5.16-jc/drivers/usb/net/cdc-ether.c	Sat May 18 12:56:19 2002
@@ -19,7 +19,7 @@
  */
 
 
-#include <linux/sched.h>
+#include <linux/jiffies.h>
 #include <linux/slab.h>
 #include <linux/init.h>
 #include <linux/delay.h>

--- linux-2.5.16/drivers/usb/storage/isd200.c	Sat May 18 13:45:30 2002
+++ linux-2.5.16-jc/drivers/usb/storage/isd200.c	Sat May 18 12:56:19 2002
@@ -49,7 +49,7 @@
 #include "scsiglue.h"
 #include "isd200.h"
 
-#include <linux/sched.h>
+#include <linux/jiffies.h>
 #include <linux/errno.h>
 #include <linux/slab.h>
 #include <linux/hdreg.h>

--- linux-2.5.16/fs/vfat/namei.c	Fri May 10 00:21:51 2002
+++ linux-2.5.16-jc/fs/vfat/namei.c	Sat May 18 12:56:19 2002
@@ -17,7 +17,7 @@
 
 #include <linux/module.h>
 
-#include <linux/sched.h>
+#include <linux/jiffies.h>
 #include <linux/msdos_fs.h>
 #include <linux/ctype.h>
 #include <linux/slab.h>
Only in linux-2.5.16-jc/include/linux: jiffies.h

--- linux-2.5.16/net/802/tr.c	Fri May 10 00:21:51 2002
+++ linux-2.5.16-jc/net/802/tr.c	Sat May 18 12:56:19 2002
@@ -20,7 +20,7 @@
 #include <linux/config.h>
 #include <linux/types.h>
 #include <linux/kernel.h>
-#include <linux/sched.h>
+#include <linux/jiffies.h>
 #include <linux/string.h>
 #include <linux/mm.h>
 #include <linux/socket.h>

--- linux-2.5.16/net/ax25/ax25_ds_timer.c	Fri May 10 00:25:35 2002
+++ linux-2.5.16-jc/net/ax25/ax25_ds_timer.c	Sat May 18 12:56:19 2002
@@ -20,7 +20,7 @@
 #include <linux/socket.h>
 #include <linux/in.h>
 #include <linux/kernel.h>
-#include <linux/sched.h>
+#include <linux/jiffies.h>
 #include <linux/timer.h>
 #include <linux/string.h>
 #include <linux/sockios.h>

--- linux-2.5.16/net/ax25/ax25_timer.c	Fri May 10 00:21:55 2002
+++ linux-2.5.16-jc/net/ax25/ax25_timer.c	Sat May 18 12:56:19 2002
@@ -31,7 +31,7 @@
 #include <linux/socket.h>
 #include <linux/in.h>
 #include <linux/kernel.h>
-#include <linux/sched.h>
+#include <linux/jiffies.h>
 #include <linux/timer.h>
 #include <linux/string.h>
 #include <linux/sockios.h>

--- linux-2.5.16/net/core/profile.c	Fri May 10 00:25:43 2002
+++ linux-2.5.16-jc/net/core/profile.c	Sat May 18 12:56:19 2002
@@ -1,7 +1,7 @@
 #include <linux/config.h>
 #include <linux/types.h>
 #include <linux/kernel.h>
-#include <linux/sched.h>
+#include <linux/jiffies.h>
 #include <linux/mm.h>
 #include <linux/interrupt.h>
 #include <linux/netdevice.h>

--- linux-2.5.16/net/core/utils.c	Fri May 10 00:21:27 2002
+++ linux-2.5.16-jc/net/core/utils.c	Sat May 18 12:56:19 2002
@@ -17,7 +17,7 @@
 #include <asm/system.h>
 #include <linux/types.h>
 #include <linux/kernel.h>
-#include <linux/sched.h>
+#include <linux/jiffies.h>
 #include <linux/string.h>
 #include <linux/mm.h>
 

--- linux-2.5.16/net/ipv4/icmp.c	Fri May 10 00:23:59 2002
+++ linux-2.5.16-jc/net/ipv4/icmp.c	Sat May 18 12:56:19 2002
@@ -65,7 +65,7 @@
 
 #include <linux/config.h>
 #include <linux/types.h>
-#include <linux/sched.h>
+#include <linux/jiffies.h>
 #include <linux/kernel.h>
 #include <linux/fcntl.h>
 #include <linux/socket.h>

--- linux-2.5.16/net/ipv4/ip_fragment.c	Fri May 10 00:23:11 2002
+++ linux-2.5.16-jc/net/ipv4/ip_fragment.c	Sat May 18 12:56:19 2002
@@ -24,7 +24,7 @@
 #include <linux/config.h>
 #include <linux/types.h>
 #include <linux/mm.h>
-#include <linux/sched.h>
+#include <linux/jiffies.h>
 #include <linux/skbuff.h>
 #include <linux/ip.h>
 #include <linux/icmp.h>

--- linux-2.5.16/net/ipv6/reassembly.c	Fri May 10 00:23:22 2002
+++ linux-2.5.16-jc/net/ipv6/reassembly.c	Sat May 18 12:56:19 2002
@@ -29,7 +29,7 @@
 #include <linux/string.h>
 #include <linux/socket.h>
 #include <linux/sockios.h>
-#include <linux/sched.h>
+#include <linux/jiffies.h>
 #include <linux/net.h>
 #include <linux/netdevice.h>
 #include <linux/in6.h>

--- linux-2.5.16/net/lapb/lapb_iface.c	Fri May 10 00:24:02 2002
+++ linux-2.5.16-jc/net/lapb/lapb_iface.c	Sat May 18 12:56:19 2002
@@ -21,7 +21,7 @@
 #include <linux/socket.h>
 #include <linux/in.h>
 #include <linux/kernel.h>
-#include <linux/sched.h>
+#include <linux/jiffies.h>
 #include <linux/timer.h>
 #include <linux/string.h>
 #include <linux/sockios.h>

--- linux-2.5.16/net/lapb/lapb_timer.c	Fri May 10 00:22:50 2002
+++ linux-2.5.16-jc/net/lapb/lapb_timer.c	Sat May 18 12:56:19 2002
@@ -19,7 +19,7 @@
 #include <linux/socket.h>
 #include <linux/in.h>
 #include <linux/kernel.h>
-#include <linux/sched.h>
+#include <linux/jiffies.h>
 #include <linux/timer.h>
 #include <linux/string.h>
 #include <linux/sockios.h>

--- linux-2.5.16/net/netrom/nr_timer.c	Fri May 10 00:22:43 2002
+++ linux-2.5.16-jc/net/netrom/nr_timer.c	Sat May 18 12:56:19 2002
@@ -20,7 +20,7 @@
 #include <linux/socket.h>
 #include <linux/in.h>
 #include <linux/kernel.h>
-#include <linux/sched.h>
+#include <linux/jiffies.h>
 #include <linux/timer.h>
 #include <linux/string.h>
 #include <linux/sockios.h>

--- linux-2.5.16/net/rose/rose_link.c	Fri May 10 00:21:39 2002
+++ linux-2.5.16-jc/net/rose/rose_link.c	Sat May 18 12:56:19 2002
@@ -19,7 +19,7 @@
 #include <linux/socket.h>
 #include <linux/in.h>
 #include <linux/kernel.h>
-#include <linux/sched.h>
+#include <linux/jiffies.h>
 #include <linux/timer.h>
 #include <linux/string.h>
 #include <linux/sockios.h>

--- linux-2.5.16/net/rose/rose_timer.c	Fri May 10 00:21:51 2002
+++ linux-2.5.16-jc/net/rose/rose_timer.c	Sat May 18 12:56:19 2002
@@ -20,7 +20,7 @@
 #include <linux/socket.h>
 #include <linux/in.h>
 #include <linux/kernel.h>
-#include <linux/sched.h>
+#include <linux/jiffies.h>
 #include <linux/timer.h>
 #include <linux/string.h>
 #include <linux/sockios.h>

--- linux-2.5.16/net/x25/x25_link.c	Fri May 10 00:21:46 2002
+++ linux-2.5.16-jc/net/x25/x25_link.c	Sat May 18 12:56:19 2002
@@ -25,7 +25,7 @@
 #include <linux/socket.h>
 #include <linux/in.h>
 #include <linux/kernel.h>
-#include <linux/sched.h>
+#include <linux/jiffies.h>
 #include <linux/timer.h>
 #include <linux/string.h>
 #include <linux/sockios.h>

--- linux-2.5.16/sound/drivers/dummy.c	Fri May 10 00:23:34 2002
+++ linux-2.5.16-jc/sound/drivers/dummy.c	Sat May 18 12:56:19 2002
@@ -20,7 +20,7 @@
 
 #include <sound/driver.h>
 #include <linux/init.h>
-#include <linux/sched.h>
+#include <linux/jiffies.h>
 #include <linux/slab.h>
 #include <linux/time.h>
 #include <linux/wait.h>

