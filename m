Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262753AbVFVFb4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262753AbVFVFb4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 01:31:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262524AbVFVFbj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 01:31:39 -0400
Received: from mail.kroah.org ([69.55.234.183]:39063 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262753AbVFVFMR convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 01:12:17 -0400
Cc: johnpol@2ka.mipt.ru
Subject: [PATCH] w1_therm: support for ds18b20, ds1822 thermal sensors.
In-Reply-To: <20050622051133.GA28612@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Tue, 21 Jun 2005 22:12:06 -0700
Message-Id: <11194171261398@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] w1_therm: support for ds18b20, ds1822 thermal sensors.

Support for ds18b20, ds1822 thermal sensors.
Based on code from Tiziano M_ller <tm@dev-zero.ch>.
Patch is against 2.6.12-rc2 and should be applied
without problems on top of any later kernels since
w1_therm driver was not changed.

Signed-off-by: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 718a538f945a84244a460df434c3f6f04701957b
tree 1477ac9d085e53afdc963401537683a248436700
parent 2a5a68b840cbab31baab2d9b2e1e6de3b289ae1e
author Evgeniy Polyakov <johnpol@2ka.mipt.ru> Sun, 17 Apr 2005 22:58:14 +0400
committer Greg Kroah-Hartman <gregkh@suse.de> Tue, 21 Jun 2005 21:43:08 -0700

 drivers/w1/w1_family.h |    4 ++
 drivers/w1/w1_therm.c  |   92 +++++++++++++++++++++++++++++++++++++++++++-----
 2 files changed, 85 insertions(+), 11 deletions(-)

diff --git a/drivers/w1/w1_family.h b/drivers/w1/w1_family.h
--- a/drivers/w1/w1_family.h
+++ b/drivers/w1/w1_family.h
@@ -27,8 +27,10 @@
 #include <asm/atomic.h>
 
 #define W1_FAMILY_DEFAULT	0
-#define W1_FAMILY_THERM		0x10
 #define W1_FAMILY_SMEM		0x01
+#define W1_THERM_DS18S20 	0x10
+#define W1_THERM_DS1822  	0x22
+#define W1_THERM_DS18B20 	0x28
 
 #define MAXNAMELEN		32
 
diff --git a/drivers/w1/w1_therm.c b/drivers/w1/w1_therm.c
--- a/drivers/w1/w1_therm.c
+++ b/drivers/w1/w1_therm.c
@@ -53,6 +53,50 @@ static struct w1_family_ops w1_therm_fop
 	.rvalname = "temp1_input",
 };
 
+static struct w1_family w1_therm_family_DS18S20 = {
+	.fid = W1_THERM_DS18S20,
+	.fops = &w1_therm_fops,
+};
+
+static struct w1_family w1_therm_family_DS18B20 = {
+	.fid = W1_THERM_DS18B20,
+	.fops = &w1_therm_fops,
+};
+static struct w1_family w1_therm_family_DS1822 = {
+	.fid = W1_THERM_DS1822,
+	.fops = &w1_therm_fops,
+};
+
+struct w1_therm_family_converter
+{
+	u8			fid;
+	u8			broken;
+	u16			reserved;
+	struct w1_family	*f;
+	int			(*convert)(u8 rom[9]);
+};
+
+static inline int w1_DS18B20_convert_temp(u8 rom[9]);
+static inline int w1_DS18S20_convert_temp(u8 rom[9]);
+
+static struct w1_therm_family_converter w1_therm_families[] = {
+	{
+		.fid 		= W1_THERM_DS18S20,
+		.f		= &w1_therm_family_DS18S20,
+		.convert 	= w1_DS18S20_convert_temp
+	},
+	{
+		.fid 		= W1_THERM_DS1822,
+		.f		= &w1_therm_family_DS1822,
+		.convert 	= w1_DS18B20_convert_temp
+	},
+	{
+		.fid 		= W1_THERM_DS18B20,
+		.f		= &w1_therm_family_DS18B20,
+		.convert 	= w1_DS18B20_convert_temp
+	},
+};
+
 static ssize_t w1_therm_read_name(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct w1_slave *sl = container_of(dev, struct w1_slave, dev);
@@ -60,9 +104,19 @@ static ssize_t w1_therm_read_name(struct
 	return sprintf(buf, "%s\n", sl->name);
 }
 
-static inline int w1_convert_temp(u8 rom[9])
+static inline int w1_DS18B20_convert_temp(u8 rom[9])
+{
+	int t = (rom[1] << 8) | rom[0];
+	t /= 16;
+	return t;
+}
+
+static inline int w1_DS18S20_convert_temp(u8 rom[9])
 {
 	int t, h;
+
+	if (!rom[7])
+		return 0;
 	
 	if (rom[1] == 0)
 		t = ((s32)rom[0] >> 1)*1000;
@@ -77,11 +131,22 @@ static inline int w1_convert_temp(u8 rom
 	return t;
 }
 
+static inline int w1_convert_temp(u8 rom[9], u8 fid)
+{
+	int i;
+
+	for (i=0; i<sizeof(w1_therm_families)/sizeof(w1_therm_families[0]); ++i)
+		if (w1_therm_families[i].fid == fid)
+			return w1_therm_families[i].convert(rom);
+
+	return 0;
+}
+
 static ssize_t w1_therm_read_temp(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct w1_slave *sl = container_of(dev, struct w1_slave, dev);
 
-	return sprintf(buf, "%d\n", w1_convert_temp(sl->rom));
+	return sprintf(buf, "%d\n", w1_convert_temp(sl->rom, sl->family->fid));
 }
 
 static int w1_therm_check_rom(u8 rom[9])
@@ -176,7 +241,7 @@ static ssize_t w1_therm_read_bin(struct 
 	for (i = 0; i < 9; ++i)
 		count += sprintf(buf + count, "%02x ", sl->rom[i]);
 	
-	count += sprintf(buf + count, "t=%d\n", w1_convert_temp(rom));
+	count += sprintf(buf + count, "t=%d\n", w1_convert_temp(rom, sl->family->fid));
 out:
 	up(&dev->mutex);
 out_dec:
@@ -186,19 +251,26 @@ out_dec:
 	return count;
 }
 
-static struct w1_family w1_therm_family = {
-	.fid = W1_FAMILY_THERM,
-	.fops = &w1_therm_fops,
-};
-
 static int __init w1_therm_init(void)
 {
-	return w1_register_family(&w1_therm_family);
+	int err, i;
+
+	for (i=0; i<sizeof(w1_therm_families)/sizeof(w1_therm_families[0]); ++i) {
+		err = w1_register_family(w1_therm_families[i].f);
+		if (err)
+			w1_therm_families[i].broken = 1;
+	}
+
+	return 0;
 }
 
 static void __exit w1_therm_fini(void)
 {
-	w1_unregister_family(&w1_therm_family);
+	int i;
+
+	for (i=0; i<sizeof(w1_therm_families)/sizeof(w1_therm_families[0]); ++i)
+		if (!w1_therm_families[i].broken)
+			w1_unregister_family(w1_therm_families[i].f);
 }
 
 module_init(w1_therm_init);

