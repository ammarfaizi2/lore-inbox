Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281562AbRKPVpM>; Fri, 16 Nov 2001 16:45:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281564AbRKPVpE>; Fri, 16 Nov 2001 16:45:04 -0500
Received: from smtp01.web.de ([194.45.170.210]:37408 "EHLO smtp.web.de")
	by vger.kernel.org with ESMTP id <S281559AbRKPVot>;
	Fri, 16 Nov 2001 16:44:49 -0500
Date: Fri, 16 Nov 2001 22:47:15 +0100
From: =?ISO-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] strtok --> strsep in filesystem drivers (part 2)
Message-Id: <20011116224715.68875ced.l.s.r@web.de>
X-Mailer: Sylpheed version 0.6.1 (GTK+ 1.2.10; i586-mandrake-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

this part finishes off the rest of the strtok() calls in filesystem
drivers. In some of them (FAT, VFAT, NTFS) we need to declare our own
char pointer to preserve the value of the original pointer. Apart from
that it's just a plain strtok() replacement. Please, apply.

René



diff -Nur linux-2.4.15-pre5/fs/fat/inode.c linux-2.4.15-pre5-rs/fs/fat/inode.c
--- linux-2.4.15-pre5/fs/fat/inode.c	Fri Oct 26 23:07:22 2001
+++ linux-2.4.15-pre5-rs/fs/fat/inode.c	Fri Nov 16 23:06:49 2001
@@ -211,6 +211,7 @@
 {
 	char *this_char,*value,save,*savep;
 	char *p;
+	char *params = options;
 	int ret = 1, len;
 
 	opts->name_check = 'n';
@@ -230,8 +231,9 @@
 		goto out;
 	save = 0;
 	savep = NULL;
-	for (this_char = strtok(options,","); this_char;
-	     this_char = strtok(NULL,",")) {
+	while ((this_char = strsep(&params)) != NULL) {
+		if (!*this_char)
+			continue;
 		if ((value = strchr(this_char,'=')) != NULL) {
 			save = *value;
 			savep = value;
diff -Nur linux-2.4.15-pre5/fs/nfs/nfsroot.c linux-2.4.15-pre5-rs/fs/nfs/nfsroot.c
--- linux-2.4.15-pre5/fs/nfs/nfsroot.c	Fri Jul 20 06:47:16 2001
+++ linux-2.4.15-pre5-rs/fs/nfs/nfsroot.c	Fri Nov 16 21:30:26 2001
@@ -202,8 +202,9 @@
 
 	if ((options = strchr(name, ','))) {
 		*options++ = 0;
-		cp = strtok(options, ",");
-		while (cp) {
+		while ((cp = strsep(&options, ",")) != NULL) {
+			if (!*cp)
+				continue;
 			if ((val = strchr(cp, '='))) {
 				struct nfs_int_opts *opts = root_int_opts;
 				*val++ = '\0';
@@ -220,7 +221,6 @@
 					nfs_data.flags |= opts->or_mask;
 				}
 			}
-			cp = strtok(NULL, ",");
 		}
 	}
 	if (name[0] && strcmp(name, "default")) {
diff -Nur linux-2.4.15-pre5/fs/ntfs/fs.c linux-2.4.15-pre5-rs/fs/ntfs/fs.c
--- linux-2.4.15-pre5/fs/ntfs/fs.c	Fri Oct 26 23:07:22 2001
+++ linux-2.4.15-pre5-rs/fs/ntfs/fs.c	Fri Nov 16 23:09:58 2001
@@ -365,10 +365,13 @@
 	int use_utf8 = -1;	/* If no NLS specified and loading the default
 				   NLS failed use utf8. */
 	int mft_zone_mul = -1;	/* 1 */
+	char *options = opt;
 
 	if (!opt)
 		goto done;
-	for (opt = strtok(opt, ","); opt; opt = strtok(NULL, ",")) {
+	while ((opt = strsep(&options, ",")) != NULL) {
+		if (!*opt)
+			continue;
 		if ((value = strchr(opt, '=')) != NULL)
 			*value ++= '\0';
 		if (strcmp(opt, "uid") == 0) {
diff -Nur linux-2.4.15-pre5/fs/vfat/namei.c linux-2.4.15-pre5-rs/fs/vfat/namei.c
--- linux-2.4.15-pre5/fs/vfat/namei.c	Fri Oct 26 23:07:23 2001
+++ linux-2.4.15-pre5-rs/fs/vfat/namei.c	Fri Nov 16 23:12:34 2001
@@ -103,6 +103,7 @@
 static int parse_options(char *options,	struct fat_mount_options *opts)
 {
 	char *this_char,*value,save,*savep;
+	char *params = options;
 	int ret, val;
 
 	opts->unicode_xlate = opts->posixfs = 0;
@@ -120,7 +121,9 @@
 	save = 0;
 	savep = NULL;
 	ret = 1;
-	for (this_char = strtok(options,","); this_char; this_char = strtok(NULL,",")) {
+	while ((this_char = strsep(&params,",")) != NULL) {
+		if (!*this_char)
+			continue;
 		if ((value = strchr(this_char,'=')) != NULL) {
 			save = *value;
 			savep = value;
diff -Nur linux-2.4.15-pre5/mm/shmem.c linux-2.4.15-pre5-rs/mm/shmem.c
--- linux-2.4.15-pre5/mm/shmem.c	Fri Nov 16 18:43:07 2001
+++ linux-2.4.15-pre5-rs/mm/shmem.c	Fri Nov 16 23:36:00 2001
@@ -1195,10 +1195,9 @@
 {
 	char *this_char, *value, *rest;
 
-	this_char = NULL;
-	if ( options )
-		this_char = strtok(options,",");
-	for ( ; this_char; this_char = strtok(NULL,",")) {
+	while ((this_char = strsep(&options,",")) != NULL) {
+		if (!*this_char)
+			continue;
 		if ((value = strchr(this_char,'=')) != NULL) {
 			*value++ = 0;
 		} else {
