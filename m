Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263003AbUIQW7R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263003AbUIQW7R (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Sep 2004 18:59:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269026AbUIQW7R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Sep 2004 18:59:17 -0400
Received: from 208.177.141.226.ptr.us.xo.net ([208.177.141.226]:57064 "HELO
	ash.lnxi.com") by vger.kernel.org with SMTP id S263003AbUIQW51
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Sep 2004 18:57:27 -0400
Subject: Re: [PATCH] gen_init_cpio uses external file list
From: Thayne Harbaugh <tharbaugh@lnxi.com>
Reply-To: tharbaugh@lnxi.com
To: Sam Ravnborg <sam@ravnborg.org>
Cc: akpm@digeo.com, linux-kernel@vger.kernel.org, klibc@zytor.com,
       jgarzik@pobox.com
In-Reply-To: <20040917044959.GA8338@mars.ravnborg.org>
References: <1095372672.19900.72.camel@tubarao>
	 <20040917044959.GA8338@mars.ravnborg.org>
Content-Type: multipart/mixed; boundary="=-v+XQVusuXS8lp4Nl/fkO"
Organization: Linux Networx
Date: Fri, 17 Sep 2004 16:38:20 -0600
Message-Id: <1095460700.19900.101.camel@tubarao>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.94.1 (1.5.94.1-1) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-v+XQVusuXS8lp4Nl/fkO
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, 2004-09-17 at 06:49 +0200, Sam Ravnborg wrote:
> On Thu, Sep 16, 2004 at 04:11:12PM -0600, Thayne Harbaugh wrote:
> > 
> > This patch makes gen_init_cpio generate the initramfs_data.cpio from a
> > file which contains a list of entries: file, dir, nod.  I swapped the
> > order of filename/location for the file arguments so that it would be
> > more uniform with the dir and nod tyes.
> 
> Comments already given on klibc list by others, but repeated for lkml readers.
> 
> Helper programs like this shall be compatible with at least solaris & cygwin.
> Therefore the linux only stuff needs to be avoided.

More correctly is GNU only stuff - but point taken.  _GNU_SOURCE
removed.

> Do we know that uid_t and gid_t equals an int here?
> Use an int in the sscanf and do explicit type conversion later.

fixed.

> fgets() please.

fixed - although it's not as clean and flexible as what was there
(although more portable).

This newer patch also adds skipping of comments (initiated with #) and
blank lines.


--=-v+XQVusuXS8lp4Nl/fkO
Content-Disposition: attachment; filename=cpio_list.3.patch
Content-Type: text/x-patch; name=cpio_list.3.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

diff -uNr linux-2.6.8.orig/usr/gen_init_cpio.c linux-2.6.8/usr/gen_init_cpio.c
--- linux-2.6.8.orig/usr/gen_init_cpio.c	2004-08-14 04:55:34.000000000 -0600
+++ linux-2.6.8/usr/gen_init_cpio.c	2004-09-17 16:58:14.419508872 -0600
@@ -6,10 +6,21 @@
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
@@ -80,7 +91,7 @@
 	}
 }
 
-static void cpio_mkdir(const char *name, unsigned int mode,
+static int cpio_mkdir(const char *name, unsigned int mode,
 		       uid_t uid, gid_t gid)
 {
 	char s[256];
@@ -104,10 +115,28 @@
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
+	int uid;
+	int gid;
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
@@ -136,43 +165,66 @@
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
+	int uid;
+	int gid;
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
@@ -189,40 +241,164 @@
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
+	int uid;
+	int gid;
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
+		"# a comment\n"
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
+		"# A simple initramfs\n"
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
+#define LINE_SIZE (2 * PATH_MAX + 50)
+
 int main (int argc, char *argv[])
 {
-	cpio_mkdir("/dev", 0755, 0, 0);
-	cpio_mknod("/dev/console", 0600, 0, 0, 'c', 5, 1);
-	cpio_mkdir("/root", 0700, 0, 0);
-	cpio_trailer();
+	FILE *cpio_list;
+	char line[LINE_SIZE];
+	char *args, *type;
+	int ec = 0;
+	int line_nr = 0;
+
+	if (2 != argc) {
+		usage(argv[0]);
+		exit(1);
+	}
 
-	exit(0);
+	if (! (cpio_list = fopen(argv[1], "r"))) {
+		fprintf(stderr, "ERROR: unable to open '%s': %s\n\n",
+			argv[1], strerror(errno));
+		usage(argv[0]);
+		exit(1);
+	}
 
-	/* silence compiler warnings */
-	return 0;
-	(void) argc;
-	(void) argv;
-}
+	while (fgets(line, LINE_SIZE, cpio_list)) {
+		int type_idx;
+		size_t slen = strlen(line);
+
+		line_nr++;
+
+		if ('#' == *line) {
+			/* comment - skip to next line */
+			continue;
+		}
+
+		if (! (type = strtok(line, " \t"))) {
+			fprintf(stderr,
+				"ERROR: incorrect format, could not locate file type line %d: '%s'\n",
+				line_nr, line);
+			ec = -1;
+		}
+
+		if ('\n' == *type) {
+			/* a blank line */
+			continue;
+		}
+
+		if (slen == strlen(type)) {
+			/* must be an empty line */
+			continue;
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
 
+	exit(ec);
+}
diff -uNr linux-2.6.8.orig/usr/initramfs_list linux-2.6.8/usr/initramfs_list
--- linux-2.6.8.orig/usr/initramfs_list	1969-12-31 17:00:00.000000000 -0700
+++ linux-2.6.8/usr/initramfs_list	2004-09-17 15:50:11.392223368 -0600
@@ -0,0 +1,5 @@
+# This is a very simple initramfs - mostly preliminary for future expansion
+
+dir /dev 0755 0 0
+nod /dev/console 0600 0 0 c 5 1
+dir /root 0700 0 0
diff -uNr linux-2.6.8.orig/usr/Makefile linux-2.6.8/usr/Makefile
--- linux-2.6.8.orig/usr/Makefile	2004-08-14 04:55:33.000000000 -0600
+++ linux-2.6.8/usr/Makefile	2004-09-16 15:45:24.343657872 -0600
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

--=-v+XQVusuXS8lp4Nl/fkO--

