Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261181AbUKHTLG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261181AbUKHTLG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Nov 2004 14:11:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261175AbUKHTJK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Nov 2004 14:09:10 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:61826 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S261203AbUKHTHl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Nov 2004 14:07:41 -0500
Message-ID: <418FC3B3.2050103@engr.sgi.com>
Date: Mon, 08 Nov 2004 11:06:27 -0800
From: Jay Lan <jlan@engr.sgi.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: lse-tech <lse-tech@lists.sourceforge.net>
CC: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Guillaume Thouvenin <guillaume.thouvenin@bull.net>,
       Tim Schmielau <tim@physik3.uni-rostock.de>
Subject: [PATCH 2.6.9 1/2] enhanced I/O accounting data patch
References: <418FC082.8090706@engr.sgi.com>
In-Reply-To: <418FC082.8090706@engr.sgi.com>
Content-Type: multipart/mixed;
 boundary="------------060102090001020500030102"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060102090001020500030102
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

1/2: acct_io

Enhanced I/O accounting data collection.

Signed-off-by: Jay Lan <jlan@sgi.com>


--------------060102090001020500030102
Content-Type: text/plain;
 name="acct_io"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="acct_io"

Index: linux/fs/read_write.c
===================================================================
--- linux.orig/fs/read_write.c	2004-10-18 14:54:37.000000000 -0700
+++ linux/fs/read_write.c	2004-11-03 16:38:10.270235494 -0800
@@ -216,8 +216,11 @@ ssize_t vfs_read(struct file *file, char
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
 
@@ -260,8 +263,11 @@ ssize_t vfs_write(struct file *file, con
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
 
@@ -540,6 +546,9 @@ sys_readv(unsigned long fd, const struct
 		fput_light(file, fput_needed);
 	}
 
+	if (ret > 0)
+		current->rchar += ret;
+	current->syscr++;
 	return ret;
 }
 
@@ -558,6 +567,9 @@ sys_writev(unsigned long fd, const struc
 		fput_light(file, fput_needed);
 	}
 
+	if (ret > 0)
+		current->wchar += ret;
+	current->syscw++;
 	return ret;
 }
 
@@ -636,6 +648,13 @@ static ssize_t do_sendfile(int out_fd, i
 
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
--- linux.orig/include/linux/sched.h	2004-10-18 14:53:13.000000000 -0700
+++ linux/include/linux/sched.h	2004-11-03 15:52:01.803397172 -0800
@@ -580,6 +580,8 @@ struct task_struct {
  * to a stack based synchronous wait) if its doing sync IO.
  */
 	wait_queue_t *io_wait;
+/* i/o counters(bytes read/written, #syscalls */
+	u64 rchar, wchar, syscr, syscw;
 #ifdef CONFIG_NUMA
   	struct mempolicy *mempolicy;
   	short il_next;		/* could be shared with used_math */
Index: linux/kernel/fork.c
===================================================================
--- linux.orig/kernel/fork.c	2004-10-18 14:53:13.000000000 -0700
+++ linux/kernel/fork.c	2004-11-03 16:44:23.266042599 -0800
@@ -985,12 +985,21 @@ static task_t *copy_process(unsigned lon
 	clear_tsk_thread_flag(p, TIF_SIGPENDING);
 	init_sigpending(&p->pending);
 
-	p->it_real_value = p->it_virt_value = p->it_prof_value = 0;
-	p->it_real_incr = p->it_virt_incr = p->it_prof_incr = 0;
+	p->it_real_value = 0;
+	p->it_virt_value = 0;
+	p->it_prof_value = 0;
+	p->it_real_incr = 0;
+	p->it_virt_incr = 0;
+	p->it_prof_incr = 0;
 	init_timer(&p->real_timer);
 	p->real_timer.data = (unsigned long) p;
 
-	p->utime = p->stime = 0;
+	p->utime = 0;
+	p->stime = 0;
+	p->rchar = 0;		/* I/O counter: bytes read */
+	p->wchar = 0;		/* I/O counter: bytes written */
+	p->syscr = 0;		/* I/O counter: read syscalls */
+	p->syscw = 0;		/* I/O counter: write syscalls */
 	p->lock_depth = -1;		/* -1 = no lock */
 	do_posix_clock_monotonic_gettime(&p->start_time);
 	p->security = NULL;

--------------060102090001020500030102--

