Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965039AbVHOXyO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965039AbVHOXyO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Aug 2005 19:54:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965037AbVHOXyO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Aug 2005 19:54:14 -0400
Received: from mx1.redhat.com ([66.187.233.31]:12189 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S965039AbVHOXyN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Aug 2005 19:54:13 -0400
Date: Mon, 15 Aug 2005 16:53:57 -0700
From: Pete Zaitcev <zaitcev@redhat.com>
To: greg@kroah.com
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net,
       zaitcev@redhat.com
Subject: usbmon in 2.6.13: peeking into DMA areas
Message-Id: <20050815165357.322892c0.zaitcev@redhat.com>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed version 2.0.0 (GTK+ 2.6.7; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am not completely confident in this patch, so while the fix is being
requested by users, I would like to have it postponed until 2.6.13.

This code looks at urb->transfer_dma, maps the page and takes the data.
I am looking for volunteers to contribute architectures other than i386
or to develop an architecure-neutral API for it (or point me that it
was done already).

Signed-off-by: Pete Zaitcev <zaitcev@redhat.com>

diff -urpN -X dontdiff linux-2.6.13-rc6/drivers/usb/mon/Makefile linux-2.6.13-rc6-lem/drivers/usb/mon/Makefile
--- linux-2.6.13-rc6/drivers/usb/mon/Makefile	2005-08-14 20:57:43.000000000 -0700
+++ linux-2.6.13-rc6-lem/drivers/usb/mon/Makefile	2005-08-15 11:25:32.000000000 -0700
@@ -2,7 +2,7 @@
 # Makefile for USB Core files and filesystem
 #
 
-usbmon-objs	:= mon_main.o mon_stat.o mon_text.o
+usbmon-objs	:= mon_main.o mon_stat.o mon_text.o mon_dma.o
 
 # This does not use CONFIG_USB_MON because we want this to use a tristate.
 obj-$(CONFIG_USB)	+= usbmon.o
diff -urpN -X dontdiff linux-2.6.13-rc6/drivers/usb/mon/mon_dma.c linux-2.6.13-rc6-lem/drivers/usb/mon/mon_dma.c
--- linux-2.6.13-rc6/drivers/usb/mon/mon_dma.c	1969-12-31 16:00:00.000000000 -0800
+++ linux-2.6.13-rc6-lem/drivers/usb/mon/mon_dma.c	2005-08-15 16:11:51.000000000 -0700
@@ -0,0 +1,55 @@
+/*
+ * The USB Monitor, inspired by Dave Harding's USBMon.
+ * 
+ * mon_dma.c: Library which snoops on DMA areas.
+ *
+ * Copyright (C) 2005 Pete Zaitcev (zaitcev@redhat.com)
+ */
+#include <linux/kernel.h>
+#include <linux/list.h>
+#include <linux/highmem.h>
+#include <asm/page.h>
+
+#include <linux/usb.h>	/* Only needed for declarations in usb_mon.h */
+#include "usb_mon.h"
+
+#ifdef __i386__		/* CONFIG_ARCH_I386 does not exit */
+#define MON_HAS_UNMAP 1
+
+#define phys_to_page(phys)	pfn_to_page((phys) >> PAGE_SHIFT)
+
+char mon_dmapeek(unsigned char *dst, dma_addr_t dma_addr, int len)
+{
+	struct page *pg;
+	unsigned long flags;
+	unsigned char *map;
+	unsigned char *ptr;
+
+	/*
+	 * On i386, a DMA handle is the "physical" address of a page.
+	 * In other words, the bus address is equal to physical address.
+	 * There is no IOMMU.
+	 */
+	pg = phys_to_page(dma_addr);
+
+	/*
+	 * We are called from hardware IRQs in case of callbacks.
+	 * But we can be called from softirq or process context in case
+	 * of submissions. In such case, we need to protect KM_IRQ0.
+	 */
+	local_irq_save(flags);
+	map = kmap_atomic(pg, KM_IRQ0);
+	ptr = map + (dma_addr & (PAGE_SIZE-1));
+	memcpy(dst, ptr, len);
+	kunmap_atomic(map, KM_IRQ0);
+	local_irq_restore(flags);
+	return 0;
+}
+#endif /* __i386__ */
+
+#ifndef MON_HAS_UNMAP
+char mon_dmapeek(unsigned char *dst, dma_addr_t dma_addr, int len)
+{
+	return 'D';
+}
+#endif
diff -urpN -X dontdiff linux-2.6.13-rc6/drivers/usb/mon/mon_text.c linux-2.6.13-rc6-lem/drivers/usb/mon/mon_text.c
--- linux-2.6.13-rc6/drivers/usb/mon/mon_text.c	2005-08-14 20:57:43.000000000 -0700
+++ linux-2.6.13-rc6-lem/drivers/usb/mon/mon_text.c	2005-08-15 11:44:13.000000000 -0700
@@ -91,25 +91,11 @@ static inline char mon_text_get_data(str
     int len, char ev_type)
 {
 	int pipe = urb->pipe;
-	unsigned char *data;
-
-	/*
-	 * The check to see if it's safe to poke at data has an enormous
-	 * number of corner cases, but it seems that the following is
-	 * more or less safe.
-	 *
-	 * We do not even try to look transfer_buffer, because it can
-	 * contain non-NULL garbage in case the upper level promised to
-	 * set DMA for the HCD.
-	 */
-	if (urb->transfer_flags & URB_NO_TRANSFER_DMA_MAP)
-		return 'D';
 
 	if (len <= 0)
 		return 'L';
-
-	if ((data = urb->transfer_buffer) == NULL)
-		return 'Z';	/* '0' would be not as pretty. */
+	if (len >= DATA_MAX)
+		len = DATA_MAX;
 
 	/*
 	 * Bulk is easy to shortcut reliably. 
@@ -126,8 +112,21 @@ static inline char mon_text_get_data(str
 		}
 	}
 
-	if (len >= DATA_MAX)
-		len = DATA_MAX;
+	/*
+	 * The check to see if it's safe to poke at data has an enormous
+	 * number of corner cases, but it seems that the following is
+	 * more or less safe.
+	 *
+	 * We do not even try to look transfer_buffer, because it can
+	 * contain non-NULL garbage in case the upper level promised to
+	 * set DMA for the HCD.
+	 */
+	if (urb->transfer_flags & URB_NO_TRANSFER_DMA_MAP)
+		return mon_dmapeek(ep->data, urb->transfer_dma, len);
+
+	if (urb->transfer_buffer == NULL)
+		return 'Z';	/* '0' would be not as pretty. */
+
 	memcpy(ep->data, urb->transfer_buffer, len);
 	return 0;
 }
diff -urpN -X dontdiff linux-2.6.13-rc6/drivers/usb/mon/usb_mon.h linux-2.6.13-rc6-lem/drivers/usb/mon/usb_mon.h
--- linux-2.6.13-rc6/drivers/usb/mon/usb_mon.h	2005-06-17 12:48:29.000000000 -0700
+++ linux-2.6.13-rc6-lem/drivers/usb/mon/usb_mon.h	2005-08-15 16:12:42.000000000 -0700
@@ -43,6 +45,10 @@ struct mon_reader {
 void mon_reader_add(struct mon_bus *mbus, struct mon_reader *r);
 void mon_reader_del(struct mon_bus *mbus, struct mon_reader *r);
 
+/*
+ */
+extern char mon_dmapeek(unsigned char *dst, dma_addr_t dma_addr, int len);
+
 extern struct semaphore mon_lock;
 
 extern struct file_operations mon_fops_text;
