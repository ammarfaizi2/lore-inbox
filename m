Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268516AbRGYAnC>; Tue, 24 Jul 2001 20:43:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266321AbRGYAmv>; Tue, 24 Jul 2001 20:42:51 -0400
Received: from jalon.able.es ([212.97.163.2]:41909 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S266293AbRGYAm0>;
	Tue, 24 Jul 2001 20:42:26 -0400
Date: Wed, 25 Jul 2001 02:46:29 +0200
From: "J . A . Magallon" <jamagallon@able.es>
To: Alan Cox <laughing@shared-source.org>,
        Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] i2c update to 2.6.0 for 2.4.7
Message-ID: <20010725024629.E2308@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Mailer: Balsa 1.1.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Hi.

This patch updates i2c support in kernel to 2.6.0. I have corrected original patch
to use slab.h instead of malloc.h, a couple #endif's, and Comfigure.help references
to other docs in <file:...> format.

It was done on 2.4.6-ac5, but should apply on 2.4.7. Only problem is those
document references in <file:.......> format, that are not suitable for plain 2.4.7.

BTW, is there any chance to include lm_sensors also in mainstream kernel ?

TIA

--- linux-old/Documentation/i2c/writing-clients	Mon Jul 23 01:39:46 CEST 2001
+++ linux/Documentation/i2c/writing-clients	Mon Jul 23 01:39:46 CEST 2001
@@ -34,5 +34,5 @@
     /* command        */  &foo_command,   /* May be NULL */
     /* inc_use        */  &foo_inc_use,   /* May be NULL */
-    /* dec_use        */  &foo_dev_use    /* May be NULL */
+    /* dec_use        */  &foo_dec_use    /* May be NULL */
   }
  
--- linux-old/drivers/i2c/i2c-algo-bit.c	Mon Jul 23 01:39:47 CEST 2001
+++ linux/drivers/i2c/i2c-algo-bit.c	Mon Jul 23 01:39:47 CEST 2001
@@ -22,5 +22,5 @@
    Frodo Looijaard <frodol@dds.nl> */
 
-/* $Id: i2c-algo-bit.c,v 1.27 2000/07/09 15:16:16 frodo Exp $ */
+/* $Id: i2c-algo-bit.c,v 1.29 2001/04/03 02:44:02 mds Exp $ */
 
 #include <linux/kernel.h>
--- linux-old/drivers/i2c/i2c-algo-pcf.c	Mon Jul 23 01:39:48 CEST 2001
+++ linux/drivers/i2c/i2c-algo-pcf.c	Mon Jul 23 01:39:48 CEST 2001
@@ -1,3 +1,2 @@
-
 /* ------------------------------------------------------------------------- */
 /* i2c-algo-pcf.c i2c driver algorithms for PCF8584 adapters		     */
@@ -25,5 +24,7 @@
    <mbailey@littlefeet-inc.com> */
 
-/* $Id: i2c-algo-pcf.c,v 1.25 2000/11/10 13:43:32 frodo Exp $ */
+/* Partially rewriten by Oleg I. Vdovikin <vdovikin@jscc.ru> to handle multiple
+   messages, proper stop/repstart signaling during receive,
+   added detect code */
 
 #include <linux/kernel.h>
@@ -50,24 +51,7 @@
 #define DEF_TIMEOUT 16
 
-/* debugging - slow down transfer to have a look at the data .. 	*/
-/* I use this with two leds&resistors, each one connected to sda,scl 	*/
-/* respectively. This makes sure that the algorithm works. Some chips   */
-/* might not like this, as they have an internal timeout of some mils	*/
-/*
-#define SLO_IO      jif=jiffies;while(jiffies<=jif+i2c_table[minor].veryslow)\
-                        if (need_resched) schedule();
-*/
-
-
-/* ----- global variables ---------------------------------------------	*/
-
-#ifdef SLO_IO
-	int jif;
-#endif
-
 /* module parameters:
  */
-static int i2c_debug=1;
-static int pcf_test=0;	/* see if the line-setting functions work	*/
+static int i2c_debug=0;
 static int pcf_scan=0;	/* have a look at what's hanging 'round		*/
 
@@ -81,5 +65,4 @@
 #define i2c_inb(adap) adap->getpcf(adap->data, 0)
 
-
 /* --- other auxiliary functions --------------------------------------	*/
 
@@ -112,14 +95,13 @@
 #ifndef STUB_I2C
 	while (timeout-- && !(status & I2C_PCF_BB)) {
-		udelay(1000); /* How much is this? */
+		udelay(100); /* wait for 100 us */
 		status = get_pcf(adap, 1);
 	}
 #endif
-	if (timeout<=0)
+	if (timeout <= 0) {
 		printk("Timeout waiting for Bus Busy\n");
-	/*
-	set_pcf(adap, 1, I2C_PCF_STOP);
-	*/
-	return(timeout<=0);
+	}
+	
+	return (timeout<=0);
 }
 
@@ -148,5 +130,4 @@
 }
 
-
 /* 
  * This should perform the 'PCF8584 initialization sequence' as described
@@ -157,109 +138,62 @@
  * to synchronize the BB-bit (in multimaster systems). How long is
  * this? I assume 1 second is always long enough.
+ *
+ * vdovikin: added detect code for PCF8584
  */
 static int pcf_init_8584 (struct i2c_algo_pcf_data *adap)
 {
+	unsigned char temp;
+
+	DEB3(printk("i2c-algo-pcf.o: PCF state 0x%02x\n", get_pcf(adap, 1)));
 
-	/* S1=0x80: S0 selected, serial interface off			*/
+	/* S1=0x80: S0 selected, serial interface off */
 	set_pcf(adap, 1, I2C_PCF_PIN);
+	/* check to see S1 now used as R/W ctrl -
+	   PCF8584 does that when ESO is zero */
+	/* PCF also resets PIN bit */
+	if ((temp = get_pcf(adap, 1)) != (0)) {
+		DEB2(printk("i2c-algo-pcf.o: PCF detection failed -- can't select S0 (0x%02x).\n", temp));
+		return -ENXIO; /* definetly not PCF8584 */
+	}
 
 	/* load own address in S0, effective address is (own << 1)	*/
 	i2c_outb(adap, get_own(adap));
+	/* check it's realy writen */
+	if ((temp = i2c_inb(adap)) != get_own(adap)) {
+		DEB2(printk("i2c-algo-pcf.o: PCF detection failed -- can't set S0 (0x%02x).\n", temp));
+		return -ENXIO;
+	}
 
 	/* S1=0xA0, next byte in S2					*/
 	set_pcf(adap, 1, I2C_PCF_PIN | I2C_PCF_ES1);
+	/* check to see S2 now selected */
+	if ((temp = get_pcf(adap, 1)) != I2C_PCF_ES1) {
+		DEB2(printk("i2c-algo-pcf.o: PCF detection failed -- can't select S2 (0x%02x).\n", temp));
+		return -ENXIO;
+	}
 
 	/* load clock register S2					*/
 	i2c_outb(adap, get_clock(adap));
+	/* check it's realy writen, the only 5 lowest bits does matter */
+	if (((temp = i2c_inb(adap)) & 0x1f) != get_clock(adap)) {
+		DEB2(printk("i2c-algo-pcf.o: PCF detection failed -- can't set S2 (0x%02x).\n", temp));
+		return -ENXIO;
+	}
 
 	/* Enable serial interface, idle, S0 selected			*/
 	set_pcf(adap, 1, I2C_PCF_IDLE);
 
-	DEB2(printk("i2c-algo-pcf.o: irq: Initialized 8584.\n"));
-	return 0;
-}
-
-
-/*
- * Sanity check for the adapter hardware - check the reaction of
- * the bus lines only if it seems to be idle.
- */
-static int test_bus(struct i2c_algo_pcf_data *adap, char *name) {
-#if 0
-	int scl,sda;
-	sda=getsda(adap);
-	if (adap->getscl==NULL) {
-		printk("i2c-algo-pcf.o: Warning: Adapter can't read from clock line - skipping test.\n");
-		return 0;		
-	}
-	scl=getscl(adap);
-	printk("i2c-algo-pcf.o: Adapter: %s scl: %d  sda: %d -- testing...\n",
-	name,getscl(adap),getsda(adap));
-	if (!scl || !sda ) {
-		printk("i2c-algo-pcf.o: %s seems to be busy.\n",adap->name);
-		goto bailout;
-	}
-	sdalo(adap);
-	printk("i2c-algo-pcf.o:1 scl: %d  sda: %d \n",getscl(adap),
-	       getsda(adap));
-	if ( 0 != getsda(adap) ) {
-		printk("i2c-algo-pcf.o: %s SDA stuck high!\n",name);
-		sdahi(adap);
-		goto bailout;
-	}
-	if ( 0 == getscl(adap) ) {
-		printk("i2c-algo-pcf.o: %s SCL unexpected low while pulling SDA low!\n",
-			name);
-		goto bailout;
-	}		
-	sdahi(adap);
-	printk("i2c-algo-pcf.o:2 scl: %d  sda: %d \n",getscl(adap),
-	       getsda(adap));
-	if ( 0 == getsda(adap) ) {
-		printk("i2c-algo-pcf.o: %s SDA stuck low!\n",name);
-		sdahi(adap);
-		goto bailout;
-	}
-	if ( 0 == getscl(adap) ) {
-		printk("i2c-algo-pcf.o: %s SCL unexpected low while SDA high!\n",
-		       adap->name);
-	goto bailout;
-	}
-	scllo(adap);
-	printk("i2c-algo-pcf.o:3 scl: %d  sda: %d \n",getscl(adap),
-	       getsda(adap));
-	if ( 0 != getscl(adap) ) {
-		printk("i2c-algo-pcf.o: %s SCL stuck high!\n",name);
-		sclhi(adap);
-		goto bailout;
-	}
-	if ( 0 == getsda(adap) ) {
-		printk("i2c-algo-pcf.o: %s SDA unexpected low while pulling SCL low!\n",
-			name);
-		goto bailout;
-	}
-	sclhi(adap);
-	printk("i2c-algo-pcf.o:4 scl: %d  sda: %d \n",getscl(adap),
-	       getsda(adap));
-	if ( 0 == getscl(adap) ) {
-		printk("i2c-algo-pcf.o: %s SCL stuck low!\n",name);
-		sclhi(adap);
-		goto bailout;
-	}
-	if ( 0 == getsda(adap) ) {
-		printk("i2c-algo-pcf.o: %s SDA unexpected low while SCL high!\n",
-			name);
-		goto bailout;
+	/* check to see PCF is realy idled and we can access status register */
+	if ((temp = get_pcf(adap, 1)) != (I2C_PCF_PIN | I2C_PCF_BB)) {
+		DEB2(printk("i2c-algo-pcf.o: PCF detection failed -- can't select S1` (0x%02x).\n", temp));
+		return -ENXIO;
 	}
-	printk("i2c-algo-pcf.o: %s passed test.\n",name);
+	
+	printk("i2c-algo-pcf.o: deteted and initialized PCF8584.\n");
+
 	return 0;
-bailout:
-	sdahi(adap);
-	sclhi(adap);
-	return -ENODEV;
-#endif
-	return (0);
 }
 
+
 /* ----- Utility functions
  */
@@ -288,6 +222,6 @@
 
 
-static int pcf_sendbytes(struct i2c_adapter *i2c_adap,const char *buf,
-                         int count)
+static int pcf_sendbytes(struct i2c_adapter *i2c_adap, const char *buf,
+                         int count, int last)
 {
 	struct i2c_algo_pcf_data *adap = i2c_adap->algo_data;
@@ -300,5 +234,5 @@
 		timeout = wait_for_pin(adap, &status);
 		if (timeout) {
-			i2c_stop(adap);
+			i2c_stop(adap); 
 			printk("i2c-algo-pcf.o: %s i2c_write: "
 			       "error - timeout.\n", i2c_adap->name);
@@ -307,5 +241,5 @@
 #ifndef STUB_I2C
 		if (status & I2C_PCF_LRB) {
-			i2c_stop(adap);
+			i2c_stop(adap); 
 			printk("i2c-algo-pcf.o: %s i2c_write: "
 			       "error - no ack.\n", i2c_adap->name);
@@ -314,56 +248,57 @@
 #endif
 	}
-	i2c_stop(adap);
+	if (last) {
+		i2c_stop(adap); 
+	}
+	else {
+		i2c_repstart(adap);
+	}
+
 	return (wrcount);
 }
 
 
-static int pcf_readbytes(struct i2c_adapter *i2c_adap, char *buf, int count)
+static int pcf_readbytes(struct i2c_adapter *i2c_adap, char *buf,
+                         int count, int last)
 {
-	int rdcount=0, i, status, timeout, dummy=1;
+	int i, status;
 	struct i2c_algo_pcf_data *adap = i2c_adap->algo_data;
-    
-	for (i=0; i<count; ++i) {
-		buf[rdcount] = i2c_inb(adap);
-		if (dummy) {
-			dummy = 0;
-		} else {
-			rdcount++;
-		}
-		timeout = wait_for_pin(adap, &status);
-		if (timeout) {
-			i2c_stop(adap);
-			printk("i2c-algo-pcf.o: i2c_read: "
-			       "i2c_inb timed out.\n");
+
+	/* increment number of bytes to read by one -- read dummy byte */
+	for (i = 0; i <= count; i++) {
+
+		if (wait_for_pin(adap, &status)) {
+			i2c_stop(adap); 
+			printk("i2c-algo-pcf.o: pcf_readbytes timed out.\n");
 			return (-1);
 		}
+
 #ifndef STUB_I2C
-		if (status & I2C_PCF_LRB) {
-			i2c_stop(adap);
+		if ((status & I2C_PCF_LRB) && (i != count)) {
+			i2c_stop(adap); 
 			printk("i2c-algo-pcf.o: i2c_read: i2c_inb, No ack.\n");
 			return (-1);
 		}
 #endif
-	}
-	set_pcf(adap, 1, I2C_PCF_ESO);
-	buf[rdcount] = i2c_inb(adap);
-	if (dummy) {
-		dummy = 0;
-	} else {
-		rdcount++;
-	}
-	timeout = wait_for_pin(adap, &status);
-	if (timeout) {
-		i2c_stop(adap);
-		printk("i2c-algo-pcf.o: i2c_read: i2c_inb timed out.\n");
-		return (-1);
-	}
-    
-	i2c_stop(adap);
+		
+		if (i == count - 1) {
+			set_pcf(adap, 1, I2C_PCF_ESO);
+		} else 
+		if (i == count) {
+			if (last) {
+				i2c_stop(adap); 
+			} else {
+				i2c_repstart(adap);
+			}
+		};
 
-	/* Read final byte from S0 register */
-	buf[rdcount++] = i2c_inb(adap);
+		if (i) {
+			buf[i - 1] = i2c_inb(adap);
+		} else {
+			i2c_inb(adap); /* dummy read */
+		}
+	}
 
-	return (rdcount);
+	return (i - 1);
 }
 
@@ -419,14 +354,8 @@
 	struct i2c_algo_pcf_data *adap = i2c_adap->algo_data;
 	struct i2c_msg *pmsg;
-	int i = 0;
-	int ret, timeout, status;
-    
-	pmsg = &msgs[i];
-    
-	/* Send address here if Read */
-	if (pmsg->flags & I2C_M_RD) {
-		ret = pcf_doAddress(adap, pmsg, i2c_adap->retries);
-	}
+	int i;
+	int ret=0, timeout, status;
     
+
 	/* Check for bus busy */
 	timeout = wait_for_bb(adap);
@@ -436,58 +365,66 @@
 		return -EIO;
 	}
+	
+	for (i = 0;ret >= 0 && i < num; i++) {
+		pmsg = &msgs[i];
+
+		DEB2(printk("i2c-algo-pcf.o: Doing %s %d bytes to 0x%02x - %d of %d messages\n",
+		     pmsg->flags & I2C_M_RD ? "read" : "write",
+                     pmsg->len, pmsg->addr, i + 1, num);)
     
-	/* Send address here if Write */
-	if (!(pmsg->flags & I2C_M_RD)) {
 		ret = pcf_doAddress(adap, pmsg, i2c_adap->retries);
-	}
-	/* Send START */
-	i2c_start(adap);
+
+		/* Send START */
+		if (i == 0) {
+			i2c_start(adap); 
+		}
     
-	/* Wait for PIN (pending interrupt NOT) */
-	timeout = wait_for_pin(adap, &status);
-	if (timeout) {
-		i2c_stop(adap);
-		DEB2(printk("i2c-algo-pcf.o: Timeout waiting "
-		            "for PIN(1) in pcf_xfer\n");)
-		return (-EREMOTEIO);
-	}
+		/* Wait for PIN (pending interrupt NOT) */
+		timeout = wait_for_pin(adap, &status);
+		if (timeout) {
+			i2c_stop(adap);
+			DEB2(printk("i2c-algo-pcf.o: Timeout waiting "
+				    "for PIN(1) in pcf_xfer\n");)
+			return (-EREMOTEIO);
+		}
     
 #ifndef STUB_I2C
-	/* Check LRB (last rcvd bit - slave ack) */
-	if (status & I2C_PCF_LRB) {
-		i2c_stop(adap);
-		DEB2(printk("i2c-algo-pcf.o: No LRB(1) in pcf_xfer\n");)
-		return (-EREMOTEIO);
-	}
+		/* Check LRB (last rcvd bit - slave ack) */
+		if (status & I2C_PCF_LRB) {
+			i2c_stop(adap);
+			DEB2(printk("i2c-algo-pcf.o: No LRB(1) in pcf_xfer\n");)
+			return (-EREMOTEIO);
+		}
 #endif
     
-	DEB3(printk("i2c-algo-pcf.o: Msg %d, addr=0x%x, flags=0x%x, len=%d\n",
-	            i, msgs[i].addr, msgs[i].flags, msgs[i].len);)
+		DEB3(printk("i2c-algo-pcf.o: Msg %d, addr=0x%x, flags=0x%x, len=%d\n",
+			    i, msgs[i].addr, msgs[i].flags, msgs[i].len);)
     
-	/* Read */
-	if (pmsg->flags & I2C_M_RD) {
-        
-		/* read bytes into buffer*/
-		ret = pcf_readbytes(i2c_adap, pmsg->buf, pmsg->len);
-        
-		if (ret != pmsg->len) {
-			DEB2(printk("i2c-algo-pcf.o: fail: "
-			            "only read %d bytes.\n",ret));
-		} else {
-			DEB2(printk("i2c-algo-pcf.o: read %d bytes.\n",ret));
-		}
-	} else { /* Write */
+		/* Read */
+		if (pmsg->flags & I2C_M_RD) {
+			/* read bytes into buffer*/
+			ret = pcf_readbytes(i2c_adap, pmsg->buf, pmsg->len,
+                                            (i + 1 == num));
         
-        /* Write bytes from buffer */
-		ret = pcf_sendbytes(i2c_adap, pmsg->buf, pmsg->len);
+			if (ret != pmsg->len) {
+				DEB2(printk("i2c-algo-pcf.o: fail: "
+					    "only read %d bytes.\n",ret));
+			} else {
+				DEB2(printk("i2c-algo-pcf.o: read %d bytes.\n",ret));
+			}
+		} else { /* Write */
+			ret = pcf_sendbytes(i2c_adap, pmsg->buf, pmsg->len,
+                                            (i + 1 == num));
         
-		if (ret != pmsg->len) {
-			DEB2(printk("i2c-algo-pcf.o: fail: "
-			            "only wrote %d bytes.\n",ret));
-		} else {
-			DEB2(printk("i2c-algo-pcf.o: wrote %d bytes.\n",ret));
+			if (ret != pmsg->len) {
+				DEB2(printk("i2c-algo-pcf.o: fail: "
+					    "only wrote %d bytes.\n",ret));
+			} else {
+				DEB2(printk("i2c-algo-pcf.o: wrote %d bytes.\n",ret));
+			}
 		}
 	}
-	return (num);
+
+	return (i);
 }
 
@@ -525,10 +462,4 @@
 	struct i2c_algo_pcf_data *pcf_adap = adap->algo_data;
 
-	if (pcf_test) {
-		int ret = test_bus(pcf_adap, adap->name);
-		if (ret<0)
-			return -ENODEV;
-	}
-
 	DEB2(printk("i2c-algo-pcf.o: hw routines for %s registered.\n",
 	            adap->name));
@@ -539,7 +470,11 @@
 	adap->algo = &pcf_algo;
 
-	adap->timeout = 100;	/* default values, should	*/
+	adap->timeout = 100;		/* default values, should	*/
 	adap->retries = 3;		/* be replaced by defines	*/
 
+	if ((i = pcf_init_8584(pcf_adap))) {
+		return i;
+	}
+
 #ifdef MODULE
 	MOD_INC_USE_COUNT;
@@ -547,5 +482,4 @@
 
 	i2c_add_adapter(adap);
-	pcf_init_8584(pcf_adap);
 
 	/* scan bus */
@@ -554,4 +488,9 @@
 		       adap->name);
 		for (i = 0x00; i < 0xff; i+=2) {
+			if (wait_for_bb(pcf_adap)) {
+    			printk(KERN_INFO " i2c-algo-pcf.o: scanning bus %s - TIMEOUTed.\n",
+		           adap->name);
+			    break;
+			}
 			i2c_outb(pcf_adap, i);
 			i2c_start(pcf_adap);
@@ -598,9 +537,7 @@
 MODULE_DESCRIPTION("I2C-Bus PCF8584 algorithm");
 
-MODULE_PARM(pcf_test, "i");
 MODULE_PARM(pcf_scan, "i");
 MODULE_PARM(i2c_debug,"i");
 
-MODULE_PARM_DESC(pcf_test, "Test if the I2C bus is available");
 MODULE_PARM_DESC(pcf_scan, "Scan for active chips on the bus");
 MODULE_PARM_DESC(i2c_debug,
--- linux-old/drivers/i2c/i2c-core.c	Mon Jul 23 01:39:52 CEST 2001
+++ linux/drivers/i2c/i2c-core.c	Mon Jul 23 01:39:52 CEST 2001
@@ -21,5 +21,5 @@
    All SMBus-related things are written by Frodo Looijaard <frodol@dds.nl> */
 
-/* $Id: i2c-core.c,v 1.58 2000/10/29 22:57:38 frodo Exp $ */
+/* $Id: i2c-core.c,v 1.61 2001/06/05 01:50:31 mds Exp $ */
 
 #include <linux/module.h>
@@ -249,5 +249,5 @@
 			if ((res=client->driver->detach_client(client))) {
 				printk("i2c-core.o: adapter %s not "
-					"unregisted, because client at "
+					"unregistered, because client at "
 					"address %02x can't be detached. ",
 					adap->name, client->addr);
@@ -659,5 +659,5 @@
 	int order[I2C_CLIENT_MAX];
 
-	if (count < 0)
+	if (count > 4000)
 		return -EINVAL; 
 	len_total = file->f_pos + count;
@@ -1278,12 +1278,36 @@
 
 #ifndef MODULE
+#ifdef CONFIG_I2C_CHARDEV
 	extern int i2c_dev_init(void);
+#endif
+#ifdef CONFIG_I2C_ALGOBIT
 	extern int i2c_algo_bit_init(void);
+#endif
+#ifdef CONFIG_I2C_BITLP
 	extern int i2c_bitlp_init(void);
+#endif
+#ifdef CONFIG_I2C_BITELV
 	extern int i2c_bitelv_init(void);
+#endif
+#ifdef CONFIG_I2C_BITVELLE
 	extern int i2c_bitvelle_init(void);
+#endif
+#ifdef CONFIG_I2C_BITVIA
 	extern int i2c_bitvia_init(void);
+#endif
+
+#ifdef CONFIG_I2C_ALGOPCF
 	extern int i2c_algo_pcf_init(void);	
+#endif
+#ifdef CONFIG_I2C_PCFISA
 	extern int i2c_pcfisa_init(void);
+#endif
+
+#ifdef CONFIG_I2C_ALGO8XX
+	extern int i2c_algo_8xx_init(void);
+#endif
+#ifdef CONFIG_I2C_RPXLITE
+	extern int i2c_rpx_init(void);
+#endif
 
 /* This is needed for automatic patch generation: sensors code starts here */
@@ -1318,4 +1342,12 @@
 #ifdef CONFIG_I2C_ELEKTOR
 	i2c_pcfisa_init();
+#endif
+
+	/* --------------------- 8xx -------- */
+#ifdef CONFIG_I2C_ALGO8XX
+	i2c_algo_8xx_init();
+#endif
+#ifdef CONFIG_I2C_RPXLITE
+	i2c_rpx_init();
 #endif
 /* This is needed for automatic patch generation: sensors code starts here */
--- linux-old/drivers/i2c/i2c-dev.c	Mon Jul 23 01:39:53 CEST 2001
+++ linux/drivers/i2c/i2c-dev.c	Mon Jul 23 01:39:53 CEST 2001
@@ -29,5 +29,5 @@
    <pmhahn@titan.lahn.de> */
 
-/* $Id: i2c-dev.c,v 1.36 2000/09/22 02:19:35 mds Exp $ */
+/* $Id: i2c-dev.c,v 1.38 2001/04/27 17:53:04 frodo Exp $ */
 
 #include <linux/config.h>
@@ -242,7 +242,4 @@
 			return -EFAULT;
 
-		if(rdwr_arg.nmsgs > 2048)
-			return -EINVAL;
-			
 		rdwr_pa = (struct i2c_msg *)
 			kmalloc(rdwr_arg.nmsgs * sizeof(struct i2c_msg), 
@@ -520,5 +517,5 @@
 			return res;
 		}
-	i2cdev_initialized ++;
+	i2cdev_initialized --;
 	}
 
--- linux-old/drivers/i2c/i2c-elektor.c	Mon Jul 23 01:39:54 CEST 2001
+++ linux/drivers/i2c/i2c-elektor.c	Mon Jul 23 01:39:54 CEST 2001
@@ -23,5 +23,6 @@
    Frodo Looijaard <frodol@dds.nl> */
 
-/* $Id: i2c-elektor.c,v 1.19 2000/07/25 23:52:17 frodo Exp $ */
+/* Partialy rewriten by Oleg I. Vdovikin for mmapped support of 
+   for Alpha Processor Inc. UP-2000(+) boards */
 
 #include <linux/kernel.h>
@@ -32,4 +33,5 @@
 #include <linux/version.h>
 #include <linux/init.h>
+#include <linux/pci.h>
 #include <asm/irq.h>
 #include <asm/io.h>
@@ -40,15 +42,18 @@
 #include "i2c-pcf8584.h"
 
-#define DEFAULT_BASE 0x300
-#define DEFAULT_IRQ      0
-#define DEFAULT_CLOCK 0x1c
-#define DEFAULT_OWN   0x55
-
-static int base  = 0;
-static int irq   = 0;
-static int clock = 0;
-static int own   = 0;
-static int i2c_debug=0;
-static struct i2c_pcf_isa gpi;
+#define DEFAULT_BASE 0x330
+
+static int base   = 0;
+static int irq    = 0;
+static int clock  = 0x1c;
+static int own    = 0x55;
+static int mmapped = 0;
+static int i2c_debug = 0;
+
+/* vdovikin: removed static struct i2c_pcf_isa gpi; code - 
+  this module in real supports only one device, due to missing arguments
+  in some functions, called from the algo-pcf module. Sometimes it's
+  need to be rewriten - but for now just remove this for simpler reading */
+
 #if (LINUX_VERSION_CODE < 0x020301)
 static struct wait_queue *pcf_wait = NULL;
@@ -64,31 +69,27 @@
 #define DEBE(x)	x	/* error messages 				*/
 
-
-/* --- Convenience defines for the i2c port:			*/
-#define BASE	((struct i2c_pcf_isa *)(data))->pi_base
-#define DATA	BASE			/* Adapter data port		*/
-#define CTRL	(BASE+1)		/* Adapter control port	        */
-
 /* ----- local functions ----------------------------------------------	*/
 
 static void pcf_isa_setbyte(void *data, int ctl, int val)
 {
-        unsigned long j = jiffies + 10;
+	int address = ctl ? (base + 1) : base;
 
-        if (ctl) {
-		if (gpi.pi_irq > 0) {
-			DEB3(printk("i2c-elektor.o: Write Ctrl 0x%02X\n",
-			     val|I2C_PCF_ENI));
-                        DEB3({while (jiffies < j) schedule();})
-			outb(val | I2C_PCF_ENI, CTRL);
-		} else {
-			 DEB3(printk("i2c-elektor.o: Write Ctrl 0x%02X\n", val|I2C_PCF_ENI));
-                         DEB3({while (jiffies < j) schedule();})
-			 outb(val|I2C_PCF_ENI, CTRL);
-		}
-	} else {
-		DEB3(printk("i2c-elektor.o: Write Data 0x%02X\n", val&0xff));
-                DEB3({while (jiffies < j) schedule();})
-		outb(val, DATA);
+	if (ctl && irq) {
+		val |= I2C_PCF_ENI;
+	}
+
+	DEB3(printk("i2c-elektor.o: Write 0x%X 0x%02X\n", address, val & 255));
+
+	switch (mmapped) {
+	case 0: /* regular I/O */
+		outb(val, address);
+		break;
+	case 2: /* double mapped I/O needed for UP2000 board,
+                   I don't know why this... */
+		writeb(val, address);
+		/* fall */
+	case 1: /* memory mapped I/O */
+		writeb(val, address);
+		break;
 	}
 }
@@ -96,13 +97,9 @@
 static int pcf_isa_getbyte(void *data, int ctl)
 {
-	int val;
+	int address = ctl ? (base + 1) : base;
+	int val = mmapped ? readb(address) : inb(address);
+
+	DEB3(printk("i2c-elektor.o: Read 0x%X 0x%02X\n", address, val));
 
-	if (ctl) {
-		val = inb(CTRL);
-		DEB3(printk("i2c-elektor.o: Read Ctrl 0x%02X\n", val));
-	} else {
-		val = inb(DATA);
-		DEB3(printk("i2c-elektor.o: Read Data 0x%02X\n", val));
-	}
 	return (val);
 }
@@ -110,5 +107,5 @@
 static int pcf_isa_getown(void *data)
 {
-	return (gpi.pi_own);
+	return (own);
 }
 
@@ -116,16 +113,6 @@
 static int pcf_isa_getclock(void *data)
 {
-	return (gpi.pi_clock);
-}
-
-
-
-#if 0
-static void pcf_isa_sleep(unsigned long timeout)
-{
-	schedule_timeout( timeout * HZ);
+	return (clock);
 }
-#endif
-
 
 static void pcf_isa_waitforpin(void) {
@@ -133,10 +120,10 @@
 	int timeout = 2;
 
-	if (gpi.pi_irq > 0) {
+	if (irq > 0) {
 		cli();
-	if (pcf_pending == 0) {
-		interruptible_sleep_on_timeout(&pcf_wait, timeout*HZ );
-	} else
-		pcf_pending = 0;
+		if (pcf_pending == 0) {
+			interruptible_sleep_on_timeout(&pcf_wait, timeout*HZ );
+		} else
+			pcf_pending = 0;
 		sti();
 	} else {
@@ -154,16 +141,18 @@
 static int pcf_isa_init(void)
 {
-	if (check_region(gpi.pi_base, 2) < 0 ) {
-		return -ENODEV;
-	} else {
-		request_region(gpi.pi_base, 2, "i2c (isa bus adapter)");
+	if (!mmapped) {
+		if (check_region(base, 2) < 0 ) {
+			printk("i2c-elektor.o: requested I/O region (0x%X:2) is in use.\n", base);
+			return -ENODEV;
+		} else {
+			request_region(base, 2, "i2c (isa bus adapter)");
+		}
 	}
-	if (gpi.pi_irq > 0) {
-		if (request_irq(gpi.pi_irq, pcf_isa_handler, 0, "PCF8584", 0)
-		    < 0) {
-		printk("i2c-elektor.o: Request irq%d failed\n", gpi.pi_irq);
-		gpi.pi_irq = 0;
-	} else
-		enable_irq(gpi.pi_irq);
+	if (irq > 0) {
+		if (request_irq(irq, pcf_isa_handler, 0, "PCF8584", 0) < 0) {
+			printk("i2c-elektor.o: Request irq%d failed\n", irq);
+			irq = 0;
+		} else
+			enable_irq(irq);
 	}
 	return 0;
@@ -173,9 +162,11 @@
 static void pcf_isa_exit(void)
 {
-	if (gpi.pi_irq > 0) {
-		disable_irq(gpi.pi_irq);
-		free_irq(gpi.pi_irq, 0);
+	if (irq > 0) {
+		disable_irq(irq);
+		free_irq(irq, 0);
+	}
+	if (!mmapped) {
+		release_region(base , 2);
 	}
-	release_region(gpi.pi_base , 2);
 }
 
@@ -218,5 +209,5 @@
 	pcf_isa_getclock,
 	pcf_isa_waitforpin,
-	80, 80, 100,		/*	waits, timeout */
+	10, 10, 100,		/*	waits, timeout */
 };
 
@@ -234,29 +225,59 @@
 int __init i2c_pcfisa_init(void) 
 {
+#ifdef __alpha__
+	/* check to see we have memory mapped PCF8584 connected to the 
+	Cypress cy82c693 PCI-ISA bridge as on UP2000 board */
+	if ((base == 0) && pci_present()) {
+		
+		struct pci_dev *cy693_dev =
+                    pci_find_device(PCI_VENDOR_ID_CONTAQ, 
+		                    PCI_DEVICE_ID_CONTAQ_82C693, NULL);
+
+		if (cy693_dev) {
+			char config;
+			/* yeap, we've found cypress, let's check config */
+			if (!pci_read_config_byte(cy693_dev, 0x47, &config)) {
+				
+				DEB3(printk("i2c-elektor.o: found cy82c693, config register 0x47 = 0x%02x.\n", config));
+
+				/* UP2000 board has this register set to 0xe1,
+                                   but the most significant bit as seems can be 
+				   reset during the proper initialisation
+                                   sequence if guys from API decides to do that
+                                   (so, we can even enable Tsunami Pchip
+                                   window for the upper 1 Gb) */
+
+				/* so just check for ROMCS at 0xe0000,
+                                   ROMCS enabled for writes
+				   and external XD Bus buffer in use. */
+				if ((config & 0x7f) == 0x61) {
+					/* seems to be UP2000 like board */
+					base = 0xe0000;
+                                        /* I don't know why we need to
+                                           write twice */
+					mmapped = 2;
+                                        /* UP2000 drives ISA with
+					   8.25 MHz (PCI/4) clock
+					   (this can be read from cypress) */
+					clock = I2C_PCF_CLK | I2C_PCF_TRNS90;
+					printk("i2c-elektor.o: found API UP2000 like board, will probe PCF8584 later.\n");
+				}
+			}
+		}
+	}
+#endif
 
-	struct i2c_pcf_isa *pisa = &gpi;
+	/* sanity checks for mmapped I/O */
+	if (mmapped && base < 0xc8000) {
+		printk("i2c-elektor.o: incorrect base address (0x%0X) specified for mmapped I/O.\n", base);
+		return -ENODEV;
+	}
 
 	printk("i2c-elektor.o: i2c pcf8584-isa adapter module\n");
-	if (base == 0)
-		pisa->pi_base = DEFAULT_BASE;
-	else
-		pisa->pi_base = base;
-
-	if (irq == 0)
-		pisa->pi_irq = DEFAULT_IRQ;
-	else
-		pisa->pi_irq = irq;
-
-	if (clock == 0)
-		pisa->pi_clock = DEFAULT_CLOCK;
-	else
-		pisa->pi_clock = clock;
-
-	if (own == 0)
-		pisa->pi_own = DEFAULT_OWN;
-	else
-		pisa->pi_own = own;
 
-	pcf_isa_data.data = (void *)pisa;
+	if (base == 0) {
+		base = DEFAULT_BASE;
+	}
+
 #if (LINUX_VERSION_CODE >= 0x020301)
 	init_waitqueue_head(&pcf_wait);
@@ -268,5 +289,7 @@
 		return -ENODEV;
 	}
-	printk("i2c-elektor.o: found device at %#x.\n", pisa->pi_base);
+	
+	printk("i2c-elektor.o: found device at %#x.\n", base);
+
 	return 0;
 }
@@ -283,5 +306,6 @@
 MODULE_PARM(clock, "i");
 MODULE_PARM(own, "i");
-MODULE_PARM(i2c_debug,"i");
+MODULE_PARM(mmapped, "i");
+MODULE_PARM(i2c_debug, "i");
 
 int init_module(void) 
--- linux-old/include/linux/i2c-elektor.h	Mon Jul 23 01:39:54 CEST 2001
+++ linux/include/linux/i2c-elektor.h	Mon Jul 23 01:39:54 CEST 2001
@@ -23,5 +23,5 @@
    Frodo Looijaard <frodol@dds.nl> */
 
-/* $Id: i2c-elektor.h,v 1.4 2000/01/18 23:54:07 frodo Exp $ */
+/* $Id: i2c-elektor.h,v 1.5 2001/06/05 01:46:33 mds Exp $ */
 
 #ifndef I2C_PCF_ELEKTOR_H
@@ -29,8 +29,12 @@
 
 /*
- * This struct contains the hw-dependent functions of PCF8584 adapters to 
- * manipulate the registers, and to init any hw-specific features. 
- */
+ * This struct contains the hw-dependent functions of PCF8584 adapters to
+ * manipulate the registers, and to init any hw-specific features.
+ * vdovikin: removed: this module in real supports only one device,
+ * due to missing arguments in some functions, called from the algo-pcf module.
+ * Sometimes it's need to be rewriten -
+ * but for now just remove this for simpler reading */
 
+/*
 struct i2c_pcf_isa {
 	int pi_base;
@@ -39,5 +43,5 @@
 	int pi_own;
 };
-
+*/
 
 #endif /* PCF_ELEKTOR_H */
--- linux-old/include/linux/i2c-id.h	Mon Jul 23 01:39:55 CEST 2001
+++ linux/include/linux/i2c-id.h	Mon Jul 23 01:39:55 CEST 2001
@@ -21,5 +21,5 @@
 /* ------------------------------------------------------------------------- */
 
-/* $Id: i2c-id.h,v 1.25 2000/10/12 07:27:29 simon Exp $ */
+/* $Id: i2c-id.h,v 1.33 2001/06/06 06:16:53 simon Exp $ */
 
 #ifndef I2C_ID_H
@@ -66,5 +66,5 @@
 #define I2C_DRIVERID_TDA9850	20	/* audio mixer			*/
 #define I2C_DRIVERID_TDA9855	21	/* audio mixer			*/
-#define I2C_DRIVERID_SAA7110	22	/* 				*/
+#define I2C_DRIVERID_SAA7110	22	/* video decoder		*/
 #define I2C_DRIVERID_MGATVO	23	/* Matrox TVOut			*/
 #define I2C_DRIVERID_SAA5249	24	/* SAA5249 and compatibles	*/
@@ -85,5 +85,10 @@
 #define I2C_DRIVERID_SAA7113	38     /* video decoder			*/
 #define I2C_DRIVERID_TDA8444	39     /* octuple 6-bit DAC             */
-
+#define I2C_DRIVERID_BT819	40     /* video decoder			*/
+#define I2C_DRIVERID_BT856	41     /* video encoder			*/
+#define I2C_DRIVERID_VPX32XX	42     /* video decoder+vbi/vtxt	*/
+#define I2C_DRIVERID_DRP3510	43     /* ADR decoder (Astra Radio)	*/
+#define I2C_DRIVERID_SP5055	44     /* Satellite tuner		*/
+#define I2C_DRIVERID_STV0030	45     /* Multipurpose switch		*/
 
 #define I2C_DRIVERID_EXP0	0xF0	/* experimental use id's	*/
@@ -95,4 +100,32 @@
 #define I2C_DRIVERID_I2CPROC	901
 
+/* IDs --   Use DRIVERIDs 1000-1999 for sensors. 
+   These were originally in sensors.h in the lm_sensors package */
+#define I2C_DRIVERID_LM78 1002
+#define I2C_DRIVERID_LM75 1003
+#define I2C_DRIVERID_GL518 1004
+#define I2C_DRIVERID_EEPROM 1005
+#define I2C_DRIVERID_W83781D 1006
+#define I2C_DRIVERID_LM80 1007
+#define I2C_DRIVERID_ADM1021 1008
+#define I2C_DRIVERID_ADM9240 1009
+#define I2C_DRIVERID_LTC1710 1010
+#define I2C_DRIVERID_SIS5595 1011
+#define I2C_DRIVERID_ICSPLL 1012
+#define I2C_DRIVERID_BT869 1013
+#define I2C_DRIVERID_MAXILIFE 1014
+#define I2C_DRIVERID_MATORB 1015
+#define I2C_DRIVERID_GL520 1016
+#define I2C_DRIVERID_THMC50 1017
+#define I2C_DRIVERID_DDCMON 1018
+#define I2C_DRIVERID_VIA686A 1019
+#define I2C_DRIVERID_ADM1025 1020
+#define I2C_DRIVERID_LM87 1021
+#define I2C_DRIVERID_PCF8574 1022
+#define I2C_DRIVERID_MTP008 1023
+#define I2C_DRIVERID_DS1621 1024
+#define I2C_DRIVERID_ADM1024 1025
+#define I2C_DRIVERID_IT87 1026
+
 /*
  * ---- Adapter types ----------------------------------------------------
@@ -142,5 +175,5 @@
 #define I2C_HW_B_RIVA	0x10	/* Riva based graphics cards		*/
 #define I2C_HW_B_IOC	0x11	/* IOC bit-wiggling			*/
-
+#define I2C_HW_B_TSUNA  0x12	/* DEC Tsunami chipset			*/
 /* --- PCF 8584 based algorithms					*/
 #define I2C_HW_P_LP	0x00	/* Parallel port interface		*/
--- linux-old/drivers/i2c/i2c-proc.c	Mon Jul 23 01:39:58 CEST 2001
+++ linux/drivers/i2c/i2c-proc.c	Mon Jul 23 01:39:58 CEST 2001
@@ -0,0 +1,906 @@
+/*
+    i2c-proc.c - Part of lm_sensors, Linux kernel modules for hardware
+                monitoring
+    Copyright (c) 1998 - 2001 Frodo Looijaard <frodol@dds.nl> and
+    Mark D. Studebaker <mdsxyz123@yahoo.com>
+
+    This program is free software; you can redistribute it and/or modify
+    it under the terms of the GNU General Public License as published by
+    the Free Software Foundation; either version 2 of the License, or
+    (at your option) any later version.
+
+    This program is distributed in the hope that it will be useful,
+    but WITHOUT ANY WARRANTY; without even the implied warranty of
+    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+    GNU General Public License for more details.
+
+    You should have received a copy of the GNU General Public License
+    along with this program; if not, write to the Free Software
+    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+*/
+
+/*
+    This driver puts entries in /proc/sys/dev/sensors for each I2C device
+*/
+
+#include <linux/version.h>
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/slab.h>
+#include <linux/ctype.h>
+#include <linux/sysctl.h>
+#include <linux/proc_fs.h>
+#include <linux/ioport.h>
+#include <asm/uaccess.h>
+
+#include <linux/i2c.h>
+#include <linux/i2c-proc.h>
+
+#include <linux/init.h>
+
+/* FIXME need i2c versioning */
+#define LM_DATE "20010228"
+#define LM_VERSION "2.6.0"
+
+#ifndef THIS_MODULE
+#define THIS_MODULE NULL
+#endif
+
+static int i2c_create_name(char **name, const char *prefix,
+			       struct i2c_adapter *adapter, int addr);
+static int i2c_parse_reals(int *nrels, void *buffer, int bufsize,
+			       long *results, int magnitude);
+static int i2c_write_reals(int nrels, void *buffer, int *bufsize,
+			       long *results, int magnitude);
+static int i2c_proc_chips(ctl_table * ctl, int write,
+			      struct file *filp, void *buffer,
+			      size_t * lenp);
+static int i2c_sysctl_chips(ctl_table * table, int *name, int nlen,
+				void *oldval, size_t * oldlenp,
+				void *newval, size_t newlen,
+				void **context);
+
+int __init sensors_init(void);
+
+#define SENSORS_ENTRY_MAX 20
+static struct ctl_table_header *i2c_entries[SENSORS_ENTRY_MAX];
+
+static struct i2c_client *i2c_clients[SENSORS_ENTRY_MAX];
+static unsigned short i2c_inodes[SENSORS_ENTRY_MAX];
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,3,1)
+static void i2c_fill_inode(struct inode *inode, int fill);
+static void i2c_dir_fill_inode(struct inode *inode, int fill);
+#endif			/* LINUX_VERSION_CODE < KERNEL_VERSION(2,3,1) */
+
+static ctl_table sysctl_table[] = {
+	{CTL_DEV, "dev", NULL, 0, 0555},
+	{0},
+	{DEV_SENSORS, "sensors", NULL, 0, 0555},
+	{0},
+	{0, NULL, NULL, 0, 0555},
+	{0}
+};
+
+static ctl_table i2c_proc_dev_sensors[] = {
+	{SENSORS_CHIPS, "chips", NULL, 0, 0644, NULL, &i2c_proc_chips,
+	 &i2c_sysctl_chips},
+	{0}
+};
+
+static ctl_table i2c_proc_dev[] = {
+	{DEV_SENSORS, "sensors", NULL, 0, 0555, i2c_proc_dev_sensors},
+	{0},
+};
+
+
+static ctl_table i2c_proc[] = {
+	{CTL_DEV, "dev", NULL, 0, 0555, i2c_proc_dev},
+	{0}
+};
+
+
+static struct ctl_table_header *i2c_proc_header;
+static int i2c_initialized;
+
+/* This returns a nice name for a new directory; for example lm78-isa-0310
+   (for a LM78 chip on the ISA bus at port 0x310), or lm75-i2c-3-4e (for
+   a LM75 chip on the third i2c bus at address 0x4e).  
+   name is allocated first. */
+int i2c_create_name(char **name, const char *prefix,
+			struct i2c_adapter *adapter, int addr)
+{
+	char name_buffer[50];
+	int id;
+	if (i2c_is_isa_adapter(adapter))
+		sprintf(name_buffer, "%s-isa-%04x", prefix, addr);
+	else {
+		if ((id = i2c_adapter_id(adapter)) < 0)
+			return -ENOENT;
+		sprintf(name_buffer, "%s-i2c-%d-%02x", prefix, id, addr);
+	}
+	*name = kmalloc(strlen(name_buffer) + 1, GFP_KERNEL);
+	strcpy(*name, name_buffer);
+	return 0;
+}
+
+/* This rather complex function must be called when you want to add an entry
+   to /proc/sys/dev/sensors/chips. It also creates a new directory within 
+   /proc/sys/dev/sensors/.
+   ctl_template should be a template of the newly created directory. It is
+   copied in memory. The extra2 field of each file is set to point to client.
+   If any driver wants subdirectories within the newly created directory,
+   this function must be updated! 
+   controlling_mod is the controlling module. It should usually be
+   THIS_MODULE when calling. Note that this symbol is not defined in
+   kernels before 2.3.13; define it to NULL in that case. We will not use it
+   for anything older than 2.3.27 anyway. */
+int i2c_register_entry(struct i2c_client *client, const char *prefix,
+			   ctl_table * ctl_template,
+			   struct module *controlling_mod)
+{
+	int i, res, len, id;
+	ctl_table *new_table;
+	char *name;
+	struct ctl_table_header *new_header;
+
+	if ((res = i2c_create_name(&name, prefix, client->adapter,
+				       client->addr))) return res;
+
+	for (id = 0; id < SENSORS_ENTRY_MAX; id++)
+		if (!i2c_entries[id]) {
+			break;
+		}
+	if (id == SENSORS_ENTRY_MAX) {
+		kfree(name);
+		return -ENOMEM;
+	}
+	id += 256;
+
+	len = 0;
+	while (ctl_template[len].procname)
+		len++;
+	len += 7;
+	if (!(new_table = kmalloc(sizeof(ctl_table) * len, GFP_KERNEL))) {
+		kfree(name);
+		return -ENOMEM;
+	}
+
+	memcpy(new_table, sysctl_table, 6 * sizeof(ctl_table));
+	new_table[0].child = &new_table[2];
+	new_table[2].child = &new_table[4];
+	new_table[4].child = &new_table[6];
+	new_table[4].procname = name;
+	new_table[4].ctl_name = id;
+	memcpy(new_table + 6, ctl_template, (len - 6) * sizeof(ctl_table));
+	for (i = 6; i < len; i++)
+		new_table[i].extra2 = client;
+
+	if (!(new_header = register_sysctl_table(new_table, 0))) {
+		kfree(new_table);
+		kfree(name);
+		return -ENOMEM;
+	}
+
+	i2c_entries[id - 256] = new_header;
+
+	i2c_clients[id - 256] = client;
+#ifdef DEBUG
+	if (!new_header || !new_header->ctl_table ||
+	    !new_header->ctl_table->child ||
+	    !new_header->ctl_table->child->child ||
+	    !new_header->ctl_table->child->child->de) {
+		printk
+		    ("i2c-proc.o: NULL pointer when trying to install fill_inode fix!\n");
+		return id;
+	}
+#endif				/* DEBUG */
+	i2c_inodes[id - 256] =
+	    new_header->ctl_table->child->child->de->low_ino;
+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,3,27))
+	new_header->ctl_table->child->child->de->owner = controlling_mod;
+#else
+	new_header->ctl_table->child->child->de->fill_inode =
+	    &i2c_dir_fill_inode;
+#endif	/* (LINUX_VERSION_CODE >= KERNEL_VERSION(2,3,27)) */
+
+	return id;
+}
+
+void i2c_deregister_entry(int id)
+{
+	ctl_table *table;
+	char *temp;
+	id -= 256;
+	if (i2c_entries[id]) {
+		table = i2c_entries[id]->ctl_table;
+		unregister_sysctl_table(i2c_entries[id]);
+		/* 2-step kfree needed to keep gcc happy about const points */
+		(const char *) temp = table[4].procname;
+		kfree(temp);
+		kfree(table);
+		i2c_entries[id] = NULL;
+		i2c_clients[id] = NULL;
+	}
+}
+
+/* Monitor access for /proc/sys/dev/sensors; make unloading i2c-proc.o 
+   impossible if some process still uses it or some file in it */
+void i2c_fill_inode(struct inode *inode, int fill)
+{
+	if (fill)
+		MOD_INC_USE_COUNT;
+	else
+		MOD_DEC_USE_COUNT;
+}
+
+/* Monitor access for /proc/sys/dev/sensors/ directories; make unloading
+   the corresponding module impossible if some process still uses it or
+   some file in it */
+void i2c_dir_fill_inode(struct inode *inode, int fill)
+{
+	int i;
+	struct i2c_client *client;
+
+#ifdef DEBUG
+	if (!inode) {
+		printk("i2c-proc.o: Warning: inode NULL in fill_inode()\n");
+		return;
+	}
+#endif				/* def DEBUG */
+
+	for (i = 0; i < SENSORS_ENTRY_MAX; i++)
+		if (i2c_clients[i]
+		    && (i2c_inodes[i] == inode->i_ino)) break;
+#ifdef DEBUG
+	if (i == SENSORS_ENTRY_MAX) {
+		printk
+		    ("i2c-proc.o: Warning: inode (%ld) not found in fill_inode()\n",
+		     inode->i_ino);
+		return;
+	}
+#endif				/* def DEBUG */
+	client = i2c_clients[i];
+	if (fill)
+		client->driver->inc_use(client);
+	else
+		client->driver->dec_use(client);
+}
+
+int i2c_proc_chips(ctl_table * ctl, int write, struct file *filp,
+		       void *buffer, size_t * lenp)
+{
+	char BUF[SENSORS_PREFIX_MAX + 30];
+	int buflen, curbufsize, i;
+	struct ctl_table *client_tbl;
+
+	if (write)
+		return 0;
+
+	/* If buffer is size 0, or we try to read when not at the start, we
+	   return nothing. Note that I think writing when not at the start
+	   does not work either, but anyway, this is straight from the kernel
+	   sources. */
+	if (!*lenp || (filp->f_pos && !write)) {
+		*lenp = 0;
+		return 0;
+	}
+	curbufsize = 0;
+	for (i = 0; i < SENSORS_ENTRY_MAX; i++)
+		if (i2c_entries[i]) {
+			client_tbl =
+			    i2c_entries[i]->ctl_table->child->child;
+			buflen =
+			    sprintf(BUF, "%d\t%s\n", client_tbl->ctl_name,
+				    client_tbl->procname);
+			if (buflen + curbufsize > *lenp)
+				buflen = *lenp - curbufsize;
+			if(copy_to_user(buffer, BUF, buflen))
+				return -EFAULT;
+			curbufsize += buflen;
+			(char *) buffer += buflen;
+		}
+	*lenp = curbufsize;
+	filp->f_pos += curbufsize;
+	return 0;
+}
+
+int i2c_sysctl_chips(ctl_table * table, int *name, int nlen,
+			 void *oldval, size_t * oldlenp, void *newval,
+			 size_t newlen, void **context)
+{
+	struct i2c_chips_data data;
+	int i, oldlen, nrels, maxels,ret=0;
+	struct ctl_table *client_tbl;
+
+	if (oldval && oldlenp && !((ret = get_user(oldlen, oldlenp))) && 
+	    oldlen) {
+		maxels = oldlen / sizeof(struct i2c_chips_data);
+		nrels = 0;
+		for (i = 0; (i < SENSORS_ENTRY_MAX) && (nrels < maxels);
+		     i++)
+			if (i2c_entries[i]) {
+				client_tbl =
+				    i2c_entries[i]->ctl_table->child->
+				    child;
+				data.sysctl_id = client_tbl->ctl_name;
+				strcpy(data.name, client_tbl->procname);
+				if(copy_to_user(oldval, &data,
+					     sizeof(struct
+						    i2c_chips_data)))
+					return -EFAULT;
+				(char *) oldval +=
+				    sizeof(struct i2c_chips_data);
+				nrels++;
+			}
+		oldlen = nrels * sizeof(struct i2c_chips_data);
+		if(put_user(oldlen, oldlenp))
+			return -EFAULT;
+	}
+	return ret;
+}
+
+
+/* This funcion reads or writes a 'real' value (encoded by the combination
+   of an integer and a magnitude, the last is the power of ten the value
+   should be divided with) to a /proc/sys directory. To use this function,
+   you must (before registering the ctl_table) set the extra2 field to the
+   client, and the extra1 field to a function of the form:
+      void func(struct i2c_client *client, int operation, int ctl_name,
+                int *nrels_mag, long *results)
+   This function can be called for three values of operation. If operation
+   equals SENSORS_PROC_REAL_INFO, the magnitude should be returned in 
+   nrels_mag. If operation equals SENSORS_PROC_REAL_READ, values should
+   be read into results. nrels_mag should return the number of elements
+   read; the maximum number is put in it on entry. Finally, if operation
+   equals SENSORS_PROC_REAL_WRITE, the values in results should be
+   written to the chip. nrels_mag contains on entry the number of elements
+   found.
+   In all cases, client points to the client we wish to interact with,
+   and ctl_name is the SYSCTL id of the file we are accessing. */
+int i2c_proc_real(ctl_table * ctl, int write, struct file *filp,
+		      void *buffer, size_t * lenp)
+{
+#define MAX_RESULTS 32
+	int mag, nrels = MAX_RESULTS;
+	long results[MAX_RESULTS];
+	i2c_real_callback callback = ctl->extra1;
+	struct i2c_client *client = ctl->extra2;
+	int res;
+
+	/* If buffer is size 0, or we try to read when not at the start, we
+	   return nothing. Note that I think writing when not at the start
+	   does not work either, but anyway, this is straight from the kernel
+	   sources. */
+	if (!*lenp || (filp->f_pos && !write)) {
+		*lenp = 0;
+		return 0;
+	}
+
+	/* Get the magnitude */
+	callback(client, SENSORS_PROC_REAL_INFO, ctl->ctl_name, &mag,
+		 NULL);
+
+	if (write) {
+		/* Read the complete input into results, converting to longs */
+		res = i2c_parse_reals(&nrels, buffer, *lenp, results, mag);
+		if (res)
+			return res;
+
+		if (!nrels)
+			return 0;
+
+		/* Now feed this information back to the client */
+		callback(client, SENSORS_PROC_REAL_WRITE, ctl->ctl_name,
+			 &nrels, results);
+
+		filp->f_pos += *lenp;
+		return 0;
+	} else {		/* read */
+		/* Get the information from the client into results */
+		callback(client, SENSORS_PROC_REAL_READ, ctl->ctl_name,
+			 &nrels, results);
+
+		/* And write them to buffer, converting to reals */
+		res = i2c_write_reals(nrels, buffer, lenp, results, mag);
+		if (res)
+			return res;
+		filp->f_pos += *lenp;
+		return 0;
+	}
+}
+
+/* This function is equivalent to i2c_proc_real, only it interacts with
+   the sysctl(2) syscall, and returns no reals, but integers */
+int i2c_sysctl_real(ctl_table * table, int *name, int nlen,
+			void *oldval, size_t * oldlenp, void *newval,
+			size_t newlen, void **context)
+{
+	long results[MAX_RESULTS];
+	int oldlen, nrels = MAX_RESULTS,ret=0;
+	i2c_real_callback callback = table->extra1;
+	struct i2c_client *client = table->extra2;
+
+	/* Check if we need to output the old values */
+	if (oldval && oldlenp && !((ret=get_user(oldlen, oldlenp))) && oldlen) {
+		callback(client, SENSORS_PROC_REAL_READ, table->ctl_name,
+			 &nrels, results);
+
+		/* Note the rounding factor! */
+		if (nrels * sizeof(long) < oldlen)
+			oldlen = nrels * sizeof(long);
+		oldlen = (oldlen / sizeof(long)) * sizeof(long);
+		if(copy_to_user(oldval, results, oldlen))
+			return -EFAULT;
+		if(put_user(oldlen, oldlenp))
+			return -EFAULT;
+	}
+
+	if (newval && newlen) {
+		/* Note the rounding factor! */
+		newlen -= newlen % sizeof(long);
+		nrels = newlen / sizeof(long);
+		if(copy_from_user(results, newval, newlen))
+			return -EFAULT;
+
+		/* Get the new values back to the client */
+		callback(client, SENSORS_PROC_REAL_WRITE, table->ctl_name,
+			 &nrels, results);
+	}
+	return ret;
+}
+
+
+/* nrels contains initially the maximum number of elements which can be
+   put in results, and finally the number of elements actually put there.
+   A magnitude of 1 will multiply everything with 10; etc.
+   buffer, bufsize is the character buffer we read from and its length.
+   results will finally contain the parsed integers. 
+
+   Buffer should contain several reals, separated by whitespace. A real
+   has the following syntax:
+     [ Minus ] Digit* [ Dot Digit* ] 
+   (everything between [] is optional; * means zero or more).
+   When the next character is unparsable, everything is skipped until the
+   next whitespace.
+
+   WARNING! This is tricky code. I have tested it, but there may still be
+            hidden bugs in it, even leading to crashes and things!
+*/
+int i2c_parse_reals(int *nrels, void *buffer, int bufsize,
+			 long *results, int magnitude)
+{
+	int maxels, min, mag;
+	long res,ret=0;
+	char nextchar = 0;
+
+	maxels = *nrels;
+	*nrels = 0;
+
+	while (bufsize && (*nrels < maxels)) {
+
+		/* Skip spaces at the start */
+		while (bufsize && 
+		       !((ret=get_user(nextchar, (char *) buffer))) &&
+		       isspace((int) nextchar)) {
+			bufsize--;
+			((char *) buffer)++;
+		}
+
+		if (ret)
+			return -EFAULT;	
+		/* Well, we may be done now */
+		if (!bufsize)
+			return 0;
+
+		/* New defaults for our result */
+		min = 0;
+		res = 0;
+		mag = magnitude;
+
+		/* Check for a minus */
+		if (!((ret=get_user(nextchar, (char *) buffer)))
+		    && (nextchar == '-')) {
+			min = 1;
+			bufsize--;
+			((char *) buffer)++;
+		}
+		if (ret)
+			return -EFAULT;
+
+		/* Digits before a decimal dot */
+		while (bufsize && 
+		       !((ret=get_user(nextchar, (char *) buffer))) &&
+		       isdigit((int) nextchar)) {
+			res = res * 10 + nextchar - '0';
+			bufsize--;
+			((char *) buffer)++;
+		}
+		if (ret)
+			return -EFAULT;
+
+		/* If mag < 0, we must actually divide here! */
+		while (mag < 0) {
+			res = res / 10;
+			mag++;
+		}
+
+		if (bufsize && (nextchar == '.')) {
+			/* Skip the dot */
+			bufsize--;
+			((char *) buffer)++;
+
+			/* Read digits while they are significant */
+			while (bufsize && (mag > 0) &&
+			       !((ret=get_user(nextchar, (char *) buffer))) &&
+			       isdigit((int) nextchar)) {
+				res = res * 10 + nextchar - '0';
+				mag--;
+				bufsize--;
+				((char *) buffer)++;
+			}
+			if (ret)
+				return -EFAULT;
+		}
+		/* If we are out of data, but mag > 0, we need to scale here */
+		while (mag > 0) {
+			res = res * 10;
+			mag--;
+		}
+
+		/* Skip everything until we hit whitespace */
+		while (bufsize && 
+		       !((ret=get_user(nextchar, (char *) buffer))) &&
+		       isspace((int) nextchar)) {
+			bufsize--;
+			((char *) buffer)++;
+		}
+		if (ret)
+			return -EFAULT;
+
+		/* Put res in results */
+		results[*nrels] = (min ? -1 : 1) * res;
+		(*nrels)++;
+	}
+
+	/* Well, there may be more in the buffer, but we need no more data. 
+	   Ignore anything that is left. */
+	return 0;
+}
+
+int i2c_write_reals(int nrels, void *buffer, int *bufsize,
+			 long *results, int magnitude)
+{
+#define BUFLEN 20
+	char BUF[BUFLEN + 1];	/* An individual representation should fit! */
+	char printfstr[10];
+	int nr = 0;
+	int buflen, mag, times;
+	int curbufsize = 0;
+
+	while ((nr < nrels) && (curbufsize < *bufsize)) {
+		mag = magnitude;
+
+		if (nr != 0) {
+			if(put_user(' ', (char *) buffer))
+				return -EFAULT;
+			curbufsize++;
+			((char *) buffer)++;
+		}
+
+		/* Fill BUF with the representation of the next string */
+		if (mag <= 0) {
+			buflen = sprintf(BUF, "%ld", results[nr]);
+			if (buflen < 0) {	/* Oops, a sprintf error! */
+				*bufsize = 0;
+				return -EINVAL;
+			}
+			while ((mag < 0) && (buflen < BUFLEN)) {
+				BUF[buflen++] = '0';
+				mag++;
+			}
+			BUF[buflen] = 0;
+		} else {
+			times = 1;
+			for (times = 1; mag-- > 0; times *= 10);
+			if (results[nr] < 0) {
+				BUF[0] = '-';
+				buflen = 1;
+			} else
+				buflen = 0;
+			strcpy(printfstr, "%ld.%0Xld");
+			printfstr[6] = magnitude + '0';
+			buflen +=
+			    sprintf(BUF + buflen, printfstr,
+				    abs(results[nr]) / times,
+				    abs(results[nr]) % times);
+			if (buflen < 0) {	/* Oops, a sprintf error! */
+				*bufsize = 0;
+				return -EINVAL;
+			}
+		}
+
+		/* Now copy it to the user-space buffer */
+		if (buflen + curbufsize > *bufsize)
+			buflen = *bufsize - curbufsize;
+		if(copy_to_user(buffer, BUF, buflen))
+			return -EFAULT;
+		curbufsize += buflen;
+		(char *) buffer += buflen;
+
+		nr++;
+	}
+	if (curbufsize < *bufsize) {
+		if(put_user('\n', (char *) buffer))
+			return -EFAULT;
+		curbufsize++;
+	}
+	*bufsize = curbufsize;
+	return 0;
+}
+
+
+/* Very inefficient for ISA detects, and won't work for 10-bit addresses! */
+int i2c_detect(struct i2c_adapter *adapter,
+		   struct i2c_address_data *address_data,
+		   i2c_found_addr_proc * found_proc)
+{
+	int addr, i, found, j, err;
+	struct i2c_force_data *this_force;
+	int is_isa = i2c_is_isa_adapter(adapter);
+	int adapter_id =
+	    is_isa ? SENSORS_ISA_BUS : i2c_adapter_id(adapter);
+
+	/* Forget it if we can't probe using SMBUS_QUICK */
+	if ((!is_isa)
+	    && !i2c_check_functionality(adapter,
+					I2C_FUNC_SMBUS_QUICK)) return -1;
+
+	for (addr = 0x00; addr <= (is_isa ? 0xffff : 0x7f); addr++) {
+		if ((is_isa && check_region(addr, 1)) ||
+		    (!is_isa && i2c_check_addr(adapter, addr)))
+			continue;
+
+		/* If it is in one of the force entries, we don't do any
+		   detection at all */
+		found = 0;
+		for (i = 0;
+		     !found
+		     && (this_force =
+			 address_data->forces + i, this_force->force); i++) {
+			for (j = 0;
+			     !found
+			     && (this_force->force[j] != SENSORS_I2C_END);
+			     j += 2) {
+				if (
+				    ((adapter_id == this_force->force[j])
+				     ||
+				     ((this_force->
+				       force[j] == SENSORS_ANY_I2C_BUS)
+				      && !is_isa))
+				    && (addr == this_force->force[j + 1])) {
+#ifdef DEBUG
+					printk
+					    ("i2c-proc.o: found force parameter for adapter %d, addr %04x\n",
+					     adapter_id, addr);
+#endif
+					if (
+					    (err =
+					     found_proc(adapter, addr, 0,
+							this_force->
+							kind))) return err;
+					found = 1;
+				}
+			}
+		}
+		if (found)
+			continue;
+
+		/* If this address is in one of the ignores, we can forget about it
+		   right now */
+		for (i = 0;
+		     !found
+		     && (address_data->ignore[i] != SENSORS_I2C_END);
+		     i += 2) {
+			if (
+			    ((adapter_id == address_data->ignore[i])
+			     ||
+			     ((address_data->
+			       ignore[i] == SENSORS_ANY_I2C_BUS)
+			      && !is_isa))
+			    && (addr == address_data->ignore[i + 1])) {
+#ifdef DEBUG
+				printk
+				    ("i2c-proc.o: found ignore parameter for adapter %d, "
+				     "addr %04x\n", adapter_id, addr);
+#endif
+				found = 1;
+			}
+		}
+		for (i = 0;
+		     !found
+		     && (address_data->ignore_range[i] != SENSORS_I2C_END);
+		     i += 3) {
+			if (
+			    ((adapter_id == address_data->ignore_range[i])
+			     ||
+			     ((address_data->
+			       ignore_range[i] ==
+			       SENSORS_ANY_I2C_BUS) & !is_isa))
+			    && (addr >= address_data->ignore_range[i + 1])
+			    && (addr <= address_data->ignore_range[i + 2])) {
+#ifdef DEBUG
+				printk
+				    ("i2c-proc.o: found ignore_range parameter for adapter %d, "
+				     "addr %04x\n", adapter_id, addr);
+#endif
+				found = 1;
+			}
+		}
+		if (found)
+			continue;
+
+		/* Now, we will do a detection, but only if it is in the normal or 
+		   probe entries */
+		if (is_isa) {
+			for (i = 0;
+			     !found
+			     && (address_data->normal_isa[i] !=
+				 SENSORS_ISA_END); i += 1) {
+				if (addr == address_data->normal_isa[i]) {
+#ifdef DEBUG
+					printk
+					    ("i2c-proc.o: found normal isa entry for adapter %d, "
+					     "addr %04x\n", adapter_id,
+					     addr);
+#endif
+					found = 1;
+				}
+			}
+			for (i = 0;
+			     !found
+			     && (address_data->normal_isa_range[i] !=
+				 SENSORS_ISA_END); i += 3) {
+				if ((addr >=
+				     address_data->normal_isa_range[i])
+				    && (addr <=
+					address_data->normal_isa_range[i + 1])
+				    &&
+				    ((addr -
+				      address_data->normal_isa_range[i]) %
+				     address_data->normal_isa_range[i + 2] ==
+				     0)) {
+#ifdef DEBUG
+					printk
+					    ("i2c-proc.o: found normal isa_range entry for adapter %d, "
+					     "addr %04x", adapter_id, addr);
+#endif
+					found = 1;
+				}
+			}
+		} else {
+			for (i = 0;
+			     !found && (address_data->normal_i2c[i] !=
+				 SENSORS_I2C_END); i += 1) {
+				if (addr == address_data->normal_i2c[i]) {
+					found = 1;
+#ifdef DEBUG
+					printk
+					    ("i2c-proc.o: found normal i2c entry for adapter %d, "
+					     "addr %02x", adapter_id, addr);
+#endif
+				}
+			}
+			for (i = 0;
+			     !found
+			     && (address_data->normal_i2c_range[i] !=
+				 SENSORS_I2C_END); i += 2) {
+				if ((addr >=
+				     address_data->normal_i2c_range[i])
+				    && (addr <=
+					address_data->normal_i2c_range[i + 1]))
+				{
+#ifdef DEBUG
+					printk
+					    ("i2c-proc.o: found normal i2c_range entry for adapter %d, "
+					     "addr %04x\n", adapter_id, addr);
+#endif
+					found = 1;
+				}
+			}
+		}
+
+		for (i = 0;
+		     !found && (address_data->probe[i] != SENSORS_I2C_END);
+		     i += 2) {
+			if (((adapter_id == address_data->probe[i]) ||
+			     ((address_data->
+			       probe[i] == SENSORS_ANY_I2C_BUS) & !is_isa))
+			    && (addr == address_data->probe[i + 1])) {
+#ifdef DEBUG
+				printk
+				    ("i2c-proc.o: found probe parameter for adapter %d, "
+				     "addr %04x\n", adapter_id, addr);
+#endif
+				found = 1;
+			}
+		}
+		for (i = 0; !found &&
+		           (address_data->probe_range[i] != SENSORS_I2C_END);
+		     i += 3) {
+			if (
+			    ((adapter_id == address_data->probe_range[i])
+			     ||
+			     ((address_data->probe_range[i] ==
+			       SENSORS_ANY_I2C_BUS) & !is_isa))
+			    && (addr >= address_data->probe_range[i + 1])
+			    && (addr <= address_data->probe_range[i + 2])) {
+				found = 1;
+#ifdef DEBUG
+				printk
+				    ("i2c-proc.o: found probe_range parameter for adapter %d, "
+				     "addr %04x\n", adapter_id, addr);
+#endif
+			}
+		}
+		if (!found)
+			continue;
+
+		/* OK, so we really should examine this address. First check
+		   whether there is some client here at all! */
+		if (is_isa ||
+		    (i2c_smbus_xfer
+		     (adapter, addr, 0, 0, 0, I2C_SMBUS_QUICK, NULL) >= 0))
+			if ((err = found_proc(adapter, addr, 0, -1)))
+				return err;
+	}
+	return 0;
+}
+
+int __init sensors_init(void)
+{
+	printk("i2c-proc.o version %s (%s)\n", LM_VERSION, LM_DATE);
+	i2c_initialized = 0;
+	if (!
+	    (i2c_proc_header =
+	     register_sysctl_table(i2c_proc, 0))) return -ENOMEM;
+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,3,1))
+	i2c_proc_header->ctl_table->child->de->owner = THIS_MODULE;
+#else
+	i2c_proc_header->ctl_table->child->de->fill_inode =
+	    &i2c_fill_inode;
+#endif			/* (LINUX_VERSION_CODE >= KERNEL_VERSION(2,3,1)) */
+	i2c_initialized++;
+	return 0;
+}
+
+EXPORT_SYMBOL(i2c_deregister_entry);
+EXPORT_SYMBOL(i2c_detect);
+EXPORT_SYMBOL(i2c_proc_real);
+EXPORT_SYMBOL(i2c_register_entry);
+EXPORT_SYMBOL(i2c_sysctl_real);
+
+#ifdef MODULE
+
+MODULE_AUTHOR("Frodo Looijaard <frodol@dds.nl>");
+MODULE_DESCRIPTION("i2c-proc driver");
+
+int i2c_cleanup(void)
+{
+	if (i2c_initialized >= 1) {
+		unregister_sysctl_table(i2c_proc_header);
+		i2c_initialized--;
+	}
+	return 0;
+}
+
+int init_module(void)
+{
+	return sensors_init();
+}
+
+int cleanup_module(void)
+{
+	return i2c_cleanup();
+}
+
+#endif				/* MODULE */
--- linux-old/include/linux/i2c-proc.h	Mon Jul 23 01:39:58 CEST 2001
+++ linux/include/linux/i2c-proc.h	Mon Jul 23 01:39:58 CEST 2001
@@ -0,0 +1,396 @@
+/*
+    sensors.h - Part of lm_sensors, Linux kernel modules for hardware
+                monitoring
+    Copyright (c) 1998, 1999  Frodo Looijaard <frodol@dds.nl>
+
+    This program is free software; you can redistribute it and/or modify
+    it under the terms of the GNU General Public License as published by
+    the Free Software Foundation; either version 2 of the License, or
+    (at your option) any later version.
+
+    This program is distributed in the hope that it will be useful,
+    but WITHOUT ANY WARRANTY; without even the implied warranty of
+    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+    GNU General Public License for more details.
+
+    You should have received a copy of the GNU General Public License
+    along with this program; if not, write to the Free Software
+    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+*/
+
+#ifndef SENSORS_SENSORS_H
+#define SENSORS_SENSORS_H
+
+#ifdef __KERNEL__
+
+/* Next two must be included before sysctl.h can be included, in 2.0 kernels */
+#include <linux/types.h>
+#include <linux/fs.h>
+#include <linux/sysctl.h>
+
+/* The type of callback functions used in sensors_{proc,sysctl}_real */
+typedef void (*i2c_real_callback) (struct i2c_client * client,
+				       int operation, int ctl_name,
+				       int *nrels_mag, long *results);
+
+/* Values for the operation field in the above function type */
+#define SENSORS_PROC_REAL_INFO 1
+#define SENSORS_PROC_REAL_READ 2
+#define SENSORS_PROC_REAL_WRITE 3
+
+/* These funcion reads or writes a 'real' value (encoded by the combination
+   of an integer and a magnitude, the last is the power of ten the value
+   should be divided with) to a /proc/sys directory. To use these functions,
+   you must (before registering the ctl_table) set the extra2 field to the
+   client, and the extra1 field to a function of the form:
+      void func(struct i2c_client *client, int operation, int ctl_name,
+                int *nrels_mag, long *results)
+   This last function can be called for three values of operation. If
+   operation equals SENSORS_PROC_REAL_INFO, the magnitude should be returned
+   in nrels_mag. If operation equals SENSORS_PROC_REAL_READ, values should
+   be read into results. nrels_mag should return the number of elements
+   read; the maximum number is put in it on entry. Finally, if operation
+   equals SENSORS_PROC_REAL_WRITE, the values in results should be
+   written to the chip. nrels_mag contains on entry the number of elements
+   found.
+   In all cases, client points to the client we wish to interact with,
+   and ctl_name is the SYSCTL id of the file we are accessing. */
+extern int i2c_sysctl_real(ctl_table * table, int *name, int nlen,
+			       void *oldval, size_t * oldlenp,
+			       void *newval, size_t newlen,
+			       void **context);
+extern int i2c_proc_real(ctl_table * ctl, int write, struct file *filp,
+			     void *buffer, size_t * lenp);
+
+
+
+/* These rather complex functions must be called when you want to add or
+   delete an entry in /proc/sys/dev/sensors/chips (not yet implemented). It
+   also creates a new directory within /proc/sys/dev/sensors/.
+   ctl_template should be a template of the newly created directory. It is
+   copied in memory. The extra2 field of each file is set to point to client.
+   If any driver wants subdirectories within the newly created directory,
+   these functions must be updated! */
+extern int i2c_register_entry(struct i2c_client *client,
+				  const char *prefix,
+				  ctl_table * ctl_template,
+				  struct module *controlling_mod);
+
+extern void i2c_deregister_entry(int id);
+
+
+/* A structure containing detect information.
+   Force variables overrule all other variables; they force a detection on
+   that place. If a specific chip is given, the module blindly assumes this
+   chip type is present; if a general force (kind == 0) is given, the module
+   will still try to figure out what type of chip is present. This is useful
+   if for some reasons the detect for SMBus or ISA address space filled
+   fails.
+   probe: insmod parameter. Initialize this list with SENSORS_I2C_END values.
+     A list of pairs. The first value is a bus number (SENSORS_ISA_BUS for
+     the ISA bus, -1 for any I2C bus), the second is the address. 
+   kind: The kind of chip. 0 equals any chip.
+*/
+struct i2c_force_data {
+	unsigned short *force;
+	unsigned short kind;
+};
+
+/* A structure containing the detect information.
+   normal_i2c: filled in by the module writer. Terminated by SENSORS_I2C_END.
+     A list of I2C addresses which should normally be examined.
+   normal_i2c_range: filled in by the module writer. Terminated by 
+     SENSORS_I2C_END
+     A list of pairs of I2C addresses, each pair being an inclusive range of
+     addresses which should normally be examined.
+   normal_isa: filled in by the module writer. Terminated by SENSORS_ISA_END.
+     A list of ISA addresses which should normally be examined.
+   normal_isa_range: filled in by the module writer. Terminated by 
+     SENSORS_ISA_END
+     A list of triples. The first two elements are ISA addresses, being an
+     range of addresses which should normally be examined. The third is the
+     modulo parameter: only addresses which are 0 module this value relative
+     to the first address of the range are actually considered.
+   probe: insmod parameter. Initialize this list with SENSORS_I2C_END values.
+     A list of pairs. The first value is a bus number (SENSORS_ISA_BUS for
+     the ISA bus, -1 for any I2C bus), the second is the address. These
+     addresses are also probed, as if they were in the 'normal' list.
+   probe_range: insmod parameter. Initialize this list with SENSORS_I2C_END 
+     values.
+     A list of triples. The first value is a bus number (SENSORS_ISA_BUS for
+     the ISA bus, -1 for any I2C bus), the second and third are addresses. 
+     These form an inclusive range of addresses that are also probed, as
+     if they were in the 'normal' list.
+   ignore: insmod parameter. Initialize this list with SENSORS_I2C_END values.
+     A list of pairs. The first value is a bus number (SENSORS_ISA_BUS for
+     the ISA bus, -1 for any I2C bus), the second is the I2C address. These
+     addresses are never probed. This parameter overrules 'normal' and 
+     'probe', but not the 'force' lists.
+   ignore_range: insmod parameter. Initialize this list with SENSORS_I2C_END 
+      values.
+     A list of triples. The first value is a bus number (SENSORS_ISA_BUS for
+     the ISA bus, -1 for any I2C bus), the second and third are addresses. 
+     These form an inclusive range of I2C addresses that are never probed.
+     This parameter overrules 'normal' and 'probe', but not the 'force' lists.
+   force_data: insmod parameters. A list, ending with an element of which
+     the force field is NULL.
+*/
+struct i2c_address_data {
+	unsigned short *normal_i2c;
+	unsigned short *normal_i2c_range;
+	unsigned int *normal_isa;
+	unsigned int *normal_isa_range;
+	unsigned short *probe;
+	unsigned short *probe_range;
+	unsigned short *ignore;
+	unsigned short *ignore_range;
+	struct i2c_force_data *forces;
+};
+
+/* Internal numbers to terminate lists */
+#define SENSORS_I2C_END 0xfffe
+#define SENSORS_ISA_END 0xfffefffe
+
+/* The numbers to use to set an ISA or I2C bus address */
+#define SENSORS_ISA_BUS 9191
+#define SENSORS_ANY_I2C_BUS 0xffff
+
+/* The length of the option lists */
+#define SENSORS_MAX_OPTS 48
+
+/* Default fill of many variables */
+#define SENSORS_DEFAULTS {SENSORS_I2C_END, SENSORS_I2C_END, SENSORS_I2C_END, \
+                          SENSORS_I2C_END, SENSORS_I2C_END, SENSORS_I2C_END, \
+                          SENSORS_I2C_END, SENSORS_I2C_END, SENSORS_I2C_END, \
+                          SENSORS_I2C_END, SENSORS_I2C_END, SENSORS_I2C_END, \
+                          SENSORS_I2C_END, SENSORS_I2C_END, SENSORS_I2C_END, \
+                          SENSORS_I2C_END, SENSORS_I2C_END, SENSORS_I2C_END, \
+                          SENSORS_I2C_END, SENSORS_I2C_END, SENSORS_I2C_END, \
+                          SENSORS_I2C_END, SENSORS_I2C_END, SENSORS_I2C_END, \
+                          SENSORS_I2C_END, SENSORS_I2C_END, SENSORS_I2C_END, \
+                          SENSORS_I2C_END, SENSORS_I2C_END, SENSORS_I2C_END, \
+                          SENSORS_I2C_END, SENSORS_I2C_END, SENSORS_I2C_END, \
+                          SENSORS_I2C_END, SENSORS_I2C_END, SENSORS_I2C_END, \
+                          SENSORS_I2C_END, SENSORS_I2C_END, SENSORS_I2C_END, \
+                          SENSORS_I2C_END, SENSORS_I2C_END, SENSORS_I2C_END, \
+                          SENSORS_I2C_END, SENSORS_I2C_END, SENSORS_I2C_END, \
+                          SENSORS_I2C_END, SENSORS_I2C_END, SENSORS_I2C_END}
+
+/* This is ugly. We need to evaluate SENSORS_MAX_OPTS before it is 
+   stringified */
+#define SENSORS_MODPARM_AUX1(x) "1-" #x "h"
+#define SENSORS_MODPARM_AUX(x) SENSORS_MODPARM_AUX1(x)
+#define SENSORS_MODPARM SENSORS_MODPARM_AUX(SENSORS_MAX_OPTS)
+
+/* SENSORS_MODULE_PARM creates a module parameter, and puts it in the
+   module header */
+#define SENSORS_MODULE_PARM(var,desc) \
+  static unsigned short var[SENSORS_MAX_OPTS] = SENSORS_DEFAULTS; \
+  MODULE_PARM(var,SENSORS_MODPARM); \
+  MODULE_PARM_DESC(var,desc)
+
+/* SENSORS_MODULE_PARM creates a 'force_*' module parameter, and puts it in
+   the module header */
+#define SENSORS_MODULE_PARM_FORCE(name) \
+  SENSORS_MODULE_PARM(force_ ## name, \
+                      "List of adapter,address pairs which are unquestionably" \
+                      " assumed to contain a `" # name "' chip")
+
+
+/* This defines several insmod variables, and the addr_data structure */
+#define SENSORS_INSMOD \
+  SENSORS_MODULE_PARM(probe, \
+                      "List of adapter,address pairs to scan additionally"); \
+  SENSORS_MODULE_PARM(probe_range, \
+                      "List of adapter,start-addr,end-addr triples to scan " \
+                      "additionally"); \
+  SENSORS_MODULE_PARM(ignore, \
+                      "List of adapter,address pairs not to scan"); \
+  SENSORS_MODULE_PARM(ignore_range, \
+                      "List of adapter,start-addr,end-addr triples not to " \
+                      "scan"); \
+  static struct i2c_address_data addr_data = \
+                                       {normal_i2c, normal_i2c_range, \
+                                        normal_isa, normal_isa_range, \
+                                        probe, probe_range, \
+                                        ignore, ignore_range, \
+                                        forces}
+
+/* The following functions create an enum with the chip names as elements. 
+   The first element of the enum is any_chip. These are the only macros
+   a module will want to use. */
+
+#define SENSORS_INSMOD_0 \
+  enum chips { any_chip }; \
+  SENSORS_MODULE_PARM(force, \
+                      "List of adapter,address pairs to boldly assume " \
+                      "to be present"); \
+  static struct i2c_force_data forces[] = {{force,any_chip},{NULL}}; \
+  SENSORS_INSMOD
+
+#define SENSORS_INSMOD_1(chip1) \
+  enum chips { any_chip, chip1 }; \
+  SENSORS_MODULE_PARM(force, \
+                      "List of adapter,address pairs to boldly assume " \
+                      "to be present"); \
+  SENSORS_MODULE_PARM_FORCE(chip1); \
+  static struct i2c_force_data forces[] = {{force,any_chip},\
+                                                 {force_ ## chip1,chip1}, \
+                                                 {NULL}}; \
+  SENSORS_INSMOD
+
+#define SENSORS_INSMOD_2(chip1,chip2) \
+  enum chips { any_chip, chip1, chip2 }; \
+  SENSORS_MODULE_PARM(force, \
+                      "List of adapter,address pairs to boldly assume " \
+                      "to be present"); \
+  SENSORS_MODULE_PARM_FORCE(chip1); \
+  SENSORS_MODULE_PARM_FORCE(chip2); \
+  static struct i2c_force_data forces[] = {{force,any_chip}, \
+                                                 {force_ ## chip1,chip1}, \
+                                                 {force_ ## chip2,chip2}, \
+                                                 {NULL}}; \
+  SENSORS_INSMOD
+
+#define SENSORS_INSMOD_3(chip1,chip2,chip3) \
+  enum chips { any_chip, chip1, chip2, chip3 }; \
+  SENSORS_MODULE_PARM(force, \
+                      "List of adapter,address pairs to boldly assume " \
+                      "to be present"); \
+  SENSORS_MODULE_PARM_FORCE(chip1); \
+  SENSORS_MODULE_PARM_FORCE(chip2); \
+  SENSORS_MODULE_PARM_FORCE(chip3); \
+  static struct i2c_force_data forces[] = {{force,any_chip}, \
+                                                 {force_ ## chip1,chip1}, \
+                                                 {force_ ## chip2,chip2}, \
+                                                 {force_ ## chip3,chip3}, \
+                                                 {NULL}}; \
+  SENSORS_INSMOD
+
+#define SENSORS_INSMOD_4(chip1,chip2,chip3,chip4) \
+  enum chips { any_chip, chip1, chip2, chip3, chip4 }; \
+  SENSORS_MODULE_PARM(force, \
+                      "List of adapter,address pairs to boldly assume " \
+                      "to be present"); \
+  SENSORS_MODULE_PARM_FORCE(chip1); \
+  SENSORS_MODULE_PARM_FORCE(chip2); \
+  SENSORS_MODULE_PARM_FORCE(chip3); \
+  SENSORS_MODULE_PARM_FORCE(chip4); \
+  static struct i2c_force_data forces[] = {{force,any_chip}, \
+                                                 {force_ ## chip1,chip1}, \
+                                                 {force_ ## chip2,chip2}, \
+                                                 {force_ ## chip3,chip3}, \
+                                                 {force_ ## chip4,chip4}, \
+                                                 {NULL}}; \
+  SENSORS_INSMOD
+
+#define SENSORS_INSMOD_5(chip1,chip2,chip3,chip4,chip5) \
+  enum chips { any_chip, chip1, chip2, chip3, chip4, chip5 }; \
+  SENSORS_MODULE_PARM(force, \
+                      "List of adapter,address pairs to boldly assume " \
+                      "to be present"); \
+  SENSORS_MODULE_PARM_FORCE(chip1); \
+  SENSORS_MODULE_PARM_FORCE(chip2); \
+  SENSORS_MODULE_PARM_FORCE(chip3); \
+  SENSORS_MODULE_PARM_FORCE(chip4); \
+  SENSORS_MODULE_PARM_FORCE(chip5); \
+  static struct i2c_force_data forces[] = {{force,any_chip}, \
+                                                 {force_ ## chip1,chip1}, \
+                                                 {force_ ## chip2,chip2}, \
+                                                 {force_ ## chip3,chip3}, \
+                                                 {force_ ## chip4,chip4}, \
+                                                 {force_ ## chip5,chip5}, \
+                                                 {NULL}}; \
+  SENSORS_INSMOD
+
+#define SENSORS_INSMOD_6(chip1,chip2,chip3,chip4,chip5,chip6) \
+  enum chips { any_chip, chip1, chip2, chip3, chip4, chip5, chip6 }; \
+  SENSORS_MODULE_PARM(force, \
+                      "List of adapter,address pairs to boldly assume " \
+                      "to be present"); \
+  SENSORS_MODULE_PARM_FORCE(chip1); \
+  SENSORS_MODULE_PARM_FORCE(chip2); \
+  SENSORS_MODULE_PARM_FORCE(chip3); \
+  SENSORS_MODULE_PARM_FORCE(chip4); \
+  SENSORS_MODULE_PARM_FORCE(chip5); \
+  SENSORS_MODULE_PARM_FORCE(chip6); \
+  static struct i2c_force_data forces[] = {{force,any_chip}, \
+                                                 {force_ ## chip1,chip1}, \
+                                                 {force_ ## chip2,chip2}, \
+                                                 {force_ ## chip3,chip3}, \
+                                                 {force_ ## chip4,chip4}, \
+                                                 {force_ ## chip5,chip5}, \
+                                                 {force_ ## chip6,chip6}, \
+                                                 {NULL}}; \
+  SENSORS_INSMOD
+
+#define SENSORS_INSMOD_7(chip1,chip2,chip3,chip4,chip5,chip6,chip7) \
+  enum chips { any_chip, chip1, chip2, chip3, chip4, chip5, chip6, chip7 }; \
+  SENSORS_MODULE_PARM(force, \
+                      "List of adapter,address pairs to boldly assume " \
+                      "to be present"); \
+  SENSORS_MODULE_PARM_FORCE(chip1); \
+  SENSORS_MODULE_PARM_FORCE(chip2); \
+  SENSORS_MODULE_PARM_FORCE(chip3); \
+  SENSORS_MODULE_PARM_FORCE(chip4); \
+  SENSORS_MODULE_PARM_FORCE(chip5); \
+  SENSORS_MODULE_PARM_FORCE(chip6); \
+  SENSORS_MODULE_PARM_FORCE(chip7); \
+  static struct i2c_force_data forces[] = {{force,any_chip}, \
+                                                 {force_ ## chip1,chip1}, \
+                                                 {force_ ## chip2,chip2}, \
+                                                 {force_ ## chip3,chip3}, \
+                                                 {force_ ## chip4,chip4}, \
+                                                 {force_ ## chip5,chip5}, \
+                                                 {force_ ## chip6,chip6}, \
+                                                 {force_ ## chip7,chip7}, \
+                                                 {NULL}}; \
+  SENSORS_INSMOD
+
+typedef int i2c_found_addr_proc(struct i2c_adapter *adapter,
+				    int addr, unsigned short flags,
+				    int kind);
+
+/* Detect function. It iterates over all possible addresses itself. For
+   SMBus addresses, it will only call found_proc if some client is connected
+   to the SMBus (unless a 'force' matched); for ISA detections, this is not
+   done. */
+extern int i2c_detect(struct i2c_adapter *adapter,
+			  struct i2c_address_data *address_data,
+			  i2c_found_addr_proc * found_proc);
+
+
+/* This macro is used to scale user-input to sensible values in almost all
+   chip drivers. */
+extern inline int SENSORS_LIMIT(long value, long low, long high)
+{
+	if (value < low)
+		return low;
+	else if (value > high)
+		return high;
+	else
+		return value;
+}
+
+#endif				/* def __KERNEL__ */
+
+
+/* The maximum length of the prefix */
+#define SENSORS_PREFIX_MAX 20
+
+/* Sysctl IDs */
+#ifdef DEV_HWMON
+#define DEV_SENSORS DEV_HWMON
+#else				/* ndef DEV_HWMOM */
+#define DEV_SENSORS 2		/* The id of the lm_sensors directory within the
+				   dev table */
+#endif				/* def DEV_HWMON */
+
+#define SENSORS_CHIPS 1
+struct i2c_chips_data {
+	int sysctl_id;
+	char name[SENSORS_PREFIX_MAX + 13];
+};
+
+#endif				/* def SENSORS_SENSORS_H */
+
--- linux-old/include/linux/i2c.h	Mon Jul 23 01:40:00 CEST 2001
+++ linux/include/linux/i2c.h	Mon Jul 23 01:40:00 CEST 2001
@@ -24,5 +24,5 @@
    Frodo Looijaard <frodol@dds.nl> */
 
-/* $Id: i2c.h,v 1.42 2000/09/06 20:14:06 frodo Exp $ */
+/* $Id: i2c.h,v 1.45 2001/04/03 02:43:21 mds Exp $ */
 
 #ifndef I2C_H
@@ -203,5 +203,5 @@
 	unsigned int id;
 
-	/* If a adapter algorithm can't to I2C-level access, set master_xfer
+	/* If an adapter algorithm can't to I2C-level access, set master_xfer
 	   to NULL. If an adapter algorithm can do SMBus access, set 
 	   smbus_xfer. If set to NULL, the SMBus protocol is simulated
@@ -345,5 +345,5 @@
 extern int i2c_check_addr (struct i2c_adapter *adapter, int addr);
 
-/* Detect function. It itterates over all possible addresses itself.
+/* Detect function. It iterates over all possible addresses itself.
  * It will only call found_proc if some client is connected at the
  * specific address (unless a 'force' matched);
@@ -361,5 +361,5 @@
 
 /* This call returns a unique low identifier for each registered adapter,
- * or -1 if the adapter was not regisitered. 
+ * or -1 if the adapter was not registered. 
  */
 extern int i2c_adapter_id(struct i2c_adapter *adap);
@@ -455,6 +455,7 @@
  */
 				/* -> bit-adapter specific ioctls	*/
-#define I2C_RETRIES	0x0701	/* number times a device address should	*/
-				/* be polled when not acknowledging 	*/
+#define I2C_RETRIES	0x0701	/* number of times a device address      */
+				/* should be polled when not            */
+                                /* acknowledging 			*/
 #define I2C_TIMEOUT	0x0702	/* set timeout - call with int 		*/
 
@@ -549,4 +550,11 @@
                                         ignore, ignore_range, \
                                         force}
+
+/* Detect whether we are on the isa bus. If this returns true, all i2c
+   access will fail! */
+#define i2c_is_isa_client(clientptr) \
+        ((clientptr)->adapter->algo->id == I2C_ALGO_ISA)
+#define i2c_is_isa_adapter(adapptr) \
+        ((adapptr)->algo->id == I2C_ALGO_ISA)
 
 #endif /* def __KERNEL__ */
--- linux-old/drivers/i2c/Config.in	Mon Jul 23 01:40:00 CEST 2001
+++ linux/drivers/i2c/Config.in	Mon Jul 23 01:40:00 CEST 2001
@@ -21,8 +21,24 @@
    fi
 
+   if [ "$CONFIG_8xx" = "y" ]; then
+      dep_tristate 'MPC8xx CPM I2C interface' CONFIG_I2C_ALGO8XX $CONFIG_I2C
+      if [ "$CONFIG_RPXLITE" = "y" -o "$CONFIG_RPXCLASSIC" = "y" ]; then
+         dep_tristate '  Embedded Planet RPX Lite/Classic suppoort' CONFIG_I2C_RPXLITE $CONFIG_I2C_ALGO8XX
+      fi
+   fi
+
+   if [ "$CONFIG_405" = "y" ]; then
+      dep_tristate 'PPC 405 I2C Algorithm' CONFIG_I2C_PPC405_ALGO $CONFIG_I2C
+      if [ "CONFIG_PPC405_I2C_ALGO" != "n" ]; then
+         dep_tristate '  PPC 405 I2C Adapter' CONFIG_I2C_PPC405_ADAP $CONFIG_I2C_PPC405_ALGO
+      fi
+   fi
+
 # This is needed for automatic patch generation: sensors code starts here
 # This is needed for automatic patch generation: sensors code ends here
 
    dep_tristate 'I2C device interface' CONFIG_I2C_CHARDEV $CONFIG_I2C
+
+   dep_tristate 'I2C /proc interface' CONFIG_I2C_PROC $CONFIG_I2C
 
 fi
--- linux-old/drivers/i2c/Makefile	Mon Jul 23 01:40:00 CEST 2001
+++ linux/drivers/i2c/Makefile	Mon Jul 23 01:40:00 CEST 2001
@@ -5,5 +5,5 @@
 O_TARGET := i2c.o
 
-export-objs	:= i2c-core.o i2c-algo-bit.o i2c-algo-pcf.o
+export-objs	:= i2c-core.o i2c-algo-bit.o i2c-algo-pcf.o i2c-proc.o
 
 obj-$(CONFIG_I2C)		+= i2c-core.o
@@ -15,4 +15,5 @@
 obj-$(CONFIG_I2C_ALGOPCF)	+= i2c-algo-pcf.o
 obj-$(CONFIG_I2C_ELEKTOR)	+= i2c-elektor.o
+obj-$(CONFIG_I2C_PROC)		+= i2c-proc.o
 
 # This is needed for automatic patch generation: sensors code starts here
--- linux-old/Documentation/Configure.help	Mon Jul 23 01:40:01 CEST 2001
+++ linux/Documentation/Configure.help	Mon Jul 23 01:40:01 CEST 2001
@@ -13559,5 +13559,5 @@
   many micro controller applications and developed by Philips. SMBus,
   or System Management Bus is a subset of the I2C protocol. More
-  information is contained in the directory Documentation/i2c/,
+  information is contained in the directory <file:Documentation/i2c/>,
   especially in the file called "summary" there.
 
@@ -13571,9 +13571,9 @@
   specific driver for your bus adapter(s) below. If you say Y to
   "/proc file system" below, you will then get a /proc interface which
-  is documented in Documentation/i2c/proc-interface.
+  is documented in <file:Documentation/i2c/proc-interface>.
 
   This I2C support is also available as a module. If you want to
   compile it as a module, say M here and read
-  Documentation/modules.txt. The module will be called i2c-core.o.
+  <file:Documentation/modules.txt>. The module will be called i2c-core.o.
 
 I2C bit-banging interfaces
@@ -13584,5 +13584,5 @@
 
   This support is also available as a module. If you want to compile
-  it as a module, say M here and read Documentation/modules.txt. The
+  it as a module, say M here and read <file:Documentation/modules.txt>. The
   module will be called i2c-algo-bit.o.
 
@@ -13593,5 +13593,5 @@
 
   This driver is also available as a module. If you want to compile
-  it as a module, say M here and read Documentation/modules.txt. The
+  it as a module, say M here and read <file:Documentation/modules.txt>. The
   module will be called i2c-philips-par.o.
 
@@ -13605,5 +13605,5 @@
 
   This driver is also available as a module. If you want to compile
-  it as a module, say M here and read Documentation/modules.txt. The
+  it as a module, say M here and read <file:Documentation/modules.txt>. The
   module will be called i2c-elv.o.
 
@@ -13614,5 +13614,5 @@
 
   This driver is also available as a module. If you want to compile
-  it as a module, say M here and read Documentation/modules.txt. The
+  it as a module, say M here and read <file:Documentation/modules.txt>. The
   module will be called i2c-velleman.o.
 
@@ -13624,5 +13624,5 @@
 
   This support is also available as a module. If you want to compile
-  it as a module, say M here and read Documentation/modules.txt. The
+  it as a module, say M here and read <file:Documentation/modules.txt>. The
   module will be called i2c-algo-pcf.o.
 
@@ -13633,5 +13633,5 @@
 
   This driver is also available as a module. If you want to compile
-  it as a module, say M here and read Documentation/modules.txt. The
+  it as a module, say M here and read <file:Documentation/modules.txt>. The
   module will be called i2c-elektor.o.
 
@@ -13641,8 +13641,17 @@
   directory on your system. They make it possible to have user-space
   programs use the I2C bus. Information on how to do this is contained
-  in the file Documentation/i2c/dev-interface.
+  in the file <file:Documentation/i2c/dev-interface>.
 
   This code is also available as a module. If you want to compile
-  it as a module, say M here and read Documentation/modules.txt. The
+  it as a module, say M here and read <file:Documentation/modules.txt>. The
+  module will be called i2c-dev.o.
+
+I2C /proc support
+CONFIG_I2C_PROC
+  This provides support for i2c device entries in the /proc filesystem.
+  The entries will be found in /proc/sys/dev/sensors.
+
+  This code is also available as a module. If you want to compile
+  it as a module, say M here and read <file:Documentation/modules.txt>. The
   module will be called i2c-dev.o.
 

-- 
J.A. Magallon                           #  Let the source be with you...        
mailto:jamagallon@able.es
Mandrake Linux release 8.1 (Cooker) for i586
Linux werewolf 2.4.7 #1 SMP Mon Jul 23 01:55:36 CEST 2001 i686
