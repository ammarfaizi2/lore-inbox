Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261868AbTKVMIg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Nov 2003 07:08:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262196AbTKVMIg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Nov 2003 07:08:36 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:34232 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261868AbTKVMIc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Nov 2003 07:08:32 -0500
Message-ID: <3FBF519D.4070307@pobox.com>
Date: Sat, 22 Nov 2003 07:07:57 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: russell@coker.com.au
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH/CFT] de2104x fixes
References: <200311212051.32352.russell@coker.com.au> <3FBE5E70.9060102@pobox.com> <200311221305.25718.russell@coker.com.au>
In-Reply-To: <200311221305.25718.russell@coker.com.au>
Content-Type: multipart/mixed;
 boundary="------------090205020205060001010200"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090205020205060001010200
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Russell Coker wrote:
> On Sat, 22 Nov 2003 05:50, Jeff Garzik <jgarzik@pobox.com> wrote:
> 
>>So, can people give this a test?  It includes a change that, I hope,
>>addresses Russell's problem, as well as a patch from Rask.
> 
> 
> It does not compile for me, below are the warnings and errors.  I am using 
> 2.6.0-test9 with no patches applied other than your patch.
> 
> drivers/net/tulip/de2104x.c: In function `de_open':
> drivers/net/tulip/de2104x.c:1369: warning: unused variable `flags'
> drivers/net/tulip/de2104x.c: In function `__de_set_settings':
> drivers/net/tulip/de2104x.c:1572: error: `dev' undeclared (first use in this 
> function)
> drivers/net/tulip/de2104x.c:1572: error: (Each undeclared identifier is 
> reported only once
> drivers/net/tulip/de2104x.c:1572: error: for each function it appears in.)

Ok, here's a better patch.  It's against 2.6.0-test9-BK-latest 
(currently bk25).

--------------090205020205060001010200
Content-Type: text/plain;
 name="patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch"

===== drivers/net/tulip/de2104x.c 1.25 vs edited =====
--- 1.25/drivers/net/tulip/de2104x.c	Thu Sep 11 18:46:11 2003
+++ edited/drivers/net/tulip/de2104x.c	Sat Nov 22 07:05:40 2003
@@ -28,8 +28,8 @@
  */
 
 #define DRV_NAME		"de2104x"
-#define DRV_VERSION		"0.6"
-#define DRV_RELDATE		"Sep 1, 2003"
+#define DRV_VERSION		"0.9"
+#define DRV_RELDATE		"Nov 21, 2003"
 
 #include <linux/config.h>
 #include <linux/module.h>
@@ -1366,7 +1366,6 @@
 {
 	struct de_private *de = dev->priv;
 	int rc;
-	unsigned long flags;
 
 	if (netif_msg_ifup(de))
 		printk(KERN_DEBUG "%s: enabling interface\n", dev->name);
@@ -1380,18 +1379,18 @@
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
@@ -1399,10 +1398,8 @@
 
 	return 0;
 
-err_out_hw:
-	spin_lock_irqsave(&de->lock, flags);
-	de_stop_hw(de);
-	spin_unlock_irqrestore(&de->lock, flags);
+err_out_free_irq:
+	free_irq (dev->irq, dev);
 
 err_out_free:
 	de_free_rings(de);
@@ -1514,7 +1511,8 @@
 	return 0;
 }
 
-static int __de_set_settings(struct de_private *de, struct ethtool_cmd *ecmd)
+static int __de_set_settings(struct net_device *dev, struct de_private *de,
+			     struct ethtool_cmd *ecmd)
 {
 	u32 new_media;
 	unsigned int media_lock;
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
@@ -1615,7 +1617,7 @@
 	int rc;
 
 	spin_lock_irq(&de->lock);
-	rc = __de_set_settings(de, ecmd);
+	rc = __de_set_settings(dev, de, ecmd);
 	spin_unlock_irq(&de->lock);
 
 	return rc;

--------------090205020205060001010200--

