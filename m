Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315808AbSFCXbJ>; Mon, 3 Jun 2002 19:31:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315856AbSFCXbI>; Mon, 3 Jun 2002 19:31:08 -0400
Received: from pD9E23450.dip.t-dialin.net ([217.226.52.80]:44683 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S315808AbSFCXbH>; Mon, 3 Jun 2002 19:31:07 -0400
Date: Mon, 3 Jun 2002 17:31:03 -0600 (MDT)
From: Lightweight patch manager <patch@luckynet.dynu.com>
X-X-Sender: patch@hawkeye.luckynet.adm
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
cc: Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH][2.5] wait for devices to wake up before mounting root, but
 don't hang
Message-ID: <Pine.LNX.4.44.0206031706400.11309-100000@hawkeye.luckynet.adm>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Don't hang while waiting for root device to come up

Someone mentioned that USB devices etc. can't be used for root fs since 
it's probably not yet available at boot time. This approach is broken, for 
sure, but it's at least supposed to rescue a small part of the whole (if 
you see a panic, you know something went atree).

--- linux-2.5.20/init/do_mounts.c	Sun Jun  2 19:44:47 2002
+++ thunder-2.5.20/init/do_mounts.c	Mon Jun  3 17:06:25 2002
@@ -298,6 +298,7 @@
 }
 static void __init mount_block_root(char *name, int flags)
 {
+	long l = 0;
 	char *fs_names = __getname();
 	char *p;
 
@@ -318,7 +319,18 @@
 		 * Allow the user to distinguish between failed open
 		 * and bad superblock on root device.
 		 */
-		printk ("VFS: Cannot open root device \"%s\" or %s\n",
+		l++;
+		if (l < 60) {
+		    printk ("VFS: Cannot open root device \"%s\" or %s, %li retries left...\n",
+			    root_device_name, kdevname (ROOT_DEV), 60-l);
+	
+		    /* Wait a second and retry */
+		    current->state = TASK_UNINTERRUPTIBLE;
+		    schedule_timeout(HZ);
+	
+		    goto retry;
+		}
+		printk ("VFS: Cannot open root device \"%s\" or %s ultimately.\n",
 			root_device_name, kdevname (ROOT_DEV));
 		printk ("Please append a correct \"root=\" boot option\n");
 		panic("VFS: Unable to mount root fs on %s",
-- 
Lightweight patch manager using pine. If you have any objections, tell me.

