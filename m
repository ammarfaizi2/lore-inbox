Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262014AbVACXz2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262014AbVACXz2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jan 2005 18:55:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262011AbVACXyy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jan 2005 18:54:54 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:16390 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262012AbVACXvd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jan 2005 18:51:33 -0500
Date: Tue, 4 Jan 2005 00:51:27 +0100
From: Adrian Bunk <bunk@stusta.de>
To: "David S. Miller" <davem@davemloft.net>
Cc: netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: [2.6 patch] net/core/: misc possible cleanups
Message-ID: <20050103235127.GQ2980@stusta.de>
References: <20041214045758.GA23151@stusta.de> <20041227190249.6afda3df.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041227190249.6afda3df.davem@davemloft.net>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 27, 2004 at 07:02:49PM -0800, David S. Miller wrote:
> On Tue, 14 Dec 2004 05:57:58 +0100
> Adrian Bunk <bunk@stusta.de> wrote:
> 
> >   - skbuff.c: skb_insert
> >   - skbuff.c: skb_iter_first
> >   - skbuff.c: skb_iter_next
> >   - skbuff.c: skb_iter_abort
> 
> These are actually planned to be used, let's keep them in for
> now.


OK, updated patch:


<--  snip  -->


The patch below contains the following cleanups:
- make needlessly global code static
- remove the following unused global functions:
  - datagram.c: skb_copy_datagram
  - iovec.c: memcpy_tokerneliovec
- remove the following unneeded EXPORT_SYMBOL's:
  - datagram.c: skb_copy_datagram
  - dev.c: ing_filter
  - iovec.c: memcpy_tokerneliovec
  - netpoll.c: netpoll_send_skb
  - rtnetlink.c: rtnetlink_dump_ifinfo
  - sock.c: sock_alloc_send_pskb


diffstat output:
 include/linux/netdevice.h |    1 -
 include/linux/netfilter.h |    4 ----
 include/linux/netpoll.h   |    1 -
 include/linux/rtnetlink.h |    1 -
 include/linux/skbuff.h    |    5 -----
 include/linux/socket.h    |    1 -
 include/net/iw_handler.h  |    3 ---
 include/net/pkt_cls.h     |    1 -
 include/net/sock.h        |    7 -------
 net/core/datagram.c       |   19 +++----------------
 net/core/dev.c            |   13 ++++---------
 net/core/dst.c            |    2 +-
 net/core/iovec.c          |   23 -----------------------
 net/core/netfilter.c      |    2 +-
 net/core/netpoll.c        |    5 ++---
 net/core/rtnetlink.c      |    3 +--
 net/core/sock.c           |   17 +++++++++--------
 net/core/wireless.c       |    3 +--
 18 files changed, 22 insertions(+), 89 deletions(-)


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc3-mm1-full/include/linux/skbuff.h.old	2004-12-14 02:34:03.000000000 +0100
+++ linux-2.6.10-rc3-mm1-full/include/linux/skbuff.h	2004-12-14 02:51:27.000000000 +0100
@@ -1086,14 +1085,9 @@
 					 int noblock, int *err);
 extern unsigned int    datagram_poll(struct file *file, struct socket *sock,
 				     struct poll_table_struct *wait);
-extern int	       skb_copy_datagram(const struct sk_buff *from,
-					 int offset, char __user *to, int size);
 extern int	       skb_copy_datagram_iovec(const struct sk_buff *from,
 					       int offset, struct iovec *to,
 					       int size);
-extern int	       skb_copy_and_csum_datagram(const struct sk_buff *skb,
-						  int offset, u8 __user *to,
-						  int len, unsigned int *csump);
 extern int	       skb_copy_and_csum_datagram_iovec(const
 							struct sk_buff *skb,
 							int hlen,
--- linux-2.6.10-rc3-mm1-full/include/net/pkt_cls.h.old	2004-12-14 02:37:09.000000000 +0100
+++ linux-2.6.10-rc3-mm1-full/include/net/pkt_cls.h	2004-12-14 02:37:15.000000000 +0100
@@ -17,7 +17,6 @@
 
 extern int register_tcf_proto_ops(struct tcf_proto_ops *ops);
 extern int unregister_tcf_proto_ops(struct tcf_proto_ops *ops);
-extern int ing_filter(struct sk_buff *skb);
 
 static inline unsigned long
 __cls_set_class(unsigned long *clp, unsigned long cl)
--- linux-2.6.10-rc3-mm1-full/include/linux/netdevice.h.old	2004-12-14 02:38:05.000000000 +0100
+++ linux-2.6.10-rc3-mm1-full/include/linux/netdevice.h	2004-12-14 02:38:11.000000000 +0100
@@ -522,7 +522,6 @@
 extern struct net_device		*dev_base;		/* All devices */
 extern rwlock_t				dev_base_lock;		/* Device list lock */
 
-extern int			netdev_boot_setup_add(char *name, struct ifmap *map);
 extern int 			netdev_boot_setup_check(struct net_device *dev);
 extern unsigned long		netdev_boot_base(const char *prefix, int unit);
 extern struct net_device    *dev_getbyhwaddr(unsigned short type, char *hwaddr);
--- linux-2.6.10-rc3-mm1-full/include/linux/socket.h.old	2004-12-14 02:39:18.000000000 +0100
+++ linux-2.6.10-rc3-mm1-full/include/linux/socket.h	2004-12-14 02:39:24.000000000 +0100
@@ -286,7 +286,6 @@
 
 extern int verify_iovec(struct msghdr *m, struct iovec *iov, char *address, int mode);
 extern int memcpy_toiovec(struct iovec *v, unsigned char *kdata, int len);
-extern void memcpy_tokerneliovec(struct iovec *iov, unsigned char *kdata, int len);
 extern int move_addr_to_user(void *kaddr, int klen, void __user *uaddr, int __user *ulen);
 extern int move_addr_to_kernel(void __user *uaddr, int ulen, void *kaddr);
 extern int put_cmsg(struct msghdr*, int level, int type, int len, void *data);
--- linux-2.6.10-rc3-mm1-full/include/linux/netfilter.h.old	2004-12-14 02:41:28.000000000 +0100
+++ linux-2.6.10-rc3-mm1-full/include/linux/netfilter.h	2004-12-14 02:41:37.000000000 +0100
@@ -175,10 +175,6 @@
 extern void (*ip_ct_attach)(struct sk_buff *, struct sk_buff *);
 extern void nf_ct_attach(struct sk_buff *, struct sk_buff *);
 
-#ifdef CONFIG_NETFILTER_DEBUG
-extern void nf_dump_skb(int pf, struct sk_buff *skb);
-#endif
-
 /* FIXME: Before cache is ever used, this must be implemented for real. */
 extern void nf_invalidate_cache(int pf);
 
--- linux-2.6.10-rc3-mm1-full/net/core/datagram.c.old	2004-12-14 04:22:37.000000000 +0100
+++ linux-2.6.10-rc3-mm1-full/net/core/datagram.c	2004-12-14 02:35:34.000000000 +0100
@@ -199,19 +199,6 @@
 	kfree_skb(skb);
 }
 
-/*
- *	Copy a datagram to a linear buffer.
- */
-int skb_copy_datagram(const struct sk_buff *skb, int offset, char __user *to, int size)
-{
-	struct iovec iov = {
-		.iov_base = to,
-		.iov_len =size,
-	};
-
-	return skb_copy_datagram_iovec(skb, offset, &iov, size);
-}
-
 /**
  *	skb_copy_datagram_iovec - Copy a datagram to an iovec.
  *	@skb - buffer to copy
@@ -296,8 +283,9 @@
 	return -EFAULT;
 }
 
-int skb_copy_and_csum_datagram(const struct sk_buff *skb, int offset,
-			       u8 __user *to, int len, unsigned int *csump)
+static int skb_copy_and_csum_datagram(const struct sk_buff *skb, int offset,
+				      u8 __user *to, int len,
+				      unsigned int *csump)
 {
 	int start = skb_headlen(skb);
 	int pos = 0;
@@ -489,7 +477,6 @@
 
 EXPORT_SYMBOL(datagram_poll);
 EXPORT_SYMBOL(skb_copy_and_csum_datagram_iovec);
-EXPORT_SYMBOL(skb_copy_datagram);
 EXPORT_SYMBOL(skb_copy_datagram_iovec);
 EXPORT_SYMBOL(skb_free_datagram);
 EXPORT_SYMBOL(skb_recv_datagram);
--- linux-2.6.10-rc3-mm1-full/net/core/dev.c.old	2004-12-14 02:36:09.000000000 +0100
+++ linux-2.6.10-rc3-mm1-full/net/core/dev.c	2004-12-14 02:38:19.000000000 +0100
@@ -183,7 +183,7 @@
  * semaphore held.
  */
 struct net_device *dev_base;
-struct net_device **dev_tail = &dev_base;
+static struct net_device **dev_tail = &dev_base;
 rwlock_t dev_base_lock = RW_LOCK_UNLOCKED;
 
 EXPORT_SYMBOL(dev_base);
@@ -361,7 +361,7 @@
  *	returns 0 on error and 1 on success.  This is a generic routine to
  *	all netdevices.
  */
-int netdev_boot_setup_add(char *name, struct ifmap *map)
+static int netdev_boot_setup_add(char *name, struct ifmap *map)
 {
 	struct netdev_boot_setup *s;
 	int i;
@@ -644,7 +644,7 @@
  *	Network device names need to be valid file names to
  *	to allow sysfs to work
  */
-int dev_valid_name(const char *name)
+static int dev_valid_name(const char *name)
 {
 	return !(*name == '\0' 
 		 || !strcmp(name, ".")
@@ -1596,7 +1596,7 @@
  * the ingress scheduler, you just cant add policies on ingress.
  *
  */
-int ing_filter(struct sk_buff *skb) 
+static int ing_filter(struct sk_buff *skb) 
 {
 	struct Qdisc *q;
 	struct net_device *dev = skb->dev;
@@ -3251,9 +3251,4 @@
 EXPORT_SYMBOL(dev_load);
 #endif
 
-#ifdef CONFIG_NET_CLS_ACT
-EXPORT_SYMBOL(ing_filter);
-#endif
-
-
 EXPORT_PER_CPU_SYMBOL(softnet_data);
--- linux-2.6.10-rc3-mm1-full/net/core/dst.c.old	2004-12-14 02:38:35.000000000 +0100
+++ linux-2.6.10-rc3-mm1-full/net/core/dst.c	2004-12-14 02:38:45.000000000 +0100
@@ -264,7 +264,7 @@
 	return NOTIFY_DONE;
 }
 
-struct notifier_block dst_dev_notifier = {
+static struct notifier_block dst_dev_notifier = {
 	.notifier_call	= dst_dev_event,
 };
 
--- linux-2.6.10-rc3-mm1-full/net/core/iovec.c.old	2004-12-14 02:39:30.000000000 +0100
+++ linux-2.6.10-rc3-mm1-full/net/core/iovec.c	2004-12-14 02:39:52.000000000 +0100
@@ -99,28 +99,6 @@
 }
 
 /*
- *	In kernel copy to iovec. Returns -EFAULT on error.
- *
- *	Note: this modifies the original iovec.
- */
- 
-void memcpy_tokerneliovec(struct iovec *iov, unsigned char *kdata, int len)
-{
-	while (len > 0) {
-		if (iov->iov_len) {
-			int copy = min_t(unsigned int, iov->iov_len, len);
-			memcpy(iov->iov_base, kdata, copy);
-			kdata += copy;
-			len -= copy;
-			iov->iov_len -= copy;
-			iov->iov_base += copy;
-		}
-		iov++;
-	}
-}
-
-
-/*
  *	Copy iovec to kernel. Returns -EFAULT on error.
  *
  *	Note: this modifies the original iovec.
@@ -259,4 +237,3 @@
 EXPORT_SYMBOL(memcpy_fromiovec);
 EXPORT_SYMBOL(memcpy_fromiovecend);
 EXPORT_SYMBOL(memcpy_toiovec);
-EXPORT_SYMBOL(memcpy_tokerneliovec);
--- linux-2.6.10-rc3-mm1-full/net/core/netfilter.c.old	2004-12-14 02:41:44.000000000 +0100
+++ linux-2.6.10-rc3-mm1-full/net/core/netfilter.c	2004-12-14 02:41:52.000000000 +0100
@@ -173,7 +173,7 @@
 	printk("\n");
 }
 
-void nf_dump_skb(int pf, struct sk_buff *skb)
+static void nf_dump_skb(int pf, struct sk_buff *skb)
 {
 	printk("skb: pf=%i %s dev=%s len=%u\n", 
 	       pf,
--- linux-2.6.10-rc3-mm1-full/include/linux/netpoll.h.old	2004-12-14 02:43:42.000000000 +0100
+++ linux-2.6.10-rc3-mm1-full/include/linux/netpoll.h	2004-12-14 02:43:47.000000000 +0100
@@ -24,7 +24,6 @@
 };
 
 void netpoll_poll(struct netpoll *np);
-void netpoll_send_skb(struct netpoll *np, struct sk_buff *skb);
 void netpoll_send_udp(struct netpoll *np, const char *msg, int len);
 int netpoll_parse_options(struct netpoll *np, char *opt);
 int netpoll_setup(struct netpoll *np);
--- linux-2.6.10-rc3-mm1-full/net/core/netpoll.c.old	2004-12-14 02:43:06.000000000 +0100
+++ linux-2.6.10-rc3-mm1-full/net/core/netpoll.c	2004-12-14 02:43:59.000000000 +0100
@@ -39,7 +39,7 @@
 static LIST_HEAD(rx_list);
 
 static atomic_t trapped;
-spinlock_t netpoll_poll_lock = SPIN_LOCK_UNLOCKED;
+static spinlock_t netpoll_poll_lock = SPIN_LOCK_UNLOCKED;
 
 #define NETPOLL_RX_ENABLED  1
 #define NETPOLL_RX_DROP     2
@@ -178,7 +178,7 @@
 	return skb;
 }
 
-void netpoll_send_skb(struct netpoll *np, struct sk_buff *skb)
+static void netpoll_send_skb(struct netpoll *np, struct sk_buff *skb)
 {
 	int status;
 
@@ -676,6 +676,5 @@
 EXPORT_SYMBOL(netpoll_parse_options);
 EXPORT_SYMBOL(netpoll_setup);
 EXPORT_SYMBOL(netpoll_cleanup);
-EXPORT_SYMBOL(netpoll_send_skb);
 EXPORT_SYMBOL(netpoll_send_udp);
 EXPORT_SYMBOL(netpoll_poll);
--- linux-2.6.10-rc3-mm1-full/include/linux/rtnetlink.h.old	2004-12-14 02:44:36.000000000 +0100
+++ linux-2.6.10-rc3-mm1-full/include/linux/rtnetlink.h	2004-12-14 02:44:52.000000000 +0100
@@ -765,7 +765,6 @@
 };
 
 extern struct rtnetlink_link * rtnetlink_links[NPROTO];
-extern int rtnetlink_dump_ifinfo(struct sk_buff *skb, struct netlink_callback *cb);
 extern int rtnetlink_send(struct sk_buff *skb, u32 pid, u32 group, int echo);
 extern int rtnetlink_put_metrics(struct sk_buff *skb, u32 *metrics);
 
--- linux-2.6.10-rc3-mm1-full/net/core/rtnetlink.c.old	2004-12-14 02:45:12.000000000 +0100
+++ linux-2.6.10-rc3-mm1-full/net/core/rtnetlink.c	2004-12-14 02:45:26.000000000 +0100
@@ -241,7 +241,7 @@
 	return -1;
 }
 
-int rtnetlink_dump_ifinfo(struct sk_buff *skb, struct netlink_callback *cb)
+static int rtnetlink_dump_ifinfo(struct sk_buff *skb, struct netlink_callback *cb)
 {
 	int idx;
 	int s_idx = cb->args[0];
@@ -676,7 +676,6 @@
 
 EXPORT_SYMBOL(__rta_fill);
 EXPORT_SYMBOL(rtattr_parse);
-EXPORT_SYMBOL(rtnetlink_dump_ifinfo);
 EXPORT_SYMBOL(rtnetlink_links);
 EXPORT_SYMBOL(rtnetlink_put_metrics);
 EXPORT_SYMBOL(rtnl);
--- linux-2.6.10-rc3-mm1-full/include/net/sock.h.old	2004-12-14 02:56:46.000000000 +0100
+++ linux-2.6.10-rc3-mm1-full/include/net/sock.h	2004-12-14 02:53:27.000000000 +0100
@@ -733,11 +733,6 @@
 						     unsigned long size,
 						     int noblock,
 						     int *errcode);
-extern struct sk_buff 		*sock_alloc_send_pskb(struct sock *sk,
-						      unsigned long header_len,
-						      unsigned long data_len,
-						      int noblock,
-						      int *errcode);
 extern void *sock_kmalloc(struct sock *sk, int size, int priority);
 extern void sock_kfree_s(struct sock *sk, void *mem, int size);
 extern void sk_send_sigurg(struct sock *sk);
@@ -795,8 +790,6 @@
  *	Default socket callbacks and setup code
  */
  
-extern void sock_def_destruct(struct sock *);
-
 /* Initialise core socket variables */
 extern void sock_init_data(struct socket *sock, struct sock *sk);
 
--- linux-2.6.10-rc3-mm1-full/net/core/sock.c.old	2004-12-14 02:52:27.000000000 +0100
+++ linux-2.6.10-rc3-mm1-full/net/core/sock.c	2004-12-14 03:12:56.000000000 +0100
@@ -825,8 +825,10 @@
  *	Generic send/receive buffer handlers
  */
 
-struct sk_buff *sock_alloc_send_pskb(struct sock *sk, unsigned long header_len,
-				     unsigned long data_len, int noblock, int *errcode)
+static struct sk_buff *sock_alloc_send_pskb(struct sock *sk,
+					    unsigned long header_len,
+					    unsigned long data_len,
+					    int noblock, int *errcode)
 {
 	struct sk_buff *skb;
 	unsigned int gfp_mask;
@@ -1084,7 +1086,7 @@
  *	Default Socket Callbacks
  */
 
-void sock_def_wakeup(struct sock *sk)
+static void sock_def_wakeup(struct sock *sk)
 {
 	read_lock(&sk->sk_callback_lock);
 	if (sk->sk_sleep && waitqueue_active(sk->sk_sleep))
@@ -1092,7 +1094,7 @@
 	read_unlock(&sk->sk_callback_lock);
 }
 
-void sock_def_error_report(struct sock *sk)
+static void sock_def_error_report(struct sock *sk)
 {
 	read_lock(&sk->sk_callback_lock);
 	if (sk->sk_sleep && waitqueue_active(sk->sk_sleep))
@@ -1101,7 +1103,7 @@
 	read_unlock(&sk->sk_callback_lock);
 }
 
-void sock_def_readable(struct sock *sk, int len)
+static void sock_def_readable(struct sock *sk, int len)
 {
 	read_lock(&sk->sk_callback_lock);
 	if (sk->sk_sleep && waitqueue_active(sk->sk_sleep))
@@ -1110,7 +1112,7 @@
 	read_unlock(&sk->sk_callback_lock);
 }
 
-void sock_def_write_space(struct sock *sk)
+static void sock_def_write_space(struct sock *sk)
 {
 	read_lock(&sk->sk_callback_lock);
 
@@ -1129,7 +1131,7 @@
 	read_unlock(&sk->sk_callback_lock);
 }
 
-void sock_def_destruct(struct sock *sk)
+static void sock_def_destruct(struct sock *sk)
 {
 	if (sk->sk_protinfo)
 		kfree(sk->sk_protinfo);
@@ -1368,7 +1370,6 @@
 EXPORT_SYMBOL(sk_alloc);
 EXPORT_SYMBOL(sk_free);
 EXPORT_SYMBOL(sk_send_sigurg);
-EXPORT_SYMBOL(sock_alloc_send_pskb);
 EXPORT_SYMBOL(sock_alloc_send_skb);
 EXPORT_SYMBOL(sock_init_data);
 EXPORT_SYMBOL(sock_kfree_s);
--- linux-2.6.10-rc3-mm1-full/include/net/iw_handler.h.old	2004-12-14 02:54:50.000000000 +0100
+++ linux-2.6.10-rc3-mm1-full/include/net/iw_handler.h	2004-12-14 02:54:57.000000000 +0100
@@ -418,9 +418,6 @@
  * Those may be called only within the kernel.
  */
 
-/* Data needed by fs/compat_ioctl.c for 32->64 bit conversion */
-extern const char iw_priv_type_size[];
-
 /* First : function strictly used inside the kernel */
 
 /* Handle /proc/net/wireless, called in net/code/dev.c */
--- linux-2.6.10-rc3-mm1-full/net/core/wireless.c.old	2004-12-14 02:55:04.000000000 +0100
+++ linux-2.6.10-rc3-mm1-full/net/core/wireless.c	2004-12-14 02:55:12.000000000 +0100
@@ -304,7 +304,7 @@
 				       sizeof(struct iw_ioctl_description));
 
 /* Size (in bytes) of the various private data types */
-const char iw_priv_type_size[] = {
+static const char iw_priv_type_size[] = {
 	0,				/* IW_PRIV_TYPE_NONE */
 	1,				/* IW_PRIV_TYPE_BYTE */
 	1,				/* IW_PRIV_TYPE_CHAR */

