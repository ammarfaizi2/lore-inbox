Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292292AbSBBOsA>; Sat, 2 Feb 2002 09:48:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292291AbSBBOrp>; Sat, 2 Feb 2002 09:47:45 -0500
Received: from sushi.toad.net ([162.33.130.105]:17611 "EHLO sushi.toad.net")
	by vger.kernel.org with ESMTP id <S292292AbSBBOrd>;
	Sat, 2 Feb 2002 09:47:33 -0500
Subject: [PATCH] Documentation for proc_file_read
From: Thomas Hood <jdthood@mail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.1 
Date: 02 Feb 2002 09:47:42 -0500
Message-Id: <1012661263.1377.28.camel@thanatos>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is a patch that improves (I hope) the documentation
of how user proc-file-read functions should interface with
proc_file_read().  At this stage I just ask that any
interested parties review what I have written.  // Thomas

--- linux-2.4.18-pre7_ORIG/fs/proc/generic.c	Fri Sep  7 13:53:59 2001
+++ linux-2.4.18-pre7/fs/proc/generic.c	Sat Feb  2 09:45:14 2002
@@ -67,23 +67,60 @@
 
 		start = NULL;
 		if (dp->get_info) {
-			/*
-			 * Handle backwards compatibility with the old net
-			 * routines.
-			 */
+			/* Handle old net routines */
 			n = dp->get_info(page, &start, *ppos, count);
 			if (n < count)
 				eof = 1;
 		} else if (dp->read_proc) {
+			/*
+			 * How to be a proc read function
+			 * ------------------------------
+			 *
+			 * Prototype:
+			 *    int f(char *buffer, char **start, off_t offset,
+			 *          int count, int *peof, void *dat)
+			 *
+			 * You may assume that the buffer provided is at least
+			 * 3 KiB in size.
+			 *
+			 * If you know you have supplied all the data there is,
+			 * set the *peof bit.
+			 *
+			 * Three ways to return data:
+			 * A) Set *start = NULL
+			 *    Put the data of the requested offset at that
+			 *    offset within the buffer.  Return the number (n)
+			 *    of bytes there are from the beginning of the
+			 *    buffer up to the last byte of data.  If the
+			 *    number of supplied bytes (= n - offset) is less
+			 *    than the requested count, you will be called
+			 *    again with the requested offset advanced by n.
+			 *    This interface is useful for files no larger
+			 *    than the buffer.
+			 * B) Set *start = a small value (less than buffer!)
+			 *    Put the data of the requested offset at the
+			 *    beginning of the buffer.  Return the number of
+			 *    bytes of data placed there.  If this number is
+			 *    less than the requested count, you will be
+			 *    called again with the requested offset advanced
+			 *    by *start.  This interface is useful when you
+			 *    have a large file consisting of a series of
+			 *    data blocks which you want to count and return
+			 *    as wholes.
+			 *    (hack by Paul.Russell@rustcorp.com.au)
+			 * C) Set *start = a location within the buffer
+			 *    Put the data of the requested offset at *start.
+			 *    Return the number (n) of bytes of data placed
+			 *    there.  If this number is less than the
+			 *    requested count, you will be called again with
+			 *    the requested offset advanced by n.
+			 */
 			n = dp->read_proc(page, &start, *ppos,
 					  count, &eof, dp->data);
 		} else
 			break;
 
-		if (!start) {
-			/*
-			 * For proc files that are less than 4k
-			 */
+		if (start == NULL) {
 			start = page + *ppos;
 			n -= *ppos;
 			if (n <= 0)
@@ -91,19 +128,14 @@
 			if (n > count)
 				n = count;
 		}
-		if (n == 0)
-			break;	/* End of file */
-		if (n < 0) {
+		if (n == 0)   /* end of file */
+			break;
+		if (n < 0) {  /* error */
 			if (retval == 0)
 				retval = n;
 			break;
 		}
 		
-		/* This is a hack to allow mangling of file pos independent
- 		 * of actual bytes read.  Simply place the data at page,
- 		 * return the bytes, and set `start' to the desired offset
- 		 * as an unsigned int. - Paul.Russell@rustcorp.com.au
-		 */
  		n -= copy_to_user(buf, start < page ? page : start, n);
 		if (n == 0) {
 			if (retval == 0)
@@ -111,7 +143,7 @@
 			break;
 		}
 
-		*ppos += start < page ? (long)start : n; /* Move down the file */
+		*ppos += start < page ? (long)start : n;
 		nbytes -= n;
 		buf += n;
 		retval += n;

