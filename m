Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292467AbSCDQ2R>; Mon, 4 Mar 2002 11:28:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292466AbSCDQ2I>; Mon, 4 Mar 2002 11:28:08 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:13687 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S292467AbSCDQ1q>; Mon, 4 Mar 2002 11:27:46 -0500
Date: Mon, 4 Mar 2002 11:27:44 -0500
From: Benjamin LaHaise <bcrl@redhat.com>
To: Chris Wedgwood <cw@f00f.org>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [bkpatch] add sys_sendfile64
Message-ID: <20020304112744.B20325@redhat.com>
In-Reply-To: <20020303161818.A18187@redhat.com> <20020304031023.GA14757@tapu.f00f.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020304031023.GA14757@tapu.f00f.org>; from cw@f00f.org on Sun, Mar 03, 2002 at 07:10:23PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Okay, here are the checks for overflow and page faults.  Again, pull from 

	bk://bcrlbits.bkbits.net/linux-2.5

To grab the updates, or apply this on top of the previous patch.

		-ben
--
"A man with a bass just walked in,
 and he's putting it down
 on the floor."

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.467   -> 1.468  
#	        mm/filemap.c	1.64    -> 1.65   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/03/04	bcrl@toomuch.toronto.redhat.com	1.468
# Add LFS style EOVERFLOW checks to sendfile*
# --------------------------------------------
#
diff -Nru a/mm/filemap.c b/mm/filemap.c
--- a/mm/filemap.c	Mon Mar  4 11:25:28 2002
+++ b/mm/filemap.c	Mon Mar  4 11:25:28 2002
@@ -1715,7 +1715,7 @@
 	return written;
 }
 
-static ssize_t common_sendfile(int out_fd, int in_fd, loff_t *offset, size_t count)
+static ssize_t common_sendfile(int out_fd, int in_fd, loff_t *offset, size_t count, loff_t max)
 {
 	ssize_t retval;
 	struct file * in_file, * out_file;
@@ -1760,10 +1760,22 @@
 	retval = 0;
 	if (count) {
 		read_descriptor_t desc;
+		loff_t pos;
 
 		if (!offset)
 			offset = &in_file->f_pos;
 
+		pos = *offset;
+		retval = -EINVAL;
+		if (unlikely(pos < 0))
+			goto fput_out;
+		if (unlikely(pos + count > max)) {
+			retval = -EOVERFLOW;
+			if (pos >= max)
+				goto fput_out;
+			count = max - pos;
+		}
+
 		desc.written = 0;
 		desc.count = count;
 		desc.buf = (char *) out_file;
@@ -1773,6 +1785,9 @@
 		retval = desc.written;
 		if (!retval)
 			retval = desc.error;
+		pos = *offset;
+		if (pos > max)
+			retval = -EOVERFLOW;
 	}
 
 fput_out:
@@ -1794,9 +1809,9 @@
 		pos = off;
 		ppos = &pos;
 	}
-	ret = common_sendfile(out_fd, in_fd, ppos, count);
-	if (offset)
-		put_user((off_t)pos, offset);
+	ret = common_sendfile(out_fd, in_fd, ppos, count, MAX_NON_LFS);
+	if (offset && put_user(pos, offset))
+		ret = -EFAULT;
 	return ret;
 }
 
@@ -1809,9 +1824,9 @@
 			return -EFAULT;
 		ppos = &pos;
 	}
-	ret = common_sendfile(out_fd, in_fd, ppos, count);
-	if (offset)
-		put_user(pos, offset);
+	ret = common_sendfile(out_fd, in_fd, ppos, count, MAX_LFS_FILESIZE);
+	if (offset && put_user(pos, offset))
+		ret = -EFAULT;
 	return ret;
 }
 
