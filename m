Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130696AbRCEVsl>; Mon, 5 Mar 2001 16:48:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130698AbRCEVsc>; Mon, 5 Mar 2001 16:48:32 -0500
Received: from web.sajt.cz ([212.71.160.9]:19987 "EHLO web.sajt.cz")
	by vger.kernel.org with ESMTP id <S130696AbRCEVsR>;
	Mon, 5 Mar 2001 16:48:17 -0500
Date: Mon, 5 Mar 2001 22:46:38 +0100 (CET)
From: Pavel Rabel <pavel@web.sajt.cz>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] mad16 C924 detection
Message-ID: <Pine.LNX.4.21.0103052244440.4042-100000@web.sajt.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Patch is replacing 7 levels of nested ifs with something
readable. Against 2.4 kernels. I have posted this one already once,
trying again.

The driver doesn't support C924 in both PnP and non-PnP modes as it
claims. It looks like part of the code got lost or was not finished. This
patch makes it more clear what's going on. There are many places in the
driver with two different paths for C924, only one is ever used.

Pavel Rabel

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



