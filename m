Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270279AbTGSPnA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Jul 2003 11:43:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270268AbTGSPmT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Jul 2003 11:42:19 -0400
Received: from mail.kroah.org ([65.200.24.183]:22176 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S270279AbTGSPkG convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Jul 2003 11:40:06 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10586300973931@kroah.com>
Subject: Re: [PATCH] i2c driver changes 2.6.0-test1
In-Reply-To: <10586300964092@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Sat, 19 Jul 2003 08:54:57 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1528, 2003/07/19 08:41:08-07:00, greg@kroah.com

[PATCH] I2C: consolidate the i2c delay functions.


 drivers/i2c/busses/i2c-ali1535.c |   10 ++--------
 drivers/i2c/busses/i2c-ali15x3.c |   11 ++---------
 drivers/i2c/busses/i2c-amd756.c  |   14 +++-----------
 drivers/i2c/busses/i2c-amd8111.c |    3 +--
 drivers/i2c/busses/i2c-i801.c    |   14 +++-----------
 drivers/i2c/busses/i2c-piix4.c   |   10 +---------
 drivers/i2c/busses/i2c-sis96x.c  |    9 +--------
 drivers/i2c/busses/i2c-viapro.c  |    9 +--------
 include/linux/i2c.h              |    7 +++++++
 9 files changed, 21 insertions(+), 66 deletions(-)


diff -Nru a/drivers/i2c/busses/i2c-ali1535.c b/drivers/i2c/busses/i2c-ali1535.c
--- a/drivers/i2c/busses/i2c-ali1535.c	Sat Jul 19 08:47:51 2003
+++ b/drivers/i2c/busses/i2c-ali1535.c	Sat Jul 19 08:47:51 2003
@@ -206,12 +206,6 @@
 	return retval;
 }
 
-static void ali1535_do_pause(unsigned int amount)
-{
-	current->state = TASK_INTERRUPTIBLE;
-	schedule_timeout(amount);
-}
-
 static int ali1535_transaction(struct i2c_adapter *adap)
 {
 	int temp;
@@ -283,7 +277,7 @@
 	/* We will always wait for a fraction of a second! */
 	timeout = 0;
 	do {
-		ali1535_do_pause(1);
+		i2c_delay(1);
 		temp = inb_p(SMBHSTSTS);
 	} while (((temp & ALI1535_STS_BUSY) && !(temp & ALI1535_STS_IDLE))
 		 && (timeout++ < MAX_TIMEOUT));
@@ -357,7 +351,7 @@
 	for (timeout = 0;
 	     (timeout < MAX_TIMEOUT) && !(temp & ALI1535_STS_IDLE);
 	     timeout++) {
-		ali1535_do_pause(1);
+		i2c_delay(1);
 		temp = inb_p(SMBHSTSTS);
 	}
 	if (timeout >= MAX_TIMEOUT)
diff -Nru a/drivers/i2c/busses/i2c-ali15x3.c b/drivers/i2c/busses/i2c-ali15x3.c
--- a/drivers/i2c/busses/i2c-ali15x3.c	Sat Jul 19 08:47:51 2003
+++ b/drivers/i2c/busses/i2c-ali15x3.c	Sat Jul 19 08:47:51 2003
@@ -225,13 +225,6 @@
 	return -ENODEV;
 }
 
-/* Internally used pause function */
-static void ali15x3_do_pause(unsigned int amount)
-{
-	current->state = TASK_INTERRUPTIBLE;
-	schedule_timeout(amount);
-}
-
 /* Another internally used function */
 static int ali15x3_transaction(struct i2c_adapter *adap)
 {
@@ -304,7 +297,7 @@
 	/* We will always wait for a fraction of a second! */
 	timeout = 0;
 	do {
-		ali15x3_do_pause(1);
+		i2c_delay(1);
 		temp = inb_p(SMBHSTSTS);
 	} while ((!(temp & (ALI15X3_STS_ERR | ALI15X3_STS_DONE)))
 		 && (timeout++ < MAX_TIMEOUT));
@@ -361,7 +354,7 @@
 	for (timeout = 0;
 	     (timeout < MAX_TIMEOUT) && !(temp & ALI15X3_STS_IDLE);
 	     timeout++) {
-		ali15x3_do_pause(1);
+		i2c_delay(1);
 		temp = inb_p(SMBHSTSTS);
 	}
 	if (timeout >= MAX_TIMEOUT) {
diff -Nru a/drivers/i2c/busses/i2c-amd756.c b/drivers/i2c/busses/i2c-amd756.c
--- a/drivers/i2c/busses/i2c-amd756.c	Sat Jul 19 08:47:51 2003
+++ b/drivers/i2c/busses/i2c-amd756.c	Sat Jul 19 08:47:51 2003
@@ -93,14 +93,6 @@
      see E0 for the status bits and enabled in E2
      
 */
-
-/* Internally used pause function */
-static void amd756_do_pause(unsigned int amount)
-{
-	current->state = TASK_INTERRUPTIBLE;
-	schedule_timeout(amount);
-}
-
 #define GS_ABRT_STS	(1 << 0)
 #define GS_COL_STS	(1 << 1)
 #define GS_PRERR_STS	(1 << 2)
@@ -132,7 +124,7 @@
 	if ((temp = inw_p(SMB_GLOBAL_STATUS)) & (GS_HST_STS | GS_SMB_STS)) {
 		dev_dbg(&adap->dev, ": SMBus busy (%04x). Waiting... \n", temp);
 		do {
-			amd756_do_pause(1);
+			i2c_delay(1);
 			temp = inw_p(SMB_GLOBAL_STATUS);
 		} while ((temp & (GS_HST_STS | GS_SMB_STS)) &&
 		         (timeout++ < MAX_TIMEOUT));
@@ -149,7 +141,7 @@
 
 	/* We will always wait for a fraction of a second! */
 	do {
-		amd756_do_pause(1);
+		i2c_delay(1);
 		temp = inw_p(SMB_GLOBAL_STATUS);
 	} while ((temp & GS_HST_STS) && (timeout++ < MAX_TIMEOUT));
 
@@ -196,7 +188,7 @@
  abort:
 	dev_warn(&adap->dev, ": Sending abort.\n");
 	outw_p(inw(SMB_GLOBAL_ENABLE) | GE_ABORT, SMB_GLOBAL_ENABLE);
-	amd756_do_pause(100);
+	i2c_delay(100);
 	outw_p(GS_CLEAR_STS, SMB_GLOBAL_STATUS);
 	return -1;
 }
diff -Nru a/drivers/i2c/busses/i2c-amd8111.c b/drivers/i2c/busses/i2c-amd8111.c
--- a/drivers/i2c/busses/i2c-amd8111.c	Sat Jul 19 08:47:51 2003
+++ b/drivers/i2c/busses/i2c-amd8111.c	Sat Jul 19 08:47:51 2003
@@ -275,8 +275,7 @@
 	}
 
 	if (~temp[0] & AMD_SMB_STS_DONE) {
-		current->state = TASK_INTERRUPTIBLE;
-		schedule_timeout(HZ/100);
+		i2c_delay(HZ/100);
 		amd_ec_read(smbus, AMD_SMB_STS, temp + 0);
 	}
 
diff -Nru a/drivers/i2c/busses/i2c-i801.c b/drivers/i2c/busses/i2c-i801.c
--- a/drivers/i2c/busses/i2c-i801.c	Sat Jul 19 08:47:51 2003
+++ b/drivers/i2c/busses/i2c-i801.c	Sat Jul 19 08:47:51 2003
@@ -103,7 +103,6 @@
 		 "Forcibly enable the I801 at the given address. "
 		 "EXTREMELY DANGEROUS!");
 
-static void i801_do_pause(unsigned int amount);
 static int i801_transaction(void);
 static int i801_block_transaction(union i2c_smbus_data *data,
 				  char read_write, int command);
@@ -178,13 +177,6 @@
 	return error_return;
 }
 
-
-static void i801_do_pause(unsigned int amount)
-{
-	current->state = TASK_INTERRUPTIBLE;
-	schedule_timeout(amount);
-}
-
 static int i801_transaction(void)
 {
 	int temp;
@@ -214,7 +206,7 @@
 
 	/* We will always wait for a fraction of a second! */
 	do {
-		i801_do_pause(1);
+		i2c_delay(1);
 		temp = inb_p(SMBHSTSTS);
 	} while ((temp & 0x01) && (timeout++ < MAX_TIMEOUT));
 
@@ -342,7 +334,7 @@
 		timeout = 0;
 		do {
 			temp = inb_p(SMBHSTSTS);
-			i801_do_pause(1);
+			i2c_delay(1);
 		}
 		    while ((!(temp & 0x80))
 			   && (timeout++ < MAX_TIMEOUT));
@@ -402,7 +394,7 @@
 		timeout = 0;
 		do {
 			temp = inb_p(SMBHSTSTS);
-			i801_do_pause(1);
+			i2c_delay(1);
 		} while ((!(temp & 0x02))
 			   && (timeout++ < MAX_TIMEOUT));
 
diff -Nru a/drivers/i2c/busses/i2c-piix4.c b/drivers/i2c/busses/i2c-piix4.c
--- a/drivers/i2c/busses/i2c-piix4.c	Sat Jul 19 08:47:51 2003
+++ b/drivers/i2c/busses/i2c-piix4.c	Sat Jul 19 08:47:51 2003
@@ -99,7 +99,6 @@
 		 "Forcibly enable the PIIX4 at the given address. "
 		 "EXTREMELY DANGEROUS!");
 
-static void piix4_do_pause(unsigned int amount);
 static int piix4_transaction(void);
 
 
@@ -208,13 +207,6 @@
 	return error_return;
 }
 
-/* Internally used pause function */
-static void piix4_do_pause(unsigned int amount)
-{
-	current->state = TASK_INTERRUPTIBLE;
-	schedule_timeout(amount);
-}
-
 /* Another internally used function */
 static int piix4_transaction(void)
 {
@@ -245,7 +237,7 @@
 
 	/* We will always wait for a fraction of a second! (See PIIX4 docs errata) */
 	do {
-		piix4_do_pause(1);
+		i2c_delay(1);
 		temp = inb_p(SMBHSTSTS);
 	} while ((temp & 0x01) && (timeout++ < MAX_TIMEOUT));
 
diff -Nru a/drivers/i2c/busses/i2c-sis96x.c b/drivers/i2c/busses/i2c-sis96x.c
--- a/drivers/i2c/busses/i2c-sis96x.c	Sat Jul 19 08:47:51 2003
+++ b/drivers/i2c/busses/i2c-sis96x.c	Sat Jul 19 08:47:51 2003
@@ -99,13 +99,6 @@
 	outb(data, sis96x_smbus_base + reg) ;
 }
 
-/* Internally used pause function */
-static void sis96x_do_pause(unsigned int amount)
-{
-	current->state = TASK_INTERRUPTIBLE;
-	schedule_timeout(amount);
-}
-
 /* Execute a SMBus transaction.
    int size is from SIS96x_QUICK to SIS96x_BLOCK_DATA
  */
@@ -147,7 +140,7 @@
 
 	/* We will always wait for a fraction of a second! */
 	do {
-		sis96x_do_pause(1);
+		i2c_delay(1);
 		temp = sis96x_read(SMB_STS);
 	} while (!(temp & 0x0e) && (timeout++ < MAX_TIMEOUT));
 
diff -Nru a/drivers/i2c/busses/i2c-viapro.c b/drivers/i2c/busses/i2c-viapro.c
--- a/drivers/i2c/busses/i2c-viapro.c	Sat Jul 19 08:47:51 2003
+++ b/drivers/i2c/busses/i2c-viapro.c	Sat Jul 19 08:47:51 2003
@@ -103,13 +103,6 @@
 
 static struct i2c_adapter vt596_adapter;
 
-/* Internally used pause function */
-static void vt596_do_pause(unsigned int amount)
-{
-	current->state = TASK_INTERRUPTIBLE;
-	schedule_timeout(amount);
-}
-
 /* Another internally used function */
 static int vt596_transaction(void)
 {
@@ -143,7 +136,7 @@
 	/* We will always wait for a fraction of a second! 
 	   I don't know if VIA needs this, Intel did  */
 	do {
-		vt596_do_pause(1);
+		i2c_delay(1);
 		temp = inb_p(SMBHSTSTS);
 	} while ((temp & 0x01) && (timeout++ < MAX_TIMEOUT));
 
diff -Nru a/include/linux/i2c.h b/include/linux/i2c.h
--- a/include/linux/i2c.h	Sat Jul 19 08:47:51 2003
+++ b/include/linux/i2c.h	Sat Jul 19 08:47:51 2003
@@ -594,4 +594,11 @@
 #define i2c_is_isa_adapter(adapptr) \
         ((adapptr)->algo->id == I2C_ALGO_ISA)
 
+/* Tiny delay function used by the i2c bus drivers */
+static inline void i2c_delay(signed long timeout)
+{
+	set_current_state(TASK_INTERRUPTIBLE);
+	schedule_timeout(timeout);
+}
+
 #endif /* _LINUX_I2C_H */

