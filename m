Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313508AbSFBUMu>; Sun, 2 Jun 2002 16:12:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313558AbSFBUMt>; Sun, 2 Jun 2002 16:12:49 -0400
Received: from gogh.rz.tu-ilmenau.de ([141.24.190.33]:24872 "EHLO
	gogh.rz.tu-ilmenau.de") by vger.kernel.org with ESMTP
	id <S313508AbSFBUMs>; Sun, 2 Jun 2002 16:12:48 -0400
Date: Sun, 2 Jun 2002 22:13:22 +0200
From: Paul Stoeber <paul.stoeber@stud.tu-ilmenau.de>
To: linux-kernel@vger.kernel.org
Subject: patch to have root fs on USB device (please CC)
Message-ID: <20020602201322.GA85820@gogh.RZ.TU-Ilmenau.DE>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It simply sleeps 10 seconds before mount_block_root().

I get an 'Unable to mount root' panic if I don't apply it,
because the attached device rolls in too late.

Same for FireWire, but that's currently out of reach because
I must run rescan-scsi-bus.sh from user space to make the
disk visible as /dev/sd?  (to be fixed soon??).

Same for all hotpluggable storage devices I suppose.

Of course that patch is really terribly wrong, maybe someone
will fix these things some day.

Please CC, I'm not on the list.


wait-before-mounting-root.patch in
Linux xyz 2.4.19-pre8 #2 Sun May 26 20:02:49 UTC 2002 ppc unknown

--- init/do_mounts.c.orig	Sat May 25 18:11:45 2002
+++ init/do_mounts.c	Sat May 25 18:15:22 2002
@@ -311,9 +311,13 @@
 }
 static void __init mount_block_root(char *name, int flags)
 {
-	char *fs_names = __getname();
+	char *fs_names;
 	char *p;
 
+	set_current_state(TASK_UNINTERRUPTIBLE);
+	schedule_timeout(10*HZ);
+
+	fs_names = __getname();
 	get_fs_names(fs_names);
 retry:
 	for (p = fs_names; *p; p += strlen(p)+1) {
