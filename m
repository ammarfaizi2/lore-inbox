Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261909AbTCLTGC>; Wed, 12 Mar 2003 14:06:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261910AbTCLTGC>; Wed, 12 Mar 2003 14:06:02 -0500
Received: from home.linuxhacker.ru ([194.67.236.68]:11937 "EHLO linuxhacker.ru")
	by vger.kernel.org with ESMTP id <S261909AbTCLTGA>;
	Wed, 12 Mar 2003 14:06:00 -0500
Date: Wed, 12 Mar 2003 22:15:54 +0300
From: Oleg Drokin <green@linuxhacker.ru>
To: alan@redhat.com, linux-kernel@vger.kernel.org, elmer@ylenurme.ee
Subject: [2.4] Memleak on error exit path in Aironet 4500 Pcmcia driver
Message-ID: <20030312191554.GA27710@linuxhacker.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

    There is a memleak on OOM in Aironet 4500 Pcmcia driver,
    trivial to fix. See the patch.
    Found with help of smatch + enhanced unfree script.

Bye,
    Oleg

===== drivers/net/pcmcia/aironet4500_cs.c 1.8 vs edited =====
--- 1.8/drivers/net/pcmcia/aironet4500_cs.c	Wed Aug  7 22:27:37 2002
+++ edited/drivers/net/pcmcia/aironet4500_cs.c	Wed Mar 12 22:13:20 2003
@@ -282,7 +282,13 @@
 	};
 	memset(dev,0,sizeof(struct net_device));
 	dev->priv = kmalloc(sizeof(struct awc_private), GFP_KERNEL);
-	if (!dev->priv ) {printk(KERN_CRIT "out of mem on dev priv alloc \n"); return NULL;};
+	if (!dev->priv ) {
+		printk(KERN_CRIT "out of mem on dev priv alloc \n");
+                kfree(dev);
+                kfree(link->dev);
+                kfree(link);
+		return NULL;
+	}
 	memset(dev->priv,0,sizeof(struct awc_private));
 	
 //	link->dev->minor = dev->minor;
