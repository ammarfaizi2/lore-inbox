Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261448AbVDUIDQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261448AbVDUIDQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Apr 2005 04:03:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261537AbVDUICD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Apr 2005 04:02:03 -0400
Received: from smtp813.mail.sc5.yahoo.com ([66.163.170.83]:52151 "HELO
	smtp813.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261448AbVDUHaR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Apr 2005 03:30:17 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: sensors@Stimpy.netroedge.com
Subject: [RFC/PATCH 11/22] W1: move w1_search to the rest of IO code
Date: Thu, 21 Apr 2005 02:18:12 -0500
User-Agent: KMail/1.8
Cc: LKML <linux-kernel@vger.kernel.org>, Greg KH <gregkh@suse.de>,
       Evgeniy Polyakov <johnpol@2ka.mipt.ru>
References: <200504210207.02421.dtor_core@ameritech.net>
In-Reply-To: <200504210207.02421.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200504210218.12399.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

W1: move w1_search function to w1_io.c to be with the rest of IO code.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 w1.c    |   87 --------------------------------------------------------------
 w1.h    |    1 
 w1_io.c |   89 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 88 insertions(+), 89 deletions(-)

Index: dtor/drivers/w1/w1.c
===================================================================
--- dtor.orig/drivers/w1/w1.c
+++ dtor/drivers/w1/w1.c
@@ -488,93 +488,6 @@ static void w1_slave_found(struct w1_mas
 	atomic_dec(&dev->refcnt);
 }
 
-void w1_search(struct w1_master *dev)
-{
-	u64 last, rn, tmp;
-	int i, count = 0;
-	int last_family_desc, last_zero, last_device;
-	int search_bit, id_bit, comp_bit, desc_bit;
-
-	search_bit = id_bit = comp_bit = 0;
-	rn = tmp = last = 0;
-	last_device = last_zero = last_family_desc = 0;
-
-	desc_bit = 64;
-
-	while (!(id_bit && comp_bit) && !last_device &&
-	       count++ < dev->max_slave_count) {
-		last = rn;
-		rn = 0;
-
-		last_family_desc = 0;
-
-		/*
-		 * Reset bus and all 1-wire device state machines
-		 * so they can respond to our requests.
-		 *
-		 * Return 0 - device(s) present, 1 - no devices present.
-		 */
-		if (w1_reset_bus(dev)) {
-			dev_info(&dev->dev, "No devices present on the wire.\n");
-			break;
-		}
-
-#if 1
-		w1_write_8(dev, W1_SEARCH);
-		for (i = 0; i < 64; ++i) {
-			/*
-			 * Read 2 bits from bus.
-			 * All who don't sleep must send ID bit and COMPLEMENT ID bit.
-			 * They actually are ANDed between all senders.
-			 */
-			id_bit = w1_touch_bit(dev, 1);
-			comp_bit = w1_touch_bit(dev, 1);
-
-			if (id_bit && comp_bit)
-				break;
-
-			if (id_bit == 0 && comp_bit == 0) {
-				if (i == desc_bit)
-					search_bit = 1;
-				else if (i > desc_bit)
-					search_bit = 0;
-				else
-					search_bit = ((last >> i) & 0x1);
-
-				if (search_bit == 0) {
-					last_zero = i;
-					if (last_zero < 9)
-						last_family_desc = last_zero;
-				}
-
-			} else
-				search_bit = id_bit;
-
-			tmp = search_bit;
-			rn |= (tmp << i);
-
-			/*
-			 * Write 1 bit to bus
-			 * and make all who don't have "search_bit" in "i"'th position
-			 * in it's registration number sleep.
-			 */
-			if (dev->bus_ops->touch_bit)
-				w1_touch_bit(dev, search_bit);
-			else
-				w1_write_bit(dev, search_bit);
-
-		}
-#endif
-
-		if (desc_bit == last_zero)
-			last_device = 1;
-
-		desc_bit = last_zero;
-
-		w1_slave_found(dev, rn);
-	}
-}
-
 
 static int w1_process(void *data)
 {
Index: dtor/drivers/w1/w1_io.c
===================================================================
--- dtor.orig/drivers/w1/w1_io.c
+++ dtor/drivers/w1/w1_io.c
@@ -178,13 +178,100 @@ u8 w1_calc_crc8(u8 * data, int len)
 	return crc;
 }
 
+static void w1_search(struct w1_master *dev, w1_slave_found_callback slave_found_cb)
+{
+	u64 last, rn, tmp;
+	int i, count = 0;
+	int last_family_desc, last_zero, last_device;
+	int search_bit, id_bit, comp_bit, desc_bit;
+
+	search_bit = id_bit = comp_bit = 0;
+	rn = tmp = last = 0;
+	last_device = last_zero = last_family_desc = 0;
+
+	desc_bit = 64;
+
+	while (!(id_bit && comp_bit) && !last_device &&
+	       count++ < dev->max_slave_count) {
+		last = rn;
+		rn = 0;
+
+		last_family_desc = 0;
+
+		/*
+		 * Reset bus and all 1-wire device state machines
+		 * so they can respond to our requests.
+		 *
+		 * Return 0 - device(s) present, 1 - no devices present.
+		 */
+		if (w1_reset_bus(dev)) {
+			dev_info(&dev->dev, "No devices present on the wire.\n");
+			break;
+		}
+
+#if 1
+		w1_write_8(dev, W1_SEARCH);
+		for (i = 0; i < 64; ++i) {
+			/*
+			 * Read 2 bits from bus.
+			 * All who don't sleep must send ID bit and COMPLEMENT ID bit.
+			 * They actually are ANDed between all senders.
+			 */
+			id_bit = w1_touch_bit(dev, 1);
+			comp_bit = w1_touch_bit(dev, 1);
+
+			if (id_bit && comp_bit)
+				break;
+
+			if (id_bit == 0 && comp_bit == 0) {
+				if (i == desc_bit)
+					search_bit = 1;
+				else if (i > desc_bit)
+					search_bit = 0;
+				else
+					search_bit = ((last >> i) & 0x1);
+
+				if (search_bit == 0) {
+					last_zero = i;
+					if (last_zero < 9)
+						last_family_desc = last_zero;
+				}
+
+			} else
+				search_bit = id_bit;
+
+			tmp = search_bit;
+			rn |= (tmp << i);
+
+			/*
+			 * Write 1 bit to bus
+			 * and make all who don't have "search_bit" in "i"'th position
+			 * in it's registration number sleep.
+			 */
+			if (dev->bus_ops->touch_bit)
+				w1_touch_bit(dev, search_bit);
+			else
+				w1_write_bit(dev, search_bit);
+
+		}
+#endif
+
+		if (desc_bit == last_zero)
+			last_device = 1;
+
+		desc_bit = last_zero;
+
+		slave_found_cb(dev, rn);
+	}
+}
+
 void w1_search_devices(struct w1_master *dev, w1_slave_found_callback cb)
 {
 	dev->attempts++;
 	if (dev->bus_ops->search)
 		dev->bus_ops->search(dev, cb);
 	else
-		w1_search(dev);
+		w1_search(dev, cb);
 }
 
 EXPORT_SYMBOL(w1_write_bit);
Index: dtor/drivers/w1/w1.h
===================================================================
--- dtor.orig/drivers/w1/w1.h
+++ dtor/drivers/w1/w1.h
@@ -132,7 +132,6 @@ struct w1_master
 struct w1_master *w1_allocate_master_device(void);
 int w1_add_master_device(struct w1_master *);
 void w1_remove_master_device(struct w1_master *);
-void w1_search(struct w1_master *);
 
 #endif /* __KERNEL__ */
 
