Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268836AbTCCWpo>; Mon, 3 Mar 2003 17:45:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268838AbTCCWpo>; Mon, 3 Mar 2003 17:45:44 -0500
Received: from locutus.cmf.nrl.navy.mil ([134.207.10.66]:5267 "EHLO
	locutus.cmf.nrl.navy.mil") by vger.kernel.org with ESMTP
	id <S268836AbTCCWpm>; Mon, 3 Mar 2003 17:45:42 -0500
Message-Id: <200303032255.h23MtpGi029157@locutus.cmf.nrl.navy.mil>
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH][ATM] get lec net_device names correct
X-url: http://www.nrl.navy.mil/CCS/people/chas/index.html
X-mailer: nmh 1.0
Date: Mon, 03 Mar 2003 17:55:51 -0500
From: chas williams <chas@locutus.cmf.nrl.navy.mil>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

init_etherdev() allocates and registers the network device in one
step.  it uses eth%d as the template for the device names.  this
conflicts with already registered ethernet devices, like eth0.  since
we want a fixed (and different name) this patch uses alloc_etherdev,
rewrites the device name and then registers our interface.

Index: linux/net/atm/lec.c
===================================================================
RCS file: /home/chas/CVSROOT/linux/net/atm/lec.c,v
retrieving revision 1.12
diff -u -r1.12 lec.c
--- linux/net/atm/lec.c	3 Mar 2003 22:23:13 -0000	1.12
+++ linux/net/atm/lec.c	3 Mar 2003 22:29:02 -0000
@@ -784,15 +784,19 @@
                 size = sizeof(struct lec_priv);
 #ifdef CONFIG_TR
                 if (is_trdev)
-                        dev_lec[i] = init_trdev(NULL, size);
+                        dev_lec[i] = alloc_trdev(size);
                 else
 #endif
-                dev_lec[i] = init_etherdev(NULL, size);
+                dev_lec[i] = alloc_etherdev(size);
                 if (!dev_lec[i])
                         return -ENOMEM;
+                snprintf(dev_lec[i]->name, IFNAMSIZ, "lec%d", i);
+                if (register_netdev(dev_lec[i])) {
+                        kfree(dev_lec[i]);
+                        return -EINVAL;
+                }
                 priv = dev_lec[i]->priv;
                 priv->is_trdev = is_trdev;
-                sprintf(dev_lec[i]->name, "lec%d", i);
                 lec_init(dev_lec[i]);
         } else {
                 priv = dev_lec[i]->priv;
