Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265435AbTLSDKq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Dec 2003 22:10:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265437AbTLSDKq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Dec 2003 22:10:46 -0500
Received: from dp.samba.org ([66.70.73.150]:46280 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S265435AbTLSDKf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Dec 2003 22:10:35 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Andrew Morton <akpm@osdl.org>
Cc: greg@kroah.com, Matthias Andree <matthias.andree@gmx.de>
Cc: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Fw: 2.6.0-test11 BK: sg and scanner modules not auto-loaded? 
In-reply-to: Your message of "Thu, 18 Dec 2003 09:14:04 -0800."
             <20031218091404.4b2f743b.akpm@osdl.org> 
Date: Fri, 19 Dec 2003 11:03:57 +1100
Message-Id: <20031219031034.B28F62C0FA@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20031218091404.4b2f743b.akpm@osdl.org> you write:
> 
> Rusty, is this something obvious?  (What are the new MODULE_ALIAS rules,
> btw?  Why are they now growing an extra numeric field?)>

Because some did, some didn't have a minor number.

I standardized on char-major-x-y, because an alias is trivial
(char-major-180-*), and almost all the modules are supposed to supply
their own aliases, so this should be an entirely in-kernel issue, but
they don't, and Linus stopped taking patches.

More aliases below.

> Similar considerations apply to scanner:
> alias char-major-180-48 scanner

Where did this alias come from?  Of course, scanner.c could put in
such an alias, but is it really constant?  If so, by all means add a
MODULE_ALIAS_CHARDEV() line in scanner.c.  Otherwise, leave it to the
hotplug code.

MODULE_ALIAS* patches welcome,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

Name: More Aliases
Author: Steve Youngs, Stephen Hemminger
Status: Trivial

D: Add more MODULE_ALIASes where required.

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .995-linux-2.6.0/drivers/net/pppoe.c .995-linux-2.6.0.updated/drivers/net/pppoe.c
--- .995-linux-2.6.0/drivers/net/pppoe.c	2003-11-28 12:27:23.000000000 +1100
+++ .995-linux-2.6.0.updated/drivers/net/pppoe.c	2003-12-19 10:36:26.000000000 +1100
@@ -1151,3 +1151,4 @@ module_exit(pppoe_exit);
 MODULE_AUTHOR("Michal Ostrowski <mostrows@speakeasy.net>");
 MODULE_DESCRIPTION("PPP over Ethernet driver");
 MODULE_LICENSE("GPL");
+MODULE_ALIAS_NETPROTO(PF_PPPOX);
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .995-linux-2.6.0/drivers/scsi/sg.c .995-linux-2.6.0.updated/drivers/scsi/sg.c
--- .995-linux-2.6.0/drivers/scsi/sg.c	2003-11-24 15:42:31.000000000 +1100
+++ .995-linux-2.6.0.updated/drivers/scsi/sg.c	2003-12-19 10:37:45.000000000 +1100
@@ -2974,3 +2974,4 @@ sg_proc_version_info(char *buffer, int *
 
 module_init(init_sg);
 module_exit(exit_sg);
+MODULE_ALIAS_CHARDEV_MAJOR(SCSI_GENERIC_MAJOR);
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .995-linux-2.6.0/fs/isofs/inode.c .995-linux-2.6.0.updated/fs/isofs/inode.c
--- .995-linux-2.6.0/fs/isofs/inode.c	2003-10-09 18:02:58.000000000 +1000
+++ .995-linux-2.6.0.updated/fs/isofs/inode.c	2003-12-19 10:36:26.000000000 +1100
@@ -1463,4 +1463,5 @@ static void __exit exit_iso9660_fs(void)
 module_init(init_iso9660_fs)
 module_exit(exit_iso9660_fs)
 MODULE_LICENSE("GPL");
-
+/* Actual filesystem name is iso9660, as requested in filesystems.c */
+MODULE_ALIAS("iso9660");
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .995-linux-2.6.0/sound/core/sound.c .995-linux-2.6.0.updated/sound/core/sound.c
--- .995-linux-2.6.0/sound/core/sound.c	2003-09-29 10:26:17.000000000 +1000
+++ .995-linux-2.6.0.updated/sound/core/sound.c	2003-12-19 10:36:26.000000000 +1100
@@ -31,6 +31,7 @@
 #include <sound/initval.h>
 #include <linux/kmod.h>
 #include <linux/devfs_fs_kernel.h>
+#include <linux/device.h>
 
 #define SNDRV_OS_MINORS 256
 
@@ -52,6 +53,7 @@ MODULE_PARM_SYNTAX(major, "default:116,s
 MODULE_PARM(cards_limit, "i");
 MODULE_PARM_DESC(cards_limit, "Count of soundcards installed in the system.");
 MODULE_PARM_SYNTAX(cards_limit, "default:8,skill:advanced");
+MODULE_ALIAS_CHARDEV_MAJOR(CONFIG_SND_MAJOR);
 #ifdef CONFIG_DEVFS_FS
 MODULE_PARM(device_mode, "i");
 MODULE_PARM_DESC(device_mode, "Device file permission mask for devfs.");
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .995-linux-2.6.0/sound/sound_core.c .995-linux-2.6.0.updated/sound/sound_core.c
--- .995-linux-2.6.0/sound/sound_core.c	2003-09-22 10:28:16.000000000 +1000
+++ .995-linux-2.6.0.updated/sound/sound_core.c	2003-12-19 10:36:26.000000000 +1100
@@ -45,6 +45,7 @@
 #include <linux/major.h>
 #include <linux/kmod.h>
 #include <linux/devfs_fs_kernel.h>
+#include <linux/device.h>
 
 #define SOUND_STEP 16
 
@@ -547,6 +548,7 @@ EXPORT_SYMBOL(mod_firmware_load);
 MODULE_DESCRIPTION("Core sound module");
 MODULE_AUTHOR("Alan Cox");
 MODULE_LICENSE("GPL");
+MODULE_ALIAS_CHARDEV_MAJOR(SOUND_MAJOR);
 
 static void __exit cleanup_soundcore(void)
 {
