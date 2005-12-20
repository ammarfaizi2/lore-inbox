Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932185AbVLTWP3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932185AbVLTWP3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Dec 2005 17:15:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932190AbVLTWP3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Dec 2005 17:15:29 -0500
Received: from mx1.redhat.com ([66.187.233.31]:60627 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932185AbVLTWP2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Dec 2005 17:15:28 -0500
Date: Tue, 20 Dec 2005 14:15:04 -0800
From: Pete Zaitcev <zaitcev@redhat.com>
To: greg@kroah.com
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net,
       zaitcev@redhat.com
Subject: usb: replace __setup("nousb") with __module_param_call
Message-Id: <20051220141504.31441a41.zaitcev@redhat.com>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.8.8; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fedora users complain that passing "nousbstorage" to the installer causes
the rest of the USB support to disappear. The installer uses kernel command
line as a way to pass options through Syslinux. The problem stems from the
use of strncmp() in obsolete_checksetup().

I used __module_param_call() instead of module_param because I wanted to
preserve the old syntax in grub.conf, and it's the only macro which allows
to remove the prefix.

The fix is tested to accept the option "nousb" correctly now.

Signed-off-by: Pete Zaitcev <zaitcev@redhat.com>

---

--- linux-2.6.14/drivers/usb/core/usb.c	2005-10-28 19:12:01.000000000 -0700
+++ linux-2.6.14-lem/drivers/usb/core/usb.c	2005-12-20 10:53:21.000000000 -0800
@@ -54,7 +54,6 @@
 const char *usbcore_name = "usbcore";
 
 static int nousb;	/* Disable USB when built into kernel image */
-			/* Not honored on modular build */
 
 static DECLARE_RWSEM(usb_all_devices_rwsem);
 
@@ -1455,18 +1454,8 @@
 	.resume =	usb_generic_resume,
 };
 
-#ifndef MODULE
-
-static int __init usb_setup_disable(char *str)
-{
-	nousb = 1;
-	return 1;
-}
-
 /* format to disable USB on kernel command line is: nousb */
-__setup("nousb", usb_setup_disable);
-
-#endif
+__module_param_call("", nousb, param_set_bool, param_get_bool, &nousb, 0444);
 
 /*
  * for external read access to <nousb>
