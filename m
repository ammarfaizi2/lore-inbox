Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310184AbSCAXqp>; Fri, 1 Mar 2002 18:46:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310188AbSCAXqg>; Fri, 1 Mar 2002 18:46:36 -0500
Received: from hermes.toad.net ([162.33.130.251]:53177 "EHLO hermes.toad.net")
	by vger.kernel.org with ESMTP id <S310184AbSCAXqZ>;
	Fri, 1 Mar 2002 18:46:25 -0500
Subject: RE: How to get kernel data using /proc system?
From: Thomas Hood <jdthood@mail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2 
Date: 01 Mar 2002 18:47:13 -0500
Message-Id: <1015026435.2121.198.camel@thanatos>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I wrote the following comment block explaining how 
to write a proc_file_read function.  This is the 
function you register with procfs using 
create_proc_read_entry().  Hope this helps. 
(This patch went into 2.5.x-djy)

[...] 
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

