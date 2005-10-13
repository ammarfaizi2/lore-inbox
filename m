Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932542AbVJMXiS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932542AbVJMXiS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Oct 2005 19:38:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932543AbVJMXiS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Oct 2005 19:38:18 -0400
Received: from soundwarez.org ([217.160.171.123]:11192 "EHLO soundwarez.org")
	by vger.kernel.org with ESMTP id S932542AbVJMXiR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Oct 2005 19:38:17 -0400
Date: Fri, 14 Oct 2005 01:38:15 +0200
From: Kay Sievers <kay.sievers@vrfy.org>
To: Greg KH <gregkh@suse.de>
Cc: Dmitry Torokhov <dtor_core@ameritech.net>,
       Vojtech Pavlik <vojtech@suse.cz>, Hannes Reinecke <hare@suse.de>,
       Patrick Mochel <mochel@digitalimplant.org>, airlied@linux.ie,
       linux-kernel@vger.kernel.org
Subject: Re: [patch 0/8] Nesting class_device patches that actually work
Message-ID: <20051013233815.GA15968@vrfy.org>
References: <20051013020844.GA31732@kroah.com> <20051013021001.GA31737@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051013021001.GA31737@kroah.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 12, 2005 at 07:10:01PM -0700, Greg KH wrote:
> On Wed, Oct 12, 2005 at 07:08:44PM -0700, Greg KH wrote:
> > Ok, finally.  Here's a set of _working_ patches that properly implement
> > nesting class_device structures, and the follow-on patches to move the
> > input subsystem to use them.  Hotplug and release functions work
> > properly now, and this will let us move /sys/block/ to use class and
> > class_device structures soon.
> 
> Oh, Kay, do you have a public patch to udevstart/udev that can handle
> this nested structure?  It might be good to have that so people can test
> these in the next -mm.

Sure, here is an still untested hack. Sorry, I'm "busy" at a conference this
week. Anyhow, I still think that we really don't want to nest classes this way. :)

Thanks,
Kay

---
diff --git a/libsysfs/sysfs_class.c b/libsysfs/sysfs_class.c
index edf751b..e95c919 100644
--- a/libsysfs/sysfs_class.c
+++ b/libsysfs/sysfs_class.c
@@ -227,16 +227,46 @@ struct sysfs_class_device *sysfs_get_cla
 	if (clsdev->parent)
 		return (clsdev->parent);
 
-	/*
-	 * As of now, only block devices have a parent child heirarchy in sysfs
-	 * We do not know, if, in the future, more classes will have a similar
-	 * structure. Hence, we now call a specialized function for block and
-	 * later we can add support functions for other subsystems as required.
-	 */
-	if (!(strncmp(clsdev->classname, SYSFS_BLOCK_NAME, 
-					sizeof(SYSFS_BLOCK_NAME)))) {
-		if ((get_blockdev_parent(clsdev)) == 0) 
+	if (!strncmp(clsdev->classname, SYSFS_BLOCK_NAME, sizeof(SYSFS_BLOCK_NAME))) {
+		if ((get_blockdev_parent(clsdev)) == 0)
 			return (clsdev->parent);
+	} else if (!strncmp(clsdev->classname, SYSFS_CLASS_NAME, sizeof(SYSFS_CLASS_NAME))) {
+		char ppath[SYSFS_PATH_MAX];
+		char dpath[SYSFS_PATH_MAX];
+		char *tmp;
+
+		memset(ppath, 0, SYSFS_PATH_MAX);
+		memset(dpath, 0, SYSFS_PATH_MAX);
+		safestrcpy(ppath, clsdev->path);
+		tmp = strrchr(ppath, '/');
+		if (!tmp) {
+			dprintf("Invalid path to device %s\n", ppath);
+			return NULL;
+		}
+		if (*(tmp + 1) == '\0') {
+			*tmp = '\0';
+			tmp = strrchr(tmp, '/');
+			if (tmp == NULL) {
+				dprintf("Invalid path to device %s\n", ppath);
+				return NULL;
+			}
+		}
+		*tmp = '\0';
+
+		/* Make sure we're not at the top of the device tree */
+		sysfs_get_mnt_path(dpath, SYSFS_PATH_MAX);
+		safestrcat(dpath, "/" SYSFS_CLASS_NAME);
+		if (strcmp(dpath, ppath) == 0) {
+			dprintf("Device at %s does not have a parent\n", clsdev->path);
+			return NULL;
+		}
+
+		clsdev->parent = sysfs_open_class_device_path(ppath);
+		if (!clsdev->parent) {
+			dprintf("Error opening device %s's parent at %s\n", clsdev->name, ppath);
+			return NULL;
+		}
+		return (clsdev->parent);
 	}
 	return NULL;
 }
diff --git a/udevstart.c b/udevstart.c
index ce96f38..09f0e5d 100644
--- a/udevstart.c
+++ b/udevstart.c
@@ -79,7 +79,7 @@ static int device_list_insert(const char
 	struct device *new_device;
 	const char *devpath = &path[strlen(sysfs_path)];
 
-	dbg("insert: '%s'\n", devpath);
+	dbg("insert: '%s'", devpath);
 
 	list_for_each_entry(loop_device, device_list, node) {
 		if (strcmp(loop_device->path, devpath) > 0) {
@@ -296,7 +296,6 @@ static void udev_scan_class(struct list_
 		for (dent = readdir(dir); dent != NULL; dent = readdir(dir)) {
 			char dirname[PATH_SIZE];
 			DIR *dir2;
-			struct dirent *dent2;
 
 			if (dent->d_name[0] == '.')
 				continue;
@@ -306,6 +305,9 @@ static void udev_scan_class(struct list_
 
 			dir2 = opendir(dirname);
 			if (dir2 != NULL) {
+				DIR *dir3;
+				struct dirent *dent2;
+
 				for (dent2 = readdir(dir2); dent2 != NULL; dent2 = readdir(dir2)) {
 					char dirname2[PATH_SIZE];
 
@@ -317,6 +319,25 @@ static void udev_scan_class(struct list_
 
 					if (has_devt(dirname2) || strcmp(dent->d_name, "net") == 0)
 						device_list_insert(dirname2, dent->d_name, device_list);
+
+					dir3 = opendir(dirname2);
+					if (dir3 != NULL) {
+						struct dirent *dent3;
+
+						for (dent3 = readdir(dir3); dent3 != NULL; dent3 = readdir(dir3)) {
+							char dirname3[PATH_SIZE];
+
+							if (dent3->d_name[0] == '.')
+								continue;
+
+							snprintf(dirname3, sizeof(dirname3), "%s/%s", dirname2, dent3->d_name);
+							dirname3[sizeof(dirname3)-1] = '\0';
+
+							if (has_devt(dirname3))
+								device_list_insert(dirname3, dent->d_name, device_list);
+						}
+						closedir(dir3);
+					}
 				}
 				closedir(dir2);
 			}

