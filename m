Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261991AbUB2GgY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Feb 2004 01:36:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261990AbUB2Gev
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Feb 2004 01:34:51 -0500
Received: from smtp800.mail.sc5.yahoo.com ([66.163.168.179]:64911 "HELO
	smtp800.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261983AbUB2Gem (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Feb 2004 01:34:42 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Manuel Estrada Sainz <ranty@ranty.pantax.net>
Subject: [PATCH 2/2] Delay firmware hotplug event (was Re: [PATCH] request_firmware(): fixes and polishing.)
Date: Sun, 29 Feb 2004 01:34:22 -0500
User-Agent: KMail/1.6
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       jt@hpl.hp.com, Simon Kelley <simon@thekelleys.org.uk>
References: <10776728882704@kroah.com> <200402290130.47960.dtor_core@ameritech.net> <200402290132.57431.dtor_core@ameritech.net>
In-Reply-To: <200402290132.57431.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200402290134.24580.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


===================================================================


ChangeSet@1.1695, 2004-02-29 00:27:53-05:00, dtor_core@ameritech.net
  Firmware loader:
    Do not call hotplug until firmware class device is completely
    instantiated.


 firmware_class.c |    6 ++++++
 1 files changed, 6 insertions(+)


===================================================================



diff -Nru a/drivers/base/firmware_class.c b/drivers/base/firmware_class.c
--- a/drivers/base/firmware_class.c	Sun Feb 29 01:21:18 2004
+++ b/drivers/base/firmware_class.c	Sun Feb 29 01:21:18 2004
@@ -27,6 +27,7 @@
 	FW_STATUS_LOADING,
 	FW_STATUS_DONE,
 	FW_STATUS_ABORT,
+	FW_STATUS_READY,
 };
 
 static int loading_timeout = 10;	/* In seconds */
@@ -96,6 +97,9 @@
 	int i = 0;
 	char *scratch = buffer;
 
+        if (!test_bit(FW_STATUS_READY, &fw_priv->status))
+                return -ENODEV;
+
 	if (buffer_size < (FIRMWARE_NAME_MAX + 10))
 		return -ENOMEM;
 	if (num_envp < 1)
@@ -362,6 +366,7 @@
 		goto error_unreg;
 	}
 
+	set_bit(FW_STATUS_READY, &fw_priv->status);
 	*class_dev_p = class_dev;
 	goto out;
 
@@ -415,6 +420,7 @@
 		add_timer(&fw_priv->timeout);
 	}
 
+	kobject_hotplug("add", &class_dev->kobj);
 	wait_for_completion(&fw_priv->completion);
 	set_bit(FW_STATUS_DONE, &fw_priv->status);
 
