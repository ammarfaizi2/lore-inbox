Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289661AbSAOVCU>; Tue, 15 Jan 2002 16:02:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289663AbSAOVCP>; Tue, 15 Jan 2002 16:02:15 -0500
Received: from smtp02.web.de ([217.72.192.151]:15393 "EHLO smtp.web.de")
	by vger.kernel.org with ESMTP id <S289661AbSAOVCC>;
	Tue, 15 Jan 2002 16:02:02 -0500
Date: Tue, 15 Jan 2002 22:09:01 +0100
From: =?ISO-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] strtok --> strsep (again)
Message-Id: <20020115220901.3465a6d2.l.s.r@web.de>
X-Mailer: Sylpheed version 0.6.6 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

patch below replaces most uses of strtok by strsep. It compiles,
but otherwise it's untested.

This change is suggested by the Kernel Janitor TODO List because
strtok is not threadsafe. For most of the framebuffer drivers it
was already done. For some more information see lib/string.c:14.

Linus, please apply.

René


 drivers/isdn/avmb1/capifs.c    |    7 +++----
 drivers/scsi/ibmmca.c          |    5 ++---
 drivers/usb/inode.c            |    6 +++---
 drivers/video/atafb.c          |    2 +-
 drivers/video/aty/atyfb_base.c |    2 ++
 drivers/video/aty128fb.c       |    4 +++-
 drivers/video/clgenfb.c        |    3 +--
 drivers/video/sis/sis_main.c   |    3 +--
 fs/adfs/super.c                |    4 +++-
 fs/affs/super.c                |    4 +++-
 fs/autofs/inode.c              |    4 +++-
 fs/autofs4/inode.c             |    4 +++-
 fs/devpts/inode.c              |    7 +++----
 fs/ext2/super.c                |    6 +++---
 fs/ext3/super.c                |    6 +++---
 fs/hfs/super.c                 |    5 +++--
 fs/hpfs/super.c                |    4 +++-
 fs/intermezzo/super.c          |    6 +++---
 fs/isofs/inode.c               |    4 +++-
 fs/nfs/nfsroot.c               |    6 +++---
 fs/ntfs/fs.c                   |    5 ++++-
 fs/proc/inode.c                |    4 +++-
 fs/reiserfs/super.c            |    4 +++-
 fs/udf/super.c                 |    4 +++-
 fs/ufs/super.c                 |    7 +++----
 mm/shmem.c                     |    7 +++----
 26 files changed, 71 insertions(+), 52 deletions(-)


diff -ur linux-2.5.2-pre11/drivers/isdn/avmb1/capifs.c linux-2.5.2.11/drivers/isdn/avmb1/capifs.c
--- linux-2.5.2-pre11/drivers/isdn/avmb1/capifs.c	Sat Jan 12 17:38:01 2002
+++ linux-2.5.2.11/drivers/isdn/avmb1/capifs.c	Sun Jan 13 18:19:16 2002
@@ -232,10 +232,9 @@
 	unsigned int maxncci = 512;
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
diff -ur linux-2.5.2-pre11/drivers/scsi/ibmmca.c linux-2.5.2.11/drivers/scsi/ibmmca.c
--- linux-2.5.2-pre11/drivers/scsi/ibmmca.c	Wed May  2 01:05:00 2001
+++ linux-2.5.2.11/drivers/scsi/ibmmca.c	Sun Jan 13 18:23:29 2002
@@ -1406,9 +1406,9 @@
    io_base = 0;
    id_base = 0;
    if (str) {
-      token = strtok(str,",");
       j = 0;
-      while (token) {
+      while ((token = strsep(&str,",")) != NULL) {
+	 if (!*token) continue;
 	 if (!strcmp(token,"activity")) display_mode |= LED_ACTIVITY;
 	 if (!strcmp(token,"display")) display_mode |= LED_DISP;
 	 if (!strcmp(token,"adisplay")) display_mode |= LED_ADISP;
@@ -1424,7 +1424,6 @@
 	      scsi_id[id_base++] = simple_strtoul(token,NULL,0);
 	    j++;
 	 }
-	 token = strtok(NULL,",");
       }
    } else if (ints) {
       for (i = 0; i < IM_MAX_HOSTS && 2*i+2 < ints[0]; i++) {
diff -ur linux-2.5.2-pre11/drivers/usb/inode.c linux-2.5.2.11/drivers/usb/inode.c
--- linux-2.5.2-pre11/drivers/usb/inode.c	Sat Jan 12 17:38:07 2002
+++ linux-2.5.2.11/drivers/usb/inode.c	Sun Jan 13 18:31:40 2002
@@ -65,9 +65,9 @@
 {
 	char *curopt = NULL, *value;
 
-	if (data)
-		curopt = strtok(data, ",");
-	for (; curopt; curopt = strtok(NULL, ",")) {
+	while ((curopt = strsep(&data, ",")) != NULL) {
+		if (!*curopt)
+			continue;
 		if ((value = strchr(curopt, '=')) != NULL)
 			*value++ = 0;
 		if (!strcmp(curopt, "devuid")) {
diff -ur linux-2.5.2-pre11/drivers/video/atafb.c linux-2.5.2.11/drivers/video/atafb.c
--- linux-2.5.2-pre11/drivers/video/atafb.c	Thu Oct 25 09:02:26 2001
+++ linux-2.5.2.11/drivers/video/atafb.c	Sat Jan 12 17:55:48 2002
@@ -2899,7 +2899,7 @@
     if (!options || !*options)
 		return 0;
      
-    for(this_opt=strtok(options,","); this_opt; this_opt=strtok(NULL,",")) {
+    while ((this_opt=strsep(&options, ",")) != NULL) {
 	if (!*this_opt) continue;
 	if ((temp=get_video_mode(this_opt)))
 		default_par=temp;
diff -ur linux-2.5.2-pre11/drivers/video/aty/atyfb_base.c linux-2.5.2.11/drivers/video/aty/atyfb_base.c
--- linux-2.5.2-pre11/drivers/video/aty/atyfb_base.c	Sat Jan 12 17:38:09 2002
+++ linux-2.5.2.11/drivers/video/aty/atyfb_base.c	Sat Jan 12 17:55:48 2002
@@ -2522,6 +2522,8 @@
 	return 0;
 
     while ((this_opt = strsep(&options, ",")) != NULL) {
+	if (!*this_opt)
+		continue;
 	if (!strncmp(this_opt, "font:", 5)) {
 		char *p;
 		int i;
diff -ur linux-2.5.2-pre11/drivers/video/aty128fb.c linux-2.5.2.11/drivers/video/aty128fb.c
--- linux-2.5.2-pre11/drivers/video/aty128fb.c	Sun Nov 11 19:09:37 2001
+++ linux-2.5.2.11/drivers/video/aty128fb.c	Sun Jan 13 16:38:46 2002
@@ -1620,7 +1620,9 @@
     if (!options || !*options)
 	return 0;
 
-    while (this_opt = strsep(&options, ",")) {
+    while ((this_opt = strsep(&options, ",")) != NULL) {
+	if (!*this_opt)
+	    continue;
 	if (!strncmp(this_opt, "font:", 5)) {
 	    char *p;
 	    int i;
diff -ur linux-2.5.2-pre11/drivers/video/clgenfb.c linux-2.5.2.11/drivers/video/clgenfb.c
--- linux-2.5.2-pre11/drivers/video/clgenfb.c	Tue Nov 20 00:19:42 2001
+++ linux-2.5.2.11/drivers/video/clgenfb.c	Sat Jan 12 17:55:48 2002
@@ -2840,8 +2840,7 @@
 	if (!options || !*options)
 		return 0;
 
-	for (this_opt = strtok (options, ","); this_opt != NULL;
-	     this_opt = strtok (NULL, ",")) {
+	while ((this_opt = strsep (&options, ",")) != NULL) {
 		if (!*this_opt) continue;
 
 		DPRINTK("clgenfb_setup: option '%s'\n", this_opt);
diff -ur linux-2.5.2-pre11/drivers/video/sis/sis_main.c linux-2.5.2.11/drivers/video/sis/sis_main.c
--- linux-2.5.2-pre11/drivers/video/sis/sis_main.c	Fri Nov  9 23:11:14 2001
+++ linux-2.5.2.11/drivers/video/sis/sis_main.c	Sat Jan 12 17:55:48 2002
@@ -2257,8 +2257,7 @@
 	if (!options || !*options)
 		return 0;
 
-	for (this_opt = strtok (options, ","); this_opt;
-	     this_opt = strtok (NULL, ",")) {
+	while ((this_opt = strsep (&options, ",")) != NULL) {
 		if (!*this_opt)
 			continue;
 
diff -ur linux-2.5.2-pre11/fs/adfs/super.c linux-2.5.2.11/fs/adfs/super.c
--- linux-2.5.2-pre11/fs/adfs/super.c	Sat Jan 12 17:38:09 2002
+++ linux-2.5.2.11/fs/adfs/super.c	Sun Jan 13 17:01:41 2002
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
diff -ur linux-2.5.2-pre11/fs/affs/super.c linux-2.5.2.11/fs/affs/super.c
--- linux-2.5.2-pre11/fs/affs/super.c	Sat Jan 12 17:38:09 2002
+++ linux-2.5.2.11/fs/affs/super.c	Sun Jan 13 17:02:58 2002
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
diff -ur linux-2.5.2-pre11/fs/autofs/inode.c linux-2.5.2.11/fs/autofs/inode.c
--- linux-2.5.2-pre11/fs/autofs/inode.c	Sat Jan 12 17:38:09 2002
+++ linux-2.5.2.11/fs/autofs/inode.c	Sun Jan 13 17:16:37 2002
@@ -61,7 +61,9 @@
 	*pipefd = -1;
 
 	if ( !options ) return 1;
-	for (this_char = strtok(options,","); this_char; this_char = strtok(NULL,",")) {
+	while ((this_char = strsep(&options,",")) != NULL) {
+		if (!*value)
+			continue;
 		if ((value = strchr(this_char,'=')) != NULL)
 			*value++ = 0;
 		if (!strcmp(this_char,"fd")) {
diff -ur linux-2.5.2-pre11/fs/autofs4/inode.c linux-2.5.2.11/fs/autofs4/inode.c
--- linux-2.5.2-pre11/fs/autofs4/inode.c	Sat Jan 12 17:38:09 2002
+++ linux-2.5.2.11/fs/autofs4/inode.c	Sun Jan 13 17:20:37 2002
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
diff -ur linux-2.5.2-pre11/fs/devpts/inode.c linux-2.5.2.11/fs/devpts/inode.c
--- linux-2.5.2-pre11/fs/devpts/inode.c	Thu Oct 25 09:02:26 2001
+++ linux-2.5.2.11/fs/devpts/inode.c	Sun Jan 13 17:19:28 2002
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
diff -ur linux-2.5.2-pre11/fs/ext2/super.c linux-2.5.2.11/fs/ext2/super.c
--- linux-2.5.2-pre11/fs/ext2/super.c	Sat Jan 12 17:38:10 2002
+++ linux-2.5.2.11/fs/ext2/super.c	Sun Jan 13 17:04:01 2002
@@ -171,9 +171,9 @@
 
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
diff -ur linux-2.5.2-pre11/fs/ext3/super.c linux-2.5.2.11/fs/ext3/super.c
--- linux-2.5.2-pre11/fs/ext3/super.c	Sat Jan 12 17:38:10 2002
+++ linux-2.5.2.11/fs/ext3/super.c	Sun Jan 13 17:05:38 2002
@@ -504,9 +504,9 @@
 
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
diff -ur linux-2.5.2-pre11/fs/hfs/super.c linux-2.5.2.11/fs/hfs/super.c
--- linux-2.5.2-pre11/fs/hfs/super.c	Sat Jan 12 17:38:10 2002
+++ linux-2.5.2.11/fs/hfs/super.c	Sun Jan 13 16:45:43 2002
@@ -181,8 +181,9 @@
 	if (!options) {
 		goto done;
 	}
-	for (this_char = strtok(options,","); this_char;
-	     this_char = strtok(NULL,",")) {
+	while ((this_char = strsep(&options,",")) != NULL) {
+		if (!*this_char)
+			continue;
 		if ((value = strchr(this_char,'=')) != NULL) {
 			*value++ = 0;
 		}
diff -ur linux-2.5.2-pre11/fs/hpfs/super.c linux-2.5.2.11/fs/hpfs/super.c
--- linux-2.5.2-pre11/fs/hpfs/super.c	Sat Jan 12 17:38:10 2002
+++ linux-2.5.2.11/fs/hpfs/super.c	Sun Jan 13 17:07:24 2002
@@ -176,7 +176,9 @@
 
 	/*printk("Parsing opts: '%s'\n",opts);*/
 
-	for (p = strtok(opts, ","); p != 0; p = strtok(0, ",")) {
+	while ((p = strsep(&opts, ",")) != NULL) {
+		if (!*p)
+			continue;
 		if ((rhs = strchr(p, '=')) != 0)
 			*rhs++ = '\0';
 		if (!strcmp(p, "help")) return 2;
diff -ur linux-2.5.2-pre11/fs/intermezzo/super.c linux-2.5.2.11/fs/intermezzo/super.c
--- linux-2.5.2-pre11/fs/intermezzo/super.c	Sat Jan 12 17:38:11 2002
+++ linux-2.5.2.11/fs/intermezzo/super.c	Sun Jan 13 17:00:07 2002
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
diff -ur linux-2.5.2-pre11/fs/isofs/inode.c linux-2.5.2.11/fs/isofs/inode.c
--- linux-2.5.2-pre11/fs/isofs/inode.c	Sat Jan 12 17:38:11 2002
+++ linux-2.5.2.11/fs/isofs/inode.c	Sun Jan 13 17:15:48 2002
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
diff -ur linux-2.5.2-pre11/fs/nfs/nfsroot.c linux-2.5.2.11/fs/nfs/nfsroot.c
--- linux-2.5.2-pre11/fs/nfs/nfsroot.c	Sat Jan 12 17:38:11 2002
+++ linux-2.5.2.11/fs/nfs/nfsroot.c	Sun Jan 13 16:47:27 2002
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
diff -ur linux-2.5.2-pre11/fs/ntfs/fs.c linux-2.5.2.11/fs/ntfs/fs.c
--- linux-2.5.2-pre11/fs/ntfs/fs.c	Sat Jan 12 17:38:12 2002
+++ linux-2.5.2.11/fs/ntfs/fs.c	Sun Jan 13 17:10:47 2002
@@ -361,10 +361,13 @@
 	int use_utf8 = -1;	/* If no NLS specified and loading the default
 				   NLS failed use utf8. */
 	int mft_zone_mul = -1;	/* 1 */
+	char *opts = opt;
 
 	if (!opt)
 		goto done;
-	for (opt = strtok(opt, ","); opt; opt = strtok(NULL, ",")) {
+	while ((opt = strsep(&opts, ",")) != NULL) {
+		if (!*opt)
+			continue;
 		if ((value = strchr(opt, '=')) != NULL)
 			*value ++= '\0';
 		if (strcmp(opt, "uid") == 0) {
diff -ur linux-2.5.2-pre11/fs/proc/inode.c linux-2.5.2.11/fs/proc/inode.c
--- linux-2.5.2-pre11/fs/proc/inode.c	Sat Nov 17 20:24:32 2001
+++ linux-2.5.2.11/fs/proc/inode.c	Sun Jan 13 17:11:49 2002
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
diff -ur linux-2.5.2-pre11/fs/reiserfs/super.c linux-2.5.2.11/fs/reiserfs/super.c
--- linux-2.5.2-pre11/fs/reiserfs/super.c	Sat Jan 12 17:38:13 2002
+++ linux-2.5.2.11/fs/reiserfs/super.c	Sun Jan 13 17:13:26 2002
@@ -154,7 +154,9 @@
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
diff -ur linux-2.5.2-pre11/fs/udf/super.c linux-2.5.2.11/fs/udf/super.c
--- linux-2.5.2-pre11/fs/udf/super.c	Sat Jan 12 17:38:14 2002
+++ linux-2.5.2.11/fs/udf/super.c	Sun Jan 13 18:49:52 2002
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
diff -ur linux-2.5.2-pre11/fs/ufs/super.c linux-2.5.2.11/fs/ufs/super.c
--- linux-2.5.2-pre11/fs/ufs/super.c	Sat Jan 12 17:38:14 2002
+++ linux-2.5.2.11/fs/ufs/super.c	Sun Jan 13 16:53:49 2002
@@ -258,10 +258,9 @@
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
diff -ur linux-2.5.2-pre11/mm/shmem.c linux-2.5.2.11/mm/shmem.c
--- linux-2.5.2-pre11/mm/shmem.c	Wed Nov 21 18:57:57 2001
+++ linux-2.5.2.11/mm/shmem.c	Sun Jan 13 18:40:00 2002
@@ -1197,10 +1197,9 @@
 {
 	char *this_char, *value, *rest;
 
-	this_char = NULL;
-	if ( options )
-		this_char = strtok(options,",");
-	for ( ; this_char; this_char = strtok(NULL,",")) {
+	while ((this_char = strsep(&options, ",")) != NULL) {
+		if (!*this_char)
+			continue;
 		if ((value = strchr(this_char,'=')) != NULL) {
 			*value++ = 0;
 		} else {
