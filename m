Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268127AbTBMWis>; Thu, 13 Feb 2003 17:38:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268126AbTBMWis>; Thu, 13 Feb 2003 17:38:48 -0500
Received: from mail.scram.de ([195.226.127.117]:31942 "EHLO mail.scram.de")
	by vger.kernel.org with ESMTP id <S268127AbTBMWhb>;
	Thu, 13 Feb 2003 17:37:31 -0500
Date: Thu, 13 Feb 2003 23:46:59 +0100 (CET)
From: Jochen Friedrich <jochen@scram.de>
X-X-Sender: jochen@gfrw1044.bocc.de
To: Linux Kernel <linux-kernel@vger.kernel.org>
cc: Linus Torvalds <torvalds@transmeta.com>, Jeff Garzik <jgarzik@pobox.com>
Subject: [BUG] smctr.c changes in latest BK 
Message-ID: <Pine.LNX.4.44.0302132335540.28838-100000@gfrw1044.bocc.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

===== smctr.c 1.15 vs 1.16 =====
--- 1.15/drivers/net/tokenring/smctr.c  Thu Nov 21 23:06:12 2002
+++ 1.16/drivers/net/tokenring/smctr.c  Thu Feb 13 07:23:32 2003
@@ -3064,7 +3064,7 @@
         __u8 r;

         /* Check if node address has been specified by user. (non-0) */
-        for(i = 0; ((i < 6) && (dev->dev_addr[i] == 0)); i++);
+        for(i = 0; ((i < 6) && (dev->dev_addr[i] == 0)); i++)
         {
                 if(i != 6)
                 {

Please revert this one as it is just wrong. As already mentioned here in
LKML (IIRC it was Alan), the semicolon is really intended here.

The above loop just runs until a non-zero byte is found in the MAC
address or all 6 bytes have been checked. A value of i=6 will then
indicate an all-zero MAC address.

However, the block following the for loop is completely unnecessary and
confusing. This patch just removes the irritating braces:

===== smctr.c 1.17 vs edited =====
--- 1.17/drivers/net/tokenring/smctr.c  Thu Feb 13 22:47:11 2003
+++ edited/smctr.c      Thu Feb 13 23:44:07 2003
@@ -3058,26 +3058,25 @@
         __u8 r;

         /* Check if node address has been specified by user. (non-0) */
-        for(i = 0; ((i < 6) && (dev->dev_addr[i] == 0)); i++)
+        for(i = 0; ((i < 6) && (dev->dev_addr[i] == 0)); i++);
+
+        if(i != 6) /* Node addr is not 00:00:00:00:00:00 */
         {
-                if(i != 6)
+                for(i = 0; i < 6; i++)
                 {
-                        for(i = 0; i < 6; i++)
-                        {
-                                r = inb(ioaddr + LAR0 + i);
-                                dev->dev_addr[i] = (char)r;
-                        }
-                        dev->addr_len = 6;
+                        r = inb(ioaddr + LAR0 + i);
+                        dev->dev_addr[i] = (char)r;
                 }
-                else    /* Node addr. not given by user, read it from board. */
+                dev->addr_len = 6;
+        }
+        else    /* Node addr. not given by user, read it from board. */
+        {
+                for(i = 0; i < 6; i++)
                 {
-                        for(i = 0; i < 6; i++)
-                        {
-                                r = inb(ioaddr + LAR0 + i);
-                                dev->dev_addr[i] = (char)r;
-                        }
-                        dev->addr_len = 6;
+                        r = inb(ioaddr + LAR0 + i);
+                        dev->dev_addr[i] = (char)r;
                 }
+                dev->addr_len = 6;
         }

         return (0);

Thanks,
--jochen

