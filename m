Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273366AbRIWK0c>; Sun, 23 Sep 2001 06:26:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273367AbRIWK0N>; Sun, 23 Sep 2001 06:26:13 -0400
Received: from eriador.apana.org.au ([203.14.152.116]:8975 "EHLO
	eriador.apana.org.au") by vger.kernel.org with ESMTP
	id <S273366AbRIWK0H>; Sun, 23 Sep 2001 06:26:07 -0400
Date: Sun, 23 Sep 2001 20:26:14 +1000
To: jgarzik@mandrakesoft.com
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] 8139too deadlock on shutdown
Message-ID: <20010923202614.A4110@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="NzB8fVQJ5HfG6fxh"
Content-Disposition: inline
User-Agent: Mutt/1.3.20i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--NzB8fVQJ5HfG6fxh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

This patch fixes an rtnl dead lock when bringing down an 8139too interface.
The rtnl lock is already held when rtl8139_close is called, so if the
thread is waiting for it at that point in time we have dead lock.
-- 
Debian GNU/Linux 2.2 is out! ( http://www.debian.org/ )
Email:  Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

--NzB8fVQJ5HfG6fxh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=p

Index: 8139too.c
===================================================================
RCS file: /home/gondolin/herbert/src/CVS/debian/kernel-source-2.4/drivers/net/8139too.c,v
retrieving revision 1.1.1.11
diff -u -r1.1.1.11 8139too.c
--- 8139too.c	12 Aug 2001 17:52:29 -0000	1.1.1.11
+++ 8139too.c	23 Sep 2001 10:17:02 -0000
@@ -154,6 +154,7 @@
 #include <linux/mii.h>
 #include <linux/completion.h>
 #include <asm/io.h>
+#include <asm/semaphore.h>
 #include <asm/uaccess.h>
 
 #define RTL8139_DRIVER_NAME   DRV_NAME " Fast Ethernet driver " DRV_VERSION
@@ -588,6 +589,7 @@
 	struct completion thr_exited;
 	u32 rx_config;
 	struct rtl_extra_stats xstats;
+	struct semaphore mdio_sem;
 };
 
 MODULE_AUTHOR ("Jeff Garzik <jgarzik@mandrakesoft.com>");
@@ -971,6 +973,7 @@
 	spin_lock_init (&tp->lock);
 	init_waitqueue_head (&tp->thr_wait);
 	init_completion (&tp->thr_exited);
+	init_MUTEX (&tp->mdio_sem);
 
 	/* dev is fully set up and ready to use now */
 	DPRINTK("about to register device named %s (%p)...\n", dev->name, dev);
@@ -1627,9 +1630,10 @@
 		if (signal_pending (current))
 			break;
 
-		rtnl_lock ();
+		if (down_interruptible (&tp->mdio_sem))
+			break;
 		rtl8139_thread_iter (dev, tp, tp->mmio_addr);
-		rtnl_unlock ();
+		up (&tp->mdio_sem);
 	}
 
 	complete_and_exit (&tp->thr_exited, 0);
@@ -2212,13 +2216,14 @@
 {
 	struct rtl8139_private *tp = dev->priv;
 	struct mii_ioctl_data *data = (struct mii_ioctl_data *)&rq->ifr_data;
-	int rc = 0;
+	int rc;
 	int phy = tp->phys[0] & 0x3f;
 
 	DPRINTK ("ENTER\n");
 
 	data->phy_id &= 0x1f;
 	data->reg_num &= 0x1f;
+	rc = -ERESTARTSYS;
 
 	switch (cmd) {
 	case SIOCETHTOOL:
@@ -2231,14 +2236,18 @@
 
 	case SIOCGMIIREG:	/* Read the specified MII register. */
 	case SIOCDEVPRIVATE+1:	/* binary compat, remove in 2.5 */
+		if (down_interruptible (&tp->mdio_sem)) {
+			goto err_out;
+		}
 		data->val_out = mdio_read (dev, data->phy_id, data->reg_num);
+		up (&tp->mdio_sem);
 		break;
 
 	case SIOCSMIIREG:	/* Write the specified MII register */
 	case SIOCDEVPRIVATE+2:	/* binary compat, remove in 2.5 */
 		if (!capable (CAP_NET_ADMIN)) {
 			rc = -EPERM;
-			break;
+			goto err_out;
 		}
 
 		if (data->phy_id == phy) {
@@ -2253,14 +2262,21 @@
 			case 4: /* tp->advertising = value; */ break;
 			}
 		}
+		if (down_interruptible (&tp->mdio_sem)) {
+			goto err_out;
+		}
 		mdio_write(dev, data->phy_id, data->reg_num, data->val_in);
+		up (&tp->mdio_sem);
 		break;
 
 	default:
 		rc = -EOPNOTSUPP;
-		break;
+		goto err_out;
 	}
 
+	rc = 0;
+
+err_out:
 	DPRINTK ("EXIT, returning %d\n", rc);
 	return rc;
 }

--NzB8fVQJ5HfG6fxh--
