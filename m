Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265896AbTL3WvR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Dec 2003 17:51:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265865AbTL3WNd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Dec 2003 17:13:33 -0500
Received: from mail.kroah.org ([65.200.24.183]:48833 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265828AbTL3WGb convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Dec 2003 17:06:31 -0500
Subject: Re: [PATCH] i2c driver fixes for 2.6.0
In-Reply-To: <10728219711770@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Tue, 30 Dec 2003 14:06:11 -0800
Message-Id: <10728219713483@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1496.8.37, 2003/12/30 12:09:49-08:00, khali@linux-fr.org

[PATCH] I2C: remove bus scan logic from i2c chip drivers

This patch drops bus scan from i2c-algo-ite and i2c-ibm_iic. It also
removes the incomplete and broken SLO_IO stuff from i2c-algo-ite.


 drivers/i2c/algos/i2c-algo-ite.c |   36 ------------------------------------
 drivers/i2c/busses/i2c-ibm_iic.c |   34 ----------------------------------
 2 files changed, 70 deletions(-)


diff -Nru a/drivers/i2c/algos/i2c-algo-ite.c b/drivers/i2c/algos/i2c-algo-ite.c
--- a/drivers/i2c/algos/i2c-algo-ite.c	Tue Dec 30 12:28:59 2003
+++ b/drivers/i2c/algos/i2c-algo-ite.c	Tue Dec 30 12:28:59 2003
@@ -60,27 +60,13 @@
  	/* debug the protocol by showing transferred bits */
 #define DEF_TIMEOUT 16
 
-/* debugging - slow down transfer to have a look at the data .. 	*/
-/* I use this with two leds&resistors, each one connected to sda,scl 	*/
-/* respectively. This makes sure that the algorithm works. Some chips   */
-/* might not like this, as they have an internal timeout of some mils	*/
-/*
-#define SLO_IO      jif=jiffies;while(jiffies<=jif+i2c_table[minor].veryslow)\
-                        cond_resched();
-*/
-
 
 /* ----- global variables ---------------------------------------------	*/
 
-#ifdef SLO_IO
-	int jif;
-#endif
-
 /* module parameters:
  */
 static int i2c_debug=1;
 static int iic_test=0;	/* see if the line-setting functions work	*/
-static int iic_scan=0;	/* have a look at what's hanging 'round		*/
 
 /* --- setting states on the bus with the right timing: ---------------	*/
 
@@ -757,8 +743,6 @@
  */
 int i2c_iic_add_bus(struct i2c_adapter *adap)
 {
-	int i;
-	short status;
 	struct i2c_algo_iic_data *iic_adap = adap->algo_data;
 
 	if (iic_test) {
@@ -782,24 +766,6 @@
 	i2c_add_adapter(adap);
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
 
@@ -839,11 +805,9 @@
 MODULE_LICENSE("GPL");
 
 MODULE_PARM(iic_test, "i");
-MODULE_PARM(iic_scan, "i");
 MODULE_PARM(i2c_debug,"i");
 
 MODULE_PARM_DESC(iic_test, "Test if the I2C bus is available");
-MODULE_PARM_DESC(iic_scan, "Scan for active chips on the bus");
 MODULE_PARM_DESC(i2c_debug,
         "debug level - 0 off; 1 normal; 2,3 more verbose; 9 iic-protocol");
 
diff -Nru a/drivers/i2c/busses/i2c-ibm_iic.c b/drivers/i2c/busses/i2c-ibm_iic.c
--- a/drivers/i2c/busses/i2c-ibm_iic.c	Tue Dec 30 12:28:59 2003
+++ b/drivers/i2c/busses/i2c-ibm_iic.c	Tue Dec 30 12:28:59 2003
@@ -48,10 +48,6 @@
 MODULE_DESCRIPTION("IBM IIC driver v" DRIVER_VERSION);
 MODULE_LICENSE("GPL");
 
-static int iic_scan = 0;
-MODULE_PARM(iic_scan, "i");
-MODULE_PARM_DESC(iic_scan, "Scan for active chips on the bus");
-
 static int iic_force_poll = 0;
 MODULE_PARM(iic_force_poll, "i");
 MODULE_PARM_DESC(iic_force_poll, "Force polling mode");
@@ -518,32 +514,6 @@
 };
 
 /*
- * Scan bus for valid 7-bit addresses (ie things that ACK on 1 byte read)
- * We only scan range [0x08 - 0x77], all other addresses are reserved anyway
- */
-static void __devinit iic_scan_bus(struct ibm_iic_private* dev)
-{
-	int found = 0;
-	char dummy;
-	struct i2c_msg msg = {
-		.buf   = &dummy,
-		.len   = sizeof(dummy),
-		.flags = I2C_M_RD
-	};
-	
-	printk(KERN_INFO "ibm-iic%d: scanning bus...\n" KERN_INFO, dev->idx);
-	
-	for (msg.addr = 8; msg.addr < 0x78; ++msg.addr)
-		if (iic_xfer(&dev->adap, &msg, 1) == 1){
-			++found;
-			printk(" 0x%02x", msg.addr);
-		}
-
-	printk("%sibm-iic%d: %d device(s) detected\n", 
-		found ? "\n" KERN_INFO : "", dev->idx, found);
-}
-
-/*
  * Calculates IICx_CLCKDIV value for a specific OPB clock frequency
  */
 static inline u8 iic_clckdiv(unsigned int opb)
@@ -648,10 +618,6 @@
 	
 	printk(KERN_INFO "ibm-iic%d: using %s mode\n", dev->idx,
 		dev->fast_mode ? "fast (400 kHz)" : "standard (100 kHz)");
-
-	/* Scan bus if requested by user */
-	if (iic_scan)
-		iic_scan_bus(dev);
 
 	return 0;
 

