Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261742AbSL2VrC>; Sun, 29 Dec 2002 16:47:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261799AbSL2VrC>; Sun, 29 Dec 2002 16:47:02 -0500
Received: from verein.lst.de ([212.34.181.86]:35083 "EHLO verein.lst.de")
	by vger.kernel.org with ESMTP id <S261742AbSL2VrA>;
	Sun, 29 Dec 2002 16:47:00 -0500
Date: Sun, 29 Dec 2002 22:55:19 +0100
From: Christoph Hellwig <hch@lst.de>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] check_region remove for drivers/i2c/
Message-ID: <20021229225519.A12080@lst.de>
Mail-Followup-To: Christoph Hellwig <hch@lst.de>, torvalds@transmeta.com,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trying to get the i2c code in shape at some point..


--- 1.5/drivers/i2c/i2c-adap-ite.c	Thu May 23 12:07:43 2002
+++ edited/drivers/i2c/i2c-adap-ite.c	Sun Dec 29 21:43:46 2002
@@ -160,19 +160,17 @@
  */
 static int iic_hw_resrc_init(void)
 {
-  	if (check_region(gpi.iic_base, ITE_IIC_IO_SIZE) < 0 ) {
-   	   return -ENODEV;
-  	} else {
-  	   request_region(gpi.iic_base, ITE_IIC_IO_SIZE, 
-		"i2c (i2c bus adapter)");
-  	}
-	if (gpi.iic_irq > 0) {
-	   if (request_irq(gpi.iic_irq, iic_ite_handler, 0, "ITE IIC", 0) < 0) {
-	      gpi.iic_irq = 0;
-	   } else
-	      DEB3(printk("Enabled IIC IRQ %d\n", gpi.iic_irq));
-	      enable_irq(gpi.iic_irq);
-	}
+	if (!request_region(gpi.iic_base, ITE_IIC_IO_SIZE, "i2c"))
+		return -ENODEV;
+  
+	if (gpi.iic_irq <= 0)
+		return 0;
+
+	if (request_irq(gpi.iic_irq, iic_ite_handler, 0, "ITE IIC", 0) < 0)
+		gpi.iic_irq = 0;
+	else
+		enable_irq(gpi.iic_irq);
+
 	return 0;
 }
 
--- 1.10/drivers/i2c/i2c-elektor.c	Mon Nov 18 07:42:08 2002
+++ edited/drivers/i2c/i2c-elektor.c	Sun Dec 29 21:44:33 2002
@@ -142,11 +142,11 @@
 static int pcf_isa_init(void)
 {
 	if (!mmapped) {
-		if (check_region(base, 2) < 0 ) {
-			printk(KERN_ERR "i2c-elektor.o: requested I/O region (0x%X:2) is in use.\n", base);
+		if (!request_region(base, 2, "i2c (isa bus adapter)"))
+			printk(KERN_ERR
+			       "i2c-elektor.o: requested I/O region (0x%X:2) "
+			       "is in use.\n", base);
 			return -ENODEV;
-		} else {
-			request_region(base, 2, "i2c (isa bus adapter)");
 		}
 	}
 	if (irq > 0) {
--- 1.6/drivers/i2c/i2c-elv.c	Tue May 14 18:01:25 2002
+++ edited/drivers/i2c/i2c-elv.c	Sun Dec 29 21:46:23 2002
@@ -88,34 +88,31 @@
 
 static int bit_elv_init(void)
 {
-	if (check_region(base,(base == 0x3bc)? 3 : 8) < 0 ) {
-		return -ENODEV;	
-	} else {
-						/* test for ELV adap. 	*/
-		if (inb(base+1) & 0x80) {	/* BUSY should be high	*/
-			DEBINIT(printk(KERN_DEBUG "i2c-elv.o: Busy was low.\n"));
-			return -ENODEV;
-		} else {
-			outb(0x0c,base+2);	/* SLCT auf low		*/
-			udelay(400);
-			if ( !(inb(base+1) && 0x10) ) {
-				outb(0x04,base+2);
-				DEBINIT(printk(KERN_DEBUG "i2c-elv.o: Select was high.\n"));
-				return -ENODEV;
-			}
-		}
-		request_region(base,(base == 0x3bc)? 3 : 8,
-			"i2c (ELV adapter)");
-		PortData = 0;
-		bit_elv_setsda((void*)base,1);
-		bit_elv_setscl((void*)base,1);
+	if (!request_region(base, (base == 0x3bc) ? 3 : 8,
+				"i2c (ELV adapter)"))
+		return -ENODEV;
+
+	if (inb(base+1) & 0x80) {	/* BUSY should be high	*/
+		DEBINIT(printk(KERN_DEBUG "i2c-elv.o: Busy was low.\n"));
+		goto fail;
+	} 
+
+	outb(0x0c,base+2);	/* SLCT auf low		*/
+	udelay(400);
+	if (!(inb(base+1) && 0x10)) {
+		outb(0x04,base+2);
+		DEBINIT(printk(KERN_DEBUG "i2c-elv.o: Select was high.\n"));
+		goto fail;
 	}
+
+	PortData = 0;
+	bit_elv_setsda((void*)base,1);
+	bit_elv_setscl((void*)base,1);
 	return 0;
-}
 
-static void __exit bit_elv_exit(void)
-{
-	release_region( base , (base == 0x3bc)? 3 : 8 );
+fail:
+	release_region(base , (base == 0x3bc) ? 3 : 8);
+	return -ENODEV;
 }
 
 static int bit_elv_reg(struct i2c_client *client)
--- 1.2/drivers/i2c/i2c-frodo.c	Mon Nov 18 09:02:17 2002
+++ edited/drivers/i2c/i2c-frodo.c	Sun Dec 29 18:25:35 2002
@@ -96,8 +96,6 @@
 	return (i2c_bit_add_bus (&frodo_ops));
 }
 
-EXPORT_NO_SYMBOLS;
-
 static void __exit i2c_frodo_exit (void)
 {
 	i2c_bit_del_bus (&frodo_ops);
@@ -105,12 +103,7 @@
 
 MODULE_AUTHOR ("Abraham van der Merwe <abraham@2d3d.co.za>");
 MODULE_DESCRIPTION ("I2C-Bus adapter routines for Frodo");
-
-#ifdef MODULE_LICENSE
 MODULE_LICENSE ("GPL");
-#endif	/* #ifdef MODULE_LICENSE */
-
-EXPORT_NO_SYMBOLS;
 
 module_init (i2c_frodo_init);
 module_exit (i2c_frodo_exit);
===== drivers/i2c/i2c-philips-par.c 1.5 vs edited =====
--- 1.5/drivers/i2c/i2c-philips-par.c	Tue Sep 17 15:53:02 2002
+++ edited/drivers/i2c/i2c-philips-par.c	Sun Dec 29 18:26:03 2002
@@ -297,14 +297,5 @@
 
 MODULE_PARM(type, "i");
 
-#ifdef MODULE
-int init_module(void)
-{
-	return i2c_bitlp_init();
-}
-
-void cleanup_module(void)
-{
-	i2c_bitlp_exit();
-}
-#endif
+module_init(i2c_bitlp_init);
+module_exit(i2c_bitlp_exit);
--- 1.8/drivers/i2c/i2c-proc.c	Sun Dec  1 19:42:06 2002
+++ edited/drivers/i2c/i2c-proc.c	Sun Dec 29 21:48:56 2002
@@ -648,6 +643,7 @@
 					I2C_FUNC_SMBUS_QUICK)) return -1;
 
 	for (addr = 0x00; addr <= (is_isa ? 0xffff : 0x7f); addr++) {
+		/* XXX: WTF is going on here??? */
 		if ((is_isa && check_region(addr, 1)) ||
 		    (!is_isa && i2c_check_addr(adapter, addr)))
 			continue;
