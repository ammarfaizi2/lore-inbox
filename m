Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261744AbUAGXYv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 18:24:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262540AbUAGXYu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 18:24:50 -0500
Received: from mail.kroah.org ([65.200.24.183]:11477 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261744AbUAGXYZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 18:24:25 -0500
Date: Wed, 7 Jan 2004 15:23:35 -0800
From: Greg KH <greg@kroah.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-hotplug-devel@lists.sourceforge.net
Subject: [PATCH] sysfs sound class patch for OSS drivers - [1/2]
Message-ID: <20040107232335.GD2540@kroah.com>
References: <20040107232137.GC2540@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040107232137.GC2540@kroah.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adds sysfs sound class support for all OSS drivers

Note, this is based on a previous patch from Leann Ogasawara
<ogasawara@osdl.org>, but modified a lot by me.

diff -Nru a/sound/oss/soundcard.c b/sound/oss/soundcard.c
--- a/sound/oss/soundcard.c	Wed Jan  7 15:10:03 2004
+++ b/sound/oss/soundcard.c	Wed Jan  7 15:10:03 2004
@@ -73,6 +73,7 @@
 
 
 unsigned long seq_time = 0;	/* Time for /dev/sequencer */
+extern struct class sound_class;
 
 /*
  * Table for configurable mixer volume handling
@@ -569,6 +570,9 @@
 		devfs_mk_cdev(MKDEV(SOUND_MAJOR, dev_list[i].minor),
 				S_IFCHR | dev_list[i].mode,
 				"sound/%s", dev_list[i].name);
+		simple_add_class_device(&sound_class, 
+					MKDEV(SOUND_MAJOR, dev_list[i].minor),
+					NULL, "%s", dev_list[i].name);
 
 		if (!dev_list[i].num)
 			continue;
@@ -578,6 +582,10 @@
 						dev_list[i].minor + (j*0x10)),
 					S_IFCHR | dev_list[i].mode,
 					"sound/%s%d", dev_list[i].name, j);
+			simple_add_class_device(&sound_class,
+					MKDEV(SOUND_MAJOR, dev_list[i].minor + (j*0x10)),
+					NULL,
+					"%s%d", dev_list[i].name, j);
 		}
 	}
 
@@ -593,10 +601,13 @@
 
 	for (i = 0; i < sizeof (dev_list) / sizeof *dev_list; i++) {
 		devfs_remove("sound/%s", dev_list[i].name);
+		simple_remove_class_device(MKDEV(SOUND_MAJOR, dev_list[i].minor));
 		if (!dev_list[i].num)
 			continue;
-		for (j = 1; j < *dev_list[i].num; j++)
+		for (j = 1; j < *dev_list[i].num; j++) {
 			devfs_remove("sound/%s%d", dev_list[i].name, j);
+			simple_remove_class_device(MKDEV(SOUND_MAJOR, dev_list[i].minor + (j*0x10)));
+		}
 	}
 	
 	unregister_sound_special(1);
diff -Nru a/sound/sound_core.c b/sound/sound_core.c
--- a/sound/sound_core.c	Wed Jan  7 15:10:03 2004
+++ b/sound/sound_core.c	Wed Jan  7 15:10:03 2004
@@ -65,6 +65,11 @@
 extern int msnd_pinnacle_init(void);
 #endif
 
+struct class sound_class = {
+	.name = "sound",
+};
+EXPORT_SYMBOL(sound_class);
+
 /*
  *	Low level list operator. Scan the ordered list, find a hole and
  *	join into it. Called with the lock asserted
@@ -171,6 +176,8 @@
 
 	devfs_mk_cdev(MKDEV(SOUND_MAJOR, s->unit_minor),
 			S_IFCHR | mode, s->name);
+	simple_add_class_device(&sound_class, MKDEV(SOUND_MAJOR, s->unit_minor),
+				NULL, s->name+6);
 	return r;
 
  fail:
@@ -193,6 +200,7 @@
 	spin_unlock(&sound_loader_lock);
 	if (p) {
 		devfs_remove(p->name);
+		simple_remove_class_device(MKDEV(SOUND_MAJOR, p->unit_minor));
 		kfree(p);
 	}
 }
@@ -556,6 +564,7 @@
 	   empty */
 	unregister_chrdev(SOUND_MAJOR, "sound");
 	devfs_remove("sound");
+	class_unregister(&sound_class);
 }
 
 static int __init init_soundcore(void)
@@ -565,6 +574,7 @@
 		return -EBUSY;
 	}
 	devfs_mk_dir ("sound");
+	class_register(&sound_class);
 
 	return 0;
 }
