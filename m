Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267581AbTA3SUU>; Thu, 30 Jan 2003 13:20:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267595AbTA3SUU>; Thu, 30 Jan 2003 13:20:20 -0500
Received: from apollo.nbase.co.il ([194.90.137.2]:63497 "EHLO
	apollo.nbase.co.il") by vger.kernel.org with ESMTP
	id <S267581AbTA3SUR>; Thu, 30 Jan 2003 13:20:17 -0500
Date: Thu, 30 Jan 2003 20:29:36 +0200
From: Michael Rozhavsky <mrozhavsky@mrv.com>
To: vlan@scry.wanfear.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] 8021q memory leak
Message-ID: <20030130182936.GC3348@mike.nbase.co.il>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="FL5UXtIhxfXey3p5"
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--FL5UXtIhxfXey3p5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

There is a memory leak in vlan module of 2.4.20

When last vlan of the group is removed the group is unhashed but not
deleted.

Attached patch fixes this memory leak and completes implementation of
memory debug output.

--
  Michael Rozhavsky
  Senior Software Engineer
  MRV International
  Tel: +972 (4) 993-6248
  Fax: +972 (4) 989-0564
  http://www.mrv.com

--FL5UXtIhxfXey3p5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="vlan.diff"

diff -u linux-2.4.20/net/8021q/vlan.c linux-2.4.20-test/net/8021q/vlan.c
--- linux-2.4.20/net/8021q/vlan.c	2002-11-29 01:53:15.000000000 +0200
+++ linux-2.4.20-test/net/8021q/vlan.c	2003-01-30 20:19:12.000000000 +0200
@@ -171,6 +171,8 @@
 		next = *pprev;
 	}
 	*pprev = grp->next;
+	kfree (grp);
+	VLAN_MEM_DBG("vlan_group kfree, addr: %p  size: %i\n", grp, sizeof(struct vlan_group));
 }
 
 /*  Find the protocol handler.  Assumes VID < VLAN_VID_MASK.
@@ -509,6 +545,7 @@
 	 */
 	if (!grp) { /* need to add a new group */
 		grp = kmalloc(sizeof(struct vlan_group), GFP_KERNEL);
+		VLAN_MEM_DBG("vlan_group malloc, addr: %p  size: %i\n", grp, sizeof(struct vlan_group));
 		if (!grp)
 			goto out_free_newdev_priv;
 					
@@ -546,9 +583,13 @@
 
 out_free_newdev_priv:
 	kfree(new_dev->priv);
+	VLAN_MEM_DBG("new_dev->priv kfree, addr: %p  size: %i\n",
+		     new_dev->priv, sizeof(struct vlan_dev_info));
 
 out_free_newdev:
 	kfree(new_dev);
+	VLAN_MEM_DBG("net_device kfree, addr: %p  size: %i\n",
+		     new_dev, sizeof (struct net_device));
 
 out_unlock:
 	rtnl_unlock();
diff -u linux-2.4.20/net/8021q/vlan_dev.c linux-2.4.20-test/net/8021q/vlan_dev.c
--- linux-2.4.20/net/8021q/vlan_dev.c	2002-11-29 01:53:15.000000000 +0200
+++ linux-2.4.20-test/net/8021q/vlan_dev.c	2003-01-30 20:06:26.000000000 +0200
@@ -171,7 +171,7 @@
 
 #ifdef VLAN_DEBUG
 		printk(VLAN_DBG "%s: dropping skb: %p because came in on wrong device, dev: %s  real_dev: %s, skb_dev: %s\n",
-			__FUNCTION__ skb, dev->name, 
+			__FUNCTION__, skb, dev->name, 
 			VLAN_DEV_INFO(skb->dev)->real_dev->name, 
 			skb->dev->name);
 #endif
@@ -783,8 +783,13 @@
 				BUG();
 
 			kfree(dev->priv);
+			VLAN_MEM_DBG("dev->priv kfree, addr: %p  size: %i\n",
+				     dev->priv, sizeof(struct vlan_dev_info));
 			dev->priv = NULL;
 		}
+		/* will be deleted by kernel */
+		VLAN_MEM_DBG("net_device kfree, addr: %p  size: %i\n",
+			     dev, sizeof (struct net_device));
 	}
 }
 

--FL5UXtIhxfXey3p5--
