Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751767AbWGZT6i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751767AbWGZT6i (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jul 2006 15:58:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751770AbWGZT6i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jul 2006 15:58:38 -0400
Received: from tetsuo.zabbo.net ([207.173.201.20]:52373 "EHLO tetsuo.zabbo.net")
	by vger.kernel.org with ESMTP id S1751767AbWGZT6h (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jul 2006 15:58:37 -0400
Date: Wed, 26 Jul 2006 12:58:35 -0700
From: Zach Brown <zach.brown@oracle.com>
To: linux-kernel@vger.kernel.org, linux-aio@kvack.org
Cc: kenneth.w.chen@intel.com, suparna@in.ibm.com, pbadari@gmail.com
Subject: [RFC][PATCH] Don't complete AIO file extension until i_size is updated
Message-ID: <20060726195835.GB13233@tetsuo.zabbo.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Don't complete AIO file extension until i_size is updated

AIO O_DIRECT file extension has a bug where the IO is completed before i_size
is updated.  direct_io_worker() calls aio_complete() after performing the
extension but before we get back up into generic_file_direct_write() which
updates i_size.  Another thread in io_getevents() can catch the completion and
stat() the file before i_size is updated.

Previously the direct write path would always call aio_complete() and return
-EIOCBQUEUED.  This fixes the bug by returning the bytes written in the sync
aio case which lets the aio core call aio_complete() after i_size has been
written.  Now the only time -EIOCBQUEUED is returned and aio_complete() is
called is when bios are still in flight at the time direct_io_worker() returns.

Signed-off-by: Zach Brown <zach.brown@oracle.com> 
---

This fixes the bug reported (with a test case!) in

  http://bugzilla.kernel.org/show_bug.cgi?id=6831

light aio-stress runs work after the change but we all know that fs/direct-io.c
is incredibly fragile.  Can you guys review this?  Has anyone packaged the
tests at http://developer.osdl.org/daniel/AIO/ in a way that can be used to
check for regressions?

 fs/direct-io.c |   15 ++++-----------
 mm/filemap.c   |    2 --
 2 files changed, 4 insertions(+), 13 deletions(-)

Index: 2.6.18-rc1-mm2-odirextend/fs/direct-io.c
===================================================================
--- 2.6.18-rc1-mm2-odirextend.orig/fs/direct-io.c
+++ 2.6.18-rc1-mm2-odirextend/fs/direct-io.c
@@ -1094,8 +1094,6 @@ direct_io_worker(int rw, struct kiocb *i
 			dio->waiter = current;
 			should_wait = 1;
 		}
-		if (ret == 0)
-			ret = dio->result;
 		finished_one_bio(dio);		/* This can free the dio */
 		blk_run_address_space(inode->i_mapping);
 		if (should_wait) {
@@ -1117,7 +1115,10 @@ direct_io_worker(int rw, struct kiocb *i
 			spin_unlock_irqrestore(&dio->bio_lock, flags);
 			set_current_state(TASK_RUNNING);
 			kfree(dio);
-		}
+			if (ret == 0)
+				ret = dio->result;
+		} else
+			ret = -EIOCBQUEUED;
 	} else {
 		ssize_t transferred = 0;
 
@@ -1142,14 +1143,6 @@ direct_io_worker(int rw, struct kiocb *i
 		if (ret == 0)
 			ret = transferred;
 
-		/* We could have also come here on an AIO file extend */
-		if (!is_sync_kiocb(iocb) && (rw & WRITE) &&
-		    ret >= 0 && dio->result == dio->size)
-			/*
-			 * For AIO writes where we have completed the
-			 * i/o, we have to mark the the aio complete.
-			 */
-			aio_complete(iocb, ret, 0);
 		kfree(dio);
 	}
 	return ret;
Index: 2.6.18-rc1-mm2-odirextend/mm/filemap.c
===================================================================
--- 2.6.18-rc1-mm2-odirextend.orig/mm/filemap.c
+++ 2.6.18-rc1-mm2-odirextend/mm/filemap.c
@@ -2129,8 +2129,6 @@ generic_file_direct_write(struct kiocb *
 		if (err < 0)
 			written = err;
 	}
-	if (written == count && !is_sync_kiocb(iocb))
-		written = -EIOCBQUEUED;
 	return written;
 }
 EXPORT_SYMBOL(generic_file_direct_write);
