Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265291AbTLMTbf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Dec 2003 14:31:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265289AbTLMTbf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Dec 2003 14:31:35 -0500
Received: from smtp-106-saturday.nerim.net ([62.4.16.106]:9229 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S265300AbTLMTav
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Dec 2003 14:30:51 -0500
Date: Sat, 13 Dec 2003 20:31:16 +0100
From: Jean Delvare <khali@linux-fr.org>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
       LM Sensors <sensors@stimpy.netroedge.com>
Subject: [PATCH 2.4] i2c cleanups (3/4)
Message-Id: <20031213203116.5149d233.khali@linux-fr.org>
In-Reply-To: <20031213191258.2d78a9f7.khali@linux-fr.org>
References: <20031213191258.2d78a9f7.khali@linux-fr.org>
Reply-To: LKML <linux-kernel@vger.kernel.org>,
       LM Sensors <sensors@stimpy.netroedge.com>
X-Mailer: Sylpheed version 0.9.8 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes many (122) printk calls missing their KERN_* constant.
There also are some other trivial fixes that were passing by
(indentation changes and string changes).

Please apply.

diff -ruN linux-2.4.24-pre1/drivers/i2c/i2c-algo-bit.c linux-2.4.24-pre1-k/drivers/i2c/i2c-algo-bit.c
--- linux-2.4.24-pre1/drivers/i2c/i2c-algo-bit.c	Mon Aug 25 13:44:41 2003
+++ linux-2.4.24-pre1-k/drivers/i2c/i2c-algo-bit.c	Sat Dec 13 15:41:57 2003
@@ -123,7 +123,7 @@
 		if (current->need_resched)
 			schedule();
 	}
-	DEBSTAT(printk("needed %ld jiffies\n", jiffies-start));
+	DEBSTAT(printk(KERN_DEBUG "needed %ld jiffies\n", jiffies-start));
 #ifdef SLO_IO
 	SLO_IO
 #endif
@@ -179,12 +179,12 @@
 	struct i2c_algo_bit_data *adap = i2c_adap->algo_data;
 
 	/* assert: scl is low */
-	DEB2(printk(" i2c_outb:%2.2X\n",c&0xff));
+	DEB2(printk(KERN_DEBUG " i2c_outb:%2.2X\n",c&0xff));
 	for ( i=7 ; i>=0 ; i-- ) {
 		sb = c & ( 1 << i );
 		setsda(adap,sb);
 		udelay(adap->udelay);
-		DEBPROTO(printk("%d",sb!=0));
+		DEBPROTO(printk(KERN_DEBUG "%d",sb!=0));
 		if (sclhi(adap)<0) { /* timed out */
 			sdahi(adap); /* we don't want to block the net */
 			return -ETIMEDOUT;
@@ -201,10 +201,10 @@
 	};
 	/* read ack: SDA should be pulled down by slave */
 	ack=getsda(adap);	/* ack: sda is pulled low ->success.	 */
-	DEB2(printk(" i2c_outb: getsda() =  0x%2.2x\n", ~ack ));
+	DEB2(printk(KERN_DEBUG " i2c_outb: getsda() =  0x%2.2x\n", ~ack ));
 
-	DEBPROTO( printk("[%2.2x]",c&0xff) );
-	DEBPROTO(if (0==ack){ printk(" A ");} else printk(" NA ") );
+	DEBPROTO( printk(KERN_DEBUG "[%2.2x]",c&0xff) );
+	DEBPROTO(if (0==ack){ printk(KERN_DEBUG " A ");} else printk(KERN_DEBUG " NA ") );
 	scllo(adap);
 	return 0==ack;		/* return 1 if device acked	 */
 	/* assert: scl is low (sda undef) */
@@ -220,7 +220,7 @@
 	struct i2c_algo_bit_data *adap = i2c_adap->algo_data;
 
 	/* assert: scl is low */
-	DEB2(printk("i2c_inb.\n"));
+	DEB2(printk(KERN_DEBUG "i2c_inb.\n"));
 
 	sdahi(adap);
 	for (i=0;i<8;i++) {
@@ -233,7 +233,7 @@
 		scllo(adap);
 	}
 	/* assert: scl is low */
-	DEBPROTO(printk(" %2.2x", indata & 0xff));
+	DEBPROTO(printk(KERN_DEBUG " 0x%02x", indata & 0xff));
 	return (int) (indata & 0xff);
 }
 
@@ -341,7 +341,7 @@
 		i2c_start(adap);
 		udelay(adap->udelay);
 	}
-	DEB2(if (i) printk("i2c-algo-bit.o: needed %d retries for %d\n",
+	DEB2(if (i) printk(KERN_DEBUG "i2c-algo-bit.o: needed %d retries for %d\n",
 	                   i,addr));
 	return ret;
 }
@@ -356,7 +356,7 @@
 
 	while (count > 0) {
 		c = *temp;
-		DEB2(printk("i2c-algo-bit.o: %s i2c_write: writing %2.2X\n",
+		DEB2(printk(KERN_DEBUG "i2c-algo-bit.o: %s sendbytes: writing %2.2X\n",
 			    i2c_adap->name, c&0xff));
 		retval = i2c_outb(i2c_adap,c);
 		if (retval>0) {
@@ -364,7 +364,7 @@
 			temp++;
 			wrcount++;
 		} else { /* arbitration or no acknowledge */
-			printk("i2c-algo-bit.o: %s i2c_write: error - bailout.\n",
+			printk(KERN_ERR "i2c-algo-bit.o: %s sendbytes: error - bailout.\n",
 			       i2c_adap->name);
 			i2c_stop(adap);
 			return (retval<0)? retval : -EFAULT;
@@ -392,7 +392,7 @@
 			*temp = inval;
 			rdcount++;
 		} else {   /* read timed out */
-			printk("i2c-algo-bit.o: i2c_read: i2c_inb timed out.\n");
+			printk(KERN_ERR "i2c-algo-bit.o: readbytes: i2c_inb timed out.\n");
 			break;
 		}
 
@@ -405,7 +405,7 @@
 		}
 		if (sclhi(adap)<0) {	/* timeout */
 			sdahi(adap);
-			printk("i2c-algo-bit.o: i2c_read: Timeout at ack\n");
+			printk(KERN_ERR "i2c-algo-bit.o: readbytes: Timeout at ack\n");
 			return -ETIMEDOUT;
 		};
 		scllo(adap);
@@ -435,18 +435,18 @@
 	if ( (flags & I2C_M_TEN)  ) { 
 		/* a ten bit address */
 		addr = 0xf0 | (( msg->addr >> 7) & 0x03);
-		DEB2(printk("addr0: %d\n",addr));
+		DEB2(printk(KERN_DEBUG "addr0: %d\n",addr));
 		/* try extended address code...*/
 		ret = try_address(i2c_adap, addr, retries);
 		if (ret!=1) {
-			printk("died at extended address code.\n");
+			printk(KERN_ERR "died at extended address code.\n");
 			return -EREMOTEIO;
 		}
 		/* the remaining 8 bit address */
 		ret = i2c_outb(i2c_adap,msg->addr & 0x7f);
 		if (ret != 1) {
 			/* the chip did not ack / xmission error occurred */
-			printk("died at 2nd address code.\n");
+			printk(KERN_ERR "died at 2nd address code.\n");
 			return -EREMOTEIO;
 		}
 		if ( flags & I2C_M_RD ) {
@@ -455,7 +455,7 @@
 			addr |= 0x01;
 			ret = try_address(i2c_adap, addr, retries);
 			if (ret!=1) {
-				printk("died at extended address code.\n");
+				printk(KERN_ERR "died at extended address code.\n");
 				return -EREMOTEIO;
 			}
 		}
@@ -490,22 +490,22 @@
 			}
 			ret = bit_doAddress(i2c_adap,pmsg,i2c_adap->retries);
 			if (ret != 0) {
-				DEB2(printk("i2c-algo-bit.o: NAK from device adr %#2x msg #%d\n"
-				       ,msgs[i].addr,i));
+				DEB2(printk(KERN_DEBUG "i2c-algo-bit.o: NAK from device addr %2.2x msg #%d\n",
+					msgs[i].addr,i));
 				return (ret<0) ? ret : -EREMOTEIO;
 			}
 		}
 		if (pmsg->flags & I2C_M_RD ) {
 			/* read bytes into buffer*/
 			ret = readbytes(i2c_adap,pmsg->buf,pmsg->len);
-			DEB2(printk("i2c-algo-bit.o: read %d bytes.\n",ret));
+			DEB2(printk(KERN_DEBUG "i2c-algo-bit.o: read %d bytes.\n",ret));
 			if (ret < pmsg->len ) {
 				return (ret<0)? ret : -EREMOTEIO;
 			}
 		} else {
 			/* write bytes from buffer */
 			ret = sendbytes(i2c_adap,pmsg->buf,pmsg->len);
-			DEB2(printk("i2c-algo-bit.o: wrote %d bytes.\n",ret));
+			DEB2(printk(KERN_DEBUG "i2c-algo-bit.o: wrote %d bytes.\n",ret));
 			if (ret < pmsg->len ) {
 				return (ret<0) ? ret : -EREMOTEIO;
 			}
@@ -555,7 +555,7 @@
 			return -ENODEV;
 	}
 
-	DEB2(printk("i2c-algo-bit.o: hw routines for %s registered.\n",
+	DEB2(printk(KERN_DEBUG "i2c-algo-bit.o: hw routines for %s registered.\n",
 	            adap->name));
 
 	/* register new adapter to i2c module... */
diff -ruN linux-2.4.24-pre1/drivers/i2c/i2c-algo-pcf.c linux-2.4.24-pre1-k/drivers/i2c/i2c-algo-pcf.c
--- linux-2.4.24-pre1/drivers/i2c/i2c-algo-pcf.c	Thu Oct 11 17:05:47 2001
+++ linux-2.4.24-pre1-k/drivers/i2c/i2c-algo-pcf.c	Thu Dec 11 22:25:42 2003
@@ -99,7 +99,7 @@
 	}
 #endif
 	if (timeout <= 0) {
-		printk("Timeout waiting for Bus Busy\n");
+		printk(KERN_ERR "Timeout waiting for Bus Busy\n");
 	}
 	
 	return (timeout<=0);
@@ -144,7 +144,7 @@
 {
 	unsigned char temp;
 
-	DEB3(printk("i2c-algo-pcf.o: PCF state 0x%02x\n", get_pcf(adap, 1)));
+	DEB3(printk(KERN_DEBUG "i2c-algo-pcf.o: PCF state 0x%02x\n", get_pcf(adap, 1)));
 
 	/* S1=0x80: S0 selected, serial interface off */
 	set_pcf(adap, 1, I2C_PCF_PIN);
@@ -152,7 +152,7 @@
 	   PCF8584 does that when ESO is zero */
 	/* PCF also resets PIN bit */
 	if ((temp = get_pcf(adap, 1)) != (0)) {
-		DEB2(printk("i2c-algo-pcf.o: PCF detection failed -- can't select S0 (0x%02x).\n", temp));
+		DEB2(printk(KERN_ERR "i2c-algo-pcf.o: PCF detection failed -- can't select S0 (0x%02x).\n", temp));
 		return -ENXIO; /* definetly not PCF8584 */
 	}
 
@@ -160,7 +160,7 @@
 	i2c_outb(adap, get_own(adap));
 	/* check it's realy writen */
 	if ((temp = i2c_inb(adap)) != get_own(adap)) {
-		DEB2(printk("i2c-algo-pcf.o: PCF detection failed -- can't set S0 (0x%02x).\n", temp));
+		DEB2(printk(KERN_ERR "i2c-algo-pcf.o: PCF detection failed -- can't set S0 (0x%02x).\n", temp));
 		return -ENXIO;
 	}
 
@@ -168,7 +168,7 @@
 	set_pcf(adap, 1, I2C_PCF_PIN | I2C_PCF_ES1);
 	/* check to see S2 now selected */
 	if ((temp = get_pcf(adap, 1)) != I2C_PCF_ES1) {
-		DEB2(printk("i2c-algo-pcf.o: PCF detection failed -- can't select S2 (0x%02x).\n", temp));
+		DEB2(printk(KERN_ERR "i2c-algo-pcf.o: PCF detection failed -- can't select S2 (0x%02x).\n", temp));
 		return -ENXIO;
 	}
 
@@ -176,7 +176,7 @@
 	i2c_outb(adap, get_clock(adap));
 	/* check it's realy writen, the only 5 lowest bits does matter */
 	if (((temp = i2c_inb(adap)) & 0x1f) != get_clock(adap)) {
-		DEB2(printk("i2c-algo-pcf.o: PCF detection failed -- can't set S2 (0x%02x).\n", temp));
+		DEB2(printk(KERN_ERR "i2c-algo-pcf.o: PCF detection failed -- can't set S2 (0x%02x).\n", temp));
 		return -ENXIO;
 	}
 
@@ -185,11 +185,11 @@
 
 	/* check to see PCF is realy idled and we can access status register */
 	if ((temp = get_pcf(adap, 1)) != (I2C_PCF_PIN | I2C_PCF_BB)) {
-		DEB2(printk("i2c-algo-pcf.o: PCF detection failed -- can't select S1` (0x%02x).\n", temp));
+		DEB2(printk(KERN_ERR "i2c-algo-pcf.o: PCF detection failed -- can't select S1` (0x%02x).\n", temp));
 		return -ENXIO;
 	}
 	
-	printk("i2c-algo-pcf.o: deteted and initialized PCF8584.\n");
+	printk(KERN_DEBUG "i2c-algo-pcf.o: deteted and initialized PCF8584.\n");
 
 	return 0;
 }
@@ -215,7 +215,7 @@
 		i2c_stop(adap);
 		udelay(adap->udelay);
 	}
-	DEB2(if (i) printk("i2c-algo-pcf.o: needed %d retries for %d\n",i,
+	DEB2(if (i) printk(KERN_DEBUG "i2c-algo-pcf.o: needed %d retries for %d\n",i,
 	                   addr));
 	return ret;
 }
@@ -228,20 +228,20 @@
 	int wrcount, status, timeout;
     
 	for (wrcount=0; wrcount<count; ++wrcount) {
-		DEB2(printk("i2c-algo-pcf.o: %s i2c_write: writing %2.2X\n",
+		DEB2(printk(KERN_DEBUG "i2c-algo-pcf.o: %s i2c_write: writing %2.2X\n",
 		      i2c_adap->name, buf[wrcount]&0xff));
 		i2c_outb(adap, buf[wrcount]);
 		timeout = wait_for_pin(adap, &status);
 		if (timeout) {
 			i2c_stop(adap);
-			printk("i2c-algo-pcf.o: %s i2c_write: "
+			printk(KERN_ERR "i2c-algo-pcf.o: %s i2c_write: "
 			       "error - timeout.\n", i2c_adap->name);
 			return -EREMOTEIO; /* got a better one ?? */
 		}
 #ifndef STUB_I2C
 		if (status & I2C_PCF_LRB) {
 			i2c_stop(adap);
-			printk("i2c-algo-pcf.o: %s i2c_write: "
+			printk(KERN_ERR "i2c-algo-pcf.o: %s i2c_write: "
 			       "error - no ack.\n", i2c_adap->name);
 			return -EREMOTEIO; /* got a better one ?? */
 		}
@@ -269,14 +269,14 @@
 
 		if (wait_for_pin(adap, &status)) {
 			i2c_stop(adap);
-			printk("i2c-algo-pcf.o: pcf_readbytes timed out.\n");
+			printk(KERN_ERR "i2c-algo-pcf.o: pcf_readbytes timed out.\n");
 			return (-1);
 		}
 
 #ifndef STUB_I2C
 		if ((status & I2C_PCF_LRB) && (i != count)) {
 			i2c_stop(adap);
-			printk("i2c-algo-pcf.o: i2c_read: i2c_inb, No ack.\n");
+			printk(KERN_ERR "i2c-algo-pcf.o: i2c_read: i2c_inb, No ack.\n");
 			return (-1);
 		}
 #endif
@@ -312,18 +312,18 @@
 	if ( (flags & I2C_M_TEN)  ) { 
 		/* a ten bit address */
 		addr = 0xf0 | (( msg->addr >> 7) & 0x03);
-		DEB2(printk("addr0: %d\n",addr));
+		DEB2(printk(KERN_DEBUG "addr0: %d\n",addr));
 		/* try extended address code...*/
 		ret = try_address(adap, addr, retries);
 		if (ret!=1) {
-			printk("died at extended address code.\n");
+			printk(KERN_ERR "died at extended address code.\n");
 			return -EREMOTEIO;
 		}
 		/* the remaining 8 bit address */
 		i2c_outb(adap,msg->addr & 0x7f);
 /* Status check comes here */
 		if (ret != 1) {
-			printk("died at 2nd address code.\n");
+			printk(KERN_ERR "died at 2nd address code.\n");
 			return -EREMOTEIO;
 		}
 		if ( flags & I2C_M_RD ) {
@@ -332,7 +332,7 @@
 			addr |= 0x01;
 			ret = try_address(adap, addr, retries);
 			if (ret!=1) {
-				printk("died at extended address code.\n");
+				printk(KERN_ERR "died at extended address code.\n");
 				return -EREMOTEIO;
 			}
 		}
@@ -360,7 +360,7 @@
 	/* Check for bus busy */
 	timeout = wait_for_bb(adap);
 	if (timeout) {
-		DEB2(printk("i2c-algo-pcf.o: "
+		DEB2(printk(KERN_ERR "i2c-algo-pcf.o: "
 		            "Timeout waiting for BB in pcf_xfer\n");)
 		return -EIO;
 	}
@@ -368,7 +368,7 @@
 	for (i = 0;ret >= 0 && i < num; i++) {
 		pmsg = &msgs[i];
 
-		DEB2(printk("i2c-algo-pcf.o: Doing %s %d bytes to 0x%02x - %d of %d messages\n",
+		DEB2(printk(KERN_DEBUG "i2c-algo-pcf.o: Doing %s %d bytes to 0x%02x - %d of %d messages\n",
 		     pmsg->flags & I2C_M_RD ? "read" : "write",
                      pmsg->len, pmsg->addr, i + 1, num);)
     
@@ -383,7 +383,7 @@
 		timeout = wait_for_pin(adap, &status);
 		if (timeout) {
 			i2c_stop(adap);
-			DEB2(printk("i2c-algo-pcf.o: Timeout waiting "
+			DEB2(printk(KERN_ERR "i2c-algo-pcf.o: Timeout waiting "
 				    "for PIN(1) in pcf_xfer\n");)
 			return (-EREMOTEIO);
 		}
@@ -392,12 +392,12 @@
 		/* Check LRB (last rcvd bit - slave ack) */
 		if (status & I2C_PCF_LRB) {
 			i2c_stop(adap);
-			DEB2(printk("i2c-algo-pcf.o: No LRB(1) in pcf_xfer\n");)
+			DEB2(printk(KERN_ERR "i2c-algo-pcf.o: No LRB(1) in pcf_xfer\n");)
 			return (-EREMOTEIO);
 		}
 #endif
     
-		DEB3(printk("i2c-algo-pcf.o: Msg %d, addr=0x%x, flags=0x%x, len=%d\n",
+		DEB3(printk(KERN_DEBUG "i2c-algo-pcf.o: Msg %d, addr=0x%x, flags=0x%x, len=%d\n",
 			    i, msgs[i].addr, msgs[i].flags, msgs[i].len);)
     
 		/* Read */
@@ -407,20 +407,20 @@
                                             (i + 1 == num));
         
 			if (ret != pmsg->len) {
-				DEB2(printk("i2c-algo-pcf.o: fail: "
+				DEB2(printk(KERN_DEBUG "i2c-algo-pcf.o: fail: "
 					    "only read %d bytes.\n",ret));
 			} else {
-				DEB2(printk("i2c-algo-pcf.o: read %d bytes.\n",ret));
+				DEB2(printk(KERN_DEBUG "i2c-algo-pcf.o: read %d bytes.\n",ret));
 			}
 		} else { /* Write */
 			ret = pcf_sendbytes(i2c_adap, pmsg->buf, pmsg->len,
                                             (i + 1 == num));
         
 			if (ret != pmsg->len) {
-				DEB2(printk("i2c-algo-pcf.o: fail: "
+				DEB2(printk(KERN_DEBUG "i2c-algo-pcf.o: fail: "
 					    "only wrote %d bytes.\n",ret));
 			} else {
-				DEB2(printk("i2c-algo-pcf.o: wrote %d bytes.\n",ret));
+				DEB2(printk(KERN_DEBUG "i2c-algo-pcf.o: wrote %d bytes.\n",ret));
 			}
 		}
 	}
@@ -461,7 +461,7 @@
 	int i, status;
 	struct i2c_algo_pcf_data *pcf_adap = adap->algo_data;
 
-	DEB2(printk("i2c-algo-pcf.o: hw routines for %s registered.\n",
+	DEB2(printk(KERN_DEBUG "i2c-algo-pcf.o: hw routines for %s registered.\n",
 	            adap->name));
 
 	/* register new adapter to i2c module... */
diff -ruN linux-2.4.24-pre1/drivers/i2c/i2c-core.c linux-2.4.24-pre1-k/drivers/i2c/i2c-core.c
--- linux-2.4.24-pre1/drivers/i2c/i2c-core.c	Mon Aug 25 13:44:41 2003
+++ linux-2.4.24-pre1-k/drivers/i2c/i2c-core.c	Sat Dec 13 14:54:25 2003
@@ -188,7 +188,7 @@
 			drivers[j]->attach_adapter(adap);
 	DRV_UNLOCK();
 	
-	DEB(printk("i2c-core.o: adapter %s registered as adapter %d.\n",
+	DEB(printk(KERN_DEBUG "i2c-core.o: adapter %s registered as adapter %d.\n",
 	           adap->name,i));
 
 	return 0;	
@@ -214,7 +214,7 @@
 		if (adap == adapters[i])
 			break;
 	if (I2C_ADAP_MAX == i) {
-		printk( "i2c-core.o: unregister_adapter adap [%s] not found.\n",
+		printk(KERN_WARNING "i2c-core.o: unregister_adapter adap [%s] not found.\n",
 			adap->name);
 		res = -ENODEV;
 		goto ERROR0;
@@ -229,7 +229,7 @@
 	for (j = 0; j < I2C_DRIVER_MAX; j++) 
 		if (drivers[j] && (drivers[j]->flags & I2C_DF_DUMMY))
 			if ((res = drivers[j]->attach_adapter(adap))) {
-				printk("i2c-core.o: can't detach adapter %s "
+				printk(KERN_WARNING "i2c-core.o: can't detach adapter %s "
 				       "while detaching driver %s: driver not "
 				       "detached!",adap->name,drivers[j]->name);
 				goto ERROR1;	
@@ -247,7 +247,7 @@
 		     * must be deleted, as this would cause invalid states.
 		     */
 			if ((res=client->driver->detach_client(client))) {
-				printk("i2c-core.o: adapter %s not "
+				printk(KERN_ERR "i2c-core.o: adapter %s not "
 					"unregistered, because client at "
 					"address %02x can't be detached. ",
 					adap->name, client->addr);
@@ -266,7 +266,7 @@
 	adap_count--;
 	
 	ADAP_UNLOCK();	
-	DEB(printk("i2c-core.o: adapter unregistered: %s\n",adap->name));
+	DEB(printk(KERN_DEBUG "i2c-core.o: adapter unregistered: %s\n",adap->name));
 	return 0;
 
 ERROR0:
@@ -305,7 +305,7 @@
 	
 	DRV_UNLOCK();	/* driver was successfully added */
 	
-	DEB(printk("i2c-core.o: driver %s registered.\n",driver->name));
+	DEB(printk(KERN_DEBUG "i2c-core.o: driver %s registered.\n",driver->name));
 	
 	ADAP_LOCK();
 
@@ -340,7 +340,7 @@
 	 * attached. If so, detach them to be able to kill the driver 
 	 * afterwards.
 	 */
-	DEB2(printk("i2c-core.o: unregister_driver - looking for clients.\n"));
+	DEB2(printk(KERN_DEBUG "i2c-core.o: unregister_driver - looking for clients.\n"));
 	/* removing clients does not depend on the notify flag, else 
 	 * invalid operation might (will!) result, when using stale client
 	 * pointers.
@@ -350,7 +350,7 @@
 		struct i2c_adapter *adap = adapters[k];
 		if (adap == NULL) /* skip empty entries. */
 			continue;
-		DEB2(printk("i2c-core.o: examining adapter %s:\n",
+		DEB2(printk(KERN_DEBUG "i2c-core.o: examining adapter %s:\n",
 			    adap->name));
 		if (driver->flags & I2C_DF_DUMMY) {
 		/* DUMMY drivers do not register their clients, so we have to
@@ -359,7 +359,7 @@
 		 * this or hell will break loose...  
 		 */
 			if ((res = driver->attach_adapter(adap))) {
-				printk("i2c-core.o: while unregistering "
+				printk(KERN_WARNING "i2c-core.o: while unregistering "
 				       "dummy driver %s, adapter %s could "
 				       "not be detached properly; driver "
 				       "not unloaded!",driver->name,
@@ -372,13 +372,13 @@
 				struct i2c_client *client = adap->clients[j];
 				if (client != NULL && 
 				    client->driver == driver) {
-					DEB2(printk("i2c-core.o: "
+					DEB2(printk(KERN_DEBUG "i2c-core.o: "
 						    "detaching client %s:\n",
 					            client->name));
 					if ((res = driver->
 							detach_client(client)))
 					{
-						printk("i2c-core.o: while "
+						printk(KERN_ERR "i2c-core.o: while "
 						       "unregistering driver "
 						       "`%s', the client at "
 						       "address %02x of "
@@ -400,7 +400,7 @@
 	driver_count--;
 	DRV_UNLOCK();
 	
-	DEB(printk("i2c-core.o: driver unregistered: %s\n",driver->name));
+	DEB(printk(KERN_DEBUG "i2c-core.o: driver unregistered: %s\n",driver->name));
 	return 0;
 }
 
@@ -436,10 +436,10 @@
 	
 	if (adapter->client_register) 
 		if (adapter->client_register(client)) 
-			printk("i2c-core.o: warning: client_register seems "
+			printk(KERN_DEBUG "i2c-core.o: warning: client_register seems "
 			       "to have failed for client %02x at adapter %s\n",
 			       client->addr,adapter->name);
-	DEB(printk("i2c-core.o: client [%s] registered to adapter [%s](pos. %d).\n",
+	DEB(printk(KERN_DEBUG "i2c-core.o: client [%s] registered to adapter [%s](pos. %d).\n",
 		client->name, adapter->name,i));
 
 	if(client->flags & I2C_CLIENT_ALLOW_USE)
@@ -470,7 +470,7 @@
 	
 	if (adapter->client_unregister != NULL) 
 		if ((res = adapter->client_unregister(client))) {
-			printk("i2c-core.o: client_unregister [%s] failed, "
+			printk(KERN_ERR "i2c-core.o: client_unregister [%s] failed, "
 			       "client not detached",client->name);
 			return res;
 		}
@@ -478,7 +478,7 @@
 	adapter->clients[i] = NULL;
 	adapter->client_count--;
 
-	DEB(printk("i2c-core.o: client [%s] unregistered.\n",client->name));
+	DEB(printk(KERN_DEBUG "i2c-core.o: client [%s] unregistered.\n",client->name));
 	return 0;
 }
 
@@ -727,7 +727,7 @@
  	} 
 	proc_bus_i2c = create_proc_entry("i2c",0,proc_bus);
 	if (!proc_bus_i2c) {
-		printk("i2c-core.o: Could not create /proc/bus/i2c");
+		printk(KERN_ERR "i2c-core.o: Could not create /proc/bus/i2c");
 		i2cproc_cleanup();
 		return -ENOENT;
  	}
@@ -764,7 +764,7 @@
 	int ret;
 
 	if (adap->algo->master_xfer) {
- 	 	DEB2(printk("i2c-core.o: master_xfer: %s with %d msgs.\n",
+ 	 	DEB2(printk(KERN_DEBUG "i2c-core.o: master_xfer: %s with %d msgs.\n",
 		            adap->name,num));
 
 		I2C_LOCK(adap);
@@ -773,7 +773,7 @@
 
 		return ret;
 	} else {
-		printk("i2c-core.o: I2C adapter %04x: I2C level transfers not supported\n",
+		printk(KERN_ERR "i2c-core.o: I2C adapter %04x: I2C level transfers not supported\n",
 		       adap->id);
 		return -ENOSYS;
 	}
@@ -791,7 +791,7 @@
 		msg.len = count;
 		(const char *)msg.buf = buf;
 	
-		DEB2(printk("i2c-core.o: master_send: writing %d bytes on %s.\n",
+		DEB2(printk(KERN_DEBUG "i2c-core.o: master_send: writing %d bytes on %s.\n",
 			count,client->adapter->name));
 	
 		I2C_LOCK(adap);
@@ -803,7 +803,7 @@
 		 */
 		return (ret == 1 )? count : ret;
 	} else {
-		printk("i2c-core.o: I2C adapter %04x: I2C level transfers not supported\n",
+		printk(KERN_ERR "i2c-core.o: I2C adapter %04x: I2C level transfers not supported\n",
 		       client->adapter->id);
 		return -ENOSYS;
 	}
@@ -821,14 +821,14 @@
 		msg.len = count;
 		msg.buf = buf;
 
-		DEB2(printk("i2c-core.o: master_recv: reading %d bytes on %s.\n",
+		DEB2(printk(KERN_DEBUG "i2c-core.o: master_recv: reading %d bytes on %s.\n",
 			count,client->adapter->name));
 	
 		I2C_LOCK(adap);
 		ret = adap->algo->master_xfer(adap,&msg,1);
 		I2C_UNLOCK(adap);
 	
-		DEB2(printk("i2c-core.o: master_recv: return:%d (count:%d, addr:0x%02x)\n",
+		DEB2(printk(KERN_DEBUG "i2c-core.o: master_recv: return:%d (count:%d, addr:0x%02x)\n",
 			ret, count, client->addr));
 	
 		/* if everything went ok (i.e. 1 msg transmitted), return #bytes
@@ -836,7 +836,7 @@
 	 	*/
 		return (ret == 1 )? count : ret;
 	} else {
-		printk("i2c-core.o: I2C adapter %04x: I2C level transfers not supported\n",
+		printk(KERN_ERR "i2c-core.o: I2C adapter %04x: I2C level transfers not supported\n",
 		       client->adapter->id);
 		return -ENOSYS;
 	}
@@ -849,7 +849,7 @@
 	int ret = 0;
 	struct i2c_adapter *adap = client->adapter;
 
-	DEB2(printk("i2c-core.o: i2c ioctl, cmd: 0x%x, arg: %#lx\n", cmd, arg));
+	DEB2(printk(KERN_DEBUG "i2c-core.o: i2c ioctl, cmd: 0x%x, arg: %#lx\n", cmd, arg));
 	switch ( cmd ) {
 		case I2C_RETRIES:
 			adap->retries = arg;
@@ -894,7 +894,7 @@
 			if (((adap_id == address_data->force[i]) || 
 			     (address_data->force[i] == ANY_I2C_BUS)) &&
 			     (addr == address_data->force[i+1])) {
-				DEB2(printk("i2c-core.o: found force parameter for adapter %d, addr %04x\n",
+				DEB2(printk(KERN_DEBUG "i2c-core.o: found force parameter for adapter %d, addr %04x\n",
 				            adap_id,addr));
 				if ((err = found_proc(adapter,addr,0,0)))
 					return err;
@@ -912,7 +912,7 @@
 			if (((adap_id == address_data->ignore[i]) || 
 			    ((address_data->ignore[i] == ANY_I2C_BUS))) &&
 			    (addr == address_data->ignore[i+1])) {
-				DEB2(printk("i2c-core.o: found ignore parameter for adapter %d, "
+				DEB2(printk(KERN_DEBUG "i2c-core.o: found ignore parameter for adapter %d, "
 				     "addr %04x\n", adap_id ,addr));
 				found = 1;
 			}
@@ -924,7 +924,7 @@
 			    ((address_data->ignore_range[i]==ANY_I2C_BUS))) &&
 			    (addr >= address_data->ignore_range[i+1]) &&
 			    (addr <= address_data->ignore_range[i+2])) {
-				DEB2(printk("i2c-core.o: found ignore_range parameter for adapter %d, "
+				DEB2(printk(KERN_DEBUG "i2c-core.o: found ignore_range parameter for adapter %d, "
 				            "addr %04x\n", adap_id,addr));
 				found = 1;
 			}
@@ -939,7 +939,7 @@
 		     i += 1) {
 			if (addr == address_data->normal_i2c[i]) {
 				found = 1;
-				DEB2(printk("i2c-core.o: found normal i2c entry for adapter %d, "
+				DEB2(printk(KERN_DEBUG "i2c-core.o: found normal i2c entry for adapter %d, "
 				            "addr %02x", adap_id,addr));
 			}
 		}
@@ -950,7 +950,7 @@
 			if ((addr >= address_data->normal_i2c_range[i]) &&
 			    (addr <= address_data->normal_i2c_range[i+1])) {
 				found = 1;
-				DEB2(printk("i2c-core.o: found normal i2c_range entry for adapter %d, "
+				DEB2(printk(KERN_DEBUG "i2c-core.o: found normal i2c_range entry for adapter %d, "
 				            "addr %04x\n", adap_id,addr));
 			}
 		}
@@ -962,7 +962,7 @@
 			    ((address_data->probe[i] == ANY_I2C_BUS))) &&
 			    (addr == address_data->probe[i+1])) {
 				found = 1;
-				DEB2(printk("i2c-core.o: found probe parameter for adapter %d, "
+				DEB2(printk(KERN_DEBUG "i2c-core.o: found probe parameter for adapter %d, "
 				            "addr %04x\n", adap_id,addr));
 			}
 		}
@@ -974,7 +974,7 @@
 			   (addr >= address_data->probe_range[i+1]) &&
 			   (addr <= address_data->probe_range[i+2])) {
 				found = 1;
-				DEB2(printk("i2c-core.o: found probe_range parameter for adapter %d, "
+				DEB2(printk(KERN_DEBUG "i2c-core.o: found probe_range parameter for adapter %d, "
 				            "addr %04x\n", adap_id,addr));
 			}
 		}
@@ -1186,13 +1186,13 @@
 		break;
 	case I2C_SMBUS_BLOCK_DATA:
 		if (read_write == I2C_SMBUS_READ) {
-			printk("i2c-core.o: Block read not supported under "
-			       "I2C emulation!\n");
-		return -1;
+			printk(KERN_ERR "i2c-core.o: Block read not supported "
+			       "under I2C emulation!\n");
+			return -1;
 		} else {
 			msg[0].len = data->block[0] + 2;
 			if (msg[0].len > 34) {
-				printk("i2c-core.o: smbus_access called with "
+				printk(KERN_ERR "i2c-core.o: smbus_access called with "
 				       "invalid block write size (%d)\n",
 				       msg[0].len);
 				return -1;
@@ -1202,7 +1202,7 @@
 		}
 		break;
 	default:
-		printk("i2c-core.o: smbus_access called with invalid size (%d)\n",
+		printk(KERN_ERR "i2c-core.o: smbus_access called with invalid size (%d)\n",
 		       size);
 		return -1;
 	}
@@ -1264,7 +1264,7 @@
 
 static int __init i2c_init(void)
 {
-	printk(KERN_INFO "i2c-core.o: i2c core module\n");
+	printk(KERN_INFO "i2c-core.o: i2c core module version %s (%s)\n", I2C_VERSION, I2C_DATE);
 	memset(adapters,0,sizeof(adapters));
 	memset(drivers,0,sizeof(drivers));
 	adap_count=0;
diff -ruN linux-2.4.24-pre1/drivers/i2c/i2c-dev.c linux-2.4.24-pre1-k/drivers/i2c/i2c-dev.c
--- linux-2.4.24-pre1/drivers/i2c/i2c-dev.c	Mon Aug 25 13:44:41 2003
+++ linux-2.4.24-pre1-k/drivers/i2c/i2c-dev.c	Sat Dec 13 14:56:48 2003
@@ -168,7 +168,7 @@
 		return -ENOMEM;
 
 #ifdef DEBUG
-	printk("i2c-dev.o: i2c-%d reading %d bytes.\n",MINOR(inode->i_rdev),
+	printk(KERN_DEBUG "i2c-dev.o: i2c-%d reading %d bytes.\n",MINOR(inode->i_rdev),
 	       count);
 #endif
 
@@ -203,7 +203,7 @@
 	}
 
 #ifdef DEBUG
-	printk("i2c-dev.o: i2c-%d writing %d bytes.\n",MINOR(inode->i_rdev),
+	printk(KERN_DEBUG "i2c-dev.o: i2c-%d writing %d bytes.\n",MINOR(inode->i_rdev),
 	       count);
 #endif
 	ret = i2c_master_send(client,tmp,count);
@@ -224,7 +224,7 @@
 	unsigned long funcs;
 
 #ifdef DEBUG
-	printk("i2c-dev.o: i2c-%d ioctl, cmd: 0x%x, arg: %lx.\n", 
+	printk(KERN_DEBUG "i2c-dev.o: i2c-%d ioctl, cmd: 0x%x, arg: %lx.\n", 
 	       MINOR(inode->i_rdev),cmd, arg);
 #endif /* DEBUG */
 
@@ -346,7 +346,7 @@
 		    (data_arg.size != I2C_SMBUS_BLOCK_DATA) &&
 		    (data_arg.size != I2C_SMBUS_I2C_BLOCK_DATA)) {
 #ifdef DEBUG
-			printk("i2c-dev.o: size out of range (%x) in ioctl I2C_SMBUS.\n",
+			printk(KERN_DEBUG "i2c-dev.o: size out of range (%x) in ioctl I2C_SMBUS.\n",
 			       data_arg.size);
 #endif
 			return -EINVAL;
@@ -356,7 +356,7 @@
 		if ((data_arg.read_write != I2C_SMBUS_READ) && 
 		    (data_arg.read_write != I2C_SMBUS_WRITE)) {
 #ifdef DEBUG
-			printk("i2c-dev.o: read_write out of range (%x) in ioctl I2C_SMBUS.\n",
+			printk(KERN_DEBUG "i2c-dev.o: read_write out of range (%x) in ioctl I2C_SMBUS.\n",
 			       data_arg.read_write);
 #endif
 			return -EINVAL;
@@ -376,7 +376,7 @@
 
 		if (data_arg.data == NULL) {
 #ifdef DEBUG
-			printk("i2c-dev.o: data is NULL pointer in ioctl I2C_SMBUS.\n");
+			printk(KERN_DEBUG "i2c-dev.o: data is NULL pointer in ioctl I2C_SMBUS.\n");
 #endif
 			return -EINVAL;
 		}
@@ -418,7 +418,7 @@
 
 	if ((minor >= I2CDEV_ADAPS_MAX) || ! (i2cdev_adaps[minor])) {
 #ifdef DEBUG
-		printk("i2c-dev.o: Trying to open unattached adapter i2c-%d\n",
+		printk(KERN_DEBUG "i2c-dev.o: Trying to open unattached adapter i2c-%d\n",
 		       minor);
 #endif
 		return -ENODEV;
@@ -439,7 +439,7 @@
 #endif /* LINUX_KERNEL_VERSION < KERNEL_VERSION(2,4,0) */
 
 #ifdef DEBUG
-	printk("i2c-dev.o: opened i2c-%d\n",minor);
+	printk(KERN_DEBUG "i2c-dev.o: opened i2c-%d\n",minor);
 #endif
 	return 0;
 }
@@ -450,7 +450,7 @@
 	kfree(file->private_data);
 	file->private_data=NULL;
 #ifdef DEBUG
-	printk("i2c-dev.o: Closed: i2c-%d\n", minor);
+	printk(KERN_DEBUG "i2c-dev.o: Closed: i2c-%d\n", minor);
 #endif
 #if LINUX_KERNEL_VERSION < KERNEL_VERSION(2,4,0)
 	MOD_DEC_USE_COUNT;
@@ -471,11 +471,11 @@
 	char name[8];
 
 	if ((i = i2c_adapter_id(adap)) < 0) {
-		printk("i2c-dev.o: Unknown adapter ?!?\n");
+		printk(KERN_DEBUG "i2c-dev.o: Unknown adapter ?!?\n");
 		return -ENODEV;
 	}
 	if (i >= I2CDEV_ADAPS_MAX) {
-		printk("i2c-dev.o: Adapter number too large?!? (%d)\n",i);
+		printk(KERN_DEBUG "i2c-dev.o: Adapter number too large?!? (%d)\n",i);
 		return -ENODEV;
 	}
 
@@ -488,7 +488,7 @@
 			S_IFCHR | S_IRUSR | S_IWUSR,
 			&i2cdev_fops, NULL);
 #endif
-		printk("i2c-dev.o: Registered '%s' as minor %d\n",adap->name,i);
+		printk(KERN_DEBUG "i2c-dev.o: Registered '%s' as minor %d\n",adap->name,i);
 	} else {
 		/* This is actually a detach_adapter call! */
 #ifdef CONFIG_DEVFS_FS
@@ -496,7 +496,7 @@
 #endif
 		i2cdev_adaps[i] = NULL;
 #ifdef DEBUG
-		printk("i2c-dev.o: Adapter unregistered: %s\n",adap->name);
+		printk(KERN_DEBUG "i2c-dev.o: Adapter unregistered: %s\n",adap->name);
 #endif
 	}
 
@@ -518,7 +518,7 @@
 {
 	int res;
 
-	printk("i2c-dev.o: i2c /dev entries driver module\n");
+	printk(KERN_INFO "i2c-dev.o: i2c /dev entries driver module version %s (%s)\n", I2C_VERSION, I2C_DATE);
 
 	i2cdev_initialized = 0;
 #ifdef CONFIG_DEVFS_FS
@@ -526,7 +526,7 @@
 #else
 	if (register_chrdev(I2C_MAJOR,"i2c",&i2cdev_fops)) {
 #endif
-		printk("i2c-dev.o: unable to get major %d for i2c bus\n",
+		printk(KERN_ERR "i2c-dev.o: unable to get major %d for i2c bus\n",
 		       I2C_MAJOR);
 		return -EIO;
 	}
@@ -536,7 +536,7 @@
 	i2cdev_initialized ++;
 
 	if ((res = i2c_add_driver(&i2cdev_driver))) {
-		printk("i2c-dev.o: Driver registration failed, module not inserted.\n");
+		printk(KERN_ERR "i2c-dev.o: Driver registration failed, module not inserted.\n");
 		i2cdev_cleanup();
 		return res;
 	}
diff -ruN linux-2.4.24-pre1/drivers/i2c/i2c-elektor.c linux-2.4.24-pre1-k/drivers/i2c/i2c-elektor.c
--- linux-2.4.24-pre1/drivers/i2c/i2c-elektor.c	Thu Oct 11 17:05:47 2001
+++ linux-2.4.24-pre1-k/drivers/i2c/i2c-elektor.c	Sat Dec 13 14:59:00 2003
@@ -78,7 +78,7 @@
 		val |= I2C_PCF_ENI;
 	}
 
-	DEB3(printk("i2c-elektor.o: Write 0x%X 0x%02X\n", address, val & 255));
+	DEB3(printk(KERN_DEBUG "i2c-elektor.o: Write 0x%X 0x%02X\n", address, val & 255));
 
 	switch (mmapped) {
 	case 0: /* regular I/O */
@@ -99,7 +99,7 @@
 	int address = ctl ? (base + 1) : base;
 	int val = mmapped ? readb(address) : inb(address);
 
-	DEB3(printk("i2c-elektor.o: Read 0x%X 0x%02X\n", address, val));
+	DEB3(printk(KERN_DEBUG "i2c-elektor.o: Read 0x%X 0x%02X\n", address, val));
 
 	return (val);
 }
@@ -142,7 +142,9 @@
 {
 	if (!mmapped) {
 		if (check_region(base, 2) < 0 ) {
-			printk("i2c-elektor.o: requested I/O region (0x%X:2) is in use.\n", base);
+			printk(KERN_ERR
+			       "i2c-elektor.o: requested I/O region (0x%X:2) "
+			       "is in use.\n", base);
 			return -ENODEV;
 		} else {
 			request_region(base, 2, "i2c (isa bus adapter)");
@@ -150,7 +152,7 @@
 	}
 	if (irq > 0) {
 		if (request_irq(irq, pcf_isa_handler, 0, "PCF8584", 0) < 0) {
-			printk("i2c-elektor.o: Request irq%d failed\n", irq);
+			printk(KERN_ERR "i2c-elektor.o: Request irq%d failed\n", irq);
 			irq = 0;
 		} else
 			enable_irq(irq);
@@ -238,7 +240,7 @@
 			/* yeap, we've found cypress, let's check config */
 			if (!pci_read_config_byte(cy693_dev, 0x47, &config)) {
 				
-				DEB3(printk("i2c-elektor.o: found cy82c693, config register 0x47 = 0x%02x.\n", config));
+				DEB3(printk(KERN_DEBUG "i2c-elektor.o: found cy82c693, config register 0x47 = 0x%02x.\n", config));
 
 				/* UP2000 board has this register set to 0xe1,
                                    but the most significant bit as seems can be 
@@ -260,7 +262,7 @@
 					   8.25 MHz (PCI/4) clock
 					   (this can be read from cypress) */
 					clock = I2C_PCF_CLK | I2C_PCF_TRNS90;
-					printk("i2c-elektor.o: found API UP2000 like board, will probe PCF8584 later.\n");
+					printk(KERN_INFO "i2c-elektor.o: found API UP2000 like board, will probe PCF8584 later.\n");
 				}
 			}
 		}
@@ -269,11 +271,11 @@
 
 	/* sanity checks for mmapped I/O */
 	if (mmapped && base < 0xc8000) {
-		printk("i2c-elektor.o: incorrect base address (0x%0X) specified for mmapped I/O.\n", base);
+		printk(KERN_ERR "i2c-elektor.o: incorrect base address (0x%0X) specified for mmapped I/O.\n", base);
 		return -ENODEV;
 	}
 
-	printk("i2c-elektor.o: i2c pcf8584-isa adapter module\n");
+	printk(KERN_INFO "i2c-elektor.o: i2c pcf8584-isa adapter module version %s (%s)\n", I2C_VERSION, I2C_DATE);
 
 	if (base == 0) {
 		base = DEFAULT_BASE;
@@ -289,7 +291,7 @@
 		return -ENODEV;
 	}
 	
-	printk("i2c-elektor.o: found device at %#x.\n", base);
+	printk(KERN_DEBUG "i2c-elektor.o: found device at %#x.\n", base);
 
 	return 0;
 }
diff -ruN linux-2.4.24-pre1/drivers/i2c/i2c-elv.c linux-2.4.24-pre1-k/drivers/i2c/i2c-elv.c
--- linux-2.4.24-pre1/drivers/i2c/i2c-elv.c	Thu Oct 11 17:05:47 2001
+++ linux-2.4.24-pre1-k/drivers/i2c/i2c-elv.c	Sat Dec 13 15:04:18 2003
@@ -95,14 +95,14 @@
 	} else {
 						/* test for ELV adap. 	*/
 		if (inb(base+1) & 0x80) {	/* BUSY should be high	*/
-			DEBINIT(printk("i2c-elv.o: Busy was low.\n"));
+			DEBINIT(printk(KERN_DEBUG "i2c-elv.o: Busy was low.\n"));
 			return -ENODEV;
 		} else {
 			outb(0x0c,base+2);	/* SLCT auf low		*/
 			udelay(400);
 			if ( !(inb(base+1) && 0x10) ) {
 				outb(0x04,base+2);
-				DEBINIT(printk("i2c-elv.o: Select was high.\n"));
+				DEBINIT(printk(KERN_DEBUG "i2c-elv.o: Select was high.\n"));
 				return -ENODEV;
 			}
 		}
@@ -170,7 +170,7 @@
 
 int __init i2c_bitelv_init(void)
 {
-	printk("i2c-elv.o: i2c ELV parallel port adapter module\n");
+	printk(KERN_INFO "i2c-elv.o: i2c ELV parallel port adapter module version %s (%s)\n", I2C_VERSION, I2C_DATE);
 	if (base==0) {
 		/* probe some values */
 		base=DEFAULT_BASE;
@@ -190,7 +190,7 @@
 			return -ENODEV;
 		}
 	}
-	printk("i2c-elv.o: found device at %#x.\n",base);
+	printk(KERN_DEBUG "i2c-elv.o: found device at %#x.\n",base);
 	return 0;
 }
 
diff -ruN linux-2.4.24-pre1/drivers/i2c/i2c-philips-par.c linux-2.4.24-pre1-k/drivers/i2c/i2c-philips-par.c
--- linux-2.4.24-pre1/drivers/i2c/i2c-philips-par.c	Sun Sep 30 21:26:05 2001
+++ linux-2.4.24-pre1-k/drivers/i2c/i2c-philips-par.c	Sat Dec 13 15:07:53 2003
@@ -190,18 +190,18 @@
 	struct i2c_par *adapter = kmalloc(sizeof(struct i2c_par),
 					  GFP_KERNEL);
 	if (!adapter) {
-		printk("i2c-philips-par: Unable to malloc.\n");
+		printk(KERN_ERR "i2c-philips-par: Unable to malloc.\n");
 		return;
 	}
 
-	printk("i2c-philips-par.o: attaching to %s\n", port->name);
+	printk(KERN_DEBUG "i2c-philips-par.o: attaching to %s\n", port->name);
 
 	adapter->pdev = parport_register_device(port, "i2c-philips-par",
 						NULL, NULL, NULL, 
 						PARPORT_FLAG_EXCL,
 						NULL);
 	if (!adapter->pdev) {
-		printk("i2c-philips-par: Unable to register with parport.\n");
+		printk(KERN_ERR "i2c-philips-par: Unable to register with parport.\n");
 		return;
 	}
 
@@ -218,7 +218,7 @@
 
 	if (i2c_bit_add_bus(&adapter->adapter) < 0)
 	{
-		printk("i2c-philips-par: Unable to register with I2C.\n");
+		printk(KERN_ERR "i2c-philips-par: Unable to register with I2C.\n");
 		parport_unregister_device(adapter->pdev);
 		kfree(adapter);
 		return;		/* No good */
@@ -264,7 +264,7 @@
 #if LINUX_VERSION_CODE < KERNEL_VERSION(2,3,4)
 	struct parport *port;
 #endif
-	printk("i2c-philips-par.o: i2c Philips parallel port adapter module\n");
+	printk(KERN_INFO "i2c-philips-par.o: i2c Philips parallel port adapter module version %s (%s)\n", I2C_VERSION, I2C_DATE);
 
 #if LINUX_VERSION_CODE >= KERNEL_VERSION(2,3,4)
 	parport_register_driver(&i2c_driver);
diff -ruN linux-2.4.24-pre1/drivers/i2c/i2c-proc.c linux-2.4.24-pre1-k/drivers/i2c/i2c-proc.c
--- linux-2.4.24-pre1/drivers/i2c/i2c-proc.c	Fri Jun 13 16:51:33 2003
+++ linux-2.4.24-pre1-k/drivers/i2c/i2c-proc.c	Sat Dec 13 15:13:13 2003
@@ -38,10 +38,6 @@
 
 #include <linux/init.h>
 
-/* FIXME need i2c versioning */
-#define LM_DATE "20010825"
-#define LM_VERSION "2.6.1"
-
 #ifndef THIS_MODULE
 #define THIS_MODULE NULL
 #endif
@@ -684,7 +680,7 @@
 				    && (addr == this_force->force[j + 1])) {
 #ifdef DEBUG
 					printk
-					    ("i2c-proc.o: found force parameter for adapter %d, addr %04x\n",
+					    (KERN_DEBUG "i2c-proc.o: found force parameter for adapter %d, addr %04x\n",
 					     adapter_id, addr);
 #endif
 					if (
@@ -714,7 +710,7 @@
 			    && (addr == address_data->ignore[i + 1])) {
 #ifdef DEBUG
 				printk
-				    ("i2c-proc.o: found ignore parameter for adapter %d, "
+				    (KERN_DEBUG "i2c-proc.o: found ignore parameter for adapter %d, "
 				     "addr %04x\n", adapter_id, addr);
 #endif
 				found = 1;
@@ -734,7 +730,7 @@
 			    && (addr <= address_data->ignore_range[i + 2])) {
 #ifdef DEBUG
 				printk
-				    ("i2c-proc.o: found ignore_range parameter for adapter %d, "
+				    (KERN_DEBUG "i2c-proc.o: found ignore_range parameter for adapter %d, "
 				     "addr %04x\n", adapter_id, addr);
 #endif
 				found = 1;
@@ -753,7 +749,7 @@
 				if (addr == address_data->normal_isa[i]) {
 #ifdef DEBUG
 					printk
-					    ("i2c-proc.o: found normal isa entry for adapter %d, "
+					    (KERN_DEBUG "i2c-proc.o: found normal isa entry for adapter %d, "
 					     "addr %04x\n", adapter_id,
 					     addr);
 #endif
@@ -775,7 +771,7 @@
 				     0)) {
 #ifdef DEBUG
 					printk
-					    ("i2c-proc.o: found normal isa_range entry for adapter %d, "
+					    (KERN_DEBUG "i2c-proc.o: found normal isa_range entry for adapter %d, "
 					     "addr %04x", adapter_id, addr);
 #endif
 					found = 1;
@@ -789,7 +785,7 @@
 					found = 1;
 #ifdef DEBUG
 					printk
-					    ("i2c-proc.o: found normal i2c entry for adapter %d, "
+					    (KERN_DEBUG "i2c-proc.o: found normal i2c entry for adapter %d, "
 					     "addr %02x", adapter_id, addr);
 #endif
 				}
@@ -805,7 +801,7 @@
 				{
 #ifdef DEBUG
 					printk
-					    ("i2c-proc.o: found normal i2c_range entry for adapter %d, "
+					    (KERN_DEBUG "i2c-proc.o: found normal i2c_range entry for adapter %d, "
 					     "addr %04x\n", adapter_id, addr);
 #endif
 					found = 1;
@@ -822,7 +818,7 @@
 			    && (addr == address_data->probe[i + 1])) {
 #ifdef DEBUG
 				printk
-				    ("i2c-proc.o: found probe parameter for adapter %d, "
+				    (KERN_DEBUG "i2c-proc.o: found probe parameter for adapter %d, "
 				     "addr %04x\n", adapter_id, addr);
 #endif
 				found = 1;
@@ -841,7 +837,7 @@
 				found = 1;
 #ifdef DEBUG
 				printk
-				    ("i2c-proc.o: found probe_range parameter for adapter %d, "
+				    (KERN_DEBUG "i2c-proc.o: found probe_range parameter for adapter %d, "
 				     "addr %04x\n", adapter_id, addr);
 #endif
 			}
@@ -862,7 +858,7 @@
 
 int __init sensors_init(void)
 {
-	printk("i2c-proc.o version %s (%s)\n", LM_VERSION, LM_DATE);
+	printk(KERN_INFO "i2c-proc.o version %s (%s)\n", I2C_VERSION, I2C_DATE);
 	i2c_initialized = 0;
 	if (!
 	    (i2c_proc_header =
diff -ruN linux-2.4.24-pre1/drivers/i2c/i2c-velleman.c linux-2.4.24-pre1-k/drivers/i2c/i2c-velleman.c
--- linux-2.4.24-pre1/drivers/i2c/i2c-velleman.c	Thu Oct 11 17:05:47 2001
+++ linux-2.4.24-pre1-k/drivers/i2c/i2c-velleman.c	Sat Dec 13 15:15:59 2003
@@ -160,7 +160,7 @@
 
 int __init  i2c_bitvelle_init(void)
 {
-	printk("i2c-velleman.o: i2c Velleman K8000 adapter module\n");
+	printk(KERN_INFO "i2c-velleman.o: i2c Velleman K8000 adapter module version %s (%s)\n", I2C_VERSION, I2C_DATE);
 	if (base==0) {
 		/* probe some values */
 		base=DEFAULT_BASE;
@@ -180,7 +180,7 @@
 			return -ENODEV;
 		}
 	}
-	printk("i2c-velleman.o: found device at %#x.\n",base);
+	printk(KERN_DEBUG "i2c-velleman.o: found device at %#x.\n",base);
 	return 0;
 }
 


-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
