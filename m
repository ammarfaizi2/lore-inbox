Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261173AbTAQXsj>; Fri, 17 Jan 2003 18:48:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261205AbTAQXsj>; Fri, 17 Jan 2003 18:48:39 -0500
Received: from h-64-105-35-85.SNVACAID.covad.net ([64.105.35.85]:4821 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S261173AbTAQXsh>; Fri, 17 Jan 2003 18:48:37 -0500
Date: Fri, 17 Jan 2003 15:57:17 -0800
From: "Adam J. Richter" <adam@yggdrasil.com>
To: alsa-devel@alsa-project.org, perex@suse.cz
Cc: linux-kernel@vger.kernel.org
Subject: Patch?: linux-2.5.59/sound/soundcore.c referenced non-existant errno variable
Message-ID: <20030117155717.A6250@baldur.yggdrasil.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="VS++wcV0S1rZb1Fb"
Content-Disposition: inline
User-Agent: Mutt/1.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--VS++wcV0S1rZb1Fb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

	linux-2.5.59/sound/sound_firmware.c attempts to use the
user level system call interface from the kernel, which I understand
works on i386 and perhaps all architectures, but requires a variable
named "errno."  (Actually, it mixed things like close() and
sys_close(), but that's beside the point.)

	I could just declare a "static int errno;" in the file, but I
thought it might be helpful to use filp_open, vfs_read and filp_close
instead, which shaves a few cpu cycles and avoids the need to allocate
a file descriptor number.  I think that this also seems to be the
convention for other kernel facilities that want to open their own
files briefly.  I've attached a patch below.  The patch shrinks
sound_firmware.c by six lines.  I have only verified that the patch
compiles and that the soundcore module now loads.

	Comments are welcome.  If this patch looks good, then I'd
appreciate it if someone more connected to sound development would
integrate it and forward it to Linus.

-- 
Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."

--VS++wcV0S1rZb1Fb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="fw.diff"

--- linux-2.5.59/sound/sound_firmware.c	2003-01-16 18:21:34.000000000 -0800
+++ linux/sound/sound_firmware.c	2003-01-17 15:38:38.000000000 -0800
@@ -9,41 +9,35 @@
 
 static int do_mod_firmware_load(const char *fn, char **fp)
 {
-	int fd;
+	struct file *file;
 	long l;
 	char *dp;
 
-	fd = open(fn, 0, 0);
-	if (fd == -1)
+	file = filp_open(fn, O_RDONLY, 0);
+	if (!file)
 	{
 		printk(KERN_INFO "Unable to load '%s'.\n", fn);
 		return 0;
 	}
-	l = lseek(fd, 0L, 2);
+	l = file->f_dentry->d_inode->i_size;
 	if (l <= 0 || l > 131072)
 	{
 		printk(KERN_INFO "Invalid firmware '%s'\n", fn);
-		sys_close(fd);
+		filp_close(file, NULL);
 		return 0;
 	}
-	lseek(fd, 0L, 0);
 	dp = vmalloc(l);
-	if (dp == NULL)
-	{
-		printk(KERN_INFO "Out of memory loading '%s'.\n", fn);
-		sys_close(fd);
-		return 0;
-	}
-	if (read(fd, dp, l) != l)
-	{
+	if (dp != NULL) {
+		if (vfs_read(file, dp, l, &file->f_pos) == l) {
+			filp_close(file, NULL);
+			*fp = dp;
+			return (int) l;
+		}
 		printk(KERN_INFO "Failed to read '%s'.\n", fn);
 		vfree(dp);
-		sys_close(fd);
-		return 0;
 	}
-	close(fd);
-	*fp = dp;
-	return (int) l;
+	filp_close(file, NULL);
+	return 0;
 }
 
 /**

--VS++wcV0S1rZb1Fb--
