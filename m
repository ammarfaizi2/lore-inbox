Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932207AbWHaNPt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932207AbWHaNPt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Aug 2006 09:15:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932202AbWHaNPs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Aug 2006 09:15:48 -0400
Received: from mtaout1.012.net.il ([84.95.2.1]:29503 "EHLO mtaout1.012.net.il")
	by vger.kernel.org with ESMTP id S932199AbWHaNPr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Aug 2006 09:15:47 -0400
Date: Thu, 31 Aug 2006 15:21:03 +0200
From: shaulka@012.net.il
Subject: [PATCH] drivers/net/{ne,smc-ultra}.c: Avoid compilation warnings by
 registering init and exit functions
To: p_gortmaker@yahoo.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Message-id: <11cf840538e0.44f6fe5f@default.domain>
MIME-version: 1.0
X-Mailer: Sun Java(tm) System Messenger Express 6.1 HotFix 0.05 (built Oct 21
 2004)
Content-type: text/plain; charset=us-ascii
Content-language: en
Content-transfer-encoding: 7BIT
Content-disposition: inline
X-Accept-Language: en
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This patch is against 2.6.17-11.
1) Meant to get rid of the following compilation warnings
         WARNING: drivers/net/ne.o - Section mismatch: reference to .init.text: from .text between 'init_module' (at offset 0xeb) and 'ne_close'
         WARNING: drivers/net/smc-ultra.o - Section mismatch: reference to .init.data:ultra_portlist from .text between 'init_module' (at offset 0xa4) and 'ultra_close_card'

2) Isn't the registration of a module's __init and __exit functions while making them
    static much encouraged in 2.6? I followed the Linux Device Drivers book.

Signed-off-by: Shaul Karl <shaulka@012.net.il>

---

drivers/net/ne.c        |    8 ++++++--
drivers/net/smc-ultra.c |   10 ++++++----
2 files changed, 12 insertions(+), 6 deletions(-)

--- linux-source-2.6.17/drivers/net/ne.c.orig   2006-08-29 14:55:59.000000000 +0300
+++ linux-source-2.6.17/drivers/net/ne.c        2006-08-29 18:27:13.000000000 +0300
@@ -829,7 +829,7 @@ that the ne2k probe is the last 8390 bas
 is at boot) and so the probe will get confused by any other 8390 cards.
 ISA device autoprobes on a running machine are not recommended anyway. */

-int init_module(void)
+static int __init init_ne_module(void)
 {
        int this_dev, found = 0;

@@ -867,7 +867,7 @@ static void cleanup_card(struct net_devi
        release_region(dev->base_addr, NE_IO_EXTENT);
 }

-void cleanup_module(void)
+static void __exit cleanup_ne_module(void)
 {
        int this_dev;

@@ -880,4 +880,8 @@ void cleanup_module(void)
                }
        }
 }
+
+module_init(init_ne_module);
+module_exit(cleanup_ne_module);
+
 #endif /* MODULE */

--- linux-source-2.6.17/drivers/net/smc-ultra.c.orig    2006-08-29 15:03:33.000000000 +0300
+++ linux-source-2.6.17/drivers/net/smc-ultra.c 2006-08-29 18:29:53.000000000 +0300
@@ -553,8 +553,7 @@ MODULE_LICENSE("GPL");

 /* This is set up so that only a single autoprobe takes place per call.
 ISA device autoprobes on a running machine are not recommended. */
-int
-init_module(void)
+static int __init init_smcUltra_module(void)
 {
        struct net_device *dev;
        int this_dev, found = 0;
@@ -594,8 +593,7 @@ static void cleanup_card(struct net_devi
        iounmap(ei_status.mem);
 }

-void
-cleanup_module(void)
+static void __exit cleanup_smcUltra_module(void)
 {
        int this_dev;

@@ -608,4 +606,8 @@ cleanup_module(void)
                }
        }
 }
+
+module_init(init_smcUltra_module);
+module_exit(cleanup_smcUltra_module);
+
 #endif /* MODULE */


