Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261520AbUL2H5D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261520AbUL2H5D (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Dec 2004 02:57:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261475AbUL2Hku
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Dec 2004 02:40:50 -0500
Received: from smtp802.mail.sc5.yahoo.com ([66.163.168.181]:15023 "HELO
	smtp802.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261425AbUL2Hd1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Dec 2004 02:33:27 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Vojtech Pavlik <vojtech@suse.cz>
Subject: [PATCH 7/16] Limit Synaptics rate on Toshiba Satellites
Date: Wed, 29 Dec 2004 02:24:13 -0500
User-Agent: KMail/1.6.2
Cc: linux-input@atrey.karlin.mff.cuni.cz, LKML <linux-kernel@vger.kernel.org>
References: <200412290217.36282.dtor_core@ameritech.net> <200412290222.25300.dtor_core@ameritech.net> <200412290223.24307.dtor_core@ameritech.net>
In-Reply-To: <200412290223.24307.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200412290224.14315.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


===================================================================


ChangeSet@1.1957.1.34, 2004-11-12 01:31:15-05:00, dtor_core@ameritech.net
  Input: synaptics - use DMI to detect Toshiba Satellite notebooks
         and automatically reduce touchpad reporting rate to 40 pps
         as they have trouble handling high rate (80 pps).
  
  Signed-off-by: Dmitry Torokhov <dtor@mail.ru>


 synaptics.c |   26 ++++++++++++++++++++++++++
 1 files changed, 26 insertions(+)


===================================================================



diff -Nru a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
--- a/drivers/input/mouse/synaptics.c	2004-12-29 01:48:12 -05:00
+++ b/drivers/input/mouse/synaptics.c	2004-12-29 01:48:12 -05:00
@@ -604,6 +604,20 @@
 	return 0;
 }
 
+#if defined(__i386__)
+#include <linux/dmi.h>
+static struct dmi_system_id toshiba_dmi_table[] = {
+	{
+		.ident = "Toshiba Satellite",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "TOSHIBA"),
+			DMI_MATCH(DMI_PRODUCT_NAME , "Satellite"),
+		},
+	},
+	{ }
+};
+#endif
+
 int synaptics_init(struct psmouse *psmouse)
 {
 	struct synaptics_data *priv;
@@ -636,6 +650,18 @@
 	psmouse->disconnect = synaptics_disconnect;
 	psmouse->reconnect = synaptics_reconnect;
 	psmouse->pktsize = 6;
+
+#if defined(__i386__)
+	/*
+	 * Toshiba's KBC seems to have trouble handling data from
+	 * Synaptics as full rate, switch to lower rate which is roughly
+	 * thye same as rate of standard PS/2 mouse.
+	 */
+	if (psmouse->rate >= 80 && dmi_check_system(toshiba_dmi_table)) {
+		printk(KERN_INFO "synaptics: Toshiba Satellite detected, limiting rate to 40pps.\n");
+		psmouse->rate = 40;
+	}
+#endif
 
 	return 0;
 
