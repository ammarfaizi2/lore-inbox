Return-Path: <linux-kernel-owner+willy=40w.ods.org-S271159AbUJVBjJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271159AbUJVBjJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 21:39:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271160AbUJVBhl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 21:37:41 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:44230 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S271161AbUJVBdq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 21:33:46 -0400
Message-ID: <41786344.9070504@engr.sgi.com>
Date: Thu, 21 Oct 2004 18:32:52 -0700
From: Jay Lan <jlan@engr.sgi.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: lse-tech <lse-tech@lists.sourceforge.net>
CC: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Guillaume Thouvenin <guillaume.thouvenin@bull.net>
Subject: [Lse-tech] [PATCH 2.6.9 1/2] enhanced accounting data collection
References: <41785FE3.806@engr.sgi.com>
In-Reply-To: <41785FE3.806@engr.sgi.com>
Content-Type: multipart/mixed;
 boundary="------------030504020306080704010903"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030504020306080704010903
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

1/2: acct_io

Enahanced I/O accounting data collection.

Signed-off-by: Jay Lan <jlan@sgi.com>


--------------030504020306080704010903
Content-Type: text/plain;
 name="acct_io"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="acct_io"

Index: linux/fs/read_write.c
===================================================================
--- linux.orig/fs/read_write.c	2004-09-29 20:05:18.000000000 -0700
+++ linux/fs/read_write.c	2004-10-01 17:09:42.711763439 -0700
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
--- linux.orig/include/linux/sched.h	2004-10-01 17:01:21.412848229 -0700
+++ linux/include/linux/sched.h	2004-10-01 17:09:42.723482260 -0700
@@ -591,6 +591,9 @@
 	struct rw_semaphore pagg_sem;
 #endif
 
+/* i/o counters(bytes read/written, #syscalls */
+	unsigned long rchar, wchar, syscr, syscw;
+
 };
 
 static inline pid_t process_group(struct task_struct *tsk)
Index: linux/kernel/fork.c
===================================================================
--- linux.orig/kernel/fork.c	2004-10-01 17:01:21.432379595 -0700
+++ linux/kernel/fork.c	2004-10-01 17:09:42.732271376 -0700
@@ -995,6 +995,7 @@
 	p->real_timer.data = (unsigned long) p;
 
 	p->utime = p->stime = 0;
+	p->rchar = p->wchar = p->syscr = p->syscw = 0;
 	p->lock_depth = -1;		/* -1 = no lock */
 	p->start_time = get_jiffies_64();
 	p->security = NULL;

--------------030504020306080704010903--

