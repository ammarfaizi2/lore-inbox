Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266548AbUG0Sah@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266548AbUG0Sah (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jul 2004 14:30:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266545AbUG0Sag
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jul 2004 14:30:36 -0400
Received: from mx1.redhat.com ([66.187.233.31]:44010 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266549AbUG0SaP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jul 2004 14:30:15 -0400
Date: Tue, 27 Jul 2004 11:30:08 -0700
From: Pete Zaitcev <zaitcev@redhat.com>
To: <marcelo.tosatti@cyclades.com>
Cc: zaitcev@redhat.com, linux-kernel@vger.kernel.org
Subject: USB: GET_ID from nonzero interface
Message-Id: <20040727113008.57ae918a@lembas.zaitcev.lan>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed version 0.9.11claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Synopsys: Fix GET_ID for nonzero interface. IIRC, it's HP-1300 combo.

The patch looks bizzare, but it is actually correct and the code is
not too bad. The 2.6 patch from errandir_news@mph.eclipse.co.uk, this
is a backport.

I must admit I didn't hear from anyone using the stock 2.4
having this problem, but I had a couple of users on RHL.

diff -urp -X dontdiff linux-2.4.27-rc3/drivers/usb/printer.c linux-2.4.27-rc3-usbx/drivers/usb/printer.c
--- linux-2.4.27-rc3/drivers/usb/printer.c	2004-07-25 23:00:17.000000000 -0700
+++ linux-2.4.27-rc3-usbx/drivers/usb/printer.c	2004-07-27 10:28:53.000000000 -0700
@@ -1,9 +1,9 @@
 /*
- * printer.c  Version 0.11
+ * printer.c  Version 0.13
  *
  * Copyright (c) 1999 Michael Gee	<michael@linuxspecific.com>
  * Copyright (c) 1999 Pavel Machek	<pavel@suse.cz>
- * Copyright (c) 2000 Randy Dunlap	<randy.dunlap@intel.com>
+ * Copyright (c) 2000 Randy Dunlap	<rddunlap@osdl.org>
  * Copyright (c) 2000 Vojtech Pavlik	<vojtech@suse.cz>
  # Copyright (c) 2001 Pete Zaitcev	<zaitcev@redhat.com>
  # Copyright (c) 2001 David Paschal	<paschal@rcsis.com>
@@ -230,11 +230,21 @@ static DECLARE_MUTEX(usblp_sem);	/* lock
 
 static int usblp_ctrl_msg(struct usblp *usblp, int request, int type, int dir, int recip, int value, void *buf, int len)
 {
-	int retval = usb_control_msg(usblp->dev,
+	int retval;
+	int index = usblp->ifnum;
+
+	/* High byte has the interface index.
+	   Low byte has the alternate setting.
+	 */
+	if ((request == USBLP_REQ_GET_ID) && (type == USB_TYPE_CLASS)) {
+	  index = (usblp->ifnum<<8)|usblp->protocol[usblp->current_protocol].alt_setting;
+	}
+
+	retval = usb_control_msg(usblp->dev,
 		dir ? usb_rcvctrlpipe(usblp->dev, 0) : usb_sndctrlpipe(usblp->dev, 0),
-		request, type | dir | recip, value, usblp->ifnum, buf, len, USBLP_WRITE_TIMEOUT);
-	dbg("usblp_control_msg: rq: 0x%02x dir: %d recip: %d value: %d len: %#x result: %d",
-		request, !!dir, recip, value, len, retval);
+		request, type | dir | recip, value, index, buf, len, USBLP_WRITE_TIMEOUT);
+	dbg("usblp_control_msg: rq: 0x%02x dir: %d recip: %d value: %d idx: %d len: %#x result: %d",
+		request, !!dir, recip, value, index, len, retval);
 	return retval < 0 ? retval : 0;
 }
 
