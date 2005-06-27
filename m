Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261196AbVF0NCg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261196AbVF0NCg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 09:02:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262182AbVF0M52
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 08:57:28 -0400
Received: from ipx10786.ipxserver.de ([80.190.251.108]:10469 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S262052AbVF0MQ1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 08:16:27 -0400
Message-Id: <20050627121417.336745000@abc>
References: <20050627120600.739151000@abc>
Date: Mon, 27 Jun 2005 14:06:39 +0200
From: Johannes Stezenbach <js@linuxtv.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Patrick Boettcher <pb@linuxtv.org>
Content-Disposition: inline; filename=dvb-usb-rc-control-modparm.patch
X-SA-Exim-Connect-IP: 84.189.248.249
Subject: [DVB patch 39/51] usb: add module parm to disable remote control polling
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Patrick Boettcher <pb@linuxtv.org>

Add module parameter to deactive remote control polling.

Signed-off-by: Patrick Boettcher <pb@linuxtv.org>
Signed-off-by: Johannes Stezenbach <js@linuxtv.org>

 drivers/media/dvb/dvb-usb/dvb-usb-common.h |    1 +
 drivers/media/dvb/dvb-usb/dvb-usb-init.c   |    4 ++++
 drivers/media/dvb/dvb-usb/dvb-usb-remote.c |    8 +++++++-
 3 files changed, 12 insertions(+), 1 deletion(-)

Index: linux-2.6.12-git8/drivers/media/dvb/dvb-usb/dvb-usb-common.h
===================================================================
--- linux-2.6.12-git8.orig/drivers/media/dvb/dvb-usb/dvb-usb-common.h	2005-06-27 13:26:05.000000000 +0200
+++ linux-2.6.12-git8/drivers/media/dvb/dvb-usb/dvb-usb-common.h	2005-06-27 13:26:11.000000000 +0200
@@ -12,6 +12,7 @@
 #include "dvb-usb.h"
 
 extern int dvb_usb_debug;
+extern int dvb_usb_disable_rc_polling;
 
 #define deb_info(args...) dprintk(dvb_usb_debug,0x01,args)
 #define deb_xfer(args...) dprintk(dvb_usb_debug,0x02,args)
Index: linux-2.6.12-git8/drivers/media/dvb/dvb-usb/dvb-usb-init.c
===================================================================
--- linux-2.6.12-git8.orig/drivers/media/dvb/dvb-usb/dvb-usb-init.c	2005-06-27 13:18:22.000000000 +0200
+++ linux-2.6.12-git8/drivers/media/dvb/dvb-usb/dvb-usb-init.c	2005-06-27 13:26:11.000000000 +0200
@@ -18,6 +18,10 @@ int dvb_usb_debug;
 module_param_named(debug,dvb_usb_debug, int, 0644);
 MODULE_PARM_DESC(debug, "set debugging level (1=info,xfer=2,pll=4,ts=8,err=16,rc=32,fw=64 (or-able))." DVB_USB_DEBUG_STATUS);
 
+int dvb_usb_disable_rc_polling;
+module_param_named(disable_rc_polling, dvb_usb_disable_rc_polling, int, 0644);
+MODULE_PARM_DESC(disable_rc_polling, "disable remote control polling (default: 0).");
+
 /* general initialization functions */
 int dvb_usb_exit(struct dvb_usb_device *d)
 {
Index: linux-2.6.12-git8/drivers/media/dvb/dvb-usb/dvb-usb-remote.c
===================================================================
--- linux-2.6.12-git8.orig/drivers/media/dvb/dvb-usb/dvb-usb-remote.c	2005-06-27 13:18:22.000000000 +0200
+++ linux-2.6.12-git8/drivers/media/dvb/dvb-usb/dvb-usb-remote.c	2005-06-27 13:26:11.000000000 +0200
@@ -21,6 +21,10 @@ static void dvb_usb_read_remote_control(
 	/* TODO: need a lock here.  We can simply skip checking for the remote control
 	   if we're busy. */
 
+	/* when the parameter has been set to 1 via sysfs while the driver was running */
+	if (dvb_usb_disable_rc_polling)
+		return;
+
 	if (d->props.rc_query(d,&event,&state)) {
 		err("error while querying for an remote control event.");
 		goto schedule;
@@ -85,7 +89,9 @@ schedule:
 int dvb_usb_remote_init(struct dvb_usb_device *d)
 {
 	int i;
-	if (d->props.rc_key_map == NULL)
+	if (d->props.rc_key_map == NULL ||
+		d->props.rc_query == NULL ||
+		dvb_usb_disable_rc_polling)
 		return 0;
 
 	/* Initialise the remote-control structures.*/

--

