Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262425AbSKYFeU>; Mon, 25 Nov 2002 00:34:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262430AbSKYFeU>; Mon, 25 Nov 2002 00:34:20 -0500
Received: from postoffice.millenniumit.com ([203.115.28.196]:34232 "EHLO
	postoffice.millenniumit.com") by vger.kernel.org with ESMTP
	id <S262425AbSKYFeT>; Mon, 25 Nov 2002 00:34:19 -0500
Message-ID: <3DE1B86C.30505@millenniumit.com>
Date: Mon, 25 Nov 2002 11:43:08 +0600
From: "Dhammika Pathirana" <dhammikap@millenniumit.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020408
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] acorn_request_region fix 2.5.48
Content-type: multipart/mixed; boundary="=_IS_MIME_Boundary"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=_IS_MIME_Boundary
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

Following patch is to fix acorn request region failure. Pls apply.

dhammika

-----------------

diff -urN ./linux-2.5.48/drivers/acorn/net/ether1.c 
./linux/drivers/acorn/net/ether1.c
--- ./linux-2.5.48/drivers/acorn/net/ether1.c   Mon Nov 18 10:29:47 2002
+++ ./linux/drivers/acorn/net/ether1.c  Mon Nov 25 11:19:52 2002
@@ -1035,13 +1035,20 @@
         /*
          * these will not fail - the nature of the bus ensures this
          */
-       request_region(dev->base_addr, 16, dev->name);
-       request_region(dev->base_addr + 0x800, 4096, dev->name);
+       if(!request_region(dev->base_addr, 16, dev->name)){
+               ret = -EBUSY;
+               goto release1;
+       }
+
+       if(!request_region(dev->base_addr + 0x800, 4096, dev->name)){
+               ret = -EBUSY;
+               goto release2;
+       }

         priv = (struct ether1_priv *)dev->priv;
         if ((priv->bus_type = ether1_reset(dev)) == 0) {
                 ret = -ENODEV;
-               goto release;
+               goto release3;
         }

         printk(KERN_INFO "%s: ether1 in slot %d, ",
@@ -1054,7 +1061,7 @@

         if (ether1_init_2(dev)) {
                 ret = -ENODEV;
-               goto release;
+               goto release3;
         }

         dev->open               = ether1_open;
@@ -1069,9 +1076,11 @@
         ecard_set_drvdata(ec, dev);
         return 0;

-release:
+release3:
         release_region(dev->base_addr, 16);
+release2:
         release_region(dev->base_addr + 0x800, 4096);
+release1:
         unregister_netdev(dev);

-----------------

--=_IS_MIME_Boundary
Content-Type: text/plain;charset=us-ascii;
	name="Disclaimer_Message.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="Disclaimer_Message.txt"

----------------------------------------- (on postoffice)

The information contained in this email is confidential and is meant to be read only by the person to whom it is addressed.Please visit http://www.millenniumit.com/legal/email.htm to read the entire confidentiality clause.

---------------------------------------------------------

--=_IS_MIME_Boundary--
