Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129507AbQKWMEL>; Thu, 23 Nov 2000 07:04:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S131997AbQKWMEB>; Thu, 23 Nov 2000 07:04:01 -0500
Received: from web.sajt.cz ([212.71.160.9]:15879 "EHLO web.sajt.cz")
        by vger.kernel.org with ESMTP id <S129507AbQKWMDu>;
        Thu, 23 Nov 2000 07:03:50 -0500
Date: Thu, 23 Nov 2000 12:32:45 +0100 (CET)
From: Pavel Rabel <pavel@web.sajt.cz>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] mad16 MPU probing
Message-ID: <Pine.LNX.4.21.0011231158350.25032-100000@web.sajt.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Small cleanup in mad16.c MPU probing code. Against any 2.4 kernel.
Replacing mad loops with readable switches. Removing unnecessary array
declarations. Removing variable 'with secret power'. Removing double
declaration (tmp).

Is there a maintainer for this stuff? 
Whom to feed with this kind of cleanup patches? 

Pavel Rabel


--- drivers/sound/mad16.c.old	Wed Sep 27 20:53:56 2000
+++ drivers/sound/mad16.c	Thu Nov 23 11:00:47 2000
@@ -718,13 +718,7 @@
 static int __init probe_mad16_mpu(struct address_info *hw_config)
 {
 	static int mpu_attached = 0;
-	static int valid_ports[] = {
-		0x330, 0x320, 0x310, 0x300
-	};
-	
-	static short valid_irqs[] = {9, 10, 5, 7};
 	unsigned char tmp;
-	int i;				/* A variable with secret power */
 
 	if (!already_initialized)	/* The MSS port must be initialized first */
 		return 0;
@@ -737,7 +731,6 @@
 	{
 
 #ifdef CONFIG_MAD16_OLDCARD
-		unsigned char   tmp;
 
 		tmp = mad_read(MC3_PORT);
 
@@ -787,9 +780,6 @@
 		 * to set MPU register. TODO - add probing
 		 */
 
-		
-		unsigned char tmp;
-
 		tmp = mad_read(MC8_PORT);
 
 		switch (hw_config->irq)
@@ -840,42 +830,50 @@
 	tmp = mad_read(MC6_PORT) & 0x83;
 	tmp |= 0x80;		/* MPU-401 enable */
 
-/*
- * Set the MPU base bits
- */
+	/* Set the MPU base bits */
 
-	for (i = 0; i < 5; i++)
+	switch (hw_config->io_base)
 	{
-		if (i > 3)	/* Out of array bounds */
-		{
-			printk(KERN_ERR "MAD16 / Mozart: Invalid MIDI port 0x%x\n", hw_config->io_base);
-			return 0;
-		}
-		if (valid_ports[i] == hw_config->io_base)
-		{
-			tmp |= i << 5;
+		case 0x300:
+			tmp |= 0x60;
 			break;
-		}
+		case 0x310:
+			tmp |= 0x40;
+			break;
+		case 0x320:
+			tmp |= 0x20;
+			break;
+		case 0x330:
+			tmp |= 0x00;
+			break;
+		default:
+			printk(KERN_ERR "MAD16: Invalid MIDI port 0x%x\n", hw_config->io_base);
+			return 0;
 	}
 
-/*
- * Set the MPU IRQ bits
- */
+	/* Set the MPU IRQ bits */
 
-	for (i = 0; i < 5; i++)
+	switch (hw_config->irq)
 	{
-		if (i > 3)	/* Out of array bounds */
-		{
-			printk(KERN_ERR "MAD16 / Mozart: Invalid MIDI IRQ %d\n", hw_config->irq);
-			return 0;
-		}
-		if (valid_irqs[i] == hw_config->irq)
-		{
-			tmp |= i << 3;
+		case 5:
+			tmp |= 0x10;
+			break;
+		case 7:
+			tmp |= 0x18;
+			break;
+		case 9:
+			tmp |= 0x00;
+			break;
+		case 10:
+			tmp |= 0x08;
+			break;
+		default:
+			printk(KERN_ERR "MAD16: Invalid MIDI IRQ %d\n", hw_config->irq);
 			break;
-		}
 	}
+			
 	mad_write(MC6_PORT, tmp);	/* Write MPU401 config */
+
 #ifndef CONFIG_MAD16_OLDCARD
 probe_401:
 #endif

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
