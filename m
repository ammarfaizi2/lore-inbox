Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265057AbUFRJCf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265057AbUFRJCf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jun 2004 05:02:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265063AbUFRJB6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jun 2004 05:01:58 -0400
Received: from smtp801.mail.sc5.yahoo.com ([66.163.168.180]:46421 "HELO
	smtp801.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S265057AbUFRIpC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jun 2004 04:45:02 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 10/11] serio manual bind
Date: Fri, 18 Jun 2004 03:43:11 -0500
User-Agent: KMail/1.6.2
Cc: Andrew Morton <akpm@osdl.org>, Vojtech Pavlik <vojtech@suse.cz>,
       vojtech@ucw.cz
References: <200406180335.52843.dtor_core@ameritech.net> <200406180342.11056.dtor_core@ameritech.net> <200406180342.41100.dtor_core@ameritech.net>
In-Reply-To: <200406180342.41100.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200406180343.13077.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


===================================================================


ChangeSet@1.1799, 2004-06-18 02:59:36-05:00, dtor_core@ameritech.net
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
--- a/drivers/input/serio/serio.c	2004-06-18 03:18:00 -05:00
+++ b/drivers/input/serio/serio.c	2004-06-18 03:18:00 -05:00
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
@@ -498,6 +499,9 @@
 	driver_register(&drv->driver);
 	driver_create_file(&drv->driver, &driver_attr_description);
 
+	if (drv->manual_bind)
+		goto out;
+
 start_over:
 	list_for_each_entry(serio, &serio_list, node) {
 		if (!serio->drv) {
@@ -511,6 +515,7 @@
 		}
 	}
 
+out:
 	up(&serio_sem);
 }
 
diff -Nru a/include/linux/serio.h b/include/linux/serio.h
--- a/include/linux/serio.h	2004-06-18 03:18:00 -05:00
+++ b/include/linux/serio.h	2004-06-18 03:18:00 -05:00
@@ -55,6 +55,8 @@
 	void *private;
 	char *description;
 
+	int manual_bind;
+
 	void (*write_wakeup)(struct serio *);
 	irqreturn_t (*interrupt)(struct serio *, unsigned char,
 			unsigned int, struct pt_regs *);
