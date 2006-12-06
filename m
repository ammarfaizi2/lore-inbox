Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757088AbWLFCRg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757088AbWLFCRg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Dec 2006 21:17:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759678AbWLFCRg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Dec 2006 21:17:36 -0500
Received: from nf-out-0910.google.com ([64.233.182.185]:17143 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757088AbWLFCRf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Dec 2006 21:17:35 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:reply-to:x-priority:message-id:to:cc:subject:mime-version:content-type:content-transfer-encoding;
        b=IbFGNWP2LkvduBP2cyiYaPr2i47dKWM7WbP6XxpUJ6NSGJfxRhwMvS3tgn6WWzZS11UBZSh8nybba0DkBxMQxuwNo+AKVJZY4gsl/tRIWGzSnwxJv2L2nBe/vscTCIb1+foPziM6JxEr2BiRP347bb0qyOennP0FjworIjz/+g4=
Date: Wed, 6 Dec 2006 04:17:35 +0200
From: Paul Sokolovsky <pmiscml@gmail.com>
Reply-To: Paul Sokolovsky <pmiscml@gmail.com>
X-Priority: 3 (Normal)
Message-ID: <993999206.20061206041735@gmail.com>
To: linux-kernel@vger.kernel.org
CC: kernel-discuss@handhelds.org, "Matt Reimer" <mattjreimer@gmail.com>
Subject: [PATCH] Convert pxaficp_ir.c to platform_driver
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello linux-kernel,

  drivers/ner/irda/pxaficp_ir.c was not converted to platform_driver,
which in 2.6.19 ( after commit
http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=386415d88b1ae50304f9c61aa3e0db082fa90428;hp=bb84c89f94851161f387285d0a449b4a3f29f4df
) leads to random memory corruption, resume problems, etc. We
specifically face issues with HP iPaq hx4700 device, which has
nondeterministic resume problems depending on the changes to kernel
config options (not directly related to pxaficp_ir). More info on the
issue: http://lkml.org/lkml/2006/10/25/73 .

Signed-off-by: Paul Sokolovsky <pmiscml@gmail.com>


Index: drivers/net/irda/pxaficp_ir.c
===================================================================
RCS file: /cvs/linux/kernel26/drivers/net/irda/pxaficp_ir.c,v
retrieving revision 1.3
diff -u -r1.3 pxaficp_ir.c
--- drivers/net/irda/pxaficp_ir.c       2 Dec 2006 02:18:04 -0000       1.3
+++ drivers/net/irda/pxaficp_ir.c       6 Dec 2006 02:00:32 -0000
@@ -704,9 +704,9 @@
        return 0;
 }
 
-static int pxa_irda_suspend(struct device *_dev, pm_message_t state)
+static int pxa_irda_suspend(struct platform_device *_dev, pm_message_t state)
 {
-       struct net_device *dev = dev_get_drvdata(_dev);
+       struct net_device *dev = platform_get_drvdata(_dev);
        struct pxa_irda *si;
 
        if (dev && netif_running(dev)) {
@@ -718,9 +718,9 @@
        return 0;
 }
 
-static int pxa_irda_resume(struct device *_dev)
+static int pxa_irda_resume(struct platform_device *_dev)
 {
-       struct net_device *dev = dev_get_drvdata(_dev);
+       struct net_device *dev = platform_get_drvdata(_dev);
        struct pxa_irda *si;
 
        if (dev && netif_running(dev)) {
@@ -746,9 +746,8 @@
        return io->head ? 0 : -ENOMEM;
 }
 
-static int pxa_irda_probe(struct device *_dev)
+static int pxa_irda_probe(struct platform_device *pdev)
 {
-       struct platform_device *pdev = to_platform_device(_dev);
        struct net_device *dev;
        struct pxa_irda *si;
        unsigned int baudrate_mask;
@@ -822,9 +821,9 @@
        return err;
 }
 
-static int pxa_irda_remove(struct device *_dev)
+static int pxa_irda_remove(struct platform_device *_dev)
 {
-       struct net_device *dev = dev_get_drvdata(_dev);
+       struct net_device *dev = platform_get_drvdata(_dev);
 
        if (dev) {
                struct pxa_irda *si = netdev_priv(dev);
@@ -840,9 +839,10 @@
        return 0;
 }
 
-static struct device_driver pxa_ir_driver = {
-       .name           = "pxa2xx-ir",
-       .bus            = &platform_bus_type,
+static struct platform_driver pxa_ir_driver = {
+       .driver         = {
+               .name   = "pxa2xx-ir",
+       },
        .probe          = pxa_irda_probe,
        .remove         = pxa_irda_remove,
        .suspend        = pxa_irda_suspend,
@@ -851,12 +851,12 @@
 
 static int __init pxa_irda_init(void)
 {
-       return driver_register(&pxa_ir_driver);
+       return platform_driver_register(&pxa_ir_driver);
 }
 
 static void __exit pxa_irda_exit(void)
 {
-       driver_unregister(&pxa_ir_driver);
+       platform_driver_unregister(&pxa_ir_driver);
 }
 
 module_init(pxa_irda_init);




-- 
Best regards,
 Paul                          mailto:pmiscml@gmail.com

