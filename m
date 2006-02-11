Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932321AbWBKP2a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932321AbWBKP2a (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Feb 2006 10:28:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932322AbWBKP2a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Feb 2006 10:28:30 -0500
Received: from smtp-106-saturday.noc.nerim.net ([62.4.17.106]:27403 "EHLO
	mallaury.nerim.net") by vger.kernel.org with ESMTP id S932321AbWBKP2a
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Feb 2006 10:28:30 -0500
Date: Sat, 11 Feb 2006 16:28:37 +0100
From: Jean Delvare <khali@linux-fr.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, Petr Vandrovec <vandrove@vc.cvut.cz>
Subject: [PATCH] matrox maven: memory allocation and other cleanups
Message-Id: <20060211162837.43e72830.khali@linux-fr.org>
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.6.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A few cleanups which were done to almost all i2c drivers some times
ago, but matroxfb_maven was forgotten:
* Don't allocate two different structures at once.
* Use kzalloc instead of kmalloc+memset.
* Use strlcpy instead of strcpy.
* Drop duplicate error message on client deregistration failure.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Cc: Petr Vandrovec <vandrove@vc.cvut.cz>
---

This needs testing!

Andrew, please include in next -mm. Thanks.

 drivers/video/matrox/matroxfb_maven.c |   55 +++++++++++++++------------------
 1 file changed, 25 insertions(+), 30 deletions(-)

--- linux-2.6.16-rc2.orig/drivers/video/matrox/matroxfb_maven.c	2006-02-11 14:54:33.000000000 +0100
+++ linux-2.6.16-rc2/drivers/video/matrox/matroxfb_maven.c	2006-02-11 14:55:49.000000000 +0100
@@ -129,7 +129,7 @@
 
 struct maven_data {
 	struct matrox_fb_info*		primary_head;
-	struct i2c_client*		client;
+	struct i2c_client		client;
 	int				version;
 };
 
@@ -970,7 +970,7 @@
 
 static int maven_program_timming(struct maven_data* md,
 		const struct mavenregs* m) {
-	struct i2c_client* c = md->client;
+	struct i2c_client* c = &md->client;
 
 	if (m->mode == MATROXFB_OUTPUT_MODE_MONITOR) {
 		LR(0x80);
@@ -1007,7 +1007,7 @@
 }
 
 static inline int maven_resync(struct maven_data* md) {
-	struct i2c_client* c = md->client;
+	struct i2c_client* c = &md->client;
 	maven_set_reg(c, 0x95, 0x20);	/* start whole thing */
 	return 0;
 }
@@ -1065,48 +1065,48 @@
 		  maven_compute_bwlevel(md, &blacklevel, &whitelevel);
 		  blacklevel = (blacklevel >> 2) | ((blacklevel & 3) << 8);
 		  whitelevel = (whitelevel >> 2) | ((whitelevel & 3) << 8);
-		  maven_set_reg_pair(md->client, 0x0e, blacklevel);
-		  maven_set_reg_pair(md->client, 0x1e, whitelevel);
+		  maven_set_reg_pair(&md->client, 0x0e, blacklevel);
+		  maven_set_reg_pair(&md->client, 0x1e, whitelevel);
 		}
 		break;
 		case V4L2_CID_SATURATION:
 		{
-		  maven_set_reg(md->client, 0x20, p->value);
-		  maven_set_reg(md->client, 0x22, p->value);
+		  maven_set_reg(&md->client, 0x20, p->value);
+		  maven_set_reg(&md->client, 0x22, p->value);
 		}
 		break;
 		case V4L2_CID_HUE:
 		{
-		  maven_set_reg(md->client, 0x25, p->value);
+		  maven_set_reg(&md->client, 0x25, p->value);
 		}
 		break;
 		case V4L2_CID_GAMMA:
 		{
 		  const struct maven_gamma* g;
 		  g = maven_compute_gamma(md);
-		  maven_set_reg(md->client, 0x83, g->reg83);
-		  maven_set_reg(md->client, 0x84, g->reg84);
-		  maven_set_reg(md->client, 0x85, g->reg85);
-		  maven_set_reg(md->client, 0x86, g->reg86);
-		  maven_set_reg(md->client, 0x87, g->reg87);
-		  maven_set_reg(md->client, 0x88, g->reg88);
-		  maven_set_reg(md->client, 0x89, g->reg89);
-		  maven_set_reg(md->client, 0x8a, g->reg8a);
-		  maven_set_reg(md->client, 0x8b, g->reg8b);
+		  maven_set_reg(&md->client, 0x83, g->reg83);
+		  maven_set_reg(&md->client, 0x84, g->reg84);
+		  maven_set_reg(&md->client, 0x85, g->reg85);
+		  maven_set_reg(&md->client, 0x86, g->reg86);
+		  maven_set_reg(&md->client, 0x87, g->reg87);
+		  maven_set_reg(&md->client, 0x88, g->reg88);
+		  maven_set_reg(&md->client, 0x89, g->reg89);
+		  maven_set_reg(&md->client, 0x8a, g->reg8a);
+		  maven_set_reg(&md->client, 0x8b, g->reg8b);
 		}
 		break;
 		case MATROXFB_CID_TESTOUT:
 		{
 			unsigned char val 
-			  = maven_get_reg (md->client,0x8d);
+			  = maven_get_reg(&md->client,0x8d);
 			if (p->value) val |= 0x10;
 			else          val &= ~0x10;
-			maven_set_reg (md->client, 0x8d, val);
+			maven_set_reg(&md->client, 0x8d, val);
 		}
 		break;
 		case MATROXFB_CID_DEFLICKER:
 		{
-		  maven_set_reg(md->client, 0x93, maven_compute_deflicker(md));
+		  maven_set_reg(&md->client, 0x93, maven_compute_deflicker(md));
 		}
 		break;
 	}
@@ -1185,7 +1185,6 @@
 	MINFO_FROM(container_of(clnt->adapter, struct i2c_bit_adapter, adapter)->minfo);
 
 	md->primary_head = MINFO;
-	md->client = clnt;
 	down_write(&ACCESS_FBINFO(altout.lock));
 	ACCESS_FBINFO(outputs[1]).output = &maven_altout;
 	ACCESS_FBINFO(outputs[1]).src = ACCESS_FBINFO(outputs[1]).default_src;
@@ -1243,19 +1242,17 @@
 					      I2C_FUNC_SMBUS_BYTE_DATA |
 					      I2C_FUNC_PROTOCOL_MANGLING))
 		goto ERROR0;
-	if (!(new_client = (struct i2c_client*)kmalloc(sizeof(*new_client) + sizeof(*data),
-			GFP_KERNEL))) {
+	if (!(data = kzalloc(sizeof(*data), GFP_KERNEL))) {
 		err = -ENOMEM;
 		goto ERROR0;
 	}
-	memset(new_client, 0, sizeof(*new_client) + sizeof(*data));
-	data = (struct maven_data*)(new_client + 1);
+	new_client = &data->client;
 	i2c_set_clientdata(new_client, data);
 	new_client->addr = address;
 	new_client->adapter = adapter;
 	new_client->driver = &maven_driver;
 	new_client->flags = 0;
-	strcpy(new_client->name, "maven client");
+	strlcpy(new_client->name, "maven", I2C_NAME_SIZE);
 	if ((err = i2c_attach_client(new_client)))
 		goto ERROR3;
 	err = maven_init_client(new_client);
@@ -1279,12 +1276,10 @@
 static int maven_detach_client(struct i2c_client* client) {
 	int err;
 
-	if ((err = i2c_detach_client(client))) {
-		printk(KERN_ERR "maven: Cannot deregister client\n");
+	if ((err = i2c_detach_client(client)))
 		return err;
-	}
 	maven_shutdown_client(client);
-	kfree(client);
+	kfree(i2c_get_clientdata(client));
 	return 0;
 }
 


-- 
Jean Delvare
