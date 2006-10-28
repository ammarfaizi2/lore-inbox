Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932067AbWJ1SnA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932067AbWJ1SnA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Oct 2006 14:43:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932074AbWJ1SnA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Oct 2006 14:43:00 -0400
Received: from nf-out-0910.google.com ([64.233.182.184]:1075 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932067AbWJ1Sm7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Oct 2006 14:42:59 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mail-followup-to:mime-version:content-type:content-disposition:user-agent;
        b=Csm0aJFjcJdB/FRv4bhg9+5/ZB+hTdXIghFqwG8I2iBkF51EjbDK0xtqhzTk5q1pddKjVprwokHkkQh79Bvmz4DhBTqNyJt588Fsb0vP3evgV6FE596EzpPLqDRNRm/1dgkY/mjCxbnj1uyeYcjKwER5cDXloZHpTAmRiiGARNs=
Date: Sun, 29 Oct 2006 03:43:19 +0900
From: Akinobu Mita <akinobu.mita@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Wim Van Sebroeck <wim@iguana.be>
Subject: [PATCH] sc1200wdt: fix missing pnp_unregister_driver()
Message-ID: <20061028184319.GD9973@localhost>
Mail-Followup-To: Akinobu Mita <akinobu.mita@gmail.com>,
	linux-kernel@vger.kernel.org, Wim Van Sebroeck <wim@iguana.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If no devices found or invalid parameter is specified,
scl200wdt_pnp_driver is left unregistered.
It breaks global list of pnp drivers.

Cc: Wim Van Sebroeck <wim@iguana.be>
Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>

 drivers/char/watchdog/sc1200wdt.c |    9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

Index: work-fault-inject/drivers/char/watchdog/sc1200wdt.c
===================================================================
--- work-fault-inject.orig/drivers/char/watchdog/sc1200wdt.c
+++ work-fault-inject/drivers/char/watchdog/sc1200wdt.c
@@ -392,7 +392,7 @@ static int __init sc1200wdt_init(void)
 	if (io == -1) {
 		printk(KERN_ERR PFX "io parameter must be specified\n");
 		ret = -EINVAL;
-		goto out_clean;
+		goto out_pnp;
 	}
 
 #if defined CONFIG_PNP
@@ -405,7 +405,7 @@ static int __init sc1200wdt_init(void)
 	if (!request_region(io, io_len, SC1200_MODULE_NAME)) {
 		printk(KERN_ERR PFX "Unable to register IO port %#x\n", io);
 		ret = -EBUSY;
-		goto out_clean;
+		goto out_pnp;
 	}
 
 	ret = sc1200wdt_probe();
@@ -435,6 +435,11 @@ out_rbt:
 out_io:
 	release_region(io, io_len);
 
+out_pnp:
+#if defined CONFIG_PNP
+	if (isapnp)
+		pnp_unregister_driver(&scl200wdt_pnp_driver);
+#endif
 	goto out_clean;
 }
 
