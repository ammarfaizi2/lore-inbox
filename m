Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264025AbTFGXbm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jun 2003 19:31:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264029AbTFGXbm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jun 2003 19:31:42 -0400
Received: from wohnheim.fh-wedel.de ([195.37.86.122]:33920 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S264025AbTFGXbj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jun 2003 19:31:39 -0400
Date: Sun, 8 Jun 2003 01:45:10 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: ncorbic@sangoma.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] wanrouter: fix stack usage
Message-ID: <20030607234510.GB8511@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Another stack patch that grew old until it didn't apply anymore.  Any
reasons why it has been ignore so far?

Jörn

-- 
Mundie uses a textbook tactic of manipulation: start with some
reasonable talk, and lead the audience to an unreasonable conclusion.
-- Bruce Perens

--- linux-2.5.70-bk12/net/wanrouter/wanmain.c~stackfix_wanrouter	2003-06-05 17:47:43.000000000 +0200
+++ linux-2.5.70-bk12/net/wanrouter/wanmain.c	2003-06-08 01:33:18.000000000 +0200
@@ -668,7 +668,7 @@
 static int wanrouter_device_new_if(struct wan_device *wandev,
 				   wanif_conf_t *u_conf)
 {
-	wanif_conf_t conf;
+	wanif_conf_t *cnf;
 	struct net_device *dev = NULL;
 #ifdef CONFIG_WANPIPE_MULTPPP
 	struct ppp_device *pppdev=NULL;
@@ -678,38 +678,47 @@
 	if ((wandev->state == WAN_UNCONFIGURED) || (wandev->new_if == NULL))
 		return -ENODEV;
 
-	if (copy_from_user(&conf, u_conf, sizeof(wanif_conf_t)))
-		return -EFAULT;
+	cnf = kmalloc(sizeof(wanif_conf_t), GFP_KERNEL);
+	if (!cnf)
+		return -ENOBUFS;
 
-	if (conf.magic != ROUTER_MAGIC)
-		return -EINVAL;
+	err = -EFAULT;
+	if (copy_from_user(cnf, u_conf, sizeof(wanif_conf_t)))
+		goto out;
 
-	if (conf.config_id == WANCONFIG_MPPP) {
+	err = -EINVAL;
+	if (cnf->magic != ROUTER_MAGIC)
+		goto out;
+
+	if (cnf->config_id == WANCONFIG_MPPP) {
 #ifdef CONFIG_WANPIPE_MULTPPP
 		pppdev = kmalloc(sizeof(struct ppp_device), GFP_KERNEL);
+		err = -ENOBUFS;
 		if (pppdev == NULL)
-			return -ENOBUFS;
+			goto out;
 		memset(pppdev, 0, sizeof(struct ppp_device));
 		pppdev->dev = kmalloc(sizeof(struct net_device), GFP_KERNEL);
 		if (pppdev->dev == NULL) {
 			kfree(pppdev);
-			return -ENOBUFS;
+			err -ENOBUFS;
+			goto out;
 		}
 		memset(pppdev->dev, 0, sizeof(struct net_device));
-		err = wandev->new_if(wandev,
-				     (struct net_device *)pppdev, &conf);
+		err = wandev->new_if(wandev, (struct net_device *)pppdev, cnf);
 		dev = pppdev->dev;
 #else
 		printk(KERN_INFO "%s: Wanpipe Mulit-Port PPP support has not been compiled in!\n",
 				wandev->name);
-		return -EPROTONOSUPPORT;
+		err = -EPROTONOSUPPORT;
+		goto out;
 #endif
 	} else {
 		dev = kmalloc(sizeof(struct net_device), GFP_KERNEL);
+		err = -ENOBUFS;
 		if (dev == NULL)
-			return -ENOBUFS;
+			goto out;
 		memset(dev, 0, sizeof(struct net_device));
-		err = wandev->new_if(wandev, dev, &conf);
+		err = wandev->new_if(wandev, dev, cnf);
 	}
 
 	if (!err) {
@@ -748,7 +757,8 @@
 				++wandev->ndev;
 
 				unlock_adapter_irq(&wandev->lock, &smp_flags);
-				return 0;	/* done !!! */
+				err = 0;	/* done !!! */
+				goto out;
 			}
 		}
 		if (wandev->del_if)
@@ -761,18 +771,19 @@
 		dev->priv = NULL;
 	}
 
-
 #ifdef CONFIG_WANPIPE_MULTPPP
-	if (conf.config_id == WANCONFIG_MPPP)
+	if (cnf->config_id == WANCONFIG_MPPP)
 		kfree(pppdev);
 	else
 		kfree(dev);
 #else
 	/* Sync PPP is disabled */
-	if (conf.config_id != WANCONFIG_MPPP)
+	if (cnf->config_id != WANCONFIG_MPPP)
 		kfree(dev);
 #endif
 
+out:
+	kfree(cnf);
 	return err;
 }
 
