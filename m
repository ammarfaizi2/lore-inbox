Return-Path: <linux-kernel-owner+w=401wt.eu-S1751147AbXAFCd4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751147AbXAFCd4 (ORCPT <rfc822;w@1wt.eu>);
	Fri, 5 Jan 2007 21:33:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751145AbXAFCdn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Jan 2007 21:33:43 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:36912 "EHLO
	sous-sol.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751136AbXAFCdT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Jan 2007 21:33:19 -0500
Message-Id: <20070106023713.079938000@sous-sol.org>
References: <20070106022753.334962000@sous-sol.org>
User-Agent: quilt/0.45-1
Date: Fri, 05 Jan 2007 18:28:41 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org, torvalds@osdl.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, johnpol@2ka.mipt.ru, tony.luck@intel.com,
       erikj@sgi.com, davem@davemloft.net
Subject: [patch 48/50] connector: some fixes for ia64 unaligned access errors
Content-Disposition: inline; filename=connector-some-fixes-for-ia64-unaligned-access-errors.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

From: Erik Jacobson <erikj@sgi.com>

On ia64, the various functions that make up cn_proc.c cause kernel
unaligned access errors.

If you are using these, for example, to get notification about all tasks
forking and exiting, you get multiple unaligned access errors per process.

Use put_unaligned() in the appropriate palces to fix this.

Signed-off-by: Erik Jacobson <erikj@sgi.com>
Cc: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Cc: Tony Luck <tony.luck@intel.com>
Cc: <stable@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
---

 drivers/connector/cn_proc.c |   11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

--- linux-2.6.19.1.orig/drivers/connector/cn_proc.c
+++ linux-2.6.19.1/drivers/connector/cn_proc.c
@@ -28,6 +28,7 @@
 #include <linux/init.h>
 #include <linux/connector.h>
 #include <asm/atomic.h>
+#include <asm/unaligned.h>
 
 #include <linux/cn_proc.h>
 
@@ -60,7 +61,7 @@ void proc_fork_connector(struct task_str
 	ev = (struct proc_event*)msg->data;
 	get_seq(&msg->seq, &ev->cpu);
 	ktime_get_ts(&ts); /* get high res monotonic timestamp */
-	ev->timestamp_ns = timespec_to_ns(&ts);
+	put_unaligned(timespec_to_ns(&ts), (__u64 *)&ev->timestamp_ns);
 	ev->what = PROC_EVENT_FORK;
 	ev->event_data.fork.parent_pid = task->real_parent->pid;
 	ev->event_data.fork.parent_tgid = task->real_parent->tgid;
@@ -88,7 +89,7 @@ void proc_exec_connector(struct task_str
 	ev = (struct proc_event*)msg->data;
 	get_seq(&msg->seq, &ev->cpu);
 	ktime_get_ts(&ts); /* get high res monotonic timestamp */
-	ev->timestamp_ns = timespec_to_ns(&ts);
+	put_unaligned(timespec_to_ns(&ts), (__u64 *)&ev->timestamp_ns);
 	ev->what = PROC_EVENT_EXEC;
 	ev->event_data.exec.process_pid = task->pid;
 	ev->event_data.exec.process_tgid = task->tgid;
@@ -124,7 +125,7 @@ void proc_id_connector(struct task_struc
 	     	return;
 	get_seq(&msg->seq, &ev->cpu);
 	ktime_get_ts(&ts); /* get high res monotonic timestamp */
-	ev->timestamp_ns = timespec_to_ns(&ts);
+	put_unaligned(timespec_to_ns(&ts), (__u64 *)&ev->timestamp_ns);
 
 	memcpy(&msg->id, &cn_proc_event_id, sizeof(msg->id));
 	msg->ack = 0; /* not used */
@@ -146,7 +147,7 @@ void proc_exit_connector(struct task_str
 	ev = (struct proc_event*)msg->data;
 	get_seq(&msg->seq, &ev->cpu);
 	ktime_get_ts(&ts); /* get high res monotonic timestamp */
-	ev->timestamp_ns = timespec_to_ns(&ts);
+	put_unaligned(timespec_to_ns(&ts), (__u64 *)&ev->timestamp_ns);
 	ev->what = PROC_EVENT_EXIT;
 	ev->event_data.exit.process_pid = task->pid;
 	ev->event_data.exit.process_tgid = task->tgid;
@@ -181,7 +182,7 @@ static void cn_proc_ack(int err, int rcv
 	ev = (struct proc_event*)msg->data;
 	msg->seq = rcvd_seq;
 	ktime_get_ts(&ts); /* get high res monotonic timestamp */
-	ev->timestamp_ns = timespec_to_ns(&ts);
+	put_unaligned(timespec_to_ns(&ts), (__u64 *)&ev->timestamp_ns);
 	ev->cpu = -1;
 	ev->what = PROC_EVENT_NONE;
 	ev->event_data.ack.err = err;

--
