Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130454AbQLNOra>; Thu, 14 Dec 2000 09:47:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131104AbQLNOrU>; Thu, 14 Dec 2000 09:47:20 -0500
Received: from pat.uio.no ([129.240.130.16]:33498 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id <S130454AbQLNOrG>;
	Thu, 14 Dec 2000 09:47:06 -0500
Message-ID: <14904.54852.334762.889784@charged.uio.no>
Date: Thu, 14 Dec 2000 15:16:36 +0100 (CET)
To: Linux Kernel <linux-kernel@vger.kernel.org>,
        NFS maillist <nfs@lists.sourceforge.net>
Subject: [CFT] Improved RPC congestion handling for 2.4.0 (and 2.2.18)
X-Mailer: VM 6.72 under 21.1 (patch 12) "Channel Islands" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

   One of the things we've been lacking in the Linux implementation of
RPC is the 'ping' routine. The latter is used on most *NIX
implementations in order to test whether or not the RPC server is
alive. To do so, it simply calls procedure-0 (the NULL procedure),
which is always set up to return the value 0 and therefore acts more
or less like the icmp 'ping'.

  The appended patch implements such a routine, and uses it to improve
our congestion control, by allowing the entire set of pending requests
to inquire whether or not the server is alive, and then to sleep for 5
seconds before retrying. This is done if and only if we get a major
RPC timeout and we see that the client Van Jacobson congestion control
can no longer throttle back the number of pending requests.

  This is more accurate than the current system of just retrying each
request, and waiting for 5 seconds if icmp fails, because the ping
directly tests whether the server is up and responding to
requests. Furthermore, unlike the retried requests, the packet length
of a ping request is always short, so we don't fall prone to issues of
udp fragmentation messing up the test. Finally, because all pending
requests are made to wait on a single ping rather than bombarding the
server with retries, it avoids further congestion to the network.

  A version of this patch for linux-2.2.18 is available on

   http://www.fys.uio.no/~trondmy/src/2.2.18/linux-2.2.18-sunrpc.dif

Cheers,
  Trond

diff -u --recursive --new-file linux-2.4.0-test12/include/linux/sunrpc/clnt.h linux-2.4.0-ping/include/linux/sunrpc/clnt.h
--- linux-2.4.0-test12/include/linux/sunrpc/clnt.h	Tue Dec 12 22:28:44 2000
+++ linux-2.4.0-ping/include/linux/sunrpc/clnt.h	Thu Dec 14 10:18:50 2000
@@ -111,6 +111,8 @@
 void		rpc_release_client(struct rpc_clnt *);
 void		rpc_getport(struct rpc_task *, struct rpc_clnt *);
 int		rpc_register(u32, u32, int, unsigned short, int *);
+u32 *		rpc_call_header(struct rpc_task *task);
+u32 *		rpc_call_verify(struct rpc_task *task);
 
 void		rpc_call_setup(struct rpc_task *, struct rpc_message *, int);
 
@@ -143,6 +145,11 @@
  * Helper function for NFSroot support
  */
 int		rpc_getport_external(struct sockaddr_in *, __u32, __u32, int);
+
+/*
+ * Ping function
+ */
+void		rpc_ping(struct rpc_task *task);
 
 #endif /* __KERNEL__ */
 #endif /* _LINUX_SUNRPC_CLNT_H */
diff -u --recursive --new-file linux-2.4.0-test12/include/linux/sunrpc/xprt.h linux-2.4.0-ping/include/linux/sunrpc/xprt.h
--- linux-2.4.0-test12/include/linux/sunrpc/xprt.h	Tue Dec 12 22:28:44 2000
+++ linux-2.4.0-ping/include/linux/sunrpc/xprt.h	Thu Dec 14 09:34:26 2000
@@ -39,12 +39,14 @@
  * Come Linux 2.3, we'll handle fragments directly.
  */
 #define RPC_MAXCONG		16
-#define RPC_MAXREQS		(RPC_MAXCONG + 1)
+#define RPC_MAXREQS		(RPC_MAXCONG + 2)
 #define RPC_CWNDSCALE		256
 #define RPC_MAXCWND		(RPC_MAXCONG * RPC_CWNDSCALE)
 #define RPC_INITCWND		RPC_CWNDSCALE
 #define RPCXPRT_CONGESTED(xprt) \
 	((xprt)->cong >= (xprt)->cwnd)
+#define RPCXPRT_SUPERCONGESTED(xprt) \
+				((xprt)->cwnd < 2*RPC_CWNDSCALE)
 
 /* Default timeout values */
 #define RPC_MAX_UDP_TIMEOUT	(60*HZ)
@@ -136,6 +138,7 @@
 	struct rpc_wait_queue	pending;	/* requests in flight */
 	struct rpc_wait_queue	backlog;	/* waiting for slot */
 	struct rpc_wait_queue	reconn;		/* waiting for reconnect */
+	struct rpc_wait_queue	pingwait;	/* waiting on ping() */
 	struct rpc_rqst *	free;		/* free slots */
 	struct rpc_rqst		slot[RPC_MAXREQS];
 	unsigned int		sockstate;	/* Socket state */
@@ -179,10 +182,12 @@
 					unsigned long);
 
 int			xprt_reserve(struct rpc_task *);
+int			xprt_ping_reserve(struct rpc_task *);
 void			xprt_transmit(struct rpc_task *);
 void			xprt_receive(struct rpc_task *);
 int			xprt_adjust_timeout(struct rpc_timeout *);
 void			xprt_release(struct rpc_task *);
+void			xprt_ping_release(struct rpc_task *);
 void			xprt_reconnect(struct rpc_task *);
 int			xprt_clear_backlog(struct rpc_xprt *);
 void			__rpciod_tcp_dispatcher(void);
@@ -191,6 +196,8 @@
 
 #define XPRT_WSPACE	0
 #define XPRT_CONNECT	1
+#define XPRT_PING	2
+#define XPRT_NORESPOND	3
 
 #define xprt_wspace(xp)			(test_bit(XPRT_WSPACE, &(xp)->sockstate))
 #define xprt_test_and_set_wspace(xp)	(test_and_set_bit(XPRT_WSPACE, &(xp)->sockstate))
@@ -200,6 +207,14 @@
 #define xprt_set_connected(xp)		(set_bit(XPRT_CONNECT, &(xp)->sockstate))
 #define xprt_test_and_set_connected(xp)	(test_and_set_bit(XPRT_CONNECT, &(xp)->sockstate))
 #define xprt_clear_connected(xp)	(clear_bit(XPRT_CONNECT, &(xp)->sockstate))
+
+#define xprt_pinging(xp)		(test_bit(XPRT_PING, &(xp)->sockstate))
+#define xprt_test_and_set_pinging(xp)	(test_and_set_bit(XPRT_PING, &(xp)->sockstate))
+#define xprt_clear_pinging(xp)		(clear_bit(XPRT_PING, &(xp)->sockstate))
+
+#define xprt_norespond(xp)		(test_bit(XPRT_NORESPOND, &(xp)->sockstate))
+#define xprt_test_and_set_norespond(xp)	(test_and_set_bit(XPRT_NORESPOND, &(xp)->sockstate))
+#define xprt_clear_norespond(xp)	(clear_bit(XPRT_NORESPOND, &(xp)->sockstate))
 
 static inline
 int xprt_tcp_pending(void)
diff -u --recursive --new-file linux-2.4.0-test12/net/sunrpc/Makefile linux-2.4.0-ping/net/sunrpc/Makefile
--- linux-2.4.0-test12/net/sunrpc/Makefile	Sat Apr 22 01:08:52 2000
+++ linux-2.4.0-ping/net/sunrpc/Makefile	Wed Dec 13 23:44:44 2000
@@ -11,7 +11,7 @@
 O_OBJS   := clnt.o xprt.o sched.o \
 	    auth.o auth_null.o auth_unix.o \
 	    svc.o svcsock.o svcauth.o \
-	    pmap_clnt.o xdr.o
+	    pmap_clnt.o ping.o xdr.o
 OX_OBJS  := sunrpc_syms.o
 
 ifeq ($(CONFIG_PROC_FS),y)
diff -u --recursive --new-file linux-2.4.0-test12/net/sunrpc/clnt.c linux-2.4.0-ping/net/sunrpc/clnt.c
--- linux-2.4.0-test12/net/sunrpc/clnt.c	Wed Nov 29 07:34:01 2000
+++ linux-2.4.0-ping/net/sunrpc/clnt.c	Thu Dec 14 10:20:45 2000
@@ -55,8 +55,8 @@
 static void	call_refreshresult(struct rpc_task *task);
 static void	call_timeout(struct rpc_task *task);
 static void	call_reconnect(struct rpc_task *task);
-static u32 *	call_header(struct rpc_task *task);
-static u32 *	call_verify(struct rpc_task *task);
+static void	call_ping(struct rpc_task *task);
+static void	call_pingresult(struct rpc_task *task);
 
 
 /*
@@ -490,7 +490,7 @@
 
 	/* Encode header and provided arguments */
 	encode = rpcproc_encode(clnt, task->tk_msg.rpc_proc);
-	if (!(p = call_header(task))) {
+	if (!(p = rpc_call_header(task))) {
 		printk(KERN_INFO "RPC: call_header failed, exit EIO\n");
 		rpc_exit(task, -EIO);
 	} else
@@ -595,11 +595,10 @@
 			task->tk_action = call_reconnect;
 			break;
 		}
-		/*
-		 * Sleep and dream of an open connection
-		 */
-		task->tk_timeout = 5 * HZ;
-		rpc_sleep_on(&xprt->sending, task, NULL, NULL);
+		if (RPCXPRT_SUPERCONGESTED(clnt->cl_xprt)) {
+			task->tk_action = call_ping;
+			break;
+		}
 	case -ENOMEM:
 	case -EAGAIN:
 		task->tk_action = call_transmit;
@@ -623,6 +622,7 @@
 {
 	struct rpc_clnt	*clnt = task->tk_client;
 	struct rpc_rqst	*req = task->tk_rqstp;
+	int major = 0;
 
 	if (req) {
 		struct rpc_timeout *to = &req->rq_timeout;
@@ -643,17 +643,7 @@
 		rpc_exit(task, -EIO);
 		return;
 	}
-	if (clnt->cl_chatty && !(task->tk_flags & RPC_CALL_MAJORSEEN)) {
-		task->tk_flags |= RPC_CALL_MAJORSEEN;
-		if (req)
-			printk(KERN_NOTICE "%s: server %s not responding, still trying\n",
-				clnt->cl_protname, clnt->cl_server);
-#ifdef RPC_DEBUG				
-		else
-			printk(KERN_NOTICE "%s: task %d can't get a request slot\n",
-				clnt->cl_protname, task->tk_pid);
-#endif				
-	}
+	major = 1;
 	if (clnt->cl_autobind)
 		clnt->cl_port = 0;
 
@@ -666,6 +656,8 @@
 	} else if (!xprt_connected(clnt->cl_xprt)) {
 		task->tk_action = call_reconnect;
 		clnt->cl_stats->rpcretrans++;
+	} else if (major && RPCXPRT_SUPERCONGESTED(clnt->cl_xprt)) {
+		task->tk_action = call_ping;
 	} else {
 		task->tk_action = call_transmit;
 		clnt->cl_stats->rpcretrans++;
@@ -687,12 +679,6 @@
 	dprintk("RPC: %4d call_decode (status %d)\n", 
 				task->tk_pid, task->tk_status);
 
-	if (clnt->cl_chatty && (task->tk_flags & RPC_CALL_MAJORSEEN)) {
-		printk(KERN_NOTICE "%s: server %s OK\n",
-			clnt->cl_protname, clnt->cl_server);
-		task->tk_flags &= ~RPC_CALL_MAJORSEEN;
-	}
-
 	if (task->tk_status < 12) {
 		printk(KERN_WARNING "%s: too small RPC reply size (%d bytes)\n",
 			clnt->cl_protname, task->tk_status);
@@ -701,7 +687,7 @@
 	}
 
 	/* Verify the RPC header */
-	if (!(p = call_verify(task)))
+	if (!(p = rpc_call_verify(task)))
 		return;
 
 	/*
@@ -760,8 +746,8 @@
 /*
  * Call header serialization
  */
-static u32 *
-call_header(struct rpc_task *task)
+u32 *
+rpc_call_header(struct rpc_task *task)
 {
 	struct rpc_clnt *clnt = task->tk_client;
 	struct rpc_xprt *xprt = clnt->cl_xprt;
@@ -781,10 +767,63 @@
 }
 
 /*
+ * Ping a non-responding server
+ */
+static void
+call_ping(struct rpc_task *task)
+{
+	task->tk_action = call_pingresult;
+	rpc_ping(task);
+}
+
+/*
+ * Interpret the result from ping
+ */
+static void
+call_pingresult(struct rpc_task *task)
+{
+	struct rpc_clnt	*clnt = task->tk_client;
+	struct rpc_xprt	*xprt = clnt->cl_xprt;
+	int		status = task->tk_status;
+
+	task->tk_status = 0;
+	if (status >= 0) {
+		task->tk_action = call_transmit;
+		return;
+	}
+
+	switch(status) {
+	case -ECONNREFUSED:
+	case -ENOTCONN:
+		if (clnt->cl_autobind || !clnt->cl_port) {
+			clnt->cl_port = 0;
+			task->tk_action = call_bind;
+			break;
+		}
+		if (xprt->stream) {
+			task->tk_action = call_reconnect;
+			break;
+		}
+	case -ENOMEM:
+	case -ENOBUFS:
+		rpc_delay(task, HZ >> 4);
+	case -ETIMEDOUT:
+		task->tk_action = call_ping;
+		break;
+	default:
+		if (clnt->cl_chatty)
+			printk("%s: RPC call returned error %d\n",
+			       clnt->cl_protname, -status);
+		rpc_exit(task,status);
+		return;
+	}
+}
+
+/*
  * Reply header verification
  */
-static u32 *
-call_verify(struct rpc_task *task)
+u32 *
+rpc_call_verify(struct rpc_task *task)
 {
 	u32	*p = task->tk_rqstp->rq_rvec[0].iov_base, n;
 
diff -u --recursive --new-file linux-2.4.0-test12/net/sunrpc/ping.c linux-2.4.0-ping/net/sunrpc/ping.c
--- linux-2.4.0-test12/net/sunrpc/ping.c	Thu Jan  1 01:00:00 1970
+++ linux-2.4.0-ping/net/sunrpc/ping.c	Thu Dec 14 10:39:06 2000
@@ -0,0 +1,209 @@
+/*
+ * linux/net/sunrpc/ping.c
+ *
+ * Ping routing.
+ *
+ * Copyright (C) 2000, Trond Myklebust <trond.myklebust@fys.uio.no>
+ */
+
+#include <linux/config.h>
+#include <linux/types.h>
+#include <linux/socket.h>
+#include <linux/kernel.h>
+#include <linux/errno.h>
+#include <linux/uio.h>
+#include <linux/in.h>
+#include <linux/sunrpc/clnt.h>
+#include <linux/sunrpc/xprt.h>
+#include <linux/sunrpc/sched.h>
+
+
+#define RPC_SLACK_SPACE		512	/* total overkill */
+
+#ifdef RPC_DEBUG
+# define RPCDBG_FACILITY	RPCDBG_XPRT
+#endif
+
+static void ping_call_reserve(struct rpc_task *);
+static void ping_call_allocate(struct rpc_task *);
+static void ping_call_encode(struct rpc_task *);
+static void ping_call_transmit(struct rpc_task *);
+static void ping_call_receive(struct rpc_task *);
+static void ping_call_exit(struct rpc_task *);
+
+
+static void
+ping_call_reserve(struct rpc_task *task)
+{
+	dprintk("RPC: %4d, ping_call_reserve\n", task->tk_pid);
+	task->tk_status = 0;
+	task->tk_action  = ping_call_allocate;
+	task->tk_timeout = task->tk_client->cl_timeout.to_resrvval;
+	xprt_ping_reserve(task);
+}
+
+static void
+ping_call_allocate(struct rpc_task *task)
+{
+	struct rpc_clnt	*clnt = task->tk_client;
+	struct rpc_rqst	*req = task->tk_rqstp;
+	unsigned int	bufsiz;
+
+	dprintk("RPC: %4d, ping_call_allocate (status %d)\n",
+		task->tk_pid, task->tk_status);
+
+	task->tk_action = ping_call_exit;
+	if (task->tk_status < 0)
+		return;
+
+	bufsiz = rpcproc_bufsiz(clnt, task->tk_msg.rpc_proc) + RPC_SLACK_SPACE;
+	if (!(task->tk_buffer = rpc_malloc(task, bufsiz << 1))) {
+		task->tk_status = -ENOMEM;
+		return;
+	}
+	req->rq_svec[0].iov_base = (void *)task->tk_buffer;
+	req->rq_svec[0].iov_len	 = bufsiz;
+	req->rq_slen		 = 0;
+	req->rq_snr		 = 1;
+	req->rq_rvec[0].iov_base = (void *)((char *)task->tk_buffer + bufsiz);
+	req->rq_rvec[0].iov_len	 = bufsiz;
+	req->rq_rlen		 = bufsiz;
+	req->rq_rnr		 = 1;
+	task->tk_action		 = ping_call_encode;
+}
+
+static void
+ping_call_encode(struct rpc_task *task)
+{
+	struct rpc_rqst	*req = task->tk_rqstp;
+	u32		*p;
+
+	dprintk("RPC: %4d, ping_call_encode (status %d)\n",
+		task->tk_pid, task->tk_status);
+
+	if (task->tk_status < 0) {
+		task->tk_action = ping_call_exit;
+		return;
+	}
+	p = rpc_call_header(task);
+	req->rq_slen = xdr_adjust_iovec(req->rq_svec, p);
+	task->tk_action = ping_call_transmit;
+}
+
+static void
+ping_call_transmit(struct rpc_task *task)
+{
+	dprintk("RPC: %4d, ping_call_transmit\n", task->tk_pid);
+	task->tk_action = ping_call_receive;
+	xprt_transmit(task);
+}
+
+static void
+ping_call_receive(struct rpc_task *task)
+{
+	struct rpc_clnt	*clnt = task->tk_client;
+	struct rpc_xprt	*xprt = clnt->cl_xprt;
+	struct rpc_rqst *req = task->tk_rqstp;
+	struct rpc_timeout *to = &req->rq_timeout;
+	u32 *p;
+
+	dprintk("RPC: %4d, ping_call_receive (status %d)\n",
+		task->tk_pid, task->tk_status);
+
+	if (task->tk_status >= 0)
+		p = rpc_call_verify(task);
+
+	if (task->tk_status >= 0 || task->tk_status == -EACCES) {
+		task->tk_status = 0;
+		if (xprt_norespond(xprt)) {
+			if (clnt->cl_chatty)
+				printk(KERN_NOTICE "%s: server %s OK\n",
+				       clnt->cl_protname, clnt->cl_server);
+			xprt_clear_norespond(xprt);
+		}
+		task->tk_action = ping_call_exit;
+		return;
+	}
+
+	switch (task->tk_status) {
+	case -ENOMEM:
+	case -EAGAIN:
+		if (!xprt_adjust_timeout(to)) {
+			task->tk_status = 0;
+			task->tk_action = ping_call_transmit;
+			break;
+		}
+	default:
+		if (clnt->cl_chatty) {
+			if (!xprt_test_and_set_norespond(xprt)) {
+				printk(KERN_NOTICE
+				       "%s: server %s is not responding\n",
+				       clnt->cl_protname, clnt->cl_server);
+			} else {
+				printk(KERN_NOTICE
+				       "%s: server %s still not responding\n",
+				       clnt->cl_protname, clnt->cl_server);
+			}
+		}
+		task->tk_action = ping_call_exit;
+		rpc_delay(task, 5*HZ);
+	}
+}
+
+static void
+ping_call_exit(struct rpc_task *task)
+{
+	struct rpc_xprt	*xprt = task->tk_xprt;
+
+	dprintk("RPC: %4d, ping_call_exit (status %d)\n",
+		task->tk_pid, task->tk_status);
+
+	task->tk_action = NULL;
+	xprt_ping_release(task);
+
+	/* Sigh. rpc_delay() clears task->tk_status */
+	if (task->tk_status == 0 && xprt_norespond(xprt))
+		task->tk_status = -ETIMEDOUT;
+
+	xprt_clear_pinging(xprt);
+	rpc_wake_up_status(&xprt->pingwait, task->tk_status);
+}
+
+void
+rpc_ping(struct rpc_task *task)
+{
+	struct rpc_clnt *clnt = task->tk_client;
+	struct rpc_xprt	*xprt = clnt->cl_xprt;
+	struct rpc_task	*child;
+	struct rpc_message msg = {0, NULL, NULL, NULL};
+
+	dprintk("RPC: %4d, rpc_ping\n", task->tk_pid);
+
+ again:
+	if (xprt_test_and_set_pinging(xprt)) {
+		rpc_sleep_on(&xprt->pingwait, task, NULL, 0);
+		if (!xprt_pinging(xprt)) {
+			rpc_wake_up_task(task);
+			goto again;
+		}
+		dprintk("RPC: %4d, rpc_ping, waiting on completion\n",
+			task->tk_pid);
+		return;
+	}
+
+	child = rpc_new_child(clnt, task);
+	if (!child) {
+		dprintk("RPC: %4d, rpc_ping, failed to create child process\n",
+			task->tk_pid);
+		xprt_clear_pinging(xprt);
+		rpc_wake_up_status(&xprt->pingwait, -ENOMEM);
+		task->tk_status = -ENOMEM;
+		return;
+	}
+	rpc_call_setup(child, &msg, 0);
+	child->tk_action = ping_call_reserve;
+
+	dprintk("RPC: %4d, rpc_ping, running child process %4d\n",
+		task->tk_pid, child->tk_pid);
+	rpc_run_child(task, child, NULL);
+}
diff -u --recursive --new-file linux-2.4.0-test12/net/sunrpc/xprt.c linux-2.4.0-ping/net/sunrpc/xprt.c
--- linux-2.4.0-test12/net/sunrpc/xprt.c	Wed Nov 29 07:34:01 2000
+++ linux-2.4.0-ping/net/sunrpc/xprt.c	Thu Dec 14 04:15:14 2000
@@ -1260,14 +1260,6 @@
 		}
 		spin_unlock_bh(&xprt_sock_lock);
 		return;
-	case -EAGAIN:
-		/* Keep holding the socket if it is blocked */
-		rpc_delay(task, HZ>>4);
-		return;
-	case -ECONNREFUSED:
-	case -ENOTCONN:
-		if (!xprt->stream)
-			return;
 	default:
 		goto out_release;
 	}
@@ -1424,6 +1416,62 @@
 }
 
 /*
+ * Reserve a ping RPC call slot.
+ */
+int
+xprt_ping_reserve(struct rpc_task *task)
+{
+	struct rpc_xprt	*xprt = task->tk_xprt;
+	struct rpc_rqst	*req;
+
+	/* We already have an initialized request. */
+	if (task->tk_rqstp)
+		return 0;
+	if (xprt->shutdown)
+		task->tk_status = -EIO;
+
+	dprintk("RPC: %4d xprt_ping_reserve cong = %ld cwnd = %ld\n",
+				task->tk_pid, xprt->cong, xprt->cwnd);
+	spin_lock_bh(&xprt_sock_lock);
+	if ((req = xprt->free) != NULL) {
+		xprt->free = req->rq_next;
+		req->rq_next = NULL;
+		task->tk_rqstp = req;
+		xprt_request_init(task, xprt);
+	} else
+		task->tk_status = -ENOBUFS;
+	spin_unlock_bh(&xprt_sock_lock);
+	dprintk("RPC: %4d xprt_ping_reserve returns %d\n",
+				task->tk_pid, task->tk_status);
+	if (!req)
+		BUG();
+	return task->tk_status;
+}
+
+/*
+ * Release an RPC call slot
+ */
+void
+xprt_ping_release(struct rpc_task *task)
+{
+	struct rpc_xprt	*xprt = task->tk_xprt;
+	struct rpc_rqst	*req;
+
+	xprt_up_transmit(task);
+	if (!(req = task->tk_rqstp))
+		return;
+	task->tk_rqstp = NULL;
+	memset(req, 0, sizeof(*req));	/* mark unused */
+
+	dprintk("RPC: %4d release request %p\n", task->tk_pid, req);
+
+	spin_lock_bh(&xprt_sock_lock);
+	req->rq_next = xprt->free;
+	xprt->free   = req;
+	spin_unlock_bh(&xprt_sock_lock);
+}
+
+/*
  * Set default timeout parameters
  */
 void
@@ -1491,6 +1539,7 @@
 	xprt->sending = RPC_INIT_WAITQ("xprt_sending");
 	xprt->backlog = RPC_INIT_WAITQ("xprt_backlog");
 	xprt->reconn  = RPC_INIT_WAITQ("xprt_reconn");
+	xprt->pingwait  = RPC_INIT_WAITQ("xprt_pingwait");
 
 	/* initialize free list */
 	for (i = 0, req = xprt->slot; i < RPC_MAXREQS-1; i++, req++)
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
