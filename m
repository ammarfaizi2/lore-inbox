Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271018AbRHXKU2>; Fri, 24 Aug 2001 06:20:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271019AbRHXKUI>; Fri, 24 Aug 2001 06:20:08 -0400
Received: from gnu.in-berlin.de ([192.109.42.4]:38925 "EHLO gnu.in-berlin.de")
	by vger.kernel.org with ESMTP id <S271018AbRHXKT7>;
	Fri, 24 Aug 2001 06:19:59 -0400
X-Envelope-From: kraxel@bytesex.org
Date: Fri, 24 Aug 2001 12:18:16 +0200
From: Gerd Knorr <kraxel@bytesex.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Gunther Mayer <Gunther.Mayer@t-online.de>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>, alan@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: yenta_socket hangs sager laptop in kernel 2.4.6-> PNPBIOS life saver
Message-ID: <20010824121816.A654@bytesex.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E15Zu68-0003nE-00@the-village.bc.nu>
User-Agent: Mutt/1.3.18i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 23, 2001 at 02:00:35PM +0100, Alan Cox wrote:
> We will see what happens. Certainly if someone wants to provide pnpbios code
> patches for -ac that grab and reserve the motherboard resources from the PCI
> code go ahead.

Here is.

  Gerd

---------------------- cut here -------------------------
--- 2.4.8-ac8/include/linux/pci.h.fix	Fri Aug 24 11:40:14 2001
+++ 2.4.8-ac8/include/linux/pci.h	Fri Aug 24 11:40:28 2001
@@ -317,7 +317,7 @@
 #define DEVICE_COUNT_COMPATIBLE	4
 #define DEVICE_COUNT_IRQ	2
 #define DEVICE_COUNT_DMA	2
-#define DEVICE_COUNT_RESOURCE	12
+#define DEVICE_COUNT_RESOURCE	16
 
 #define PCI_ANY_ID (~0)
 
--- 2.4.8-ac8/drivers/pnp/Makefile.fix	Thu Aug 23 10:08:57 2001
+++ 2.4.8-ac8/drivers/pnp/Makefile	Fri Aug 24 11:47:27 2001
@@ -17,7 +17,7 @@
 isa-pnp-objs := isapnp.o quirks.o $(proc-y)
 
 procpnp-$(CONFIG_PROC_FS) = pnp_proc.o
-pnpbios-objs := pnp_bios.o  $(procpnp-y)
+pnpbios-objs := pnp_bios.o mboard.o $(procpnp-y)
 
 obj-$(CONFIG_ISAPNP) += isa-pnp.o
 obj-$(CONFIG_PNPBIOS) += pnpbios.o
--- 2.4.8-ac8/drivers/pnp/pnp_bios.c.fix	Thu Aug 23 10:08:57 2001
+++ 2.4.8-ac8/drivers/pnp/pnp_bios.c	Fri Aug 24 11:39:21 2001
@@ -49,6 +49,7 @@
 
 void pnp_proc_init(void);
 static void pnpbios_build_devlist(void);
+int pnpbios_request_mboard(void);
 
 /*
  * This is the standard structure used to identify the entry point
@@ -605,6 +606,7 @@
 		break;
 	}
 	pnpbios_build_devlist();
+	pnpbios_request_mboard();
 #ifdef CONFIG_PROC_FS
 	pnp_proc_init();
 #endif
--- 2.4.8-ac8/drivers/pnp/mboard.c.fix	Fri Aug 24 11:39:50 2001
+++ 2.4.8-ac8/drivers/pnp/mboard.c	Fri Aug 24 11:38:38 2001
@@ -0,0 +1,73 @@
+/*
+ * request I/O ports which are used according to the PnP BIOS.
+ *
+ * (c) 2001 Gerd Knorr <kraxel@bytesex.org>
+ */
+#include <linux/config.h>
+#include <linux/module.h>
+#include <linux/init.h>
+
+#include <asm/io.h>
+#include <asm/dma.h>
+#include <asm/uaccess.h>
+
+#include <linux/pnp_bios.h>
+
+static int request_stuff(char *pnp, struct pci_dev *dev)
+{
+	struct resource *res;
+	int i,count = 0;
+
+	printk(KERN_INFO "%s: request ports [%s]:",dev->name,pnp);
+	for (i = 0; i < DEVICE_COUNT_RESOURCE &&
+		    (dev->resource[i].start || dev->resource[i].end); i++) {
+		if (dev->resource[i].start > 0xffff ||
+		    dev->resource[i].end   > 0xffff) {
+			/*
+			 * these are memory ressources -- ignore them.
+			 * The PnP BIOS reports the main memory layout
+			 * this way.
+			 */
+			continue;
+		}
+		if (dev->resource[i].end < 0x100) {
+			/*
+			 * below 0x100 is only standard PC hardware
+			 * (pics, kbd, timer, dma, ...)
+			 *
+			 * We should not get ressource conflicts there,
+			 * and the kernel reserves these anyway
+			 * (see arch/i386/kernel/setup.c).
+			 */
+			continue;
+		}
+		/*
+		 * anything else we'll reserve to avoid these ranges are
+		 * assigned to someone (CardBus bridges for example) and
+		 * thus are triggering resource conflicts.
+		 */
+		res = request_region(dev->resource[i].start,
+			dev->resource[i].end - dev->resource[i].start,
+			dev->name);
+		printk(" 0x%lx-0x%lx",
+			dev->resource[i].start, dev->resource[i].end);
+		count++;
+	} 
+	printk("\n");
+	if (i == DEVICE_COUNT_RESOURCE)
+		printk("%s: warning: >= %d resources, overflow?\n",
+			dev->name,DEVICE_COUNT_RESOURCE);
+	return count;
+}
+
+int pnpbios_request_mboard(void)
+{
+	struct pci_dev *dev = NULL;
+	int count = 0;
+
+	while ((dev=pnpbios_find_device("PNP0c01",dev)))
+		count += request_stuff("PNP0c01",dev);
+	while ((dev=pnpbios_find_device("PNP0c02",dev)))
+		count += request_stuff("PNP0c02",dev);
+	return count;
+}
