Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264588AbUENXnW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264588AbUENXnW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 May 2004 19:43:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264585AbUENXmj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 May 2004 19:42:39 -0400
Received: from mail.kroah.org ([65.200.24.183]:18405 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S264588AbUENX3v convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 May 2004 19:29:51 -0400
Subject: Re: [PATCH] I2C update for 2.6.6
In-Reply-To: <1084577358220@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 14 May 2004 16:29:18 -0700
Message-Id: <10845773583910@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1587.15.17, 2004/05/14 14:59:26-07:00, bjorn@mork.no

[PATCH] I2C: "probe" module param broken for it87 in Linux 2.6.6

Jean Delvare <khali@linux-fr.org> writes:
> So I'd suggest that you simply use the standard exit sequence in the
> it87 driver (the second one in your current patch). A patch for the 2.4
> driver would be appreciated as well.

OK.  I've attached a new version of the patch against linux-2.6.6.
I'll send a patch against current lm_sensors CVS removing the extra
exit command in a separate mail.

Greg KH <greg@kroah.com> writes:
> On Wed, May 12, 2004 at 04:38:03PM +0200, Bj?rn Mork wrote:
>> +	if (!it87_find(&addr)) {
>> +		printk("it87.o: new ISA address: 0x%04x\n", addr);
>
> That printk is wrong (no KERN_ level, or dev_printk() style use).
> Please fix it in your next revision of this patch.

Errh, I just added it to document my sloppyness.  It was never meant
to be in the patch I sent you.  Sorry.  Removed in the attached patch.
The style of these drivers seem to be "just working, making no noise"
so I assume informational printk's are unwanted.


 drivers/i2c/chips/it87.c |   78 +++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 78 insertions(+)


diff -Nru a/drivers/i2c/chips/it87.c b/drivers/i2c/chips/it87.c
--- a/drivers/i2c/chips/it87.c	Fri May 14 16:18:36 2004
+++ b/drivers/i2c/chips/it87.c	Fri May 14 16:18:36 2004
@@ -49,6 +49,54 @@
 /* Insmod parameters */
 SENSORS_INSMOD_1(it87);
 
+#define	REG	0x2e	/* The register to read/write */
+#define	DEV	0x07	/* Register: Logical device select */
+#define	VAL	0x2f	/* The value to read/write */
+#define PME	0x04	/* The device with the fan registers in it */
+#define	DEVID	0x20	/* Register: Device ID */
+
+static inline void
+superio_outb(int reg, int val)
+{
+	outb(reg, REG);
+	outb(val, VAL);
+}
+
+static inline int
+superio_inb(int reg)
+{
+	outb(reg, REG);
+	return inb(VAL);
+}
+
+static inline void
+superio_select(void)
+{
+	outb(DEV, REG);
+	outb(PME, VAL);
+}
+
+static inline void
+superio_enter(void)
+{
+	outb(0x87, REG);
+	outb(0x01, REG);
+	outb(0x55, REG);
+	outb(0x55, REG);
+}
+
+static inline void
+superio_exit(void)
+{
+	outb(0x02, REG);
+	outb(0x02, VAL);
+}
+
+/* just IT8712F for now - this should be extended to support the other
+   chips as well */
+#define IT8712F_DEVID 0x8712
+#define IT87_ACT_REG  0x30
+#define IT87_BASE_REG 0x60
 
 /* Update battery voltage after every reading if true */
 static int update_vbat;
@@ -158,6 +206,7 @@
 
 
 static int it87_attach_adapter(struct i2c_adapter *adapter);
+static int it87_find(int *address);
 static int it87_detect(struct i2c_adapter *adapter, int address, int kind);
 static int it87_detach_client(struct i2c_client *client);
 
@@ -505,6 +554,30 @@
 	return i2c_detect(adapter, &addr_data, it87_detect);
 }
 
+/* SuperIO detection - will change normal_isa[0] if a chip is found */
+static int it87_find(int *address)
+{
+	u16 val;
+
+	superio_enter();
+	val = (superio_inb(DEVID) << 8) |
+	       superio_inb(DEVID + 1);
+	if (val != IT8712F_DEVID) {
+		superio_exit();
+		return -ENODEV;
+	}
+
+	superio_select();
+	val = (superio_inb(IT87_BASE_REG) << 8) |
+	       superio_inb(IT87_BASE_REG + 1);
+	superio_exit();
+	*address = val & ~(IT87_EXTENT - 1);
+	if (*address == 0) {
+		return -ENODEV;
+	}
+	return 0;
+}
+
 /* This function is called by i2c_detect */
 int it87_detect(struct i2c_adapter *adapter, int address, int kind)
 {
@@ -853,6 +926,11 @@
 
 static int __init sm_it87_init(void)
 {
+	int addr;
+
+	if (!it87_find(&addr)) {
+		normal_isa[0] = addr;
+	}
 	return i2c_add_driver(&it87_driver);
 }
 

