Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263591AbUCUC2y (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Mar 2004 21:28:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263592AbUCUC2y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Mar 2004 21:28:54 -0500
Received: from gate.crashing.org ([63.228.1.57]:39911 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S263591AbUCUC2w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Mar 2004 21:28:52 -0500
Subject: [PATCH] pmac: keywest bugfix
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1079835329.900.119.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sun, 21 Mar 2004 13:15:30 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please apply

-----Forwarded Message-----
From: Samuel Rydh <samuel@ibrium.se>
To: linuxppc-dev@lists.linuxppc.org
Cc: benh@kernel.crashing.org
Subject: keywest bugfix
Date: Sat, 20 Mar 2004 14:43:16 +0100


The following patch fixes a deadlock in I2C probing:

===== drivers/i2c/busses/i2c-keywest.c 1.12 vs edited =====
--- 1.12/drivers/i2c/busses/i2c-keywest.c	Mon Mar 15 11:25:23 2004
+++ edited/drivers/i2c/busses/i2c-keywest.c	Sat Mar 20 14:33:07 2004
@@ -608,6 +608,7 @@
 	}
 #endif /* POLLED_MODE */

+	pmac_low_i2c_unlock(np);
 	dev_set_drvdata(dev, iface);

 	for (i=0; i<nchan; i++) {
@@ -645,7 +646,6 @@
 	printk(KERN_INFO "Found KeyWest i2c on \"%s\", %d channel%s, stepping: %d bits\n",
 		np->parent->name, nchan, nchan > 1 ? "s" : "", bsteps);

-	pmac_low_i2c_unlock(np);
 	return 0;
 }


Without this patch, the deadlock occurs in the following situation:

- keywest holds the pmac_low_i2c_lock while registering the i2c adapter.
- i2c_add_adapter() notifies registered drivers by calling
driver->attach_adapter().
- a driver might access the i2c bus from attach_adapter() which
deadlocks since all xfer routines take the lock.

/Samuel

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
-- 
Benjamin Herrenschmidt <benh@kernel.crashing.org>

