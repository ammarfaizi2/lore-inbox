Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268231AbUIPWcz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268231AbUIPWcz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 18:32:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268105AbUIPWcz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 18:32:55 -0400
Received: from 208.177.141.226.ptr.us.xo.net ([208.177.141.226]:29936 "HELO
	ash.lnxi.com") by vger.kernel.org with SMTP id S268269AbUIPWaL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 18:30:11 -0400
Subject: [PATCH] gen_init_cpio uses external file list
From: Thayne Harbaugh <tharbaugh@lnxi.com>
Reply-To: tharbaugh@lnxi.com
To: akpm@digeo.com
Cc: linux-kernel@vger.kernel.org, klibc@zytor.com
Content-Type: multipart/mixed; boundary="=-53YTvnLoZ7JDr1uMSnnO"
Organization: Linux Networx
Date: Thu, 16 Sep 2004 16:11:12 -0600
Message-Id: <1095372672.19900.72.camel@tubarao>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.94.1 (1.5.94.1-1) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-53YTvnLoZ7JDr1uMSnnO
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

(Apologies to klibc@zytor.com for the re-send)

This patch makes gen_init_cpio generate the initramfs_data.cpio from a
file which contains a list of entries: file, dir, nod.  I swapped the
order of filename/location for the file arguments so that it would be
more uniform with the dir and nod tyes.

[thayne@torch linux-2.6.8]$ usr/gen_init_cpio --help
ERROR: unable to open '--help': No such file or directory

Usage:
        usr/gen_init_cpio <cpio_list>

<cpio_list> is a file containing newline separated entries that
describe the files to be included in the initramfs archive:

file <name> <location> <mode> <uid> <gid>
dir <name> <mode> <uid> <gid>
nod <name> <mode> <uid> <gid> <dev_type> <maj> <min>

<name>      name of the file/dir/nod in the archive
<location>  location of the file in the current filesystem
<mode>      mode/permissions of the file
<uid>       user id (0=root)
<gid>       group id (0=root)
<dev_type>  device type (b=block, c=character)
<maj>       major number of nod
<min>       minor number of nod

example:
dir /dev 0755 0 0
nod /dev/console 0600 0 0 c 5 1
dir /root 0700 0 0
dir /sbin 0755 0 0
file /sbin/kinit /usr/src/klibc/kinit/kinit 0755 0 0


--=-53YTvnLoZ7JDr1uMSnnO
Content-Description: 
Content-Disposition: inline; filename=cpio_list.patch
Content-Type: text/x-patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

diff -uNr linux-2.6.8/usr/gen_init_cpio.c linux-2.6.8-cpio_list/usr/gen_init_cpio.c
--- linux-2.6.8/usr/gen_init_cpio.c	2004-09-13 12:35:11.148116792 -0600
+++ linux-2.6.8-cpio_list/usr/gen_init_cpio.c	2004-09-16 15:36:37.634729800 -0600
@@ -1,3 +1,4 @@
+#define _GNU_SOURCE
 #include <stdio.h>
 #include <stdlib.h>
 #include <sys/types.h>
@@ -6,10 +7,21 @@
 #include <unistd.h>
 #include <time.h>
 #include <fcntl.h>
+#include <errno.h>
+#include <ctype.h>
+#include <limits.h>
+
+#define xstr(s) #s
+#define str(s) xstr(s)
 
 static unsigned int offset;
 static unsigned int ino = 721;
 
+struct file_type {
+	const char *type;
+	int (*handler)(const char *line);
+};
+
 static void push_string(const char *name)
 {
 	unsigned int name_len = strlen(name) + 1;
@@ -80,7 +92,7 @@
 	}
 }
 
-static void cpio_mkdir(const char *name, unsigned int mode,
+static int cpio_mkdir(const char *name, unsigned int mode,
 		       uid_t uid, gid_t gid)
 {
 	char s[256];
@@ -104,10 +116,28 @@
 		0);			/* chksum */
 	push_hdr(s);
 	push_rest(name);
+	return 0;
 }
 
-static void cpio_mknod(const char *name, unsigned int mode,
-		       uid_t uid, gid_t gid, int dev_type,
+static int cpio_mkdir_line(const char *line)
+{
+	char name[PATH_MAX + 1];
+	unsigned int mode;
+	uid_t uid;
+	gid_t gid;
+	int rc = -1;
+
+	if (4 != sscanf(line, "%" str(PATH_MAX) "s %o %d %d", name, &mode, &uid, &gid)) {
+		fprintf(stderr, "Unrecognized dir format '%s'", line);
+		goto fail;
+	}
+	rc = cpio_mkdir(name, mode, uid, gid);
+ fail:
+	return rc;
+}
+
+static int cpio_mknod(const char *name, unsigned int mode,
+		       uid_t uid, gid_t gid, char dev_type,
 		       unsigned int maj, unsigned int min)
 {
 	char s[256];
@@ -136,43 +166,66 @@
 		0);			/* chksum */
 	push_hdr(s);
 	push_rest(name);
+	return 0;
+}
+
+static int cpio_mknod_line(const char *line)
+{
+	char name[PATH_MAX + 1];
+	unsigned int mode;
+	uid_t uid;
+	gid_t gid;
+	char dev_type;
+	unsigned int maj;
+	unsigned int min;
+	int rc = -1;
+
+	if (7 != sscanf(line, "%" str(PATH_MAX) "s %o %d %d %c %u %u",
+			 name, &mode, &uid, &gid, &dev_type, &maj, &min)) {
+		fprintf(stderr, "Unrecognized nod format '%s'", line);
+		goto fail;
+	}
+	rc = cpio_mknod(name, mode, uid, gid, dev_type, maj, min);
+ fail:
+	return rc;
 }
 
 /* Not marked static to keep the compiler quiet, as no one uses this yet... */
-void cpio_mkfile(const char *filename, const char *location,
+static int cpio_mkfile(const char *name, const char *location,
 			unsigned int mode, uid_t uid, gid_t gid)
 {
 	char s[256];
-	char *filebuf;
+	char *filebuf = NULL;
 	struct stat buf;
-	int file;
+	int file = -1;
 	int retval;
 	int i;
+	int rc = -1;
 
 	mode |= S_IFREG;
 
-	retval = stat (filename, &buf);
+	retval = stat (location, &buf);
 	if (retval) {
-		fprintf (stderr, "Filename %s could not be located\n", filename);
+		fprintf (stderr, "File %s could not be located\n", location);
 		goto error;
 	}
 
-	file = open (filename, O_RDONLY);
+	file = open (location, O_RDONLY);
 	if (file < 0) {
-		fprintf (stderr, "Filename %s could not be opened for reading\n", filename);
+		fprintf (stderr, "File %s could not be opened for reading\n", location);
 		goto error;
 	}
 
 	filebuf = malloc(buf.st_size);
 	if (!filebuf) {
 		fprintf (stderr, "out of memory\n");
-		goto error_close;
+		goto error;
 	}
 
 	retval = read (file, filebuf, buf.st_size);
 	if (retval < 0) {
-		fprintf (stderr, "Can not read %s file\n", filename);
-		goto error_free;
+		fprintf (stderr, "Can not read %s file\n", location);
+		goto error;
 	}
 
 	sprintf(s,"%s%08X%08X%08lX%08lX%08X%08lX"
@@ -189,40 +242,146 @@
 		1,			/* minor */
 		0,			/* rmajor */
 		0,			/* rminor */
-		(unsigned)strlen(location) + 1,/* namesize */
+		(unsigned)strlen(name) + 1,/* namesize */
 		0);			/* chksum */
 	push_hdr(s);
-	push_string(location);
+	push_string(name);
 	push_pad();
 
 	for (i = 0; i < buf.st_size; ++i)
 		fputc(filebuf[i], stdout);
 	offset += buf.st_size;
-	close(file);
-	free(filebuf);
 	push_pad();
-	return;
+	rc = 0;
 	
-error_free:
-	free(filebuf);
-error_close:
-	close(file);
 error:
-	exit(-1);
+	if (filebuf) free(filebuf);
+	if (file >= 0) close(file);
+	return rc;
 }
 
+static int cpio_mkfile_line(const char *line)
+{
+	char name[PATH_MAX + 1];
+	char location[PATH_MAX + 1];
+	unsigned int mode;
+	uid_t uid;
+	gid_t gid;
+	int rc = -1;
+
+	if (5 != sscanf(line, "%" str(PATH_MAX) "s %" str(PATH_MAX) "s %o %d %d", name, location, &mode, &uid, &gid)) {
+		fprintf(stderr, "Unrecognized file format '%s'", line);
+		goto fail;
+	}
+	rc = cpio_mkfile(name, location, mode, uid, gid);
+ fail:
+	return rc;
+}
+
+void usage(const char *prog)
+{
+	fprintf(stderr, "Usage:\n"
+		"\t%s <cpio_list>\n"
+		"\n"
+		"<cpio_list> is a file containing newline separated entries that\n"
+		"describe the files to be included in the initramfs archive:\n"
+		"\n"
+		"file <name> <location> <mode> <uid> <gid> \n"
+		"dir <name> <mode> <uid> <gid>\n"
+		"nod <name> <mode> <uid> <gid> <dev_type> <maj> <min>\n"
+		"\n"
+		"<name>      name of the file/dir/nod in the archive\n"
+		"<location>  location of the file in the current filesystem\n"
+		"<mode>      mode/permissions of the file\n"
+		"<uid>       user id (0=root)\n"
+		"<gid>       group id (0=root)\n"
+		"<dev_type>  device type (b=block, c=character)\n"
+		"<maj>       major number of nod\n"
+		"<min>       minor number of nod\n"
+		"\n"
+		"example:\n"
+		"dir /dev 0755 0 0\n"
+		"nod /dev/console 0600 0 0 c 5 1\n"
+		"dir /root 0700 0 0\n"
+		"dir /sbin 0755 0 0\n"
+		"file /sbin/kinit /usr/src/klibc/kinit/kinit 0755 0 0\n",
+		prog);
+}
+
+struct file_type file_type_table[] = {
+	{
+		.type    = "file",
+		.handler = cpio_mkfile_line,
+	}, {
+		.type    = "nod",
+		.handler = cpio_mknod_line,
+	}, {
+		.type    = "dir",
+		.handler = cpio_mkdir_line,
+	}, {
+		.type    = NULL,
+		.handler = NULL,
+	}
+};
+
 int main (int argc, char *argv[])
 {
-	cpio_mkdir("/dev", 0755, 0, 0);
-	cpio_mknod("/dev/console", 0600, 0, 0, 'c', 5, 1);
-	cpio_mkdir("/root", 0700, 0, 0);
-	cpio_trailer();
+	FILE *cpio_list;
+	char *line = NULL, *args, *type;
+	size_t line_sz = 0;
+	int ec = 0;
+	int line_nr = 0;
+
+	if (2 != argc) {
+		usage(argv[0]);
+		exit(1);
+	}
+
+	if (! (cpio_list = fopen(argv[1], "r"))) {
+		fprintf(stderr, "ERROR: unable to open '%s': %s\n\n",
+			argv[1], strerror(errno));
+		usage(argv[0]);
+		exit(1);
+	}
 
-	exit(0);
+	while (-1 != getline(&line, &line_sz, cpio_list)) {
+		int type_idx;
 
-	/* silence compiler warnings */
-	return 0;
-	(void) argc;
-	(void) argv;
+		line_nr++;
+
+		if (! (type = strtok(line, " \t"))) {
+			fprintf(stderr,
+				"ERROR: incorrect format, could not locate file type line %d: '%s'\n",
+				line_nr, line);
+			ec = -1;
+		}
+
+		if (! (args = strtok(NULL, "\n"))) {
+			fprintf(stderr,
+				"ERROR: incorrect format, newline required line %d: '%s'\n",
+				line_nr, line);
+			ec = -1;
+		}
+
+		for (type_idx = 0; file_type_table[type_idx].type; type_idx++) {
+			int rc;
+			if (! strcmp(line, file_type_table[type_idx].type)) {
+				if ((rc = file_type_table[type_idx].handler(args))) {
+					ec = rc;
+					fprintf(stderr, " line %d\n", line_nr);
+				}
+				break;
+			}
+		}
+
+		if (NULL == file_type_table[type_idx].type) {
+			fprintf(stderr, "unknown file type line %d: '%s'\n",
+				line_nr, line);
+		}
+	}
+	cpio_trailer();
+
+	if (line) free(line);
+	exit(ec);
 }
 
diff -uNr linux-2.6.8/usr/initramfs_list linux-2.6.8-cpio_list/usr/initramfs_list
--- linux-2.6.8/usr/initramfs_list	1969-12-31 17:00:00.000000000 -0700
+++ linux-2.6.8-cpio_list/usr/initramfs_list	2004-09-16 15:36:37.686721896 -0600
@@ -0,0 +1,3 @@
+dir /dev 0755 0 0
+nod /dev/console 0600 0 0 c 5 1
+dir /root 0700 0 0
diff -uNr linux-2.6.8/usr/Makefile linux-2.6.8-cpio_list/usr/Makefile
--- linux-2.6.8/usr/Makefile	2004-09-16 15:03:35.535054752 -0600
+++ linux-2.6.8-cpio_list/usr/Makefile	2004-09-16 15:36:37.686721896 -0600
@@ -5,6 +5,11 @@
 
 clean-files := initramfs_data.cpio.gz
 
+# If you want a different list of files in the initramfs_data.cpio
+# then you can either overwrite the cpio_list in this directory
+# or set INITRAMFS_LIST to another filename.
+INITRAMFS_LIST ?= $(obj)/initramfs_list
+
 # initramfs_data.o contains the initramfs_data.cpio.gz image.
 # The image is included using .incbin, a dependency which is not
 # tracked automatically.
@@ -19,9 +24,9 @@
 # initramfs-y := $(obj)/root/hello
 
 quiet_cmd_cpio = CPIO    $@
-      cmd_cpio = ./$< > $@
+      cmd_cpio = ./$< $(INITRAMFS_LIST) > $@
 
-$(obj)/initramfs_data.cpio: $(obj)/gen_init_cpio $(initramfs-y) FORCE
+$(obj)/initramfs_data.cpio: $(obj)/gen_init_cpio $(initramfs-y) $(INITRAMFS_LIST) FORCE
 	$(call if_changed,cpio)
 
 targets += initramfs_data.cpio

--=-53YTvnLoZ7JDr1uMSnnO--

