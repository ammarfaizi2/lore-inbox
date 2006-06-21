Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030260AbWFUTux@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030260AbWFUTux (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 15:50:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030245AbWFUTuR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 15:50:17 -0400
Received: from ns.suse.de ([195.135.220.2]:13489 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1030240AbWFUTt1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 15:49:27 -0400
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Cc: Hansjoerg Lipp <hjlipp@web.de>, Tilman Schmidt <tilman@imap.cc>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 6/22] [PATCH] i4l gigaset: move sysfs entry to tty class device
Reply-To: Greg KH <greg@kroah.com>
Date: Wed, 21 Jun 2006 12:45:49 -0700
Message-Id: <11509191812079-git-send-email-greg@kroah.com>
X-Mailer: git-send-email 1.4.0
In-Reply-To: <11509191781796-git-send-email-greg@kroah.com>
References: <20060621194511.GA23982@kroah.com> <11509191652021-git-send-email-greg@kroah.com> <11509191682051-git-send-email-greg@kroah.com> <11509191721672-git-send-email-greg@kroah.com> <1150919175882-git-send-email-greg@kroah.com> <11509191781796-git-send-email-greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hansjoerg Lipp <hjlipp@web.de>

Using the class device pointer returned by tty_register_device() with
part 1 of the patch, attach the Gigaset drivers' "cidmode" sysfs entry
to its tty class device, where it can be found more easily by users
who do not know nor care which USB port the device is attached to.

Signed-off-by: Hansjoerg Lipp <hjlipp@web.de>
Signed-off-by: Tilman Schmidt <tilman@imap.cc>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 Documentation/isdn/README.gigaset |    7 ++++---
 drivers/isdn/gigaset/common.c     |   13 +++++++------
 drivers/isdn/gigaset/gigaset.h    |    1 +
 drivers/isdn/gigaset/interface.c  |   10 +++++++++-
 drivers/isdn/gigaset/proc.c       |   21 +++++++++++++--------
 5 files changed, 34 insertions(+), 18 deletions(-)

diff --git a/Documentation/isdn/README.gigaset b/Documentation/isdn/README.gigaset
index 85a64de..fa0d4cc 100644
--- a/Documentation/isdn/README.gigaset
+++ b/Documentation/isdn/README.gigaset
@@ -124,7 +124,8 @@ GigaSet 307x Device Driver
 
      You can use some configuration tool of your distribution to configure this
      "modem" or configure pppd/wvdial manually. There are some example ppp
-     configuration files and chat scripts in the gigaset-VERSION/ppp directory.
+     configuration files and chat scripts in the gigaset-VERSION/ppp directory
+     in the driver packages from http://sourceforge.net/projects/gigaset307x/.
      Please note that the USB drivers are not able to change the state of the
      control lines (the M105 driver can be configured to use some undocumented
      control requests, if you really need the control lines, though). This means
@@ -164,8 +165,8 @@ GigaSet 307x Device Driver
 
      If you want both of these at once, you are out of luck.
 
-     You can also use /sys/module/<name>/parameters/cidmode for changing
-     the CID mode setting (<name> is usb_gigaset or bas_gigaset).
+     You can also use /sys/class/tty/ttyGxy/cidmode for changing the CID mode
+     setting (ttyGxy is ttyGU0 or ttyGB0).
 
 
 3.   Troubleshooting
diff --git a/drivers/isdn/gigaset/common.c b/drivers/isdn/gigaset/common.c
index e55767b..acb7e26 100644
--- a/drivers/isdn/gigaset/common.c
+++ b/drivers/isdn/gigaset/common.c
@@ -460,6 +460,9 @@ void gigaset_freecs(struct cardstate *cs
 
 	switch (cs->cs_init) {
 	default:
+		/* clear device sysfs */
+		gigaset_free_dev_sysfs(cs);
+
 		gigaset_if_free(cs);
 
 		gig_dbg(DEBUG_INIT, "clearing hw");
@@ -699,6 +702,7 @@ struct cardstate *gigaset_initcs(struct 
 	cs->open_count = 0;
 	cs->dev = NULL;
 	cs->tty = NULL;
+	cs->class = NULL;
 	cs->cidmode = cidmode != 0;
 
 	//if(onechannel) { //FIXME
@@ -760,6 +764,9 @@ struct cardstate *gigaset_initcs(struct 
 
 	gigaset_if_init(cs);
 
+	/* set up device sysfs */
+	gigaset_init_dev_sysfs(cs);
+
 	spin_lock_irqsave(&cs->lock, flags);
 	cs->running = 1;
 	spin_unlock_irqrestore(&cs->lock, flags);
@@ -902,9 +909,6 @@ int gigaset_start(struct cardstate *cs)
 
 	wait_event(cs->waitqueue, !cs->waiting);
 
-	/* set up device sysfs */
-	gigaset_init_dev_sysfs(cs);
-
 	mutex_unlock(&cs->mutex);
 	return 1;
 
@@ -969,9 +973,6 @@ void gigaset_stop(struct cardstate *cs)
 		//FIXME
 	}
 
-	/* clear device sysfs */
-	gigaset_free_dev_sysfs(cs);
-
 	cleanup_cs(cs);
 
 exit:
diff --git a/drivers/isdn/gigaset/gigaset.h b/drivers/isdn/gigaset/gigaset.h
index 22b9693..8d63d82 100644
--- a/drivers/isdn/gigaset/gigaset.h
+++ b/drivers/isdn/gigaset/gigaset.h
@@ -445,6 +445,7 @@ struct cardstate {
 	struct gigaset_driver *driver;
 	unsigned minor_index;
 	struct device *dev;
+	struct class_device *class;
 
 	const struct gigaset_ops *ops;
 
diff --git a/drivers/isdn/gigaset/interface.c b/drivers/isdn/gigaset/interface.c
index 08e4c4e..74fd234 100644
--- a/drivers/isdn/gigaset/interface.c
+++ b/drivers/isdn/gigaset/interface.c
@@ -625,7 +625,14 @@ void gigaset_if_init(struct cardstate *c
 		return;
 
 	tasklet_init(&cs->if_wake_tasklet, &if_wake, (unsigned long) cs);
-	tty_register_device(drv->tty, cs->minor_index, NULL);
+	cs->class = tty_register_device(drv->tty, cs->minor_index, NULL);
+
+	if (!IS_ERR(cs->class))
+		class_set_devdata(cs->class, cs);
+	else {
+		warn("could not register device to the tty subsystem");
+		cs->class = NULL;
+	}
 }
 
 void gigaset_if_free(struct cardstate *cs)
@@ -638,6 +645,7 @@ void gigaset_if_free(struct cardstate *c
 
 	tasklet_disable(&cs->if_wake_tasklet);
 	tasklet_kill(&cs->if_wake_tasklet);
+	cs->class = NULL;
 	tty_unregister_device(drv->tty, cs->minor_index);
 }
 
diff --git a/drivers/isdn/gigaset/proc.c b/drivers/isdn/gigaset/proc.c
index d267a63..9ae3a7f 100644
--- a/drivers/isdn/gigaset/proc.c
+++ b/drivers/isdn/gigaset/proc.c
@@ -16,12 +16,11 @@
 #include "gigaset.h"
 #include <linux/ctype.h>
 
-static ssize_t show_cidmode(struct device *dev, struct device_attribute *attr,
-			    char *buf)
+static ssize_t show_cidmode(struct class_device *class, char *buf)
 {
 	int ret;
 	unsigned long flags;
-	struct cardstate *cs = dev_get_drvdata(dev);
+	struct cardstate *cs = class_get_devdata(class);
 
 	spin_lock_irqsave(&cs->lock, flags);
 	ret = sprintf(buf, "%u\n", cs->cidmode);
@@ -30,10 +29,10 @@ static ssize_t show_cidmode(struct devic
 	return ret;
 }
 
-static ssize_t set_cidmode(struct device *dev, struct device_attribute *attr,
+static ssize_t set_cidmode(struct class_device *class,
 			   const char *buf, size_t count)
 {
-	struct cardstate *cs = dev_get_drvdata(dev);
+	struct cardstate *cs = class_get_devdata(class);
 	long int value;
 	char *end;
 
@@ -65,18 +64,24 @@ static ssize_t set_cidmode(struct device
 	return count;
 }
 
-static DEVICE_ATTR(cidmode, S_IRUGO|S_IWUSR, show_cidmode, set_cidmode);
+static CLASS_DEVICE_ATTR(cidmode, S_IRUGO|S_IWUSR, show_cidmode, set_cidmode);
 
 /* free sysfs for device */
 void gigaset_free_dev_sysfs(struct cardstate *cs)
 {
+	if (!cs->class)
+		return;
+
 	gig_dbg(DEBUG_INIT, "removing sysfs entries");
-	device_remove_file(cs->dev, &dev_attr_cidmode);
+	class_device_remove_file(cs->class, &class_device_attr_cidmode);
 }
 
 /* initialize sysfs for device */
 void gigaset_init_dev_sysfs(struct cardstate *cs)
 {
+	if (!cs->class)
+		return;
+
 	gig_dbg(DEBUG_INIT, "setting up sysfs");
-	device_create_file(cs->dev, &dev_attr_cidmode);
+	class_device_create_file(cs->class, &class_device_attr_cidmode);
 }
-- 
1.4.0

