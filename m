Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262623AbSJBVqy>; Wed, 2 Oct 2002 17:46:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262624AbSJBVqx>; Wed, 2 Oct 2002 17:46:53 -0400
Received: from pc1-cwma1-5-cust51.swa.cable.ntl.com ([80.5.120.51]:28413 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S262623AbSJBVqu>; Wed, 2 Oct 2002 17:46:50 -0400
Subject: PATCH: 2.5 Fix set_bit abuse in ATP driver
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 02 Oct 2002 22:59:58 +0100
Message-Id: <1033595998.25240.9.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.2.5.40/drivers/net/atp.c linux.2.5.40-ac1/drivers/net/atp.c
--- linux.2.5.40/drivers/net/atp.c	2002-10-02 21:33:29.000000000 +0100
+++ linux.2.5.40-ac1/drivers/net/atp.c	2002-10-02 22:40:31.000000000 +0100
@@ -27,11 +27,12 @@
 

 	Modular support/softnet added by Alan Cox.
+	_bit abuse fixed up by Alan Cox
 
 */
 
 static const char versionA[] =
-"atp.c:v1.09 8/9/2000 Donald Becker <becker@scyld.com>\n";
+"atp.c:v1.09=ac 2002/10/01 Donald Becker <becker@scyld.com>\n";
 static const char versionB[] =
 "  http://www.scyld.com/network/atp.html\n";
 
@@ -164,8 +165,6 @@
 MODULE_PARM_DESC(irq, "ATP IRQ number(s)");
 MODULE_PARM_DESC(xcvr, "ATP tranceiver(s) (0=internal, 1=external)");
 
-#define RUN_AT(x) (jiffies + (x))
-
 /* The number of low I/O ports used by the ethercard. */
 #define ETHERCARD_TOTAL_SIZE	3
 
@@ -223,6 +222,8 @@
    If dev->base_addr == 1, always return failure.
    If dev->base_addr == 2, allocate space for the device and return success
    (detachable devices only).
+   
+   FIXME: we should use the parport layer for this
    */
 static int __init atp_init(struct net_device *dev)
 {
@@ -402,13 +403,13 @@
  * DO :	 _________X_______X
  */
 
-static unsigned short __init eeprom_op(long ioaddr, unsigned int cmd)
+static unsigned short __init eeprom_op(long ioaddr, u32 cmd)
 {
 	unsigned eedata_out = 0;
 	int num_bits = EE_CMD_SIZE;
 
 	while (--num_bits >= 0) {
-		char outval = test_bit(num_bits, &cmd) ? EE_DATA_WRITE : 0;
+		char outval = (cmd & (1<<num_bits)) ? EE_DATA_WRITE : 0;
 		write_reg_high(ioaddr, PROM_CMD, outval | EE_CLK_LOW);
 		write_reg_high(ioaddr, PROM_CMD, outval | EE_CLK_HIGH);
 		eedata_out <<= 1;
@@ -445,7 +446,7 @@
 	hardware_init(dev);
 
 	init_timer(&lp->timer);
-	lp->timer.expires = RUN_AT(TIMED_CHECKER);
+	lp->timer.expires = jiffies + TIMED_CHECKER;
 	lp->timer.data = (unsigned long)dev;
 	lp->timer.function = &atp_timed_checker;    /* timer handler */
 	add_timer(&lp->timer);
@@ -687,7 +688,7 @@
 		for (i = 0; i < 6; i++)
 			write_reg_byte(ioaddr, PAR0 + i, dev->dev_addr[i]);
 #if 0 && defined(TIMED_CHECKER)
-		mod_timer(&lp->timer, RUN_AT(TIMED_CHECKER));
+		mod_timer(&lp->timer, jiffies + TIMED_CHECKER);
 #endif
 	}
 
@@ -740,7 +741,7 @@
 #endif
 	}
 	spin_unlock(&lp->lock);
-	lp->timer.expires = RUN_AT(TIMED_CHECKER);
+	lp->timer.expires = jiffies + TIMED_CHECKER;
 	add_timer(&lp->timer);
 }
 #endif
@@ -893,8 +894,10 @@
 		memset(mc_filter, 0, sizeof(mc_filter));
 		for (i = 0, mclist = dev->mc_list; mclist && i < dev->mc_count;
 			 i++, mclist = mclist->next)
-			set_bit(ether_crc_le(ETH_ALEN, mclist->dmi_addr) & 0x3f,
-					mc_filter);
+		{
+			int filterbit = ether_crc_le(ETH_ALEN, mclist->dmi_addr) & 0x3f;
+			mc_filter[filterbit >> 5] |= cpu_to_le32(1 << (filterbit & 31));
+		}
 		new_mode = CMR2h_Normal;
 	}
 	lp->addr_mode = new_mode;
