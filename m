Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287293AbSBCO6P>; Sun, 3 Feb 2002 09:58:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287303AbSBCO6G>; Sun, 3 Feb 2002 09:58:06 -0500
Received: from sushi.toad.net ([162.33.130.105]:7628 "EHLO sushi.toad.net")
	by vger.kernel.org with ESMTP id <S287293AbSBCO54>;
	Sun, 3 Feb 2002 09:57:56 -0500
Subject: Re: [PATCH] Documentation for proc_file_read
From: Thomas Hood <jdthood@mail.com>
To: linux-kernel@vger.kernel.org
Cc: Andreas Schwab <schwab@suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.1 
Date: 03 Feb 2002 09:58:05 -0500
Message-Id: <1012748288.809.22.camel@thanatos>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

After further study I have revised the documentation
to fix some mistakes.

This patch also fixes some problems in the code. First,
the patch adds checks for buffer overruns.  (The
original code allows the user to return any number
as the number of bytes to copy to the user, even if
this would exceed procfs's and/or the user's buffer.)
Second, with *start==NULL, n is trimmed down to "count"
_prior_ to subtracting the offset.  (The original code
trims n down to count after subtracting the offset;
but this means that it could be copying up to count
many bytes near the very end of the buffer.)

Still just asking for criticism.

--
Thomas

--- linux-2.4.18-pre7_ORIG/fs/proc/generic.c	Fri Sep  7 13:53:59 2001
+++ linux-2.4.18-pre7/fs/proc/generic.c	Sun Feb  3 08:51:32 2002
@@ -65,55 +65,101 @@
 	{
 		count = MIN(PROC_BLOCK_SIZE, nbytes);
 
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
+			 * Prototype:
+			 *    int f(char *buffer, char **start, off_t offset,
+			 *          int count, int *peof, void *dat)
+			 *
+			 * Assume that the buffer is "count" bytes in size.
+			 *
+			 * If you know you have supplied all the data you
+			 * have, set *peof.
+			 *
+			 * You have three ways to return data:
+			 * 0) Leave *start = NULL.  (This is the default.)
+			 *    Put the data of the requested offset at that
+			 *    offset within the buffer.  Return the number (n)
+			 *    of bytes there are from the beginning of the
+			 *    buffer up to the last byte of data.  If the
+			 *    number of supplied bytes (= n - offset) is 
+			 *    greater than zero (and you didn't signal eof)
+			 *    you will be called again with the requested
+			 *    offset advanced by the number of bytes 
+			 *    absorbed.  This interface is useful for files
+			 *    no larger than the buffer.
+			 * 1) Set *start = a small value (less than buffer
+			 *    but greater than zero).
+			 *    Put the data of the requested offset at the
+			 *    beginning of the buffer.  Return the number of
+			 *    bytes of data placed there.  If this number is
+			 *    greater than zero (and you didn't signal eof),
+			 *    you will be called again with the requested
+			 *    offset advanced by *start.  This interface is
+			 *    useful when you have a large file consisting
+			 *    of a series of blocks which you want to count
+			 *    and return as wholes.
+			 *    (hack by Paul.Russell@rustcorp.com.au)
+			 * 2) Set *start = an address within the buffer.
+			 *    Put the data of the requested offset at *start.
+			 *    Return the number (n) of bytes of data placed
+			 *    there.  If this number is greater than zero
+			 *    (and you didn't signal eof) you will be called
+			 *    again with the requested offset advanced by
+			 *    the number of bytes absorbed.
+			 */
 			n = dp->read_proc(page, &start, *ppos,
 					  count, &eof, dp->data);
 		} else
 			break;
 
-		if (!start) {
-			/*
-			 * For proc files that are less than 4k
-			 */
+		if (n == 0)   /* end of file */
+			break;
+		if (n < 0) {  /* error */
+			if (retval == 0)
+				retval = n;
+			break;
+		}
+
+		if (start == NULL) {
 			start = page + *ppos;
+			if (n > PAGE_SIZE)
+				printk(KERN_ERR "proc_file_read: Buffer overflow!\n");
+			if (n > count)
+				n = count;
 			n -= *ppos;
 			if (n <= 0)
 				break;
+		} else if (start < page) {
+			if (n > PAGE_SIZE)
+				printk(KERN_ERR "proc_file_read: Buffer overflow!\n");
+			if (n > count)
+				printk(KERN_WARNING "proc_file_read: Read count exceeded\n");
+		} else /* start >= page */ {
+			if ((start - page + n) > PAGE_SIZE)
+				printk(KERN_ERR "proc_file_read: Buffer overflow!\n");
 			if (n > count)
 				n = count;
 		}
-		if (n == 0)
-			break;	/* End of file */
-		if (n < 0) {
-			if (retval == 0)
-				retval = n;
-			break;
-		}
 		
-		/* This is a hack to allow mangling of file pos independent
- 		 * of actual bytes read.  Simply place the data at page,
- 		 * return the bytes, and set `start' to the desired offset
- 		 * as an unsigned int. - Paul.Russell@rustcorp.com.au
-		 */
  		n -= copy_to_user(buf, start < page ? page : start, n);
 		if (n == 0) {
 			if (retval == 0)
 				retval = -EFAULT;
 			break;
 		}
 
-		*ppos += start < page ? (long)start : n; /* Move down the file */
+		*ppos += start < page ? (unsigned long)start : n;
 		nbytes -= n;
 		buf += n;
 		retval += n;
 	}
 	free_page((unsigned long) page);



