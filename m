Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132053AbQLPSxY>; Sat, 16 Dec 2000 13:53:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132130AbQLPSxO>; Sat, 16 Dec 2000 13:53:14 -0500
Received: from lsmls02.we.mediaone.net ([24.130.1.15]:7919 "EHLO
	lsmls02.we.mediaone.net") by vger.kernel.org with ESMTP
	id <S132053AbQLPSxI>; Sat, 16 Dec 2000 13:53:08 -0500
To: linux-kernel@vger.kernel.org
Subject: 2.4.0-test13-pre2 has problems
X-Mailer: Mew version 1.94.2 on XEmacs 21.1 (Canyonlands)
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
 boundary="--Next_Part(Sat_Dec_16_10:22:35_2000_559)--"
Content-Transfer-Encoding: 7bit
Message-Id: <20001216102236W.dyky@df-usa.com>
Date: Sat, 16 Dec 2000 10:22:36 -0800
From: Daiki Matsuda <dyky@df-usa.com>
X-Dispatcher: imput version 20000414(IM141)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

----Next_Part(Sat_Dec_16_10:22:35_2000_559)--
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hi, all.
I'm trying kernel 2.4.0-test13-pre2. But it has a problem in
CONFIG_ATM.

In net/Config.in, we seletct CONFIG_ATM by bool, CONFIG_ATM_LANE
and CONFIG_ATM_MPOA by tristate. But net/atm/common.c calls two
function i.e. atm_lane_init and atm_mpoa_init, there also in
net/atm/{lane_mpoa_init.c,mpoa_caches.c}. When CONFIG_ATM_LANE or
CONFIG_ATM_MPOA is defined as module, the two functions are
unreferenced. So, I will put a simple patch. But I feel its patch
redundancy against two *.c files.

Regards
Daiki Matsuda


----Next_Part(Sat_Dec_16_10:22:35_2000_559)--
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="net.atm.commn.c.patch"

--- linux/net/atm/common.c.old	Fri Dec 15 23:48:51 2000
+++ linux/net/atm/common.c	Sat Dec 16 00:07:29 2000
@@ -607,8 +607,10 @@
 #if defined(CONFIG_ATM_LANE) || defined(CONFIG_ATM_LANE_MODULE)
                 case ATMLEC_CTRL:
                         if (!capable(CAP_NET_ADMIN)) return -EPERM;
+#ifndef CONFIG_ATM_LANE_MODULE
                         if (atm_lane_ops.lecd_attach == NULL)
                                 atm_lane_init();
+#endif
                         if (atm_lane_ops.lecd_attach == NULL) /* try again */
                                 return -ENOSYS;
                         error = atm_lane_ops.lecd_attach(vcc, (int)arg);
@@ -624,8 +626,10 @@
 #if defined(CONFIG_ATM_MPOA) || defined(CONFIG_ATM_MPOA_MODULE)
 		case ATMMPC_CTRL:
 			if (!capable(CAP_NET_ADMIN)) return -EPERM;
+#ifndef CONFIG_ATM_MPOA_MODULE
                         if (atm_mpoa_ops.mpoad_attach == NULL)
                                 atm_mpoa_init();
+#endif
                         if (atm_mpoa_ops.mpoad_attach == NULL) /* try again */
                                 return -ENOSYS;
                         error = atm_mpoa_ops.mpoad_attach(vcc, (int)arg);

----Next_Part(Sat_Dec_16_10:22:35_2000_559)----
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
