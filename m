Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264898AbUAJIrI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jan 2004 03:47:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264919AbUAJIrI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jan 2004 03:47:08 -0500
Received: from smtp802.mail.sc5.yahoo.com ([66.163.168.181]:63081 "HELO
	smtp802.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S264898AbUAJIrE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jan 2004 03:47:04 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Gunter =?iso-8859-1?q?K=F6nigsmann?= <gunter.koenigsmann@gmx.de>,
       Gunter =?iso-8859-1?q?K=F6nigsmann?= <gunter@peterpall.de>
Subject: [PATCH 1/2] Synaptics rate switching
Date: Sat, 10 Jan 2004 03:45:13 -0500
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org, Vojtech Pavlik <vojtech@suse.cz>,
       Andrew Morton <akpm@osdl.org>
References: <Pine.LNX.4.53.0401091101170.1050@calcula.uni-erlangen.de> <200401100344.03758.dtor_core@ameritech.net>
In-Reply-To: <200401100344.03758.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200401100345.17211.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

===================================================================


ChangeSet@1.1512, 2004-01-10 02:42:42-05:00, dtor_core@ameritech.net
  Input: Allow switching between high and low reporting rate for Synaptics
         touchpads in native mode. Synaptics support 2 report rates - 40
         and 80 packets/sec; report rate must be set using Synaptics mode
         set command. Rate is controlled by psmouse.rate parameter, values
         greater or equal 80 will set 'high' rate. (psmouse.rate defaults
         to 100)
  
         Using low report rate should help slower systems or systems
         spending too much time in SCI (ACPI).


 psmouse.h   |    1 +
 synaptics.c |    4 +++-
 2 files changed, 4 insertions(+), 1 deletion(-)


===================================================================



diff -Nru a/drivers/input/mouse/psmouse.h b/drivers/input/mouse/psmouse.h
--- a/drivers/input/mouse/psmouse.h	Sat Jan 10 03:22:26 2004
+++ b/drivers/input/mouse/psmouse.h	Sat Jan 10 03:22:26 2004
@@ -67,6 +67,7 @@
 int psmouse_command(struct psmouse *psmouse, unsigned char *param, int command);
 
 extern int psmouse_smartscroll;
+extern unsigned int psmouse_rate;
 extern unsigned int psmouse_resetafter;
 
 #endif /* _PSMOUSE_H */
diff -Nru a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
--- a/drivers/input/mouse/synaptics.c	Sat Jan 10 03:22:26 2004
+++ b/drivers/input/mouse/synaptics.c	Sat Jan 10 03:22:26 2004
@@ -214,7 +214,9 @@
 {
 	struct synaptics_data *priv = psmouse->private;
 
-	mode |= SYN_BIT_ABSOLUTE_MODE | SYN_BIT_HIGH_RATE;
+	mode |= SYN_BIT_ABSOLUTE_MODE;
+	if (psmouse_rate >= 80)
+		mode |= SYN_BIT_HIGH_RATE;
 	if (SYN_ID_MAJOR(priv->identity) >= 4)
 		mode |= SYN_BIT_DISABLE_GESTURE;
 	if (SYN_CAP_EXTENDED(priv->capabilities))
