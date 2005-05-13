Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262585AbVEMWRS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262585AbVEMWRS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 May 2005 18:17:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262584AbVEMWP0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 May 2005 18:15:26 -0400
Received: from ipx10786.ipxserver.de ([80.190.251.108]:64160 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S262573AbVEMWKT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 May 2005 18:10:19 -0400
Message-Id: <20050513220226.215727000@abc>
References: <20050513220019.907667000@abc>
Date: Sat, 14 May 2005 00:00:29 +0200
From: Johannes Stezenbach <js@linuxtv.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Patrick Boettcher <pb@linuxtv.org>
Content-Disposition: inline; filename=dvb-flexcop-i2c.patch
X-SA-Exim-Connect-IP: 217.231.56.126
Subject: [DVB patch 10/11] flexcop: i2c read fixes
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

rewrote the i2c-reading-part (no more ack-error ignoring, which was inherited
from the skystar2-driver)

Signed-off-by: Patrick Boettcher <pb@linuxtv.org>
Signed-off-by: Johannes Stezenbach <js@linuxtv.org>
---

 drivers/media/dvb/b2c2/flexcop-i2c.c |  116 ++++++++++++++++++-----------------
 drivers/media/dvb/b2c2/flexcop-reg.h |    3 
 drivers/media/dvb/b2c2/flexcop.c     |    4 -
 3 files changed, 63 insertions(+), 60 deletions(-)

Index: linux-2.6.12-rc4/drivers/media/dvb/b2c2/flexcop-i2c.c
===================================================================
--- linux-2.6.12-rc4.orig/drivers/media/dvb/b2c2/flexcop-i2c.c	2005-05-12 01:30:04.000000000 +0200
+++ linux-2.6.12-rc4/drivers/media/dvb/b2c2/flexcop-i2c.c	2005-05-12 01:31:10.000000000 +0200
@@ -9,9 +9,9 @@
 
 #define FC_MAX_I2C_RETRIES 100000
 
-static int flexcop_i2c_operation(struct flexcop_device *fc, flexcop_ibi_value *r100, int max_ack_errors)
+static int flexcop_i2c_operation(struct flexcop_device *fc, flexcop_ibi_value *r100)
 {
-	int i,ack_errors = 0;
+	int i;
 	flexcop_ibi_value r;
 
 	r100->tw_sm_c_100.working_start = 1;
@@ -31,11 +31,7 @@ static int flexcop_i2c_operation(struct 
 			}
 		} else {
 			deb_i2c("suffering from an i2c ack_error\n");
-			if (++ack_errors >= max_ack_errors)
-				break;
-
-			fc->write_ibi_reg(fc, tw_sm_c_100, ibi_zero);
-			fc->write_ibi_reg(fc, tw_sm_c_100, *r100);
+			return -EREMOTEIO;
 		}
 	}
 	deb_i2c("tried %d times i2c operation, never finished or too many ack errors.\n",i);
@@ -48,19 +44,30 @@ static int flexcop_i2c_read4(struct flex
 	int len = r100.tw_sm_c_100.total_bytes, /* remember total_bytes is buflen-1 */
 		ret;
 
-	if ((ret = flexcop_i2c_operation(fc,&r100,30)) != 0)
-		return ret;
-
-	r104 = fc->read_ibi_reg(fc,tw_sm_c_104);
-
-	deb_i2c("read: r100: %08x, r104: %08x\n",r100.raw,r104.raw);
+	if ((ret = flexcop_i2c_operation(fc,&r100)) != 0) {
+		/* The Cablestar needs a different kind of i2c-transfer (does not
+		 * support "Repeat Start"):
+		 * wait for the ACK failure,
+		 * and do a subsequent read with the Bit 30 enabled
+		 */
+		r100.tw_sm_c_100.no_base_addr_ack_error = 1;
+		if ((ret = flexcop_i2c_operation(fc,&r100)) != 0) {
+			deb_i2c("no_base_addr read failed. %d\n",ret);
+			return ret;
+		}
+	}
 
-	/* there is at least one byte, otherwise we wouldn't be here */
 	buf[0] = r100.tw_sm_c_100.data1_reg;
 
-	if (len > 0) buf[1] = r104.tw_sm_c_104.data2_reg;
-	if (len > 1) buf[2] = r104.tw_sm_c_104.data3_reg;
-	if (len > 2) buf[3] = r104.tw_sm_c_104.data4_reg;
+	if (len > 0) {
+		r104 = fc->read_ibi_reg(fc,tw_sm_c_104);
+		deb_i2c("read: r100: %08x, r104: %08x\n",r100.raw,r104.raw);
+
+		/* there is at least one more byte, otherwise we wouldn't be here */
+		buf[1] = r104.tw_sm_c_104.data2_reg;
+		if (len > 1) buf[2] = r104.tw_sm_c_104.data3_reg;
+		if (len > 2) buf[3] = r104.tw_sm_c_104.data4_reg;
+	}
 
 	return 0;
 }
@@ -82,9 +89,45 @@ static int flexcop_i2c_write4(struct fle
 
 	/* write the additional i2c data before doing the actual i2c operation */
 	fc->write_ibi_reg(fc,tw_sm_c_104,r104);
+	return flexcop_i2c_operation(fc,&r100);
+}
+
+int flexcop_i2c_request(struct flexcop_device *fc, flexcop_access_op_t op,
+		flexcop_i2c_port_t port, u8 chipaddr, u8 addr, u8 *buf, u16 len)
+{
+	int ret;
+	u16 bytes_to_transfer;
+	flexcop_ibi_value r100;
+
+	deb_i2c("op = %d\n",op);
+	r100.raw = 0;
+	r100.tw_sm_c_100.chipaddr = chipaddr;
+	r100.tw_sm_c_100.twoWS_rw = op;
+	r100.tw_sm_c_100.twoWS_port_reg = port;
+
+	while (len != 0) {
+		bytes_to_transfer = len > 4 ? 4 : len;
+
+		r100.tw_sm_c_100.total_bytes = bytes_to_transfer - 1;
+		r100.tw_sm_c_100.baseaddr = addr;
+
+		if (op == FC_READ)
+			ret = flexcop_i2c_read4(fc, r100, buf);
+		else
+			ret = flexcop_i2c_write4(fc,r100, buf);
+
+		if (ret < 0)
+			return ret;
+
+		buf  += bytes_to_transfer;
+		addr += bytes_to_transfer;
+		len  -= bytes_to_transfer;
+	};
 
-	return flexcop_i2c_operation(fc,&r100,30);
+	return 0;
 }
+/* exported for PCI i2c */
+EXPORT_SYMBOL(flexcop_i2c_request);
 
 /* master xfer callback for demodulator */
 static int flexcop_master_xfer(struct i2c_adapter *i2c_adap, struct i2c_msg msgs[], int num)
@@ -123,43 +166,6 @@ static int flexcop_master_xfer(struct i2
 	return ret;
 }
 
-int flexcop_i2c_request(struct flexcop_device *fc, flexcop_access_op_t op,
-		flexcop_i2c_port_t port, u8 chipaddr, u8 addr, u8 *buf, u16 len)
-{
-	int ret;
-	u16 bytes_to_transfer;
-	flexcop_ibi_value r100;
-
-	deb_i2c("op = %d\n",op);
-	r100.raw = 0;
-	r100.tw_sm_c_100.chipaddr = chipaddr;
-	r100.tw_sm_c_100.twoWS_rw = op;
-	r100.tw_sm_c_100.twoWS_port_reg = port;
-
-	while (len != 0) {
-		bytes_to_transfer = len > 4 ? 4 : len;
-
-		r100.tw_sm_c_100.total_bytes = bytes_to_transfer - 1;
-		r100.tw_sm_c_100.baseaddr = addr;
-
-		if (op == FC_READ)
-			ret = flexcop_i2c_read4(fc, r100, buf);
-		else
-			ret = flexcop_i2c_write4(fc,r100, buf);
-
-		if (ret < 0)
-			return ret;
-
-		buf  += bytes_to_transfer;
-		addr += bytes_to_transfer;
-		len  -= bytes_to_transfer;
-	};
-
-	return 0;
-}
-/* exported for PCI i2c */
-EXPORT_SYMBOL(flexcop_i2c_request);
-
 static u32 flexcop_i2c_func(struct i2c_adapter *adapter)
 {
 	return I2C_FUNC_I2C;
Index: linux-2.6.12-rc4/drivers/media/dvb/b2c2/flexcop-reg.h
===================================================================
--- linux-2.6.12-rc4.orig/drivers/media/dvb/b2c2/flexcop-reg.h	2005-05-12 01:30:04.000000000 +0200
+++ linux-2.6.12-rc4/drivers/media/dvb/b2c2/flexcop-reg.h	2005-05-12 01:31:10.000000000 +0200
@@ -692,9 +692,10 @@ typedef enum {
 	wan_ctrl_reg_71c    = 0x71c,
 } flexcop_ibi_register;
 
-#define flexcop_set_ibi_value(reg,attr,val) \
+#define flexcop_set_ibi_value(reg,attr,val) { \
 	flexcop_ibi_value v = fc->read_ibi_reg(fc,reg); \
 	v.reg.attr = val; \
 	fc->write_ibi_reg(fc,reg,v); \
+}
 
 #endif
Index: linux-2.6.12-rc4/drivers/media/dvb/b2c2/flexcop.c
===================================================================
--- linux-2.6.12-rc4.orig/drivers/media/dvb/b2c2/flexcop.c	2005-05-12 01:30:55.000000000 +0200
+++ linux-2.6.12-rc4/drivers/media/dvb/b2c2/flexcop.c	2005-05-12 01:31:10.000000000 +0200
@@ -184,10 +184,6 @@ static void flexcop_reset(struct flexcop
 	fc->write_ibi_reg(fc,misc_204,v204);
 	v204.misc_204.Per_reset_sig = 1;
 	fc->write_ibi_reg(fc,misc_204,v204);
-
-/*	v208.raw = 0;
-	v208.ctrl_208.Null_filter_sig = 1;
-	fc->write_ibi_reg(fc,ctrl_208,v208);*/
 }
 
 struct flexcop_device *flexcop_device_kmalloc(size_t bus_specific_len)

--

