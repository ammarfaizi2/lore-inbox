Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262107AbVAJFpo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262107AbVAJFpo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 00:45:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262106AbVAJFp2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 00:45:28 -0500
Received: from pool-151-203-193-191.bos.east.verizon.net ([151.203.193.191]:28164
	"EHLO ccure.user-mode-linux.org") by vger.kernel.org with ESMTP
	id S262107AbVAJFOe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 00:14:34 -0500
Message-Id: <200501100735.j0A7ZxPW005830@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.1-RC1
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org
Subject: [PATCH 20/28] UML - 64-bit cleanups
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 10 Jan 2005 02:35:59 -0500
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This makes a bunch of 64-bit cleanups exposed by x86_64.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: 2.6.10/arch/um/drivers/cow.h
===================================================================
--- 2.6.10.orig/arch/um/drivers/cow.h	2005-01-09 19:06:06.000000000 -0500
+++ 2.6.10/arch/um/drivers/cow.h	2005-01-09 21:51:30.000000000 -0500
@@ -21,11 +21,12 @@
 extern int read_cow_header(int (*reader)(__u64, char *, int, void *),
 			   void *arg, __u32 *version_out,
 			   char **backing_file_out, time_t *mtime_out,
-			   __u64 *size_out, int *sectorsize_out,
+			   unsigned long long *size_out, int *sectorsize_out,
 			   __u32 *align_out, int *bitmap_offset_out);
 
 extern int write_cow_header(char *cow_file, int fd, char *backing_file,
-			    int sectorsize, int alignment, long long *size);
+			    int sectorsize, int alignment, 
+			    unsigned long long *size);
 
 extern void cow_sizes(int version, __u64 size, int sectorsize, int align,
 		      int bitmap_offset, unsigned long *bitmap_len_out,
Index: 2.6.10/arch/um/drivers/cow_sys.h
===================================================================
--- 2.6.10.orig/arch/um/drivers/cow_sys.h	2005-01-09 19:06:06.000000000 -0500
+++ 2.6.10/arch/um/drivers/cow_sys.h	2005-01-09 21:51:30.000000000 -0500
@@ -23,12 +23,12 @@
 	return(uml_strdup(str));
 }
 
-static inline int cow_seek_file(int fd, __u64 offset)
+static inline int cow_seek_file(int fd, unsigned long long offset)
 {
 	return(os_seek_file(fd, offset));
 }
 
-static inline int cow_file_size(char *file, __u64 *size_out)
+static inline int cow_file_size(char *file, unsigned long long *size_out)
 {
 	return(os_file_size(file, size_out));
 }
Index: 2.6.10/arch/um/drivers/cow_user.c
===================================================================
--- 2.6.10.orig/arch/um/drivers/cow_user.c	2005-01-09 19:06:06.000000000 -0500
+++ 2.6.10/arch/um/drivers/cow_user.c	2005-01-09 21:51:30.000000000 -0500
@@ -159,7 +159,7 @@
 }
 
 int write_cow_header(char *cow_file, int fd, char *backing_file,
-		     int sectorsize, int alignment, long long *size)
+		     int sectorsize, int alignment, unsigned long long *size)
 {
 	struct cow_header_v3 *header;
 	unsigned long modtime;
@@ -236,7 +236,7 @@
 
 int read_cow_header(int (*reader)(__u64, char *, int, void *), void *arg,
 		    __u32 *version_out, char **backing_file_out,
-		    time_t *mtime_out, __u64 *size_out,
+		    time_t *mtime_out, unsigned long long *size_out,
 		    int *sectorsize_out, __u32 *align_out,
 		    int *bitmap_offset_out)
 {
@@ -329,7 +329,7 @@
 		  int alignment, int *bitmap_offset_out,
 		  unsigned long *bitmap_len_out, int *data_offset_out)
 {
-	__u64 size, offset;
+	unsigned long long size, offset;
 	char zero = 0;
 	int err;
 
Index: 2.6.10/arch/um/drivers/mconsole_kern.c
===================================================================
--- 2.6.10.orig/arch/um/drivers/mconsole_kern.c	2005-01-09 19:06:06.000000000 -0500
+++ 2.6.10/arch/um/drivers/mconsole_kern.c	2005-01-09 21:51:30.000000000 -0500
@@ -73,11 +73,12 @@
 static irqreturn_t mconsole_interrupt(int irq, void *dev_id,
 				      struct pt_regs *regs)
 {
-	int fd;
+	/* long to avoid size mismatch warnings from gcc */
+	long fd; 
 	struct mconsole_entry *new;
 	struct mc_request req;
 
-	fd = (int) dev_id;
+	fd = (long) dev_id;
 	while (mconsole_get_request(fd, &req)){
 		if(req.cmd->context == MCONSOLE_INTR)
 			(*req.cmd->handler)(&req);
@@ -457,7 +458,9 @@
 
 int mconsole_init(void)
 {
-	int err, sock;
+	/* long to avoid size mismatch warnings from gcc */
+	long sock;
+	int err;
 	char file[256];
 
 	if(umid_file_name("mconsole", file, sizeof(file))) return(-1);
Index: 2.6.10/arch/um/drivers/ubd_user.c
===================================================================
--- 2.6.10.orig/arch/um/drivers/ubd_user.c	2005-01-09 19:06:06.000000000 -0500
+++ 2.6.10/arch/um/drivers/ubd_user.c	2005-01-09 21:51:30.000000000 -0500
@@ -107,7 +107,7 @@
 		  int *create_cow_out)
 {
 	time_t mtime;
-	__u64 size;
+	unsigned long long size;
 	__u32 version, align;
 	char *backing_file;
 	int fd, err, sectorsize, same, mode = 0644;
Index: 2.6.10/arch/um/include/um_uaccess.h
===================================================================
--- 2.6.10.orig/arch/um/include/um_uaccess.h	2005-01-09 19:06:06.000000000 -0500
+++ 2.6.10/arch/um/include/um_uaccess.h	2005-01-09 21:51:30.000000000 -0500
@@ -105,7 +105,7 @@
  * On exception, returns 0.
  * If the string is too long, returns a value greater than @n.
  */
-static inline int strnlen_user(const void *str, int len)
+static inline int strnlen_user(const void *str, long len)
 {
 	return(CHOOSE_MODE_PROC(strnlen_user_tt, strnlen_user_skas, str, len));
 }

