Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291054AbSBGBid>; Wed, 6 Feb 2002 20:38:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291059AbSBGBiY>; Wed, 6 Feb 2002 20:38:24 -0500
Received: from hermes.toad.net ([162.33.130.251]:21211 "EHLO hermes.toad.net")
	by vger.kernel.org with ESMTP id <S291054AbSBGBiH>;
	Wed, 6 Feb 2002 20:38:07 -0500
Subject: Re: [PATCH] Documentation for proc_file_read
From: Thomas Hood <jdthood@mail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2 
Date: 06 Feb 2002 20:38:19 -0500
Message-Id: <1013045901.3986.518.camel@thanatos>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here's the final version of the patch to add documentary
comments and buffer overflow checking to the proc_file_read()
function.

--- linux-2.4.18-pre8_ORIG/fs/proc/generic.c	Fri Sep  7 13:53:59 2001
+++ linux-2.4.18-pre8/fs/proc/generic.c	Wed Feb  6 09:26:25 2002
@@ -65,55 +65,120 @@
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
+			 *    greater than zero and you didn't signal eof
+			 *    and the reader is prepared to take more data
+			 *    you will be called again with the requested
+			 *    offset advanced by the number of bytes 
+			 *    absorbed.  This interface is useful for files
+			 *    no larger than the buffer.
+			 * 1) Set *start = an unsigned long value less than
+			 *    the buffer address but greater than zero.
+			 *    Put the data of the requested offset at the
+			 *    beginning of the buffer.  Return the number of
+			 *    bytes of data placed there.  If this number is
+			 *    greater than zero and you didn't signal eof
+			 *    and the reader is prepared to take more data
+			 *    you will be called again with the requested
+			 *    offset advanced by *start.  This interface is
+			 *    useful when you have a large file consisting
+			 *    of a series of blocks which you want to count
+			 *    and return as wholes.
+			 *    (Hack by Paul.Russell@rustcorp.com.au)
+			 * 2) Set *start = an address within the buffer.
+			 *    Put the data of the requested offset at *start.
+			 *    Return the number of bytes of data placed there.
+			 *    If this number is greater than zero and you
+			 *    didn't signal eof and the reader is prepared to
+			 *    take more data you will be called again with the
+			 *    requested offset advanced by the number of bytes
+			 *    absorbed.
+			 */
 			n = dp->read_proc(page, &start, *ppos,
 					  count, &eof, dp->data);
 		} else
 			break;
 
-		if (!start) {
-			/*
-			 * For proc files that are less than 4k
-			 */
-			start = page + *ppos;
+		if (n == 0)   /* end of file */
+			break;
+		if (n < 0) {  /* error */
+			if (retval == 0)
+				retval = n;
+			break;
+		}
+
+		if (start == NULL) {
+			if (n > PAGE_SIZE) {
+				printk(KERN_ERR
+				       "proc_file_read: Apparent buffer overflow!\n");
+				n = PAGE_SIZE;
+			}
+			if (n > count)
+				n = count;
 			n -= *ppos;
 			if (n <= 0)
 				break;
+			start = page + *ppos;
+		} else if (start < page) {
+			if (n > PAGE_SIZE) {
+				printk(KERN_ERR
+				       "proc_file_read: Apparent buffer overflow!\n");
+				n = PAGE_SIZE;
+			}
+			if (n > count) {
+				/*
+				 * Don't reduce n because doing so might
+				 * cut off part of a data block.
+				 */
+				printk(KERN_WARNING
+				       "proc_file_read: Read count exceeded\n");
+			}
+		} else /* start >= page */ {
+			unsigned long startoff = (unsigned long)(start - page);
+			if (n > (PAGE_SIZE - startoff)) {
+				printk(KERN_ERR
+				       "proc_file_read: Apparent buffer overflow!\n");
+				n = PAGE_SIZE - startoff;
+			}
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




