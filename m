Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262468AbUEKItF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262468AbUEKItF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 04:49:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262606AbUEKItE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 04:49:04 -0400
Received: from fw.osdl.org ([65.172.181.6]:20354 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262468AbUEKIsk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 04:48:40 -0400
Date: Tue, 11 May 2004 01:48:33 -0700
From: Chris Wright <chrisw@osdl.org>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, torvalds@osdl.org, marcelo.tosatti@cyclades.com
Subject: [PATCH 3/11] pass task_struct in send_signal()
Message-ID: <20040511014833.B21045@build.pdx.osdl.net>
References: <20040511014232.Y21045@build.pdx.osdl.net> <20040511014524.Z21045@build.pdx.osdl.net> <20040511014639.A21045@build.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20040511014639.A21045@build.pdx.osdl.net>; from chrisw@osdl.org on Tue, May 11, 2004 at 01:46:39AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Update send_signal() api to allow passing the task receiving the signal.
This is necessary to ensure signals generated out of process context can
be charged to the correct user.

===== kernel/signal.c 1.115 vs edited =====
--- 1.115/kernel/signal.c	Mon May 10 03:04:00 2004
+++ edited/kernel/signal.c	Mon May 10 16:16:13 2004
@@ -698,7 +698,8 @@
 	}
 }
 
-static int send_signal(int sig, struct siginfo *info, struct sigpending *signals)
+static int send_signal(int sig, struct siginfo *info, struct task_struct *t,
+			struct sigpending *signals)
 {
 	struct sigqueue * q = NULL;
 	int ret = 0;
@@ -797,7 +798,7 @@
 	if (LEGACY_QUEUE(&t->pending, sig))
 		goto out;
 
-	ret = send_signal(sig, info, &t->pending);
+	ret = send_signal(sig, info, t, &t->pending);
 	if (!ret && !sigismember(&t->blocked, sig))
 		signal_wake_up(t, sig == SIGKILL);
 out:
@@ -998,7 +999,7 @@
 	 * We always use the shared queue for process-wide signals,
 	 * to avoid several races.
 	 */
-	ret = send_signal(sig, info, &p->signal->shared_pending);
+	ret = send_signal(sig, info, p, &p->signal->shared_pending);
 	if (unlikely(ret))
 		return ret;
 

