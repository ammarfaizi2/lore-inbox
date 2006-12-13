Return-Path: <linux-kernel-owner+w=401wt.eu-S964949AbWLMGS1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964949AbWLMGS1 (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 01:18:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964945AbWLMGS1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 01:18:27 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:49203 "EHLO omx1.sgi.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S964950AbWLMGS0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 01:18:26 -0500
X-Greylist: delayed 571 seconds by postgrey-1.27 at vger.kernel.org; Wed, 13 Dec 2006 01:18:24 EST
Date: Wed, 13 Dec 2006 00:08:29 -0600
From: Erik Jacobson <erikj@sgi.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Erik Jacobson <erikj@sgi.com>, linux-kernel@vger.kernel.org,
       guillaume.thouvenin@bull.net, matthltc@us.ibm.com
Subject: Re: [PATCH] connector: Some fixes for ia64 unaligned access errors
Message-ID: <20061213060829.GA1409@sgi.com>
References: <20061207232213.GA29340@sgi.com> <1165881166.24721.71.camel@localhost.localdomain> <20061212175411.GA20407@sgi.com> <20061212164504.d6f8a3cb.akpm@osdl.org> <20061213023132.GA29897@sgi.com> <20061212183826.6edb3a3f.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061212183826.6edb3a3f.akpm@osdl.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.  I didn't want to leave this hanging and it stayed in my head so I
thought I'd better just finish it and test it.

I tried out this patch and it got rid of all three unaligned acces errors
I was seeing with process connectors and the patch is indeed much smaller.

I ran our container daemon program in debug mode to be sure the forks
and exits still worked right when the patch was applied and all seemed
well.

I applied this patch to x86_64 as well as a sanity check and it seems
working fine.

Things look good to me.  I'm ok if you prefer this patch, or the one
already in -mm.

Signed-off-by: Erik Jacobson <erikj@sgi.com>
---

 cn_proc.c |   11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)
--- linux.orig/drivers/connector/cn_proc.c	2006-12-12 23:03:31.000000000 -0600
+++ linux/drivers/connector/cn_proc.c	2006-12-12 23:06:34.243535000 -0600
@@ -28,6 +28,7 @@
 #include <linux/init.h>
 #include <linux/connector.h>
 #include <asm/atomic.h>
+#include <asm/unaligned.h>
 
 #include <linux/cn_proc.h>
 
@@ -60,7 +61,7 @@
 	ev = (struct proc_event*)msg->data;
 	get_seq(&msg->seq, &ev->cpu);
 	ktime_get_ts(&ts); /* get high res monotonic timestamp */
-	ev->timestamp_ns = timespec_to_ns(&ts);
+	put_unaligned(timespec_to_ns(&ts), (__u64 *) &ev->timestamp_ns);
 	ev->what = PROC_EVENT_FORK;
 	ev->event_data.fork.parent_pid = task->real_parent->pid;
 	ev->event_data.fork.parent_tgid = task->real_parent->tgid;
@@ -88,7 +89,7 @@
 	ev = (struct proc_event*)msg->data;
 	get_seq(&msg->seq, &ev->cpu);
 	ktime_get_ts(&ts); /* get high res monotonic timestamp */
-	ev->timestamp_ns = timespec_to_ns(&ts);
+	put_unaligned(timespec_to_ns(&ts), (__u64 *) &ev->timestamp_ns);
 	ev->what = PROC_EVENT_EXEC;
 	ev->event_data.exec.process_pid = task->pid;
 	ev->event_data.exec.process_tgid = task->tgid;
@@ -124,7 +125,7 @@
 	     	return;
 	get_seq(&msg->seq, &ev->cpu);
 	ktime_get_ts(&ts); /* get high res monotonic timestamp */
-	ev->timestamp_ns = timespec_to_ns(&ts);
+	put_unaligned(timespec_to_ns(&ts), (__u64 *) &ev->timestamp_ns);
 
 	memcpy(&msg->id, &cn_proc_event_id, sizeof(msg->id));
 	msg->ack = 0; /* not used */
@@ -146,7 +147,7 @@
 	ev = (struct proc_event*)msg->data;
 	get_seq(&msg->seq, &ev->cpu);
 	ktime_get_ts(&ts); /* get high res monotonic timestamp */
-	ev->timestamp_ns = timespec_to_ns(&ts);
+	put_unaligned(timespec_to_ns(&ts), (__u64 *) &ev->timestamp_ns);
 	ev->what = PROC_EVENT_EXIT;
 	ev->event_data.exit.process_pid = task->pid;
 	ev->event_data.exit.process_tgid = task->tgid;
@@ -181,7 +182,7 @@
 	ev = (struct proc_event*)msg->data;
 	msg->seq = rcvd_seq;
 	ktime_get_ts(&ts); /* get high res monotonic timestamp */
-	ev->timestamp_ns = timespec_to_ns(&ts);
+	put_unaligned(timespec_to_ns(&ts), (__u64 *) &ev->timestamp_ns);
 	ev->cpu = -1;
 	ev->what = PROC_EVENT_NONE;
 	ev->event_data.ack.err = err;
