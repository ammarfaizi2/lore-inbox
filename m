Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751103AbWELJ7P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751103AbWELJ7P (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 05:59:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751104AbWELJ7P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 05:59:15 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:45220 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751103AbWELJ7O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 05:59:14 -0400
Date: Fri, 12 May 2006 11:58:27 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Morton <akpm@osdl.org>, kernel list <linux-kernel@vger.kernel.org>
Subject: [PATCH] swsusp: documentation updates
Message-ID: <20060512095827.GA28478@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Update documentation a bit, add more machines to video.txt list.

Signed-off-by: Pavel Machek <pavel@suse.cz>

diff --git a/Documentation/power/swsusp.txt b/Documentation/power/swsusp.txt
index d7814a1..3fcec52 100644
--- a/Documentation/power/swsusp.txt
+++ b/Documentation/power/swsusp.txt
@@ -349,9 +349,34 @@ Q: How do I make suspend more verbose?
 
 A: If you want to see any non-error kernel messages on the virtual
 terminal the kernel switches to during suspend, you have to set the
-kernel console loglevel to at least 5, for example by doing
+kernel console loglevel to at least 4 (KERN_WARNING), for example by
+doing
 
-	echo 5 > /proc/sys/kernel/printk
+	# save the old loglevel
+	read LOGLEVEL DUMMY < /proc/sys/kernel/printk
+	# set the loglevel so we see the progress bar.
+	# if the level is higher than needed, we leave it alone.
+	if [ $LOGLEVEL -lt 5 ]; then
+	        echo 5 > /proc/sys/kernel/printk
+		fi
+
+        IMG_SZ=0
+        read IMG_SZ < /sys/power/image_size
+        echo -n disk > /sys/power/state
+        RET=$?      
+        #
+        # the logic here is:
+        # if image_size > 0 (without kernel support, IMG_SZ will be zero),
+        # then try again with image_size set to zero.
+	if [ $RET -ne 0 -a $IMG_SZ -ne 0 ]; then # try again with minimal image size
+                echo 0 > /sys/power/image_size
+                echo -n disk > /sys/power/state
+                RET=$?
+        fi
+
+	# restore previous loglevel
+	echo $LOGLEVEL > /proc/sys/kernel/printk
+	exit $RET
 
 Q: Is this true that if I have a mounted filesystem on a USB device and
 I suspend to disk, I can lose data unless the filesystem has been mounted
@@ -371,3 +396,17 @@ mounted filesystem.  With USB that's tru
 The safest thing is to unmount all USB-based filesystems before suspending
 and remount them after resuming.
 
+Q: I upgraded the kernel from 2.6.15 to 2.6.16. Both kernels were
+compiled with the similar configuration files. Anyway I found that
+suspend to disk (and resume) is much slower on 2.6.16 compared to
+2.6.15. Any idea for why that might happen or how can I speed it up?
+
+A: This is because the size of the suspend image is now greater than
+for 2.6.15 (by saving more data we can get more responsive system
+after resume).
+
+There's the /sys/power/image_size knob that controls the size of the
+image.  If you set it to 0 (eg. by echo 0 > /sys/power/image_size as
+root), the 2.6.15 behavior should be restored.  If it is still too
+slow, take a look at suspend.sf.net -- userland suspend is faster and
+supports LZF compression to speed it up further.
diff --git a/Documentation/power/video.txt b/Documentation/power/video.txt
index 43a889f..d859faa 100644
--- a/Documentation/power/video.txt
+++ b/Documentation/power/video.txt
@@ -90,6 +90,7 @@ Table of known working notebooks:
 Model                           hack (or "how to do it")
 ------------------------------------------------------------------------------
 Acer Aspire 1406LC		ole's late BIOS init (7), turn off DRI
+Acer TM 230			s3_bios (2)
 Acer TM 242FX			vbetool (6)
 Acer TM C110			video_post (8)
 Acer TM C300                    vga=normal (only suspend on console, not in X), vbetool (6) or video_post (8)
@@ -115,6 +116,7 @@ Dell D610			vga=normal and X (possibly v
 Dell Inspiron 4000		??? (*)
 Dell Inspiron 500m		??? (*)
 Dell Inspiron 510m		???
+Dell Inspiron 5150		vbetool needed (6)
 Dell Inspiron 600m		??? (*)
 Dell Inspiron 8200		??? (*)
 Dell Inspiron 8500		??? (*)
@@ -125,6 +127,7 @@ HP NX7000			??? (*)
 HP Pavilion ZD7000		vbetool post needed, need open-source nv driver for X
 HP Omnibook XE3	athlon version	none (1)
 HP Omnibook XE3GC		none (1), video is S3 Savage/IX-MV
+HP Omnibook XE3L-GF		vbetool (6)
 HP Omnibook 5150		none (1), (S1 also works OK)
 IBM TP T20, model 2647-44G	none (1), video is S3 Inc. 86C270-294 Savage/IX-MV, vesafb gets "interesting" but X work.
 IBM TP A31 / Type 2652-M5G      s3_mode (3) [works ok with BIOS 1.04 2002-08-23, but not at all with BIOS 1.11 2004-11-05 :-(]
@@ -157,6 +160,7 @@ Sony Vaio vgn-s260		X or boot-radeon can
 Sony Vaio vgn-S580BH		vga=normal, but suspend from X. Console will be blank unless you return to X.
 Sony Vaio vgn-FS115B		s3_bios (2),s3_mode (4)
 Toshiba Libretto L5		none (1)
+Toshiba Libretto 100CT/110CT    vbetool (6)
 Toshiba Portege 3020CT		s3_mode (3)
 Toshiba Satellite 4030CDT	s3_mode (3) (S1 also works OK)
 Toshiba Satellite 4080XCDT      s3_mode (3) (S1 also works OK)


-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
