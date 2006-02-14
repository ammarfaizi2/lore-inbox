Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750952AbWBNCiN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750952AbWBNCiN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 21:38:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750946AbWBNCiN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 21:38:13 -0500
Received: from cantor2.suse.de ([195.135.220.15]:45464 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750947AbWBNCiM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 21:38:12 -0500
From: Neil Brown <neilb@suse.de>
To: Chris Stromsoe <cbs@cts.ucla.edu>
Date: Tue, 14 Feb 2006 13:38:04 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17393.17036.288440.448415@cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: any FS with tree-based quota system?
In-Reply-To: message from Chris Stromsoe on Monday February 13
References: <Pine.LNX.4.64.0602130959270.28894@potato.cts.ucla.edu>
	<17393.904.252068.459547@cse.unsw.edu.au>
	<Pine.LNX.4.64.0602131459150.330@potato.cts.ucla.edu>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: v[Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday February 13, cbs@cts.ucla.edu wrote:
> On Tue, 14 Feb 2006, Neil Brown wrote:
> > You still need to assign a uid to each user (the kernel needs some 
> > number to use as an index into the quotas file).  But only the top-level 
> > directory of each tree needs to be owned by the uid.  Files beneath the 
> > top can be owned by anyone.
> 
> I'm hoping to modify your patch to use the inode at the root of the tree 
> instead of a particular uid as the quota owner, so that setting a quota of 
> 50Mb on /some/location would charge usage for any children of 
> /some/location to the inode of /some/location.

That sounds possible...
So you are, in fact, assigning a uid to each user, but you are using
the filesystem to do it - the inode number that the filesystem uses
for the directory becomes the uid for the corresponding user.
You wouldn't even need to change the kernel patch.
When you make a directory do
   mkdir $dir
   chown `stat -c '%i' $dir` $dir

and the quotas will do what you want (you might need to fix
group-access so that you controlling application can access the files
properly. 


> 
> > I can dig-up a patch for quota-utils if you want to proceed with this.
> 
> I would appreciate that.
> 

The following seems to be against 3.09.  There are actually two
patches, the main one and a little fixup afterwards.

These patches *don't* update the documentation (sorry).  They fairly
consistently use 'Y' to request tree quotas, because:
 - a 'Y' looks a bit like a tree and
 - both 't' and 'T' were already taken in some tools.

NeilBrown


-----------------------
diff -Naur quota-tools.orig/configure quota-tools/configure
--- quota-tools.orig/configure	2002-11-13 04:00:32.000000000 +1100
+++ quota-tools/configure	2003-07-14 12:42:00.000000000 +1000
@@ -1133,6 +1133,8 @@
   cat > conftest.$ac_ext <<EOF
 #line 1135 "configure"
 #include "confdefs.h"
+#include <stdio.h>
+#include <ext2fs/ext2_fs.h>
 #include <ext2fs/ext2fs.h>
 EOF
 ac_try="$ac_cpp conftest.$ac_ext >/dev/null 2>conftest.out"
diff -Naur quota-tools.orig/convertquota.c quota-tools/convertquota.c
--- quota-tools.orig/convertquota.c	2002-11-12 21:00:05.000000000 +1100
+++ quota-tools/convertquota.c	2003-07-14 12:42:00.000000000 +1000
@@ -28,7 +28,7 @@
 
 char *mntpoint;
 char *progname;
-int ucv, gcv;
+int ucv, gcv, tcv;
 struct quota_handle *qn;	/* Handle of new file */
 int action;			/* Action to be performed */
 
@@ -44,7 +44,7 @@
 	int ret;
 
 	action = ACT_FORMAT;
-	while ((ret = getopt(argcnt, argstr, "Vugefh:")) != -1) {
+	while ((ret = getopt(argcnt, argstr, "YVugefh:")) != -1) {
 		switch (ret) {
 			case '?':
 			case 'h':
@@ -58,6 +58,9 @@
 			case 'g':
 				gcv = 1;
 				break;
+			case 'Y':
+				tcv = 1;
+				break;
 			case 'e':
 				action = ACT_ENDIAN;
 				break;
@@ -72,7 +75,7 @@
 		usage();
 	}
 
-	if (!(ucv | gcv))
+	if (!(ucv | gcv | tcv))
 		ucv = 1;
 
 	mntpoint = argstr[optind];
@@ -355,6 +358,8 @@
 		ret |= convert_file(USRQUOTA, mnt);
 	if (gcv)
 		ret |= convert_file(GRPQUOTA, mnt);
+	if (tcv)
+		ret |= convert_file(TREEQUOTA, mnt);
 	end_mounts_scan();
 
 	if (ret)
diff -Naur quota-tools.orig/edquota.c quota-tools/edquota.c
--- quota-tools.orig/edquota.c	2003-07-14 14:18:16.000000000 +1000
+++ quota-tools/edquota.c	2003-07-14 12:42:00.000000000 +1000
@@ -100,9 +100,9 @@
 	dirname = NULL;
 	quotatype = USRQUOTA;
 #if defined(RPC_SETQUOTA)
-	while ((ret = getopt(argc, argv, "ugrntTVp:F:f:")) != -1) {
+	while ((ret = getopt(argc, argv, "YugrntTVp:F:f:")) != -1) {
 #else
-	while ((ret = getopt(argc, argv, "ugtTVp:F:f:")) != -1) {
+	while ((ret = getopt(argc, argv, "YugtTVp:F:f:")) != -1) {
 #endif
 		switch (ret) {
 		  case 'p':
@@ -112,6 +112,8 @@
 		  case 'g':
 			  quotatype = GRPQUOTA;
 			  break;
+		case 'Y':
+			  quotatype = TREEQUOTA;
 #if defined(RPC_SETQUOTA)
 		  case 'n':
 		  case 'r':
diff -Naur quota-tools.orig/mntopt.h quota-tools/mntopt.h
--- quota-tools.orig/mntopt.h	2003-07-14 14:18:16.000000000 +1000
+++ quota-tools/mntopt.h	2003-07-14 12:42:00.000000000 +1000
@@ -18,6 +18,7 @@
 #define MNTOPT_QUOTA		"quota"	/* enforce user quota */
 #define MNTOPT_USRQUOTA		"usrquota"	/* enforce user quota */
 #define MNTOPT_GRPQUOTA		"grpquota"	/* enforce group quota */
+#define MNTOPT_TREEQUOTA	"treequota"	/* enforce tree quota */
 #define MNTOPT_RSQUASH		"rsquash"	/* root as ordinary user */
 #define MNTOPT_BIND		"bind"		/* binded mount */
 #define MNTOPT_LOOP		"loop"		/* loopback mount */
diff -Naur quota-tools.orig/quota.c quota-tools/quota.c
--- quota-tools.orig/quota.c	2003-07-14 14:18:16.000000000 +1000
+++ quota-tools/quota.c	2003-07-14 14:17:56.000000000 +1000
@@ -68,6 +68,7 @@
 #define FL_LOCALONLY 32
 #define FL_QUIETREFUSE 64
 #define FL_NOAUTOFS 128
+#define FL_TREE 256
 
 int flags, fmt = -1;
 char *progname;
@@ -85,7 +86,7 @@
 	gettexton();
 	progname = basename(argv[0]);
 
-	while ((ret = getopt(argc, argv, "guqvsVliQF:")) != -1) {
+	while ((ret = getopt(argc, argv, "YtguqvsVliQF:")) != -1) {
 		switch (ret) {
 		  case 'g':
 			  flags |= FL_GROUP;
@@ -93,6 +94,10 @@
 		  case 'u':
 			  flags |= FL_USER;
 			  break;
+		  case 'Y':
+		  case 't':
+			  flags |= FL_TREE;
+			  break;
 		  case 'q':
 			  flags |= FL_QUIET;
 			  break;
@@ -125,7 +130,8 @@
 	argc -= optind;
 	argv += optind;
 
-	if (!(flags & FL_USER) && !(flags & FL_GROUP))
+	if (!(flags & FL_USER) && !(flags & FL_GROUP) 
+	    && !(flags & FL_TREE))
 		flags |= FL_USER;
 	init_kernel_interface();
 
@@ -140,16 +146,21 @@
 			for (i = 0; i < ngroups; i++)
 				ret |= showquotas(GRPQUOTA, gidset[i]);
 		}
+		if (flags & FL_TREE)
+			ret |= showquotas(TREEQUOTA, getuid());
 		exit(ret);
 	}
 
-	if ((flags & FL_USER) && (flags & FL_GROUP))
+	if ((flags & (FL_USER|FL_TREE)) && (flags & FL_GROUP))
 		usage();
 
 	if (flags & FL_USER)
 		for (; argc > 0; argc--, argv++)
 			ret |= showquotas(USRQUOTA, user2uid(*argv));
-	else if (flags & FL_GROUP)
+	if (flags & FL_TREE)
+		for (; argc > 0; argc--, argv++)
+			ret |= showquotas(TREEQUOTA, user2uid(*argv));
+	if (flags & FL_GROUP)
 		for (; argc > 0; argc--, argv++)
 			ret |= showquotas(GRPQUOTA, group2gid(*argv));
 	return ret;
@@ -158,8 +169,9 @@
 void usage(void)
 {
 	errstr( "%s%s%s",
-		_("Usage: quota [-guqvs] [-l | -Q] [-i] [-F quotaformat]\n"),
+		_("Usage: quota [-gutYqvs] [-l | -Q] [-i] [-F quotaformat]\n"),
 		_("\tquota [-qvs] [-l | -Q] [-i] [-F quotaformat] -u username ...\n"),
+		_("\tquota [-qvs] [-l | -Q] [-i] [-F quotaformat] -Y username ...\n"),
 		_("\tquota [-qvs] [-l | -Q] [-i] [-F quotaformat] -g groupname ...\n"));
 	fprintf(stderr, _("Bugs to: %s\n"), MY_EMAIL);
 	exit(1);
diff -Naur quota-tools.orig/quota.h quota-tools/quota.h
--- quota-tools.orig/quota.h	2002-05-31 09:39:26.000000000 +1000
+++ quota-tools/quota.h	2003-07-14 12:42:00.000000000 +1000
@@ -6,9 +6,10 @@
 typedef u_int32_t qid_t;	/* Type in which we store ids in memory */
 typedef u_int64_t qsize_t;	/* Type in which we store size limitations */
 
-#define MAXQUOTAS 2
+#define MAXQUOTAS 3
 #define USRQUOTA  0		/* element used for user quotas */
 #define GRPQUOTA  1		/* element used for group quotas */
+#define TREEQUOTA  2		/* element used for tree quotas */
 
 /*
  * Definitions for the default names of the quotas files.
@@ -16,6 +17,7 @@
 #define INITQFNAMES { \
 	"user",    /* USRQUOTA */ \
 	"group",   /* GRPQUOTA */ \
+	"tree",    /* TREEQUOTA */ \
 	"undefined", \
 }
 
@@ -24,7 +26,8 @@
  */
 #define INITQMAGICS {\
 	0xd9c01f11,	/* USRQUOTA */\
-	0xd9c01927	/* GRPQUOTA */\
+	0xd9c01927,	/* GRPQUOTA */\
+	0xd9c01abc	/* TREEQUOTA */\
 }
 
 /* Size of blocks in which are counted size limits in generic utility parts */
diff -Naur quota-tools.orig/quotacheck.c quota-tools/quotacheck.c
--- quota-tools.orig/quotacheck.c	2003-07-14 14:18:16.000000000 +1000
+++ quota-tools/quotacheck.c	2003-07-14 14:14:34.000000000 +1000
@@ -28,7 +28,7 @@
 #include <sys/mount.h>
 
 #if defined(EXT2_DIRECT)
-#include <linux/ext2_fs.h>
+#include <ext2fs/ext2_fs.h>
 #include <ext2fs/ext2fs.h>
 #endif
 
@@ -63,7 +63,7 @@
 dev_t cur_dev;			/* Device we are working on */
 int files_done, dirs_done;
 int flags, fmt = -1, cfmt;	/* Options from command line; Quota format to use spec. by user; Actual format to check */
-int uwant, gwant, ucheck, gcheck;	/* Does user want to check user/group quota; Do we check user/group quota? */
+int uwant, gwant, twant, ucheck, gcheck, tcheck;	/* Does user want to check user/group quota; Do we check user/group quota? */
 char *mntpoint;			/* Mountpoint to check */
 char *progname;
 struct util_dqinfo old_info[MAXQUOTAS];	/* Loaded infos */
@@ -181,7 +181,7 @@
 /*
  * Add a number of blocks and inodes to a quota.
  */
-static void add_to_quota(int type, ino_t i_num, uid_t i_uid, gid_t i_gid, mode_t i_mode,
+static void add_to_quota(int type, ino_t i_num, uid_t i_uid, gid_t i_gid, uid_t i_tid, mode_t i_mode,
 			 nlink_t i_nlink, loff_t i_space, int need_remember)
 {
 	qid_t wanted;
@@ -189,6 +189,8 @@
 
 	if (type == USRQUOTA)
 		wanted = i_uid;
+	else if (type == TREEQUOTA)
+		wanted = i_tid;
 	else
 		wanted = i_gid;
 
@@ -281,7 +283,7 @@
 
 static void usage(void)
 {
-	printf(_("Utility for checking and repairing quota files.\n%s [-gucfinvdmMR] [-F <quota-format>] filesystem|-a\n"), progname);
+	printf(_("Utility for checking and repairing quota files.\n%s [-gucfinvdmtYMR] [-F <quota-format>] filesystem|-a\n"), progname);
 	printf(_("Bugs to %s\n"), MY_EMAIL);
 	exit(1);
 }
@@ -290,7 +292,7 @@
 {
 	int ret;
 
-	while ((ret = getopt(argcnt, argstr, "VhbcvugidnfF:mMRa")) != -1) {
+	while ((ret = getopt(argcnt, argstr, "tYVhbcvugidnfF:mMRa")) != -1) {
   	        switch (ret) {
 		  case 'b':
   		          flags |= FL_BACKUPS;
@@ -301,6 +303,10 @@
 		  case 'u':
 			  uwant = 1;
 			  break;
+		  case 't':
+		  case 'Y':
+			  twant = 1;
+			  break;
 		  case 'd':
 			  flags |= FL_DEBUG;
 			  setlinebuf(stderr);
@@ -343,7 +349,7 @@
 			usage();
 		}
 	}
-	if (!(uwant | gwant))
+	if (!(uwant | gwant | twant))
 		uwant = 1;
 	if ((argcnt == optind && !(flags & FL_ALL)) || (argcnt > optind && flags & FL_ALL)) {
 		fputs(_("Bad number of arguments.\n"), stderr);
@@ -375,6 +381,7 @@
 	uid_t uid;
 	gid_t gid;
 
+#define i_tid i_reserved2
 	if ((error = ext2fs_open(device, 0, 0, 0, unix_io_manager, &fs))) {
 		errstr(_("error (%d) while opening %s\n"), (int)error, device);
 		return -1;
@@ -410,11 +417,15 @@
 			if (inode.i_uid_high | inode.i_gid_high)
 				debug(FL_DEBUG, _("High uid detected.\n"));
 			if (ucheck)
-				add_to_quota(USRQUOTA, i_num, uid, gid,
+				add_to_quota(USRQUOTA, i_num, uid, gid, inode.i_tid,
 					     inode.i_mode, inode.i_links_count,
 					     inode.i_blocks << 9, 0);
 			if (gcheck)
-				add_to_quota(GRPQUOTA, i_num, uid, gid,
+				add_to_quota(GRPQUOTA, i_num, uid, gid, inode.i_tid,
+					     inode.i_mode, inode.i_links_count,
+					     inode.i_blocks << 9, 0);
+			if (tcheck)
+				add_to_quota(TREEQUOTA, i_num, uid, gid, inode.i_tid,
 					     inode.i_mode, inode.i_links_count,
 					     inode.i_blocks << 9, 0);
 			if (S_ISDIR(inode.i_mode))
@@ -453,10 +464,13 @@
 	}
 	qspace = getqsize(pathname, &st);
 	if (ucheck)
-		add_to_quota(USRQUOTA, st.st_ino, st.st_uid, st.st_gid, st.st_mode,
+		add_to_quota(USRQUOTA, st.st_ino, st.st_uid, st.st_gid, 0, st.st_mode,
 			     st.st_nlink, qspace, 0);
 	if (gcheck)
-		add_to_quota(GRPQUOTA, st.st_ino, st.st_uid, st.st_gid, st.st_mode,
+		add_to_quota(GRPQUOTA, st.st_ino, st.st_uid, st.st_gid, 0, st.st_mode,
+			     st.st_nlink, qspace, 0);
+	if (tcheck)
+		add_to_quota(TREEQUOTA, st.st_ino, st.st_uid, st.st_gid, 0, st.st_mode,
 			     st.st_nlink, qspace, 0);
 
 	if ((dp = opendir(pathname)) == (DIR *) NULL)
@@ -477,10 +491,13 @@
 
 		qspace = getqsize(de->d_name, &st);
 		if (ucheck)
-			add_to_quota(USRQUOTA, st.st_ino, st.st_uid, st.st_gid, st.st_mode,
+			add_to_quota(USRQUOTA, st.st_ino, st.st_uid, st.st_gid, 0, st.st_mode,
 				     st.st_nlink, qspace, !S_ISDIR(st.st_mode));
 		if (gcheck)
-			add_to_quota(GRPQUOTA, st.st_ino, st.st_uid, st.st_gid, st.st_mode,
+			add_to_quota(GRPQUOTA, st.st_ino, st.st_uid, st.st_gid, 0, st.st_mode,
+				     st.st_nlink, qspace, !S_ISDIR(st.st_mode));
+		if (tcheck)
+			add_to_quota(TREEQUOTA, st.st_ino, st.st_uid, st.st_gid, 0, st.st_mode,
 				     st.st_nlink, qspace, !S_ISDIR(st.st_mode));
 
 		if (S_ISDIR(st.st_mode)) {
@@ -766,7 +783,10 @@
 	if (gcheck)
 		if (process_file(mnt, GRPQUOTA) < 0)
 			gcheck = 0;
-	if (!ucheck && !gcheck)	/* Nothing to check? */
+	if (tcheck)
+		if (process_file(mnt, TREEQUOTA) < 0)
+			tcheck = 0;
+	if (!ucheck && !gcheck && !tcheck)	/* Nothing to check? */
 		return;
 	if (!(flags & FL_NOREMOUNT)) {
 		/* Now we try to remount fs read-only to prevent races when scanning filesystem */
@@ -817,6 +837,8 @@
 		dump_to_file(mnt, USRQUOTA);
 	if (gcheck)
 		dump_to_file(mnt, GRPQUOTA);
+	if (tcheck)
+		dump_to_file(mnt, TREEQUOTA);
 out:
 	remove_list();
 }
@@ -834,6 +856,10 @@
 		else if ((option = hasmntopt(mnt, MNTOPT_QUOTA)))
 			option += strlen(MNTOPT_QUOTA);
 	}
+	else if (type == TREEQUOTA) {
+		if ((option = hasmntopt(mnt, MNTOPT_TREEQUOTA)))
+			option += strlen(MNTOPT_TREEQUOTA);
+	}
 	else {
 		if ((option = hasmntopt(mnt, MNTOPT_GRPQUOTA)))
 			option += strlen(MNTOPT_GRPQUOTA);
@@ -881,10 +907,14 @@
 			gcheck = 1;
 		else
 			gcheck = 0;
-		if (!ucheck && !gcheck)
+		if (twant && hasquota(mnt, TREEQUOTA))
+			tcheck = 1;
+		else
+			tcheck = 0;
+		if (!ucheck && !gcheck && !tcheck)
 			continue;
 		if (cfmt == -1) {
-			if ((cfmt = detect_filename_format(mnt, ucheck ? USRQUOTA : GRPQUOTA)) == -1) {
+			if ((cfmt = detect_filename_format(mnt, ucheck ? USRQUOTA : tcheck ? TREEQUOTA : GRPQUOTA)) == -1) {
 				errstr(_("Cannot guess format from filename on %s. Please specify format on commandline.\n"),
 					mnt->mnt_fsname);
 				continue;
diff -Naur quota-tools.orig/quotaon.c quota-tools/quotaon.c
--- quota-tools.orig/quotaon.c	2002-06-17 05:00:46.000000000 +1000
+++ quota-tools/quotaon.c	2003-07-14 12:42:00.000000000 +1000
@@ -55,6 +55,7 @@
 #define FL_ALL 8
 #define FL_STAT 16
 #define FL_OFF 32
+#define FL_TREE 64
 
 int flags, fmt = -1;
 char *progname;
@@ -72,7 +73,7 @@
 {
 	int c;
 
-	while ((c = getopt(argcnt, argstr, "afvugpx:VF:")) != -1) {
+	while ((c = getopt(argcnt, argstr, "tYafvugpx:VF:")) != -1) {
 		switch (c) {
 		  case 'a':
 			  flags |= FL_ALL;
@@ -86,6 +87,10 @@
 		  case 'u':
 			  flags |= FL_USER;
 			  break;
+		  case 't':
+		  case 'Y':
+			  flags |= FL_TREE;
+			  break;
 		  case 'v':
 			  flags |= FL_VERBOSE;
 			  break;
@@ -114,8 +119,8 @@
 		fputs(_("Can't turn on/off quotas via RPC.\n"), stderr);
 		exit(1);
 	}
-	if (!(flags & (FL_USER | FL_GROUP)))
-		flags |= FL_USER | FL_GROUP;
+	if (!(flags & (FL_USER | FL_GROUP | FL_TREE)))
+		flags |= FL_USER | FL_GROUP | FL_TREE;
 	if (!(flags & FL_ALL)) {
 		mntpoints = argstr + optind;
 		mntcnt = argcnt - optind;
@@ -330,12 +335,16 @@
 				errs += newstate(mnt, GRPQUOTA, xarg);
 			if (flags & FL_USER)
 				errs += newstate(mnt, USRQUOTA, xarg);
+			if (flags & FL_TREE)
+				errs += newstate(mnt, TREEQUOTA, xarg);
 		}
 		else {
 			if (flags & FL_GROUP)
 				errs += print_state(mnt, GRPQUOTA);
 			if (flags & FL_USER)
 				errs += print_state(mnt, USRQUOTA);
+			if (flags & FL_TREE)
+				errs += print_state(mnt, TREEQUOTA);
 		}
 	}
 	end_mounts_scan();
diff -Naur quota-tools.orig/quotaops.c quota-tools/quotaops.c
--- quota-tools.orig/quotaops.c	2002-11-22 05:37:58.000000000 +1100
+++ quota-tools/quotaops.c	2003-07-14 12:42:00.000000000 +1000
@@ -104,6 +104,7 @@
 #if defined(BSD_BEHAVIOUR)
 		switch (handles[i]->qh_type) {
 			case USRQUOTA:
+			case TREEQUOTA:
 				euid = geteuid();
 				if (euid != id && euid != 0) {
 					uid2user(id, name);
diff -Naur quota-tools.orig/quotasys.c quota-tools/quotasys.c
--- quota-tools.orig/quotasys.c	2003-07-14 14:18:16.000000000 +1000
+++ quota-tools/quotasys.c	2003-07-14 12:42:00.000000000 +1000
@@ -97,7 +97,7 @@
  */
 int name2id(char *name, int qtype)
 {
-	if (qtype == USRQUOTA)
+	if (qtype == USRQUOTA || qtype == TREEQUOTA)
 		return user2uid(name);
 	else
 		return group2gid(name);
@@ -140,7 +140,7 @@
  */
 int id2name(int id, int qtype, char *buf)
 {
-	if (qtype == USRQUOTA)
+	if (qtype == USRQUOTA || qtype == TREEQUOTA)
 		return uid2user(id, buf);
 	else
 		return gid2group(id, buf);
@@ -393,6 +393,8 @@
 		return 1;
 	if ((type == GRPQUOTA) && hasmntopt(mnt, MNTOPT_GRPQUOTA))
 		return 1;
+	if ((type == TREEQUOTA) && hasmntopt(mnt, MNTOPT_TREEQUOTA))
+		return 1;
 	if ((type == USRQUOTA) && hasmntopt(mnt, MNTOPT_QUOTA))
 		return 1;
 	return 0;
@@ -446,6 +448,10 @@
 		if (*(pathname = option + strlen(MNTOPT_GRPQUOTA)) == '=')
 			has_quota_file_definition = 1;
 	}
+	else if (type == TREEQUOTA && (option = hasmntopt(mnt, MNTOPT_TREEQUOTA))) {
+		if (*(pathname = option + strlen(MNTOPT_TREEQUOTA)) == '=')
+			has_quota_file_definition = 1;
+	}
 	else if (type == USRQUOTA && (option = hasmntopt(mnt, MNTOPT_QUOTA))) {
 		if (*(pathname = option + strlen(MNTOPT_QUOTA)) == '=')
 			has_quota_file_definition = 1;
@@ -625,7 +631,7 @@
 static int v1_kern_quota_on(const char *dev, int type)
 {
 	char tmp[1024];		/* Just temporary buffer */
-	qid_t id = (type == USRQUOTA) ? getuid() : getgid();
+	qid_t id = (type != GRPQUOTA) ? getuid() : getgid();
 
 	if (!quotactl(QCMD(Q_V1_GETQUOTA, type), dev, id, tmp))	/* OK? */
 		return 1;
@@ -636,7 +642,7 @@
 static int v2_kern_quota_on(const char *dev, int type)
 {
 	char tmp[1024];		/* Just temporary buffer */
-	qid_t id = (type == USRQUOTA) ? getuid() : getgid();
+	qid_t id = (type != GRPQUOTA) ? getuid() : getgid();
 
 	if (!quotactl(QCMD(Q_V2_GETQUOTA, type), dev, id, tmp))	/* OK? */
 		return 1;
diff -Naur quota-tools.orig/repquota.c quota-tools/repquota.c
--- quota-tools.orig/repquota.c	2003-07-14 14:18:16.000000000 +1000
+++ quota-tools/repquota.c	2003-07-14 13:45:08.000000000 +1000
@@ -33,6 +33,7 @@
 #define FL_NONAME 64	/* Don't translate ids to names */
 #define FL_NOCACHE 128	/* Don't cache dquots before resolving */
 #define FL_NOAUTOFS 256	/* Ignore autofs mountpoints */
+#define FL_TREE 512	/* Tree-based quotas */
 
 int flags, fmt = -1;
 char **mnt;
@@ -53,7 +54,7 @@
 	int ret;
 	int cache_specified = 0;
 
-	while ((ret = getopt(argcnt, argstr, "VavughtsncCiF:")) != -1) {
+	while ((ret = getopt(argcnt, argstr, "YVavughtsncCiF:")) != -1) {
 		switch (ret) {
 			case '?':
 			case 'h':
@@ -67,6 +68,9 @@
 			case 'g':
 				flags |= FL_GROUP;
 				break;
+			case 'Y':
+				flags |= FL_TREE;
+				break;
 			case 'v':
 				flags |= FL_VERBOSE;
 				break;
@@ -112,7 +116,7 @@
 		fputs(_("Specified both -n and -t but only one of them can be used.\n"), stderr);
 		exit(1);
 	}
-	if (!(flags & (FL_USER | FL_GROUP)))
+	if (!(flags & (FL_USER | FL_GROUP | FL_TREE)))
 		flags |= FL_USER;
 	if (!(flags & FL_ALL)) {
 		mnt = argstr + optind;
@@ -173,13 +177,12 @@
 
 	if (!cached_dquots)
 		return;
-	if (type == USRQUOTA) {
+	if (type == USRQUOTA || type == TREEQUOTA ) {
 		struct passwd *pwent;
 
-		setpwent();
-		while ((pwent = getpwent())) {
-			for (i = 0; i < cached_dquots && pwent->pw_uid != dquot_cache[i].dq_id; i++);
-			if (i < cached_dquots && !(dquot_cache[i].dq_flags & DQ_PRINTED)) {
+		for (i = 0 ; i < cached_dquots; i++) {
+			pwent = getpwuid(dquot_cache[i].dq_id);
+			if (pwent && !(dquot_cache[i].dq_flags & DQ_PRINTED)) {			
 				print(dquot_cache+i, pwent->pw_name);
 				dquot_cache[i].dq_flags |= DQ_PRINTED;
 			}
@@ -189,10 +192,10 @@
 	else {
 		struct group *grent;
 
-		setgrent();
-		while ((grent = getgrent())) {
-			for (i = 0; i < cached_dquots && grent->gr_gid != dquot_cache[i].dq_id; i++);
-			if (i < cached_dquots && !(dquot_cache[i].dq_flags & DQ_PRINTED)) {
+
+		for (i = 0; i < cached_dquots ; i++) {
+			grent = getgrgid(dquot_cache[i].dq_id);
+			if (grent && !(dquot_cache[i].dq_flags & DQ_PRINTED)) {
 				print(dquot_cache+i, grent->gr_name);
 				dquot_cache[i].dq_flags |= DQ_PRINTED;
 			}
@@ -243,7 +246,7 @@
 	time2str(h->qh_info.dqi_igrace, igbuf, TF_ROUND);
 	printf(_("Block grace time: %s; Inode grace time: %s\n"), bgbuf, igbuf);
 	printf(_("                        Block limits                File limits\n"));
-	printf(_("%-9s       used    soft    hard  grace    used  soft  hard  grace\n"), (type == USRQUOTA)?_("User"):_("Group"));
+	printf(_("%-9s       used    soft    hard  grace    used  soft  hard  grace\n"), (type == USRQUOTA)?_("User"):(type == GRPQUOTA)?_("Group"):_("Tree"));
 	printf("----------------------------------------------------------------------\n");
 
 	if (h->qh_ops->scan_dquots(h, output) < 0)
@@ -284,5 +287,8 @@
 	if (flags & FL_GROUP)
 		report(GRPQUOTA);
 
+	if (flags & FL_TREE)
+		report(TREEQUOTA);
+
 	return 0;
 }
diff -Naur quota-tools.orig/rquota_server.c quota-tools/rquota_server.c
--- quota-tools.orig/rquota_server.c	2003-07-14 14:18:16.000000000 +1000
+++ quota-tools/rquota_server.c	2003-07-14 12:42:00.000000000 +1000
@@ -223,6 +223,11 @@
 			return (&result);
 		}
 
+		if (type == TREEQUOTA && unix_cred->aup_uid && unix_cred->aup_uid != id) {
+			result.status = Q_EPERM;
+			return (&result);
+		}
+
 		if (type == GRPQUOTA && unix_cred->aup_uid && unix_cred->aup_gid != id &&
 		    !in_group((gid_t *) unix_cred->aup_gids, unix_cred->aup_len, id)) {
 			result.status = Q_EPERM;
diff -Naur quota-tools.orig/set_limits_example.c quota-tools/set_limits_example.c
--- quota-tools.orig/set_limits_example.c	2001-07-18 07:58:31.000000000 +1000
+++ quota-tools/set_limits_example.c	2003-07-14 12:42:00.000000000 +1000
@@ -28,6 +28,29 @@
 	}
 }
 
+int copy_tree_quota_limits(const char *block_device, uid_t from, uid_t to)
+{
+	struct dqblk dq;
+
+	if (quotactl(QCMD(Q_GETQUOTA, TREEQUOTA), block_device, from, (caddr_t) & dq) == 0) {
+		if (quotactl(QCMD(Q_SETQLIM, TREEQUOTA), block_device, to, (caddr_t) & dq) == 0) {
+			return (0);
+		}
+		else {
+			errstr(
+				_("copy_tree_quota_limits: Failed to set treequota for uid %ld : %s\n"),
+				to, strerror(errno));
+			return (1);
+		}
+	}
+	else {
+		errstr(
+			_("copy_tree_quota_limits: Failed to get treequota for uid %ld : %s\n"),
+			from, strerror(errno));
+		return (1);
+	}
+}
+
 int copy_group_quota_limits(const char *block_device, gid_t from, gid_t to)
 {
 	struct dqblk dq;
diff -Naur quota-tools.orig/setquota.c quota-tools/setquota.c
--- quota-tools.orig/setquota.c	2003-07-14 14:18:16.000000000 +1000
+++ quota-tools/setquota.c	2003-07-14 12:42:00.000000000 +1000
@@ -28,6 +28,7 @@
 #define FL_PROTO 16
 #define FL_GRACE 32
 #define FL_INDIVIDUAL_GRACE 64
+#define FL_TREE 128
 
 int flags, fmt = -1;
 char **mnt;
@@ -78,6 +79,8 @@
 		return USRQUOTA;
 	if (flags & FL_GROUP)
 		return GRPQUOTA;
+	if (flags & FL_TREE)
+		return TREEQUOTA;
 	return -1;
 }
 
@@ -88,9 +91,9 @@
 	char *protoname = NULL;
 
 #ifdef RPC_SETQUOTA
-	char *opts = "igp:urVF:taT";
+	char *opts = "Yigp:urVF:taT";
 #else
-	char *opts = "igp:uVF:taT";
+	char *opts = "Yigp:uVF:taT";
 #endif
 
 	while ((ret = getopt(argcnt, argstr, opts)) != -1) {
@@ -104,6 +107,9 @@
 		  case 'u':
 			  flags |= FL_USER;
 			  break;
+		  case 'Y':
+			  flags |= FL_TREE;
+			  break;
 		  case 'p':
 			  flags |= FL_PROTO;
 			  protoname = optarg;
@@ -150,7 +156,7 @@
 		fputs(_("Bad number of arguments.\n"), stderr);
 		usage();
 	}
-	if (!(flags & (FL_USER | FL_GROUP)))
+	if (!(flags & (FL_USER | FL_GROUP | FL_TREE)))
 		flags |= FL_USER;
 	if (!(flags & FL_GRACE)) {
 		id = name2id(argstr[optind++], flag2type(flags));
@@ -247,7 +253,7 @@
 		q->dq_dqb.dqb_itime = toset.dqb_itime;
 	}
 	if (putprivs(curprivs, COMMIT_TIMES) == -1)
-		errstr(_("Can't write times for %s. Maybe kernel doesn't support such operation?\n"), type2name(flags & FL_USER ? USRQUOTA : GRPQUOTA));
+		errstr(_("Can't write times for %s. Maybe kernel doesn't support such operation?\n"), type2name(flags & FL_USER ? USRQUOTA : flags & FL_GROUP ? GRPQUOTA : TREEQUOTA));
 	freeprivs(curprivs);
 }
 
------------------------------------------------------
--- quotatools/quotasys.c~	2003-08-04 16:23:59.000000000 +1000
+++ quotatools/quotasys.c	2003-08-04 16:28:54.000000000 +1000
@@ -775,7 +775,7 @@
 		
 		/* Further we are not interested in mountpoints without quotas and
 		   we don't want to touch them */
-		if (!CORRECT_FSTYPE(mnt->mnt_type) || hasmntopt(mnt, MNTOPT_NOQUOTA) || !(hasmntopt(mnt, MNTOPT_USRQUOTA) || hasmntopt(mnt, MNTOPT_GRPQUOTA) || hasmntopt(mnt, MNTOPT_QUOTA) || !strcmp(mnt->mnt_type, MNTTYPE_NFS))) {
+		if (!CORRECT_FSTYPE(mnt->mnt_type) || hasmntopt(mnt, MNTOPT_NOQUOTA) || !(hasmntopt(mnt, MNTOPT_USRQUOTA) || hasmntopt(mnt, MNTOPT_GRPQUOTA) || hasmntopt(mnt, MNTOPT_TREEQUOTA) || hasmntopt(mnt, MNTOPT_QUOTA) || !strcmp(mnt->mnt_type, MNTTYPE_NFS))) {
 			free((char *)devname);
 			continue;
 		}
