Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279634AbRJXXNJ>; Wed, 24 Oct 2001 19:13:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279637AbRJXXM7>; Wed, 24 Oct 2001 19:12:59 -0400
Received: from mailgate5.cinetic.de ([217.72.192.165]:52879 "EHLO
	mailgate5.cinetic.de") by vger.kernel.org with ESMTP
	id <S279636AbRJXXMz>; Wed, 24 Oct 2001 19:12:55 -0400
Message-Id: <m15wXD7-007qcQC@smtp.web.de>
Content-Type: text/plain;
  charset="iso-8859-15"
From: =?iso-8859-15?q?Ren=E9=20Scharfe?= <l.s.r@web.de>
To: Alan Cox <alan@redhat.com>, Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH] strtok --> strsep in filesystem drivers
Date: Thu, 25 Oct 2001 01:02:51 +0200
X-Mailer: KMail [version 1.3.1]
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

here comes another strtok related patch. This time all strtok calls in
filesystem drivers are converted to strsep calls.

This patch is made against kernel 2.4.13 and applies, with some
offsets, against kernel 2.4.12-ac6, too.

As usual, I did NOT test this patch. ;) It compiles, though. Please
apply.

René



diff -ruN linux-2.4.13/fs/adfs/super.c linux-2.4.13-rs/fs/adfs/super.c
--- linux-2.4.13/fs/adfs/super.c	Wed Oct 24 21:07:53 2001
+++ linux-2.4.13-rs/fs/adfs/super.c	Wed Oct 24 22:32:00 2001
@@ -171,7 +171,9 @@
 	if (!options)
 		return 0;
 
-	for (opt = strtok(options, ","); opt != NULL; opt = strtok(NULL, ",")) {
+	while (opt = strsep(&options, ",")) {
+		if (!*opt)
+			continue;
 		value = strchr(opt, '=');
 		if (value)
 			*value++ = '\0';
diff -ruN linux-2.4.13/fs/affs/super.c linux-2.4.13-rs/fs/affs/super.c
--- linux-2.4.13/fs/affs/super.c	Wed Oct 24 21:07:53 2001
+++ linux-2.4.13-rs/fs/affs/super.c	Wed Oct 24 22:32:00 2001
@@ -109,7 +109,9 @@
 	*mount_opts = 0;
 	if (!options)
 		return 1;
-	for (this_char = strtok(options,","); this_char; this_char = strtok(NULL,",")) {
+	while (this_char = strsep(&options, ",")) {
+		if (!*this_char)
+			continue;
 		f = 0;
 		if ((value = strchr(this_char,'=')) != NULL)
 			*value++ = 0;
diff -ruN linux-2.4.13/fs/autofs/inode.c linux-2.4.13-rs/fs/autofs/inode.c
--- linux-2.4.13/fs/autofs/inode.c	Wed Oct 24 21:07:53 2001
+++ linux-2.4.13-rs/fs/autofs/inode.c	Wed Oct 24 22:32:00 2001
@@ -60,7 +60,9 @@
 	*pipefd = -1;
 
 	if ( !options ) return 1;
-	for (this_char = strtok(options,","); this_char; this_char = strtok(NULL,",")) {
+	while (this_char = strsep(&options,",")) {
+		if (!*this_char)
+			continue;
 		if ((value = strchr(this_char,'=')) != NULL)
 			*value++ = 0;
 		if (!strcmp(this_char,"fd")) {
diff -ruN linux-2.4.13/fs/autofs4/inode.c linux-2.4.13-rs/fs/autofs4/inode.c
--- linux-2.4.13/fs/autofs4/inode.c	Wed Oct 24 21:07:53 2001
+++ linux-2.4.13-rs/fs/autofs4/inode.c	Wed Oct 24 22:32:00 2001
@@ -112,7 +112,9 @@
 	*pipefd = -1;
 
 	if ( !options ) return 1;
-	for (this_char = strtok(options,","); this_char; this_char = strtok(NULL,",")) {
+	while (this_char = strsep(&options,",")) {
+		if (!*this_char)
+			continue;
 		if ((value = strchr(this_char,'=')) != NULL)
 			*value++ = 0;
 		if (!strcmp(this_char,"fd")) {
diff -ruN linux-2.4.13/fs/devpts/inode.c linux-2.4.13-rs/fs/devpts/inode.c
--- linux-2.4.13/fs/devpts/inode.c	Wed Oct 24 21:07:53 2001
+++ linux-2.4.13-rs/fs/devpts/inode.c	Wed Oct 24 22:48:20 2001
@@ -66,10 +66,11 @@
 	umode_t mode = 0600;
 	char *this_char, *value;
 
-	this_char = NULL;
-	if ( options )
-		this_char = strtok(options,",");
-	for ( ; this_char; this_char = strtok(NULL,",")) {
+	if (!options)
+		goto default_settings;
+	while ( this_char = strsep(&options,",") ) {
+		if (!*this_char)
+			continue;
 		if ((value = strchr(this_char,'=')) != NULL)
 			*value++ = 0;
 		if (!strcmp(this_char,"uid")) {
@@ -98,6 +99,7 @@
 		else
 			return 1;
 	}
+default_settings:
 	sbi->setuid  = setuid;
 	sbi->setgid  = setgid;
 	sbi->uid     = uid;
diff -ruN linux-2.4.13/fs/ext2/super.c linux-2.4.13-rs/fs/ext2/super.c
--- linux-2.4.13/fs/ext2/super.c	Wed Oct 24 21:07:53 2001
+++ linux-2.4.13-rs/fs/ext2/super.c	Wed Oct 24 22:32:00 2001
@@ -166,9 +166,9 @@
 
 	if (!options)
 		return 1;
-	for (this_char = strtok (options, ",");
-	     this_char != NULL;
-	     this_char = strtok (NULL, ",")) {
+	while (this_char = strsep (&options, ",")) {
+		if (!*this_char)
+			continue;
 		if ((value = strchr (this_char, '=')) != NULL)
 			*value++ = 0;
 		if (!strcmp (this_char, "bsddf"))
diff -ruN linux-2.4.13/fs/fat/inode.c linux-2.4.13-rs/fs/fat/inode.c
--- linux-2.4.13/fs/fat/inode.c	Wed Oct 24 21:07:53 2001
+++ linux-2.4.13-rs/fs/fat/inode.c	Wed Oct 24 22:32:00 2001
@@ -210,7 +210,7 @@
 			 char *cvf_format, char *cvf_options)
 {
 	char *this_char,*value,save,*savep;
-	char *p;
+	char *p,*options_p = options;
 	int ret = 1, len;
 
 	opts->name_check = 'n';
@@ -230,8 +230,7 @@
 		goto out;
 	save = 0;
 	savep = NULL;
-	for (this_char = strtok(options,","); this_char;
-	     this_char = strtok(NULL,",")) {
+	while (this_char = strsep(&options_p, ",")) {
 		if ((value = strchr(this_char,'=')) != NULL) {
 			save = *value;
 			savep = value;
diff -ruN linux-2.4.13/fs/hfs/super.c linux-2.4.13-rs/fs/hfs/super.c
--- linux-2.4.13/fs/hfs/super.c	Wed Oct 24 21:07:53 2001
+++ linux-2.4.13-rs/fs/hfs/super.c	Wed Oct 24 22:32:00 2001
@@ -181,8 +181,9 @@
 	if (!options) {
 		goto done;
 	}
-	for (this_char = strtok(options,","); this_char;
-	     this_char = strtok(NULL,",")) {
+	while (this_char = strsep(&options, ",")) {
+		if (!*this_char)
+			continue;
 		if ((value = strchr(this_char,'=')) != NULL) {
 			*value++ = 0;
 		}
diff -ruN linux-2.4.13/fs/hpfs/super.c linux-2.4.13-rs/fs/hpfs/super.c
--- linux-2.4.13/fs/hpfs/super.c	Wed Oct 24 21:07:53 2001
+++ linux-2.4.13-rs/fs/hpfs/super.c	Wed Oct 24 22:32:00 2001
@@ -176,7 +176,9 @@
 
 	/*printk("Parsing opts: '%s'\n",opts);*/
 
-	for (p = strtok(opts, ","); p != 0; p = strtok(0, ",")) {
+	while (p = strsep(&opts, ",")) {
+		if (!*p)
+			continue;
 		if ((rhs = strchr(p, '=')) != 0)
 			*rhs++ = '\0';
 		if (!strcmp(p, "help")) return 2;
diff -ruN linux-2.4.13/fs/isofs/inode.c linux-2.4.13-rs/fs/isofs/inode.c
--- linux-2.4.13/fs/isofs/inode.c	Wed Oct 24 21:07:53 2001
+++ linux-2.4.13-rs/fs/isofs/inode.c	Wed Oct 24 22:32:00 2001
@@ -290,7 +290,9 @@
 	popt->session=-1;
 	popt->sbsector=-1;
 	if (!options) return 1;
-	for (this_char = strtok(options,","); this_char; this_char = strtok(NULL,",")) {
+	while (this_char = strsep(&options,",")) {
+		if (!*this_char)
+			continue;
 	        if (strncmp(this_char,"norock",6) == 0) {
 		  popt->rock = 'n';
 		  continue;
diff -ruN linux-2.4.13/fs/nfs/nfsroot.c linux-2.4.13-rs/fs/nfs/nfsroot.c
--- linux-2.4.13/fs/nfs/nfsroot.c	Wed Oct 24 21:07:53 2001
+++ linux-2.4.13-rs/fs/nfs/nfsroot.c	Wed Oct 24 23:06:38 2001
@@ -202,8 +202,9 @@
 
 	if ((options = strchr(name, ','))) {
 		*options++ = 0;
-		cp = strtok(options, ",");
-		while (cp) {
+		while (cp = strsep(&options, ",")) {
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
diff -ruN linux-2.4.13/fs/ntfs/fs.c linux-2.4.13-rs/fs/ntfs/fs.c
--- linux-2.4.13/fs/ntfs/fs.c	Wed Oct 24 21:07:53 2001
+++ linux-2.4.13-rs/fs/ntfs/fs.c	Wed Oct 24 23:04:14 2001
@@ -365,10 +365,13 @@
 	int use_utf8 = -1;	/* If no NLS specified and loading the default
 				   NLS failed use utf8. */
 	int mft_zone_mul = -1;	/* 1 */
+	char *options = opt;
 
 	if (!opt)
 		goto done;
-	for (opt = strtok(opt, ","); opt; opt = strtok(NULL, ",")) {
+	while (opt = strsep(&options, ",")) {
+		if (!*opt)
+			continue;
 		if ((value = strchr(opt, '=')) != NULL)
 			*value ++= '\0';
 		if (strcmp(opt, "uid") == 0) {
diff -ruN linux-2.4.13/fs/proc/inode.c linux-2.4.13-rs/fs/proc/inode.c
--- linux-2.4.13/fs/proc/inode.c	Wed Oct 24 21:07:53 2001
+++ linux-2.4.13-rs/fs/proc/inode.c	Wed Oct 24 22:32:00 2001
@@ -106,7 +106,9 @@
 	*uid = current->uid;
 	*gid = current->gid;
 	if (!options) return 1;
-	for (this_char = strtok(options,","); this_char; this_char = strtok(NULL,",")) {
+	while (this_char = strsep(&options,",")) {
+		if (!*this_char)
+			continue;
 		if ((value = strchr(this_char,'=')) != NULL)
 			*value++ = 0;
 		if (!strcmp(this_char,"uid")) {
diff -ruN linux-2.4.13/fs/reiserfs/super.c linux-2.4.13-rs/fs/reiserfs/super.c
--- linux-2.4.13/fs/reiserfs/super.c	Wed Oct 24 21:07:53 2001
+++ linux-2.4.13-rs/fs/reiserfs/super.c	Wed Oct 24 22:32:00 2001
@@ -144,7 +144,9 @@
 	/* use default configuration: create tails, journaling on, no
            conversion to newest format */
 	return 1;
-    for (this_char = strtok (options, ","); this_char != NULL; this_char = strtok (NULL, ",")) {
+    while (this_char = strsep (&options, ",")) {
+	if (!*this_char)
+	    continue;
 	if ((value = strchr (this_char, '=')) != NULL)
 	    *value++ = 0;
 	if (!strcmp (this_char, "notail")) {
diff -ruN linux-2.4.13/fs/udf/super.c linux-2.4.13-rs/fs/udf/super.c
--- linux-2.4.13/fs/udf/super.c	Wed Oct 24 21:07:53 2001
+++ linux-2.4.13-rs/fs/udf/super.c	Wed Oct 24 22:32:00 2001
@@ -218,8 +218,10 @@
 	if (!options)
 		return 1;
 
-	for (opt = strtok(options, ","); opt; opt = strtok(NULL, ","))
+	while (opt = strsep(&options, ","))
 	{
+		if (!*opt)
+			continue;
 		/* Make "opt=val" into two strings */
 		val = strchr(opt, '=');
 		if (val)
diff -ruN linux-2.4.13/fs/ufs/super.c linux-2.4.13-rs/fs/ufs/super.c
--- linux-2.4.13/fs/ufs/super.c	Wed Oct 24 21:07:53 2001
+++ linux-2.4.13-rs/fs/ufs/super.c	Wed Oct 24 22:32:00 2001
@@ -257,10 +257,9 @@
 	if (!options)
 		return 1;
 		
-	for (this_char = strtok (options, ",");
-	     this_char != NULL;
-	     this_char = strtok (NULL, ",")) {
-	     
+	while (this_char = strsep (&options, ",")) {
+		if (!*this_char)
+			continue;
 		if ((value = strchr (this_char, '=')) != NULL)
 			*value++ = 0;
 		if (!strcmp (this_char, "ufstype")) {
diff -ruN linux-2.4.13/fs/vfat/namei.c linux-2.4.13-rs/fs/vfat/namei.c
--- linux-2.4.13/fs/vfat/namei.c	Wed Oct 24 21:07:53 2001
+++ linux-2.4.13-rs/fs/vfat/namei.c	Wed Oct 24 22:32:00 2001
@@ -104,6 +104,7 @@
 {
 	char *this_char,*value,save,*savep;
 	int ret, val;
+	char *options_p = options;
 
 	opts->unicode_xlate = opts->posixfs = 0;
 	opts->numtail = 1;
@@ -120,7 +121,7 @@
 	save = 0;
 	savep = NULL;
 	ret = 1;
-	for (this_char = strtok(options,","); this_char; this_char = strtok(NULL,",")) {
+	while (this_char = strsep(&options_p, ",")) {
 		if ((value = strchr(this_char,'=')) != NULL) {
 			save = *value;
 			savep = value;
diff -ruN linux-2.4.13/mm/shmem.c linux-2.4.13-rs/mm/shmem.c
--- linux-2.4.13/mm/shmem.c	Wed Oct 24 21:07:53 2001
+++ linux-2.4.13-rs/mm/shmem.c	Wed Oct 24 22:53:51 2001
@@ -1237,10 +1237,11 @@
 {
 	char *this_char, *value, *rest;
 
-	this_char = NULL;
-	if ( options )
-		this_char = strtok(options,",");
-	for ( ; this_char; this_char = strtok(NULL,",")) {
+	if (!options)
+		return 0;
+	while (this_char = strsep(&options,",")) {
+		if (!*this_char)
+			continue;
 		if ((value = strchr(this_char,'=')) != NULL) {
 			*value++ = 0;
 		} else {

