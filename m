Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262468AbUKLGlK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262468AbUKLGlK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Nov 2004 01:41:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262476AbUKLGjt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Nov 2004 01:39:49 -0500
Received: from smtp811.mail.sc5.yahoo.com ([66.163.170.81]:19358 "HELO
	smtp811.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262472AbUKLGfM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Nov 2004 01:35:12 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Vojtech Pavlik <vojtech@suse.cz>
Subject: [PATCH 7/7] Limit Synaptics rate on Toshibas
Date: Fri, 12 Nov 2004 01:34:21 -0500
User-Agent: KMail/1.6.2
Cc: LKML <linux-kernel@vger.kernel.org>
References: <200411120127.01473.dtor_core@ameritech.net> <200411120132.44833.dtor_core@ameritech.net> <200411120133.36249.dtor_core@ameritech.net>
In-Reply-To: <200411120133.36249.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200411120134.23157.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


===================================================================


ChangeSet@1.1991, 2004-11-12 00:47:33-05:00, dtor_core@ameritech.net
  Input: synaptics - use DMI to detect Toshiba Satellite notebooks
         and automatically reduce touchpad reporting rate to 40 pps
         as they have trouble handling high rate (80 pps).
  
  Signed-off-by: Dmitry Torokhov <dtor@mail.ru>


 synaptics.c |   26 ++++++++++++++++++++++++++
 1 files changed, 26 insertions(+)


===================================================================



diff -Nru a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
--- a/drivers/input/mouse/synaptics.c	2004-11-12 01:01:27 -05:00
+++ b/drivers/input/mouse/synaptics.c	2004-11-12 01:01:27 -05:00
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
 
