Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932287AbVLLXr5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932287AbVLLXr5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Dec 2005 18:47:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932286AbVLLXrF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Dec 2005 18:47:05 -0500
Received: from mx1.redhat.com ([66.187.233.31]:37283 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932248AbVLLXqV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Dec 2005 18:46:21 -0500
Date: Mon, 12 Dec 2005 23:45:49 GMT
Message-Id: <200512122345.jBCNjnMW009059@warthog.cambridge.redhat.com>
From: David Howells <dhowells@redhat.com>
To: torvalds@osdl.org, akpm@osdl.org, hch@infradead.org, arjan@infradead.org,
       matthew@wil.cx
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Fcc: outgoing
Subject: [PATCH 17/19] MUTEX: Networking changes
In-Reply-To: <dhowells1134431145@warthog.cambridge.redhat.com>
References: <dhowells1134431145@warthog.cambridge.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The attached patch modifies the networking files to use the new mutex
functions.

Signed-Off-By: David Howells <dhowells@redhat.com>
---
warthog>diffstat -p1 mutex-net-2615rc5.diff
 net/atm/resources.h             |    2 +-
 net/bridge/netfilter/ebtables.c |   12 ++++++------
 net/core/flow.c                 |    2 +-
 net/dccp/proto.c                |    2 +-
 net/ipv4/ipcomp.c               |    2 +-
 net/ipv4/netfilter/arp_tables.c |    2 +-
 net/ipv4/netfilter/ip_tables.c  |    2 +-
 net/ipv6/ipcomp6.c              |    2 +-
 net/ipv6/netfilter/ip6_tables.c |    2 +-
 net/sunrpc/sched.c              |    2 --
 net/sunrpc/svcsock.c            |    2 +-
 11 files changed, 15 insertions(+), 17 deletions(-)

diff -uNrp /warthog/kernels/linux-2.6.15-rc5/net/atm/resources.h linux-2.6.15-rc5-mutex/net/atm/resources.h
--- /warthog/kernels/linux-2.6.15-rc5/net/atm/resources.h	2005-12-08 16:23:56.000000000 +0000
+++ linux-2.6.15-rc5-mutex/net/atm/resources.h	2005-12-12 20:45:35.000000000 +0000
@@ -11,7 +11,7 @@
 
 
 extern struct list_head atm_devs;
-extern struct semaphore atm_dev_mutex;
+extern struct mutex atm_dev_mutex;
 
 int atm_dev_ioctl(unsigned int cmd, void __user *arg);
 
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/net/bridge/netfilter/ebtables.c linux-2.6.15-rc5-mutex/net/bridge/netfilter/ebtables.c
--- /warthog/kernels/linux-2.6.15-rc5/net/bridge/netfilter/ebtables.c	2005-11-01 13:19:23.000000000 +0000
+++ linux-2.6.15-rc5-mutex/net/bridge/netfilter/ebtables.c	2005-12-12 20:46:34.000000000 +0000
@@ -296,7 +296,7 @@ letscontinue:
 /* If it succeeds, returns element and locks mutex */
 static inline void *
 find_inlist_lock_noload(struct list_head *head, const char *name, int *error,
-   struct semaphore *mutex)
+   struct mutx *mutex)
 {
 	void *ret;
 
@@ -317,7 +317,7 @@ find_inlist_lock_noload(struct list_head
 #else
 static void *
 find_inlist_lock(struct list_head *head, const char *name, const char *prefix,
-   int *error, struct semaphore *mutex)
+   int *error, struct mutex *mutex)
 {
 	void *ret;
 
@@ -331,25 +331,25 @@ find_inlist_lock(struct list_head *head,
 #endif
 
 static inline struct ebt_table *
-find_table_lock(const char *name, int *error, struct semaphore *mutex)
+find_table_lock(const char *name, int *error, struct mutex *mutex)
 {
 	return find_inlist_lock(&ebt_tables, name, "ebtable_", error, mutex);
 }
 
 static inline struct ebt_match *
-find_match_lock(const char *name, int *error, struct semaphore *mutex)
+find_match_lock(const char *name, int *error, struct mutex *mutex)
 {
 	return find_inlist_lock(&ebt_matches, name, "ebt_", error, mutex);
 }
 
 static inline struct ebt_watcher *
-find_watcher_lock(const char *name, int *error, struct semaphore *mutex)
+find_watcher_lock(const char *name, int *error, struct mutex *mutex)
 {
 	return find_inlist_lock(&ebt_watchers, name, "ebt_", error, mutex);
 }
 
 static inline struct ebt_target *
-find_target_lock(const char *name, int *error, struct semaphore *mutex)
+find_target_lock(const char *name, int *error, struct mutex *mutex)
 {
 	return find_inlist_lock(&ebt_targets, name, "ebt_", error, mutex);
 }
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/net/core/flow.c linux-2.6.15-rc5-mutex/net/core/flow.c
--- /warthog/kernels/linux-2.6.15-rc5/net/core/flow.c	2005-11-01 13:19:23.000000000 +0000
+++ linux-2.6.15-rc5-mutex/net/core/flow.c	2005-12-12 22:12:50.000000000 +0000
@@ -20,9 +20,9 @@
 #include <linux/notifier.h>
 #include <linux/cpu.h>
 #include <linux/cpumask.h>
+#include <linux/semaphore.h>
 #include <net/flow.h>
 #include <asm/atomic.h>
-#include <asm/semaphore.h>
 
 struct flow_cache_entry {
 	struct flow_cache_entry	*next;
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/net/dccp/proto.c linux-2.6.15-rc5-mutex/net/dccp/proto.c
--- /warthog/kernels/linux-2.6.15-rc5/net/dccp/proto.c	2005-12-08 16:23:56.000000000 +0000
+++ linux-2.6.15-rc5-mutex/net/dccp/proto.c	2005-12-12 22:12:50.000000000 +0000
@@ -29,7 +29,7 @@
 #include <net/sock.h>
 #include <net/xfrm.h>
 
-#include <asm/semaphore.h>
+#include <linux/semaphore.h>
 #include <linux/spinlock.h>
 #include <linux/timer.h>
 #include <linux/delay.h>
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/net/ipv4/ipcomp.c linux-2.6.15-rc5-mutex/net/ipv4/ipcomp.c
--- /warthog/kernels/linux-2.6.15-rc5/net/ipv4/ipcomp.c	2005-11-01 13:19:24.000000000 +0000
+++ linux-2.6.15-rc5-mutex/net/ipv4/ipcomp.c	2005-12-12 22:12:50.000000000 +0000
@@ -16,7 +16,7 @@
 #include <linux/config.h>
 #include <linux/module.h>
 #include <asm/scatterlist.h>
-#include <asm/semaphore.h>
+#include <linux/semaphore.h>
 #include <linux/crypto.h>
 #include <linux/pfkeyv2.h>
 #include <linux/percpu.h>
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/net/ipv4/netfilter/arp_tables.c linux-2.6.15-rc5-mutex/net/ipv4/netfilter/arp_tables.c
--- /warthog/kernels/linux-2.6.15-rc5/net/ipv4/netfilter/arp_tables.c	2005-12-08 16:23:56.000000000 +0000
+++ linux-2.6.15-rc5-mutex/net/ipv4/netfilter/arp_tables.c	2005-12-12 22:12:50.000000000 +0000
@@ -19,9 +19,9 @@
 #include <linux/proc_fs.h>
 #include <linux/module.h>
 #include <linux/init.h>
+#include <linux/semaphore.h>
 
 #include <asm/uaccess.h>
-#include <asm/semaphore.h>
 
 #include <linux/netfilter_arp/arp_tables.h>
 
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/net/ipv4/netfilter/ip_tables.c linux-2.6.15-rc5-mutex/net/ipv4/netfilter/ip_tables.c
--- /warthog/kernels/linux-2.6.15-rc5/net/ipv4/netfilter/ip_tables.c	2005-12-08 16:23:56.000000000 +0000
+++ linux-2.6.15-rc5-mutex/net/ipv4/netfilter/ip_tables.c	2005-12-12 22:12:50.000000000 +0000
@@ -24,7 +24,7 @@
 #include <linux/icmp.h>
 #include <net/ip.h>
 #include <asm/uaccess.h>
-#include <asm/semaphore.h>
+#include <linux/semaphore.h>
 #include <linux/proc_fs.h>
 #include <linux/err.h>
 #include <linux/cpumask.h>
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/net/ipv6/ipcomp6.c linux-2.6.15-rc5-mutex/net/ipv6/ipcomp6.c
--- /warthog/kernels/linux-2.6.15-rc5/net/ipv6/ipcomp6.c	2005-12-08 16:23:56.000000000 +0000
+++ linux-2.6.15-rc5-mutex/net/ipv6/ipcomp6.c	2005-12-12 22:12:50.000000000 +0000
@@ -36,7 +36,7 @@
 #include <net/xfrm.h>
 #include <net/ipcomp.h>
 #include <asm/scatterlist.h>
-#include <asm/semaphore.h>
+#include <linux/semaphore.h>
 #include <linux/crypto.h>
 #include <linux/pfkeyv2.h>
 #include <linux/random.h>
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/net/ipv6/netfilter/ip6_tables.c linux-2.6.15-rc5-mutex/net/ipv6/netfilter/ip6_tables.c
--- /warthog/kernels/linux-2.6.15-rc5/net/ipv6/netfilter/ip6_tables.c	2005-12-08 16:23:57.000000000 +0000
+++ linux-2.6.15-rc5-mutex/net/ipv6/netfilter/ip6_tables.c	2005-12-12 22:12:50.000000000 +0000
@@ -25,7 +25,7 @@
 #include <linux/icmpv6.h>
 #include <net/ipv6.h>
 #include <asm/uaccess.h>
-#include <asm/semaphore.h>
+#include <linux/semaphore.h>
 #include <linux/proc_fs.h>
 #include <linux/cpumask.h>
 
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/net/sunrpc/sched.c linux-2.6.15-rc5-mutex/net/sunrpc/sched.c
--- /warthog/kernels/linux-2.6.15-rc5/net/sunrpc/sched.c	2005-11-01 13:19:26.000000000 +0000
+++ linux-2.6.15-rc5-mutex/net/sunrpc/sched.c	2005-12-12 17:57:01.000000000 +0000
@@ -971,8 +971,6 @@ void rpc_killall_tasks(struct rpc_clnt *
 	spin_unlock(&rpc_sched_lock);
 }
 
-static DECLARE_MUTEX_LOCKED(rpciod_running);
-
 static void rpciod_killall(void)
 {
 	unsigned long flags;
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/net/sunrpc/svcsock.c linux-2.6.15-rc5-mutex/net/sunrpc/svcsock.c
--- /warthog/kernels/linux-2.6.15-rc5/net/sunrpc/svcsock.c	2005-12-08 16:23:57.000000000 +0000
+++ linux-2.6.15-rc5-mutex/net/sunrpc/svcsock.c	2005-12-12 17:58:56.000000000 +0000
@@ -1351,7 +1351,7 @@ svc_setup_socket(struct svc_serv *serv, 
 	svsk->sk_lastrecv = get_seconds();
 	INIT_LIST_HEAD(&svsk->sk_deferred);
 	INIT_LIST_HEAD(&svsk->sk_ready);
-	sema_init(&svsk->sk_sem, 1);
+	init_MUTEX(&svsk->sk_sem);
 
 	/* Initialize the socket */
 	if (sock->type == SOCK_DGRAM)
