Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751122AbWITU7o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751122AbWITU7o (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 16:59:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751093AbWITU7W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 16:59:22 -0400
Received: from [63.64.152.142] ([63.64.152.142]:59661 "EHLO gitlost.site")
	by vger.kernel.org with ESMTP id S1751066AbWITU7S (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 16:59:18 -0400
From: Ashwini Kulkarni <ashwini.kulkarni@intel.com>
Subject: [RFC 3/6] Add in TCP related part of splice read to ipv4
Date: Wed, 20 Sep 2006 14:08:16 -0700
To: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc: christopher.leech@intel.com
Message-Id: <20060920210815.17480.77860.stgit@gitlost.site>
In-Reply-To: <20060920210711.17480.92354.stgit@gitlost.site>
References: <20060920210711.17480.92354.stgit@gitlost.site>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


---

 net/ipv4/af_inet.c |    1 
 net/ipv4/tcp.c     |  135 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 136 insertions(+), 0 deletions(-)

diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
index c84a320..3c0d245 100644
--- a/net/ipv4/af_inet.c
+++ b/net/ipv4/af_inet.c
@@ -807,6 +807,7 @@ const struct proto_ops inet_stream_ops =
 	.recvmsg	   = sock_common_recvmsg,
 	.mmap		   = sock_no_mmap,
 	.sendpage	   = tcp_sendpage,
+	.splice_read	   = tcp_splice_read,
 #ifdef CONFIG_COMPAT
 	.compat_setsockopt = compat_sock_common_setsockopt,
 	.compat_getsockopt = compat_sock_common_getsockopt,
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 934396b..d4c02a1 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -254,6 +254,10 @@
 #include <linux/init.h>
 #include <linux/smp_lock.h>
 #include <linux/fs.h>
+#include <linux/skbuff.h>
+#include <linux/pipe_fs_i.h>
+#include <linux/net.h>
+#include <linux/socket.h>
 #include <linux/random.h>
 #include <linux/bootmem.h>
 #include <linux/cache.h>
@@ -264,6 +268,7 @@
 #include <net/xfrm.h>
 #include <net/ip.h>
 #include <net/netdma.h>
+#include <net/sock.h>
 
 #include <asm/uaccess.h>
 #include <asm/ioctls.h>
@@ -291,6 +296,23 @@ EXPORT_SYMBOL(tcp_memory_allocated);
 EXPORT_SYMBOL(tcp_sockets_allocated);
 
 /*
+ *	Create a TCP splice context.
+ */
+struct tcp_splice_state {
+		struct pipe_inode_info *pipe;
+		void (*original_data_ready)(struct sock*, int);
+		size_t len;
+		size_t offset;
+		unsigned int flags;
+};
+
+int __tcp_splice_read(struct sock *sk, loff_t *ppos, struct pipe_inode_info *pipe,
+		      size_t len, unsigned int flags, struct tcp_splice_state *tss);
+int tcp_splice_data_recv(read_descriptor_t *rd_desc, struct sk_buff *skb,
+			 unsigned int offset, size_t len);
+void tcp_splice_data_ready(struct sock *sk, int flag);
+
+/*
  * Pressure flag: try to collapse.
  * Technical note: it is used by multiple contexts non atomically.
  * All the sk_stream_mem_schedule() is of this nature: accounting
@@ -499,6 +521,118 @@ static inline void tcp_push(struct sock 
 	}
 }
 
+/*
+ *  tcp_splice_read - splice data from TCP socket to a pipe
+ * @sock:	socket to splice from
+ * @pipe:	pipe to splice to
+ * @len:	number of bytes to splice
+ * @flags:	splice modifier flags
+ *
+ * Will read pages from given socket and fill them into a pipe.
+ */
+ssize_t tcp_splice_read(struct socket *sock, loff_t *ppos, struct pipe_inode_info *pipe, size_t len, unsigned int flags)
+{
+	struct tcp_splice_state tss = {
+		.pipe = pipe,
+		.len = len,
+		.flags = flags,
+	};
+	struct sock *sk = sock->sk;
+	ssize_t spliced;
+	int ret;
+
+	ret = 0;
+	spliced = 0;
+
+	if (*ppos != 0)
+		return -EINVAL;
+
+	while(tss.len) {
+		ret = __tcp_splice_read(sk, ppos, tss.pipe, tss.len, tss.flags, &tss);
+
+		if(ret < 0)
+			break;
+		else if (!ret) {
+			if (spliced)
+				break;
+			if (flags & SPLICE_F_NONBLOCK) {
+				ret = -EAGAIN;
+				break;
+			}
+		}
+		tss.len -= ret;
+		spliced += ret;
+	}
+	if (spliced)
+		return spliced;
+
+	return ret;
+}
+
+int __tcp_splice_read(struct sock *sk, loff_t *ppos, struct pipe_inode_info *pipe, size_t len, unsigned int flags, struct tcp_splice_state *tss)
+{
+	read_descriptor_t rd_desc;
+	int copied;
+
+	tss->original_data_ready = sk->sk_data_ready;
+
+	sk->sk_user_data = tss;
+
+	/* Store TCP splice context information in read_descriptor_t. */
+	rd_desc.arg.data = tss;
+
+	copied = tcp_read_sock(sk, &rd_desc, tcp_splice_data_recv);
+
+	if (copied != 0) {
+		if (flags & SPLICE_F_MORE) {
+			/* Setup new sk_data_ready as tcp_splice_data_ready. */
+			sk->sk_data_ready = tcp_splice_data_ready;
+			return sk_wait_data(sk, &sk->sk_rcvtimeo);
+		}
+		else if(flags & SPLICE_F_NONBLOCK)
+			return -EAGAIN;
+		else return copied;
+	}
+	else
+		return copied;
+}
+
+int tcp_splice_data_recv(read_descriptor_t *rd_desc, struct sk_buff *skb, unsigned int offset, size_t len)
+{
+	/*
+	 * Restore TCP splice context from read_descriptor_t
+	 */
+	struct tcp_splice_state *tss = rd_desc->arg.data;
+
+	return skb_splice_bits(skb, offset, tss->pipe, tss->len, tss->flags);
+}
+
+void tcp_splice_data_ready(struct sock *sk, int flag)
+{
+	/*
+	 * Restore splice context/ read_descriptor_t from sk->sk_user_data
+	 */
+	struct tcp_splice_state *tss = sk->sk_user_data;
+	read_descriptor_t rd_desc;
+
+	read_lock(&sk->sk_callback_lock);
+
+	rd_desc.arg.data = tss;
+	rd_desc.count = 1;
+	tcp_read_sock(sk, &rd_desc, tcp_splice_data_recv);
+
+	read_unlock(&sk->sk_callback_lock);
+
+	if(tss->len == 0) {
+		/* Restore original sk_data_ready callback. */
+		sk->sk_data_ready = tss->original_data_ready;
+		/* Wakeup user thread. */
+		return sock_def_wakeup(sk);
+	}
+	else
+		return;
+}
+
 static ssize_t do_tcp_sendpages(struct sock *sk, struct page **pages, int poffset,
 			 size_t psize, int flags)
 {
@@ -2345,6 +2479,7 @@ EXPORT_SYMBOL(tcp_poll);
 EXPORT_SYMBOL(tcp_read_sock);
 EXPORT_SYMBOL(tcp_recvmsg);
 EXPORT_SYMBOL(tcp_sendmsg);
+EXPORT_SYMBOL(tcp_splice_read);
 EXPORT_SYMBOL(tcp_sendpage);
 EXPORT_SYMBOL(tcp_setsockopt);
 EXPORT_SYMBOL(tcp_shutdown);

