Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317910AbSGPR4L>; Tue, 16 Jul 2002 13:56:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317911AbSGPR4J>; Tue, 16 Jul 2002 13:56:09 -0400
Received: from mons.uio.no ([129.240.130.14]:47849 "EHLO mons.uio.no")
	by vger.kernel.org with ESMTP id <S317910AbSGPRzw>;
	Tue, 16 Jul 2002 13:55:52 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15668.24273.81662.915763@charged.uio.no>
Date: Tue, 16 Jul 2002 19:58:41 +0200
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       NFS maillist <nfs@lists.sourceforge.net>
Subject: [PATCH] RPC over UDP congestion control updates [1/8]
X-Mailer: VM 7.00 under 21.4 (patch 6) "Common Lisp" XEmacs Lucid
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Implement the basic round trip timing algorithm in order to adapt the
timeout values for the most common NFS operations to the server's
rate of response.
Algorithm is described in Van Jacobson's paper 1998 paper
on http://www-nrg.ee.lbl.gov/nrg-papers.html, and is the same as is
used for most TCP stacks.

Following the *BSD code, we implement separate rtt timers for GETATTR,
LOOKUP, READ/READDIR/READLINK, and WRITE. In addition to this, there
is one extra timer for the COMMIT operation.
All the remaining RPC calls use the current system in which a fixed
timeout value gets set by the 'timeo' mount option.

In case of a timeout, the current exponential backoff algoritm is
implemented. Subsequent patches will improve this...

Cheers,
  Trond

diff -u --recursive --new-file linux-2.5.25/fs/lockd/xdr.c linux-2.5.25-rtt1/fs/lockd/xdr.c
--- linux-2.5.25/fs/lockd/xdr.c	Mon Feb 25 19:35:33 2002
+++ linux-2.5.25-rtt1/fs/lockd/xdr.c	Tue Jul 16 11:43:08 2002
@@ -561,11 +561,10 @@
 #define nlmclt_decode_norep	NULL
 
 #define PROC(proc, argtype, restype)	\
-    { "nlm_" #proc,						\
-      (kxdrproc_t) nlmclt_encode_##argtype,			\
-      (kxdrproc_t) nlmclt_decode_##restype,			\
-      MAX(NLM_##argtype##_sz, NLM_##restype##_sz) << 2,		\
-      0								\
+    { .p_procname  = "nlm_" #proc,					\
+      .p_encode    = (kxdrproc_t) nlmclt_encode_##argtype,		\
+      .p_decode    = (kxdrproc_t) nlmclt_decode_##restype,		\
+      .p_bufsiz    = MAX(NLM_##argtype##_sz, NLM_##restype##_sz) << 2	\
     }
 
 static struct rpc_procinfo	nlm_procedures[] = {
diff -u --recursive --new-file linux-2.5.25/fs/lockd/xdr4.c linux-2.5.25-rtt1/fs/lockd/xdr4.c
--- linux-2.5.25/fs/lockd/xdr4.c	Mon Feb 25 19:35:33 2002
+++ linux-2.5.25-rtt1/fs/lockd/xdr4.c	Tue Jul 16 11:43:08 2002
@@ -566,12 +566,11 @@
  */
 #define nlm4clt_decode_norep	NULL
 
-#define PROC(proc, argtype, restype)				\
-    { "nlm4_" #proc,						\
-      (kxdrproc_t) nlm4clt_encode_##argtype,			\
-      (kxdrproc_t) nlm4clt_decode_##restype,			\
-      MAX(NLM4_##argtype##_sz, NLM4_##restype##_sz) << 2,	\
-      0								\
+#define PROC(proc, argtype, restype)					\
+    { .p_procname  = "nlm4_" #proc,					\
+      .p_encode    = (kxdrproc_t) nlm4clt_encode_##argtype,		\
+      .p_decode    = (kxdrproc_t) nlm4clt_decode_##restype,		\
+      .p_bufsiz    = MAX(NLM4_##argtype##_sz, NLM4_##restype##_sz) << 2	\
     }
 
 static struct rpc_procinfo	nlm4_procedures[] = {
diff -u --recursive --new-file linux-2.5.25/fs/nfs/nfs2xdr.c linux-2.5.25-rtt1/fs/nfs/nfs2xdr.c
--- linux-2.5.25/fs/nfs/nfs2xdr.c	Sat May 25 21:34:59 2002
+++ linux-2.5.25-rtt1/fs/nfs/nfs2xdr.c	Tue Jul 16 11:43:08 2002
@@ -671,33 +671,32 @@
 # define MAX(a, b)	(((a) > (b))? (a) : (b))
 #endif
 
-#define PROC(proc, argtype, restype)	\
-    { "nfs_" #proc,					\
-      (kxdrproc_t) nfs_xdr_##argtype,			\
-      (kxdrproc_t) nfs_xdr_##restype,			\
-      MAX(NFS_##argtype##_sz,NFS_##restype##_sz) << 2,	\
-      0							\
+#define PROC(proc, argtype, restype, timer)				\
+    { .p_procname =  "nfs_" #proc,					\
+      .p_encode   =  (kxdrproc_t) nfs_xdr_##argtype,			\
+      .p_decode   =  (kxdrproc_t) nfs_xdr_##restype,			\
+      .p_bufsiz   =  MAX(NFS_##argtype##_sz,NFS_##restype##_sz) << 2,	\
+      .p_timer    =  timer						\
     }
-
 static struct rpc_procinfo	nfs_procedures[18] = {
-    PROC(null,		enc_void,	dec_void),
-    PROC(getattr,	fhandle,	attrstat),
-    PROC(setattr,	sattrargs,	attrstat),
-    PROC(root,		enc_void,	dec_void),
-    PROC(lookup,	diropargs,	diropres),
-    PROC(readlink,	readlinkargs,	readlinkres),
-    PROC(read,		readargs,	readres),
-    PROC(writecache,	enc_void,	dec_void),
-    PROC(write,		writeargs,	writeres),
-    PROC(create,	createargs,	diropres),
-    PROC(remove,	diropargs,	stat),
-    PROC(rename,	renameargs,	stat),
-    PROC(link,		linkargs,	stat),
-    PROC(symlink,	symlinkargs,	stat),
-    PROC(mkdir,		createargs,	diropres),
-    PROC(rmdir,		diropargs,	stat),
-    PROC(readdir,	readdirargs,	readdirres),
-    PROC(statfs,	fhandle,	statfsres),
+    PROC(null,		enc_void,	dec_void, 0),
+    PROC(getattr,	fhandle,	attrstat, 1),
+    PROC(setattr,	sattrargs,	attrstat, 0),
+    PROC(root,		enc_void,	dec_void, 0),
+    PROC(lookup,	diropargs,	diropres, 2),
+    PROC(readlink,	readlinkargs,	readlinkres, 3),
+    PROC(read,		readargs,	readres, 3),
+    PROC(writecache,	enc_void,	dec_void, 0),
+    PROC(write,		writeargs,	writeres, 4),
+    PROC(create,	createargs,	diropres, 0),
+    PROC(remove,	diropargs,	stat, 0),
+    PROC(rename,	renameargs,	stat, 0),
+    PROC(link,		linkargs,	stat, 0),
+    PROC(symlink,	symlinkargs,	stat, 0),
+    PROC(mkdir,		createargs,	diropres, 0),
+    PROC(rmdir,		diropargs,	stat, 0),
+    PROC(readdir,	readdirargs,	readdirres, 3),
+    PROC(statfs,	fhandle,	statfsres, 0),
 };
 
 struct rpc_version		nfs_version2 = {
diff -u --recursive --new-file linux-2.5.25/fs/nfs/nfs3xdr.c linux-2.5.25-rtt1/fs/nfs/nfs3xdr.c
--- linux-2.5.25/fs/nfs/nfs3xdr.c	Sat May 25 21:25:56 2002
+++ linux-2.5.25-rtt1/fs/nfs/nfs3xdr.c	Tue Jul 16 11:43:08 2002
@@ -988,37 +988,37 @@
 # define MAX(a, b)	(((a) > (b))? (a) : (b))
 #endif
 
-#define PROC(proc, argtype, restype)				\
-    { "nfs3_" #proc,						\
-      (kxdrproc_t) nfs3_xdr_##argtype,				\
-      (kxdrproc_t) nfs3_xdr_##restype,				\
-      MAX(NFS3_##argtype##_sz,NFS3_##restype##_sz) << 2,	\
-      0							\
+#define PROC(proc, argtype, restype, timer)				\
+    { .p_procname  = "nfs3_" #proc,					\
+      .p_encode    = (kxdrproc_t) nfs3_xdr_##argtype,			\
+      .p_decode    = (kxdrproc_t) nfs3_xdr_##restype,			\
+      .p_bufsiz    = MAX(NFS3_##argtype##_sz,NFS3_##restype##_sz) << 2,	\
+      .p_timer     = timer						\
     }
 
 static struct rpc_procinfo	nfs3_procedures[22] = {
-  PROC(null,		enc_void,	dec_void),
-  PROC(getattr,		fhandle,	attrstat),
-  PROC(setattr, 	sattrargs,	wccstat),
-  PROC(lookup,		diropargs,	lookupres),
-  PROC(access,		accessargs,	accessres),
-  PROC(readlink,	readlinkargs,	readlinkres),
-  PROC(read,		readargs,	readres),
-  PROC(write,		writeargs,	writeres),
-  PROC(create,		createargs,	createres),
-  PROC(mkdir,		mkdirargs,	createres),
-  PROC(symlink,		symlinkargs,	createres),
-  PROC(mknod,		mknodargs,	createres),
-  PROC(remove,		diropargs,	wccstat),
-  PROC(rmdir,		diropargs,	wccstat),
-  PROC(rename,		renameargs,	renameres),
-  PROC(link,		linkargs,	linkres),
-  PROC(readdir,		readdirargs,	readdirres),
-  PROC(readdirplus,	readdirargs,	readdirres),
-  PROC(fsstat,		fhandle,	fsstatres),
-  PROC(fsinfo,  	fhandle,	fsinfores),
-  PROC(pathconf,	fhandle,	pathconfres),
-  PROC(commit,		commitargs,	commitres),
+  PROC(null,		enc_void,	dec_void, 0),
+  PROC(getattr,		fhandle,	attrstat, 1),
+  PROC(setattr, 	sattrargs,	wccstat, 0),
+  PROC(lookup,		diropargs,	lookupres, 2),
+  PROC(access,		accessargs,	accessres, 1),
+  PROC(readlink,	readlinkargs,	readlinkres, 3),
+  PROC(read,		readargs,	readres, 3),
+  PROC(write,		writeargs,	writeres, 4),
+  PROC(create,		createargs,	createres, 0),
+  PROC(mkdir,		mkdirargs,	createres, 0),
+  PROC(symlink,		symlinkargs,	createres, 0),
+  PROC(mknod,		mknodargs,	createres, 0),
+  PROC(remove,		diropargs,	wccstat, 0),
+  PROC(rmdir,		diropargs,	wccstat, 0),
+  PROC(rename,		renameargs,	renameres, 0),
+  PROC(link,		linkargs,	linkres, 0),
+  PROC(readdir,		readdirargs,	readdirres, 3),
+  PROC(readdirplus,	readdirargs,	readdirres, 3),
+  PROC(fsstat,		fhandle,	fsstatres, 0),
+  PROC(fsinfo,  	fhandle,	fsinfores, 0),
+  PROC(pathconf,	fhandle,	pathconfres, 0),
+  PROC(commit,		commitargs,	commitres, 5),
 };
 
 struct rpc_version		nfs_version3 = {
diff -u --recursive --new-file linux-2.5.25/include/linux/sunrpc/clnt.h linux-2.5.25-rtt1/include/linux/sunrpc/clnt.h
--- linux-2.5.25/include/linux/sunrpc/clnt.h	Tue Feb  5 16:23:43 2002
+++ linux-2.5.25-rtt1/include/linux/sunrpc/clnt.h	Tue Jul 16 11:44:28 2002
@@ -15,6 +15,7 @@
 #include <linux/sunrpc/auth.h>
 #include <linux/sunrpc/stats.h>
 #include <linux/sunrpc/xdr.h>
+#include <linux/sunrpc/timer.h>
 #include <asm/signal.h>
 
 /*
@@ -52,6 +53,8 @@
 	unsigned int		cl_flags;	/* misc client flags */
 	unsigned long		cl_hardmax;	/* max hard timeout */
 
+	struct rpc_rtt		cl_rtt;		/* RTO estimator data */
+
 	struct rpc_portmap	cl_pmap;	/* port mapping */
 	struct rpc_wait_queue	cl_bindwait;	/* waiting on getport() */
 
@@ -91,6 +94,7 @@
 	kxdrproc_t		p_decode;	/* XDR decode function */
 	unsigned int		p_bufsiz;	/* req. buffer size */
 	unsigned int		p_count;	/* call count */
+	unsigned int		p_timer;	/* Which RTT timer to use */
 };
 
 #define rpcproc_bufsiz(clnt, proc)	((clnt)->cl_procinfo[proc].p_bufsiz)
@@ -98,6 +102,7 @@
 #define rpcproc_decode(clnt, proc)	((clnt)->cl_procinfo[proc].p_decode)
 #define rpcproc_name(clnt, proc)	((clnt)->cl_procinfo[proc].p_procname)
 #define rpcproc_count(clnt, proc)	((clnt)->cl_procinfo[proc].p_count)
+#define rpcproc_timer(clnt, proc)	((clnt)->cl_procinfo[proc].p_timer)
 
 #define RPC_CONGESTED(clnt)	(RPCXPRT_CONGESTED((clnt)->cl_xprt))
 #define RPC_PEERADDR(clnt)	(&(clnt)->cl_xprt->addr)
diff -u --recursive --new-file linux-2.5.25/include/linux/sunrpc/timer.h linux-2.5.25-rtt1/include/linux/sunrpc/timer.h
--- linux-2.5.25/include/linux/sunrpc/timer.h	Thu Jan  1 01:00:00 1970
+++ linux-2.5.25-rtt1/include/linux/sunrpc/timer.h	Tue Jul 16 11:43:08 2002
@@ -0,0 +1,23 @@
+/*
+ *  linux/include/linux/sunrpc/timer.h
+ *
+ *  Declarations for the RPC transport timer.
+ *
+ *  Copyright (C) 2002 Trond Myklebust <trond.myklebust@fys.uio.no>
+ */
+
+#ifndef _LINUX_SUNRPC_TIMER_H
+#define _LINUX_SUNRPC_TIMER_H
+
+struct rpc_rtt {
+	long timeo;		/* default timeout value */
+	long srtt[5];		/* smoothed round trip time << 3 */
+	long sdrtt[5];		/* soothed medium deviation of RTT */
+};
+
+
+extern void rpc_init_rtt(struct rpc_rtt *rt, long timeo);
+extern void rpc_update_rtt(struct rpc_rtt *rt, int timer, long m);
+extern long rpc_calc_rto(struct rpc_rtt *rt, int timer);
+
+#endif /* _LINUX_SUNRPC_TIMER_H */
diff -u --recursive --new-file linux-2.5.25/include/linux/sunrpc/xprt.h linux-2.5.25-rtt1/include/linux/sunrpc/xprt.h
--- linux-2.5.25/include/linux/sunrpc/xprt.h	Sun Jul  7 19:43:16 2002
+++ linux-2.5.25-rtt1/include/linux/sunrpc/xprt.h	Tue Jul 16 11:43:08 2002
@@ -98,9 +98,8 @@
 	
 	u32			rq_bytes_sent;	/* Bytes we have sent */
 
-#ifdef RPC_PROFILE
-	unsigned long		rq_xtime;	/* when transmitted */
-#endif
+	long			rq_xtime;	/* when transmitted */
+	int			rq_nresend;
 };
 #define rq_svec			rq_snd_buf.head
 #define rq_slen			rq_snd_buf.len
diff -u --recursive --new-file linux-2.5.25/net/sunrpc/Makefile linux-2.5.25-rtt1/net/sunrpc/Makefile
--- linux-2.5.25/net/sunrpc/Makefile	Sat May 25 01:33:46 2002
+++ linux-2.5.25-rtt1/net/sunrpc/Makefile	Tue Jul 16 11:46:29 2002
@@ -9,7 +9,8 @@
 sunrpc-y := clnt.o xprt.o sched.o \
 	    auth.o auth_null.o auth_unix.o \
 	    svc.o svcsock.o svcauth.o \
-	    pmap_clnt.o xdr.o sunrpc_syms.o
+	    pmap_clnt.o timer.o xdr.o \
+	    sunrpc_syms.o
 sunrpc-$(CONFIG_PROC_FS) += stats.o
 sunrpc-$(CONFIG_SYSCTL) += sysctl.o
 sunrpc-objs := $(sunrpc-y)
diff -u --recursive --new-file linux-2.5.25/net/sunrpc/clnt.c linux-2.5.25-rtt1/net/sunrpc/clnt.c
--- linux-2.5.25/net/sunrpc/clnt.c	Sun Jul  7 19:43:16 2002
+++ linux-2.5.25-rtt1/net/sunrpc/clnt.c	Tue Jul 16 11:43:08 2002
@@ -104,6 +104,8 @@
 	if (!clnt->cl_port)
 		clnt->cl_autobind = 1;
 
+	rpc_init_rtt(&clnt->cl_rtt, xprt->timeout.to_initval);
+
 	if (!rpcauth_create(flavor, clnt))
 		goto out_no_auth;
 
diff -u --recursive --new-file linux-2.5.25/net/sunrpc/timer.c linux-2.5.25-rtt1/net/sunrpc/timer.c
--- linux-2.5.25/net/sunrpc/timer.c	Thu Jan  1 01:00:00 1970
+++ linux-2.5.25-rtt1/net/sunrpc/timer.c	Tue Jul 16 11:43:08 2002
@@ -0,0 +1,73 @@
+#include <linux/version.h>
+#include <linux/types.h>
+#include <linux/unistd.h>
+
+#include <linux/sunrpc/clnt.h>
+#include <linux/sunrpc/xprt.h>
+#include <linux/sunrpc/timer.h>
+
+#define RPC_RTO_MAX (60*HZ)
+#define RPC_RTO_INIT (HZ/5)
+#define RPC_RTO_MIN (2)
+
+void
+rpc_init_rtt(struct rpc_rtt *rt, long timeo)
+{
+	long t = (timeo - RPC_RTO_INIT) << 3;
+	int i;
+	rt->timeo = timeo;
+	if (t < 0)
+		t = 0;
+	for (i = 0; i < 5; i++) {
+		rt->srtt[i] = t;
+		rt->sdrtt[i] = RPC_RTO_INIT;
+	}
+}
+
+void
+rpc_update_rtt(struct rpc_rtt *rt, int timer, long m)
+{
+	long *srtt, *sdrtt;
+
+	if (timer-- == 0)
+		return;
+
+	if (m == 0)
+		m = 1;
+	srtt = &rt->srtt[timer];
+	m -= *srtt >> 3;
+	*srtt += m;
+	if (m < 0)
+		m = -m;
+	sdrtt = &rt->sdrtt[timer];
+	m -= *sdrtt >> 2;
+	*sdrtt += m;
+	/* Set lower bound on the variance */
+	if (*sdrtt < RPC_RTO_MIN)
+		*sdrtt = RPC_RTO_MIN;
+}
+
+/*
+ * Estimate rto for an nfs rpc sent via. an unreliable datagram.
+ * Use the mean and mean deviation of rtt for the appropriate type of rpc
+ * for the frequent rpcs and a default for the others.
+ * The justification for doing "other" this way is that these rpcs
+ * happen so infrequently that timer est. would probably be stale.
+ * Also, since many of these rpcs are
+ * non-idempotent, a conservative timeout is desired.
+ * getattr, lookup,
+ * read, write, commit     - A+4D
+ * other                   - timeo
+ */
+
+long
+rpc_calc_rto(struct rpc_rtt *rt, int timer)
+{
+	long res;
+	if (timer-- == 0)
+		return rt->timeo;
+	res = (rt->srtt[timer] >> 3) + rt->sdrtt[timer];
+	if (res > RPC_RTO_MAX)
+		res = RPC_RTO_MAX;
+	return res;
+}
diff -u --recursive --new-file linux-2.5.25/net/sunrpc/xprt.c linux-2.5.25-rtt1/net/sunrpc/xprt.c
--- linux-2.5.25/net/sunrpc/xprt.c	Sun Jul  7 19:57:26 2002
+++ linux-2.5.25-rtt1/net/sunrpc/xprt.c	Tue Jul 16 11:43:08 2002
@@ -480,13 +480,20 @@
  * Complete reply received.
  * The TCP code relies on us to remove the request from xprt->pending.
  */
-static inline void
+static void
 xprt_complete_rqst(struct rpc_xprt *xprt, struct rpc_rqst *req, int copied)
 {
 	struct rpc_task	*task = req->rq_task;
+	struct rpc_clnt *clnt = task->tk_client;
 
 	/* Adjust congestion window */
-	xprt_adjust_cwnd(xprt, copied);
+	if (!xprt->nocong) {
+		xprt_adjust_cwnd(xprt, copied);
+	       	if (!req->rq_nresend) {
+			int timer = rpcproc_timer(clnt, task->tk_msg.rpc_proc);
+			if (timer)
+				rpc_update_rtt(&clnt->cl_rtt, timer, (long)jiffies - req->rq_xtime);
+	}
 
 #ifdef RPC_PROFILE
 	/* Profile only reads for now */
@@ -934,6 +941,7 @@
 	spin_lock(&xprt->sock_lock);
 	if (req->rq_received)
 		goto out;
+	req->rq_nresend++;
 	xprt_adjust_cwnd(xprt, -ETIMEDOUT);
 
 	dprintk("RPC: %4d xprt_timer (%s request)\n",
@@ -982,15 +990,13 @@
 	if (!xprt_lock_write(xprt, task))
 		return;
 
-#ifdef RPC_PROFILE
-	req->rq_xtime = jiffies;
-#endif
 	do_xprt_transmit(task);
 }
 
 static void
 do_xprt_transmit(struct rpc_task *task)
 {
+	struct rpc_clnt *clnt = task->tk_client;
 	struct rpc_rqst	*req = task->tk_rqstp;
 	struct rpc_xprt	*xprt = req->rq_xprt;
 	int status, retry = 0;
@@ -1002,6 +1008,7 @@
 	 */
 	while (1) {
 		xprt_clear_wspace(xprt);
+		req->rq_xtime = jiffies;
 		status = xprt_sendmsg(xprt, req);
 
 		if (status < 0)
@@ -1065,7 +1072,21 @@
  out_receive:
 	dprintk("RPC: %4d xmit complete\n", task->tk_pid);
 	/* Set the task's receive timeout value */
-	task->tk_timeout = req->rq_timeout.to_current;
+	if (!xprt->nocong) {
+		int backoff;
+		task->tk_timeout = rpc_calc_rto(&clnt->cl_rtt,
+				rpcproc_timer(clnt, task->tk_msg.rpc_proc));
+		/* If we are retransmitting, increment the timeout counter */
+		backoff = req->rq_nresend;
+		if (backoff) {
+			if (backoff > 7)
+				backoff = 7;
+			task->tk_timeout <<= backoff;
+		}
+		if (task->tk_timeout > req->rq_timeout.to_maxval)
+			task->tk_timeout = req->rq_timeout.to_maxval;
+	} else
+		task->tk_timeout = req->rq_timeout.to_current;
 	spin_lock_bh(&xprt->sock_lock);
 	if (!req->rq_received)
 		rpc_sleep_on(&xprt->pending, task, NULL, xprt_timer);
