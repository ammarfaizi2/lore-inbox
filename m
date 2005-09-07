Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932143AbVIGSOX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932143AbVIGSOX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Sep 2005 14:14:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932153AbVIGSOW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Sep 2005 14:14:22 -0400
Received: from vana.vc.cvut.cz ([147.32.240.58]:38586 "EHLO vana.vc.cvut.cz")
	by vger.kernel.org with ESMTP id S932143AbVIGSOW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Sep 2005 14:14:22 -0400
Date: Wed, 7 Sep 2005 20:14:15 +0200
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: khali@linux-fr.org
Cc: lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Request only really used I/O ports in w83627hf driver
Message-ID: <20050907181415.GA468@vana.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
  my motherboard (Tyan S2885) reports range 295-296 in its PNP hardware
descriptors, and due to this w83627hf driver fails to load, as it requests
290-297 range, which is not subrange of this PNP resource.  As hardware 
monitor chip responds to 295/296 addresses only, there is no reason to 
request full 8 byte I/O.

  While I was doing that, I also changed W83781D_*_REG_OFFSET definitions
from 5/6 to 0/1.  Code is a bit smaller after doing that, and it looks
better now since we do not allocate full 8 byte range.

  cat /proc/ioports is now much happier and monitor finally works.
...
0295-0296 : pnp 00:09
  0295-0296 : w83627hf
...

						Thanks,
							Petr Vandrovec

Signed-off-by:  Petr Vandrovec <vandrove@vc.cvut.cz>


diff -urN linux-2.6.13-5bca.dist/drivers/hwmon/w83627hf.c linux-2.6.13-5bca/drivers/hwmon/w83627hf.c
--- linux-2.6.13-5bca.dist/drivers/hwmon/w83627hf.c     2005-09-06 13:50:03.000000000 +0200
+++ linux-2.6.13-5bca/drivers/hwmon/w83627hf.c  2005-09-07 19:54:08.000000000 +0200
@@ -138,12 +138,16 @@
 #define WINB_BASE_REG 0x60
 /* Constants specified below */
 
-/* Length of ISA address segment */
-#define WINB_EXTENT 8
+/* Alignment of ISA address */
+#define WINB_ALIGNMENT		~7
 
-/* Where are the ISA address/data registers relative to the base address */
-#define W83781D_ADDR_REG_OFFSET 5
-#define W83781D_DATA_REG_OFFSET 6
+/* Offset & size of I/O region we are interested in */
+#define WINB_REGION_OFFSET	5
+#define WINB_REGION_SIZE	2
+
+/* Where are the ISA address/data registers relative to the region start */
+#define W83781D_ADDR_REG_OFFSET 0
+#define W83781D_DATA_REG_OFFSET 1
 
 /* The W83781D registers */
 /* The W83782D registers for nr=7,8 are in bank 5 */
@@ -977,7 +981,7 @@
 	superio_select(W83627HF_LD_HWM);
 	val = (superio_inb(WINB_BASE_REG) << 8) |
 	       superio_inb(WINB_BASE_REG + 1);
-	*addr = val & ~(WINB_EXTENT - 1);
+	*addr = val & WINB_ALIGNMENT;
 	if (*addr == 0 && force_addr == 0) {
 		superio_exit();
 		return -ENODEV;
@@ -994,11 +998,13 @@
 	struct w83627hf_data *data;
 	int err = 0;
 	const char *client_name = "";
+	unsigned short addr;
 
 	if(force_addr)
-		address = force_addr & ~(WINB_EXTENT - 1);
+		address = force_addr & WINB_ALIGNMENT;
+	addr = address + WINB_REGION_OFFSET;
 
-	if (!request_region(address, WINB_EXTENT, w83627hf_driver.name)) {
+	if (!request_region(addr, WINB_REGION_SIZE, w83627hf_driver.name)) {
 		err = -EBUSY;
 		goto ERROR0;
 	}
@@ -1045,7 +1051,7 @@
 
 	new_client = &data->client;
 	i2c_set_clientdata(new_client, data);
-	new_client->addr = address;
+	new_client->addr = addr;
 	init_MUTEX(&data->lock);
 	new_client->adapter = adapter;
 	new_client->driver = &w83627hf_driver;
@@ -1144,7 +1150,7 @@
       ERROR2:
 	kfree(data);
       ERROR1:
-	release_region(address, WINB_EXTENT);
+	release_region(addr, WINB_REGION_SIZE);
       ERROR0:
 	return err;
 }
@@ -1159,7 +1165,7 @@
 	if ((err = i2c_detach_client(client)))
 		return err;
 
-	release_region(client->addr, WINB_EXTENT);
+	release_region(client->addr, WINB_REGION_SIZE);
 	kfree(data);
 
 	return 0;
