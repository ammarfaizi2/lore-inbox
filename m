Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932084AbWJ1Svx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932084AbWJ1Svx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Oct 2006 14:51:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932082AbWJ1Svx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Oct 2006 14:51:53 -0400
Received: from nz-out-0102.google.com ([64.233.162.193]:6100 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932084AbWJ1Svw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Oct 2006 14:51:52 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mail-followup-to:mime-version:content-type:content-disposition:user-agent;
        b=R3N5OwD3iU/0SFe8CCAIPfLJjltPFNFivP8HX4DVxCh6cSRSzYCj0E2xq3uLJd6lvVrMRg5LQc9I4M5XWYb+2CAlEfq2fr+Q51ap8Zb5MFOYEGPPJEVHUx5f3qGcsrWooBdfXKxcsqn8+OWjg8IyeOoGH5cwRDa25fo25dFSQZU=
Date: Sun, 29 Oct 2006 03:52:14 +0900
From: Akinobu Mita <akinobu.mita@gmail.com>
To: linux-kernel@vger.kernel.org, linux-netdev@vger.kernel.org
Cc: Jeff Garzik <jgarzik@pobox.com>, Mike Phillips <mikep@linuxtr.net>
Subject: [PATCH] tokenring: fix module_init error handling
Message-ID: <20061028185214.GJ9973@localhost>
Mail-Followup-To: Akinobu Mita <akinobu.mita@gmail.com>,
	linux-kernel@vger.kernel.org, linux-netdev@vger.kernel.org,
	Jeff Garzik <jgarzik@pobox.com>, Mike Phillips <mikep@linuxtr.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

- Call platform_driver_unregister() before return when no cards found.
  (fixes data corruption when no cards found)

- Check platform_device_register_simple() return value

Cc: Jeff Garzik <jgarzik@pobox.com>
Cc: Mike Phillips <mikep@linuxtr.net>
Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>

 drivers/net/tokenring/proteon.c |    9 +++++++--
 drivers/net/tokenring/skisa.c   |    9 +++++++--
 2 files changed, 14 insertions(+), 4 deletions(-)

Index: work-fault-inject/drivers/net/tokenring/proteon.c
===================================================================
--- work-fault-inject.orig/drivers/net/tokenring/proteon.c
+++ work-fault-inject/drivers/net/tokenring/proteon.c
@@ -370,6 +370,10 @@ static int __init proteon_init(void)
 		dev->dma = dma[i];
 		pdev = platform_device_register_simple("proteon",
 			i, NULL, 0);
+		if (IS_ERR(pdev)) {
+			free_netdev(dev);
+			continue;
+		}
 		err = setup_card(dev, &pdev->dev);
 		if (!err) {
 			proteon_dev[i] = pdev;
@@ -385,9 +389,10 @@ static int __init proteon_init(void)
 	/* Probe for cards. */
 	if (num == 0) {
 		printk(KERN_NOTICE "proteon.c: No cards found.\n");
-		return (-ENODEV);
+		platform_driver_unregister(&proteon_driver);
+		return -ENODEV;
 	}
-	return (0);
+	return 0;
 }
 
 static void __exit proteon_cleanup(void)
Index: work-fault-inject/drivers/net/tokenring/skisa.c
===================================================================
--- work-fault-inject.orig/drivers/net/tokenring/skisa.c
+++ work-fault-inject/drivers/net/tokenring/skisa.c
@@ -380,6 +380,10 @@ static int __init sk_isa_init(void)
 		dev->dma = dma[i];
 		pdev = platform_device_register_simple("skisa",
 			i, NULL, 0);
+		if (IS_ERR(pdev)) {
+			free_netdev(dev);
+			continue;
+		}
 		err = setup_card(dev, &pdev->dev);
 		if (!err) {
 			sk_isa_dev[i] = pdev;
@@ -395,9 +399,10 @@ static int __init sk_isa_init(void)
 	/* Probe for cards. */
 	if (num == 0) {
 		printk(KERN_NOTICE "skisa.c: No cards found.\n");
-		return (-ENODEV);
+		platform_driver_unregister(&sk_isa_driver);
+		return -ENODEV;
 	}
-	return (0);
+	return 0;
 }
 
 static void __exit sk_isa_cleanup(void)
