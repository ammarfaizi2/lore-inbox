Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262902AbUAOUoK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jan 2004 15:44:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262796AbUAOUoJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jan 2004 15:44:09 -0500
Received: from mail.kroah.org ([65.200.24.183]:10203 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262686AbUAOUoC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jan 2004 15:44:02 -0500
Date: Thu, 15 Jan 2004 12:42:59 -0800
From: Greg KH <greg@kroah.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-hotplug-devel@lists.sourceforge.net
Subject: [PATCH] add sysfs class support for OSS sound devices [07/10]
Message-ID: <20040115204259.GH22199@kroah.com>
References: <20040115204048.GA22199@kroah.com> <20040115204111.GB22199@kroah.com> <20040115204125.GC22199@kroah.com> <20040115204138.GD22199@kroah.com> <20040115204153.GE22199@kroah.com> <20040115204209.GF22199@kroah.com> <20040115204241.GG22199@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040115204241.GG22199@kroah.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch adds support for all OSS sound devices.

This patch is based on a work originally written by 
Leann Ogasawara <ogasawara@osdl.org>



diff -Nru a/sound/oss/soundcard.c b/sound/oss/soundcard.c
--- a/sound/oss/soundcard.c	Thu Jan 15 11:06:01 2004
+++ b/sound/oss/soundcard.c	Thu Jan 15 11:06:01 2004
@@ -73,6 +73,7 @@
 
 
 unsigned long seq_time = 0;	/* Time for /dev/sequencer */
+extern struct class_simple *sound_class;
 
 /*
  * Table for configurable mixer volume handling
@@ -569,6 +570,9 @@
 		devfs_mk_cdev(MKDEV(SOUND_MAJOR, dev_list[i].minor),
 				S_IFCHR | dev_list[i].mode,
 				"sound/%s", dev_list[i].name);
+		class_simple_device_add(sound_class, 
+					MKDEV(SOUND_MAJOR, dev_list[i].minor),
+					NULL, "%s", dev_list[i].name);
 
 		if (!dev_list[i].num)
 			continue;
@@ -578,6 +582,10 @@
 						dev_list[i].minor + (j*0x10)),
 					S_IFCHR | dev_list[i].mode,
 					"sound/%s%d", dev_list[i].name, j);
+			class_simple_device_add(sound_class,
+					MKDEV(SOUND_MAJOR, dev_list[i].minor + (j*0x10)),
+					NULL,
+					"%s%d", dev_list[i].name, j);
 		}
 	}
 
@@ -593,10 +601,13 @@
 
 	for (i = 0; i < sizeof (dev_list) / sizeof *dev_list; i++) {
 		devfs_remove("sound/%s", dev_list[i].name);
+		class_simple_device_remove(MKDEV(SOUND_MAJOR, dev_list[i].minor));
 		if (!dev_list[i].num)
 			continue;
-		for (j = 1; j < *dev_list[i].num; j++)
+		for (j = 1; j < *dev_list[i].num; j++) {
 			devfs_remove("sound/%s%d", dev_list[i].name, j);
+			class_simple_device_remove(MKDEV(SOUND_MAJOR, dev_list[i].minor + (j*0x10)));
+		}
 	}
 	
 	unregister_sound_special(1);
diff -Nru a/sound/sound_core.c b/sound/sound_core.c
--- a/sound/sound_core.c	Thu Jan 15 11:05:56 2004
+++ b/sound/sound_core.c	Thu Jan 15 11:05:56 2004
@@ -65,6 +65,9 @@
 extern int msnd_pinnacle_init(void);
 #endif
 
+struct class_simple *sound_class;
+EXPORT_SYMBOL(sound_class);
+
 /*
  *	Low level list operator. Scan the ordered list, find a hole and
  *	join into it. Called with the lock asserted
@@ -171,6 +174,8 @@
 
 	devfs_mk_cdev(MKDEV(SOUND_MAJOR, s->unit_minor),
 			S_IFCHR | mode, s->name);
+	class_simple_device_add(sound_class, MKDEV(SOUND_MAJOR, s->unit_minor),
+				NULL, s->name+6);
 	return r;
 
  fail:
@@ -193,6 +198,7 @@
 	spin_unlock(&sound_loader_lock);
 	if (p) {
 		devfs_remove(p->name);
+		class_simple_device_remove(MKDEV(SOUND_MAJOR, p->unit_minor));
 		kfree(p);
 	}
 }
@@ -556,6 +562,7 @@
 	   empty */
 	unregister_chrdev(SOUND_MAJOR, "sound");
 	devfs_remove("sound");
+	class_simple_destroy(sound_class);
 }
 
 static int __init init_soundcore(void)
@@ -565,6 +572,9 @@
 		return -EBUSY;
 	}
 	devfs_mk_dir ("sound");
+	sound_class = class_simple_create(THIS_MODULE, "sound");
+	if (IS_ERR(sound_class))
+		return PTR_ERR(sound_class);
 
 	return 0;
 }
