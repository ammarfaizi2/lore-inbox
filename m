Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751439AbWFIILv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751439AbWFIILv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 04:11:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751438AbWFIIL1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 04:11:27 -0400
Received: from smtp.ustc.edu.cn ([202.38.64.16]:35482 "HELO ustc.edu.cn")
	by vger.kernel.org with SMTP id S1751439AbWFIILX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 04:11:23 -0400
Message-ID: <349840680.03819@ustc.edu.cn>
X-EYOUMAIL-SMTPAUTH: wfg@mail.ustc.edu.cn
Message-Id: <20060609081120.531013274@localhost.localdomain>
References: <20060609080801.741901069@localhost.localdomain>
Date: Fri, 09 Jun 2006 16:08:05 +0800
From: Wu Fengguang <wfg@mail.ustc.edu.cn>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Michael Tokarev <mjt@tls.msk.ru>,
       Jens Axboe <axboe@suse.de>
Subject: [PATCH 4/5] readahead: backoff on I/O error
Content-Disposition: inline; filename=readahead-eio-case.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Backoff readahead size exponentially on I/O error.

------
Michael Tokarev <mjt@tls.msk.ru> described the problem as:

[QUOTE]
Suppose there's a CD-rom with a scratch/etc, one sector is unreadable.
In order to "fix" it, one have to read it and write to another CD-rom,
or something.. or just ignore the error (if it's just a skip in a video
stream).  Let's assume the unreadable block is number U.

But current behavior is just insane.  An application requests block
number N, which is before U. Kernel tries to read-ahead blocks N..U.
Cdrom drive tries to read it, re-read it.. for some time.  Finally,
when all the N..U-1 blocks are read, kernel returns block number N
(as requested) to an application, successefully.

Now an app requests block number N+1, and kernel tries to read
blocks N+1..U+1.  Retrying again as in previous step.

And so on, up to when an app requests block number U-1.  And when,
finally, it requests block U, it receives read error.

So, kernel currentry tries to re-read the same failing block as
many times as the current readahead value (256 (times?) by default).

This whole process already killed my cdrom drive (I posted about it
to LKML several months ago) - literally, the drive has fried, and
does not work anymore.  Ofcourse that problem was a bug in firmware
(or whatever) of the drive *too*, but.. main problem with that is
current readahead logic as described above.
[/QUOTE]

Which was confirmed by Jens Axboe <axboe@suse.de>:

[QUOTE]
For ide-cd, it tends do only end the first part of the request on a
medium error. So you may see a lot of repeats :/
[/QUOTE]

With this patch, retries are expected to be reduced from, say, 256, to 5.

Signed-off-by: Wu Fengguang <wfg@mail.ustc.edu.cn>
---


--- linux-2.6.17-rc4-mm3.orig/mm/filemap.c
+++ linux-2.6.17-rc4-mm3/mm/filemap.c
@@ -809,6 +809,33 @@ grab_cache_page_nowait(struct address_sp
 EXPORT_SYMBOL(grab_cache_page_nowait);
 
 /*
+ * CD/DVDs are error prone. When a medium error occurs, the driver may fail
+ * a _large_ part of the i/o request. Imagine the worst scenario:
+ *
+ *      ---R__________________________________________B__________
+ *         ^ reading here                             ^ bad block(assume 4k)
+ *
+ * read(R) => miss => readahead(R...B) => media error => frustrating retries
+ * => failing the whole request => read(R) => read(R+1) =>
+ * readahead(R+1...B+1) => bang => read(R+2) => read(R+3) =>
+ * readahead(R+3...B+2) => bang => read(R+3) => read(R+4) =>
+ * readahead(R+4...B+3) => bang => read(R+4) => read(R+5) => ......
+ *
+ * It is going insane. Fix it by quickly scaling down the readahead size.
+ */
+static void shrink_readahead_size_eio(struct file *filp,
+					struct file_ra_state *ra)
+{
+	if (!ra->ra_pages)
+		return;
+
+	ra->ra_pages /= 4;
+	printk(KERN_WARNING "Retracting readahead size of %s to %luK\n",
+			filp->f_dentry->d_iname,
+			ra->ra_pages << (PAGE_CACHE_SHIFT - 10));
+}
+
+/*
  * This is a generic file read routine, and uses the
  * mapping->a_ops->readpage() function for the actual low-level
  * stuff.
@@ -983,6 +1010,7 @@ readpage:
 				}
 				unlock_page(page);
 				error = -EIO;
+				shrink_readahead_size_eio(filp, &ra);
 				goto readpage_error;
 			}
 			unlock_page(page);
@@ -1535,6 +1563,7 @@ page_not_uptodate:
 	 * Things didn't work out. Return zero to tell the
 	 * mm layer so, possibly freeing the page cache page first.
 	 */
+	shrink_readahead_size_eio(file, ra);
 	page_cache_release(page);
 	return NULL;
 }

--
