Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263250AbTETB4m (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 May 2003 21:56:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263449AbTETB4m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 May 2003 21:56:42 -0400
Received: from pat.uio.no ([129.240.130.16]:23282 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S263250AbTETB4l (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 May 2003 21:56:41 -0400
To: Vladimir Serov <vserov@infratel.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Russell King <rmk@arm.linux.org.uk>
Subject: Re: [BUG] nfs client stuck in D state in linux 2.4.17 - 2.4.21-pre5
References: <20030318155731.1f60a55a.skraw@ithnet.com>
	<3E79EAA8.4000907@infratel.com>
	<15993.60520.439204.267818@charged.uio.no>
	<3E7ADBFD.4060202@infratel.com> <shsof45nf58.fsf@charged.uio.no>
	<3E7B0051.8060603@infratel.com>
	<15995.578.341176.325238@charged.uio.no>
	<3E7B10DF.5070005@infratel.com>
	<15995.5996.446164.746224@charged.uio.no>
	<3E7B1DF9.2090401@infratel.com>
	<15995.10797.983569.410234@charged.uio.no>
	<3EC8DA1B.50304@infratel.com>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Date: 20 May 2003 04:09:31 +0200
In-Reply-To: <3EC8DA1B.50304@infratel.com>
Message-ID: <shsel2uqsh0.fsf@charged.uio.no>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Honest Recruiter)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-MailScanner-Information: Please contact postmaster@uio.no for more information
X-UiO-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Did you try the patch I sent you last week? (appended below)

Cheers,
  Trond

--- linux-2.4.21-up/include/linux/sunrpc/sched.h.orig	2003-05-13 17:51:59.000000000 +0200
+++ linux-2.4.21-up/include/linux/sunrpc/sched.h	2003-05-13 23:04:44.000000000 +0200
@@ -128,7 +128,12 @@
 #define RPC_IS_RUNNING(t)	(test_bit(RPC_TASK_RUNNING, &(t)->tk_runstate))
 
 #define rpc_set_running(t)	(set_bit(RPC_TASK_RUNNING, &(t)->tk_runstate))
-#define rpc_clear_running(t)	(clear_bit(RPC_TASK_RUNNING, &(t)->tk_runstate))
+#define rpc_clear_running(t) \
+	do { \
+		smp_mb__before_clear_bit(); \
+		clear_bit(RPC_TASK_RUNNING, &(t)->tk_runstate); \
+		smp_mb__after_clear_bit(); \
+	} while(0)
 
 #define rpc_set_sleeping(t)	(set_bit(RPC_TASK_SLEEPING, &(t)->tk_runstate))
 
--- linux-2.4.21-up/include/linux/sunrpc/xprt.h.orig	2003-05-13 17:51:59.000000000 +0200
+++ linux-2.4.21-up/include/linux/sunrpc/xprt.h	2003-05-13 23:06:41.000000000 +0200
@@ -200,7 +200,12 @@
 #define xprt_connected(xp)		(test_bit(XPRT_CONNECT, &(xp)->sockstate))
 #define xprt_set_connected(xp)		(set_bit(XPRT_CONNECT, &(xp)->sockstate))
 #define xprt_test_and_set_connected(xp)	(test_and_set_bit(XPRT_CONNECT, &(xp)->sockstate))
-#define xprt_clear_connected(xp)	(clear_bit(XPRT_CONNECT, &(xp)->sockstate))
+#define xprt_clear_connected(xp) \
+	do { \
+		smp_mb__before_clear_bit(); \
+		clear_bit(XPRT_CONNECT, &(xp)->sockstate); \
+		smp_mb__after_clear_bit(); \
+	} while(0)
 
 #endif /* __KERNEL__*/
 
