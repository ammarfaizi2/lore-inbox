Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129814AbQKPXti>; Thu, 16 Nov 2000 18:49:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131539AbQKPXt2>; Thu, 16 Nov 2000 18:49:28 -0500
Received: from web.sajt.cz ([212.71.160.9]:51986 "EHLO web.sajt.cz")
	by vger.kernel.org with ESMTP id <S129814AbQKPXtR>;
	Thu, 16 Nov 2000 18:49:17 -0500
Date: Fri, 17 Nov 2000 00:18:48 +0100 (CET)
From: Pavel Rabel <pavel@web.sajt.cz>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] MAD16 madness
Message-ID: <Pine.LNX.4.21.0011170010130.9058-100000@web.sajt.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

When I saw the mad16.c driver, I just couldn't resist.
There were 7 (seven) levels of nested ifs.
It looks like more cleaning can be done, but this patch is just
reorganising the code without any functionality change and makes the 
questionable logic more readable. 

Patch against latest 2.4test, similar patch can be
written for 2.2, it's just using older API.

Pavel

--- drivers/sound/mad16.c.old	Wed Nov 15 20:18:57 2000
+++ drivers/sound/mad16.c	Thu Nov 16 23:07:44 2000
@@ -462,72 +462,80 @@
 
 	DDB(printk("Detect using password = 0xE5\n"));
 	
-	if (!detect_mad16())	/* No luck. Try different model */
-	{
-		board_type = C928;
+	if (detect_mad16()) {
+		return 1;
+	}
+	
+	board_type = C928;
 
-		DDB(printk("Detect using password = 0xE2\n"));
+	DDB(printk("Detect using password = 0xE2\n"));
 
-		if (!detect_mad16())
-		{
-			board_type = C929;
-
-			DDB(printk("Detect using password = 0xE3\n"));
-
-			if (!detect_mad16())
-			{
-				if (inb(PASSWD_REG) != 0xff)
-					return 0;
-
-				/*
-				 * First relocate MC# registers to 0xe0e/0xe0f, disable password 
-				 */
-
-				outb((0xE4), PASSWD_REG);
-				outb((0x80), PASSWD_REG);
-
-				board_type = C930;
-
-				DDB(printk("Detect using password = 0xE4\n"));
-
-				for (i = 0xf8d; i <= 0xf93; i++)
-					DDB(printk("port %03x = %02x\n", i, mad_read(i)));
-                                if(!detect_mad16()) {
-
-				  /* The C931 has the password reg at F8D */
-				  outb((0xE4), 0xF8D);
-				  outb((0x80), 0xF8D);
-				  DDB(printk("Detect using password = 0xE4 for C931\n"));
-
-				  if (!detect_mad16()) {
-				    board_type = C924;
-				    c924pnp++;
-				    DDB(printk("Detect using password = 0xE5 (again), port offset -0x80\n"));
-				    if (!detect_mad16()) {
-				      c924pnp=0;
-				      return 0;
-				    }
-				  
-				    DDB(printk("mad16.c: 82C924 PnP detected\n"));
-				  }
-				}
-				else
-				  DDB(printk("mad16.c: 82C930 detected\n"));
-			} else
-				DDB(printk("mad16.c: 82C929 detected\n"));
-		} else {
-			unsigned char model;
+	if (detect_mad16())
+	{
+		unsigned char model;
 
-			if (((model = mad_read(MC3_PORT)) & 0x03) == 0x03) {
-				DDB(printk("mad16.c: Mozart detected\n"));
-				board_type = MOZART;
-			} else {
-				DDB(printk("mad16.c: 82C928 detected???\n"));
-				board_type = C928;
-			}
+		if (((model = mad_read(MC3_PORT)) & 0x03) == 0x03) {
+			DDB(printk("mad16.c: Mozart detected\n"));
+			board_type = MOZART;
+		} else {
+			DDB(printk("mad16.c: 82C928 detected???\n"));
+			board_type = C928;
 		}
+		return 1;
+	}
+
+	board_type = C929;
+
+	DDB(printk("Detect using password = 0xE3\n"));
+
+	if (detect_mad16())
+	{
+		DDB(printk("mad16.c: 82C929 detected\n"));
+		return 1;
+	}
+
+	if (inb(PASSWD_REG) != 0xff)
+		return 0;
+
+	/*
+	 * First relocate MC# registers to 0xe0e/0xe0f, disable password 
+	 */
+
+	outb((0xE4), PASSWD_REG);
+	outb((0x80), PASSWD_REG);
+
+	board_type = C930;
+
+	DDB(printk("Detect using password = 0xE4\n"));
+
+	for (i = 0xf8d; i <= 0xf93; i++)
+		DDB(printk("port %03x = %02x\n", i, mad_read(i)));
+
+        if(detect_mad16()) {
+		DDB(printk("mad16.c: 82C930 detected\n"));
+		return 1;
 	}
-	return 1;
+
+	/* The C931 has the password reg at F8D */
+	outb((0xE4), 0xF8D);
+	outb((0x80), 0xF8D);
+	DDB(printk("Detect using password = 0xE4 for C931\n"));
+
+	if (detect_mad16()) {
+		return 1;
+	}
+
+	board_type = C924;
+	c924pnp++;
+	DDB(printk("Detect using password = 0xE5 (again), port offset -0x80\n"));
+	if (detect_mad16()) {
+		DDB(printk("mad16.c: 82C924 PnP detected\n"));
+		return 1;
+	}
+	
+	c924pnp=0;
+
+	return 0;
 }
 
 static int __init probe_mad16(struct address_info *hw_config)

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
