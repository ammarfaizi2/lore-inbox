Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267408AbUI0Wpo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267408AbUI0Wpo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Sep 2004 18:45:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267409AbUI0Wpn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Sep 2004 18:45:43 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:25790 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S267408AbUI0Wpa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Sep 2004 18:45:30 -0400
Message-ID: <415897B0.3060008@engr.sgi.com>
Date: Mon, 27 Sep 2004 15:44:00 -0700
From: Jay Lan <jlan@engr.sgi.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
CC: lse-tech <lse-tech@lists.sourceforge.net>, CSA-ML <csa@oss.sgi.com>,
       Andrew Morton <akpm@osdl.org>,
       Guillaume Thouvenin <guillaume.thouvenin@bull.net>,
       Tim Schmielau <tim@physik3.uni-rostock.de>,
       Arthur Corliss <corliss@digitalmages.com>
Subject: Re: [PATCH 2.6.9-rc2 1/2] enhanced I/O accounting data collection
References: <4158956F.3030706@engr.sgi.com>
In-Reply-To: <4158956F.3030706@engr.sgi.com>
Content-Type: multipart/mixed;
 boundary="------------020609000803060702000401"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020609000803060702000401
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

1/2: acct_io

Enhanced I/O accounting data collection.

Signed-off-by: Jay Lan <jlan@sgi.com>


--------------020609000803060702000401
Content-Type: text/plain;
 name="acct_io"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="acct_io"

Index: linux/drivers/block/ll_rw_blk.c
===================================================================
--- linux.orig/drivers/block/ll_rw_blk.c	2004-09-12 22:31:31.000000000 -0700
+++ linux/drivers/block/ll_rw_blk.c	2004-09-27 12:37:04.374234677 -0700
@@ -1741,6 +1741,7 @@
 {
 	DEFINE_WAIT(wait);
 	struct request *rq;
+	unsigned long start_wait = jiffies;
 
 	generic_unplug_device(q);
 	do {
@@ -1769,6 +1770,7 @@
 		finish_wait(&rl->wait[rw], &wait);
 	} while (!rq);
 
+	current->bwtime += (unsigned long) jiffies - start_wait;
 	return rq;
 }
 
Index: linux/fs/read_write.c
===================================================================
--- linux.orig/fs/read_write.c	2004-09-12 22:32:55.000000000 -0700
+++ linux/fs/read_write.c	2004-09-27 12:37:04.381070659 -0700
@@ -216,8 +216,11 @@
 				ret = file->f_op->read(file, buf, count, pos);
 			else
 				ret = do_sync_read(file, buf, count, pos);
-			if (ret > 0)
+			if (ret > 0) {
 				dnotify_parent(file->f_dentry, DN_ACCESS);
+				current->rchar += ret;
+			}
+			current->syscr++;
 		}
 	}
 
@@ -260,8 +263,11 @@
 				ret = file->f_op->write(file, buf, count, pos);
 			else
 				ret = do_sync_write(file, buf, count, pos);
-			if (ret > 0)
+			if (ret > 0) {
 				dnotify_parent(file->f_dentry, DN_MODIFY);
+				current->wchar += ret;
+			}
+			current->syscw++;
 		}
 	}
 
@@ -540,6 +546,10 @@
 		fput_light(file, fput_needed);
 	}
 
+	if (ret > 0) {
+		current->rchar += ret;
+	}
+	current->syscr++;
 	return ret;
 }
 
@@ -558,6 +568,10 @@
 		fput_light(file, fput_needed);
 	}
 
+	if (ret > 0) {
+		current->wchar += ret;
+	}
+	current->syscw++;
 	return ret;
 }
 
@@ -636,6 +650,13 @@
 
 	retval = in_file->f_op->sendfile(in_file, ppos, count, file_send_actor, out_file);
 
+	if (retval > 0) {
+		current->rchar += retval;
+		current->wchar += retval;
+	}
+	current->syscr++;
+	current->syscw++;
+
 	if (*ppos > max)
 		retval = -EOVERFLOW;
 
Index: linux/include/linux/sched.h
===================================================================
--- linux.orig/include/linux/sched.h	2004-09-27 11:57:40.220967100 -0700
+++ linux/include/linux/sched.h	2004-09-27 12:52:51.305237393 -0700
@@ -591,6 +591,9 @@
 	struct rw_semaphore pagg_sem;
 #endif
 
+/* i/o counters(bytes read/written, #syscalls, waittime */
+	unsigned long rchar, wchar, syscr, syscw, bwtime;
+
 };
 
 static inline pid_t process_group(struct task_struct *tsk)

--------------020609000803060702000401--

