Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261775AbVFFX4H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261775AbVFFX4H (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Jun 2005 19:56:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261786AbVFFXzV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Jun 2005 19:55:21 -0400
Received: from rav-az.mvista.com ([65.200.49.157]:48928 "EHLO
	zipcode.az.mvista.com") by vger.kernel.org with ESMTP
	id S261771AbVFFXwg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Jun 2005 19:52:36 -0400
Cc: linux-kernel@vger.kernel.org, linuxppc-embedded@ozlabs.org
Subject: [PATCH][RIO] -mm: sysfs config space fixes
In-Reply-To: <11181019441461@foobar.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 6 Jun 2005 16:52:24 -0700
Message-Id: <11181019442715@foobar.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Matt Porter <mporter@kernel.crashing.org>
To: akpm@osdl.org
Content-Transfer-Encoding: 7BIT
From: Matt Porter <mporter@kernel.crashing.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix sysfs config space access similar to the recent PCI sysfs changes. 

Signed-off-by: Matt Porter <mporter@kernel.crashing.org>

commit 2a28743938495ab6055db2e29f3e0721bba022cc
tree 09d592a46eff8592327b20c609595eb8b7d5e333
parent d45c2d2fedcafd50a860267ff1d517c3071ab585
author Matt Porter <mporter@kernel.crashing.org> Mon, 06 Jun 2005 14:50:28 -0700
committer Matt Porter <mporter@kernel.crashing.org> Mon, 06 Jun 2005 14:50:28 -0700

 drivers/rio/rio-sysfs.c |   82 +++++++++++++++++++++++++++++++++--------------
 1 files changed, 58 insertions(+), 24 deletions(-)

diff --git a/drivers/rio/rio-sysfs.c b/drivers/rio/rio-sysfs.c
--- a/drivers/rio/rio-sysfs.c
+++ b/drivers/rio/rio-sysfs.c
@@ -74,10 +74,11 @@ rio_read_config(struct kobject *kobj, ch
 	    to_rio_dev(container_of(kobj, struct device, kobj));
 	unsigned int size = 0x100;
 	loff_t init_off = off;
+	u8 *data = (u8 *) buf;
 
 	/* Several chips lock up trying to read undefined config space */
 	if (capable(CAP_SYS_ADMIN))
-		size = 0x80000;
+		size = 0x200000;
 
 	if (off > size)
 		return 0;
@@ -88,30 +89,47 @@ rio_read_config(struct kobject *kobj, ch
 		size = count;
 	}
 
-	while (off & 3) {
-		unsigned char val;
+	if ((off & 1) && size) {
+		u8 val;
 		rio_read_config_8(dev, off, &val);
-		buf[off - init_off] = val;
+		data[off - init_off] = val;
 		off++;
-		if (--size == 0)
-			break;
+		size--;
+	}
+
+	if ((off & 3) && size > 2) {
+		u16 val;
+		rio_read_config_16(dev, off, &val);
+		data[off - init_off] = (val >> 8) & 0xff;
+		data[off - init_off + 1] = val & 0xff;
+		off += 2;
+		size -= 2;
 	}
 
 	while (size > 3) {
-		unsigned int val;
+		u32 val;
 		rio_read_config_32(dev, off, &val);
-		buf[off - init_off] = (val >> 24) & 0xff;
-		buf[off - init_off + 1] = (val >> 16) & 0xff;
-		buf[off - init_off + 2] = (val >> 8) & 0xff;
-		buf[off - init_off + 3] = val & 0xff;
+		data[off - init_off] = (val >> 24) & 0xff;
+		data[off - init_off + 1] = (val >> 16) & 0xff;
+		data[off - init_off + 2] = (val >> 8) & 0xff;
+		data[off - init_off + 3] = val & 0xff;
 		off += 4;
 		size -= 4;
 	}
 
-	while (size > 0) {
-		unsigned char val;
+	if (size >= 2) {
+		u16 val;
+		rio_read_config_16(dev, off, &val);
+		data[off - init_off] = (val >> 8) & 0xff;
+		data[off - init_off + 1] = val & 0xff;
+		off += 2;
+		size -= 2;
+	}
+
+	if (size > 0) {
+		u8 val;
 		rio_read_config_8(dev, off, &val);
-		buf[off - init_off] = val;
+		data[off - init_off] = val;
 		off++;
 		--size;
 	}
@@ -126,6 +144,7 @@ rio_write_config(struct kobject *kobj, c
 	    to_rio_dev(container_of(kobj, struct device, kobj));
 	unsigned int size = count;
 	loff_t init_off = off;
+	u8 *data = (u8 *) buf;
 
 	if (off > 0x200000)
 		return 0;
@@ -134,25 +153,40 @@ rio_write_config(struct kobject *kobj, c
 		count = size;
 	}
 
-	while (off & 3) {
-		rio_write_config_8(dev, off, buf[off - init_off]);
+	if ((off & 1) && size) {
+		rio_write_config_8(dev, off, data[off - init_off]);
 		off++;
-		if (--size == 0)
-			break;
+		size--;
+	}
+
+	if ((off & 3) && (size > 2)) {
+		u16 val = data[off - init_off + 1];
+		val |= (u16) data[off - init_off] << 8;
+		rio_write_config_16(dev, off, val);
+		off += 2;
+		size -= 2;
 	}
 
 	while (size > 3) {
-		unsigned int val = buf[off - init_off + 3];
-		val |= (unsigned int)buf[off - init_off + 2] << 8;
-		val |= (unsigned int)buf[off - init_off + 1] << 16;
-		val |= (unsigned int)buf[off - init_off] << 24;
+		u32 val = data[off - init_off + 3];
+		val |= (u32) data[off - init_off + 2] << 8;
+		val |= (u32) data[off - init_off + 1] << 16;
+		val |= (u32) data[off - init_off] << 24;
 		rio_write_config_32(dev, off, val);
 		off += 4;
 		size -= 4;
 	}
 
-	while (size > 0) {
-		rio_write_config_8(dev, off, buf[off - init_off]);
+	if (size >= 2) {
+		u16 val = data[off - init_off + 1];
+		val |= (u16) data[off - init_off] << 8;
+		rio_write_config_16(dev, off, val);
+		off += 2;
+		size -= 2;
+	}
+
+	if (size) {
+		rio_write_config_8(dev, off, data[off - init_off]);
 		off++;
 		--size;
 	}


