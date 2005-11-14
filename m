Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932159AbVKNVdx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932159AbVKNVdx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Nov 2005 16:33:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932161AbVKNVdZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Nov 2005 16:33:25 -0500
Received: from e34.co.us.ibm.com ([32.97.110.152]:2755 "EHLO e34.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S932147AbVKNVct (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Nov 2005 16:32:49 -0500
Message-Id: <20051114212529.024197000@sergelap>
References: <20051114212341.724084000@sergelap>
Date: Mon, 14 Nov 2005 15:23:50 -0600
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: Hubertus Franke <frankeh@watson.ibm.com>,
       Dave Hansen <haveblue@us.ibm.com>
Subject: [RFC] [PATCH 09/13] Change pid accesses: net/
Content-Disposition: inline; filename=B8-change-pid-tgid-references-net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Replace-Subject: Change pid accesses: net/
From: Serge Hallyn <serue@us.ibm.com>

Change pid accesses for net/.

Signed-off-by: Dave Hansen <haveblue@us.ibm.com>
Signed-off-by: Serge Hallyn <serue@us.ibm.com>
---
 net/core/pktgen.c          |    4 ++--
 net/core/rtnetlink.c       |    3 ++-
 net/core/scm.c             |    2 +-
 net/ipv4/devinet.c         |    2 +-
 net/ipv4/fib_semantics.c   |    2 +-
 net/ipv4/ipvs/ip_vs_sync.c |    6 +++---
 net/ipv4/tcp.c             |    2 +-
 net/ipv6/addrconf.c        |    6 +++---
 net/ipv6/ip6_flowlabel.c   |    2 +-
 net/ipv6/route.c           |    2 +-
 net/netlink/af_netlink.c   |    2 +-
 net/rxrpc/krxiod.c         |    2 +-
 net/rxrpc/krxsecd.c        |    2 +-
 net/rxrpc/krxtimod.c       |    2 +-
 net/sunrpc/sched.c         |    2 +-
 net/unix/af_unix.c         |    6 +++---
 16 files changed, 24 insertions(+), 23 deletions(-)

Index: linux-2.6.15-rc1/net/core/pktgen.c
===================================================================
--- linux-2.6.15-rc1.orig/net/core/pktgen.c
+++ linux-2.6.15-rc1/net/core/pktgen.c
@@ -2699,9 +2699,9 @@ static void pktgen_thread_worker(struct 
 	t->control &= ~(T_STOP);
 	t->control &= ~(T_REMDEV);
 
-        t->pid = current->pid;        
+        t->pid = task_pid(current);
 
-        PG_DEBUG(printk("pktgen: starting pktgen/%d:  pid=%d\n", cpu, current->pid));
+        PG_DEBUG(printk("pktgen: starting pktgen/%d:  pid=%d\n", cpu, task_pid(current)));
 
 	max_before_softirq = t->max_before_softirq;
         
Index: linux-2.6.15-rc1/net/core/rtnetlink.c
===================================================================
--- linux-2.6.15-rc1.orig/net/core/rtnetlink.c
+++ linux-2.6.15-rc1/net/core/rtnetlink.c
@@ -455,7 +455,8 @@ void rtmsg_ifinfo(int type, struct net_d
 	if (!skb)
 		return;
 
-	if (rtnetlink_fill_ifinfo(skb, dev, type, current->pid, 0, change, 0) < 0) {
+	if (rtnetlink_fill_ifinfo(skb, dev, type, task_pid(current),
+				  0, change, 0) < 0) {
 		kfree_skb(skb);
 		return;
 	}
Index: linux-2.6.15-rc1/net/core/scm.c
===================================================================
--- linux-2.6.15-rc1.orig/net/core/scm.c
+++ linux-2.6.15-rc1/net/core/scm.c
@@ -41,7 +41,7 @@
 
 static __inline__ int scm_check_creds(struct ucred *creds)
 {
-	if ((creds->pid == current->tgid || capable(CAP_SYS_ADMIN)) &&
+	if ((creds->pid == task_tgid(current) || capable(CAP_SYS_ADMIN)) &&
 	    ((creds->uid == current->uid || creds->uid == current->euid ||
 	      creds->uid == current->suid) || capable(CAP_SETUID)) &&
 	    ((creds->gid == current->gid || creds->gid == current->egid ||
Index: linux-2.6.15-rc1/net/ipv4/devinet.c
===================================================================
--- linux-2.6.15-rc1.orig/net/ipv4/devinet.c
+++ linux-2.6.15-rc1/net/ipv4/devinet.c
@@ -1113,7 +1113,7 @@ static void rtmsg_ifa(int event, struct 
 
 	if (!skb)
 		netlink_set_err(rtnl, 0, RTNLGRP_IPV4_IFADDR, ENOBUFS);
-	else if (inet_fill_ifaddr(skb, ifa, current->pid, 0, event, 0) < 0) {
+	else if (inet_fill_ifaddr(skb, ifa, task_pid(current), 0, event, 0) < 0) {
 		kfree_skb(skb);
 		netlink_set_err(rtnl, 0, RTNLGRP_IPV4_IFADDR, EINVAL);
 	} else {
Index: linux-2.6.15-rc1/net/ipv4/fib_semantics.c
===================================================================
--- linux-2.6.15-rc1.orig/net/ipv4/fib_semantics.c
+++ linux-2.6.15-rc1/net/ipv4/fib_semantics.c
@@ -1043,7 +1043,7 @@ fib_convert_rtentry(int cmd, struct nlms
 	}
 
 	nl->nlmsg_flags = NLM_F_REQUEST;
-	nl->nlmsg_pid = current->pid;
+	nl->nlmsg_pid = task_pid(current);
 	nl->nlmsg_seq = 0;
 	nl->nlmsg_len = NLMSG_LENGTH(sizeof(*rtm));
 	if (cmd == SIOCDELRT) {
Index: linux-2.6.15-rc1/net/ipv4/ipvs/ip_vs_sync.c
===================================================================
--- linux-2.6.15-rc1.orig/net/ipv4/ipvs/ip_vs_sync.c
+++ linux-2.6.15-rc1/net/ipv4/ipvs/ip_vs_sync.c
@@ -786,7 +786,7 @@ static int sync_thread(void *startup)
 
 	add_wait_queue(&sync_wait, &wait);
 
-	set_sync_pid(state, current->pid);
+	set_sync_pid(state, task_pid(current));
 	complete((struct completion *)startup);
 
 	/* processing master/backup loop here */
@@ -841,7 +841,7 @@ int start_sync_thread(int state, char *m
 	    (state == IP_VS_STATE_BACKUP && sync_backup_pid))
 		return -EEXIST;
 
-	IP_VS_DBG(7, "%s: pid %d\n", __FUNCTION__, current->pid);
+	IP_VS_DBG(7, "%s: pid %d\n", __FUNCTION__, task_pid(current));
 	IP_VS_DBG(7, "Each ip_vs_sync_conn entry need %Zd bytes\n",
 		  sizeof(struct ip_vs_sync_conn));
 
@@ -876,7 +876,7 @@ int stop_sync_thread(int state)
 	    (state == IP_VS_STATE_BACKUP && !sync_backup_pid))
 		return -ESRCH;
 
-	IP_VS_DBG(7, "%s: pid %d\n", __FUNCTION__, current->pid);
+	IP_VS_DBG(7, "%s: pid %d\n", __FUNCTION__, task_pid(current));
 	IP_VS_INFO("stopping sync thread %d ...\n",
 		   (state == IP_VS_STATE_MASTER) ? sync_master_pid : sync_backup_pid);
 
Index: linux-2.6.15-rc1/net/ipv4/tcp.c
===================================================================
--- linux-2.6.15-rc1.orig/net/ipv4/tcp.c
+++ linux-2.6.15-rc1/net/ipv4/tcp.c
@@ -1299,7 +1299,7 @@ do_prequeue:
 		if ((flags & MSG_PEEK) && peek_seq != tp->copied_seq) {
 			if (net_ratelimit())
 				printk(KERN_DEBUG "TCP(%s:%d): Application bug, race in MSG_PEEK.\n",
-				       current->comm, current->pid);
+				       current->comm, task_pid(current));
 			peek_seq = tp->copied_seq;
 		}
 		continue;
Index: linux-2.6.15-rc1/net/ipv6/addrconf.c
===================================================================
--- linux-2.6.15-rc1.orig/net/ipv6/addrconf.c
+++ linux-2.6.15-rc1/net/ipv6/addrconf.c
@@ -2997,7 +2997,7 @@ static void inet6_ifa_notify(int event, 
 		netlink_set_err(rtnl, 0, RTNLGRP_IPV6_IFADDR, ENOBUFS);
 		return;
 	}
-	if (inet6_fill_ifaddr(skb, ifa, current->pid, 0, event, 0) < 0) {
+	if (inet6_fill_ifaddr(skb, ifa, task_pid(current), 0, event, 0) < 0) {
 		kfree_skb(skb);
 		netlink_set_err(rtnl, 0, RTNLGRP_IPV6_IFADDR, EINVAL);
 		return;
@@ -3132,7 +3132,7 @@ void inet6_ifinfo_notify(int event, stru
 		netlink_set_err(rtnl, 0, RTNLGRP_IPV6_IFINFO, ENOBUFS);
 		return;
 	}
-	if (inet6_fill_ifinfo(skb, idev, current->pid, 0, event, 0) < 0) {
+	if (inet6_fill_ifinfo(skb, idev, task_pid(current), 0, event, 0) < 0) {
 		kfree_skb(skb);
 		netlink_set_err(rtnl, 0, RTNLGRP_IPV6_IFINFO, EINVAL);
 		return;
@@ -3192,7 +3192,7 @@ static void inet6_prefix_notify(int even
 		netlink_set_err(rtnl, 0, RTNLGRP_IPV6_PREFIX, ENOBUFS);
 		return;
 	}
-	if (inet6_fill_prefix(skb, idev, pinfo, current->pid, 0, event, 0) < 0) {
+	if (inet6_fill_prefix(skb, idev, pinfo, task_pid(current), 0, event, 0) < 0) {
 		kfree_skb(skb);
 		netlink_set_err(rtnl, 0, RTNLGRP_IPV6_PREFIX, EINVAL);
 		return;
Index: linux-2.6.15-rc1/net/ipv6/ip6_flowlabel.c
===================================================================
--- linux-2.6.15-rc1.orig/net/ipv6/ip6_flowlabel.c
+++ linux-2.6.15-rc1/net/ipv6/ip6_flowlabel.c
@@ -342,7 +342,7 @@ fl_create(struct in6_flowlabel_req *freq
 	case IPV6_FL_S_ANY:
 		break;
 	case IPV6_FL_S_PROCESS:
-		fl->owner = current->pid;
+		fl->owner = task_pid(current);
 		break;
 	case IPV6_FL_S_USER:
 		fl->owner = current->euid;
Index: linux-2.6.15-rc1/net/ipv6/route.c
===================================================================
--- linux-2.6.15-rc1.orig/net/ipv6/route.c
+++ linux-2.6.15-rc1/net/ipv6/route.c
@@ -1840,7 +1840,7 @@ void inet6_rt_notify(int event, struct r
 {
 	struct sk_buff *skb;
 	int size = NLMSG_SPACE(sizeof(struct rtmsg)+256);
-	u32 pid = current->pid;
+	u32 pid = task_pid(current);
 	u32 seq = 0;
 
 	if (req)
Index: linux-2.6.15-rc1/net/netlink/af_netlink.c
===================================================================
--- linux-2.6.15-rc1.orig/net/netlink/af_netlink.c
+++ linux-2.6.15-rc1/net/netlink/af_netlink.c
@@ -476,7 +476,7 @@ static int netlink_autobind(struct socke
 	struct hlist_head *head;
 	struct sock *osk;
 	struct hlist_node *node;
-	s32 pid = current->pid;
+	s32 pid = task_pid(current);
 	int err;
 	static s32 rover = -4097;
 
Index: linux-2.6.15-rc1/net/rxrpc/krxiod.c
===================================================================
--- linux-2.6.15-rc1.orig/net/rxrpc/krxiod.c
+++ linux-2.6.15-rc1/net/rxrpc/krxiod.c
@@ -40,7 +40,7 @@ static int rxrpc_krxiod(void *arg)
 {
 	DECLARE_WAITQUEUE(krxiod,current);
 
-	printk("Started krxiod %d\n",current->pid);
+	printk("Started krxiod %d\n",task_pid(current));
 
 	daemonize("krxiod");
 
Index: linux-2.6.15-rc1/net/rxrpc/krxsecd.c
===================================================================
--- linux-2.6.15-rc1.orig/net/rxrpc/krxsecd.c
+++ linux-2.6.15-rc1/net/rxrpc/krxsecd.c
@@ -53,7 +53,7 @@ static int rxrpc_krxsecd(void *arg)
 
 	int die;
 
-	printk("Started krxsecd %d\n", current->pid);
+	printk("Started krxsecd %d\n", task_pid(current));
 
 	daemonize("krxsecd");
 
Index: linux-2.6.15-rc1/net/rxrpc/krxtimod.c
===================================================================
--- linux-2.6.15-rc1.orig/net/rxrpc/krxtimod.c
+++ linux-2.6.15-rc1/net/rxrpc/krxtimod.c
@@ -68,7 +68,7 @@ static int krxtimod(void *arg)
 
 	rxrpc_timer_t *timer;
 
-	printk("Started krxtimod %d\n", current->pid);
+	printk("Started krxtimod %d\n", task_pid(current));
 
 	daemonize("krxtimod");
 
Index: linux-2.6.15-rc1/net/sunrpc/sched.c
===================================================================
--- linux-2.6.15-rc1.orig/net/sunrpc/sched.c
+++ linux-2.6.15-rc1/net/sunrpc/sched.c
@@ -792,7 +792,7 @@ void rpc_init_task(struct rpc_task *task
 	spin_unlock(&rpc_sched_lock);
 
 	dprintk("RPC: %4d new task procpid %d\n", task->tk_pid,
-				current->pid);
+				task_pid(current));
 }
 
 static struct rpc_task *
Index: linux-2.6.15-rc1/net/unix/af_unix.c
===================================================================
--- linux-2.6.15-rc1.orig/net/unix/af_unix.c
+++ linux-2.6.15-rc1/net/unix/af_unix.c
@@ -439,7 +439,7 @@ static int unix_listen(struct socket *so
 	sk->sk_max_ack_backlog	= backlog;
 	sk->sk_state		= TCP_LISTEN;
 	/* set credentials so connect can copy them */
-	sk->sk_peercred.pid	= current->tgid;
+	sk->sk_peercred.pid	= task_tgid(current);
 	sk->sk_peercred.uid	= current->euid;
 	sk->sk_peercred.gid	= current->egid;
 	err = 0;
@@ -1043,7 +1043,7 @@ restart:
 	unix_peer(newsk)	= sk;
 	newsk->sk_state		= TCP_ESTABLISHED;
 	newsk->sk_type		= sk->sk_type;
-	newsk->sk_peercred.pid	= current->tgid;
+	newsk->sk_peercred.pid	= task_tgid(current);
 	newsk->sk_peercred.uid	= current->euid;
 	newsk->sk_peercred.gid	= current->egid;
 	newu = unix_sk(newsk);
@@ -1105,7 +1105,7 @@ static int unix_socketpair(struct socket
 	sock_hold(skb);
 	unix_peer(ska)=skb;
 	unix_peer(skb)=ska;
-	ska->sk_peercred.pid = skb->sk_peercred.pid = current->tgid;
+	ska->sk_peercred.pid = skb->sk_peercred.pid = task_tgid(current);
 	ska->sk_peercred.uid = skb->sk_peercred.uid = current->euid;
 	ska->sk_peercred.gid = skb->sk_peercred.gid = current->egid;
 

--

