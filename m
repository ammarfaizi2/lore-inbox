Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281546AbRKPU3i>; Fri, 16 Nov 2001 15:29:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281548AbRKPU33>; Fri, 16 Nov 2001 15:29:29 -0500
Received: from smtp01.web.de ([194.45.170.210]:64035 "EHLO smtp.web.de")
	by vger.kernel.org with ESMTP id <S281546AbRKPU3M>;
	Fri, 16 Nov 2001 15:29:12 -0500
Date: Fri, 16 Nov 2001 21:31:32 +0100
From: =?ISO-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] strtok --> strsep in filesystem drivers (part 1)
Message-Id: <20011116213132.2d385619.l.s.r@web.de>
X-Mailer: Sylpheed version 0.6.1 (GTK+ 1.2.10; i586-mandrake-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello again,

patch below is for making most of the filesystem drivers strtok()-free.
Part 2 will consist of some not so boring chunks.

As usual, the patch is untested. It survived a heavy staring-at-it,
though. ;) Please, apply.

René



diff -Nur linux-2.4.15-pre5/fs/adfs/super.c linux-2.4.15-pre5-rs/fs/adfs/super.c
--- linux-2.4.15-pre5/fs/adfs/super.c	Thu Nov  8 22:51:16 2001
+++ linux-2.4.15-pre5-rs/fs/adfs/super.c	Fri Nov 16 21:40:19 2001
@@ -171,7 +171,9 @@
 	if (!options)
 		return 0;
 
-	for (opt = strtok(options, ","); opt != NULL; opt = strtok(NULL, ",")) {
+	while ((opt = strsep(&options, ",")) != NULL) {
+		if (!*opt)
+			continue;
 		value = strchr(opt, '=');
 		if (value)
 			*value++ = '\0';
diff -Nur linux-2.4.15-pre5/fs/affs/super.c linux-2.4.15-pre5-rs/fs/affs/super.c
--- linux-2.4.15-pre5/fs/affs/super.c	Fri Nov 16 18:43:03 2001
+++ linux-2.4.15-pre5-rs/fs/affs/super.c	Fri Nov 16 21:42:58 2001
@@ -109,7 +109,9 @@
 	*mount_opts = 0;
 	if (!options)
 		return 1;
-	for (this_char = strtok(options,","); this_char; this_char = strtok(NULL,",")) {
+	while ((this_char = strsep(&options, ",")) != NULL) {
+		if (!*this_char)
+			continue;
 		f = 0;
 		if ((value = strchr(this_char,'=')) != NULL)
 			*value++ = 0;
diff -Nur linux-2.4.15-pre5/fs/autofs/inode.c linux-2.4.15-pre5-rs/fs/autofs/inode.c
--- linux-2.4.15-pre5/fs/autofs/inode.c	Thu Jun 14 23:16:58 2001
+++ linux-2.4.15-pre5-rs/fs/autofs/inode.c	Fri Nov 16 22:10:06 2001
@@ -60,7 +60,9 @@
 	*pipefd = -1;
 
 	if ( !options ) return 1;
-	for (this_char = strtok(options,","); this_char; this_char = strtok(NULL,",")) {
+	while ((this_char = strsep(&options,",")) != NULL) {
+		if (!*this_char)
+			continue;
 		if ((value = strchr(this_char,'=')) != NULL)
 			*value++ = 0;
 		if (!strcmp(this_char,"fd")) {
diff -Nur linux-2.4.15-pre5/fs/autofs4/inode.c linux-2.4.15-pre5-rs/fs/autofs4/inode.c
--- linux-2.4.15-pre5/fs/autofs4/inode.c	Fri Nov 16 18:43:03 2001
+++ linux-2.4.15-pre5-rs/fs/autofs4/inode.c	Fri Nov 16 22:04:20 2001
@@ -112,7 +112,9 @@
 	*pipefd = -1;
 
 	if ( !options ) return 1;
-	for (this_char = strtok(options,","); this_char; this_char = strtok(NULL,",")) {
+	while ((this_char = strsep(&options,",")) != NULL) {
+		if (!*this_char)
+			continue;
 		if ((value = strchr(this_char,'=')) != NULL)
 			*value++ = 0;
 		if (!strcmp(this_char,"fd")) {
diff -Nur linux-2.4.15-pre5/fs/devpts/inode.c linux-2.4.15-pre5-rs/fs/devpts/inode.c
--- linux-2.4.15-pre5/fs/devpts/inode.c	Sun Sep 30 21:26:08 2001
+++ linux-2.4.15-pre5-rs/fs/devpts/inode.c	Fri Nov 16 22:02:25 2001
@@ -66,10 +66,9 @@
 	umode_t mode = 0600;
 	char *this_char, *value;
 
-	this_char = NULL;
-	if ( options )
-		this_char = strtok(options,",");
-	for ( ; this_char; this_char = strtok(NULL,",")) {
+	while ((this_char = strsep(&options,",")) != NULL) {
+		if (!*this_char)
+			continue;
 		if ((value = strchr(this_char,'=')) != NULL)
 			*value++ = 0;
 		if (!strcmp(this_char,"uid")) {
diff -Nur linux-2.4.15-pre5/fs/ext2/super.c linux-2.4.15-pre5-rs/fs/ext2/super.c
--- linux-2.4.15-pre5/fs/ext2/super.c	Fri Nov 16 18:43:03 2001
+++ linux-2.4.15-pre5-rs/fs/ext2/super.c	Fri Nov 16 21:44:34 2001
@@ -166,9 +166,9 @@
 
 	if (!options)
 		return 1;
-	for (this_char = strtok (options, ",");
-	     this_char != NULL;
-	     this_char = strtok (NULL, ",")) {
+	while ((this_char = strsep (&options, ",")) != NULL) {
+		if (!*this_char)
+			continue;
 		if ((value = strchr (this_char, '=')) != NULL)
 			*value++ = 0;
 		if (!strcmp (this_char, "bsddf"))
diff -Nur linux-2.4.15-pre5/fs/ext3/super.c linux-2.4.15-pre5-rs/fs/ext3/super.c
--- linux-2.4.15-pre5/fs/ext3/super.c	Fri Nov 16 18:43:03 2001
+++ linux-2.4.15-pre5-rs/fs/ext3/super.c	Fri Nov 16 21:47:38 2001
@@ -505,9 +505,9 @@
 
 	if (!options)
 		return 1;
-	for (this_char = strtok (options, ",");
-	     this_char != NULL;
-	     this_char = strtok (NULL, ",")) {
+	while ((this_char = strsep (&options, ",")) != NULL) {
+		if (!*this_char)
+			continue;
 		if ((value = strchr (this_char, '=')) != NULL)
 			*value++ = 0;
 		if (!strcmp (this_char, "bsddf"))
diff -Nur linux-2.4.15-pre5/fs/hfs/super.c linux-2.4.15-pre5-rs/fs/hfs/super.c
--- linux-2.4.15-pre5/fs/hfs/super.c	Wed Apr 18 08:16:39 2001
+++ linux-2.4.15-pre5-rs/fs/hfs/super.c	Fri Nov 16 21:27:52 2001
@@ -181,8 +181,9 @@
 	if (!options) {
 		goto done;
 	}
-	for (this_char = strtok(options,","); this_char;
-	     this_char = strtok(NULL,",")) {
+	while ((this_char = strsep(&options, ",")) != NULL) {
+		if (!*this_char)
+			continue;
 		if ((value = strchr(this_char,'=')) != NULL) {
 			*value++ = 0;
 		}
diff -Nur linux-2.4.15-pre5/fs/hpfs/super.c linux-2.4.15-pre5-rs/fs/hpfs/super.c
--- linux-2.4.15-pre5/fs/hpfs/super.c	Tue Jun 12 04:15:27 2001
+++ linux-2.4.15-pre5-rs/fs/hpfs/super.c	Fri Nov 16 21:49:25 2001
@@ -176,7 +176,9 @@
 
 	/*printk("Parsing opts: '%s'\n",opts);*/
 
-	for (p = strtok(opts, ","); p != 0; p = strtok(0, ",")) {
+	while ((p = strsep(&opts, ",")) != NULL) {
+		if (!*p)
+			continue;
 		if ((rhs = strchr(p, '=')) != 0)
 			*rhs++ = '\0';
 		if (!strcmp(p, "help")) return 2;
diff -Nur linux-2.4.15-pre5/fs/intermezzo/super.c linux-2.4.15-pre5-rs/fs/intermezzo/super.c
--- linux-2.4.15-pre5/fs/intermezzo/super.c	Fri Nov 16 18:43:04 2001
+++ linux-2.4.15-pre5-rs/fs/intermezzo/super.c	Fri Nov 16 22:14:06 2001
@@ -120,10 +120,10 @@
         store_opt(prestodev, NULL, PRESTO_PSDEV_NAME "0"); 
 
         CDEBUG(D_SUPER, "parsing options\n");
-        for (this_char = strtok (options, ",");
-             this_char != NULL;
-             this_char = strtok (NULL, ",")) {
+        while ((this_char = strsep (&options, ",")) != NULL) {
                 char *opt;
+                if (!*this_char)
+                        continue;
                 CDEBUG(D_SUPER, "this_char %s\n", this_char);
 
                 if ( (opt = read_opt("fileset", this_char)) ) {
diff -Nur linux-2.4.15-pre5/fs/isofs/inode.c linux-2.4.15-pre5-rs/fs/isofs/inode.c
--- linux-2.4.15-pre5/fs/isofs/inode.c	Thu Nov  8 22:51:17 2001
+++ linux-2.4.15-pre5-rs/fs/isofs/inode.c	Fri Nov 16 21:56:20 2001
@@ -294,7 +294,9 @@
 	popt->session=-1;
 	popt->sbsector=-1;
 	if (!options) return 1;
-	for (this_char = strtok(options,","); this_char; this_char = strtok(NULL,",")) {
+	while ((this_char = strsep(&options,",")) != NULL) {
+		if (!*this_char)
+			continue;
 	        if (strncmp(this_char,"norock",6) == 0) {
 		  popt->rock = 'n';
 		  continue;
diff -Nur linux-2.4.15-pre5/fs/proc/inode.c linux-2.4.15-pre5-rs/fs/proc/inode.c
--- linux-2.4.15-pre5/fs/proc/inode.c	Sun Sep 30 21:26:08 2001
+++ linux-2.4.15-pre5-rs/fs/proc/inode.c	Fri Nov 16 21:51:12 2001
@@ -106,7 +106,9 @@
 	*uid = current->uid;
 	*gid = current->gid;
 	if (!options) return 1;
-	for (this_char = strtok(options,","); this_char; this_char = strtok(NULL,",")) {
+	while ((this_char = strsep(&options,",")) != NULL) {
+		if (!*this_char)
+			continue;
 		if ((value = strchr(this_char,'=')) != NULL)
 			*value++ = 0;
 		if (!strcmp(this_char,"uid")) {
diff -Nur linux-2.4.15-pre5/fs/reiserfs/super.c linux-2.4.15-pre5-rs/fs/reiserfs/super.c
--- linux-2.4.15-pre5/fs/reiserfs/super.c	Fri Nov 16 18:43:05 2001
+++ linux-2.4.15-pre5-rs/fs/reiserfs/super.c	Fri Nov 16 21:53:16 2001
@@ -153,7 +153,9 @@
 	/* use default configuration: create tails, journaling on, no
            conversion to newest format */
 	return 1;
-    for (this_char = strtok (options, ","); this_char != NULL; this_char = strtok (NULL, ",")) {
+    while ((this_char = strsep (&options, ",")) != NULL) {
+	if (!*this_char)
+	    continue;
 	if ((value = strchr (this_char, '=')) != NULL)
 	    *value++ = 0;
 	if (!strcmp (this_char, "notail")) {
diff -Nur linux-2.4.15-pre5/fs/udf/super.c linux-2.4.15-pre5-rs/fs/udf/super.c
--- linux-2.4.15-pre5/fs/udf/super.c	Fri Oct 26 23:07:23 2001
+++ linux-2.4.15-pre5-rs/fs/udf/super.c	Fri Nov 16 21:32:50 2001
@@ -218,8 +218,10 @@
 	if (!options)
 		return 1;
 
-	for (opt = strtok(options, ","); opt; opt = strtok(NULL, ","))
+	while ((opt = strsep(&options, ",")) != NULL)
 	{
+		if (!*opt)
+			continue;
 		/* Make "opt=val" into two strings */
 		val = strchr(opt, '=');
 		if (val)
diff -Nur linux-2.4.15-pre5/fs/ufs/super.c linux-2.4.15-pre5-rs/fs/ufs/super.c
--- linux-2.4.15-pre5/fs/ufs/super.c	Wed May 16 19:31:27 2001
+++ linux-2.4.15-pre5-rs/fs/ufs/super.c	Fri Nov 16 21:35:18 2001
@@ -257,10 +257,9 @@
 	if (!options)
 		return 1;
 		
-	for (this_char = strtok (options, ",");
-	     this_char != NULL;
-	     this_char = strtok (NULL, ",")) {
-	     
+	while ((this_char = strsep (&options, ",")) != NULL) {
+		if (!*this_char)
+			continue;
 		if ((value = strchr (this_char, '=')) != NULL)
 			*value++ = 0;
 		if (!strcmp (this_char, "ufstype")) {
