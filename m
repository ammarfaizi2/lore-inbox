Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262432AbTC1ITk>; Fri, 28 Mar 2003 03:19:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262523AbTC1ITk>; Fri, 28 Mar 2003 03:19:40 -0500
Received: from hera.cwi.nl ([192.16.191.8]:8683 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S262432AbTC1ITi>;
	Fri, 28 Mar 2003 03:19:38 -0500
From: Andries.Brouwer@cwi.nl
Date: Fri, 28 Mar 2003 09:30:53 +0100 (MET)
Message-Id: <UTC200303280830.h2S8Urm08986.aeb@smtp.cwi.nl>
To: Andries.Brouwer@cwi.nl, davej@codemonkey.org.uk
Subject: Re: LVM/Device mapper breaks with -mm (was: Re: 2.5.66-mm1)
Cc: Joel.Becker@oracle.com, erik@hensema.net, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    From: Dave Jones <davej@codemonkey.org.uk>

     > For example, struct umsdos_ioctl has twice dev_t followed
     > by padding. Probably these should become unsigned longs.
     > I'll send a patch later tonight.
     > 
     > Is it used anywhere? That requires detective work.
     > It is used by the utilities udosctl (a useless demo utility),
     > umssync and umssetup. I do not know of any others.
     > No doubt people will tell me what I overlooked.
     > Less conservative people will tell me that umsdos has to
     > be killed entirely.

    Isn't it still horribly broken ? I remember Al putting it on
    the "To be fixed later" burner, but never saw anything happen
    to it after that asides from janitor style fixes.

Yes, umsdos is victim of bitrot.
Al broke it with his patch called MA37-break-umsdos-C3-pre3.
Afterwards people doing global changes failed to do them on
umsdos, so the amount of work required to get umsdos in the
shape it was before (working, but with races and other problems)
increases in time.

I failed to cc the list on the patch referred to above.
It is rather useless since umsdos is broken, but at least
prevents increased bitrot. Let me include it here.

Andries

diff -u --recursive --new-file -X /linux/dontdiff a/include/linux/umsdos_fs.h b/include/linux/umsdos_fs.h
--- a/include/linux/umsdos_fs.h	Fri Nov 22 22:40:12 2002
+++ b/include/linux/umsdos_fs.h	Wed Mar 26 22:31:14 2003
@@ -49,7 +49,7 @@
 #	else
 #		define Printk(x)
 #	endif
-#endif
+#endif	/* __KERNEL__ */
 
 
 struct umsdos_fake_info {
@@ -70,8 +70,7 @@
 	time_t atime;		/* Access time */
 	time_t mtime;		/* Last modification time */
 	time_t ctime;		/* Creation time */
-	dev_t rdev;		/* major and minor number of a device */
-				/* special file */
+	unsigned short rdev;	/* major and minor of a device special file */
 	umode_t mode;		/* Standard UNIX permissions bits + type of */
 	char spare[12];		/* unused bytes for future extensions */
 				/* file, see linux/stat.h */
@@ -129,34 +128,32 @@
 struct umsdos_ioctl {
 	struct dirent dos_dirent;
 	struct umsdos_dirent umsdos_dirent;
-	/* The following structure is used to exchange some data
-	 * with utilities (umsdos_progs/util/umsdosio.c). The first
-	 * releases were using struct stat from "sys/stat.h". This was
-	 * causing some problem for cross compilation of the kernel
-	 * Since I am not really using the structure stat, but only some field
-	 * of it, I have decided to replicate the structure here
-	 * for compatibility with the binaries out there
+	/* The following structure is used to exchange some data with
+	 * utilities (umsdos_progs/util/umsdosio.c). The first releases
+	 * were using struct stat from "sys/stat.h". This was causing
+	 * some problem for cross compilation of the kernel.
+	 * Since I am not really using the structure stat, but only
+	 * some fields of it, I have decided to replicate the structure
+	 * here for compatibility with the binaries out there.
 	 * FIXME PTW 1998, this has probably changed
 	 */
 	
 	struct {
-		dev_t st_dev;
-		unsigned short __pad1;
-		ino_t st_ino;
-		umode_t st_mode;
+		unsigned long st_dev;
+		ino_t st_ino;			/* used */
+		umode_t st_mode;		/* used */
 		nlink_t st_nlink;
 		__kernel_uid_t st_uid;
 		__kernel_gid_t st_gid;
-		dev_t st_rdev;
-		unsigned short __pad2;
-		off_t st_size;
+		unsigned long st_rdev;
+		off_t st_size;			/* used */
 		unsigned long st_blksize;
 		unsigned long st_blocks;
-		time_t st_atime;
+		time_t st_atime;		/* used */
 		unsigned long __unused1;
-		time_t st_mtime;
+		time_t st_mtime;		/* used */
 		unsigned long __unused2;
-		time_t st_ctime;
+		time_t st_ctime;		/* used */
 		unsigned long __unused3;
 		uid_t st_uid32;
 		gid_t st_gid32;



[all fields without comment /* used */ might just as well
be called dummy; in particular, only the size of st_dev,
st_rdev matters, the value is not used]
