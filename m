Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261201AbVGNLc1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261201AbVGNLc1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Jul 2005 07:32:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261204AbVGNLc1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Jul 2005 07:32:27 -0400
Received: from mailservice.tudelft.nl ([130.161.131.5]:40235 "EHLO
	mailservice.tudelft.nl") by vger.kernel.org with ESMTP
	id S261201AbVGNLcX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Jul 2005 07:32:23 -0400
Message-ID: <42D64D25.1000009@aglu.demon.nl>
Date: Thu, 14 Jul 2005 13:31:49 +0200
From: Thomas Hood <jdthood@aglu.demon.nl>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050404)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Patch to make mount follow a symlink at /etc/mtab
Content-Type: multipart/mixed;
 boundary="------------040101090207030805030103"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040101090207030805030103
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

I attach a patch that modifies the mount program in the util-linux
package so that if /etc/mtab is a symbolic link (to a location outside
of /proc) then mount accesses mtab at the target of the symbolic link.

This feature is useful when the root filesystem is mounted read-only;
/etc/mtab can then be symlinked to a location on a writable filesystem.
In the long run mtab should be eliminated entirely but in the meantime
it is nice to be able to relocate the file.

The patch deals correctly with the fact that mount creates lock files
in the same directory as mtab.

This patch also fixes a bug in umount.c whereby umount will update mtab
in some circumstances even though the -n option has been given.

I wrote the patch in August 2003 and submitted it to the util-linux
maintainer at that time.  He said that he would apply it if it proved
to be reliable after some testing.  The patch has been on my web page

     http://panopticon.csustan.edu/thood/readonly-root.html

for almost two years since then, updated from time to time as new
versions of util-linux were released.  I have advertised the patch in
various forums and I have used the patch myself for a long time.  No
problems have ever been reported.

The latest version of the patch applies to versions 2.12p and 2.12q.

     util-linux-2.12q-symlinkmtab_jdth20050709.patch

I tested it by patching the latest Debian and Ubuntu packages.  In
order for the latter to build I had to modify 10fstab.dpatch as well.
I attach the patch for that file too.

     util-linux-2.12q-symlinkmtab-10fstab_jdth20050709.patch

-- 
Thomas Hood

--------------040101090207030805030103
Content-Type: text/x-patch;
 name="util-linux-2.12q-symlinkmtab_jdth20050709.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline;
 filename="util-linux-2.12q-symlinkmtab_jdth20050709.patch"

diff -uNr util-linux-2.12p_ORIG/mount/fstab.c util-linux-2.12p/mount/fstab.c
--- util-linux-2.12p_ORIG/mount/fstab.c	2004-12-21 20:09:24.000000000 +0100
+++ util-linux-2.12p/mount/fstab.c	2005-07-09 11:53:19.000000000 +0200
@@ -1,7 +1,10 @@
-/* 1999-02-22 Arkadiusz Mi¶kiewicz <misiek@pld.ORG.PL>
+/*
+ * 1999-02-22 Arkadiusz Mi¶kiewicz <misiek@pld.ORG.PL>
  * - added Native Language Support
- * Sun Mar 21 1999 - Arnaldo Carvalho de Melo <acme@conectiva.com.br>
+ * 1999-03-21 Arnaldo Carvalho de Melo <acme@conectiva.com.br>
  * - fixed strerr(errno) in gettext calls
+ * 2003-08-08 Thomas Hood <jdthood@yahoo.co.uk> with help from Patrick McLean
+ * - Write through a symlink at /etc/mtab if it doesn't point into /proc/
  */
 
 #include <unistd.h>
@@ -11,67 +14,129 @@
 #include <sys/stat.h>
 #include "mntent.h"
 #include "fstab.h"
+#include "realpath.h"
 #include "sundries.h"
 #include "xmalloc.h"
 #include "mount_blkid.h"
 #include "paths.h"
 #include "nls.h"
 
-#define streq(s, t)	(strcmp ((s), (t)) == 0)
-
-#define PROC_MOUNTS		"/proc/mounts"
-
-
 /* Information about mtab. ------------------------------------*/
-static int have_mtab_info = 0;
-static int var_mtab_does_not_exist = 0;
-static int var_mtab_is_a_symlink = 0;
+/* A 64 bit number can be displayed in 20 decimal digits */
+#define LEN_LARGEST_PID 20
+#define MTAB_PATH_MAX (PATH_MAX - (sizeof(MTAB_LOCK_SUFFIX) - 1) - LEN_LARGEST_PID)
+static char mtab_path[MTAB_PATH_MAX];
+static char mtab_lock_path[PATH_MAX];
+static char mtab_lock_targ[PATH_MAX];
+static char mtab_temp_path[PATH_MAX];
 
-static void
+/*
+ * Set mtab_path to the real path of the mtab file
+ * or to the null string if that path is inaccessible
+ *
+ * Run this early
+ */
+void
 get_mtab_info(void) {
 	struct stat mtab_stat;
 
-	if (!have_mtab_info) {
-		if (lstat(MOUNTED, &mtab_stat))
-			var_mtab_does_not_exist = 1;
-		else if (S_ISLNK(mtab_stat.st_mode))
-			var_mtab_is_a_symlink = 1;
-		have_mtab_info = 1;
+	if (lstat(MOUNTED, &mtab_stat)) {
+		/* Assume that the lstat error means that the file does not exist */
+		/* (Maybe we should check errno here) */
+		strcpy(mtab_path, MOUNTED);
+	} else if (S_ISLNK(mtab_stat.st_mode)) {
+		/* Is a symlink */
+		int len;
+		char *r = myrealpath(MOUNTED, mtab_path, MTAB_PATH_MAX);
+		mtab_path[MTAB_PATH_MAX - 1] = 0; /* Just to be sure */
+		len = strlen(mtab_path);
+		if (
+			r == NULL
+			|| len == 0
+			|| len >= (MTAB_PATH_MAX - 1)
+			|| streqn(mtab_path, PATH_PROC, sizeof(PATH_PROC) - 1)
+		) {
+			/* Real path invalid or inaccessible */
+			mtab_path[0] = '\0';
+			return;
+		}
+		/* mtab_path now contains mtab's real path */
+	} else {
+		/* Exists and is not a symlink */
+		strcpy(mtab_path, MOUNTED);
 	}
+
+	sprintf(mtab_lock_path, "%s%s", mtab_path, MTAB_LOCK_SUFFIX);
+	sprintf(mtab_lock_targ, "%s%s%d", mtab_path, MTAB_LOCK_SUFFIX, getpid());
+	sprintf(mtab_temp_path, "%s%s", mtab_path, MTAB_TEMP_SUFFIX);
+
+	return;
 }
 
-int
-mtab_does_not_exist(void) {
-	get_mtab_info();
-	return var_mtab_does_not_exist;
+/*
+ * Tell whether or not the mtab real path is accessible
+ *
+ * get_mtab_info() must have been run
+ */
+static int
+mtab_is_accessible(void) {
+	return (mtab_path[0] != '\0');
 }
 
+/*
+ * Tell whether or not the mtab file currently exists
+ *
+ * Note that the answer here is independent of whether or
+ * not the file is writable, so if you are planning to create
+ * the mtab file then check mtab_is_writable() too.
+ *
+ * get_mtab_info() must have been run
+ */
 int
-mtab_is_a_symlink(void) {
-	get_mtab_info();
-	return var_mtab_is_a_symlink;
+mtab_does_not_exist(void) {
+	struct stat mtab_stat;
+
+	if (!mtab_is_accessible())
+		return 1;
+
+	if (lstat(mtab_path, &mtab_stat))
+		return 1;
+
+	return 0;
 }
 
+/*
+ * Tell whether or not mtab is writable (whether or not it currently exists)
+ *
+ * This depends on whether or not the real path is accessible and,
+ * if so, whether or not the file can be opened.  This function
+ * has the side effect of creating the file if it is writable.
+ *
+ * get_mtab_info() must have been run
+ */
 int
 mtab_is_writable() {
-	static int ret = -1;
+	static int is_writable = -1;
+	int fd;
+
+	if (is_writable != -1)
+		return is_writable;
 
-	/* Should we write to /etc/mtab upon an update?
-	   Probably not if it is a symlink to /proc/mounts, since that
-	   would create a file /proc/mounts in case the proc filesystem
-	   is not mounted. */
-	if (mtab_is_a_symlink())
-		return 0;
-
-	if (ret == -1) {
-		int fd = open(MOUNTED, O_RDWR | O_CREAT, 0644);
-		if (fd >= 0) {
-			close(fd);
-			ret = 1;
-		} else
-			ret = 0;
+	if (!mtab_is_accessible()) {
+		is_writable = 0;
+		return is_writable;
 	}
-	return ret;
+
+	lock_mtab();
+	fd = open(mtab_path, O_RDWR | O_CREAT, 0644);
+	if (fd >= 0) {
+		close(fd);
+		is_writable = 1;
+	} else {
+		is_writable = 0;
+	}
+	unlock_mtab();
+	return is_writable;
 }
 
 /* Contents of mtab and fstab ---------------------------------*/
@@ -154,21 +219,21 @@
 	got_mtab = 1;
 	mc->nxt = mc->prev = NULL;
 
-	fnam = MOUNTED;
+	fnam = mtab_path;
 	mfp = my_setmntent (fnam, "r");
 	if (mfp == NULL || mfp->mntent_fp == NULL) {
 		int errsv = errno;
-		fnam = PROC_MOUNTS;
+		fnam = PATH_PROC_MOUNTS;
 		mfp = my_setmntent (fnam, "r");
 		if (mfp == NULL || mfp->mntent_fp == NULL) {
 			error(_("warning: can't open %s: %s"),
-			      MOUNTED, strerror (errsv));
+			      mtab_path, strerror (errsv));
 			return;
 		}
 		if (verbose)
 			printf (_("mount: could not open %s - "
 				  "using %s instead\n"),
-				MOUNTED, PROC_MOUNTS);
+				mtab_path, PATH_PROC_MOUNTS);
 	}
 	read_mntentchn(mfp, fnam, mc);
 }
@@ -396,9 +461,6 @@
 /* Flag for already existing lock file. */
 static int we_created_lockfile = 0;
 
-/* Flag to indicate that signals have been set up. */
-static int signals_have_been_setup = 0;
-
 /* Ensure that the lock is released if we are interrupted.  */
 extern char *strsignal(int sig);	/* not always in <string.h> */
 
@@ -416,35 +478,33 @@
 void
 unlock_mtab (void) {
 	if (we_created_lockfile) {
-		unlink (MOUNTED_LOCK);
+		unlink (mtab_lock_path);
 		we_created_lockfile = 0;
 	}
 }
 
-/* Create the lock file.
-   The lock file will be removed if we catch a signal or when we exit. */
+/*
+ * Create the lock file
+ *
+ * The lock file will be removed if we catch a signal or when we exit
+ */
 /* The old code here used flock on a lock file /etc/mtab~ and deleted
-   this lock file afterwards. However, as rgooch remarks, that has a
-   race: a second mount may be waiting on the lock and proceed as
-   soon as the lock file is deleted by the first mount, and immediately
-   afterwards a third mount comes, creates a new /etc/mtab~, applies
-   flock to that, and also proceeds, so that the second and third mount
-   now both are scribbling in /etc/mtab.
+   this lock file afterwards. However, as rgooch remarks, that races:
+   a second mount may be waiting on the lock which will proceed as
+   soon as the lock file is deleted by the first mount; immediately
+   afterwards a third mount can come, create a new /etc/mtab~, apply
+   flock to that, and also proceed, so that the second and third mount
+   now both scribble in /etc/mtab.
    The new code uses a link() instead of a creat(), where we proceed
-   only if it was us that created the lock, and hence we always have
+   only if it was we that created the lock, and hence we always have
    to delete the lock afterwards. Now the use of flock() is in principle
-   superfluous, but avoids an arbitrary sleep(). */
-
-/* Where does the link point to? Obvious choices are mtab and mtab~~.
-   HJLu points out that the latter leads to races. Right now we use
-   mtab~.<pid> instead. Use 20 as upper bound for the length of %d. */
-#define MOUNTLOCK_LINKTARGET		MOUNTED_LOCK "%d"
-#define MOUNTLOCK_LINKTARGET_LTH	(sizeof(MOUNTED_LOCK)+20)
+   superfluous, but using it allows us to avoid an arbitrary sleep(). */
 
 void
 lock_mtab (void) {
 	int tries = 3;
-	char linktargetfile[MOUNTLOCK_LINKTARGET_LTH];
+	/* Flag to indicate that signals have been set up. */
+	static int signals_have_been_setup = 0;
 
 	at_die = unlock_mtab;
 
@@ -467,30 +527,28 @@
 		signals_have_been_setup = 1;
 	}
 
-	sprintf(linktargetfile, MOUNTLOCK_LINKTARGET, getpid ());
-
 	/* Repeat until it was us who made the link */
 	while (!we_created_lockfile) {
 		struct flock flock;
 		int errsv, fd, i, j;
 
-		i = open (linktargetfile, O_WRONLY|O_CREAT, 0);
+		i = open (mtab_lock_targ, O_WRONLY|O_CREAT, 0);
 		if (i < 0) {
 			int errsv = errno;
-			/* linktargetfile does not exist (as a file)
+			/* mtab_lock_targ does not exist (as a file)
 			   and we cannot create it. Read-only filesystem?
 			   Too many files open in the system?
 			   Filesystem full? */
 			die (EX_FILEIO, _("can't create lock file %s: %s "
 			     "(use -n flag to override)"),
-			     linktargetfile, strerror (errsv));
+			     mtab_lock_targ, strerror (errsv));
 		}
 		close(i);
 
-		j = link(linktargetfile, MOUNTED_LOCK);
+		j = link(mtab_lock_targ, mtab_lock_path);
 		errsv = errno;
 
-		(void) unlink(linktargetfile);
+		(void) unlink(mtab_lock_targ);
 
 		if (j == 0)
 			we_created_lockfile = 1;
@@ -498,10 +556,10 @@
 		if (j < 0 && errsv != EEXIST) {
 			die (EX_FILEIO, _("can't link lock file %s: %s "
 			     "(use -n flag to override)"),
-			     MOUNTED_LOCK, strerror (errsv));
+			     mtab_lock_path, strerror (errsv));
 		}
 
-		fd = open (MOUNTED_LOCK, O_WRONLY);
+		fd = open (mtab_lock_path, O_WRONLY);
 
 		if (fd < 0) {
 			int errsv = errno;
@@ -510,7 +568,7 @@
 				continue;
 			die (EX_FILEIO, _("can't open lock file %s: %s "
 			     "(use -n flag to override)"),
-			     MOUNTED_LOCK, strerror (errsv));
+			     mtab_lock_path, strerror (errsv));
 		}
 
 		flock.l_type = F_WRLCK;
@@ -524,7 +582,7 @@
 				if (verbose) {
 				    int errsv = errno;
 				    printf(_("Can't lock lock file %s: %s\n"),
-					   MOUNTED_LOCK, strerror (errsv));
+					   mtab_lock_path, strerror (errsv));
 				}
 				/* proceed anyway */
 			}
@@ -536,17 +594,17 @@
 			if (fcntl (fd, F_SETLKW, &flock) == -1) {
 				int errsv = errno;
 				die (EX_FILEIO, _("can't lock lock file %s: %s"),
-				     MOUNTED_LOCK, (errno == EINTR) ?
+				     mtab_lock_path, (errno == EINTR) ?
 				     _("timed out") : strerror (errsv));
 			}
 			alarm(0);
 			/* Limit the number of iterations - maybe there
-			   still is some old /etc/mtab~ */
+			   still is some old lock */
 			if (tries++ > 3) {
 				if (tries > 5)
 					die (EX_FILEIO, _("Cannot create link %s\n"
 					    "Perhaps there is a stale lock file?\n"),
-					     MOUNTED_LOCK);
+					     mtab_lock_path);
 				sleep(1);
 			}
 		}
@@ -568,16 +626,16 @@
 void
 update_mtab (const char *dir, struct my_mntent *instead) {
 	mntFILE *mfp, *mftmp;
-	const char *fnam = MOUNTED;
+	const char *fnam = mtab_path;
 	struct mntentchn mtabhead;	/* dummy */
 	struct mntentchn *mc, *mc0, *absent = NULL;
 
-	if (mtab_does_not_exist() || mtab_is_a_symlink())
+	if (mtab_does_not_exist())
 		return;
 
 	lock_mtab();
 
-	/* having locked mtab, read it again */
+	/* Having got the lock, we read mtab again */
 	mc0 = mc = &mtabhead;
 	mc->nxt = mc->prev = NULL;
 
@@ -619,11 +677,11 @@
 	}
 
 	/* write chain to mtemp */
-	mftmp = my_setmntent (MOUNTED_TEMP, "w");
+	mftmp = my_setmntent (mtab_temp_path, "w");
 	if (mftmp == NULL || mftmp->mntent_fp == NULL) {
 		int errsv = errno;
 		error (_("cannot open %s (%s) - mtab not updated"),
-		       MOUNTED_TEMP, strerror (errsv));
+		       mtab_temp_path, strerror (errsv));
 		goto leave;
 	}
 
@@ -631,7 +689,7 @@
 		if (my_addmntent(mftmp, &(mc->m)) == 1) {
 			int errsv = errno;
 			die (EX_FILEIO, _("error writing %s: %s"),
-			     MOUNTED_TEMP, strerror (errsv));
+			     mtab_temp_path, strerror (errsv));
 		}
 	}
 
@@ -641,25 +699,25 @@
 		    S_IRUSR|S_IWUSR|S_IRGRP|S_IROTH) < 0) {
 		int errsv = errno;
 		fprintf(stderr, _("error changing mode of %s: %s\n"),
-			MOUNTED_TEMP, strerror (errsv));
+			mtab_temp_path, strerror (errsv));
 	}
 	my_endmntent (mftmp);
 
 	{ /*
 	   * If mount is setuid and some non-root user mounts sth,
-	   * then mtab.tmp might get the group of this user. Copy uid/gid
-	   * from the present mtab before renaming.
+	   * then the temp file might get the group of this user.
+	   * Copy uid/gid from the present mtab before renaming.
 	   */
 	    struct stat sbuf;
-	    if (stat (MOUNTED, &sbuf) == 0)
-		chown (MOUNTED_TEMP, sbuf.st_uid, sbuf.st_gid);
+	    if (stat (mtab_path, &sbuf) == 0)
+		chown (mtab_temp_path, sbuf.st_uid, sbuf.st_gid);
 	}
 
 	/* rename mtemp to mtab */
-	if (rename (MOUNTED_TEMP, MOUNTED) < 0) {
+	if (rename (mtab_temp_path, mtab_path) < 0) {
 		int errsv = errno;
 		fprintf(stderr, _("can't rename %s to %s: %s\n"),
-			MOUNTED_TEMP, MOUNTED, strerror(errsv));
+			mtab_temp_path, mtab_path, strerror(errsv));
 	}
 
  leave:
diff -uNr util-linux-2.12p_ORIG/mount/fstab.h util-linux-2.12p/mount/fstab.h
--- util-linux-2.12p_ORIG/mount/fstab.h	2004-09-19 20:45:53.000000000 +0200
+++ util-linux-2.12p/mount/fstab.h	2005-07-09 11:52:07.000000000 +0200
@@ -22,6 +22,10 @@
 struct mntentchn *getfsuuidspec (const char *uuid);
 struct mntentchn *getfsvolspec (const char *label);
 
+void get_mtab_info (void);
+int mtab_is_writable(void);
+int mtab_does_not_exist(void);
+int is_mounted_once(const char *name);
 void lock_mtab (void);
 void unlock_mtab (void);
-void update_mtab (const char *special, struct my_mntent *with);
+void update_mtab (const char *dir, struct my_mntent *instead);
diff -uNr util-linux-2.12p_ORIG/mount/mount.8 util-linux-2.12p/mount/mount.8
--- util-linux-2.12p_ORIG/mount/mount.8	2004-12-19 23:30:14.000000000 +0100
+++ util-linux-2.12p/mount/mount.8	2005-07-09 11:52:07.000000000 +0200
@@ -38,6 +38,8 @@
 .\" 010714, Michael K. Johnson <johnsonm@redhat.com> added -O
 .\" 010725, Nikita Danilov <NikitaDanilov@Yahoo.COM>: reiserfs options
 .\" 011124, Karl Eichwalder <ke@gnu.franken.de>: tmpfs options
+.\" 030808, Thomas Hood <jdthood@yahoo.co.uk>: symlinking /etc/mtab
+.\" 030809, Thomas Hood <jdthood@yahoo.co.uk>: use 'file system' consistently
 .\"
 .TH MOUNT 8 "2004-12-16" "Linux 2.6" "Linux Programmer's Manual"
 .SH NAME
@@ -111,7 +113,7 @@
 After this call the same contents is accessible in two places.
 One can also remount a single file (on a single file).
 
-This call attaches only (part of) a single filesystem, not possible
+This call attaches only (part of) a single file system, not possible
 submounts. The entire file hierarchy including submounts is attached
 a second place using
 .RS
@@ -120,7 +122,7 @@
 .RE
 .\" available since Linux 2.4.11.
 
-Note that the filesystem mount options will remain the same as those
+Note that the file system mount options will remain the same as those
 on the original mount point, and cannot be changed by passing the -o
 option along with --bind/--rbind.
 
@@ -172,7 +174,7 @@
 keyword. Adding the
 .B \-F
 option will make mount fork, so that the
-filesystems are mounted simultaneously.
+file systems are mounted simultaneously.
 .LP
 (ii) When mounting a file system mentioned in
 .IR fstab ,
@@ -203,7 +205,7 @@
 .RE
 For more details, see
 .BR fstab (5).
-Only the user that mounted a filesystem can unmount it again.
+Only the user that mounted a file system can unmount it again.
 If any user should be able to unmount, then use
 .B users
 instead of
@@ -236,25 +238,48 @@
 
 When the
 .I proc
-filesystem is mounted (say at
+file system is mounted (say at
 .IR /proc ),
 the files
 .I /etc/mtab
 and
 .I /proc/mounts
-have very similar contents. The former has somewhat
+have very similar contents. The former contains somewhat
 more information, such as the mount options used,
-but is not necessarily up-to-date (cf. the
+but is not necessarily completely accurate (cf. the
 .B \-n
-option below). It is possible to replace
+and
+.B \-f
+options below). It is possible to replace
 .I /etc/mtab
 by a symbolic link to
 .IR /proc/mounts ,
 and especially when you have very large numbers of mounts
 things will be much faster with that symlink,
-but some information is lost that way, and in particular
-working with the loop device will be less convenient,
-and using the "user" option will fail.
+but some information is lost that way.  As a result,
+working with the loop device is less convenient
+and the "user" option does not work.
+
+You can also replace
+.I /etc/mtab
+by a symbolic link to
+another location such as
+.IR /var/run/mtab .
+This may be useful if your root file system is mounted read-only
+but you have another file system such as
+.I /var
+that is writable where you can store the mtab.
+Note that in this case you will have to mount
+.I /var
+first using the
+.B \-n
+option.  Once the target of the
+.I /etc/mtab
+symbolic link is writable you can run
+.B mount
+again with the
+.B \-f
+option to add the missing entry.
 
 .SH OPTIONS
 The full set of options used by an invocation of
@@ -282,7 +307,7 @@
 Verbose mode.
 .TP
 .B \-a
-Mount all filesystems (of the given types) mentioned in
+Mount all file systems (of the given types) mentioned in
 .IR fstab .
 .TP
 .B \-F
@@ -336,7 +361,7 @@
 .TP
 .B \-s
 Tolerate sloppy mount options rather than failing. This will ignore
-mount options not supported by a filesystem type. Not all filesystems
+mount options not supported by a file system type. Not all file systems
 support this option. This option exists for support of the Linux
 autofs\-based automounter.
 .TP
@@ -419,7 +444,7 @@
 .B mount
 program has to do is issue a simple
 .IR mount (2)
-system call, and no detailed knowledge of the filesystem type is required.
+system call, and no detailed knowledge of the file system type is required.
 For a few types however (like nfs, smbfs, ncpfs) ad hoc code is
 necessary. The nfs ad hoc code is built in, but smbfs and ncpfs
 have a separate mount program. In order to make it possible to
@@ -445,7 +470,7 @@
 .IR /etc/filesystems ,
 or, if that does not exist,
 .IR /proc/filesystems .
-All of the filesystem types listed there will be tried,
+All of the file system types listed there will be tried,
 except for those that are labeled "nodev" (e.g.,
 .IR devpts ,
 .I proc
@@ -465,7 +490,7 @@
 can be useful to change the probe order (e.g., to try vfat before msdos
 or ext3 before ext2) or if you use a kernel module autoloader.
 Warning: the probing uses a heuristic (the presence of appropriate `magic'),
-and could recognize the wrong filesystem type, possibly with catastrophic
+and could recognize the wrong file system type, possibly with catastrophic
 consequences. If your data is valuable, don't ask
 .B mount
 to guess.
@@ -492,7 +517,7 @@
 .B \-O
 Used in conjunction with
 .BR \-a ,
-to limit the set of filesystems to which the
+to limit the set of file systems to which the
 .B \-a
 is applied.  Like
 .B \-t
@@ -523,7 +548,7 @@
 .RS
 .B "mount \-a \-t ext2 \-O _netdev"
 .RE
-mounts all ext2 filesystems with the _netdev option, not all filesystems
+mounts all ext2 file systems with the _netdev option, not all file systems
 that are either ext2 or have the _netdev option specified.
 .RE
 .TP
@@ -569,12 +594,12 @@
 .BR group,dev,suid ).
 .TP
 .B mand
-Allow mandatory locks on this filesystem. See
+Allow mandatory locks on this file system. See
 .BR fcntl (2).
 .TP
 .B _netdev
-The filesystem resides on a device that requires network access
-(used to prevent the system from attempting to mount these filesystems
+The file system resides on a device that requires network access
+(used to prevent the system from attempting to mount these file systems
 until the network has been enabled on the system).
 .TP
 .B noatime
@@ -596,7 +621,7 @@
 /lib/ld*.so /mnt/binary. This trick fails since Linux 2.4.25 / 2.6.0.)
 .TP
 .B nomand
-Do not allow mandatory locks on this filesystem.
+Do not allow mandatory locks on this file system.
 .TP
 .B nosuid
 Do not allow set-user-identifier or set-group-identifier bits to take
@@ -772,7 +797,7 @@
 .\" Due to a kernel bug, it may be mounted with random mount options
 .\" (fixed in Linux 2.0.4).
 Since Linux 2.5.46, for most mount options the default
-is determined by the filesystem superblock. Set them with
+is determined by the file system superblock. Set them with
 .BR tune2fs (8).
 .TP
 .BR acl " / " noacl
@@ -817,7 +842,7 @@
 .\" Since 2.3.99-pre3 but before 2.6.0-test7 every string check=foo
 .\" was equivalent to just check. Since 2.6.0-test7 only check is accepted.
 .BR check
-Check filesystem (block and inode bitmaps) at mount time.
+Check file system (block and inode bitmaps) at mount time.
 .\" requires CONFIG_EXT2_CHECK
 .TP
 .BR check=none " / " nocheck
@@ -833,7 +858,7 @@
 Define the behaviour when an error is encountered.
 (Either ignore errors and just mark the file system erroneous and continue,
 or remount the file system read-only, or panic and halt the system.)
-The default is set in the filesystem superblock, and can be
+The default is set in the file system superblock, and can be
 changed using
 .BR tune2fs (8).
 .TP
@@ -872,18 +897,18 @@
 .BI sb= n
 Instead of block 1, use block
 .I n
-as superblock. This could be useful when the filesystem has been damaged.
+as superblock. This could be useful when the file system has been damaged.
 (Earlier, copies of the superblock would be made every 8192 blocks: in
 block 1, 8193, 16385, ... (and one got thousands of copies on
-a big filesystem). Since version 1.08,
+a big file system). Since version 1.08,
 .B mke2fs
 has a \-s (sparse superblock) option to reduce the number of backup
 superblocks, and since version 1.15 this is the default. Note
-that this may mean that ext2 filesystems created by a recent
+that this may mean that ext2 file systems created by a recent
 .B mke2fs
 cannot be mounted r/w under Linux 2.0.*.)
 The block number here uses 1k units. Thus, if you want to use logical
-block 32768 on a filesystem with 4k blocks, use "sb=131072".
+block 32768 on a file system with 4k blocks, use "sb=131072".
 .TP
 .BR user_xattr " / " nouser_xattr
 Support "user." extended attributes (or not).
@@ -943,12 +968,12 @@
 .SH "Mount options for fat"
 (Note:
 .I fat
-is not a separate filesystem, but a common part of the
+is not a separate file system, but a common part of the
 .IR msdos ,
 .I umsdos
 and
 .I vfat
-filesystems.)
+file systems.)
 .TP
 .BR blocksize=512 " / " blocksize=1024 " / " blocksize=2048
 Set blocksize (default 512).
@@ -999,7 +1024,7 @@
 .TP
 .BI codepage= value
 Sets the codepage for converting to shortname characters on FAT
-and VFAT filesystems. By default, codepage 437 is used.
+and VFAT file systems. By default, codepage 437 is used.
 .TP
 .BR conv=b[inary] " / " conv=t[ext] " / " conv=a[uto]
 The
@@ -1127,10 +1152,10 @@
 Do not abort mounting when certain consistency checks fail.
 
 .SH "Mount options for iso9660"
-ISO 9660 is a standard describing a filesystem structure to be used
-on CD-ROMs. (This filesystem type is also seen on some DVDs. See also the
+ISO 9660 is a standard describing a file system structure to be used
+on CD-ROMs. (This file system type is also seen on some DVDs. See also the
 .I udf
-filesystem.)
+file system.)
 
 Normal
 .I iso9660
@@ -1142,7 +1167,7 @@
 Rock Ridge is an extension to iso9660 that provides all of these unix like
 features.  Basically there are extensions to each directory record that
 supply all of the additional information, and when Rock Ridge is in use,
-the filesystem is indistinguishable from a normal UNIX file system (except
+the file system is indistinguishable from a normal UNIX file system (except
 that it is read-only, of course).
 .TP
 .B norock
@@ -1393,7 +1418,7 @@
 hard links instead of being suppressed.
 .TP
 \fBuid=\fP\fIvalue\fP, \fBgid=\fP\fIvalue\fP and \fBumask=\fP\fIvalue\fP
-Set the file permission on the filesystem.
+Set the file permission on the file system.
 The umask value is given in octal.
 By default, the files are owned by root and not readable by somebody else.
 
@@ -1403,12 +1428,12 @@
 These options are recognized, but have no effect as far as I can see.
 
 .SH "Mount options for ramfs"
-Ramfs is a memory based filesystem. Mount it and you have it. Unmount it
+Ramfs is a memory based file system. Mount it and you have it. Unmount it
 and it is gone. Present since Linux 2.3.99pre4.
 There are no mount options.
 
 .SH "Mount options for reiserfs"
-Reiserfs is a journaling filesystem.
+Reiserfs is a journaling file system.
 The reiserfs mount options are more fully described at
 .IR http://www.namesys.com/mount-options.html .
 .TP
@@ -1517,7 +1542,7 @@
 for Ki, Mi, Gi (binary kilo, mega and giga) and can be changed on remount.
 .TP
 .BI size= nbytes
-Override default maximum size of the filesystem.
+Override default maximum size of the file system.
 The size is given in bytes, and rounded down to entire pages.
 The default is half of the memory.
 .TP
@@ -1531,7 +1556,7 @@
 Set initial permissions of the root directory.
 
 .SH "Mount options for udf"
-udf is the "Universal Disk Format" filesystem defined by the Optical
+udf is the "Universal Disk Format" file system defined by the Optical
 Storage Technology Association, and is often used for DVD-ROM.
 See also
 .IR iso9660 .
@@ -1580,7 +1605,7 @@
 Override the PartitionDesc location. (unused)
 .TP
 .B lastblock=
-Set the last block of the filesystem.
+Set the last block of the file system.
 .TP
 .B fileset=
 Override the fileset block location. (unused)
@@ -1604,26 +1629,26 @@
 (Don't forget to give the \-r option.)
 .TP
 .B 44bsd
-For filesystems created by a BSD-like system (NetBSD,FreeBSD,OpenBSD).
+For file systems created by a BSD-like system (NetBSD,FreeBSD,OpenBSD).
 .TP
 .B sun
-For filesystems created by SunOS or Solaris on Sparc.
+For file systems created by SunOS or Solaris on Sparc.
 .TP
 .B sunx86
-For filesystems created by Solaris on x86.
+For file systems created by Solaris on x86.
 .TP
 .B hp
-For filesystems created by HP-UX, read-only.
+For file systems created by HP-UX, read-only.
 .TP
 .B nextstep
-For filesystems created by NeXTStep (on NeXT station) (currently read only).
+For file systems created by NeXTStep (on NeXT station) (currently read only).
 .TP
 .B nextstep-cd
 For NextStep CDROMs (block_size == 2048), read-only.
 .TP
 .B openstep
-For filesystems created by OpenStep (currently read only).
-The same filesystem type is also used by Mac OS X.
+For file systems created by OpenStep (currently read only).
+The same file system type is also used by Mac OS X.
 .RE
 
 .TP
@@ -1661,7 +1686,7 @@
 This lets you backup and restore filenames that are created with any
 Unicode characters. Without this option, a '?' is used when no
 translation is possible. The escape character is ':' because it is
-otherwise illegal on the vfat filesystem. The escape sequence
+otherwise illegal on the vfat file system. The escape sequence
 that gets used, where u is the unicode character,
 is: ':', (u & 0x3f), ((u>>6) & 0x3f), (u>>12).
 .TP
@@ -1674,8 +1699,8 @@
 .IR name~num.ext .
 .TP
 .B utf8
-UTF8 is the filesystem safe 8-bit encoding of Unicode that is used
-by the console. It can be be enabled for the filesystem with this option.
+UTF8 is the file system safe 8-bit encoding of Unicode that is used
+by the console. It can be be enabled for the file system with this option.
 If `uni_xlate' gets set, UTF8 gets disabled.
 .TP
 .B shortname=[lower|win95|winnt|mixed]
@@ -1743,9 +1768,9 @@
 .BI logbufs= value
 Set the number of in-memory log buffers.
 Valid numbers range from 2-8 inclusive.
-The default value is 8 buffers for filesystems with a blocksize of 64K,
-4 buffers for filesystems with a blocksize of 32K,
-3 buffers for filesystems with a blocksize of 16K,
+The default value is 8 buffers for file systems with a blocksize of 64K,
+4 buffers for file systems with a blocksize of 32K,
+3 buffers for file systems with a blocksize of 16K,
 and 2 buffers for all other configurations.
 Increasing the number of buffers may increase performance on
 some workloads at the cost of the memory used for the
@@ -1759,7 +1784,7 @@
 .TP
 \fBlogdev=\fP\fIdevice\fP and \fBrtdev=\fP\fIdevice\fP
 Use an external log (metadata journal) and/or real-time device.
-An XFS filesystem has up to three parts: a data section, a log section,
+An XFS file system has up to three parts: a data section, a log section,
 and a real-time section.
 The real-time section is optional, and the log section can be separate
 from the data section or contained within it.
@@ -1773,8 +1798,8 @@
 Access timestamps are not updated when a file is read.
 .TP
 .B norecovery
-The filesystem will be mounted without running log recovery.
-If the filesystem was not cleanly unmounted, it is likely to
+The file system will be mounted without running log recovery.
+If the file system was not cleanly unmounted, it is likely to
 be inconsistent when mounted in
 .B norecovery
 mode.
@@ -1784,7 +1809,7 @@
 must be mounted read-only or the mount will fail.
 .TP
 .B nouuid
-Ignore the filesystem uuid. This avoids errors for duplicate uuids.
+Ignore the file system uuid. This avoids errors for duplicate uuids.
 .TP
 .B osyncisdsync
 Make writes to files opened with the O_SYNC flag set behave
@@ -1805,13 +1830,13 @@
 volume.
 .I value
 must be specified in 512-byte block units.
-If this option is not specified and the filesystem was made on a stripe
+If this option is not specified and the file system was made on a stripe
 volume or the stripe width or unit were specified for the RAID device at
 mkfs time, then the mount system call will restore the value from the
 superblock.
-For filesystems that are made directly on RAID devices, these options can be
+For file systems that are made directly on RAID devices, these options can be
 used to override the information in the superblock if the underlying disk
-layout changes after the filesystem has been created.
+layout changes after the file system has been created.
 The
 .B swidth
 option is required if the
@@ -1846,7 +1871,7 @@
 that are really options to
 .BR \%losetup (8).
 (These options can be used in addition to those specific
-to the filesystem type.)
+to the file system type.)
 
 If no explicit loop device is mentioned
 (but just an option `\fB\-o loop\fP' is given), then
@@ -1911,7 +1936,7 @@
 temporary file
 .TP
 .I /etc/filesystems
-a list of filesystem types to try
+a list of file system types to try
 
 .SH "SEE ALSO"
 .BR mount (2),
diff -uNr util-linux-2.12p_ORIG/mount/mount.c util-linux-2.12p/mount/mount.c
--- util-linux-2.12p_ORIG/mount/mount.c	2004-12-21 23:00:36.000000000 +0100
+++ util-linux-2.12p/mount/mount.c	2005-07-09 11:52:07.000000000 +0200
@@ -391,7 +391,11 @@
 	return ret;
 }
 
-/* Create mtab with a root entry.  */
+/*
+ * Create mtab with a root entry.
+ *
+ * Caller should check that mtab is writable first
+ */
 static void
 create_mtab (void) {
 	struct mntentchn *fstab;
@@ -1491,6 +1495,9 @@
 	initproctitle(argc, argv);
 #endif
 
+	get_mtab_info();
+	/* Keep in mind that /etc/mtab may be a symlink */
+
 	while ((c = getopt_long (argc, argv, "afFhilL:no:O:p:rsU:vVwt:",
 				 longopts, NULL)) != -1) {
 		switch (c) {
@@ -1615,7 +1622,7 @@
 			die (EX_USAGE, _("mount: only root can do that"));
 	}
 
-	if (!nomtab && mtab_does_not_exist()) {
+	if (!nomtab && mtab_does_not_exist() && mtab_is_writable()) {
 		if (verbose > 1)
 			printf(_("mount: no %s found - creating it..\n"),
 			       MOUNTED);
diff -uNr util-linux-2.12p_ORIG/mount/paths.h util-linux-2.12p/mount/paths.h
--- util-linux-2.12p_ORIG/mount/paths.h	2004-09-19 20:45:38.000000000 +0200
+++ util-linux-2.12p/mount/paths.h	2005-07-09 11:52:07.000000000 +0200
@@ -1,10 +1,14 @@
 #include <mntent.h>
-#define _PATH_FSTAB	"/etc/fstab"
+#define _PATH_FSTAB		"/etc/fstab"
+#define PATH_PROC		"/proc/"
+#define PATH_PROC_MOUNTS	PATH_PROC "mounts"
+#define MTAB_LOCK_SUFFIX	"~"
+#define MTAB_TEMP_SUFFIX	".tmp"
 #ifdef _PATH_MOUNTED
-#define MOUNTED_LOCK	_PATH_MOUNTED "~"
-#define MOUNTED_TEMP	_PATH_MOUNTED ".tmp"
+#define MOUNTED_LOCK		_PATH_MOUNTED "~"
+#define MOUNTED_TEMP		_PATH_MOUNTED ".tmp"
 #else
-#define MOUNTED_LOCK	"/etc/mtab~"
-#define MOUNTED_TEMP	"/etc/mtab.tmp"
+#define MOUNTED_LOCK		"/etc/mtab~"
+#define MOUNTED_TEMP		"/etc/mtab.tmp"
 #endif
-#define LOCK_TIMEOUT	10
+#define LOCK_TIMEOUT		10
diff -uNr util-linux-2.12p_ORIG/mount/sundries.h util-linux-2.12p/mount/sundries.h
--- util-linux-2.12p_ORIG/mount/sundries.h	2004-12-21 22:59:59.000000000 +0100
+++ util-linux-2.12p/mount/sundries.h	2005-07-09 11:52:07.000000000 +0200
@@ -17,7 +17,8 @@
 extern int verbose;
 extern int sloppy;
 
-#define streq(s, t)	(strcmp ((s), (t)) == 0)
+#define streq(s, t)      (strcmp ((s), (t)) == 0)
+#define streqn(s, t, n)  (strncmp((s), (t), (n)) == 0)
 
 /* Functions in sundries.c that are used in mount.c and umount.c  */ 
 void block_signals (int how);
diff -uNr util-linux-2.12p_ORIG/mount/umount.c util-linux-2.12p/mount/umount.c
--- util-linux-2.12p_ORIG/mount/umount.c	2004-12-20 23:03:45.000000000 +0100
+++ util-linux-2.12p/mount/umount.c	2005-07-09 11:52:07.000000000 +0200
@@ -264,8 +264,11 @@
   }
 }
 
-/* Umount a single device.  Return a status code, so don't exit
-   on a non-fatal error.  We lock/unlock around each umount.  */
+/*
+ * Umount a single device
+ *
+ * Returns a status code; doesn't exit on a non-fatal error
+ */
 static int
 umount_one (const char *spec, const char *node, const char *type,
 	    const char *opts, struct mntentchn *mc) {
@@ -355,7 +358,8 @@
 			remnt.mnt_type = remnt.mnt_fsname = NULL;
 			remnt.mnt_dir = xstrdup(node);
 			remnt.mnt_opts = xstrdup("ro");
-			update_mtab(node, &remnt);
+			if (!nomtab && mtab_is_writable())
+				update_mtab(node, &remnt);
 			return 0;
 		} else if (errno != EBUSY) { 	/* hmm ... */
 			perror("remount");
@@ -665,6 +669,8 @@
 
 	umask(022);
 
+	get_mtab_info();
+
 	while ((c = getopt_long (argc, argv, "adfhlnrit:O:vV",
 				 longopts, NULL)) != -1)
 		switch (c) {


--------------040101090207030805030103
Content-Type: text/x-patch;
 name="util-linux-2.12q-symlinkmtab-10fstab_jdth20050709.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="util-linux-2.12q-symlinkmtab-10fstab_jdth20050709.patch"

--- util-linux-2.12p_ORIG/debian/patches/10fstab.dpatch	2005-07-09 11:47:17.000000000 +0200
+++ util-linux-2.12p/debian/patches/10fstab.dpatch	2005-07-09 16:20:23.000000000 +0200
@@ -12,8 +12,8 @@
  		struct flock flock;
  		int errsv, fd, i, j;
  
--		i = open (linktargetfile, O_WRONLY|O_CREAT, 0);
-+		i = open (linktargetfile, O_WRONLY|O_CREAT, 0600);
+-		i = open (mtab_lock_targ, O_WRONLY|O_CREAT, 0);
++		i = open (mtab_lock_targ, O_WRONLY|O_CREAT, 0600);
  		if (i < 0) {
  			int errsv = errno;
  			/* linktargetfile does not exist (as a file)


--------------040101090207030805030103--
