Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315130AbSD2MOV>; Mon, 29 Apr 2002 08:14:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315133AbSD2MOU>; Mon, 29 Apr 2002 08:14:20 -0400
Received: from krynn.axis.se ([193.13.178.10]:38537 "EHLO krynn.axis.se")
	by vger.kernel.org with ESMTP id <S315130AbSD2MOS>;
	Mon, 29 Apr 2002 08:14:18 -0400
Date: Mon, 29 Apr 2002 14:10:35 +0200 (CEST)
From: Johan Adolfsson <johan.adolfsson@axis.com>
X-X-Sender: <johana@ado-2.axis.se>
To: <quinlan@transmeta.com>
cc: <linux-kernel@vger.kernel.org>, <johan.adolfsson@axis.com>
Subject: [PATCH] cramfs 3/6 mkcramfs and cramfsck -b and timestamp
Message-ID: <Pine.LNX.4.33.0204291403050.25892-100000@ado-2.axis.se>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


3. The tools: mkcramfs.c and cramfsck.c: Add support for timestamp in the
   edition field (fstime) and added the option -b blocksize.
   For cramfsck.c it also fixes a segfault that occured in the error
   message if the incorrect blocksize is used (order of arguments wrong).

Against cramfs-1.1 from sourceforge.

Please apply
/Johan


--- mkcramfs_org.c	Thu Apr 25 21:44:33 2002
+++ mkcramfs.c	Thu Apr 25 23:22:06 2002
@@ -2,6 +2,7 @@
  * mkcramfs - make a cramfs file system
  *
  * Copyright (C) 1999-2002 Transmeta Corporation
+ * Portions Copyright (C) 2002 Axis Communications AB, Sweden
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -35,6 +36,7 @@
 #include <stdarg.h>
 #include <linux/cramfs_fs.h>
 #include <zlib.h>
+#include <time.h>

 /* Exit codes used by mkfs-type programs */
 #define MKFS_OK          0	/* No errors */
@@ -45,7 +47,7 @@
 #define PAD_SIZE 512

 /* The kernel assumes PAGE_CACHE_SIZE as block size. */
-#define PAGE_CACHE_SIZE (4096)
+#define DEFAULT_PAGE_CACHE_SIZE (4096)

 /*
  * The longest filename component to allow for in the input directory tree.
@@ -69,12 +71,14 @@
  */
 #define MAXFSLEN ((((1 << CRAMFS_OFFSET_WIDTH) - 1) << 2) /* offset */ \
 		  + (1 << CRAMFS_SIZE_WIDTH) - 1 /* filesize */ \
-		  + (1 << CRAMFS_SIZE_WIDTH) * 4 / PAGE_CACHE_SIZE /* block pointers */ )
+		  + (1 << CRAMFS_SIZE_WIDTH) * 4 / blksize /* block pointers */ )

 static const char *progname = "mkcramfs";
-static unsigned int blksize = PAGE_CACHE_SIZE;
+static unsigned int blksize = DEFAULT_PAGE_CACHE_SIZE;
 static long total_blocks = 0, total_nodes = 1; /* pre-count the root node */
 static int image_length = 0;
+static time_t newest_time = 0; /* Newest file in the filesystem */
+static int timestamp_in_edition = 1; /* Default timestamp is on */

 /*
  * If opt_holes is set, then mkcramfs can create explicit holes in the
@@ -123,18 +127,19 @@
 {
 	FILE *stream = status ? stderr : stdout;

-	fprintf(stream, "usage: %s [-h] [-e edition] [-i file] [-n name] dirname outfile\n"
-		" -h         print this help\n"
-		" -E         make all warnings errors (non-zero exit status)\n"
-		" -e edition set edition number (part of fsid)\n"
-		" -i file    insert a file image into the filesystem (requires >= 2.4.0)\n"
-		" -n name    set name of cramfs filesystem\n"
-		" -p         pad by %d bytes for boot code\n"
-		" -s         sort directory entries (old option, ignored)\n"
-		" -v         be more verbose\n"
-		" -z         make explicit holes (requires >= 2.3.39)\n"
-		" dirname    root of the directory tree to be compressed\n"
-		" outfile    output file\n", progname, PAD_SIZE);
+	fprintf(stream, "usage: %s [options] dirname outfile\n"
+		" -h           print this help\n"
+		" -E           make all warnings errors (non-zero exit status)\n"
+		" -b blocksize the page-size (default is 4096)\n"
+		" -e edition   set edition number (part of fsid) (default timestamp)\n"
+		" -i file      insert a file image into the filesystem (requires >= 2.4.0)\n"
+		" -n name      set name of cramfs filesystem\n"
+		" -p           pad by %d bytes for boot code\n"
+		" -s           sort directory entries (old option, ignored)\n"
+		" -v           be more verbose\n"
+		" -z           make explicit holes (requires >= 2.3.39)\n"
+		" dirname      root of the directory tree to be compressed\n"
+		" outfile      output file\n", progname, PAD_SIZE);

 	exit(status);
 }
@@ -280,6 +285,13 @@
 			warn_skip = 1;
 			continue;
 		}
+		/* Update the newest time */
+		if (st.st_mtime > newest_time) {
+			newest_time = st.st_mtime;
+		}
+		if (st.st_ctime > newest_time) {
+			newest_time = st.st_ctime;
+		}
 		entry = calloc(1, sizeof(struct entry));
 		if (!entry) {
 			die(MKFS_ERROR, 1, "calloc failed");
@@ -386,6 +398,11 @@
 		super->flags |= CRAMFS_FLAG_HOLES;
 	if (image_length > 0)
 		super->flags |= CRAMFS_FLAG_SHIFTED_ROOT_OFFSET;
+	if (timestamp_in_edition) {
+		opt_edition = newest_time;
+		super->flags |= CRAMFS_FLAG_EDITION_TIMESTAMP;
+		printf("Edition timestamp: %lu = %s\n", (unsigned long)opt_edition, ctime(&newest_time));
+	}
 	super->size = size;
 	memcpy(super->signature, CRAMFS_SIGNATURE, sizeof(super->signature));

@@ -699,7 +716,7 @@
 		progname = argv[0];

 	/* command line options */
-	while ((c = getopt(argc, argv, "hEe:i:n:psvz")) != EOF) {
+	while ((c = getopt(argc, argv, "hEe:i:b:n:psvz")) != EOF) {
 		switch (c) {
 		case 'h':
 			usage(MKFS_OK);
@@ -708,6 +725,7 @@
 			break;
 		case 'e':
 			errno = 0;
+			timestamp_in_edition = 0;
 			opt_edition = strtoul(optarg, &ep, 10);
 			if (errno || optarg[0] == '\0' || *ep != '\0')
 				usage(MKFS_USAGE);
@@ -720,6 +738,12 @@
 			image_length = st.st_size; /* may be padded later */
 			fslen_ub += (image_length + 3); /* 3 is for padding */
 			break;
+		case 'b':
+			blksize = atoi(optarg);
+			if (blksize <= 0) {
+				die(MKFS_ERROR,0,"wrong block size\n");
+			}
+			break;
 		case 'n':
 			opt_name = optarg;
 			break;
@@ -744,6 +768,7 @@
 	dirname = argv[optind];
 	outfile = argv[optind + 1];

+	printf("Using a blocksize of %d bytes.\n", blksize);
 	if (stat(dirname, &st) < 0) {
 		die(MKFS_USAGE, 1, "stat failed: %s", dirname);
 	}
--- cramfsck_org.c	Fri Apr 26 11:58:23 2002
+++ cramfsck.c	Fri Apr 26 13:50:07 2002
@@ -2,6 +2,7 @@
  * cramfsck - check a cramfs file system
  *
  * Copyright (C) 2000-2002 Transmeta Corporation
+ * Portions Copyright (C) 2002 Axis Communciations AB, Sweden
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -49,12 +50,14 @@
 #include <string.h>
 #include <sys/sysmacros.h>
 #include <utime.h>
+#include <time.h>
 #include <sys/ioctl.h>
 #define _LINUX_STRING_H_
 #include <linux/fs.h>
 #include <linux/cramfs_fs.h>
 #include <zlib.h>

+
 /* Exit codes used by fsck-type programs */
 #define FSCK_OK          0	/* No errors */
 #define FSCK_NONDESTRUCT 1	/* File system errors corrected */
@@ -65,7 +68,9 @@
 #define FSCK_LIBRARY     128	/* Shared library error */

 #define PAD_SIZE 512
-#define PAGE_CACHE_SIZE (4096)
+#define DEFAULT_PAGE_CACHE_SIZE (4096)
+#define MAX_PAGE_CACHE_SIZE (32768)
+static unsigned int blksize = DEFAULT_PAGE_CACHE_SIZE;

 static const char *progname = "cramfsck";

@@ -92,7 +97,7 @@
 static unsigned long read_buffer_block = ~0UL;

 /* Uncompressing data structures... */
-static char outbuffer[PAGE_CACHE_SIZE*2];
+static char outbuffer[MAX_PAGE_CACHE_SIZE*2];
 static z_stream stream;

 /* Prototypes */
@@ -104,11 +109,13 @@
 {
 	FILE *stream = status ? stderr : stdout;

-	fprintf(stream, "usage: %s [-hv] [-x dir] file\n"
-		" -h         print this help\n"
-		" -x dir     extract into dir\n"
-		" -v         be more verbose\n"
-		" file       file to test\n", progname);
+	fprintf(stream, "usage: %s [-hv] [-b blocksize] [-x dir] file\n"
+		" -h             print this help\n"
+		" -b blocksize   blocksize (default %i, max %i)\n"
+		" -x dir         extract into dir\n"
+		" -v             be more verbose\n"
+		" file           file to test\n",
+		progname, DEFAULT_PAGE_CACHE_SIZE, MAX_PAGE_CACHE_SIZE);

 	exit(status);
 }
@@ -182,7 +189,7 @@
 	if (super.flags & ~CRAMFS_SUPPORTED_FLAGS) {
 		die(FSCK_ERROR, 0, "unsupported filesystem features");
 	}
-	if (super.size < PAGE_CACHE_SIZE) {
+	if (super.size < blksize) {
 		die(FSCK_UNCORRECTED, 0, "superblock size (%d) too small", super.size);
 	}
 	if (super.flags & CRAMFS_FLAG_FSID_VERSION_2) {
@@ -195,6 +202,14 @@
 		else if (*length > super.size) {
 			fprintf(stderr, "warning: file extends past end of filesystem\n");
 		}
+		if (super.flags & CRAMFS_FLAG_EDITION_TIMESTAMP) {
+			if (opt_verbose) {
+				time_t fstime = (time_t) super.fsid.edition;
+				printf("Edition timestamp: %d = %s\n",
+				       super.fsid.edition,
+				       ctime(&fstime));
+			}
+		}
 	}
 	else {
 		fprintf(stderr, "warning: old cramfs format\n");
@@ -335,7 +350,7 @@
 	return cramfs_iget(&super.root);
 }

-static int uncompress_block(void *src, int len)
+static int uncompress_block(void *src, unsigned int len)
 {
 	int err;

@@ -343,27 +358,27 @@
 	stream.avail_in = len;

 	stream.next_out = (unsigned char *) outbuffer;
-	stream.avail_out = PAGE_CACHE_SIZE*2;
+	stream.avail_out = blksize*2;

 	inflateReset(&stream);

-	if (len > PAGE_CACHE_SIZE*2) {
+	if (len > blksize*2) {
 		die(FSCK_UNCORRECTED, 0, "data block too large");
 	}
 	err = inflate(&stream, Z_FINISH);
 	if (err != Z_STREAM_END) {
-		die(FSCK_UNCORRECTED, 0, "decompression error %p(%d): %s",
-		    zError(err), src, len);
+		die(FSCK_UNCORRECTED, 0, "decompression error %p(%d): %s\n\tTry a different blocksize? ",
+		    src, len, zError(err));
 	}
 	return stream.total_out;
 }

 static void do_uncompress(char *path, int fd, unsigned long offset, unsigned long size)
 {
-	unsigned long curr = offset + 4 * ((size + PAGE_CACHE_SIZE - 1) / PAGE_CACHE_SIZE);
+	unsigned long curr = offset + 4 * ((size + blksize - 1) / blksize);

 	do {
-		unsigned long out = PAGE_CACHE_SIZE;
+		unsigned long out = blksize;
 		unsigned long next = *(u32 *) romfs_read(offset);

 		if (next > end_data) {
@@ -373,9 +388,9 @@
 		offset += 4;
 		if (curr == next) {
 			if (opt_verbose > 1) {
-				printf("  hole at %ld (%d)\n", curr, PAGE_CACHE_SIZE);
+				printf("  hole at %ld (%d)\n", curr, blksize);
 			}
-			if (size < PAGE_CACHE_SIZE)
+			if (size < blksize)
 				out = size;
 			memset(outbuffer, 0x00, out);
 		}
@@ -385,8 +400,8 @@
 			}
 			out = uncompress_block(romfs_read(curr), next - curr);
 		}
-		if (size >= PAGE_CACHE_SIZE) {
-			if (out != PAGE_CACHE_SIZE) {
+		if (size >= blksize) {
+			if (out != blksize) {
 				die(FSCK_UNCORRECTED, 0, "non-block (%ld) bytes", out);
 			}
 		} else {
@@ -665,10 +680,17 @@
 		progname = argv[0];

 	/* command line options */
-	while ((c = getopt(argc, argv, "hx:v")) != EOF) {
+	while ((c = getopt(argc, argv, "hb:x:v")) != EOF) {
 		switch (c) {
 		case 'h':
 			usage(FSCK_OK);
+			break;
+		case 'b':
+			blksize = atoi(optarg);
+			if (blksize > MAX_PAGE_CACHE_SIZE || blksize == 0) {
+				die(FSCK_USAGE, 0, "Invalid blocksize");
+			}
+			break;
 		case 'x':
 #ifdef INCLUDE_FS_TESTS
 			opt_extract = 1;

