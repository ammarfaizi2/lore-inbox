Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264246AbUIITja@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264246AbUIITja (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 15:39:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263100AbUIITiM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 15:38:12 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:43718 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S266756AbUIITJ4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 15:09:56 -0400
Message-ID: <4140A9D2.3010602@engr.sgi.com>
Date: Thu, 09 Sep 2004 12:06:58 -0700
From: Jay Lan <jlan@engr.sgi.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
CC: Andrew Morton <akpm@osdl.org>, lse-tech <lse-tech@lists.sourceforge.net>,
       Guillaume Thouvenin <guillaume.thouvenin@bull.net>,
       CSA-ML <csa@oss.sgi.com>, Arthur Corliss <corliss@digitalmages.com>,
       Tim Schmielau <tim@physik3.uni-rostock.de>,
       Erik Jacobson <erikj@dbear.engr.sgi.com>, Limin Gu <limin@engr.sgi.com>,
       John Hesterberg <jh@sgi.com>
Subject: [PATCH 2.6.8.1 1/4] CSA  csa_io: accounting IO data gathering
Content-Type: multipart/mixed;
 boundary="------------030802040406070309060909"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030802040406070309060909
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Linux Comprehensive System Accounting (CSA) is a set of C programs and
shell scripts that, like other accounting packages, provide methods for
collecting per-process resource usage data, monitoring disk usage, and
charging fees to specific login accounts.

The CSA patchset includes csa_io, csa_mm, csa_eop and csa_module.
Patches csa_io, csa_mm, and csa_eop are responsible for system
accounting data collection and are independent of each other.

The csa_io is a patch that gathers I/O activity data.

Please find CSA project at http://oss.sgi.com/projects/csa. This set of
csa patches has been tested with the pagg and job kernel patches.
The information of pagg and job project can be found at
http://oss.sgi.com/projects/pagg/


Signed-off-by: Jay Lan <jlan@sgi.com>

--------------030802040406070309060909
Content-Type: text/plain;
 name="linux-2.6.8.1.csa_io.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="linux-2.6.8.1.csa_io.patch"

Index: linux/drivers/block/ll_rw_blk.c
===================================================================
--- linux.orig/drivers/block/ll_rw_blk.c	2004-08-13 22:36:16.000000000 -0700
+++ linux/drivers/block/ll_rw_blk.c	2004-09-03 17:15:06.000000000 -0700
@@ -1674,6 +1674,7 @@
 {
 	DEFINE_WAIT(wait);
 	struct request *rq;
+	unsigned long start_wait = jiffies;
 
 	generic_unplug_device(q);
 	do {
@@ -1702,6 +1703,7 @@
 		finish_wait(&rl->wait[rw], &wait);
 	} while (!rq);
 
+	current->bwtime += (unsigned long) jiffies - start_wait;
 	return rq;
 }
 
Index: linux/fs/read_write.c
===================================================================
--- linux.orig/fs/read_write.c	2004-08-13 22:37:15.000000000 -0700
+++ linux/fs/read_write.c	2004-09-03 12:59:18.000000000 -0700
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
 
Index: linux/kernel/fork.c
===================================================================
--- linux.orig/kernel/fork.c	2004-09-03 12:59:18.000000000 -0700
+++ linux/kernel/fork.c	2004-09-03 16:21:20.000000000 -0700
@@ -964,6 +964,8 @@
 
 	p->utime = p->stime = 0;
 	p->cutime = p->cstime = 0;
+	p->rchar = p->wchar = p->syscr = p->syscw = 0;
+	p->bwtime = 0;
 	p->lock_depth = -1;		/* -1 = no lock */
 	p->start_time = get_jiffies_64();
 	p->security = NULL;
Index: linux/include/linux/sched.h
===================================================================
--- linux.orig/include/linux/sched.h	2004-09-03 12:59:18.000000000 -0700
+++ linux/include/linux/sched.h	2004-09-03 16:18:31.000000000 -0700
@@ -523,6 +523,9 @@
 	unsigned long ptrace_message;
 	siginfo_t *last_siginfo; /* For ptrace use.  */
 
+/* i/o counters(bytes read/written, #syscalls, waittime */
+        unsigned long rchar, wchar, syscr, syscw, bwtime;
+
 #ifdef CONFIG_NUMA
   	struct mempolicy *mempolicy;
   	short il_next;		/* could be shared with used_math */

--------------030802040406070309060909--

