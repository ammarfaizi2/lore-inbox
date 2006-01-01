Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751093AbWAAAJo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751093AbWAAAJo (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Dec 2005 19:09:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751090AbWAAAJo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Dec 2005 19:09:44 -0500
Received: from tirith.ics.muni.cz ([147.251.4.36]:37042 "EHLO
	tirith.ics.muni.cz") by vger.kernel.org with ESMTP id S1751093AbWAAAJn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Dec 2005 19:09:43 -0500
From: "Jiri Slaby" <xslaby@fi.muni.cz>
Date: Sun,  1 Jan 2006 01:09:33 +0100
To: Grant Coady <gcoady@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.14.5: segfault / oops with ide-scsi
In-reply-to: <8budr11mfchfp03ncrpqjeck6f04urom8n@4ax.com>
Message-Id: <20060101000931.0A92622AEE6@anxur.fi.muni.cz>
X-Muni-Spam-TestIP: 147.251.48.3
X-Muni-Envelope-From: xslaby@fi.muni.cz
X-Muni-Virus-Test: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Grant Coady wrote:
>Hi there,
>
>Got this, trying to mount CDROM on a troublesome box I've not had 
>for long, Intel ICH 801 / 810 -- this with "hdc=ide-scsi":
>
>root@niner:~# mount /dev/sr0 /mnt/cdrom/
>mount: you must specify the filesystem type
>root@niner:~# mount -t iso9660 /dev/sr0 /mnt/cdrom/
>mount: /dev/sr0 is not a valid block device
>root@niner:~# mount -t iso9660 /dev/sg0 /mnt/cdrom/
>mount: /dev/sg0 is not a block device
>root@niner:~# mount -t iso9660 /dev/hdc /mnt/cdrom/
>Segmentation fault
>
>Even if this be finger trouble, it should not oops?
Could you try the patch below, what does it tell us? Somebody is not setting a
name of a kobject up.

regards, Jiri Slaby.
--
diff --git a/lib/kobject.c b/lib/kobject.c
--- a/lib/kobject.c
+++ b/lib/kobject.c
@@ -72,6 +72,12 @@ static int get_kobj_path_length(struct k
 	 * Add 1 to strlen for leading '/' of each level.
 	 */
 	do {
+		printf(KERN_INFO "THIS:");
+		if (parent->name)
+			printf("%s:", parent->name);
+		if (kobject_name(parent))
+			printf("%s", kobject_name(parent));
+		printf("\n");
 		length += strlen(kobject_name(parent)) + 1;
 		parent = parent->parent;
 	} while (parent);
