Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266534AbUBDVY1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Feb 2004 16:24:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266576AbUBDVY1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Feb 2004 16:24:27 -0500
Received: from fw.osdl.org ([65.172.181.6]:30399 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266534AbUBDVV2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Feb 2004 16:21:28 -0500
Date: Wed, 4 Feb 2004 13:22:48 -0800
From: Andrew Morton <akpm@osdl.org>
To: "David S. Miller" <davem@redhat.com>
Cc: jfaulkne@ccs.neu.edu, linux-kernel@vger.kernel.org, kraxel@bytesex.org
Subject: Re: major network performance difference between 2.4 and 2.6.2-rc2
Message-Id: <20040204132248.39b19895.akpm@osdl.org>
In-Reply-To: <20040204130839.1023c2f2.davem@redhat.com>
References: <Pine.GSO.4.58.0401302108560.1211@denali.ccs.neu.edu>
	<Pine.GSO.4.58.0402041529160.7454@denali.ccs.neu.edu>
	<20040204125444.3f2b5e79.akpm@osdl.org>
	<20040204130839.1023c2f2.davem@redhat.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David S. Miller" <davem@redhat.com> wrote:
>
> On Wed, 4 Feb 2004 12:54:44 -0800
> Andrew Morton <akpm@osdl.org> wrote:
> 
> > Jim Faulkner <jfaulkne@ccs.neu.edu> wrote:
> > >   PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND
> > >   3 root      35  19     0    0    0 S 45.9  0.0   0:46.98 ksoftirqd/0
> > >   6 root       5 -10     0    0    0 S 43.3  0.0   1:56.63 events/0
> > >   12008 dogshu 15   0  4800 2356 3828 S  5.3  0.2   0:05.98 proftpd
> > >   12 root      15   0     0    0    0 S  0.3  0.0   0:00.41 pdflush
> > >   9778 root    16   0  5888 1724 5516 R  0.3  0.2   0:00.12 sshd
> > > 
> > > the load before that network transfer was 0.01, and the load after the
> > > network transfer was 1.45.
> > 
> > Could be a networking problem, but boy that's a lot of CPU time.
> 
> Andrew maybe something bolixed in the MAX_SOFTIRQ_RESTART stuff
> we put into kernel/softirq.c?  Just a guess...

Might be.  Jim, does a `patch -p1 -R' of the below help things?



diff -Nru a/kernel/softirq.c b/kernel/softirq.c
--- a/kernel/softirq.c	Wed Feb  4 13:20:39 2004
+++ b/kernel/softirq.c	Wed Feb  4 13:20:39 2004
@@ -57,11 +57,22 @@
 		wake_up_process(tsk);
 }
 
+/*
+ * We restart softirq processing MAX_SOFTIRQ_RESTART times,
+ * and we fall back to softirqd after that.
+ *
+ * This number has been established via experimentation.
+ * The two things to balance is latency against fairness -
+ * we want to handle softirqs as soon as possible, but they
+ * should not be able to lock up the box.
+ */
+#define MAX_SOFTIRQ_RESTART 10
+
 asmlinkage void do_softirq(void)
 {
+	int max_restart = MAX_SOFTIRQ_RESTART;
 	__u32 pending;
 	unsigned long flags;
-	__u32 mask;
 
 	if (in_interrupt())
 		return;
@@ -73,7 +84,6 @@
 	if (pending) {
 		struct softirq_action *h;
 
-		mask = ~pending;
 		local_bh_disable();
 restart:
 		/* Reset the pending bitmask before enabling irqs */
@@ -93,10 +103,8 @@
 		local_irq_disable();
 
 		pending = local_softirq_pending();
-		if (pending & mask) {
-			mask &= ~pending;
+		if (pending && --max_restart)
 			goto restart;
-		}
 		if (pending)
 			wakeup_softirqd();
 		__local_bh_enable();

