Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265571AbUEULzu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265571AbUEULzu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 May 2004 07:55:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265611AbUEULzu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 May 2004 07:55:50 -0400
Received: from arnor.apana.org.au ([203.14.152.115]:522 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S265571AbUEULzj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 May 2004 07:55:39 -0400
Date: Fri, 21 May 2004 21:55:29 +1000
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PCMCIA] Check return status of register calls in i82365
Message-ID: <20040521115529.GA1408@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="9jxsPFA5p3P2qPhR"
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--9jxsPFA5p3P2qPhR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi:

i82365 calls driver_register and platform_device_register without
checking their return values.  This patch fixes that.

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email:  Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

--9jxsPFA5p3P2qPhR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=p

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1808  -> 1.1809 
#	drivers/pcmcia/i82365.c	1.51    -> 1.52   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 04/05/21	herbert@gondor.apana.org.au	1.1809
# [PCMCIA] Check return status of register calls in i82365.
# --------------------------------------------
#
diff -Nru a/drivers/pcmcia/i82365.c b/drivers/pcmcia/i82365.c
--- a/drivers/pcmcia/i82365.c	Fri May 21 21:53:42 2004
+++ b/drivers/pcmcia/i82365.c	Fri May 21 21:53:42 2004
@@ -1372,8 +1372,15 @@
 {
     int i, ret;
 
-    if (driver_register(&i82365_driver))
-	return -1;
+    ret = driver_register(&i82365_driver);
+    if (ret)
+	return ret;
+
+    ret = platform_device_register(&i82365_device);
+    if (ret) {
+	driver_unregister(&i82365_driver);
+	return ret;
+    }
 
     printk(KERN_INFO "Intel ISA PCIC probe: ");
     sockets = 0;
@@ -1382,11 +1389,10 @@
 
     if (sockets == 0) {
 	printk("not found.\n");
+	platform_device_unregister(&i82365_device);
 	driver_unregister(&i82365_driver);
 	return -ENODEV;
     }
-
-    platform_device_register(&i82365_device);
 
     /* Set up interrupt handler(s) */
     if (grab_irq != 0)

--9jxsPFA5p3P2qPhR--
