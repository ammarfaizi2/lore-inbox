Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262244AbTHYV06 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Aug 2003 17:26:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262245AbTHYV05
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Aug 2003 17:26:57 -0400
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:49933 "HELO
	127.0.0.1") by vger.kernel.org with SMTP id S262244AbTHYV0x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Aug 2003 17:26:53 -0400
Content-Type: text/plain; charset=US-ASCII
From: insecure <insecure@mail.od.ua>
Reply-To: insecure@mail.od.ua
To: Jeff Garzik <jgarzik@pobox.com>, Linus Torvalds <torvalds@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] raceless request_region() fix (was Re: Linux 2.6.0-test4)
Date: Tue, 26 Aug 2003 00:26:47 +0300
X-Mailer: KMail [version 1.4]
References: <Pine.LNX.4.44.0308221732170.4677-100000@home.osdl.org> <200308260020.21817.insecure@mail.od.ua>
In-Reply-To: <200308260020.21817.insecure@mail.od.ua>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200308260026.47994.insecure@mail.od.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 26 August 2003 00:20, insecure wrote:
> >   o [arcnet com90io] replace check_region with temporary
> >     request_region, in probe phase.
>
> check_region() is deprecated because it is racy.
> Replacing it with request_region in probe:
>
> int probe() {
> 	if(!request_region(...))
> 		return 0;
> 	/* probe */
> 	release_region(...);
> }
>
> int init() {
> 	request_region(...);
> }
>
> only removes 'deprecated' warning. Race remains.

Corrected com90io.c patch is below.
-- 
vda

--- linux-2.6.0-test4/drivers/net/arcnet/com90io.c.orig	Sat Aug 23 02:53:52 2003
+++ linux-2.6.0-test4/drivers/net/arcnet/com90io.c	Tue Aug 26 00:22:51 2003
@@ -158,7 +158,7 @@
 		       "must specify the base address!\n");
 		return -ENODEV;
 	}
-	if (!request_region(ioaddr, ARCNET_TOTAL_SIZE, "com90io probe")) {
+	if (!request_region(ioaddr, ARCNET_TOTAL_SIZE, "arcnet (COM90xx-IO)")) {
 		BUGMSG(D_INIT_REASONS, "IO check_region %x-%x failed.\n",
 		       ioaddr, ioaddr + ARCNET_TOTAL_SIZE - 1);
 		return -ENXIO;
@@ -218,7 +218,6 @@
 			goto err_out;
 		}
 	}
-	release_region(ioaddr, ARCNET_TOTAL_SIZE); /* end of probing */
 	return com90io_found(dev);
 
 err_out:
@@ -237,13 +236,9 @@

 	/* Reserve the irq */
 	if (request_irq(dev->irq, &arcnet_interrupt, 0, "arcnet (COM90xx-IO)", dev)) {
+		release_region(dev->base_addr, ARCNET_TOTAL_SIZE);
 		BUGMSG(D_NORMAL, "Can't get IRQ %d!\n", dev->irq);
 		return -ENODEV;
-	}
-	/* Reserve the I/O region - guaranteed to work by check_region */
-	if (!request_region(dev->base_addr, ARCNET_TOTAL_SIZE, "arcnet (COM90xx-IO)")) {
-		free_irq(dev->irq, dev);
-		return -EBUSY;
 	}

 	/* Initialize the rest of the device structure. */

