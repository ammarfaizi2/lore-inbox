Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264697AbUF1FbP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264697AbUF1FbP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jun 2004 01:31:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264692AbUF1F2v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jun 2004 01:28:51 -0400
Received: from smtp811.mail.sc5.yahoo.com ([66.163.170.81]:61576 "HELO
	smtp811.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S264665AbUF1FRH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jun 2004 01:17:07 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Vojtech Pavlik <vojtech@suse.cz>
Subject: PATCH 9/19] serio manual bind
Date: Mon, 28 Jun 2004 00:17:03 -0500
User-Agent: KMail/1.6.2
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <200406280008.21465.dtor_core@ameritech.net> <200406280015.38752.dtor_core@ameritech.net> <200406280016.29032.dtor_core@ameritech.net>
In-Reply-To: <200406280016.29032.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200406280017.05202.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


===================================================================


ChangeSet@1.1783, 2004-06-27 15:56:35-05:00, dtor_core@ameritech.net
  Input: allow marking some drivers (that don't do HW autodetection)
         as manual bind only. Such drivers will only be bound to a
         serio port if user requests it by echoing driver name into
         port's sysfs driver attribute.
  
  Signed-off-by: Dmitry Torokhov <dtor@mail.ru>


 drivers/input/serio/serio.c |    9 +++++++--
 include/linux/serio.h       |    2 ++
 2 files changed, 9 insertions(+), 2 deletions(-)


===================================================================



diff -Nru a/drivers/input/serio/serio.c b/drivers/input/serio/serio.c
--- a/drivers/input/serio/serio.c	2004-06-27 17:49:39 -05:00
+++ b/drivers/input/serio/serio.c	2004-06-27 17:49:39 -05:00
@@ -92,8 +92,9 @@
 	struct serio_driver *drv;
 
 	list_for_each_entry(drv, &serio_driver_list, node)
-		if (serio_bind_driver(serio, drv))
-			break;
+		if (!drv->manual_bind)
+			if (serio_bind_driver(serio, drv))
+				break;
 }
 
 /*
@@ -502,6 +503,9 @@
 	driver_register(&drv->driver);
 	driver_create_file(&drv->driver, &driver_attr_description);
 
+	if (drv->manual_bind)
+		goto out;
+
 start_over:
 	list_for_each_entry(serio, &serio_list, node) {
 		if (!serio->drv) {
@@ -515,6 +519,7 @@
 		}
 	}
 
+out:
 	up(&serio_sem);
 }
 
diff -Nru a/include/linux/serio.h b/include/linux/serio.h
--- a/include/linux/serio.h	2004-06-27 17:49:39 -05:00
+++ b/include/linux/serio.h	2004-06-27 17:49:39 -05:00
@@ -55,6 +55,8 @@
 	void *private;
 	char *description;
 
+	int manual_bind;
+
 	void (*write_wakeup)(struct serio *);
 	irqreturn_t (*interrupt)(struct serio *, unsigned char,
 			unsigned int, struct pt_regs *);
