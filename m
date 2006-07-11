Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751006AbWGKKy2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751006AbWGKKy2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 06:54:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751010AbWGKKy2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 06:54:28 -0400
Received: from smtp.osdl.org ([65.172.181.4]:38806 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751006AbWGKKyZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 06:54:25 -0400
Date: Tue, 11 Jul 2006 03:53:38 -0700
From: Andrew Morton <akpm@osdl.org>
To: Herbert Valerio Riedel <hvr@gnu.org>
Cc: a.zummo@towertech.it, linux-kernel@vger.kernel.org, khali@linux-fr.org,
       jr@mpoli.fi
Subject: Re: [PATCH] RTC subsystem, Add ISL1208 support
Message-Id: <20060711035338.093354d9.akpm@osdl.org>
In-Reply-To: <E1G0DGP-0003fs-Mn@fencepost.gnu.org>
References: <E1G0DGP-0003fs-Mn@fencepost.gnu.org>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Jul 2006 04:06:37 -0400
Herbert Valerio Riedel <hvr@gnu.org> wrote:

> This patch adds support for the I2C-attached Intersil ISL1208 RTC chip.

The driver does a lot of:

	if (foo())
		return -EIO.

It's more conventional to preserve the error code:

	ret = foo();
	if (ret < 0)
		return ret;

Also, the return value from device_create_file() is ignored.  We should check
these things.


I see no device_remove_file() calls on the teardown path.  Should they be
there?


The driver does a lot of

	if ((foo = something()) < 0)

whereas perferred kernel style (ie: super-simple style) is

	foo = something();
	if (foo < 0)


Here's a hastily-flung-together update.  Please consider.

From: Andrew Morton <akpm@osdl.org>

- Correctly propagate error codes

- Coding style consistency

- Clean up if device_create_file() failed.

Cc: Herbert Valerio Riedel <hvr@gnu.org>
Cc: Alessandro Zummo <a.zummo@towertech.it>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 drivers/rtc/rtc-isl1208.c |  163 +++++++++++++++++++++---------------
 linux/i2c-id.h            |    0 
 2 files changed, 99 insertions(+), 64 deletions(-)

diff -puN drivers/rtc/Kconfig~rtc-subsystem-add-isl1208-support-tweaks drivers/rtc/Kconfig
diff -puN drivers/rtc/Makefile~rtc-subsystem-add-isl1208-support-tweaks drivers/rtc/Makefile
diff -puN drivers/rtc/rtc-isl1208.c~rtc-subsystem-add-isl1208-support-tweaks drivers/rtc/rtc-isl1208.c
--- a/drivers/rtc/rtc-isl1208.c~rtc-subsystem-add-isl1208-support-tweaks
+++ a/drivers/rtc/rtc-isl1208.c
@@ -66,8 +66,8 @@ static unsigned short normal_i2c[] = {
 };
 I2C_CLIENT_INSMOD; /* defines addr_data */
 
-static int isl1208_attach_adapter (struct i2c_adapter *adapter);
-static int isl1208_detach_client (struct i2c_client *client);
+static int isl1208_attach_adapter(struct i2c_adapter *adapter);
+static int isl1208_detach_client(struct i2c_client *client);
 
 static struct i2c_driver isl1208_driver = {
 	.driver		= {
@@ -80,7 +80,7 @@ static struct i2c_driver isl1208_driver 
 
 /* block read */
 static int
-isl1208_i2c_read_regs (struct i2c_client *client, u8 reg, u8 buf[],
+isl1208_i2c_read_regs(struct i2c_client *client, u8 reg, u8 buf[],
 		       unsigned len)
 {
 	u8 reg_addr[1] = { reg };
@@ -88,25 +88,28 @@ isl1208_i2c_read_regs (struct i2c_client
 		{ client->addr, client->flags, sizeof(reg_addr), reg_addr },
 		{ client->addr, client->flags | I2C_M_RD, len, buf }
 	};
+	int ret;
 
 	BUG_ON(len == 0);
 	BUG_ON(reg > ISL1208_REG_USR2);
 	BUG_ON(reg + len > ISL1208_REG_USR2 + 1);
 
-	if (i2c_transfer (client->adapter, msgs, 2) < 0)
-		return -EIO;
-	return 0;
+	ret = i2c_transfer(client->adapter, msgs, 2);
+	if (ret > 0)
+		ret = 0;
+	return ret;
 }
 
 /* block write */
 static int
-isl1208_i2c_set_regs (struct i2c_client *client, u8 reg, u8 const buf[],
+isl1208_i2c_set_regs(struct i2c_client *client, u8 reg, u8 const buf[],
 		       unsigned len)
 {
 	u8 i2c_buf[ISL1208_REG_USR2 + 2];
 	struct i2c_msg msgs[1] = {
 		{ client->addr, client->flags, len + 1, i2c_buf }
 	};
+	int ret;
 
 	BUG_ON(len == 0);
 	BUG_ON(reg > ISL1208_REG_USR2);
@@ -115,9 +118,10 @@ isl1208_i2c_set_regs (struct i2c_client 
 	i2c_buf[0] = reg;
 	memcpy(&i2c_buf[1], &buf[0], len);
 
-	if (i2c_transfer (client->adapter, msgs, 1) < 0)
-		return -EIO;
-	return 0;
+	ret = i2c_transfer(client->adapter, msgs, 1);
+	if (ret > 0)
+		ret = 0;
+	return ret;
 }
 
 /* simple check to see wether we have a isl1208 */
@@ -128,9 +132,11 @@ static int isl1208_i2c_validate_client(s
 		0x80, 0x80, 0x40, 0xc0, 0xe0, 0x00, 0xf8
 	};
 	int i;
+	int ret;
 
-	if (isl1208_i2c_read_regs(client, 0, regs, ISL1208_RTC_SECTION_LEN))
-		return -EIO;
+	ret = isl1208_i2c_read_regs(client, 0, regs, ISL1208_RTC_SECTION_LEN);
+	if (ret < 0)
+		return ret;
 
 	for (i = 0; i < ISL1208_RTC_SECTION_LEN; ++i) {
 		if (regs[i] & zero_mask[i]) /* check if bits are cleared */
@@ -142,14 +148,15 @@ static int isl1208_i2c_validate_client(s
 
 static int isl1208_i2c_get_sr(struct i2c_client *client)
 {
-	return i2c_smbus_read_byte_data (client, ISL1208_REG_SR);
+	return i2c_smbus_read_byte_data(client, ISL1208_REG_SR) == -1 ? -EIO:0;
 }
 
 static int isl1208_i2c_get_atr(struct i2c_client *client)
 {
-	int atr = i2c_smbus_read_byte_data (client, ISL1208_REG_ATR);
+	int atr = i2c_smbus_read_byte_data(client, ISL1208_REG_ATR);
+
 	if (atr < 0)
-		return -1;
+		return -EIO;
 
 	/* The 6bit value in the ATR register controls the load
 	 * capacitance C_load * in steps of 0.25pF
@@ -171,9 +178,10 @@ static int isl1208_i2c_get_atr(struct i2
 
 static int isl1208_i2c_get_dtr(struct i2c_client *client)
 {
-	int dtr = i2c_smbus_read_byte_data (client, ISL1208_REG_DTR);
+	int dtr = i2c_smbus_read_byte_data(client, ISL1208_REG_DTR);
+
 	if (dtr < 0)
-		return -1;
+		return -EIO;
 
 	/* dtr encodes adjustments of {-60,-40,-20,0,20,40,60} ppm */
 	dtr = ((dtr & 0x3) * 20) * (dtr & (1<<2) ? -1 : 1);
@@ -184,10 +192,12 @@ static int isl1208_i2c_get_dtr(struct i2
 static int isl1208_i2c_get_usr(struct i2c_client *client)
 {
 	u8 buf[ISL1208_USR_SECTION_LEN] = { 0, };
+	int ret;
 
-	if (isl1208_i2c_read_regs (client, ISL1208_REG_USR1, buf,
-				   ISL1208_USR_SECTION_LEN))
-		return -EIO;
+	ret = isl1208_i2c_read_regs (client, ISL1208_REG_USR1, buf,
+				   ISL1208_USR_SECTION_LEN);
+	if (ret < 0)
+		return ret;
 
 	return (buf[1] << 8) | buf[0];
 }
@@ -208,9 +218,10 @@ static int isl1208_rtc_proc(struct devic
 	struct i2c_client *const client = to_i2c_client(dev);
 	int sr, dtr, atr, usr;
 
-	if ((sr = isl1208_i2c_get_sr(client)) < 0) {
+	sr = isl1208_i2c_get_sr(client);
+	if (sr < 0) {
 		dev_err(&client->dev, "%s: reading SR failed\n", __func__);
-		return -EIO;
+		return sr;
 	}
 
 	seq_printf(seq, "status_reg\t:%s%s%s%s%s%s (0x%.2x)\n",
@@ -226,16 +237,16 @@ static int isl1208_rtc_proc(struct devic
 		   (sr & ISL1208_REG_SR_RTCF) ? "bad" : "okay");
 
 	dtr = isl1208_i2c_get_dtr(client);
-	if (dtr != -1)
+	if (dtr >= 0 -1)
 		seq_printf(seq, "digital_trim\t: %d ppm\n", dtr);
 
 	atr = isl1208_i2c_get_atr(client);
-	if (atr != -1)
+	if (atr >= 0)
 		seq_printf(seq, "analog_trim\t: %d.%.2d pF\n",
 			   atr>>2, (atr&0x3)*25);
 
 	usr = isl1208_i2c_get_usr(client);
-	if (usr != -1)
+	if (usr >= 0)
 		seq_printf(seq, "user_data\t: 0x%.4x\n", usr);
 
 	return 0;
@@ -248,16 +259,17 @@ static int isl1208_i2c_read_time(struct 
 	int sr;
 	u8 regs[ISL1208_RTC_SECTION_LEN] = { 0, };
 
-	if ((sr = isl1208_i2c_get_sr(client)) < 0) {
+	sr = isl1208_i2c_get_sr(client);
+	if (sr < 0) {
 		dev_err(&client->dev, "%s: reading SR failed\n", __func__);
 		return -EIO;
 	}
 
-	if (isl1208_i2c_read_regs(client, 0, regs, ISL1208_RTC_SECTION_LEN))
-	{
+	sr = isl1208_i2c_read_regs(client, 0, regs, ISL1208_RTC_SECTION_LEN);
+	if (sr < 0) {
 		dev_err(&client->dev, "%s: reading RTC section failed\n",
 			__func__);
-		return -EIO;
+		return sr;
 	}
 
 	tm->tm_sec = BCD2BIN(regs[ISL1208_REG_SC]);
@@ -288,17 +300,18 @@ static int isl1208_i2c_read_alarm(struct
 	u8 regs[ISL1208_ALARM_SECTION_LEN] = { 0, };
 	int sr;
 
-	if ((sr = isl1208_i2c_get_sr(client)) < 0) {
+	sr = isl1208_i2c_get_sr(client);
+	if (sr < 0) {
 		dev_err(&client->dev, "%s: reading SR failed\n", __func__);
-		return -EIO;
+		return sr;
 	}
 
-	if (isl1208_i2c_read_regs(client, ISL1208_REG_SCA, regs,
-				  ISL1208_ALARM_SECTION_LEN))
-	{
+	sr = isl1208_i2c_read_regs(client, ISL1208_REG_SCA, regs,
+				  ISL1208_ALARM_SECTION_LEN);
+	if (sr < 0) {
 		dev_err(&client->dev, "%s: reading alarm section failed\n",
 			__func__);
-		return -EIO;
+		return sr;
 	}
 
 	/* MSB of each alarm register is an enable bit */
@@ -333,30 +346,34 @@ static int isl1208_i2c_set_time(struct i
 
 	regs[ISL1208_REG_DW] = BIN2BCD(tm->tm_wday & 7);
 
-	if ((sr = isl1208_i2c_get_sr(client)) < 0) {
+	sr = isl1208_i2c_get_sr(client);
+	if (sr < 0) {
 		dev_err(&client->dev, "%s: reading SR failed\n", __func__);
-		return -EIO;
+		return sr;
 	}
 
 	/* set WRTC */
-	if (i2c_smbus_write_byte_data (client, ISL1208_REG_SR,
-				       sr | ISL1208_REG_SR_WRTC) < 0) {
+	sr = i2c_smbus_write_byte_data (client, ISL1208_REG_SR,
+				       sr | ISL1208_REG_SR_WRTC);
+	if (sr < 0) {
 		dev_err(&client->dev, "%s: writing SR failed\n", __func__);
-		return -EIO;
+		return sr;
 	}
 
 	/* write RTC registers */
-	if (isl1208_i2c_set_regs(client, 0, regs, ISL1208_RTC_SECTION_LEN)) {
+	sr = isl1208_i2c_set_regs(client, 0, regs, ISL1208_RTC_SECTION_LEN);
+	if (sr < 0) {
 		dev_err(&client->dev, "%s: writing RTC section failed\n",
 			__func__);
-		return -EIO;
+		return sr;
 	}
 
 	/* clear WRTC again */
-	if (i2c_smbus_write_byte_data (client, ISL1208_REG_SR,
-				       sr & ~ISL1208_REG_SR_WRTC) < 0) {
+	sr = i2c_smbus_write_byte_data (client, ISL1208_REG_SR,
+				       sr & ~ISL1208_REG_SR_WRTC);
+	if (sr < 0) {
 		dev_err(&client->dev, "%s: writing SR failed\n", __func__);
-		return -EIO;
+		return sr;
 	}
 
 	return 0;
@@ -389,8 +406,9 @@ static ssize_t isl1208_sysfs_show_atrim(
 {
 	int atr;
 
-	if ((atr = isl1208_i2c_get_atr(to_i2c_client(dev))) == -1)
-		return -EIO;
+	atr = isl1208_i2c_get_atr(to_i2c_client(dev));
+	if (atr < 0)
+		return atr;
 
 	return sprintf(buf, "%d.%.2d pF\n", atr>>2, (atr&0x3)*25);
 }
@@ -402,8 +420,9 @@ static ssize_t isl1208_sysfs_show_dtrim(
 {
 	int dtr;
 
-	if ((dtr = isl1208_i2c_get_dtr(to_i2c_client(dev))) == -1)
-		return -EIO;
+	dtr = isl1208_i2c_get_dtr(to_i2c_client(dev));
+	if (dtr < 0)
+		return dtr;
 
 	return sprintf(buf, "%d ppm\n", dtr);
 }
@@ -415,8 +434,9 @@ static ssize_t isl1208_sysfs_show_usr(st
 {
 	int usr;
 
-	if ((usr = isl1208_i2c_get_usr(to_i2c_client(dev))) < 0)
-		return -EIO;
+	usr = isl1208_i2c_get_usr(to_i2c_client(dev));
+	if (usr < 0)
+		return usr;
 
 	return sprintf(buf, "0x%.4x\n", usr);
 }
@@ -430,10 +450,10 @@ static ssize_t isl1208_sysfs_store_usr(s
 	if (buf[0] == '0' && (buf[1] == 'x' || buf[1] == 'X')) {
 		if (sscanf(buf, "%x", &usr) != 1)
 			return -EINVAL;
-	}
-	else
+	} else {
 		if (sscanf(buf, "%d", &usr) != 1)
 			return -EINVAL;
+	}
 
 	if (usr < 0 || usr > 0xffff)
 		return -EINVAL;
@@ -444,7 +464,7 @@ static DEVICE_ATTR(usr, S_IRUGO | S_IWUS
 		   isl1208_sysfs_store_usr);
 
 static int
-isl1208_probe (struct i2c_adapter *adapter, int addr, int kind)
+isl1208_probe(struct i2c_adapter *adapter, int addr, int kind)
 {
 	int rc = 0;
 	struct i2c_client *new_client = NULL;
@@ -455,7 +475,8 @@ isl1208_probe (struct i2c_adapter *adapt
 		goto failout;
 	}
 
-	if (!(new_client = kzalloc(sizeof(struct i2c_client), GFP_KERNEL))) {
+	new_client = kzalloc(sizeof(struct i2c_client), GFP_KERNEL);
+	if (new_client == NULL) {
 		rc = -ENOMEM;
 		goto failout;
 	}
@@ -464,14 +485,16 @@ isl1208_probe (struct i2c_adapter *adapt
 	new_client->adapter = adapter;
 	new_client->driver = &isl1208_driver;
 	new_client->flags = 0;
-	strcpy (new_client->name, DRV_NAME);
+	strcpy(new_client->name, DRV_NAME);
 
 	if (kind < 0) {
-		if ((rc = isl1208_i2c_validate_client(new_client)) < 0)
+		rc = isl1208_i2c_validate_client(new_client);
+		if (rc < 0)
 			goto failout;
 	}
 
-	if ((rc = i2c_attach_client(new_client)))
+	rc = i2c_attach_client(new_client);
+	if (rc < 0)
 		goto failout;
 
 	dev_info(&new_client->dev,
@@ -488,7 +511,8 @@ isl1208_probe (struct i2c_adapter *adapt
 
 	i2c_set_clientdata(new_client, rtc);
 
-	if ((rc = isl1208_i2c_get_sr (new_client)) < 0) {
+	rc = isl1208_i2c_get_sr(new_client);
+	if (rc < 0) {
 		dev_err(&new_client->dev, "reading status failed\n");
 		goto failout_unregister;
 	}
@@ -497,12 +521,22 @@ isl1208_probe (struct i2c_adapter *adapt
 		dev_warn(&new_client->dev, "rtc power failure detected, "
 			 "please set clock.\n");
 
-	device_create_file(&new_client->dev, &dev_attr_atrim);
-	device_create_file(&new_client->dev, &dev_attr_dtrim);
-	device_create_file(&new_client->dev, &dev_attr_usr);
+	rc = device_create_file(&new_client->dev, &dev_attr_atrim);
+	if (rc < 0)
+		goto failout_unregister;
+	rc = device_create_file(&new_client->dev, &dev_attr_dtrim);
+	if (rc < 0)
+		goto failout_atrim;
+	rc = device_create_file(&new_client->dev, &dev_attr_usr);
+	if (rc < 0)
+		goto failout_dtrim;
 
 	return 0;
 
+ failout_dtrim:
+	device_remove_file(&new_client->dev, &dev_attr_dtrim);
+ failout_atrim:
+	device_remove_file(&new_client->dev, &dev_attr_atrim);
  failout_unregister:
 	rtc_device_unregister(rtc);
  failout_detach:
@@ -515,7 +549,7 @@ isl1208_probe (struct i2c_adapter *adapt
 static int
 isl1208_attach_adapter (struct i2c_adapter *adapter)
 {
-	return i2c_probe (adapter, &addr_data, isl1208_probe);
+	return i2c_probe(adapter, &addr_data, isl1208_probe);
 }
 
 static int
@@ -527,7 +561,8 @@ isl1208_detach_client(struct i2c_client 
 	if (rtc)
 		rtc_device_unregister(rtc); /* do we need to kfree? */
 
-	if ((rc = i2c_detach_client(client)))
+	rc = i2c_detach_client(client);
+	if (rc)
 		return rc;
 
 	kfree(client);
diff -puN include/linux/i2c-id.h~rtc-subsystem-add-isl1208-support-tweaks include/linux/i2c-id.h
_

