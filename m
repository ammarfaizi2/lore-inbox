Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268068AbTBMPzB>; Thu, 13 Feb 2003 10:55:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268069AbTBMPzB>; Thu, 13 Feb 2003 10:55:01 -0500
Received: from mons.uio.no ([129.240.130.14]:57542 "EHLO mons.uio.no")
	by vger.kernel.org with ESMTP id <S268068AbTBMPy7>;
	Thu, 13 Feb 2003 10:54:59 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15947.49657.69111.510604@charged.uio.no>
Date: Thu, 13 Feb 2003 17:04:09 +0100
To: Dave Jones <davej@codemonkey.org.uk>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.60 NFS FSX
In-Reply-To: <20030213155112.GA2070@codemonkey.org.uk>
References: <20030213152742.GA1560@codemonkey.org.uk>
	<shs4r78yyjs.fsf@charged.uio.no>
	<20030213155112.GA2070@codemonkey.org.uk>
X-Mailer: VM 7.07 under 21.4 (patch 8) "Honest Recruiter" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Dave Jones <davej@codemonkey.org.uk> writes:

     > Last thing I spotted on a serial terminal was..

     > RPC: garbage, exit EIO

Right: that's what you would expect for corruption.

Was this by the way an SMP setup? If so, could you try the following
patch (based on a previous patch by Olaf Kirch) and that I sent to Linus
earlier today. It fixes an issue that could on occasion lead to some
pretty nasty corruption issues.

I don't think SMP can explain all the corruption issues though, as
I've also been seeing wierdness on my laptop.

Cheers,
  Trond

diff -u --recursive --new-file linux-2.5.60-00-fix_pipes/net/sunrpc/xprt.c linux-2.5.60-01-fix_xid/net/sunrpc/xprt.c
--- linux-2.5.60-00-fix_pipes/net/sunrpc/xprt.c	2003-01-12 22:39:48.000000000 +0100
+++ linux-2.5.60-01-fix_xid/net/sunrpc/xprt.c	2003-02-13 14:17:10.000000000 +0100
@@ -1273,25 +1273,41 @@
 }
 
 /*
+ * Allocate a 'unique' XID
+ */
+static u32
+xprt_alloc_xid(void)
+{
+	static spinlock_t xid_lock = SPIN_LOCK_UNLOCKED;
+	static int need_init = 1;
+	static u32 xid;
+	u32 ret;
+
+	spin_lock(&xid_lock);
+	if (unlikely(need_init)) {
+		xid = get_seconds() << 12;
+		need_init = 0;
+	}
+	ret = xid++;
+	spin_unlock(&xid_lock);
+	return ret;
+}
+
+/*
  * Initialize RPC request
  */
 static void
 xprt_request_init(struct rpc_task *task, struct rpc_xprt *xprt)
 {
 	struct rpc_rqst	*req = task->tk_rqstp;
-	static u32	xid = 0;
-
-	if (!xid)
-		xid = get_seconds() << 12;
 
-	dprintk("RPC: %4d reserved req %p xid %08x\n", task->tk_pid, req, xid);
 	req->rq_timeout = xprt->timeout;
 	req->rq_task	= task;
 	req->rq_xprt    = xprt;
-	req->rq_xid     = xid++;
-	if (!xid)
-		xid++;
+	req->rq_xid     = xprt_alloc_xid();
 	INIT_LIST_HEAD(&req->rq_list);
+	dprintk("RPC: %4d reserved req %p xid %08x\n", task->tk_pid,
+			req, req->rq_xid);
 }
 
 /*
