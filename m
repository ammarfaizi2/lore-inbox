Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264264AbTL2WJe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Dec 2003 17:09:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264286AbTL2WJe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Dec 2003 17:09:34 -0500
Received: from fep03-mail.bloor.is.net.cable.rogers.com ([66.185.86.73]:4809
	"EHLO fep03-mail.bloor.is.net.cable.rogers.com") by vger.kernel.org
	with ESMTP id S264264AbTL2WJb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Dec 2003 17:09:31 -0500
Date: Mon, 29 Dec 2003 17:09:16 -0500
From: Omkhar Arasaratnam <omkhar@rogers.com>
To: emoenke@gwdg.de
Cc: linux-kernel@vger.kernel.org, trivial@rustcorp.com.au
Subject: [PATCH] drivers/cdrom/isp16.c check_region() fix - take 2
Message-ID: <20031229220916.GA17210@omkhar.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
X-Authentication-Info: Submitted using SMTP AUTH LOGIN at fep03-mail.bloor.is.net.cable.rogers.com from [24.192.237.88] using ID <omkhar@rogers.com> at Mon, 29 Dec 2003 17:08:45 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok,

Thanks to all for pointing out my "kernel newbie" mistakes. Here is a new patch, let me know what you think.

Feel free to flame me if I _still_ don't get it :)


--- linux-clean/drivers/cdrom/isp16.c.org	2003-12-29 16:47:34.000000000 -0500
+++ linux-clean/drivers/cdrom/isp16.c	2003-12-29 16:47:26.000000000 -0500
@@ -121,14 +121,14 @@
 		return (0);
 	}
 
-	if (check_region(ISP16_IO_BASE, ISP16_IO_SIZE)) {
+	if (!request_region(ISP16_IO_BASE, ISP16_IO_SIZE,"isp16")) {
 		printk("ISP16: i/o ports already in use.\n");
 		return (-EIO);
 	}
 
 	if ((isp16_type = isp16_detect()) < 0) {
 		printk("ISP16: no cdrom interface found.\n");
-		return (-EIO);
+		goto out;
 	}
 
 	printk(KERN_INFO
@@ -148,20 +148,23 @@
 	else {
 		printk("ISP16: %s not supported by cdrom interface.\n",
 		       isp16_cdrom_type);
-		return (-EIO);
+		goto out;
 	}
 
 	if (isp16_cdi_config(isp16_cdrom_base, expected_drive,
 			     isp16_cdrom_irq, isp16_cdrom_dma) < 0) {
 		printk
 		    ("ISP16: cdrom interface has not been properly configured.\n");
-		return (-EIO);
+		goto out;
 	}
 	printk(KERN_INFO
 	       "ISP16: cdrom interface set up with io base 0x%03X, irq %d, dma %d,"
 	       " type %s.\n", isp16_cdrom_base, isp16_cdrom_irq,
 	       isp16_cdrom_dma, isp16_cdrom_type);
 	return (0);
+:out
+	release_region(ISP16_IO_BASE, ISP16_IO_SIZE);
+	return (-EIO);
 }
 
 static short __init isp16_detect(void)


 O
