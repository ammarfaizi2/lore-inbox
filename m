Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265986AbUGOAS6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265986AbUGOAS6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jul 2004 20:18:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266028AbUGOAS6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jul 2004 20:18:58 -0400
Received: from mail.kroah.org ([69.55.234.183]:53483 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265986AbUGOAJD convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jul 2004 20:09:03 -0400
Subject: Re: [PATCH] I2C update for 2.6.8-rc1
In-Reply-To: <10898500203140@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Wed, 14 Jul 2004 17:07:06 -0700
Message-Id: <10898500251206@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1784.13.2, 2004/07/08 16:06:22-07:00, ebs@ebshome.net

[PATCH] I2C PPC4xx IIC driver: 0-length transactions bit-banging implementation

IBM PPC 4xx i2c controller doesn't support 0-length transactions (e.g. used by
SMBUS_QUICK). This patch implements bit-banging emulation for such requests and
removes temporary kludge added earlier.

Signed-off-by: Eugene Surovegin <ebs@ebshome.net>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/i2c/busses/i2c-ibm_iic.c |  132 +++++++++++++++++++++++++++++++++++++--
 1 files changed, 126 insertions(+), 6 deletions(-)


diff -Nru a/drivers/i2c/busses/i2c-ibm_iic.c b/drivers/i2c/busses/i2c-ibm_iic.c
--- a/drivers/i2c/busses/i2c-ibm_iic.c	2004-07-14 17:00:40 -07:00
+++ b/drivers/i2c/busses/i2c-ibm_iic.c	2004-07-14 17:00:40 -07:00
@@ -45,7 +45,7 @@
 
 #include "i2c-ibm_iic.h"
 
-#define DRIVER_VERSION "2.01"
+#define DRIVER_VERSION "2.1"
 
 MODULE_DESCRIPTION("IBM IIC driver v" DRIVER_VERSION);
 MODULE_LICENSE("GPL");
@@ -96,6 +96,31 @@
 #  define DUMP_REGS(h,dev)	((void)0)
 #endif
 
+/* Bus timings (in ns) for bit-banging */
+static struct i2c_timings {
+	unsigned int hd_sta;
+	unsigned int su_sto;
+	unsigned int low;
+	unsigned int high;
+	unsigned int buf;
+} timings [] = {
+/* Standard mode (100 KHz) */
+{
+	.hd_sta	= 4000,
+	.su_sto	= 4000,
+	.low	= 4700,
+	.high	= 4000,
+	.buf	= 4700,
+},
+/* Fast mode (400 KHz) */
+{
+	.hd_sta = 600,
+	.su_sto	= 600,
+	.low 	= 1300,
+	.high 	= 600,
+	.buf	= 1300,
+}};
+
 /* Enable/disable interrupt generation */
 static inline void iic_interrupt_mode(struct ibm_iic_private* dev, int enable)
 {
@@ -196,6 +221,104 @@
 }
 
 /*
+ * Do 0-length transaction using bit-banging through IIC_DIRECTCNTL register.
+ */
+
+/* Wait for SCL and/or SDA to be high */
+static int iic_dc_wait(volatile struct iic_regs *iic, u8 mask)
+{
+	unsigned long x = jiffies + HZ / 28 + 2;
+	while ((in_8(&iic->directcntl) & mask) != mask){
+		if (unlikely(time_after(jiffies, x)))
+			return -1;
+		cond_resched();
+	}
+	return 0;
+}
+
+static int iic_smbus_quick(struct ibm_iic_private* dev, const struct i2c_msg* p)
+{
+	volatile struct iic_regs* iic = dev->vaddr;
+	const struct i2c_timings* t = &timings[dev->fast_mode ? 1 : 0];
+	u8 mask, v, sda;
+	int i, res;
+
+	/* Only 7-bit addresses are supported */
+	if (unlikely(p->flags & I2C_M_TEN)){
+		DBG("%d: smbus_quick - 10 bit addresses are not supported\n",
+			dev->idx);
+		return -EINVAL;
+	}
+
+	DBG("%d: smbus_quick(0x%02x)\n", dev->idx, p->addr);
+
+	/* Reset IIC interface */
+	out_8(&iic->xtcntlss, XTCNTLSS_SRST);
+
+	/* Wait for bus to become free */
+	out_8(&iic->directcntl, DIRCNTL_SDAC | DIRCNTL_SCC);
+	if (unlikely(iic_dc_wait(iic, DIRCNTL_MSDA | DIRCNTL_MSC)))
+		goto err;
+	ndelay(t->buf);
+
+	/* START */
+	out_8(&iic->directcntl, DIRCNTL_SCC);
+	sda = 0;
+	ndelay(t->hd_sta);
+
+	/* Send address */
+	v = (u8)((p->addr << 1) | ((p->flags & I2C_M_RD) ? 1 : 0));
+	for (i = 0, mask = 0x80; i < 8; ++i, mask >>= 1){
+		out_8(&iic->directcntl, sda);
+		ndelay(t->low / 2);
+		sda = (v & mask) ? DIRCNTL_SDAC : 0;
+		out_8(&iic->directcntl, sda);
+		ndelay(t->low / 2);
+
+		out_8(&iic->directcntl, DIRCNTL_SCC | sda);
+		if (unlikely(iic_dc_wait(iic, DIRCNTL_MSC)))
+			goto err;
+		ndelay(t->high);
+	}
+
+	/* ACK */
+	out_8(&iic->directcntl, sda);
+	ndelay(t->low / 2);
+	out_8(&iic->directcntl, DIRCNTL_SDAC);
+	ndelay(t->low / 2);
+	out_8(&iic->directcntl, DIRCNTL_SDAC | DIRCNTL_SCC);
+	if (unlikely(iic_dc_wait(iic, DIRCNTL_MSC)))
+		goto err;
+	res = (in_8(&iic->directcntl) & DIRCNTL_MSDA) ? -EREMOTEIO : 1;
+	ndelay(t->high);
+
+	/* STOP */
+	out_8(&iic->directcntl, 0);
+	ndelay(t->low);
+	out_8(&iic->directcntl, DIRCNTL_SCC);
+	if (unlikely(iic_dc_wait(iic, DIRCNTL_MSC)))
+		goto err;
+	ndelay(t->su_sto);
+	out_8(&iic->directcntl, DIRCNTL_SDAC | DIRCNTL_SCC);
+
+	ndelay(t->buf);
+
+	DBG("%d: smbus_quick -> %s\n", dev->idx, res ? "NACK" : "ACK");
+out:
+	/* Remove reset */
+	out_8(&iic->xtcntlss, 0);
+
+	/* Reinitialize interface */
+	iic_dev_init(dev);
+
+	return res;
+err:
+	DBG("%d: smbus_quick - bus is stuck\n", dev->idx);
+	res = -EREMOTEIO;
+	goto out;
+}
+
+/*
  * IIC interrupt handler
  */
 static irqreturn_t iic_handler(int irq, void *dev_id, struct pt_regs *regs)
@@ -457,13 +580,10 @@
 		if (unlikely(msgs[i].len <= 0)){
 			if (num == 1 && !msgs[0].len){
 				/* Special case for I2C_SMBUS_QUICK emulation.
-				 * Although this logic is FAR FROM PERFECT, this 
-				 * is what previous driver version did.
 				 * IBM IIC doesn't support 0-length transactions
-				 * (except bit-banging through IICx_DIRECTCNTL).
+				 * so we have to emulate them using bit-banging.
 				 */
-				DBG("%d: zero-length msg kludge\n", dev->idx); 
-				return 0;
+				return iic_smbus_quick(dev, &msgs[0]);
 			}
 			DBG("%d: invalid len %d in msg[%d]\n", dev->idx, 
 				msgs[i].len, i);

