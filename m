Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274799AbTGaOe0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Jul 2003 10:34:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274802AbTGaOe0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Jul 2003 10:34:26 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:64268 "EHLO
	www.home.local") by vger.kernel.org with ESMTP id S274799AbTGaOeS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Jul 2003 10:34:18 -0400
Date: Thu, 31 Jul 2003 16:33:50 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Keith Owens <kaos@ocs.com.au>
Cc: Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org
Subject: Re: module-init-tools don't support gzipped modules.
Message-ID: <20030731143350.GA30865@alpha.home.local>
References: <20030730183635.0B82D2C097@lists.samba.org> <2347.1059613595@kao2.melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2347.1059613595@kao2.melbourne.sgi.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 31, 2003 at 11:06:35AM +1000, Keith Owens wrote:
> On Thu, 31 Jul 2003 02:46:23 +1000, 
> Rusty Russell <rusty@rustcorp.com.au> wrote:
> >I don't want to require zlib, though.  The modutils I have (Debian)
> >doesn't support it, either.
> 
> Really?  modutils 2.4: ./configure --enable-zlib

Ok, here is a patch against module-init-tools-0.9.13-pre that I ported from
modutils. I haven't tested it yet since I don't have any 2.6 kernel right here.
But at least it compiles with and without zlib.

After applying the patch, you'll have to run aclocal, automake and autoconf
as specified in the README.

There's one thing I'm not sure about. There were mmap() calls which I replaced
with malloc()+read(). I don't know if the syscall supports such a way to load
modules. Volunteers will have to try it :-)

Cheers,
Willy


diff -urN --exclude aclocal.m4 --exclude Makefile.in --exclude configure module-init-tools-0.9.13-pre/Makefile.am module-init-tools-0.9.13-pre-gz/Makefile.am
--- module-init-tools-0.9.13-pre/Makefile.am	Tue May 13 07:45:21 2003
+++ module-init-tools-0.9.13-pre-gz/Makefile.am	Thu Jul 31 16:16:50 2003
@@ -1,12 +1,13 @@
-insmod_SOURCES = insmod.c testing.h
+insmod_SOURCES = insmod.c gzfiles.c testing.h
 lsmod_SOURCES = lsmod.c testing.h
-modprobe_SOURCES = modprobe.c testing.h
+modprobe_SOURCES = modprobe.c gzfiles.c testing.h
 rmmod_SOURCES = rmmod.c testing.h
-depmod_SOURCES = depmod.c moduleops.c tables.c depmod.h moduleops.h tables.h list.h testing.h
-modinfo_SOURCES = modinfo.c testing.h 
+depmod_SOURCES = depmod.c gzfiles.c moduleops.c tables.c depmod.h moduleops.h tables.h list.h testing.h
+modinfo_SOURCES = modinfo.c gzfiles.c testing.h 
 
-insmod_static_SOURCES = insmod.c
+insmod_static_SOURCES = insmod.c gzfiles.c
 insmod_static_LDFLAGS = -static
+insmod_static_LDADD = $(LDADD) $(stat_zlib_flags)
 
 EXTRA_insmod_SOURCES = backwards_compat.c
 EXTRA_lsmod_SOURCES = backwards_compat.c
diff -urN --exclude aclocal.m4 --exclude Makefile.in --exclude configure module-init-tools-0.9.13-pre/configure.in module-init-tools-0.9.13-pre-gz/configure.in
--- module-init-tools-0.9.13-pre/configure.in	Wed May 14 02:21:15 2003
+++ module-init-tools-0.9.13-pre-gz/configure.in	Thu Jul 31 16:13:36 2003
@@ -4,7 +4,23 @@
 
 AM_INIT_AUTOMAKE(module-init-tools,"0.9.13-pre")
 
+# If zlib is required, libz must be linked static, insmod is in /sbin, libz is
+# in /usr/lib and may not be available when insmod is run.
+AC_ARG_ENABLE(zlib,
+[  --disable-zlib               Do not handle gzipped objects (default)],
+[if test "$enableval" = "yes"; then
+  AC_DEFINE(CONFIG_USE_ZLIB)
+  zlib_flags="-Wl,-Bstatic -lz -Wl,-Bdynamic"
+  stat_zlib_flags="-Wl,-Bstatic"
+fi])
+
 AC_PROG_CC
+
+# Delay adding the zlib_flags until after AC_PROG_CC, so we can distinguish
+# between a broken cc and a working cc but missing libz.a.
+LDADD="$LDADD $zlib_flags"
+AC_SUBST(LDADD)
+AC_SUBST(stat_zlib_flags)
 
 case $target in
 *-*-linux*) ;;
diff -urN --exclude aclocal.m4 --exclude Makefile.in --exclude configure module-init-tools-0.9.13-pre/depmod.c module-init-tools-0.9.13-pre-gz/depmod.c
--- module-init-tools-0.9.13-pre/depmod.c	Tue May 13 07:34:46 2003
+++ module-init-tools-0.9.13-pre-gz/depmod.c	Thu Jul 31 16:02:16 2003
@@ -23,6 +23,7 @@
 #include "tables.h"
 
 #include "testing.h"
+#include "gzfiles.h"
 
 /* I hate strcmp. */
 #define streq(a,b) (strcmp((a),(b)) == 0)
@@ -291,8 +292,15 @@
 		     new->pathname, strerror(errno));
 		goto fail;
 	}
+#ifndef CONFIG_USE_ZLIB
 	fstat(fd, &buf);
 	new->mmap = mmap(0, buf.st_size, PROT_READ, MAP_PRIVATE, fd, 0);
+#else
+	bzero(&buf, sizeof(buf));
+	new->mmap = gzf_load(fd, &buf.st_size);
+	if (new->mmap == NULL)
+	    new->mmap = MAP_FAILED;
+#endif
 	if (new->mmap == MAP_FAILED) {
 		warn("Can't map module %s: %s\n",
 		     new->pathname, strerror(errno));
diff -urN --exclude aclocal.m4 --exclude Makefile.in --exclude configure module-init-tools-0.9.13-pre/gzfiles.c module-init-tools-0.9.13-pre-gz/gzfiles.c
--- module-init-tools-0.9.13-pre/gzfiles.c	Thu Jan  1 01:00:00 1970
+++ module-init-tools-0.9.13-pre-gz/gzfiles.c	Thu Jul 31 13:38:00 2003
@@ -0,0 +1,124 @@
+/*
+ * This simple library intends to make it transparent to read gzipped and/or
+ * standard files. This is simple enough to fit modutils' needs, but may be
+ * easily adapted to anyone's needs. It's completely free, do what you want
+ * with it .  - Willy Tarreau <willy@meta-x.org> - 2000/05/05 -
+ *
+ * Changes :
+ *
+ * 2003/07/31 - willy tarreau
+ *   - added gzf_load()
+ *   - version 0.2
+ */
+
+#ifdef CONFIG_USE_ZLIB
+
+#include <stdio.h>
+#include <zlib.h>
+#include <sys/types.h>
+#include <fcntl.h>
+#include <unistd.h>
+#include <stdlib.h>
+
+/* redefinition of gz_stream which isn't exported by zlib */
+typedef struct gz_stream {
+    z_stream stream;
+    int      z_err;   /* error code for last stream operation */
+    int      z_eof;   /* set if end of input file */
+    FILE     *file;   /* .gz file */
+    Byte     *inbuf;  /* input buffer */
+    Byte     *outbuf; /* output buffer */
+    uLong    crc;     /* crc32 of uncompressed data */
+    char     *msg;    /* error message */
+    char     *path;   /* path name for debugging only */
+    int      transparent; /* 1 if input file is not a .gz file */
+    char     mode;    /* 'w' or 'r' */
+    long     startpos; /* start of compressed data in file (header skipped) */
+} gz_stream;
+
+/* maximum number of simultaneous open files, also greater file descriptor number */
+#define MAXFD	64
+
+/* this static list is assumed to be filled with NULLs at runtime */
+static gzFile gzf_fds[MAXFD];
+
+/* returns the filedesc of the opened file. */
+int gzf_open(const char *name, int mode)
+{
+    int fd;
+    gzFile g;
+
+    if ((g=gzopen(name, "rb")) != NULL) {
+	fd=fileno(((gz_stream*)g)->file);
+	gzf_fds[fd]=g;
+    }
+    else if ((fd=open(name, mode)) != -1) {
+	gzf_fds[fd]=NULL; /* NULL means not GZ mode */
+    }
+    return fd;
+}
+
+off_t gzf_lseek(int fd, off_t offset, int whence)
+{
+    if (fd<0 || fd>=MAXFD || gzf_fds[fd]==NULL)
+	return lseek(fd, offset, whence);
+    else
+	return gzseek(gzf_fds[fd], offset, whence);
+}
+
+int gzf_read(int fd, void *buf, size_t count)
+{
+    if (fd<0 || fd>=MAXFD || gzf_fds[fd]==NULL)
+	return read(fd, buf, count);
+    else
+	return gzread(gzf_fds[fd], buf, count);
+}
+
+void gzf_close(int fd)
+{
+    if (fd<0 || fd>=MAXFD || gzf_fds[fd]==NULL)
+	close(fd);
+    else
+	gzclose(gzf_fds[fd]);
+}
+
+#define READBLK 1024
+
+/* loads a complete file in memory, an return a pointer to the newly allocated
+ * zone, and its size if required. This may be used to emulate mmap() in certain
+ * occasions.
+ */
+void *gzf_load(int fd, off_t *size)
+{
+	void *new, *ret = NULL;
+	unsigned long allocated = 0;
+	unsigned long used = 0;
+	int r;
+
+	do {
+	    if (allocated < used + READBLK) {
+		new = realloc(ret, allocated + READBLK);
+		if (new == NULL) {
+		    free(ret);
+		    return NULL;
+		}
+		ret = new;
+		allocated += READBLK;
+	    }	
+
+	    r = gzf_read(fd, ret + used, allocated - used);
+	    if (r < 0) {
+		free(ret);
+		return NULL;
+	    }
+	    used += r;
+	} while (r);
+
+	if (size != NULL)
+	    *size = used;
+
+	return ret;
+}
+
+
+#endif
diff -urN --exclude aclocal.m4 --exclude Makefile.in --exclude configure module-init-tools-0.9.13-pre/gzfiles.h module-init-tools-0.9.13-pre-gz/gzfiles.h
--- module-init-tools-0.9.13-pre/gzfiles.h	Thu Jan  1 01:00:00 1970
+++ module-init-tools-0.9.13-pre-gz/gzfiles.h	Thu Jul 31 12:32:02 2003
@@ -0,0 +1,22 @@
+#ifndef GZFILES_H
+#define GZFILES_H
+
+#ifdef CONFIG_USE_ZLIB
+extern int gzf_open(const char *name, int mode);
+extern int gzf_read(int fd, void *buf, size_t count);
+extern off_t gzf_lseek(int fd, off_t offset, int whence);
+extern void gzf_close(int fd);
+extern void *gzf_load(int fd, off_t *size);
+
+#else /* ! CONFIG_USE_ZLIB */
+
+#include <unistd.h>
+
+#define gzf_open        open
+#define gzf_read        read
+#define gzf_lseek       lseek
+#define gzf_close       close
+
+#endif /* CONFIG_USE_ZLIB */
+
+#endif /* GZFILES_H */
diff -urN --exclude aclocal.m4 --exclude Makefile.in --exclude configure module-init-tools-0.9.13-pre/insmod.c module-init-tools-0.9.13-pre-gz/insmod.c
--- module-init-tools-0.9.13-pre/insmod.c	Sat Dec 21 07:34:27 2002
+++ module-init-tools-0.9.13-pre-gz/insmod.c	Thu Jul 31 13:39:49 2003
@@ -29,6 +29,7 @@
 #include <asm/unistd.h>
 
 #include "backwards_compat.c"
+#include "gzfiles.h"
 
 static void print_usage(const char *progname)
 {
@@ -99,9 +100,16 @@
 		exit(1);
 	}
 
+#ifndef CONFIG_USE_ZLIB
 	fstat(fd, &st);
 	len = st.st_size;
 	map = mmap(NULL, len, PROT_READ, MAP_SHARED, fd, 0);
+#else
+	bzero(&st, sizeof(st));
+	map = gzf_load(fd, &st.st_size);
+	if (map == NULL)
+	    map = MAP_FAILED;
+#endif
 	if (map == MAP_FAILED) {
 		fprintf(stderr, "Can't map '%s': %s\n",
 			filename, strerror(errno));
diff -urN --exclude aclocal.m4 --exclude Makefile.in --exclude configure module-init-tools-0.9.13-pre/modinfo.c module-init-tools-0.9.13-pre-gz/modinfo.c
--- module-init-tools-0.9.13-pre/modinfo.c	Fri May  9 02:57:09 2003
+++ module-init-tools-0.9.13-pre-gz/modinfo.c	Thu Jul 31 13:40:41 2003
@@ -13,6 +13,7 @@
 #include <sys/utsname.h>
 #include <sys/mman.h>
 #include "backwards_compat.c"
+#include "gzfiles.h"
 
 #define streq(a,b) (strcmp((a),(b)) == 0)
 
@@ -219,9 +220,16 @@
 		}
 	}
 
+#ifndef CONFIG_USE_ZLIB
 	fstat(fd, &st);
 	*size = st.st_size;
 	map = mmap(NULL, *size, PROT_READ, MAP_PRIVATE, fd, 0);
+#else
+	bzero(&st, sizeof(st));
+	map = gzf_load(fd, size);
+	if (map == NULL)
+	    map = MAP_FAILED;
+#endif
 	if (map == MAP_FAILED) {
 		fprintf(stderr, "Could not find module %s\n", name);
 		close(fd);
diff -urN --exclude aclocal.m4 --exclude Makefile.in --exclude configure module-init-tools-0.9.13-pre/modprobe.c module-init-tools-0.9.13-pre-gz/modprobe.c
--- module-init-tools-0.9.13-pre/modprobe.c	Wed Jun 11 08:01:53 2003
+++ module-init-tools-0.9.13-pre-gz/modprobe.c	Thu Jul 31 12:30:49 2003
@@ -41,6 +41,7 @@
 
 #include "list.h"
 #include "backwards_compat.c"
+#include "gzfiles.h"
 
 struct module {
 	struct list_head list;
@@ -729,8 +730,13 @@
 		goto out_optstring;
 	}
 
+#ifndef CONFIG_USE_ZLIB
 	fstat(fd, &st);
 	map = read_in(fd, st.st_size);
+#else
+	bzero(&st, sizeof(st));
+	map = gzf_load(fd, &st.st_size);
+#endif
 	if (!map) {
 		if (dont_fail)
 			fatal("Can't read '%s': %s\n",
