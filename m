Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261458AbUKOP2y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261458AbUKOP2y (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Nov 2004 10:28:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261474AbUKOP2y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Nov 2004 10:28:54 -0500
Received: from 208.177.141.226.ptr.us.xo.net ([208.177.141.226]:36588 "EHLO
	ash.lnxi.com") by vger.kernel.org with ESMTP id S261458AbUKOP2A
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Nov 2004 10:28:00 -0500
Subject: Re: [PATCH] gen_init_cpio-slink_pipe_sock
From: Thayne Harbaugh <tharbaugh@lnxi.com>
Reply-To: tharbaugh@lnxi.com
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-kernel@vger.kernel.org, klibc@zytor.com, akpm@digeo.com,
       azarah@nosferatu.za.org
In-Reply-To: <41952022.1050607@pobox.com>
References: <1100290509.3171.8.camel@tubarao>  <41952022.1050607@pobox.com>
Content-Type: multipart/mixed; boundary="=-5S0bCS6ebPNKJa7dnlKv"
Organization: Linux Networx
Date: Mon, 15 Nov 2004 08:04:28 -0700
Message-Id: <1100531069.3171.27.camel@tubarao>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-5S0bCS6ebPNKJa7dnlKv
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

I didn't see any comments other than these by Jeff.  Here's a new patch
with the following modifications:

On Fri, 2004-11-12 at 15:42 -0500, Jeff Garzik wrote:
> Thayne Harbaugh wrote:
> > diff -ur linux-2.6.10-rc1.orig/drivers/block/Kconfig linux-2.6.10-rc1/drivers/block/Kconfig
> > --- linux-2.6.10-rc1.orig/drivers/block/Kconfig	2004-11-12 11:03:52.657108248 -0700
> > +++ linux-2.6.10-rc1/drivers/block/Kconfig	2004-11-12 11:07:28.458301480 -0700
> > @@ -363,10 +363,14 @@
> >  	    file <name> <location> <mode> <uid> <gid>
> >  	    dir <name> <mode> <uid> <gid>
> >  	    nod <name> <mode> <uid> <gid> <dev_type> <maj> <min>
> > +	    slink <name> <target> <mode> <uid> <gid>
> > +	    pipe <name> <mode> <uid> <gid>
> > +	    sock <name> <mode> <uid> <gid>
> >  
> >  	  Where:
> > -	    <name>      name of the file/dir/nod in the archive
> > +	    <name>      name of the file/dir/nod/etc in the archive
> >  	    <location>  location of the file in the current filesystem
> > +	    <target>    link target
> >  	    <mode>      mode/permissions of the file
> >  	    <uid>       user id (0=root)
> >  	    <gid>       group id (0=root)
> 
> This info should get moved out of Kconfig, and into a Documentation/* 
> text file somewhere.

Now Kconfig and Documentation/early-userspace/README reference the usage
output of usr/gen_init_cpio instead of reproducing the file format
information.  This way there is no redundant information that gets out
of synch.  The drawback is that usr/gen_init_cpio has to be built before
it can be run to obtain the usage information.

> > +/*
> > + * Original work by Jeff Garzick
> 
> Please spell my last name correctly :)

Jeff refused to change his name to my new spelling so I have reluctantly
altered the comment so that it reads "Original work by Jeff
Garzik" (sic.). :)

-- 
Thayne Harbaugh
Linux Networx

--=-5S0bCS6ebPNKJa7dnlKv
Content-Disposition: attachment; filename=gen_init_cpio-slink_pipe_sock_2.patch
Content-Type: text/x-patch; name=gen_init_cpio-slink_pipe_sock_2.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

diff -ur linux-2.6.10-rc1.orig/Documentation/early-userspace/README linux-2.6.10-rc1/Documentation/early-userspace/README
--- linux-2.6.10-rc1.orig/Documentation/early-userspace/README	2004-11-12 11:16:29.000000000 -0700
+++ linux-2.6.10-rc1/Documentation/early-userspace/README	2004-11-12 11:48:57.000000000 -0700
@@ -1,7 +1,7 @@
 Early userspace support
 =======================
 
-Last update: 2003-08-21
+Last update: 2004-11-12
 
 
 "Early userspace" is a set of libraries and programs that provide
@@ -17,14 +17,22 @@
 - initramfs, a chunk of code that unpacks the compressed cpio image
   midway through the kernel boot process.
 - klibc, a userspace C library, currently packaged separately, that is
-  optimised for correctness and small size.
+  optimized for correctness and small size.
 
 The cpio file format used by initramfs is the "newc" (aka "cpio -c")
-format, and is documented in the file "buffer-format.txt".  If you
-want to generate your own cpio files directly instead of hacking on
-gen_init_cpio, you will need to short-circuit the build process in
-usr/ so that gen_init_cpio does not get run, then simply pop your own
-initramfs_data.cpio.gz file into place.
+format, and is documented in the file "buffer-format.txt".  There are
+three ways to add an early userspace filesystem:
+
+1) Put your gzip'ed cpio in usr/initramfs_data.cpio.gz.
+
+2) Set CONFIG_INITRAMFS_SOURCE to the filename of a gen_init_cpio
+input file.  This provides the most flexibility and allows creation of
+archives with files not owned by the build user.  This means that an
+unprivileged user can create an early userspace with files owned by
+root.
+
+3) Set CONFIG_INITRAMFS_SOURCE to point to a directory containing the
+files for your filesystem.
 
 
 Where's this all leading?
diff -ur linux-2.6.10-rc1.orig/drivers/block/Kconfig linux-2.6.10-rc1/drivers/block/Kconfig
--- linux-2.6.10-rc1.orig/drivers/block/Kconfig	2004-11-12 11:03:52.000000000 -0700
+++ linux-2.6.10-rc1/drivers/block/Kconfig	2004-11-15 08:32:44.165339080 -0700
@@ -355,24 +355,9 @@
 	default ""
 	help
 	  This can be set to either a directory containing files, etc to be
-	  included in the initramfs archive, or a file containing newline
-	  separated entries.
-
-	  If it is a file, it should be in the following format:
-	    # a comment
-	    file <name> <location> <mode> <uid> <gid>
-	    dir <name> <mode> <uid> <gid>
-	    nod <name> <mode> <uid> <gid> <dev_type> <maj> <min>
-
-	  Where:
-	    <name>      name of the file/dir/nod in the archive
-	    <location>  location of the file in the current filesystem
-	    <mode>      mode/permissions of the file
-	    <uid>       user id (0=root)
-	    <gid>       group id (0=root)
-	    <dev_type>  device type (b=block, c=character)
-	    <maj>       major number of nod
-	    <min>       minor number of nod
+	  included in the initramfs archive, or a file containing  entries
+	  according to the format described by the "usr/gen_init_cpio"
+	  program in the kernel tree.
 
 	  If you are not sure, leave it blank.
 
diff -ur linux-2.6.10-rc1.orig/scripts/gen_initramfs_list.sh linux-2.6.10-rc1/scripts/gen_initramfs_list.sh
--- linux-2.6.10-rc1.orig/scripts/gen_initramfs_list.sh	2004-11-12 08:39:48.000000000 -0700
+++ linux-2.6.10-rc1/scripts/gen_initramfs_list.sh	2004-11-12 11:00:14.000000000 -0700
@@ -9,8 +9,6 @@
 #
 # The output is suitable for gen_init_cpio as found in usr/Makefile.
 #
-# TODO:  Add support for symlinks, sockets and pipes when gen_init_cpio
-#        supports them.
 
 simple_initramfs() {
 	cat <<-EOF
@@ -25,12 +23,19 @@
 filetype() {
 	local argv1="$1"
 
-	if [ -f "${argv1}" ]; then
+	# symlink test must come before file test
+	if [ -L "${argv1}" ]; then
+		echo "slink"
+	elif [ -f "${argv1}" ]; then
 		echo "file"
 	elif [ -d "${argv1}" ]; then
 		echo "dir"
 	elif [ -b "${argv1}" -o -c "${argv1}" ]; then
 		echo "nod"
+	elif [ -p "${argv1}" ]; then
+		echo "pipe"
+	elif [ -S "${argv1}" ]; then
+		echo "sock"
 	else
 		echo "invalid"
 	fi
@@ -52,6 +57,8 @@
 parse() {
 	local location="$1"
 	local name="${location/${srcdir}//}"
+	# change '//' into '/'
+	name="${name//\/\///}"
 	local mode="$2"
 	local uid="$3"
 	local gid="$4"
@@ -79,6 +86,11 @@
 			fi
 			str="${ftype} ${name} ${str} ${dev_type} ${maj} ${min}"
 			;;
+		"slink")
+			local target=$(LC_ALL=C ls -l "${location}" | \
+					gawk '{print $11}')
+			str="${ftype} ${name} ${target} ${str}"
+			;;
 		*)
 			str="${ftype} ${name} ${str}"
 			;;
diff -ur linux-2.6.10-rc1.orig/usr/gen_init_cpio.c linux-2.6.10-rc1/usr/gen_init_cpio.c
--- linux-2.6.10-rc1.orig/usr/gen_init_cpio.c	2004-11-12 08:39:18.000000000 -0700
+++ linux-2.6.10-rc1/usr/gen_init_cpio.c	2004-11-12 14:11:39.000000000 -0700
@@ -10,13 +10,19 @@
 #include <ctype.h>
 #include <limits.h>
 
+/*
+ * Original work by Jeff Garzik
+ *
+ * External file lists, symlink, pipe and fifo support by Thayne Harbaugh
+ */
+
 #define xstr(s) #s
 #define str(s) xstr(s)
 
 static unsigned int offset;
 static unsigned int ino = 721;
 
-struct file_type {
+struct file_handler {
 	const char *type;
 	int (*handler)(const char *line);
 };
@@ -91,7 +97,55 @@
 	}
 }
 
-static int cpio_mkdir(const char *name, unsigned int mode,
+static int cpio_mkslink(const char *name, const char *target,
+			 unsigned int mode, uid_t uid, gid_t gid)
+{
+	char s[256];
+	time_t mtime = time(NULL);
+
+	sprintf(s,"%s%08X%08X%08lX%08lX%08X%08lX"
+	       "%08X%08X%08X%08X%08X%08X%08X",
+		"070701",		/* magic */
+		ino++,			/* ino */
+		S_IFLNK | mode,		/* mode */
+		(long) uid,		/* uid */
+		(long) gid,		/* gid */
+		1,			/* nlink */
+		(long) mtime,		/* mtime */
+		strlen(target) + 1,	/* filesize */
+		3,			/* major */
+		1,			/* minor */
+		0,			/* rmajor */
+		0,			/* rminor */
+		(unsigned)strlen(name) + 1,/* namesize */
+		0);			/* chksum */
+	push_hdr(s);
+	push_string(name);
+	push_pad();
+	push_string(target);
+	push_pad();
+	return 0;
+}
+
+static int cpio_mkslink_line(const char *line)
+{
+	char name[PATH_MAX + 1];
+	char target[PATH_MAX + 1];
+	unsigned int mode;
+	int uid;
+	int gid;
+	int rc = -1;
+
+	if (5 != sscanf(line, "%" str(PATH_MAX) "s %" str(PATH_MAX) "s %o %d %d", name, target, &mode, &uid, &gid)) {
+		fprintf(stderr, "Unrecognized dir format '%s'", line);
+		goto fail;
+	}
+	rc = cpio_mkslink(name, target, mode, uid, gid);
+ fail:
+	return rc;
+}
+
+static int cpio_mkgeneric(const char *name, unsigned int mode,
 		       uid_t uid, gid_t gid)
 {
 	char s[256];
@@ -101,7 +155,7 @@
 	       "%08X%08X%08X%08X%08X%08X%08X",
 		"070701",		/* magic */
 		ino++,			/* ino */
-		S_IFDIR | mode,		/* mode */
+		mode,			/* mode */
 		(long) uid,		/* uid */
 		(long) gid,		/* gid */
 		2,			/* nlink */
@@ -118,7 +172,33 @@
 	return 0;
 }
 
-static int cpio_mkdir_line(const char *line)
+enum generic_types {
+	GT_DIR,
+	GT_PIPE,
+	GT_SOCK
+};
+
+struct generic_type {
+	const char *type;
+	mode_t mode;
+};
+
+static struct generic_type generic_type_table[] = {
+	[GT_DIR] = {
+		.type = "dir",
+		.mode = S_IFDIR
+	},
+	[GT_PIPE] = {
+		.type = "pipe",
+		.mode = S_IFIFO
+	},
+	[GT_SOCK] = {
+		.type = "sock",
+		.mode = S_IFSOCK
+	}
+};
+
+static int cpio_mkgeneric_line(const char *line, enum generic_types gt)
 {
 	char name[PATH_MAX + 1];
 	unsigned int mode;
@@ -127,14 +207,31 @@
 	int rc = -1;
 
 	if (4 != sscanf(line, "%" str(PATH_MAX) "s %o %d %d", name, &mode, &uid, &gid)) {
-		fprintf(stderr, "Unrecognized dir format '%s'", line);
+		fprintf(stderr, "Unrecognized %s format '%s'",
+			line, generic_type_table[gt].type);
 		goto fail;
 	}
-	rc = cpio_mkdir(name, mode, uid, gid);
+	mode |= generic_type_table[gt].mode;
+	rc = cpio_mkgeneric(name, mode, uid, gid);
  fail:
 	return rc;
 }
 
+static int cpio_mkdir_line(const char *line)
+{
+	return cpio_mkgeneric_line(line, GT_DIR);
+}
+
+static int cpio_mkpipe_line(const char *line)
+{
+	return cpio_mkgeneric_line(line, GT_PIPE);
+}
+
+static int cpio_mksock_line(const char *line)
+{
+	return cpio_mkgeneric_line(line, GT_SOCK);
+}
+
 static int cpio_mknod(const char *name, unsigned int mode,
 		       uid_t uid, gid_t gid, char dev_type,
 		       unsigned int maj, unsigned int min)
@@ -286,12 +383,16 @@
 		"describe the files to be included in the initramfs archive:\n"
 		"\n"
 		"# a comment\n"
-		"file <name> <location> <mode> <uid> <gid> \n"
+		"file <name> <location> <mode> <uid> <gid>\n"
 		"dir <name> <mode> <uid> <gid>\n"
 		"nod <name> <mode> <uid> <gid> <dev_type> <maj> <min>\n"
+		"slink <name> <target> <mode> <uid> <gid>\n"
+		"pipe <name> <mode> <uid> <gid>\n"
+		"sock <name> <mode> <uid> <gid>\n"
 		"\n"
-		"<name>      name of the file/dir/nod in the archive\n"
+		"<name>      name of the file/dir/nod/etc in the archive\n"
 		"<location>  location of the file in the current filesystem\n"
+		"<target>    link target\n"
 		"<mode>      mode/permissions of the file\n"
 		"<uid>       user id (0=root)\n"
 		"<gid>       group id (0=root)\n"
@@ -309,7 +410,7 @@
 		prog);
 }
 
-struct file_type file_type_table[] = {
+struct file_handler file_handler_table[] = {
 	{
 		.type    = "file",
 		.handler = cpio_mkfile_line,
@@ -320,6 +421,15 @@
 		.type    = "dir",
 		.handler = cpio_mkdir_line,
 	}, {
+		.type    = "slink",
+		.handler = cpio_mkslink_line,
+	}, {
+		.type    = "pipe",
+		.handler = cpio_mkpipe_line,
+	}, {
+		.type    = "sock",
+		.handler = cpio_mksock_line,
+	}, {
 		.type    = NULL,
 		.handler = NULL,
 	}
@@ -382,10 +492,10 @@
 			ec = -1;
 		}
 
-		for (type_idx = 0; file_type_table[type_idx].type; type_idx++) {
+		for (type_idx = 0; file_handler_table[type_idx].type; type_idx++) {
 			int rc;
-			if (! strcmp(line, file_type_table[type_idx].type)) {
-				if ((rc = file_type_table[type_idx].handler(args))) {
+			if (! strcmp(line, file_handler_table[type_idx].type)) {
+				if ((rc = file_handler_table[type_idx].handler(args))) {
 					ec = rc;
 					fprintf(stderr, " line %d\n", line_nr);
 				}
@@ -393,7 +503,7 @@
 			}
 		}
 
-		if (NULL == file_type_table[type_idx].type) {
+		if (NULL == file_handler_table[type_idx].type) {
 			fprintf(stderr, "unknown file type line %d: '%s'\n",
 				line_nr, line);
 		}

--=-5S0bCS6ebPNKJa7dnlKv--

