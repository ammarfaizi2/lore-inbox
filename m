Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268282AbUHQPWM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268282AbUHQPWM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Aug 2004 11:22:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268301AbUHQPWM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Aug 2004 11:22:12 -0400
Received: from fep02fe.ttnet.net.tr ([212.156.4.132]:42714 "EHLO
	fep02.ttnet.net.tr") by vger.kernel.org with ESMTP id S268282AbUHQPPv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Aug 2004 11:15:51 -0400
Message-ID: <412220EB.7090909@ttnet.net.tr>
Date: Tue, 17 Aug 2004 18:14:51 +0300
From: "O.Sezer" <sezeroz@ttnet.net.tr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.2) Gecko/20040308
X-Accept-Language: tr, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: marcelo.tosatti@cyclades.com
Subject: [PATCH] [2.4.28-pre1] more gcc3.4 inline fixes [5/10]
Content-Type: multipart/mixed;
	boundary="------------080309050700020706070100"
X-ESAFE-STATUS: Mail clean
X-ESAFE-DETAILS: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080309050700020706070100
Content-Type: text/plain;
	charset=ISO-8859-9;
	format=flowed
Content-Transfer-Encoding: 7bit


--------------080309050700020706070100
Content-Type: text/plain;
	name="gcc34_inline_05.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="gcc34_inline_05.diff"

--- 28p1/drivers/mtd/devices/doc1000.c~	2003-06-13 17:51:34.000000000 +0300
+++ 28p1/drivers/mtd/devices/doc1000.c	2004-08-16 22:33:26.000000000 +0300
@@ -137,6 +137,119 @@
 	return 0;
 }
 
+static inline int suspend_erase(volatile u_char *addr)
+{
+	__u16 status;
+	u_long i = 0;
+	
+	writew(IF_ERASE_SUSPEND, addr);
+	writew(IF_READ_CSR, addr);
+	
+	do {
+		status = readw(addr);
+		if ((status & CSR_WR_READY) == CSR_WR_READY)
+			return 0;
+		i++;
+	} while(i < max_tries);
+
+	printk(KERN_NOTICE "flashcard: suspend_erase timed out, status 0x%x\n", status);
+	return -EIO;
+
+}
+
+static inline void resume_erase(volatile u_char *addr)
+{
+	__u16 status;
+	
+	writew(IF_READ_CSR, addr);
+	status = readw(addr);
+	
+	/* Only give resume signal if the erase is really suspended */
+	if (status & CSR_ERA_SUSPEND)
+		writew(IF_CONFIRM, addr);
+}
+
+static inline int byte_write (volatile u_char *addr, u_char byte)
+{
+	register u_char status;
+	register u_short i = 0;
+
+	do {
+		status = readb(addr);
+		if (status & CSR_WR_READY)
+		{
+			writeb(IF_WRITE & 0xff, addr);
+			writeb(byte, addr);
+			return 0;
+		}
+		i++;
+	} while(i < max_tries);
+
+		
+	printk(KERN_NOTICE "flashcard: byte_write timed out, status 0x%x\n",status);
+	return -EIO;
+}
+
+static inline int word_write (volatile u_char *addr, __u16 word)
+{
+	register u_short status;
+	register u_short i = 0;
+	
+	do {
+		status = readw(addr);
+		if ((status & CSR_WR_READY) == CSR_WR_READY)
+		{
+			writew(IF_WRITE, addr);
+			writew(word, addr);
+			return 0;
+		}
+		i++;
+	} while(i < max_tries);
+		
+	printk(KERN_NOTICE "flashcard: word_write timed out at %p, status 0x%x\n", addr, status);
+	return -EIO;
+}
+
+static inline void reset_block(volatile u_char *addr)
+{
+	u_short i;
+	__u16 status;
+
+	writew(IF_CLEAR_CSR, addr);
+
+	for (i = 0; i < 100; i++) {
+		writew(IF_READ_CSR, addr);
+		status = readw(addr);
+		if (status != 0xffff) break;
+		udelay(1000);
+	}
+
+	writew(IF_READ_CSR, addr);
+}
+
+static inline int check_write(volatile u_char *addr)
+{
+	u_short status, i = 0;
+	
+	writew(IF_READ_CSR, addr);
+	
+	do {
+		status = readw(addr);
+		if (status & (CSR_WR_ERR | CSR_VPP_LOW))
+		{
+			printk(KERN_NOTICE "flashcard: write failure at %p, status 0x%x\n", addr, status);
+			reset_block(addr);
+			return -EIO;
+		}
+		if ((status & CSR_WR_READY) == CSR_WR_READY)
+			return 0;
+		i++;
+	} while (i < max_tries);
+
+	printk(KERN_NOTICE "flashcard: write timed out at %p, status 0x%x\n", addr, status);
+	return -EIO;
+}
+
 
 int flashcard_read (struct mtd_info *mtd, loff_t from, size_t len, size_t *retlen, u_char *buf)
 {
@@ -281,47 +394,6 @@
 
 /*====================================================================*/
 
-static inline int byte_write (volatile u_char *addr, u_char byte)
-{
-	register u_char status;
-	register u_short i = 0;
-
-	do {
-		status = readb(addr);
-		if (status & CSR_WR_READY)
-		{
-			writeb(IF_WRITE & 0xff, addr);
-			writeb(byte, addr);
-			return 0;
-		}
-		i++;
-	} while(i < max_tries);
-
-		
-	printk(KERN_NOTICE "flashcard: byte_write timed out, status 0x%x\n",status);
-	return -EIO;
-}
-
-static inline int word_write (volatile u_char *addr, __u16 word)
-{
-	register u_short status;
-	register u_short i = 0;
-	
-	do {
-		status = readw(addr);
-		if ((status & CSR_WR_READY) == CSR_WR_READY)
-		{
-			writew(IF_WRITE, addr);
-			writew(word, addr);
-			return 0;
-		}
-		i++;
-	} while(i < max_tries);
-		
-	printk(KERN_NOTICE "flashcard: word_write timed out at %p, status 0x%x\n", addr, status);
-	return -EIO;
-}
-
 static inline void block_erase (volatile u_char *addr)
 {
 	writew(IF_BLOCK_ERASE, addr);
@@ -350,79 +422,6 @@
 	return 0;
 }
 
-static inline int suspend_erase(volatile u_char *addr)
-{
-	__u16 status;
-	u_long i = 0;
-	
-	writew(IF_ERASE_SUSPEND, addr);
-	writew(IF_READ_CSR, addr);
-	
-	do {
-		status = readw(addr);
-		if ((status & CSR_WR_READY) == CSR_WR_READY)
-			return 0;
-		i++;
-	} while(i < max_tries);
-
-	printk(KERN_NOTICE "flashcard: suspend_erase timed out, status 0x%x\n", status);
-	return -EIO;
-
-}
-
-static inline void resume_erase(volatile u_char *addr)
-{
-	__u16 status;
-	
-	writew(IF_READ_CSR, addr);
-	status = readw(addr);
-	
-	/* Only give resume signal if the erase is really suspended */
-	if (status & CSR_ERA_SUSPEND)
-		writew(IF_CONFIRM, addr);
-}
-
-static inline void reset_block(volatile u_char *addr)
-{
-	u_short i;
-	__u16 status;
-
-	writew(IF_CLEAR_CSR, addr);
-
-	for (i = 0; i < 100; i++) {
-		writew(IF_READ_CSR, addr);
-		status = readw(addr);
-		if (status != 0xffff) break;
-		udelay(1000);
-	}
-
-	writew(IF_READ_CSR, addr);
-}
-
-static inline int check_write(volatile u_char *addr)
-{
-	u_short status, i = 0;
-	
-	writew(IF_READ_CSR, addr);
-	
-	do {
-		status = readw(addr);
-		if (status & (CSR_WR_ERR | CSR_VPP_LOW))
-		{
-			printk(KERN_NOTICE "flashcard: write failure at %p, status 0x%x\n", addr, status);
-			reset_block(addr);
-			return -EIO;
-		}
-		if ((status & CSR_WR_READY) == CSR_WR_READY)
-			return 0;
-		i++;
-	} while (i < max_tries);
-
-	printk(KERN_NOTICE "flashcard: write timed out at %p, status 0x%x\n", addr, status);
-	return -EIO;
-}
-
-
 /*====================================================================*/
 
 

--------------080309050700020706070100--
