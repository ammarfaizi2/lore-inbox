Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266859AbUAXC3B (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jan 2004 21:29:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266837AbUAXC0P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jan 2004 21:26:15 -0500
Received: from palrel13.hp.com ([156.153.255.238]:41418 "EHLO palrel13.hp.com")
	by vger.kernel.org with ESMTP id S266856AbUAXCZH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jan 2004 21:25:07 -0500
Date: Fri, 23 Jan 2004 18:25:04 -0800
To: "David S. Miller" <davem@redhat.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.6 IrDA] 10/11: old_belkin-sir: converted to new API
Message-ID: <20040124022504.GK22410@bougret.hpl.hp.com>
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

ir262_dongles-10_belkin-sir.diff :
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
		<Patch from Martin Diehl>
* converted for new api from old driver


diff -u -p linux/drivers/net/irda.d6/old_belkin-sir.c  linux/drivers/net/irda/old_belkin-sir.c
--- linux/drivers/net/irda.d6/old_belkin-sir.c	Wed Dec 31 16:00:00 1969
+++ linux/drivers/net/irda/old_belkin-sir.c	Thu Jan 22 16:43:52 2004
@@ -0,0 +1,156 @@
+/*********************************************************************
+ *                
+ * Filename:      old_belkin.c
+ * Version:       1.1
+ * Description:   Driver for the Belkin (old) SmartBeam dongle
+ * Status:        Experimental...
+ * Author:        Jean Tourrilhes <jt@hpl.hp.com>
+ * Created at:    22/11/99
+ * Modified at:   Fri Dec 17 09:13:32 1999
+ * Modified by:   Dag Brattli <dagb@cs.uit.no>
+ * 
+ *     Copyright (c) 1999 Jean Tourrilhes, All Rights Reserved.
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
+#include <linux/module.h>
+#include <linux/delay.h>
+#include <linux/init.h>
+
+#include <net/irda/irda.h>
+// #include <net/irda/irda_device.h>
+
+#include "sir-dev.h"
+
+/*
+ * Belkin is selling a dongle called the SmartBeam.
+ * In fact, there is two hardware version of this dongle, of course with
+ * the same name and looking the exactly same (grrr...).
+ * I guess that I've got the old one, because inside I don't have
+ * a jumper for IrDA/ASK...
+ *
+ * As far as I can make it from info on their web site, the old dongle 
+ * support only 9600 b/s, which make our life much simpler as far as
+ * the driver is concerned, but you might not like it very much ;-)
+ * The new SmartBeam does 115 kb/s, and I've not tested it...
+ *
+ * Belkin claim that the correct driver for the old dongle (in Windows)
+ * is the generic Parallax 9500a driver, but the Linux LiteLink driver
+ * fails for me (probably because Linux-IrDA doesn't rate fallback),
+ * so I created this really dumb driver...
+ *
+ * In fact, this driver doesn't do much. The only thing it does is to
+ * prevent Linux-IrDA to use any other speed than 9600 b/s ;-) This
+ * driver is called "old_belkin" so that when the new SmartBeam is supported
+ * its driver can be called "belkin" instead of "new_belkin".
+ *
+ * Note : this driver was written without any info/help from Belkin,
+ * so a lot of info here might be totally wrong. Blame me ;-)
+ */
+
+static int old_belkin_open(struct sir_dev *dev);
+static int old_belkin_close(struct sir_dev *dev);
+static int old_belkin_change_speed(struct sir_dev *dev, unsigned speed);
+static int old_belkin_reset(struct sir_dev *dev);
+
+static struct dongle_driver old_belkin = {
+	.owner		= THIS_MODULE,
+	.driver_name	= "Old Belkin SmartBeam",
+	.type		= IRDA_OLD_BELKIN_DONGLE,
+	.open		= old_belkin_open,
+	.close		= old_belkin_close,
+	.reset		= old_belkin_reset,
+	.set_speed	= old_belkin_change_speed,
+};
+
+int __init old_belkin_init(void)
+{
+	return irda_register_dongle(&old_belkin);
+}
+
+void __exit old_belkin_cleanup(void)
+{
+	irda_unregister_dongle(&old_belkin);
+}
+
+static int old_belkin_open(struct sir_dev *dev)
+{
+	struct qos_info *qos = &dev->qos;
+
+	IRDA_DEBUG(2, "%s()\n", __FUNCTION__);
+
+	/* Power on dongle */
+	sirdev_set_dtr_rts(dev, TRUE, TRUE);
+
+	/* Not too fast, please... */
+	qos->baud_rate.bits &= IR_9600;
+	/* Needs at least 10 ms (totally wild guess, can do probably better) */
+	qos->min_turn_time.bits = 0x01;
+	irda_qos_bits_to_value(qos);
+
+	/* irda thread waits 50 msec for power settling */
+
+	return 0;
+}
+
+static int old_belkin_close(struct sir_dev *dev)
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
+ * Function old_belkin_change_speed (task)
+ *
+ *    With only one speed available, not much to do...
+ */
+static int old_belkin_change_speed(struct sir_dev *dev, unsigned speed)
+{
+	IRDA_DEBUG(2, "%s()\n", __FUNCTION__);
+
+	dev->speed = 9600;
+	return (speed==dev->speed) ? 0 : -EINVAL;
+}
+
+/*
+ * Function old_belkin_reset (task)
+ *
+ *      Reset the Old-Belkin type dongle.
+ *
+ */
+static int old_belkin_reset(struct sir_dev *dev)
+{
+	IRDA_DEBUG(2, "%s()\n", __FUNCTION__);
+
+	/* This dongles speed "defaults" to 9600 bps ;-) */
+	dev->speed = 9600;
+
+	return 0;
+}
+
+MODULE_AUTHOR("Jean Tourrilhes <jt@hpl.hp.com>");
+MODULE_DESCRIPTION("Belkin (old) SmartBeam dongle driver");	
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("irda-dongle-7"); /* IRDA_OLD_BELKIN_DONGLE */
+
+module_init(old_belkin_init);
+module_exit(old_belkin_cleanup);
