Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261757AbUKHGzJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261757AbUKHGzJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Nov 2004 01:55:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261755AbUKHGzJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Nov 2004 01:55:09 -0500
Received: from smtp807.mail.sc5.yahoo.com ([66.163.168.186]:50792 "HELO
	smtp807.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261757AbUKHGy6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Nov 2004 01:54:58 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: LKML <linux-kernel@vger.kernel.org>
Subject: [RFT/PATCH] Toshiba Satellite, Synaptics & keyboard problems
Date: Mon, 8 Nov 2004 01:54:52 -0500
User-Agent: KMail/1.6.2
Cc: Vojtech Pavlik <vojtech@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200411080154.54279.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

If anyone experiencing keyboard getting "stuck" when you use Synaptics
touchpad in native mode on Toshiba Satellite type notebooks it seems that
lowering rate to 40 pps (which is roughly the same as standard PS/2 rate
bytewise) helps.

Please try the patch below (should apply to -mm tree) and see if it helps
any. If not using -mm tree just use "psmouse.rate=40" or "modprobe psmouse
rate=40" to check if fix is working for you and let me know.

Thanks!

-- 
Dmitry


===================================================================


ChangeSet@1.1960, 2004-11-08 01:51:37-05:00, dtor_core@ameritech.net
  Input: synaptics - use DMI to detect Toshiba Satellite notebooks
         and automatically reduce touchpad reporting rate to 40 pps
         as they have trouble handling high rate (80 pps).
  
  Signed-off-by: Dmitry Torokhov <dtor@mail.ru>


 synaptics.c |   26 ++++++++++++++++++++++++++
 1 files changed, 26 insertions(+)


===================================================================



diff -Nru a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
--- a/drivers/input/mouse/synaptics.c	2004-11-08 01:52:54 -05:00
+++ b/drivers/input/mouse/synaptics.c	2004-11-08 01:52:54 -05:00
@@ -604,6 +604,20 @@
 	return 0;
 }
 
+#if defined(__i386__)
+#include <linux/dmi.h>
+static struct dmi_system_id synaptics_dmi_table[] = {
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
+	if (dmi_check_system(synaptics_dmi_table)) {
+		printk(KERN_INFO "synaptics: Toshiba Satellite detected, limiting rate to 40pps.\n");
+		psmouse->rate = 40;
+	}
+#endif
 
 	return 0;
 
