Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266852AbUAXCW0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jan 2004 21:22:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266851AbUAXCW0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jan 2004 21:22:26 -0500
Received: from palrel12.hp.com ([156.153.255.237]:55194 "EHLO palrel12.hp.com")
	by vger.kernel.org with ESMTP id S266852AbUAXCVs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jan 2004 21:21:48 -0500
Date: Fri, 23 Jan 2004 18:21:46 -0800
To: "David S. Miller" <davem@redhat.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.6 IrDA] 5/11: litelink-sir: converted to new API
Message-ID: <20040124022146.GF22410@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ir262_dongles-5_litelink-sir-2.diff :
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
		<Patch from Eugene Crosser>
* converted for new api from old driver
		<Patch from Martin Diehl>
* convert to de-virtualized sirdev helpers
* set dongle to 9600 in case of invalid speed instead leaving it in
  unknown configuration


diff -u -p linux/drivers/net/irda.d6/litelink-sir.c  linux/drivers/net/irda/litelink-sir.c
--- linux/drivers/net/irda.d6/litelink-sir.c	Wed Dec 31 16:00:00 1969
+++ linux/drivers/net/irda/litelink-sir.c	Thu Jan 22 16:43:31 2004
@@ -0,0 +1,209 @@
+/*********************************************************************
+ *                
+ * Filename:      litelink.c
+ * Version:       1.1
+ * Description:   Driver for the Parallax LiteLink dongle
+ * Status:        Stable
+ * Author:        Dag Brattli <dagb@cs.uit.no>
+ * Created at:    Fri May  7 12:50:33 1999
+ * Modified at:   Fri Dec 17 09:14:23 1999
+ * Modified by:   Dag Brattli <dagb@cs.uit.no>
+ * 
+ *     Copyright (c) 1999 Dag Brattli, All Rights Reserved.
+ *     
+ *     This program is free software; you can redistribute it and/or 
+ *     modify it under the terms of the GNU General Public License as 
+ *     published by the Free Software Foundation; either version 2 of 
+ *     the License, or (at your option) any later version.
+ * 
+ *     This program is distributed in the hope that it will be useful,
+ *     but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ *     GNU General Public License for more details.
+ * 
+ *     You should have received a copy of the GNU General Public License 
+ *     along with this program; if not, write to the Free Software 
+ *     Foundation, Inc., 59 Temple Place, Suite 330, Boston, 
+ *     MA 02111-1307 USA
+ *     
+ ********************************************************************/
+
+/*
+ * Modified at:   Thu Jan 15 2003
+ * Modified by:   Eugene Crosser <crosser@average.org>
+ *
+ * Convert to "new" IRDA infrastructure for kernel 2.6
+ */
+
+#include <linux/module.h>
+#include <linux/delay.h>
+#include <linux/init.h>
+
+#include <net/irda/irda.h>
+
+#include "sir-dev.h"
+
+#define MIN_DELAY 25      /* 15 us, but wait a little more to be sure */
+#define MAX_DELAY 10000   /* 1 ms */
+
+static int litelink_open(struct sir_dev *dev);
+static int litelink_close(struct sir_dev *dev);
+static int litelink_change_speed(struct sir_dev *dev, unsigned speed);
+static int litelink_reset(struct sir_dev *dev);
+
+/* These are the baudrates supported - 9600 must be last one! */
+static unsigned baud_rates[] = { 115200, 57600, 38400, 19200, 9600 };
+
+static struct dongle_driver litelink = {
+	.owner		= THIS_MODULE,
+	.driver_name	= "Parallax LiteLink",
+	.type		= IRDA_LITELINK_DONGLE,
+	.open		= litelink_open,
+	.close		= litelink_close,
+	.reset		= litelink_reset,
+	.set_speed	= litelink_change_speed,
+};
+
+int __init litelink_sir_init(void)
+{
+	return irda_register_dongle(&litelink);
+}
+
+void __exit litelink_sir_cleanup(void)
+{
+	irda_unregister_dongle(&litelink);
+}
+
+static int litelink_open(struct sir_dev *dev)
+{
+	struct qos_info *qos = &dev->qos;
+
+	IRDA_DEBUG(2, "%s()\n", __FUNCTION__);
+
+	/* Power up dongle */
+	sirdev_set_dtr_rts(dev, TRUE, TRUE);
+
+	/* Set the speeds we can accept */
+	qos->baud_rate.bits &= IR_115200|IR_57600|IR_38400|IR_19200|IR_9600;
+	qos->min_turn_time.bits = 0x7f; /* Needs 0.01 ms */
+	irda_qos_bits_to_value(qos);
+
+	/* irda thread waits 50 msec for power settling */
+
+	return 0;
+}
+
+static int litelink_close(struct sir_dev *dev)
+{
+	IRDA_DEBUG(2, "%s()\n", __FUNCTION__);
+
+	/* Power off dongle */
+	sirdev_set_dtr_rts(dev, FALSE, FALSE);
+
+	return 0;
+}
+
+/*
+ * Function litelink_change_speed (task)
+ *
+ *    Change speed of the Litelink dongle. To cycle through the available 
+ *    baud rates, pulse RTS low for a few ms.  
+ */
+static int litelink_change_speed(struct sir_dev *dev, unsigned speed)
+{
+        int i;
+
+	IRDA_DEBUG(2, "%s()\n", __FUNCTION__);
+
+	/* dongle already reset by irda-thread - current speed (dongle and
+	 * port) is the default speed (115200 for litelink!)
+	 */
+
+	/* Cycle through avaiable baudrates until we reach the correct one */
+	for (i = 0; baud_rates[i] != speed; i++) {
+
+		/* end-of-list reached due to invalid speed request */
+		if (baud_rates[i] == 9600)
+			break;
+
+		/* Set DTR, clear RTS */
+		sirdev_set_dtr_rts(dev, FALSE, TRUE);
+
+		/* Sleep a minimum of 15 us */
+		udelay(MIN_DELAY);
+
+		/* Set DTR, Set RTS */
+		sirdev_set_dtr_rts(dev, TRUE, TRUE);
+
+		/* Sleep a minimum of 15 us */
+		udelay(MIN_DELAY);
+        }
+
+	dev->speed = baud_rates[i];
+
+	/* invalid baudrate should not happen - but if, we return -EINVAL and
+	 * the dongle configured for 9600 so the stack has a chance to recover
+	 */
+
+	return (dev->speed == speed) ? 0 : -EINVAL;
+}
+
+/*
+ * Function litelink_reset (task)
+ *
+ *      Reset the Litelink type dongle.
+ *
+ */
+static int litelink_reset(struct sir_dev *dev)
+{
+	IRDA_DEBUG(2, "%s()\n", __FUNCTION__);
+
+	/* probably the power-up can be dropped here, but with only
+	 * 15 usec delay it's not worth the risk unless somebody with
+	 * the hardware confirms it doesn't break anything...
+	 */
+
+	/* Power on dongle */
+	sirdev_set_dtr_rts(dev, TRUE, TRUE);
+
+	/* Sleep a minimum of 15 us */
+	udelay(MIN_DELAY);
+
+	/* Clear RTS to reset dongle */
+	sirdev_set_dtr_rts(dev, TRUE, FALSE);
+
+	/* Sleep a minimum of 15 us */
+	udelay(MIN_DELAY);
+
+	/* Go back to normal mode */
+	sirdev_set_dtr_rts(dev, TRUE, TRUE);
+
+	/* Sleep a minimum of 15 us */
+	udelay(MIN_DELAY);
+
+	/* This dongles speed defaults to 115200 bps */
+	dev->speed = 115200;
+
+	return 0;
+}
+
+MODULE_AUTHOR("Dag Brattli <dagb@cs.uit.no>");
+MODULE_DESCRIPTION("Parallax Litelink dongle driver");	
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("irda-dongle-5"); /* IRDA_LITELINK_DONGLE */
+
+/*
+ * Function init_module (void)
+ *
+ *    Initialize Litelink module
+ *
+ */
+module_init(litelink_sir_init);
+
+/*
+ * Function cleanup_module (void)
+ *
+ *    Cleanup Litelink module
+ *
+ */
+module_exit(litelink_sir_cleanup);
