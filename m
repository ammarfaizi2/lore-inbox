Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262382AbUKQUTr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262382AbUKQUTr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 15:19:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262378AbUKQUSU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 15:18:20 -0500
Received: from ra.tuxdriver.com ([24.172.12.4]:29203 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S262374AbUKQUQN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 15:16:13 -0500
Date: Wed, 17 Nov 2004 15:12:44 -0500
From: "John W. Linville" <linville@tuxdriver.com>
To: linux-kernel@vger.kernel.org
Cc: netdev@oss.sgi.com, jgarzik@pobox.com, grant.grundler@hp.com,
       charlie.brett@hp.com
Subject: [patch 2.6.10-rc2] tulip: make tulip_stop_rxtx() wait for DMA to fully stop
Message-ID: <20041117151244.B31363@tuxdriver.com>
Mail-Followup-To: linux-kernel@vger.kernel.org, netdev@oss.sgi.com,
	jgarzik@pobox.com, grant.grundler@hp.com, charlie.brett@hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

tulip_stop_rxtx() doesn't wait for DMA to fully stop like the function
call name implies.

Acked-by: Grant Grundler <grant.grundler@hp.com>
Acked-by: Charlie Brett <charlie.brett@hp.com>
Signed-off-by: John W. Linville <linville@tuxdriver.com>
---
This was submitted through my employer -- I am not the original author
of this patch.  However, I passed it by Jeff Garizk and he expressed
interest in having it upstream.

 drivers/net/tulip/21142.c      |    2 +-
 drivers/net/tulip/eeprom.c     |    1 +
 drivers/net/tulip/interrupt.c  |    2 +-
 drivers/net/tulip/media.c      |    1 +
 drivers/net/tulip/pnic.c       |    1 +
 drivers/net/tulip/pnic2.c      |    2 +-
 drivers/net/tulip/timer.c      |    1 +
 drivers/net/tulip/tulip.h      |   15 ++++++++++++++-
 drivers/net/tulip/tulip_core.c |    2 +-
 9 files changed, 22 insertions(+), 5 deletions(-)

--- tulip_stop_rxtx-2.6/drivers/net/tulip/tulip_core.c.orig
+++ tulip_stop_rxtx-2.6/drivers/net/tulip/tulip_core.c
@@ -26,8 +26,8 @@
 
 
 #include <linux/module.h>
-#include "tulip.h"
 #include <linux/pci.h>
+#include "tulip.h"
 #include <linux/init.h>
 #include <linux/etherdevice.h>
 #include <linux/delay.h>
--- tulip_stop_rxtx-2.6/drivers/net/tulip/media.c.orig
+++ tulip_stop_rxtx-2.6/drivers/net/tulip/media.c
@@ -18,6 +18,7 @@
 #include <linux/mii.h>
 #include <linux/init.h>
 #include <linux/delay.h>
+#include <linux/pci.h>
 #include "tulip.h"
 
 
--- tulip_stop_rxtx-2.6/drivers/net/tulip/21142.c.orig
+++ tulip_stop_rxtx-2.6/drivers/net/tulip/21142.c
@@ -14,9 +14,9 @@
 
 */
 
-#include "tulip.h"
 #include <linux/pci.h>
 #include <linux/delay.h>
+#include "tulip.h"
 
 
 static u16 t21142_csr13[] = { 0x0001, 0x0009, 0x0009, 0x0000, 0x0001, };
--- tulip_stop_rxtx-2.6/drivers/net/tulip/timer.c.orig
+++ tulip_stop_rxtx-2.6/drivers/net/tulip/timer.c
@@ -14,6 +14,7 @@
 
 */
 
+#include <linux/pci.h>
 #include "tulip.h"
 
 
--- tulip_stop_rxtx-2.6/drivers/net/tulip/tulip.h.orig
+++ tulip_stop_rxtx-2.6/drivers/net/tulip/tulip.h
@@ -149,6 +149,9 @@ enum status_bits {
 	TxIntr = 0x01,
 };
 
+/* bit mask for CSR5 TX/RX process state */
+#define CSR5_TS	0x00700000
+#define CSR5_RS	0x000e0000
 
 enum tulip_mode_bits {
 	TxThreshold		= (1 << 22),
@@ -460,9 +463,19 @@ static inline void tulip_stop_rxtx(struc
 	u32 csr6 = ioread32(ioaddr + CSR6);
 
 	if (csr6 & RxTx) {
+		unsigned i=1300/10;
 		iowrite32(csr6 & ~RxTx, ioaddr + CSR6);
 		barrier();
-		(void) ioread32(ioaddr + CSR6); /* mmio sync */
+		/* wait until in-flight frame completes.
+		 * Max time @ 10BT: 1500*8b/10Mbps == 1200us (+ 100us margin)
+		 * Typically expect this loop to end in < 50 us on 100BT.
+		 */
+		while (--i && (ioread32(ioaddr + CSR5) & (CSR5_TS|CSR5_RS)))
+			udelay(10);
+
+		if (!i)
+			printk(KERN_DEBUG "%s: tulip_stop_rxtx() failed\n",
+					tp->pdev->slot_name);
 	}
 }
 
--- tulip_stop_rxtx-2.6/drivers/net/tulip/pnic.c.orig
+++ tulip_stop_rxtx-2.6/drivers/net/tulip/pnic.c
@@ -15,6 +15,7 @@
 */
 
 #include <linux/kernel.h>
+#include <linux/pci.h>
 #include "tulip.h"
 
 
--- tulip_stop_rxtx-2.6/drivers/net/tulip/pnic2.c.orig
+++ tulip_stop_rxtx-2.6/drivers/net/tulip/pnic2.c
@@ -76,8 +76,8 @@
 
 
 
-#include "tulip.h"
 #include <linux/pci.h>
+#include "tulip.h"
 #include <linux/delay.h>
 
 
--- tulip_stop_rxtx-2.6/drivers/net/tulip/eeprom.c.orig
+++ tulip_stop_rxtx-2.6/drivers/net/tulip/eeprom.c
@@ -14,6 +14,7 @@
 
 */
 
+#include <linux/pci.h>
 #include "tulip.h"
 #include <linux/init.h>
 #include <asm/unaligned.h>
--- tulip_stop_rxtx-2.6/drivers/net/tulip/interrupt.c.orig
+++ tulip_stop_rxtx-2.6/drivers/net/tulip/interrupt.c
@@ -14,10 +14,10 @@
 
 */
 
+#include <linux/pci.h>
 #include "tulip.h"
 #include <linux/config.h>
 #include <linux/etherdevice.h>
-#include <linux/pci.h>
 
 int tulip_rx_copybreak;
 unsigned int tulip_max_interrupt_work;
