Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262893AbVAQVxc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262893AbVAQVxc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jan 2005 16:53:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262885AbVAQVw4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jan 2005 16:52:56 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:49618 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S262902AbVAQVtR convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jan 2005 16:49:17 -0500
Cc: khali@linux-fr.org
Subject: [PATCH] I2C: Improve it87 super-i/o detection
In-Reply-To: <11059983963929@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 17 Jan 2005 13:46:36 -0800
Message-Id: <11059983962750@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.2329.2.9, 2005/01/14 14:44:10-08:00, khali@linux-fr.org

[PATCH] I2C: Improve it87 super-i/o detection

This patch improves the detection of Super-I/O it87 chips (IT8712F,
IT8705F).

* Find the IT8712F and IT8705F address through Super-I/O (as opposed to
  IT8712F only so far).

* Verify that the device is activated. Print info lines if a
  disactivated or unconfigured chip is found.

* Print an info line when finding either chip, with device name,
  address and revision.

* Rearrange code in it87_find() (error path).

* (bonus) Get rid of the useless i2c_client id.

Successfully tested on two IT8712F and one IT8705F, thanks to Jonas
Munsin, Rudolf Marek and Karine Proot.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/i2c/chips/it87.c |   53 +++++++++++++++++++++++++++++------------------
 1 files changed, 33 insertions(+), 20 deletions(-)


diff -Nru a/drivers/i2c/chips/it87.c b/drivers/i2c/chips/it87.c
--- a/drivers/i2c/chips/it87.c	2005-01-17 13:20:06 -08:00
+++ b/drivers/i2c/chips/it87.c	2005-01-17 13:20:06 -08:00
@@ -56,6 +56,7 @@
 #define	VAL	0x2f	/* The value to read/write */
 #define PME	0x04	/* The device with the fan registers in it */
 #define	DEVID	0x20	/* Register: Device ID */
+#define	DEVREV	0x22	/* Register: Device Revision */
 
 static inline int
 superio_inb(int reg)
@@ -64,6 +65,16 @@
 	return inb(VAL);
 }
 
+static int superio_inw(int reg)
+{
+	int val;
+	outb(reg++, REG);
+	val = inb(VAL) << 8;
+	outb(reg, REG);
+	val |= inb(VAL);
+	return val;
+}
+
 static inline void
 superio_select(void)
 {
@@ -87,9 +98,8 @@
 	outb(0x02, VAL);
 }
 
-/* just IT8712F for now - this should be extended to support the other
-   chips as well */
 #define IT8712F_DEVID 0x8712
+#define IT8705F_DEVID 0x8705
 #define IT87_ACT_REG  0x30
 #define IT87_BASE_REG 0x60
 
@@ -228,8 +238,6 @@
 	.detach_client	= it87_detach_client,
 };
 
-static int it87_id;
-
 static ssize_t show_in(struct device *dev, char *buf, int nr)
 {
 	struct it87_data *data = it87_update_device(dev);
@@ -673,25 +681,33 @@
 /* SuperIO detection - will change normal_isa[0] if a chip is found */
 static int it87_find(int *address)
 {
-	u16 val;
+	int err = -ENODEV;
 
 	superio_enter();
-	chip_type = (superio_inb(DEVID) << 8) |
-	       superio_inb(DEVID + 1);
-	if (chip_type != IT8712F_DEVID) {
-		superio_exit();
-		return -ENODEV;
-	}
+	chip_type = superio_inw(DEVID);
+	if (chip_type != IT8712F_DEVID
+	 && chip_type != IT8705F_DEVID)
+	 	goto exit;
 
 	superio_select();
-	val = (superio_inb(IT87_BASE_REG) << 8) |
-	       superio_inb(IT87_BASE_REG + 1);
-	superio_exit();
-	*address = val & ~(IT87_EXTENT - 1);
+	if (!(superio_inb(IT87_ACT_REG) & 0x01)) {
+		pr_info("it87: Device not activated, skipping\n");
+		goto exit;
+	}
+
+	*address = superio_inw(IT87_BASE_REG) & ~(IT87_EXTENT - 1);
 	if (*address == 0) {
-		return -ENODEV;
+		pr_info("it87: Base address not set, skipping\n");
+		goto exit;
 	}
-	return 0;
+
+	err = 0;
+	pr_info("it87: Found IT%04xF chip at 0x%x, revision %d\n",
+		chip_type, *address, superio_inb(DEVREV) & 0x0f);
+
+exit:
+	superio_exit();
+	return err;
 }
 
 /* This function is called by i2c_detect */
@@ -800,10 +816,7 @@
 
 	/* Fill in the remaining client fields and put it into the global list */
 	strlcpy(new_client->name, name, I2C_NAME_SIZE);
-
 	data->type = kind;
-
-	new_client->id = it87_id++;
 	data->valid = 0;
 	init_MUTEX(&data->update_lock);
 

