Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265892AbUAKOGu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jan 2004 09:06:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265895AbUAKOGu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jan 2004 09:06:50 -0500
Received: from smtp-100-sunday.noc.nerim.net ([62.4.17.100]:57866 "EHLO
	mallaury.noc.nerim.net") by vger.kernel.org with ESMTP
	id S265892AbUAKOGf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jan 2004 09:06:35 -0500
Date: Sun, 11 Jan 2004 15:08:27 +0100
From: Jean Delvare <khali@linux-fr.org>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
       LM Sensors <sensors@Stimpy.netroedge.com>
Subject: [PATCH 2.4] i2c cleanups, third wave (3/8)
Message-Id: <20040111150827.48b9a144.khali@linux-fr.org>
In-Reply-To: <20040111144214.7a6a4e59.khali@linux-fr.org>
References: <20040111144214.7a6a4e59.khali@linux-fr.org>
Reply-To: LKML <linux-kernel@vger.kernel.org>,
       LM Sensors <sensors@Stimpy.netroedge.com>
X-Mailer: Sylpheed version 0.9.8a (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove bus scanning from various algorithms (i2c-algo-bit, i2c-algo-ite,
i2c-algo-pcf and i2c-algo-sibyte). This was discussed on the LM Sensors
mailing list:
http://archives.andrew.net.au/lm-sensors/msg05639.html
Main reason is that there is the i2cdetect user-space tools for that,
which works with all i2c busses (except i2c-isa) and does a better job.

A similar patch was sent to Greg KH for linux 2.6 and was applied in
2.6.1-rc1.

Note that this patch was voluntarily generated using diff -U2, because
it contains only removals, so much context isn't required.


diff -U2 -rN linux-2.4.24-pre3-k1/drivers/i2c/i2c-algo-bit.c linux-2.4.24-pre3-k2/drivers/i2c/i2c-algo-bit.c
--- linux-2.4.24-pre3-k1/drivers/i2c/i2c-algo-bit.c	2004-01-05 09:44:26.000000000 +0100
+++ linux-2.4.24-pre3-k2/drivers/i2c/i2c-algo-bit.c	2004-01-05 15:22:54.000000000 +0100
@@ -51,5 +51,4 @@
 static int i2c_debug;
 static int bit_test;	/* see if the line-setting functions work	*/
-static int bit_scan;	/* have a look at what's hanging 'round		*/
 
 /* --- setting states on the bus with the right timing: ---------------	*/
@@ -527,5 +526,4 @@
 int i2c_bit_add_bus(struct i2c_adapter *adap)
 {
-	int i;
 	struct i2c_algo_bit_data *bit_adap = adap->algo_data;
 
@@ -547,21 +545,4 @@
 	adap->retries = 3;	/* be replaced by defines	*/
 
-	/* scan bus */
-	if (bit_scan) {
-		int ack;
-		printk(KERN_INFO " i2c-algo-bit.o: scanning bus %s.\n",
-		       adap->name);
-		for (i = 0x00; i < 0xff; i+=2) {
-			i2c_start(bit_adap);
-			ack = i2c_outb(adap,i);
-			i2c_stop(bit_adap);
-			if (ack>0) {
-				printk("(%02x)",i>>1); 
-			} else 
-				printk("."); 
-		}
-		printk("\n");
-	}
-
 #ifdef MODULE
 	MOD_INC_USE_COUNT;
@@ -605,9 +586,7 @@
 
 MODULE_PARM(bit_test, "i");
-MODULE_PARM(bit_scan, "i");
 MODULE_PARM(i2c_debug,"i");
 
 MODULE_PARM_DESC(bit_test, "Test the lines of the bus to see if it is stuck");
-MODULE_PARM_DESC(bit_scan, "Scan for active chips on the bus");
 MODULE_PARM_DESC(i2c_debug,
             "debug level - 0 off; 1 normal; 2,3 more verbose; 9 bit-protocol");
diff -U2 -rN linux-2.4.24-pre3-k1/drivers/i2c/i2c-algo-ite.c linux-2.4.24-pre3-k2/drivers/i2c/i2c-algo-ite.c
--- linux-2.4.24-pre3-k1/drivers/i2c/i2c-algo-ite.c	2004-01-05 09:43:53.000000000 +0100
+++ linux-2.4.24-pre3-k2/drivers/i2c/i2c-algo-ite.c	2004-01-06 11:56:13.000000000 +0100
@@ -68,5 +68,4 @@
 static int i2c_debug=1;
 static int iic_test=0;	/* see if the line-setting functions work	*/
-static int iic_scan=0;	/* have a look at what's hanging 'round		*/
 
 /* --- setting states on the bus with the right timing: ---------------	*/
@@ -745,6 +744,4 @@
 int i2c_iic_add_bus(struct i2c_adapter *adap)
 {
-	int i;
-	short status;
 	struct i2c_algo_iic_data *iic_adap = adap->algo_data;
 
@@ -774,22 +771,4 @@
 	iic_init(iic_adap);
 
-	/* scan bus */
-	/* By default scanning the bus is turned off. */
-	if (iic_scan) {
-		printk(KERN_INFO " i2c-algo-ite: scanning bus %s.\n",
-		       adap->name);
-		for (i = 0x00; i < 0xff; i+=2) {
-			iic_outw(iic_adap, ITE_I2CSAR, i);
-			iic_start(iic_adap);
-			if ( (wait_for_pin(iic_adap, &status) == 0) && 
-			    ((status & ITE_I2CHSR_DNE) == 0) ) { 
-				printk(KERN_INFO "\n(%02x)\n",i>>1); 
-			} else {
-				printk(KERN_INFO "."); 
-				iic_reset(iic_adap);
-			}
-			udelay(iic_adap->udelay);
-		}
-	}
 	return 0;
 }
@@ -834,9 +813,7 @@
 
 MODULE_PARM(iic_test, "i");
-MODULE_PARM(iic_scan, "i");
 MODULE_PARM(i2c_debug,"i");
 
 MODULE_PARM_DESC(iic_test, "Test if the I2C bus is available");
-MODULE_PARM_DESC(iic_scan, "Scan for active chips on the bus");
 MODULE_PARM_DESC(i2c_debug,
         "debug level - 0 off; 1 normal; 2,3 more verbose; 9 iic-protocol");
diff -U2 -rN linux-2.4.24-pre3-k1/drivers/i2c/i2c-algo-pcf.c linux-2.4.24-pre3-k2/drivers/i2c/i2c-algo-pcf.c
--- linux-2.4.24-pre3-k1/drivers/i2c/i2c-algo-pcf.c	2003-12-31 14:50:59.000000000 +0100
+++ linux-2.4.24-pre3-k2/drivers/i2c/i2c-algo-pcf.c	2004-01-06 12:01:10.000000000 +0100
@@ -53,5 +53,4 @@
  */
 static int i2c_debug=0;
-static int pcf_scan=0;	/* have a look at what's hanging 'round		*/
 
 /* --- setting states on the bus with the right timing: ---------------	*/
@@ -458,5 +457,5 @@
 int i2c_pcf_add_bus(struct i2c_adapter *adap)
 {
-	int i, status;
+	int i;
 	struct i2c_algo_pcf_data *pcf_adap = adap->algo_data;
 
@@ -481,28 +480,4 @@
 
 	i2c_add_adapter(adap);
-
-	/* scan bus */
-	if (pcf_scan) {
-		printk(KERN_INFO " i2c-algo-pcf.o: scanning bus %s.\n",
-		       adap->name);
-		for (i = 0x00; i < 0xff; i+=2) {
-			if (wait_for_bb(pcf_adap)) {
-    			printk(KERN_INFO " i2c-algo-pcf.o: scanning bus %s - TIMEOUTed.\n",
-		           adap->name);
-			    break;
-			}
-			i2c_outb(pcf_adap, i);
-			i2c_start(pcf_adap);
-			if ((wait_for_pin(pcf_adap, &status) >= 0) && 
-			    ((status & I2C_PCF_LRB) == 0)) { 
-				printk("(%02x)",i>>1); 
-			} else {
-				printk("."); 
-			}
-			i2c_stop(pcf_adap);
-			udelay(pcf_adap->udelay);
-		}
-		printk("\n");
-	}
 	return 0;
 }
@@ -537,12 +512,8 @@
 MODULE_LICENSE("GPL");
 
-MODULE_PARM(pcf_scan, "i");
 MODULE_PARM(i2c_debug,"i");
-
-MODULE_PARM_DESC(pcf_scan, "Scan for active chips on the bus");
 MODULE_PARM_DESC(i2c_debug,
         "debug level - 0 off; 1 normal; 2,3 more verbose; 9 pcf-protocol");
 
-
 int init_module(void) 
 {
diff -U2 -rN linux-2.4.24-pre3-k1/drivers/i2c/i2c-algo-sibyte.c linux-2.4.24-pre3-k2/drivers/i2c/i2c-algo-sibyte.c
--- linux-2.4.24-pre3-k1/drivers/i2c/i2c-algo-sibyte.c	2003-08-25 13:44:41.000000000 +0200
+++ linux-2.4.24-pre3-k2/drivers/i2c/i2c-algo-sibyte.c	2004-01-06 12:09:46.000000000 +0100
@@ -40,10 +40,5 @@
 #define SMB_CSR(a,r) ((long)(a->reg_base + r))
 
-/* ----- global variables ---------------------------------------------	*/
-
-/* module parameters:
- */
-static int bit_scan=0;	/* have a look at what's hanging 'round		*/
-
+/* ----- functions ---------------------------------------------------- */
 
 static int smbus_xfer(struct i2c_adapter *i2c_adap, u16 addr, 
@@ -152,5 +147,4 @@
 int i2c_sibyte_add_bus(struct i2c_adapter *i2c_adap, int speed)
 {
-	int i;
 	struct i2c_algo_sibyte_data *adap = i2c_adap->algo_data;
 
@@ -164,22 +158,4 @@
         csr_out32(0, SMB_CSR(adap,R_SMB_CONTROL));
 
-	/* scan bus */
-	if (bit_scan) {
-                union i2c_smbus_data data;
-                int rc;
-		printk(KERN_INFO " i2c-algo-sibyte.o: scanning bus %s.\n",
-		       i2c_adap->name);
-		for (i = 0x00; i < 0x7f; i++) {
-                        /* XXXKW is this a realistic probe? */
-                        rc = smbus_xfer(i2c_adap, i, 0, I2C_SMBUS_READ, 0,
-                                        I2C_SMBUS_BYTE_DATA, &data);
-			if (!rc) {
-				printk("(%02x)",i); 
-			} else 
-				printk("."); 
-		}
-		printk("\n");
-	}
-
 #ifdef MODULE
 	MOD_INC_USE_COUNT;
@@ -217,6 +193,4 @@
 MODULE_AUTHOR("Kip Walker, Broadcom Corp.");
 MODULE_DESCRIPTION("SiByte I2C-Bus algorithm");
-MODULE_PARM(bit_scan, "i");
-MODULE_PARM_DESC(bit_scan, "Scan for active chips on the bus");
 MODULE_LICENSE("GPL");
 

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
