Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268440AbUIQEQE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268440AbUIQEQE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Sep 2004 00:16:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268337AbUIQENe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Sep 2004 00:13:34 -0400
Received: from [12.177.129.25] ([12.177.129.25]:5572 "EHLO
	ccure.user-mode-linux.org") by vger.kernel.org with ESMTP
	id S268345AbUIQENC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Sep 2004 00:13:02 -0400
Message-Id: <200409170517.i8H5HX2J005397@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.1-RC1
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] UML - Network driver fixes
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 17 Sep 2004 01:17:33 -0400
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is from Gerd Knorr.  It fixes a network hang caused by the host side
of an interface being full when the UML interface is brought up, preventing
any SIGIOs from happening.  It also implements an ioctl needed for ethtool.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: 2.6.9-rc2/arch/um/drivers/net_kern.c
===================================================================
--- 2.6.9-rc2.orig/arch/um/drivers/net_kern.c	2004-09-16 22:59:06.000000000 -0400
+++ 2.6.9-rc2/arch/um/drivers/net_kern.c	2004-09-16 23:34:32.000000000 -0400
@@ -19,6 +19,8 @@
 #include "linux/inetdevice.h"
 #include "linux/ctype.h"
 #include "linux/bootmem.h"
+#include "linux/ethtool.h"
+#include "asm/uaccess.h"
 #include "user_util.h"
 #include "kern_util.h"
 #include "net_kern.h"
@@ -127,6 +129,13 @@
 	spin_lock(&opened_lock);
 	list_add(&lp->list, &opened);
 	spin_unlock(&opened_lock);
+
+	/* clear buffer - it can happen that the host side of the interface
+	 * is full when we get here.  In this case, new data is never queued,
+	 * SIGIOs never arrive, and the net never works.
+	 */
+	while((err = uml_net_rx(dev)) > 0) ;
+
  out:
 	spin_unlock(&lp->lock);
 	return(err);
@@ -240,7 +249,30 @@
 
 static int uml_net_ioctl(struct net_device *dev, struct ifreq *ifr, int cmd)
 {
-	return(-EINVAL);
+	static const struct ethtool_drvinfo info = {
+		.cmd     = ETHTOOL_GDRVINFO,
+		.driver  = "uml virtual ethernet",
+		.version = "42",
+	};
+	void *useraddr;
+	u32 ethcmd;
+
+	switch (cmd) {
+	case SIOCETHTOOL:
+		useraddr = ifr->ifr_data;
+		if (copy_from_user(&ethcmd, useraddr, sizeof(ethcmd)))
+			return -EFAULT;
+		switch (ethcmd) {
+		case ETHTOOL_GDRVINFO:
+			if (copy_to_user(useraddr, &info, sizeof(info)))
+				return -EFAULT;
+			return 0;
+		default:
+			return -EOPNOTSUPP;
+		}
+	default:
+		return -EINVAL;
+	}
 }
 
 void uml_net_user_timer_expire(unsigned long _conn)

