Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263713AbTCVRac>; Sat, 22 Mar 2003 12:30:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263710AbTCVRaI>; Sat, 22 Mar 2003 12:30:08 -0500
Received: from verein.lst.de ([212.34.181.86]:23046 "EHLO verein.lst.de")
	by vger.kernel.org with ESMTP id <S263646AbTCVR31>;
	Sat, 22 Mar 2003 12:29:27 -0500
Date: Sat, 22 Mar 2003 18:40:29 +0100
From: Christoph Hellwig <hch@lst.de>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] cleanup input_register_minor
Message-ID: <20030322184029.F21623@lst.de>
Mail-Followup-To: Christoph Hellwig <hch@lst.de>, torvalds@transmeta.com,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Always pass the input/ prefix to input_register_minor instead of using
the first argument to devfs_register


diff -Nru a/drivers/input/evdev.c b/drivers/input/evdev.c
--- a/drivers/input/evdev.c	Sat Mar 22 17:03:17 2003
+++ b/drivers/input/evdev.c	Sat Mar 22 17:03:17 2003
@@ -397,7 +397,7 @@
 	sprintf(evdev->name, "event%d", minor);
 
 	evdev_table[minor] = evdev;
-	evdev->devfs = input_register_minor("event%d", minor, EVDEV_MINOR_BASE);
+	evdev->devfs = input_register_minor("input/event%d", minor, EVDEV_MINOR_BASE);
 
 	return &evdev->handle;
 }
diff -Nru a/drivers/input/input.c b/drivers/input/input.c
--- a/drivers/input/input.c	Sat Mar 22 17:03:17 2003
+++ b/drivers/input/input.c	Sat Mar 22 17:03:17 2003
@@ -546,8 +546,11 @@
 {
 	char devfs_name[16];
 	sprintf(devfs_name, name, minor);
-	return devfs_register(input_devfs_handle, devfs_name, DEVFS_FL_DEFAULT, INPUT_MAJOR, minor + minor_base,
-		S_IFCHR | S_IRUGO | S_IWUSR, &input_fops, NULL);
+
+	return devfs_register(NULL, devfs_name, 0,
+			INPUT_MAJOR, minor + minor_base,
+			S_IFCHR|S_IRUGO|S_IWUSR,
+			&input_fops, NULL);
 }
 
 void input_unregister_minor(devfs_handle_t handle)
diff -Nru a/drivers/input/mousedev.c b/drivers/input/mousedev.c
--- a/drivers/input/mousedev.c	Sat Mar 22 17:03:17 2003
+++ b/drivers/input/mousedev.c	Sat Mar 22 17:03:17 2003
@@ -425,7 +425,7 @@
 		input_open_device(&mousedev->handle);
 
 	mousedev_table[minor] = mousedev;
-	mousedev->devfs = input_register_minor("mouse%d", minor, MOUSEDEV_MINOR_BASE);
+	mousedev->devfs = input_register_minor("input/mouse%d", minor, MOUSEDEV_MINOR_BASE);
 
 	return &mousedev->handle;
 }
@@ -507,7 +507,7 @@
 	mousedev_table[MOUSEDEV_MIX] = &mousedev_mix;
 	mousedev_mix.exist = 1;
 	mousedev_mix.minor = MOUSEDEV_MIX;
-	mousedev_mix.devfs = input_register_minor("mice", MOUSEDEV_MIX, MOUSEDEV_MINOR_BASE);
+	mousedev_mix.devfs = input_register_minor("input/mice", MOUSEDEV_MIX, MOUSEDEV_MINOR_BASE);
 
 #ifdef CONFIG_INPUT_MOUSEDEV_PSAUX
 	if (!(mousedev_mix.misc = !misc_register(&psaux_mouse)))
diff -Nru a/drivers/input/tsdev.c b/drivers/input/tsdev.c
--- a/drivers/input/tsdev.c	Sat Mar 22 17:03:17 2003
+++ b/drivers/input/tsdev.c	Sat Mar 22 17:03:17 2003
@@ -326,7 +326,7 @@
 
 	tsdev_table[minor] = tsdev;
 	tsdev->devfs =
-	    input_register_minor("ts%d", minor, TSDEV_MINOR_BASE);
+	    input_register_minor("input/ts%d", minor, TSDEV_MINOR_BASE);
 
 
 	return &tsdev->handle;
