Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264415AbTKUSvG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Nov 2003 13:51:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264416AbTKUSvG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Nov 2003 13:51:06 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:59805 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264415AbTKUSvA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Nov 2003 13:51:00 -0500
Message-ID: <3FBE5E70.9060102@pobox.com>
Date: Fri, 21 Nov 2003 13:50:24 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: russell@coker.com.au
CC: Linux Kernel <linux-kernel@vger.kernel.org>, rask@sygehus.dk,
       akpm@osdl.org, netdev@oss.sgi.com
Subject: [PATCH/CFT] de2104x fixes
References: <200311212051.32352.russell@coker.com.au>
In-Reply-To: <200311212051.32352.russell@coker.com.au>
Content-Type: multipart/mixed;
 boundary="------------060507000103040403010101"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060507000103040403010101
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

So, can people give this a test?  It includes a change that, I hope, 
addresses Russell's problem, as well as a patch from Rask.

	Jeff


P.S.  It would be great if people cc'd me on such bug reports ;-) 
Quicker to find and respond, these days.


--------------060507000103040403010101
Content-Type: text/plain;
 name="patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch"

===== drivers/net/tulip/de2104x.c 1.25 vs edited =====
--- 1.25/drivers/net/tulip/de2104x.c	Thu Sep 11 18:46:11 2003
+++ edited/drivers/net/tulip/de2104x.c	Fri Nov 21 13:48:17 2003
@@ -28,8 +28,8 @@
  */
 
 #define DRV_NAME		"de2104x"
-#define DRV_VERSION		"0.6"
-#define DRV_RELDATE		"Sep 1, 2003"
+#define DRV_VERSION		"0.9"
+#define DRV_RELDATE		"Nov 21, 2003"
 
 #include <linux/config.h>
 #include <linux/module.h>
@@ -1380,18 +1380,18 @@
 		return rc;
 	}
 
-	rc = de_init_hw(de);
+	rc = request_irq(dev->irq, de_interrupt, SA_SHIRQ, dev->name, dev);
 	if (rc) {
-		printk(KERN_ERR "%s: h/w init failure, err=%d\n",
-		       dev->name, rc);
+		printk(KERN_ERR "%s: IRQ %d request failure, err=%d\n",
+		       dev->name, dev->irq, rc);
 		goto err_out_free;
 	}
 
-	rc = request_irq(dev->irq, de_interrupt, SA_SHIRQ, dev->name, dev);
+	rc = de_init_hw(de);
 	if (rc) {
-		printk(KERN_ERR "%s: IRQ %d request failure, err=%d\n",
-		       dev->name, dev->irq, rc);
-		goto err_out_hw;
+		printk(KERN_ERR "%s: h/w init failure, err=%d\n",
+		       dev->name, rc);
+		goto err_out_free_irq;
 	}
 
 	netif_start_queue(dev);
@@ -1399,10 +1399,8 @@
 
 	return 0;
 
-err_out_hw:
-	spin_lock_irqsave(&de->lock, flags);
-	de_stop_hw(de);
-	spin_unlock_irqrestore(&de->lock, flags);
+err_out_free_irq:
+	free_irq (dev->irq, dev);
 
 err_out_free:
 	de_free_rings(de);
@@ -1571,13 +1569,17 @@
 	    (ecmd->advertising == de->media_advertise))
 		return 0; /* nothing to change */
 	    
-	de_link_down(de);
-	de_stop_rxtx(de);
+	if (netif_running(dev)) {
+		de_link_down(de);
+		de_stop_rxtx(de);
+	}
 	
 	de->media_type = new_media;
 	de->media_lock = media_lock;
 	de->media_advertise = ecmd->advertising;
-	de_set_media(de);
+
+	if (netif_running(dev))
+		de_set_media(de);
 	
 	return 0;
 }

--------------060507000103040403010101--

