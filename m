Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262116AbTKCQzT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Nov 2003 11:55:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262118AbTKCQzT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Nov 2003 11:55:19 -0500
Received: from hueytecuilhuitl.mtu.ru ([195.34.32.123]:31238 "EHLO
	hueymiccailhuitl.mtu.ru") by vger.kernel.org with ESMTP
	id S262116AbTKCQzO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Nov 2003 11:55:14 -0500
From: Andrey Borzenkov <arvidjaar@mail.ru>
To: linux-kernel@vger.kernel.org
Subject: [PATCH][2.6.0-test9] prevent catch-all USB aliases in modules.alias
Date: Mon, 3 Nov 2003 19:45:03 +0300
User-Agent: KMail/1.5.3
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_QYop/TW2/kS9R0c"
Message-Id: <200311031945.04013.arvidjaar@mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_QYop/TW2/kS9R0c
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

visor.c defines one empty slot in USB ids table that can be filled in at 
runtime using module parameters. file2alias generates catch-all alias for it:

alias usb:v*p*dl*dh*dc*dsc*dp*ic*isc*ip* visor

patch adds the same sanity check as in depmod to scripts/file2alias.

regards

-andrey

--Boundary-00=_QYop/TW2/kS9R0c
Content-Type: text/x-diff;
  charset="us-ascii";
  name="2.6.0-test9-file2alias_visor.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="2.6.0-test9-file2alias_visor.patch"

--- ../tmp/linux-2.6.0-test9/scripts/file2alias.c	2003-07-27 22:29:49.000000000 +0400
+++ linux-2.6.0-test9/scripts/file2alias.c	2003-11-03 19:40:47.744746456 +0300
@@ -52,6 +52,13 @@ static int do_usb_entry(const char *file
 	id->bcdDevice_lo = TO_NATIVE(id->bcdDevice_lo);
 	id->bcdDevice_hi = TO_NATIVE(id->bcdDevice_hi);
 
+	/*
+	 * Some modules (visor) have empty slots as placeholder for
+	 * run-time specification that results in catch-all alias
+	 */
+	if (!(id->idVendor | id->bDeviceClass | id->bInterfaceClass))
+		return 1;
+
 	strcpy(alias, "usb:");
 	ADD(alias, "v", id->match_flags&USB_DEVICE_ID_MATCH_VENDOR,
 	    id->idVendor);

--Boundary-00=_QYop/TW2/kS9R0c--

