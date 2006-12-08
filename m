Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1425441AbWLHLxu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1425441AbWLHLxu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Dec 2006 06:53:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1425426AbWLHLxU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 06:53:20 -0500
Received: from smtp.osdl.org ([65.172.181.25]:52367 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1425425AbWLHLwr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 06:52:47 -0500
Message-Id: <200612081152.kB8BqXLA019780@shell0.pdx.osdl.net>
Subject: [patch 11/13] io-accounting: via taskstats
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, balbir@in.ibm.com, csturtiv@sgi.com, daw@sgi.com,
       guillaume.thouvenin@bull.net, jlan@sgi.com, nagar@watson.ibm.com,
       tee@sgi.com
From: akpm@osdl.org
Date: Fri, 08 Dec 2006 03:52:33 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrew Morton <akpm@osdl.org>

Deliver IO accounting via taskstats.

Cc: Jay Lan <jlan@sgi.com>
Cc: Shailabh Nagar <nagar@watson.ibm.com>
Cc: Balbir Singh <balbir@in.ibm.com>
Cc: Chris Sturtivant <csturtiv@sgi.com>
Cc: Tony Ernst <tee@sgi.com>
Cc: Guillaume Thouvenin <guillaume.thouvenin@bull.net>
Cc: David Wright <daw@sgi.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 include/linux/taskstats.h |    8 +++++++-
 kernel/tsacct.c           |    9 +++++++++
 2 files changed, 16 insertions(+), 1 deletion(-)

diff -puN include/linux/taskstats.h~io-accounting-via-taskstats include/linux/taskstats.h
--- a/include/linux/taskstats.h~io-accounting-via-taskstats
+++ a/include/linux/taskstats.h
@@ -31,7 +31,7 @@
  */
 
 
-#define TASKSTATS_VERSION	2
+#define TASKSTATS_VERSION	3
 #define TS_COMM_LEN		32	/* should be >= TASK_COMM_LEN
 					 * in linux/sched.h */
 
@@ -140,6 +140,12 @@ struct taskstats {
 	__u64	read_syscalls;		/* read syscalls */
 	__u64	write_syscalls;		/* write syscalls */
 	/* Extended accounting fields end */
+
+#define TASKSTATS_HAS_IO_ACCOUNTING
+	/* Per-task storage I/O accounting starts */
+	__u64	read_bytes;		/* bytes of read I/O */
+	__u64	write_bytes;		/* bytes of write I/O */
+	__u64	cancelled_write_bytes;	/* bytes of cancelled write I/O */
 };
 
 
diff -puN kernel/tsacct.c~io-accounting-via-taskstats kernel/tsacct.c
--- a/kernel/tsacct.c~io-accounting-via-taskstats
+++ a/kernel/tsacct.c
@@ -96,6 +96,15 @@ void xacct_add_tsk(struct taskstats *sta
 	stats->write_char	= p->wchar;
 	stats->read_syscalls	= p->syscr;
 	stats->write_syscalls	= p->syscw;
+#ifdef CONFIG_TASK_IO_ACCOUNTING
+	stats->read_bytes	= p->ioac.read_bytes;
+	stats->write_bytes	= p->ioac.write_bytes;
+	stats->cancelled_write_bytes = p->ioac.cancelled_write_bytes;
+#else
+	stats->read_bytes	= 0;
+	stats->write_bytes	= 0;
+	stats->cancelled_write_bytes = 0;
+#endif
 }
 #undef KB
 #undef MB
_
