Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750749AbWJJNhP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750749AbWJJNhP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 09:37:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750756AbWJJNhP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 09:37:15 -0400
Received: from havoc.gtf.org ([69.61.125.42]:29078 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S1750749AbWJJNhN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 09:37:13 -0400
Date: Tue, 10 Oct 2006 09:37:11 -0400
From: Jeff Garzik <jeff@garzik.org>
To: dmitry.torokhov@gmail.com, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] input: handle sysfs errors
Message-ID: <20061010133710.GA10299@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Signed-off-by: Jeff Garzik <jeff@garzik.org>

---

 drivers/input/evdev.c    |   14 +++++++++++---
 drivers/input/joydev.c   |   13 ++++++++++---
 drivers/input/mousedev.c |   16 +++++++++++++---
 drivers/input/tsdev.c    |   14 +++++++++++---
 4 files changed, 45 insertions(+), 12 deletions(-)

diff --git a/drivers/input/evdev.c b/drivers/input/evdev.c
index 6439f37..f35051b 100644
--- a/drivers/input/evdev.c
+++ b/drivers/input/evdev.c
@@ -621,7 +621,7 @@ static struct input_handle *evdev_connec
 {
 	struct evdev *evdev;
 	struct class_device *cdev;
-	int minor;
+	int minor, rc;
 
 	for (minor = 0; minor < EVDEV_MINORS && evdev_table[minor]; minor++);
 	if (minor == EVDEV_MINORS) {
@@ -650,10 +650,18 @@ static struct input_handle *evdev_connec
 			dev->cdev.dev, evdev->name);
 
 	/* temporary symlink to keep userspace happy */
-	sysfs_create_link(&input_class.subsys.kset.kobj, &cdev->kobj,
-			  evdev->name);
+	rc = sysfs_create_link(&input_class.subsys.kset.kobj, &cdev->kobj,
+			       evdev->name);
+	if (rc)
+		goto err_out;
 
 	return &evdev->handle;
+
+err_out:
+	class_device_destroy(&input_class,
+			MKDEV(INPUT_MAJOR, EVDEV_MINOR_BASE + evdev->minor));
+	evdev_free(evdev);
+	return NULL;
 }
 
 static void evdev_disconnect(struct input_handle *handle)
diff --git a/drivers/input/joydev.c b/drivers/input/joydev.c
index 9f3529a..5260632 100644
--- a/drivers/input/joydev.c
+++ b/drivers/input/joydev.c
@@ -470,7 +470,7 @@ static struct input_handle *joydev_conne
 {
 	struct joydev *joydev;
 	struct class_device *cdev;
-	int i, j, t, minor;
+	int i, j, t, minor, rc;
 
 	for (minor = 0; minor < JOYDEV_MINORS && joydev_table[minor]; minor++);
 	if (minor == JOYDEV_MINORS) {
@@ -539,10 +539,17 @@ static struct input_handle *joydev_conne
 			dev->cdev.dev, joydev->name);
 
 	/* temporary symlink to keep userspace happy */
-	sysfs_create_link(&input_class.subsys.kset.kobj, &cdev->kobj,
-			  joydev->name);
+	rc = sysfs_create_link(&input_class.subsys.kset.kobj, &cdev->kobj,
+			       joydev->name);
+	if (rc)
+		goto err_out;
 
 	return &joydev->handle;
+
+err_out:
+	class_device_destroy(&input_class, MKDEV(INPUT_MAJOR, JOYDEV_MINOR_BASE + joydev->minor));
+	joydev_free(joydev);
+	return NULL;
 }
 
 static void joydev_disconnect(struct input_handle *handle)
diff --git a/drivers/input/mousedev.c b/drivers/input/mousedev.c
index a22a74a..77e8596 100644
--- a/drivers/input/mousedev.c
+++ b/drivers/input/mousedev.c
@@ -629,7 +629,7 @@ static struct input_handle *mousedev_con
 {
 	struct mousedev *mousedev;
 	struct class_device *cdev;
-	int minor = 0;
+	int minor = 0, rc;
 
 	for (minor = 0; minor < MOUSEDEV_MINORS && mousedev_table[minor]; minor++);
 	if (minor == MOUSEDEV_MINORS) {
@@ -661,10 +661,20 @@ static struct input_handle *mousedev_con
 			dev->cdev.dev, mousedev->name);
 
 	/* temporary symlink to keep userspace happy */
-	sysfs_create_link(&input_class.subsys.kset.kobj, &cdev->kobj,
-			  mousedev->name);
+	rc = sysfs_create_link(&input_class.subsys.kset.kobj, &cdev->kobj,
+			       mousedev->name);
+	if (rc)
+		goto err_out;
 
 	return &mousedev->handle;
+
+err_out:
+	class_device_destroy(&input_class,
+			MKDEV(INPUT_MAJOR, MOUSEDEV_MINOR_BASE + mousedev->minor));
+	if (mousedev_mix.open)
+		input_close_device(&mousedev->handle);
+	mousedev_free(mousedev);
+	return NULL;
 }
 
 static void mousedev_disconnect(struct input_handle *handle)
diff --git a/drivers/input/tsdev.c b/drivers/input/tsdev.c
index a730c46..49e34ce 100644
--- a/drivers/input/tsdev.c
+++ b/drivers/input/tsdev.c
@@ -372,7 +372,7 @@ static struct input_handle *tsdev_connec
 {
 	struct tsdev *tsdev;
 	struct class_device *cdev;
-	int minor, delta;
+	int minor, delta, rc;
 
 	for (minor = 0; minor < TSDEV_MINORS / 2 && tsdev_table[minor]; minor++);
 	if (minor >= TSDEV_MINORS / 2) {
@@ -416,10 +416,18 @@ static struct input_handle *tsdev_connec
 			dev->cdev.dev, tsdev->name);
 
 	/* temporary symlink to keep userspace happy */
-	sysfs_create_link(&input_class.subsys.kset.kobj, &cdev->kobj,
-			  tsdev->name);
+	rc = sysfs_create_link(&input_class.subsys.kset.kobj, &cdev->kobj,
+			       tsdev->name);
+	if (rc)
+		goto err_out;
 
 	return &tsdev->handle;
+
+err_out:
+	class_device_destroy(&input_class,
+			MKDEV(INPUT_MAJOR, TSDEV_MINOR_BASE + tsdev->minor));
+	tsdev_free(tsdev);
+	return NULL;
 }
 
 static void tsdev_disconnect(struct input_handle *handle)
