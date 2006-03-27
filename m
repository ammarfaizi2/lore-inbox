Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751428AbWC0TZm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751428AbWC0TZm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Mar 2006 14:25:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751436AbWC0TZm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Mar 2006 14:25:42 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.142]:13512 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751428AbWC0TZl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Mar 2006 14:25:41 -0500
From: Arnd Bergmann <arnd.bergmann@de.ibm.com>
Organization: IBM Deutschland Entwicklung GmbH
To: cbe-oss-dev@ozlabs.org
Subject: [updated patch 1/2] powerpc: hvc_console updates
Date: Mon, 27 Mar 2006 21:25:16 +0200
User-Agent: KMail/1.9.1
Cc: Paul Mackerras <paulus@samba.org>, Arnd Bergmann <abergman@de.ibm.com>,
       linuxppc-dev@ozlabs.org, "Ryan S. Arnold" <rsa@us.ibm.com>,
       linux-kernel@vger.kernel.org
References: <20060323203423.620978000@dyn-9-152-242-103.boeblingen.de.ibm.com> <20060323203520.909999000@dyn-9-152-242-103.boeblingen.de.ibm.com> <17447.25413.486950.115568@cargo.ozlabs.ibm.com>
In-Reply-To: <17447.25413.486950.115568@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603272125.16871.arnd.bergmann@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

These are some updates from both Ryan and Arnd for the hvc_console
driver:

The main point is to enable the inclusion of a console driver
for rtas, which is currrently needed for the cell platform.

Also shuffle around some data-type declarations and moves some
functions out of include/asm-ppc64/hvconsole.h and into a new
drivers/char/hvc_console.h file.

From: "Ryan S. Arnold" <rsa@us.ibm.com>
Signed-off-by: "Ryan S. Arnold" <rsa@us.ibm.com>
Signed-off-by: Arnd Bergmann <abergman@de.ibm.com>

Index: linus-2.6/drivers/char/hvc_console.c
===================================================================
--- linus-2.6.orig/drivers/char/hvc_console.c
+++ linus-2.6/drivers/char/hvc_console.c
@@ -39,8 +39,10 @@
 #include <linux/sched.h>
 #include <linux/spinlock.h>
 #include <linux/delay.h>
+
 #include <asm/uaccess.h>
-#include <asm/hvconsole.h>
+
+#include "hvc_console.h"
 
 #define HVC_MAJOR	229
 #define HVC_MINOR	0
@@ -54,17 +56,14 @@
 #define HVC_CLOSE_WAIT (HZ/100) /* 1/10 of a second */
 
 /*
- * The Linux TTY code does not support dynamic addition of tty derived devices
- * so we need to know how many tty devices we might need when space is allocated
- * for the tty device.  Since this driver supports hotplug of vty adapters we
- * need to make sure we have enough allocated.
+ * These sizes are most efficient for vio, because they are the
+ * native transfer size. We could make them selectable in the
+ * future to better deal with backends that want other buffer sizes.
  */
-#define HVC_ALLOC_TTY_ADAPTERS	8
-
 #define N_OUTBUF	16
 #define N_INBUF		16
 
-#define __ALIGNED__	__attribute__((__aligned__(8)))
+#define __ALIGNED__ __attribute__((__aligned__(sizeof(long))))
 
 static struct tty_driver *hvc_driver;
 static struct task_struct *hvc_task;
@@ -154,7 +153,7 @@ static uint32_t vtermnos[MAX_NR_HVC_CONS
 
 void hvc_console_print(struct console *co, const char *b, unsigned count)
 {
-	char c[16] __ALIGNED__;
+	char c[N_OUTBUF] __ALIGNED__;
 	unsigned i = 0, n = 0;
 	int r, donecr = 0, index = co->index;
 
@@ -473,8 +472,10 @@ static void hvc_push(struct hvc_struct *
 
 	n = hp->ops->put_chars(hp->vtermno, hp->outbuf, hp->n_outbuf);
 	if (n <= 0) {
-		if (n == 0)
+		if (n == 0) {
+			hp->do_wakeup = 1;
 			return;
+		}
 		/* throw away output on error; this happens when
 		   there is no session connected to the vterm. */
 		hp->n_outbuf = 0;
@@ -486,12 +487,19 @@ static void hvc_push(struct hvc_struct *
 		hp->do_wakeup = 1;
 }
 
-static inline int __hvc_write_kernel(struct hvc_struct *hp,
-				   const unsigned char *buf, int count)
+static int hvc_write(struct tty_struct *tty, const unsigned char *buf, int count)
 {
+	struct hvc_struct *hp = tty->driver_data;
 	unsigned long flags;
 	int rsize, written = 0;
 
+	/* This write was probably executed during a tty close. */
+	if (!hp)
+		return -EPIPE;
+
+	if (hp->count <= 0)
+		return -EIO;
+
 	spin_lock_irqsave(&hp->lock, flags);
 
 	/* Push pending writes */
@@ -510,26 +518,8 @@ static inline int __hvc_write_kernel(str
 	}
 	spin_unlock_irqrestore(&hp->lock, flags);
 
-	return written;
-}
-static int hvc_write(struct tty_struct *tty, const unsigned char *buf, int count)
-{
-	struct hvc_struct *hp = tty->driver_data;
-	int written;
-
-	/* This write was probably executed during a tty close. */
-	if (!hp)
-		return -EPIPE;
-
-	if (hp->count <= 0)
-		return -EIO;
-
-	written = __hvc_write_kernel(hp, buf, count);
-
 	/*
 	 * Racy, but harmless, kick thread if there is still pending data.
-	 * There really is nothing wrong with kicking the thread, even if there
-	 * is no buffered data.
 	 */
 	if (hp->n_outbuf)
 		hvc_kick();
@@ -614,6 +604,13 @@ static int hvc_poll(struct hvc_struct *h
 				spin_unlock_irqrestore(&hp->lock, flags);
 				tty_hangup(tty);
 				spin_lock_irqsave(&hp->lock, flags);
+			} else if ( n == -EAGAIN ) {
+				/*
+				 * Some back-ends can only ensure a certain min
+				 * num of bytes read, which may be > 'count'.
+				 * Let the tty clear the flip buff to make room.
+				 */
+				poll_mask |= HVC_POLL_READ;
 			}
 			break;
 		}
@@ -635,16 +632,7 @@ static int hvc_poll(struct hvc_struct *h
 			tty_insert_flip_char(tty, buf[i], 0);
 		}
 
-		/*
-		 * Account for the total amount read in one loop, and if above
-		 * 64 bytes, we do a quick schedule loop to let the tty grok
-		 * the data and eventually throttle us.
-		 */
 		read_total += n;
-		if (read_total >= 64) {
-			poll_mask |= HVC_POLL_QUICK;
-			break;
-		}
 	}
  throttled:
 	/* Wakeup write queue if necessary */
@@ -767,7 +755,8 @@ struct hvc_struct __devinit *hvc_alloc(u
 	 * see if this vterm id matches one registered for console.
 	 */
 	for (i=0; i < MAX_NR_HVC_CONSOLES; i++)
-		if (vtermnos[i] == hp->vtermno)
+		if (vtermnos[i] == hp->vtermno &&
+		    cons_ops[i] == hp->ops)
 			break;
 
 	/* no matching slot, just use a counter */
Index: linus-2.6/drivers/char/hvc_console.h
===================================================================
--- /dev/null
+++ linus-2.6/drivers/char/hvc_console.h
@@ -0,0 +1,63 @@
+/*
+ * hvc_console.h
+ * Copyright (C) 2005 IBM Corporation
+ *
+ * Author(s):
+ * 	Ryan S. Arnold <rsa@us.ibm.com>
+ *
+ * hvc_console header information:
+ *      moved here from include/asm-powerpc/hvconsole.h
+ *      and drivers/char/hvc_console.c
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
+ */
+
+#ifndef HVC_CONSOLE_H
+#define HVC_CONSOLE_H
+
+/*
+ * This is the max number of console adapters that can/will be found as
+ * console devices on first stage console init.  Any number beyond this range
+ * can't be used as a console device but is still a valid tty device.
+ */
+#define MAX_NR_HVC_CONSOLES	16
+
+/*
+ * The Linux TTY code does not support dynamic addition of tty derived devices
+ * so we need to know how many tty devices we might need when space is allocated
+ * for the tty device.  Since this driver supports hotplug of vty adapters we
+ * need to make sure we have enough allocated.
+ */
+#define HVC_ALLOC_TTY_ADAPTERS	8
+
+
+/* implemented by a low level driver */
+struct hv_ops {
+	int (*get_chars)(uint32_t vtermno, char *buf, int count);
+	int (*put_chars)(uint32_t vtermno, const char *buf, int count);
+};
+
+struct hvc_struct;
+
+/* Register a vterm and a slot index for use as a console (console_init) */
+extern int hvc_instantiate(uint32_t vtermno, int index, struct hv_ops *ops);
+
+/* register a vterm for hvc tty operation (module_init or hotplug add) */
+extern struct hvc_struct * __devinit hvc_alloc(uint32_t vtermno, int irq,
+						 struct hv_ops *ops);
+/* remove a vterm from hvc tty operation (modele_exit or hotplug remove) */
+extern int __devexit hvc_remove(struct hvc_struct *hp);
+
+#endif // HVC_CONSOLE_H
Index: linus-2.6/include/asm-powerpc/hvconsole.h
===================================================================
--- linus-2.6.orig/include/asm-powerpc/hvconsole.h
+++ linus-2.6/include/asm-powerpc/hvconsole.h
@@ -24,28 +24,18 @@
 #ifdef __KERNEL__
 
 /*
- * This is the max number of console adapters that can/will be found as
- * console devices on first stage console init.  Any number beyond this range
- * can't be used as a console device but is still a valid tty device.
+ * PSeries firmware will only send/recv up to 16 bytes of character data per
+ * hcall.
  */
-#define MAX_NR_HVC_CONSOLES	16
+#define MAX_VIO_PUT_CHARS	16
+#define SIZE_VIO_GET_CHARS	16
 
-/* implemented by a low level driver */
-struct hv_ops {
-	int (*get_chars)(uint32_t vtermno, char *buf, int count);
-	int (*put_chars)(uint32_t vtermno, const char *buf, int count);
-};
+/*
+ * Vio firmware always attempts to fetch MAX_VIO_GET_CHARS chars.  The 'count'
+ * parm is included to conform to put_chars() function pointer template
+ */
 extern int hvc_get_chars(uint32_t vtermno, char *buf, int count);
 extern int hvc_put_chars(uint32_t vtermno, const char *buf, int count);
 
-struct hvc_struct;
-
-/* Register a vterm and a slot index for use as a console (console_init) */
-extern int hvc_instantiate(uint32_t vtermno, int index, struct hv_ops *ops);
-/* register a vterm for hvc tty operation (module_init or hotplug add) */
-extern struct hvc_struct * __devinit hvc_alloc(uint32_t vtermno, int irq,
-						 struct hv_ops *ops);
-/* remove a vterm from hvc tty operation (modele_exit or hotplug remove) */
-extern int __devexit hvc_remove(struct hvc_struct *hp);
 #endif /* __KERNEL__ */
 #endif /* _PPC64_HVCONSOLE_H */
Index: linus-2.6/drivers/char/Kconfig
===================================================================
--- linus-2.6.orig/drivers/char/Kconfig
+++ linus-2.6/drivers/char/Kconfig
@@ -561,9 +561,19 @@ config TIPAR
 
 	  If unsure, say N.
 
+config HVC_DRIVER
+	bool
+	help
+	  Users of pSeries machines that want to utilize the hvc console front-end
+	  module for their backend console driver should select this option.
+	  It will automatically be selected if one of the back-end console drivers
+	  is selected.
+
+
 config HVC_CONSOLE
 	bool "pSeries Hypervisor Virtual Console support"
 	depends on PPC_PSERIES
+	select HVC_DRIVER
 	help
 	  pSeries machines when partitioned support a hypervisor virtual
 	  console. This driver allows each pSeries partition to have a console
Index: linus-2.6/drivers/char/Makefile
===================================================================
--- linus-2.6.orig/drivers/char/Makefile
+++ linus-2.6/drivers/char/Makefile
@@ -41,7 +41,8 @@ obj-$(CONFIG_N_HDLC)		+= n_hdlc.o
 obj-$(CONFIG_AMIGA_BUILTIN_SERIAL) += amiserial.o
 obj-$(CONFIG_SX)		+= sx.o generic_serial.o
 obj-$(CONFIG_RIO)		+= rio/ generic_serial.o
-obj-$(CONFIG_HVC_CONSOLE)	+= hvc_console.o hvc_vio.o hvsi.o
+obj-$(CONFIG_HVC_DRIVER)	+= hvc_console.o
+obj-$(CONFIG_HVC_CONSOLE)	+= hvc_vio.o hvsi.o
 obj-$(CONFIG_RAW_DRIVER)	+= raw.o
 obj-$(CONFIG_SGI_SNSC)		+= snsc.o snsc_event.o
 obj-$(CONFIG_MMTIMER)		+= mmtimer.o
Index: linus-2.6/drivers/char/hvc_vio.c
===================================================================
--- linus-2.6.orig/drivers/char/hvc_vio.c
+++ linus-2.6/drivers/char/hvc_vio.c
@@ -31,10 +31,13 @@
 
 #include <linux/types.h>
 #include <linux/init.h>
+
 #include <asm/hvconsole.h>
 #include <asm/vio.h>
 #include <asm/prom.h>
 
+#include "hvc_console.h"
+
 char hvc_driver_name[] = "hvc_console";
 
 static struct vio_device_id hvc_driver_table[] __devinitdata = {
@@ -48,6 +51,14 @@ static int filtered_get_chars(uint32_t v
 	unsigned long got;
 	int i;
 
+	/*
+	 * Vio firmware will read up to SIZE_VIO_GET_CHARS at its own discretion
+	 * so we play safe and avoid the situation where got > count which could
+	 * overload the flip buffer.
+	 */
+	if (count < SIZE_VIO_GET_CHARS)
+		return -EAGAIN;
+
 	got = hvc_get_chars(vtermno, buf, count);
 
 	/*
Index: linus-2.6/arch/powerpc/platforms/pseries/hvconsole.c
===================================================================
--- linus-2.6.orig/arch/powerpc/platforms/pseries/hvconsole.c
+++ linus-2.6/arch/powerpc/platforms/pseries/hvconsole.c
@@ -62,6 +62,11 @@ int hvc_put_chars(uint32_t vtermno, cons
 	unsigned long *lbuf = (unsigned long *) buf;
 	long ret;
 
+
+	/* hcall will ret H_PARAMETER if 'count' exceeds firmware max.*/
+	if (count > MAX_VIO_PUT_CHARS)
+		count = MAX_VIO_PUT_CHARS;
+
 	ret = plpar_hcall_norets(H_PUT_TERM_CHAR, vtermno, count, lbuf[0],
 				 lbuf[1]);
 	if (ret == H_Success)
