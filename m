Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161116AbWI2Q11@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161116AbWI2Q11 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Sep 2006 12:27:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161135AbWI2Q11
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Sep 2006 12:27:27 -0400
Received: from wr-out-0506.google.com ([64.233.184.239]:46502 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1161116AbWI2Q10 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Sep 2006 12:27:26 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=q9Wg0GG/AUwbRjCFq7d6BSGtq1UTpKlFGmTSLw3QFKWI2XOhfDrKQoTd0a7LUsm+P7ze/C2HHML30mv94vQddqOIVXq06tCk8umkGYhoss+71JY2eQ14u5d10ka8p765XL98Iv1c3nbNmlVakiu27V/C7iEctjb/RRt0WiMi1eA=
Message-ID: <728201270609290927x4b441f92idfaba2f8e3caafa1@mail.gmail.com>
Date: Fri, 29 Sep 2006 11:27:25 -0500
From: "Ram Gupta" <ram.gupta5@gmail.com>
To: "Andrew Morton" <akpm@osdl.org>
Subject: [PATCH]doc: Added explaination for splice system call
Cc: "linux mailing-list" <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds documentation for splice system call. Please apply

Signed-off-by: Ram Gupta<r.gupta@astronautics.com>
-------
diff -uprN -X linux-2.6.18-doc/Documentation/dontdiff
linux-2.6.18/Documentation/splice.txt
linux-2.6.18-doc/Documentation/splice.txt
--- linux-2.6.18/Documentation/splice.txt       1969-12-31
19:00:00.000000000 -0500
+++ linux-2.6.18-doc/Documentation/splice.txt   2006-09-29
10:54:11.000000000 -0500
@@ -0,0 +1,57 @@
+                       Splice system call
+                      ----------------------------
+A splice() is a system call mechanism  to do i/o from one file to another file
+in kernel space without doing copying from/to user space.It is a way of
+improving I/O performance. The splice system call avoids all data copy from
+user space to kernel space & vice versa. It reads from the specified offset
+from the input file & writes to a pipe in the kernel space. There is no copying
+of data to user space.Then it can be called to write the data from the pipe
+to the output file at the specified/current offset.
+
+splice() works by using the pipe buffer mechanism to open a file descriptor
+for a data source and another for a data sink then by using splice() it can
+join the two together. In other words, splice()  work on a kernel buffer that
+the user has control over and  moves data to/from the buffer from/to an
+arbitrary file descriptor. Specifying  offset with pipe is an error as usual.
+If no  offset is specified with an input/output file descriptor then the
+current offset will be assumed to be the offset specified. Currently one of
+the file descriptor must be pipe otherwise it is an error.
+This system call was added in 2.6.17 kernel
+
+########################################
+Overview of reading from a file to pipe
+########################################
+* It does the read ahead if there is more than one page
+
+* It tries to find the nr_pages from the input file mapping (contiguous
+   if possible)
+
+* If we got less number of contiguous pages than needed then find the other
+   pages or allocate new page.
+
+* If the page is not uptodate then we may need to start io on that page. But
+  the page may be under i/o already.
+
+* If needed start io if we are not in non-block mode.
+
+*  Set up the pages in the buffers of the pipe.
+
+################################################
+Overview of writing from pipe to the output file
+#################################################
+
+*  Make sure the page is uptodate
+
+*  Steal the page from the page cache if the flag SPLICE_F_MOVE is
set & add the
+   page to the page cache of the file mapping.
+
+*  Otherwise find the page of the mapping for the offset & make sure that page
+   is  uptodate.
+
+*  Prepare  the page to be written  in the file
+
+*  balance dirty memory state
+
+*  If file or inode is SYNC and we actually wrote some data, sync it.
+
+Ram Gupta<r.gupta@astronautics.com>

Thanks
Ram Gupta
