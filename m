Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261984AbUB2Gep (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Feb 2004 01:34:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261987AbUB2Geo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Feb 2004 01:34:44 -0500
Received: from smtp802.mail.sc5.yahoo.com ([66.163.168.181]:51030 "HELO
	smtp802.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261984AbUB2Gek (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Feb 2004 01:34:40 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Manuel Estrada Sainz <ranty@ranty.pantax.net>
Subject: [PATCH 1/2] Pin firmware module (was Re: [PATCH] request_firmware(): fixes and polishing.)
Date: Sun, 29 Feb 2004 01:32:55 -0500
User-Agent: KMail/1.6
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       jt@hpl.hp.com, Simon Kelley <simon@thekelleys.org.uk>
References: <10776728882704@kroah.com> <200402290130.47960.dtor_core@ameritech.net>
In-Reply-To: <200402290130.47960.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200402290132.57431.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

===================================================================


ChangeSet@1.1694, 2004-02-29 00:06:09-05:00, dtor_core@ameritech.net
  Firmware loader:
    We need to pin the firmware loader module until the last reference
    to the firmware class device is dropped and the class device is
    destroyed.


 firmware_class.c |    6 ++++++
 1 files changed, 6 insertions(+)


===================================================================



diff -Nru a/drivers/base/firmware_class.c b/drivers/base/firmware_class.c
--- a/drivers/base/firmware_class.c	Sun Feb 29 01:20:57 2004
+++ b/drivers/base/firmware_class.c	Sun Feb 29 01:20:57 2004
@@ -263,6 +263,8 @@
 
 	kfree(fw_priv);
 	kfree(class_dev);
+
+	module_put(THIS_MODULE);
 }
 
 static void
@@ -325,6 +327,7 @@
 	kfree(class_dev);
 	return retval;
 }
+
 static int
 fw_setup_class_device(struct firmware *fw, struct class_device **class_dev_p,
 		      const char *fw_name, struct device *device)
@@ -337,6 +340,9 @@
 	retval = fw_register_class_device(&class_dev, fw_name, device);
 	if (retval)
 		goto out;
+
+	/* Need to pin this module until class device is destroyed */
+	__module_get(THIS_MODULE);
 
 	fw_priv = class_get_devdata(class_dev);
 
