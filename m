Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261373AbUKIF1w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261373AbUKIF1w (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 00:27:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261370AbUKIF0w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 00:26:52 -0500
Received: from mail.kroah.org ([69.55.234.183]:51358 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261373AbUKIFYx convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 00:24:53 -0500
Subject: Re: [PATCH] I2C update for 2.6.10-rc1
In-Reply-To: <10999778563058@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 8 Nov 2004 21:24:16 -0800
Message-Id: <10999778563792@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.2014.1.17, 2004/11/08 16:36:33-08:00, greg@kroah.com

I2C: fix i2c_detect to allow NULL fields in adapter address structure.

Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/i2c/i2c-sensor-detect.c |   52 +++++++++++++++++++++++++++-------------
 1 files changed, 36 insertions(+), 16 deletions(-)


diff -Nru a/drivers/i2c/i2c-sensor-detect.c b/drivers/i2c/i2c-sensor-detect.c
--- a/drivers/i2c/i2c-sensor-detect.c	2004-11-08 18:55:00 -08:00
+++ b/drivers/i2c/i2c-sensor-detect.c	2004-11-08 18:55:00 -08:00
@@ -31,6 +31,8 @@
 #include <linux/i2c-sensor.h>
 #include <asm/uaccess.h>
 
+static unsigned short empty[] = {I2C_CLIENT_END};
+static unsigned int empty_isa[] = {I2C_CLIENT_ISA_END};
 
 /* Very inefficient for ISA detects, and won't work for 10-bit addresses! */
 int i2c_detect(struct i2c_adapter *adapter,
@@ -42,11 +44,30 @@
 	int is_isa = i2c_is_isa_adapter(adapter);
 	int adapter_id =
 	    is_isa ? ANY_I2C_ISA_BUS : i2c_adapter_id(adapter);
+	unsigned short *normal_i2c;
+	unsigned short *normal_i2c_range;
+	unsigned int *normal_isa;
+	unsigned short *probe;
+	unsigned short *ignore;
 
 	/* Forget it if we can't probe using SMBUS_QUICK */
 	if ((!is_isa) &&
 	    !i2c_check_functionality(adapter, I2C_FUNC_SMBUS_QUICK))
 		return -1;
+	
+	/* Use default "empty" list if the adapter doesn't specify any */
+	normal_i2c = normal_i2c_range = probe = ignore = empty;
+	normal_isa = empty_isa;
+	if (address_data->normal_i2c)
+		normal_i2c = address_data->normal_i2c;
+	if (address_data->normal_i2c_range)
+		normal_i2c_range = address_data->normal_i2c_range;
+	if (address_data->normal_isa)
+		normal_isa = address_data->normal_isa;
+	if (address_data->probe)
+		probe = address_data->probe;
+	if (address_data->ignore)
+		ignore = address_data->ignore;
 
 	for (addr = 0x00; addr <= (is_isa ? 0xffff : 0x7f); addr++) {
 		if (!is_isa && i2c_check_addr(adapter, addr))
@@ -72,11 +93,11 @@
 
 		/* If this address is in one of the ignores, we can forget about it
 		   right now */
-		for (i = 0; !found && (address_data->ignore[i] != I2C_CLIENT_END); i += 2) {
-			if ( ((adapter_id == address_data->ignore[i]) ||
-			      ((address_data->ignore[i] == ANY_I2C_BUS) &&
+		for (i = 0; !found && (ignore[i] != I2C_CLIENT_END); i += 2) {
+			if ( ((adapter_id == ignore[i]) ||
+			      ((ignore[i] == ANY_I2C_BUS) &&
 			       !is_isa)) &&
-			      (addr == address_data->ignore[i + 1])) {
+			      (addr == ignore[i + 1])) {
 				dev_dbg(&adapter->dev, "found ignore parameter for adapter %d, addr %04x\n", adapter_id, addr);
 				found = 1;
 			}
@@ -87,22 +108,22 @@
 		/* Now, we will do a detection, but only if it is in the normal or 
 		   probe entries */
 		if (is_isa) {
-			for (i = 0; !found && (address_data->normal_isa[i] != I2C_CLIENT_ISA_END); i += 1) {
-				if (addr == address_data->normal_isa[i]) {
+			for (i = 0; !found && (normal_isa[i] != I2C_CLIENT_ISA_END); i += 1) {
+				if (addr == normal_isa[i]) {
 					dev_dbg(&adapter->dev, "found normal isa entry for adapter %d, addr %04x\n", adapter_id, addr);
 					found = 1;
 				}
 			}
 		} else {
-			for (i = 0; !found && (address_data->normal_i2c[i] != I2C_CLIENT_END); i += 1) {
-				if (addr == address_data->normal_i2c[i]) {
+			for (i = 0; !found && (normal_i2c[i] != I2C_CLIENT_END); i += 1) {
+				if (addr == normal_i2c[i]) {
 					found = 1;
 					dev_dbg(&adapter->dev, "found normal i2c entry for adapter %d, addr %02x", adapter_id, addr);
 				}
 			}
-			for (i = 0; !found && (address_data->normal_i2c_range[i] != I2C_CLIENT_END); i += 2) {
-				if ((addr >= address_data->normal_i2c_range[i]) &&
-				    (addr <= address_data->normal_i2c_range[i + 1])) {
+			for (i = 0; !found && (normal_i2c_range[i] != I2C_CLIENT_END); i += 2) {
+				if ((addr >= normal_i2c_range[i]) &&
+				    (addr <= normal_i2c_range[i + 1])) {
 					dev_dbg(&adapter->dev, "found normal i2c_range entry for adapter %d, addr %04x\n", adapter_id, addr);
 					found = 1;
 				}
@@ -110,12 +131,11 @@
 		}
 
 		for (i = 0;
-		     !found && (address_data->probe[i] != I2C_CLIENT_END);
+		     !found && (probe[i] != I2C_CLIENT_END);
 		     i += 2) {
-			if (((adapter_id == address_data->probe[i]) ||
-			     ((address_data->
-			       probe[i] == ANY_I2C_BUS) && !is_isa))
-			    && (addr == address_data->probe[i + 1])) {
+			if (((adapter_id == probe[i]) ||
+			     ((probe[i] == ANY_I2C_BUS) && !is_isa))
+			    && (addr == probe[i + 1])) {
 				dev_dbg(&adapter->dev, "found probe parameter for adapter %d, addr %04x\n", adapter_id, addr);
 				found = 1;
 			}

