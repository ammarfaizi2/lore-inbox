Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289007AbSAFSre>; Sun, 6 Jan 2002 13:47:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289006AbSAFSrZ>; Sun, 6 Jan 2002 13:47:25 -0500
Received: from thick.mail.pipex.net ([158.43.192.95]:64916 "HELO
	thick.mail.pipex.net") by vger.kernel.org with SMTP
	id <S289005AbSAFSrJ>; Sun, 6 Jan 2002 13:47:09 -0500
From: Chris Rankin <rankincj@yahoo.com>
Message-Id: <200201061836.g06IaXx1005807@twopit.underworld>
Subject: [PATCH] Multiple soundcard support in register_sound_special()
To: jgarzik@mandrakesoft.com, zab@zabbo.net
Date: Sun, 6 Jan 2002 18:36:33 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am feeling "lucky" and so I am going to post this patch again
:-). This patch is needed to allow ALSA to provide OSS compatibility
for multiple sound cards, because ALSA uses the
register_sound_special() function exclusively to create OSS device
nodes. With the patch (and devfs), my /dev/sound directory looks like
this:

$ ls -als /dev/sound
total 0
   0 drwxr-xr-x    1 root     root            0 Jan  1  1970 .
   0 drwxr-xr-x    1 root     root            0 Jan  1  1970 ..
   0 crw-rw-rw-    1 root     root      14,  14 Jan  1  1970 admmidi
   0 crw-rw-rw-    1 root     root      14,  12 Jan  1  1970 adsp
   0 crw-rw-rw-    1 root     root      14,  13 Jan  1  1970 amidi
   0 crw-rw-rw-    1 root     root      14,   4 Jan  1  1970 audio
   0 crw-rw-rw-    1 root     root      14,  20 Jan  1  1970 audio1
   0 crw-rw-rw-    1 root     root      14,   9 Jan  1  1970 dmmidi
   0 crw-rw-rw-    1 root     root      14,   3 Jan  1  1970 dsp
   0 crw-rw-rw-    1 root     root      14,  19 Jan  1  1970 dsp1
   0 crw-rw-rw-    1 root     root      14,   2 Jan  1  1970 midi
   0 crw-rw-rw-    1 root     root      14,   0 Jan  1  1970 mixer
   0 crw-rw-rw-    1 root     root      14,  16 Jan  1  1970 mixer1
   0 crw-rw-rw-    1 root     root      14,   1 Jan  1  1970 sequencer
   0 crw-rw-rw-    1 root     root      14,   8 Jan  1  1970 sequencer2

Without it, my /dev/sound directory looks like this:

$ ls -als /dev/sound
total 0
   0 drwxr-xr-x    1 root     root            0 Jan  1  1970 .
   0 drwxr-xr-x    1 root     root            0 Jan  1  1970 ..
   0 crw-r--r--    1 root     root      14,  14 Jan  1  1970 admmidi
   0 crw-r--r--    1 root     root      14,  12 Jan  1  1970 adsp
   0 crw-r--r--    1 root     root      14,  13 Jan  1  1970 amidi
   0 crw-rw-rw-    1 root     root      14,   4 Jan  1  1970 audio
   0 crw-r--r--    1 root     root      14,   9 Jan  1  1970 dmmidi
   0 crw-rw-rw-    1 root     root      14,   3 Jan  1  1970 dsp
   0 crw-------    1 root     root      14,   2 Jan  1  1970 midi00
   0 crw-rw-rw-    1 root     root      14,   0 Jan  1  1970 mixer
   0 crw-rw-rw-    1 root     root      14,   1 Jan  1  1970 sequencer
   0 crw-r--r--    1 root     root      14,   8 Jan  1  1970 sequencer2
   0 crw-------    1 root     root      14,  16 Jan  1  1970 unknown

and the following errors are written into my kernel log:

Jan  6 18:10:27 twopit kernel: devfs: devfs_register(unknown): could not append to parent, err: -17
Jan  6 18:10:27 twopit kernel: devfs: devfs_register(unknown): could not append to parent, err: -17

These errors are presumably caused by devices "mixer1", "dsp1" and
"audio1" all fighting over the "unknown" slot. Could someone please
apply the patch? Any feedback on any cleanups it might need would
also be appreciated. Note that the uniqueness of the sequencer and
sequencer2 devices is preserved.

Cheers,
Chris

--- linux-2.4.17/drivers/sound/sound_core.c.orig	Sun Jan  6 17:31:30 2002
+++ linux-2.4.17/drivers/sound/sound_core.c	Sun Jan  6 17:39:43 2002
@@ -17,7 +17,7 @@
  *	plug into this. The fact they dont all go via OSS doesn't mean 
  *	they don't have to implement the OSS API. There is a lot of logic
  *	to keeping much of the OSS weight out of the code in a compatibility
- *	module, but its up to the driver to rember to load it...
+ *	module, but it's up to the driver to remember to load it...
  *
  *	The code provides a set of functions for registration of devices
  *	by type. This is done rather than providing a single call so that
@@ -173,10 +173,10 @@
 		return r;
 	}
 	
-	if (r == low)
+	if ( r < SOUND_STEP )
 		sprintf (name_buf, "%s", name);
 	else
-		sprintf (name_buf, "%s%d", name, (r - low) / SOUND_STEP);
+		sprintf (name_buf, "%s%d", name, (r / SOUND_STEP));
 	s->de = devfs_register (devfs_handle, name_buf,
 				DEVFS_FL_NONE, SOUND_MAJOR, s->unit_minor,
 				S_IFCHR | mode, fops, NULL);
@@ -231,17 +231,20 @@
  
 int register_sound_special(struct file_operations *fops, int unit)
 {
-	char *name;
+	const int chain = (unit & 0x0F);
+	int max_unit = chain + 128;
+	const char *name;
 
-	switch (unit) {
+	switch (chain) {
 	    case 0:
 		name = "mixer";
 		break;
 	    case 1:
 		name = "sequencer";
+		max_unit = unit + 1;
 		break;
 	    case 2:
-		name = "midi00";
+		name = "midi";
 		break;
 	    case 3:
 		name = "dsp";
@@ -260,6 +263,7 @@
 		break;
 	    case 8:
 		name = "sequencer2";
+		max_unit = unit + 1;
 		break;
 	    case 9:
 		name = "dmmidi";
@@ -280,10 +284,10 @@
 		name = "admmidi";
 		break;
 	    default:
-		name = "unknown";
+		name = "unknownX";
 		break;
 	}
-	return sound_insert_unit(&chains[unit&15], fops, -1, unit, unit+1,
+	return sound_insert_unit(&chains[chain], fops, -1, unit, max_unit,
 				 name, S_IRUSR | S_IWUSR);
 }
  
