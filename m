Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1425438AbWLHLye@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1425438AbWLHLye (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Dec 2006 06:54:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1425434AbWLHLy2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 06:54:28 -0500
Received: from smtp.osdl.org ([65.172.181.25]:52469 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1425432AbWLHLyU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 06:54:20 -0500
Message-Id: <200612081152.kB8BqVnS019774@shell0.pdx.osdl.net>
Subject: [patch 09/13] io-accounting: report in procfs
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, balbir@in.ibm.com, csturtiv@sgi.com, daw@sgi.com,
       guillaume.thouvenin@bull.net, jlan@sgi.com, nagar@watson.ibm.com,
       tee@sgi.com
From: akpm@osdl.org
Date: Fri, 08 Dec 2006 03:52:31 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrew Morton <akpm@osdl.org>

Add a simple /proc/pid/io to show the IO accounting fields.

Maybe this shouldn't be merged in mainline - the preferred reporting channel
is taskstats.  But given the poor state of our userspace support for
taskstats, this is useful for developer-testing, at least.  And it improves
the changes that the procps developers will wire it up into top(1).  Opinions
are sought.

The patch also wires up the existing IO-accounting fields.

It's a bit racy on 32-bit machines: if process A reads process B's
/proc/pid/io while process B is updating one of those 64-bit counters, process
A could see an intermediate result.

Cc: Jay Lan <jlan@sgi.com>
Cc: Shailabh Nagar <nagar@watson.ibm.com>
Cc: Balbir Singh <balbir@in.ibm.com>
Cc: Chris Sturtivant <csturtiv@sgi.com>
Cc: Tony Ernst <tee@sgi.com>
Cc: Guillaume Thouvenin <guillaume.thouvenin@bull.net>
Cc: David Wright <daw@sgi.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 fs/proc/base.c |   24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff -puN fs/proc/base.c~io-accounting-report-in-procfs fs/proc/base.c
--- a/fs/proc/base.c~io-accounting-report-in-procfs
+++ a/fs/proc/base.c
@@ -1804,6 +1804,27 @@ static int proc_base_fill_cache(struct f
 				proc_base_instantiate, task, p);
 }
 
+#ifdef CONFIG_TASK_IO_ACCOUNTING
+static int proc_pid_io_accounting(struct task_struct *task, char *buffer)
+{
+	return sprintf(buffer,
+			"rchar: %llu\n"
+			"wchar: %llu\n"
+			"syscr: %llu\n"
+			"syscw: %llu\n"
+			"read_bytes: %llu\n"
+			"write_bytes: %llu\n"
+			"cancelled_write_bytes: %llu\n",
+			(unsigned long long)task->rchar,
+			(unsigned long long)task->wchar,
+			(unsigned long long)task->syscr,
+			(unsigned long long)task->syscw,
+			(unsigned long long)task->ioac.read_bytes,
+			(unsigned long long)task->ioac.write_bytes,
+			(unsigned long long)task->ioac.cancelled_write_bytes);
+}
+#endif
+
 /*
  * Thread groups
  */
@@ -1855,6 +1876,9 @@ static struct pid_entry tgid_base_stuff[
 #ifdef CONFIG_FAULT_INJECTION
 	REG("make-it-fail", S_IRUGO|S_IWUSR, fault_inject),
 #endif
+#ifdef CONFIG_TASK_IO_ACCOUNTING
+	INF("io",	S_IRUGO, pid_io_accounting),
+#endif
 };
 
 static int proc_tgid_base_readdir(struct file * filp,
_
