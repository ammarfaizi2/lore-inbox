Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264283AbTEZF41 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 May 2003 01:56:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264288AbTEZF41
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 May 2003 01:56:27 -0400
Received: from thunk.org ([140.239.227.29]:11662 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S264283AbTEZF4U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 May 2003 01:56:20 -0400
Date: Sun, 25 May 2003 17:51:54 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Felix von Leitner <felix-kernel@fefe.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: corrupt ext3 that even debugfs refuses to repair
Message-ID: <20030525215154.GA705@think>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Felix von Leitner <felix-kernel@fefe.de>,
	linux-kernel@vger.kernel.org
References: <20030522132646.GB1506@codeblau.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030522132646.GB1506@codeblau.de>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 22, 2003 at 03:26:46PM +0200, Felix von Leitner wrote:
> I just found out that my CVS ext3 file system is corrupted.
> The symptom is that du complains about "file not found", i.e. getdents64
> returns the files but stat says they aren't there.
> 
> e2fsck finds nothing wrong with the filesystem.
> 
> I isolated the files into one directory which I moved to /broken.  This
> is what debugfs says:
> 
> # debugfs -w /dev/discs/disc0/part5
> debugfs 1.33 (21-Apr-2003)
> debugfs:  cd /broken
> debugfs:  ls
>  6243596  (12) .    2  (4084) ..    0  (4096) nsISO88592ToUnicode.cpp
>  0  (4096) nsKOI8UToUnicode.o    0  (4096) nsUnicodeToMacDevanagari.h
>  0  (4096) nsUnicodeToZapfDingbat.h    0  (620) nsCP1258ToUnicode.h
>  6243907  (3476) .cvsignore    0  (4096) nsMacUkrainianToUnicode.cpp
> debugfs:  rm foo
> rm: File not found by ext2_lookup while trying to resolve filename
> debugfs:  ls
> ls: invalid option -- o
> zsh: 5846 segmentation fault  debugfs -w /dev/discs/disc0/part5

This is actually completely irrelevant whatever to the filesystem
problems you're having.  This was a bug which was introduced in
debugfs in e2fsprogs 1.33 when I was trying to make it be portable to
BSD systems (specifically, Mac OSX).  Unfortunately, calling getopt()
on multiple command lines is not easy to do portably, and when I made
it work for MacOSX, I accidentally broke it for glibc.  The following
patch (attached) should solve your problem, or just run with the BK
repository version of e2fsprogs.

I'll release a new version of e2fsprogs once I get back from vacation
in Wales....

> Huh?  debugfs does not appear to be a very stable tool ;)
> Once again, with nsCP1258ToUnicode.h this time:
> 
> debugfs:  rm nsCP1258ToUnicode.h
> rm: File not found by ext2_lookup while trying to resolve filename
> debugfs:  unlink nsCP1258ToUnicode.h
> unlink_file_by_name: No free space in the directory

OK, couple of questions.  Did you run all of this with the filesystem
unmounted?  (Modifying a filesystem using debugfs while it is mounted
is dangerous in the extreme.)

Secondly, debugfs's commands are not necessarily the same as their
unix equivalents.  For example debugfs's "ls" command lists all
directory entries in the directory, regardless of whether or not they
are deleted.  According to the debugfs "ls" command, the only file
which should be in the broken directory is .cvsignore.  All of the
other directory entries are deleted.  

If the kernel was showing more than that, it implies that it somehow
got confused, and there were dentries in the cache that weren't in the
system.  However, if you unmounted the filesystem, ran e2fsck, and
remounted it, I would be very surprised indeed if you saw any files in
the /broken directory except for .cvsignore.

						- Ted

# This is a BitKeeper generated patch for the following project:
# Project Name: Ext2 filesystem utilities
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1206  -> 1.1207 
#	      debugfs/util.c	1.12    -> 1.13   
#	   debugfs/debugfs.c	1.59    -> 1.60   
#	      debugfs/dump.c	1.13    -> 1.14   
#	   debugfs/debugfs.h	1.15    -> 1.16   
#	   debugfs/ChangeLog	1.127   -> 1.128  
#	     debugfs/htree.c	1.9     -> 1.10   
#	        debugfs/ls.c	1.12    -> 1.13   
#	   debugfs/logdump.c	1.9     -> 1.10   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/05/13	tytso@think.thunk.org	1.1207
# util.c, ls.c, logdump.c, htree.c, dump.c, debugfs.h, debugfs.c, ChangeLog:
#   util.c (reset_getopt), debugfs.c (do_open_filesys,
#   	do_show_super_stats), ls.c (do_list_dir), dump.c (do_dump),
#   	htree.c (do_htree_dump, do_dx_hash), logdump.c (do_logdump):
#   	Define and use a new function, reset_getopt(), which does whatever
#   	is necessary to reset getopt() again.  This is different for
#   	different implementations, so the portabilty issues are a bit of a
#   	nightmare.  (Addresses Debian bug #192834)
# --------------------------------------------
#
diff -Nru a/debugfs/ChangeLog b/debugfs/ChangeLog
--- a/debugfs/ChangeLog	Sun May 25 17:40:28 2003
+++ b/debugfs/ChangeLog	Sun May 25 17:40:28 2003
@@ -1,3 +1,13 @@
+2003-05-13  root  <tytso@mit.edu>
+
+	* util.c (reset_getopt), debugfs.c (do_open_filesys,
+	do_show_super_stats), ls.c (do_list_dir), dump.c (do_dump),
+	htree.c (do_htree_dump, do_dx_hash), logdump.c (do_logdump):
+	Define and use a new function, reset_getopt(), which does whatever
+	is necessary to reset getopt() again.  This is different for
+	different implementations, so the portabilty issues are a bit of a
+	nightmare.  (Addresses Debian bug #192834)
+	
 2003-05-05  Theodore Ts'o  <tytso@mit.edu>
 
 	* debugfs.c (do_imap), debugfs.h, debug_cmds.ct, debugfs.8.in:
diff -Nru a/debugfs/util.c b/debugfs/util.c
--- a/debugfs/util.c	Sun May 25 17:40:28 2003
+++ b/debugfs/util.c	Sun May 25 17:40:28 2003
@@ -13,8 +13,48 @@
 #include <string.h>
 #include <time.h>
 #include <signal.h>
+#ifdef HAVE_GETOPT_H
+#include <getopt.h>
+#else 
+extern int optind;
+extern char *optarg;
+#endif
+#ifdef HAVE_OPTRESET
+extern int optreset;		/* defined by BSD, but not others */
+#endif
 
 #include "debugfs.h"
+
+/*
+ * This function resets the libc getopt() function, which keeps
+ * internal state.  Bad design!  Stupid libc API designers!  No
+ * biscuit!
+ *
+ * BSD-derived getopt() functions require that optind be reset to 1 in
+ * order to reset getopt() state.  This used to be generally accepted
+ * way of resetting getopt().  However, glibc's getopt()
+ * has additional getopt() state beyond optind, and requires that
+ * optind be set zero to reset its state.  So the unfortunate state of
+ * affairs is that BSD-derived versions of getopt() misbehave if
+ * optind is set to 0 in order to reset getopt(), and glibc's getopt()
+ * will core ump if optind is set 1 in order to reset getopt().
+ * 
+ * More modern versions of BSD require that optreset be set to 1 in
+ * order to reset getopt().   Sigh.  Standards, anyone?
+ *
+ * We hide the hair here.
+ */
+void reset_getopt(void)
+{
+#ifdef __GLIBC__
+	optind = 0;
+#else
+	optind = 1;
+#endif
+#ifdef HAVE_OPTRESET
+	optreset = 1;		/* Makes BSD getopt happy */
+#endif
+}	
 
 FILE *open_pager(void)
 {
diff -Nru a/debugfs/debugfs.c b/debugfs/debugfs.c
--- a/debugfs/debugfs.c	Sun May 25 17:40:28 2003
+++ b/debugfs/debugfs.c	Sun May 25 17:40:28 2003
@@ -20,9 +20,6 @@
 extern int optind;
 extern char *optarg;
 #endif
-#ifdef HAVE_OPTRESET
-extern int optreset;		/* defined by BSD, but not others */
-#endif
 #ifdef HAVE_ERRNO_H
 #include <errno.h>
 #endif
@@ -101,10 +98,7 @@
 	blk_t	blocksize = 0;
 	int open_flags = 0;
 	
-	optind = 1;
-#ifdef HAVE_OPTRESET
-	optreset = 1;		/* Makes BSD getopt happy */
-#endif
+	reset_getopt();
 	while ((c = getopt (argc, argv, "iwfcb:s:")) != EOF) {
 		switch (c) {
 		case 'i':
@@ -242,10 +236,7 @@
 	int	numdirs = 0;
 	const char *usage = "Usage: show_super [-h]";
 
-	optind = 1;
-#ifdef HAVE_OPTRESET
-	optreset = 1;		/* Makes BSD getopt happy */
-#endif
+	reset_getopt();
 	while ((c = getopt (argc, argv, "h")) != EOF) {
 		switch (c) {
 		case 'h':
@@ -1486,7 +1477,7 @@
 		return;
 	ino = string_to_inode(argv[1]);
 	if (!ino)
-		return 0;
+		return;
 
 	group = (ino - 1) / EXT2_INODES_PER_GROUP(current_fs->super);
 	offset = ((ino - 1) % EXT2_INODES_PER_GROUP(current_fs->super)) *
diff -Nru a/debugfs/debugfs.h b/debugfs/debugfs.h
--- a/debugfs/debugfs.h	Sun May 25 17:40:28 2003
+++ b/debugfs/debugfs.h	Sun May 25 17:40:28 2003
@@ -22,6 +22,7 @@
 extern ext2_filsys current_fs;
 extern ext2_ino_t	root, cwd;
 
+extern void reset_getopt(void);
 extern FILE *open_pager(void);
 extern void close_pager(FILE *stream);
 extern int check_fs_open(char *name);
diff -Nru a/debugfs/dump.c b/debugfs/dump.c
--- a/debugfs/dump.c	Sun May 25 17:40:28 2003
+++ b/debugfs/dump.c	Sun May 25 17:40:28 2003
@@ -24,9 +24,6 @@
 extern int optind;
 extern char *optarg;
 #endif
-#ifdef HAVE_OPTRESET
-extern int optreset;		/* defined by BSD, but not others */
-#endif
 
 #include "debugfs.h"
 
@@ -149,10 +146,7 @@
 	const char *dump_usage = "Usage: dump_inode [-p] <file> <output_file>";
 	char		*in_fn, *out_fn;
 	
-	optind = 1;
-#ifdef HAVE_OPTRESET
-	optreset = 1;		/* Makes BSD getopt happy */
-#endif
+	reset_getopt();
 	while ((c = getopt (argc, argv, "p")) != EOF) {
 		switch (c) {
 		case 'p':
diff -Nru a/debugfs/htree.c b/debugfs/htree.c
--- a/debugfs/htree.c	Sun May 25 17:40:28 2003
+++ b/debugfs/htree.c	Sun May 25 17:40:28 2003
@@ -21,9 +21,6 @@
 extern int optind;
 extern char *optarg;
 #endif
-#ifdef HAVE_OPTRESET
-extern int optreset;		/* defined by BSD, but not others */
-#endif
 
 #include "debugfs.h"
 
@@ -193,10 +190,7 @@
 
 	pager = open_pager();
 
-	optind = 1;
-#ifdef HAVE_OPTRESET
-	optreset = 1;		/* Makes BSD getopt happy */
-#endif
+	reset_getopt();
 	while ((c = getopt (argc, argv, "l")) != EOF) {
 		switch (c) {
 		case 'l':
@@ -277,10 +271,8 @@
 	__u32		hash_seed[4];
 	
 	hash_seed[0] = hash_seed[1] = hash_seed[2] = hash_seed[3] = 0;
-	optind = 1;
-#ifdef HAVE_OPTRESET
-	optreset = 1;		/* Makes BSD getopt happy */
-#endif
+
+	reset_getopt();
 	while ((c = getopt (argc, argv, "h:")) != EOF) {
 		switch (c) {
 		case 'h':
diff -Nru a/debugfs/logdump.c b/debugfs/logdump.c
--- a/debugfs/logdump.c	Sun May 25 17:40:28 2003
+++ b/debugfs/logdump.c	Sun May 25 17:40:28 2003
@@ -28,9 +28,6 @@
 extern int optind;
 extern char *optarg;
 #endif
-#ifdef HAVE_OPTRESET
-extern int optreset;		/* defined by BSD, but not others */
-#endif
 
 #include "debugfs.h"
 #include "blkid/blkid.h"
@@ -92,10 +89,6 @@
 	struct journal_source journal_source;
 	struct ext2_super_block *es = NULL;
 	
-	optind = 1;
-#ifdef HAVE_OPTRESET
-	optreset = 1;		/* Makes BSD getopt happy */
-#endif
 	journal_source.where = 0;
 	journal_source.fd = 0;
 	journal_source.file = 0;
@@ -107,6 +100,7 @@
 	inode_block_to_dump = -1;
 	inode_to_dump = -1;
 	
+	reset_getopt();
 	while ((c = getopt (argc, argv, "ab:ci:f:")) != EOF) {
 		switch (c) {
 		case 'a':
diff -Nru a/debugfs/ls.c b/debugfs/ls.c
--- a/debugfs/ls.c	Sun May 25 17:40:28 2003
+++ b/debugfs/ls.c	Sun May 25 17:40:28 2003
@@ -21,9 +21,6 @@
 extern int optind;
 extern char *optarg;
 #endif
-#ifdef HAVE_OPTRESET
-extern int optreset;		/* defined by BSD, but not others */
-#endif
 
 #include "debugfs.h"
 
@@ -125,10 +122,7 @@
 	if (check_fs_open(argv[0]))
 		return;
 
-	optind = 1;
-#ifdef HAVE_OPTRESET
-	optreset = 1;		/* Makes BSD getopt happy */
-#endif
+	reset_getopt();
 	while ((c = getopt (argc, argv, "dl")) != EOF) {
 		switch (c) {
 		case 'l':
