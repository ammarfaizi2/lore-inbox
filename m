Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265152AbUG2SmZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265152AbUG2SmZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 14:42:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264997AbUG2OoT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 10:44:19 -0400
Received: from styx.suse.cz ([82.119.242.94]:29590 "EHLO shadow.ucw.cz")
	by vger.kernel.org with ESMTP id S265031AbUG2OIN convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 10:08:13 -0400
To: torvalds@osdl.org, vojtech@suse.cz, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=US-ASCII
Subject: [PATCH 39/47] allow marking some drivers as manual bind only
Content-Transfer-Encoding: 7BIT
Date: Thu, 29 Jul 2004 16:09:56 +0200
X-Mailer: gregkh_patchbomb_levon_offspring
In-Reply-To: <10911101963805@twilight.ucw.cz>
From: Vojtech Pavlik <vojtech@suse.cz>
Message-Id: <10911101963350@twilight.ucw.cz>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You can pull this changeset from:
	bk://kernel.bkbits.net/vojtech/input

===================================================================

ChangeSet@1.1757.15.34, 2004-06-29 01:30:19-05:00, dtor_core@ameritech.net
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
--- a/drivers/input/serio/serio.c	Thu Jul 29 14:39:07 2004
+++ b/drivers/input/serio/serio.c	Thu Jul 29 14:39:07 2004
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
@@ -494,6 +495,9 @@
 	driver_register(&drv->driver);
 	driver_create_file(&drv->driver, &driver_attr_description);
 
+	if (drv->manual_bind)
+		goto out;
+
 start_over:
 	list_for_each_entry(serio, &serio_list, node) {
 		if (!serio->drv) {
@@ -507,6 +511,7 @@
 		}
 	}
 
+out:
 	up(&serio_sem);
 }
 
diff -Nru a/include/linux/serio.h b/include/linux/serio.h
--- a/include/linux/serio.h	Thu Jul 29 14:39:07 2004
+++ b/include/linux/serio.h	Thu Jul 29 14:39:07 2004
@@ -55,6 +55,8 @@
 	void *private;
 	char *description;
 
+	int manual_bind;
+
 	void (*write_wakeup)(struct serio *);
 	irqreturn_t (*interrupt)(struct serio *, unsigned char,
 			unsigned int, struct pt_regs *);

