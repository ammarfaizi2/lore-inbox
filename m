Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262682AbUKLXvH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262682AbUKLXvH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Nov 2004 18:51:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262722AbUKLXsO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Nov 2004 18:48:14 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.102]:58001 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262717AbUKLX0w convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Nov 2004 18:26:52 -0500
Subject: Re: [PATCH] I2C fixes for 2.6.10-rc1
In-Reply-To: <11003020051927@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 12 Nov 2004 15:26:45 -0800
Message-Id: <11003020051859@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.2096, 2004/11/12 13:21:22-08:00, paubert@iram.es

[PATCH] I2C: Recent I2C "dead code removal" breaks pmac sound.

> Put the function back, and change the pmac.h file to delete the #define,
> and replace the snd_pmac_keywest_write function with a real call to
> i2c_smbus_write_block_data so things like this don't happen again.
>
> Care to write a patch to do this?

It follows, along with an update of the include/linux/i2c.h to only
declare functions that actually exist, but grepping the whole sound
subtree shows that at least sound/oss/dmasound/tas_common.h defines
a few inline functions that call i2c_smbus_write_{byte,block}_data.


[I2C part]
Ressuscitate i2c_smbus_write_block_data since it's actually
used. Update include/linux/i2c.h to reflect the existing
functions.

[Sound part]
Remove snd_pmac_keywest_write* wrapper macros and directly
call the i2c_smbus_* functions instead.

Signed-off-by: Gabriel Paubert <paubert@iram.es>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


===== include/linux/i2c.h 1.41 vs edited =====


 drivers/i2c/i2c-core.c |   17 +++++++++++++++++
 include/linux/i2c.h    |   16 ++++------------
 sound/ppc/daca.c       |   24 +++++++++++++-----------
 sound/ppc/pmac.h       |    2 --
 sound/ppc/tumbler.c    |   41 +++++++++++++++++++++++------------------
 5 files changed, 57 insertions(+), 43 deletions(-)


diff -Nru a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
--- a/drivers/i2c/i2c-core.c	2004-11-12 15:22:30 -08:00
+++ b/drivers/i2c/i2c-core.c	2004-11-12 15:22:30 -08:00
@@ -1021,6 +1021,22 @@
 	                      I2C_SMBUS_WORD_DATA,&data);
 }
 
+/* Returns the number of bytes transferred */
+s32 i2c_smbus_write_block_data(struct i2c_client *client, u8 command,
+			       u8 length, u8 *values)
+{
+	union i2c_smbus_data data;
+	int i;
+	if (length > I2C_SMBUS_BLOCK_MAX)
+		length = I2C_SMBUS_BLOCK_MAX;
+	for (i = 1; i <= length; i++)
+		data.block[i] = values[i-1];
+	data.block[0] = length;
+	return i2c_smbus_xfer(client->adapter,client->addr,client->flags,
+			      I2C_SMBUS_WRITE,command,
+			      I2C_SMBUS_BLOCK_DATA,&data);
+}
+
 /* Returns the number of read bytes */
 s32 i2c_smbus_block_process_call(struct i2c_client *client, u8 command, u8 length, u8 *values)
 {
@@ -1279,6 +1295,7 @@
 EXPORT_SYMBOL(i2c_smbus_write_byte_data);
 EXPORT_SYMBOL(i2c_smbus_read_word_data);
 EXPORT_SYMBOL(i2c_smbus_write_word_data);
+EXPORT_SYMBOL(i2c_smbus_write_block_data);
 EXPORT_SYMBOL(i2c_smbus_read_i2c_block_data);
 
 EXPORT_SYMBOL(i2c_get_functionality);
diff -Nru a/include/linux/i2c.h b/include/linux/i2c.h
--- a/include/linux/i2c.h	2004-11-12 15:22:30 -08:00
+++ b/include/linux/i2c.h	2004-11-12 15:22:30 -08:00
@@ -88,20 +88,12 @@
 extern s32 i2c_smbus_read_word_data(struct i2c_client * client, u8 command);
 extern s32 i2c_smbus_write_word_data(struct i2c_client * client,
                                      u8 command, u16 value);
-extern s32 i2c_smbus_process_call(struct i2c_client * client,
-                                  u8 command, u16 value);
-/* Returns the number of read bytes */
-extern s32 i2c_smbus_read_block_data(struct i2c_client * client,
-                                     u8 command, u8 *values);
+/* Returns the number of bytes transferred */
 extern s32 i2c_smbus_write_block_data(struct i2c_client * client,
-                                      u8 command, u8 length,
-                                      u8 *values);
+				      u8 command, u8 length,
+				      u8 *values);
 extern s32 i2c_smbus_read_i2c_block_data(struct i2c_client * client,
-                                         u8 command, u8 *values);
-extern s32 i2c_smbus_write_i2c_block_data(struct i2c_client * client,
-                                          u8 command, u8 length,
-                                          u8 *values);
-
+					 u8 command, u8 *values);
 
 /*
  * A driver is capable of handling one or more physical devices present on
diff -Nru a/sound/ppc/daca.c b/sound/ppc/daca.c
--- a/sound/ppc/daca.c	2004-11-12 15:22:30 -08:00
+++ b/sound/ppc/daca.c	2004-11-12 15:22:30 -08:00
@@ -56,10 +56,11 @@
 	unsigned short wdata = 0x00;
 	/* SR: no swap, 1bit delay, 32-48kHz */
 	/* GCFG: power amp inverted, DAC on */
-	if (snd_pmac_keywest_write_byte(i2c, DACA_REG_SR, 0x08) < 0 ||
-	    snd_pmac_keywest_write_byte(i2c, DACA_REG_GCFG, 0x05) < 0)
+	if (i2c_smbus_write_byte_data(i2c->client, DACA_REG_SR, 0x08) < 0 ||
+	    i2c_smbus_write_byte_data(i2c->client, DACA_REG_GCFG, 0x05) < 0)
 		return -EINVAL;
-	return snd_pmac_keywest_write(i2c, DACA_REG_AVOL, 2, (unsigned char*)&wdata);
+	return i2c_smbus_write_block_data(i2c->client, DACA_REG_AVOL,
+					  2, (unsigned char*)&wdata);
 }
 
 /*
@@ -81,9 +82,10 @@
 	else
 		data[1] = mix->right_vol;
 	data[1] |= mix->deemphasis ? 0x40 : 0;
-	if (snd_pmac_keywest_write(&mix->i2c, DACA_REG_AVOL, 2, data) < 0) {
-		snd_printk("failed to set volume \n");  
-		return -EINVAL; 
+	if (i2c_smbus_write_block_data(mix->i2c.client, DACA_REG_AVOL,
+				       2, data) < 0) {
+		snd_printk("failed to set volume \n");
+		return -EINVAL;
 	}
 	return 0;
 }
@@ -188,8 +190,8 @@
 	change = mix->amp_on != ucontrol->value.integer.value[0];
 	if (change) {
 		mix->amp_on = ucontrol->value.integer.value[0];
-		snd_pmac_keywest_write_byte(&mix->i2c, DACA_REG_GCFG,
-					    mix->amp_on ? 0x05 : 0x04);
+		i2c_smbus_write_byte_data(mix->i2c.client, DACA_REG_GCFG,
+					  mix->amp_on ? 0x05 : 0x04);
 	}
 	return change;
 }
@@ -220,9 +222,9 @@
 static void daca_resume(pmac_t *chip)
 {
 	pmac_daca_t *mix = chip->mixer_data;
-	snd_pmac_keywest_write_byte(&mix->i2c, DACA_REG_SR, 0x08);
-	snd_pmac_keywest_write_byte(&mix->i2c, DACA_REG_GCFG,
-				    mix->amp_on ? 0x05 : 0x04);
+	i2c_smbus_write_byte_data(mix->i2c.client, DACA_REG_SR, 0x08);
+	i2c_smbus_write_byte_data(mix->i2c.client, DACA_REG_GCFG,
+				  mix->amp_on ? 0x05 : 0x04);
 	daca_set_volume(mix);
 }
 #endif /* CONFIG_PMAC_PBOOK */
diff -Nru a/sound/ppc/pmac.h b/sound/ppc/pmac.h
--- a/sound/ppc/pmac.h	2004-11-12 15:22:30 -08:00
+++ b/sound/ppc/pmac.h	2004-11-12 15:22:30 -08:00
@@ -199,8 +199,6 @@
 
 int snd_pmac_keywest_init(pmac_keywest_t *i2c);
 void snd_pmac_keywest_cleanup(pmac_keywest_t *i2c);
-#define snd_pmac_keywest_write(i2c,cmd,len,data) i2c_smbus_write_block_data((i2c)->client, cmd, len, data)
-#define snd_pmac_keywest_write_byte(i2c,cmd,data) i2c_smbus_write_byte_data((i2c)->client, cmd, data)
 
 /* misc */
 int snd_pmac_boolean_stereo_info(snd_kcontrol_t *kcontrol, snd_ctl_elem_info_t *uinfo);
diff -Nru a/sound/ppc/tumbler.c b/sound/ppc/tumbler.c
--- a/sound/ppc/tumbler.c	2004-11-12 15:22:30 -08:00
+++ b/sound/ppc/tumbler.c	2004-11-12 15:22:30 -08:00
@@ -109,7 +109,8 @@
 	while (*regs > 0) {
 		int err, count = 10;
 		do {
-			err =  snd_pmac_keywest_write_byte(i2c, regs[0], regs[1]);
+			err = i2c_smbus_write_byte_data(i2c->client,
+							regs[0], regs[1]);
 			if (err >= 0)
 				break;
 			mdelay(10);
@@ -220,9 +221,10 @@
 	block[4] = (right_vol >> 8)  & 0xff;
 	block[5] = (right_vol >> 0)  & 0xff;
   
-	if (snd_pmac_keywest_write(&mix->i2c, TAS_REG_VOL, 6, block) < 0) {
-		snd_printk("failed to set volume \n");  
-		return -EINVAL; 
+	if (i2c_smbus_write_block_data(mix->i2c.client, TAS_REG_VOL,
+				       6, block) < 0) {
+		snd_printk("failed to set volume \n");
+		return -EINVAL;
 	}
 	return 0;
 }
@@ -320,9 +322,10 @@
 		val[1] = 0;
 	}
 
-	if (snd_pmac_keywest_write(&mix->i2c, TAS_REG_DRC, 2, val) < 0) {
-		snd_printk("failed to set DRC\n");  
-		return -EINVAL; 
+	if (i2c_smbus_write_block_data(mix->i2c.client, TAS_REG_DRC,
+				       2, val) < 0) {
+		snd_printk("failed to set DRC\n");
+		return -EINVAL;
 	}
 	return 0;
 }
@@ -355,9 +358,10 @@
 	val[4] = 0x60;
 	val[5] = 0xa0;
 
-	if (snd_pmac_keywest_write(&mix->i2c, TAS_REG_DRC, 6, val) < 0) {
-		snd_printk("failed to set DRC\n");  
-		return -EINVAL; 
+	if (i2c_smbus_write_block_data(mix->i2c.client, TAS_REG_DRC,
+				       6, val) < 0) {
+		snd_printk("failed to set DRC\n");
+		return -EINVAL;
 	}
 	return 0;
 }
@@ -459,9 +463,10 @@
 	vol = info->table[vol];
 	for (i = 0; i < info->bytes; i++)
 		block[i] = (vol >> ((info->bytes - i - 1) * 8)) & 0xff;
-	if (snd_pmac_keywest_write(&mix->i2c, info->reg, info->bytes, block) < 0) {
-		snd_printk("failed to set mono volume %d\n", info->index);  
-		return -EINVAL; 
+	if (i2c_smbus_write_block_data(mix->i2c.client, info->reg,
+				       info->bytes, block) < 0) {
+		snd_printk("failed to set mono volume %d\n", info->index);
+		return -EINVAL;
 	}
 	return 0;
 }
@@ -588,9 +593,9 @@
 		for (j = 0; j < 3; j++)
 			block[i * 3 + j] = (vol >> ((2 - j) * 8)) & 0xff;
 	}
-	if (snd_pmac_keywest_write(&mix->i2c, reg, 9, block) < 0) {
-		snd_printk("failed to set mono volume %d\n", reg);  
-		return -EINVAL; 
+	if (i2c_smbus_write_block_data(mix->i2c.client, reg, 9, block) < 0) {
+		snd_printk("failed to set mono volume %d\n", reg);
+		return -EINVAL;
 	}
 	return 0;
 }
@@ -689,8 +694,8 @@
 {
 	if (! mix->i2c.client)
 		return -ENODEV;
-	return snd_pmac_keywest_write_byte(&mix->i2c, TAS_REG_ACS,
-					   mix->capture_source ? 2 : 0);
+	return i2c_smbus_write_byte_data(mix->i2c.client, TAS_REG_ACS,
+					 mix->capture_source ? 2 : 0);
 }
 
 static int snapper_info_capture_source(snd_kcontrol_t *kcontrol, snd_ctl_elem_info_t *uinfo)

