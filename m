Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316475AbSFKVcN>; Tue, 11 Jun 2002 17:32:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316621AbSFKVcM>; Tue, 11 Jun 2002 17:32:12 -0400
Received: from cpe-24-221-152-185.az.sprintbbd.net ([24.221.152.185]:9428 "EHLO
	opus.bloom.county") by vger.kernel.org with ESMTP
	id <S316475AbSFKVcL>; Tue, 11 Jun 2002 17:32:11 -0400
Date: Tue, 11 Jun 2002 14:31:11 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Linus Torvalds <torvalds@transmeta.com>,
        Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: [PATCH] Fix CONFIG_VIDEO_DEV=y
Message-ID: <20020611213111.GB13541@opus.bloom.county>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Currently 2.4.19-pre10 and 2.5.21 won't compile if CONFIG_VIDEO_DEV=y.

The problem is that videodev_proc_destroy() is protected by MODULE &&
CONFIG_PROC_FS && CONFIG_VIDEO_PROC_FS.  Additionally, all calls to
videodev_proc_create() are protected by CONFIG_PROC_FS &&
CONFIG_VIDEO_PROC_FS but the function itself (which is static) is not.

This hides both functions within CONFIG_PROC_FS && CONFIG_VIDEO_PROC_FS
tests.

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

===== drivers/media/video/videodev.c 1.10 vs edited =====
--- 1.10/drivers/media/video/videodev.c	Thu May  2 08:48:22 2002
+++ edited/drivers/media/video/videodev.c	Tue Jun 11 14:27:08 2002
@@ -394,6 +394,7 @@
 	return len;
 }
 
+#if defined(CONFIG_PROC_FS) && defined(CONFIG_VIDEO_PROC_FS)
 static void videodev_proc_create(void)
 {
 	video_proc_entry = create_proc_entry("video", S_IFDIR, &proc_root);
@@ -414,8 +415,6 @@
 	video_dev_proc_entry->owner = THIS_MODULE;
 }
 
-#ifdef MODULE
-#if defined(CONFIG_PROC_FS) && defined(CONFIG_VIDEO_PROC_FS)
 static void videodev_proc_destroy(void)
 {
 	if (video_dev_proc_entry != NULL)
@@ -424,7 +423,6 @@
 	if (video_proc_entry != NULL)
 		remove_proc_entry("video", &proc_root);
 }
-#endif
 #endif
 
 static void videodev_proc_create_dev (struct video_device *vfd, char *name)
