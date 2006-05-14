Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751169AbWENNL5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751169AbWENNL5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 May 2006 09:11:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751186AbWENNL4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 May 2006 09:11:56 -0400
Received: from nf-out-0910.google.com ([64.233.182.185]:60491 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751133AbWENNLz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 May 2006 09:11:55 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=ma16WGUFKFH3IEH/Bi3APq1GgnXybQFZ+95AemNI/YsgfBGhdzB6FsoGLryBpMMr9AOtCedixxLi3F5fIsKFFw4Ag515I8F2enm679PGFJG/bZOkmxgZD1U3nAOpH0cu+yCY+HSzGryf0ImFM4h0j1vbrFfexQMsOC95hEK/0CE=
From: Jesper Juhl <jesper.juhl@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] fix potential NULL pointer dereference in yam
Date: Sun, 14 May 2006 15:12:50 +0200
User-Agent: KMail/1.9.1
Cc: Frederic Rible <frible@teaser.fr>, Jean-Paul Roubelat <jpr@f6fbb.org>,
       linux-hams@vger.kernel.org, Jesper Juhl <jesper.juhl@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605141512.50923.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Testing a pointer for NULL after it has already been dereferenced is not
very safe.
Patch below to rework yam_open() so that `dev' is not dereferenced until
after it has been tested for NULL.

Found by coverity checker as #787

(please Cc me on replies)


Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
---

 drivers/net/hamradio/yam.c |   18 ++++++++++++++----
 1 files changed, 14 insertions(+), 4 deletions(-)


--- linux-2.6.17-rc4-git2-orig/drivers/net/hamradio/yam.c	2006-05-13 21:28:27.000000000 +0200
+++ linux-2.6.17-rc4-git2/drivers/net/hamradio/yam.c	2006-05-14 15:07:00.000000000 +0200
@@ -845,15 +845,25 @@ static struct net_device_stats *yam_get_
 
 static int yam_open(struct net_device *dev)
 {
-	struct yam_port *yp = netdev_priv(dev);
+	struct yam_port *yp;
 	enum uart u;
 	int i;
-	int ret=0;
+	int ret = 0;
 
-	printk(KERN_INFO "Trying %s at iobase 0x%lx irq %u\n", dev->name, dev->base_addr, dev->irq);
+	if (!dev) {
+		printk(KERN_ERR "yam_open() called without device\n");
+		return -ENXIO;
+	}
 
-	if (!dev || !yp->bitrate)
+	yp = netdev_priv(dev);
+	if (!yp->bitrate) {
+		printk(KERN_ERR "%s: no bitrate\n", dev->name);
 		return -ENXIO;
+	}
+
+	printk(KERN_INFO "Trying %s at iobase 0x%lx irq %u\n",
+		dev->name, dev->base_addr, dev->irq);
+
 	if (!dev->base_addr || dev->base_addr > 0x1000 - YAM_EXTENT ||
 		dev->irq < 2 || dev->irq > 15) {
 		return -ENXIO;


