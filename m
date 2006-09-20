Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932073AbWITVAm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932073AbWITVAm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 17:00:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932072AbWITVAh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 17:00:37 -0400
Received: from [63.64.152.142] ([63.64.152.142]:60429 "EHLO gitlost.site")
	by vger.kernel.org with ESMTP id S1751085AbWITU7V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 16:59:21 -0400
From: Ashwini Kulkarni <ashwini.kulkarni@intel.com>
Subject: [RFC 4/6] Add TCP socket splicing (tcp_splice_read) support
Date: Wed, 20 Sep 2006 14:08:18 -0700
To: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc: christopher.leech@intel.com
Message-Id: <20060920210818.17480.59450.stgit@gitlost.site>
In-Reply-To: <20060920210711.17480.92354.stgit@gitlost.site>
References: <20060920210711.17480.92354.stgit@gitlost.site>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


---

 fs/splice.c               |   16 ++++++++++++++++
 include/linux/net.h       |    2 ++
 include/linux/pipe_fs_i.h |    1 +
 include/net/tcp.h         |    3 +++
 net/socket.c              |   13 +++++++++++++
 5 files changed, 35 insertions(+), 0 deletions(-)

diff --git a/fs/splice.c b/fs/splice.c
index c6a880b..3a4202d 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -123,6 +123,12 @@ error:
 	return err;
 }
 
+void generic_sock_buf_release(struct pipe_inode_info *pipe,
+					struct pipe_buffer *buf)
+{
+	put_page(buf->page);
+}
+
 static struct pipe_buf_operations page_cache_pipe_buf_ops = {
 	.can_merge = 0,
 	.map = generic_pipe_buf_map,
@@ -133,6 +139,16 @@ static struct pipe_buf_operations page_c
 	.get = generic_pipe_buf_get,
 };
 
+static struct pipe_buf_operations sock_buf_ops = {
+	.can_merge = 0,
+	.map = generic_pipe_buf_map,
+	.unmap = generic_pipe_buf_unmap,
+	.pin = generic_pipe_buf_pin,
+	.release = generic_sock_buf_release,
+	.steal = generic_pipe_buf_steal,
+	.get = generic_pipe_buf_get,
+};
+
 static int user_page_pipe_buf_steal(struct pipe_inode_info *pipe,
 				    struct pipe_buffer *buf)
 {
diff --git a/include/linux/net.h b/include/linux/net.h
index b20c53c..65dfe0c 100644
--- a/include/linux/net.h
+++ b/include/linux/net.h
@@ -164,6 +164,8 @@ struct proto_ops {
 				      struct vm_area_struct * vma);
 	ssize_t		(*sendpage)  (struct socket *sock, struct page *page,
 				      int offset, size_t size, int flags);
+	ssize_t 	(*splice_read)(struct socket *sock,  loff_t *ppos,
+				       struct pipe_inode_info *pipe, size_t len, unsigned int flags);
 };
 
 struct net_proto_family {
diff --git a/include/linux/pipe_fs_i.h b/include/linux/pipe_fs_i.h
index 9067985..f7f439b 100644
--- a/include/linux/pipe_fs_i.h
+++ b/include/linux/pipe_fs_i.h
@@ -72,6 +72,7 @@ void generic_pipe_buf_get(struct pipe_in
 int generic_pipe_buf_pin(struct pipe_inode_info *, struct pipe_buffer *);
 int generic_pipe_buf_steal(struct pipe_inode_info *, struct pipe_buffer *);
 
+void generic_sock_buf_release(struct pipe_inode_info *, struct pipe_buffer *);
 /*
  * splice is tied to pipes as a transport (at least for now), so we'll just
  * add the splice flags here.
diff --git a/include/net/tcp.h b/include/net/tcp.h
index 7a093d0..5032501 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -300,6 +300,9 @@ extern void			tcp_cleanup_rbuf(struct so
 extern int			tcp_twsk_unique(struct sock *sk,
 						struct sock *sktw, void *twp);
 
+extern ssize_t			tcp_splice_read(struct socket *sk, loff_t *ppos,
+					        struct pipe_inode_info *pipe, size_t len, unsigned int flags);
+
 static inline void tcp_dec_quickack_mode(struct sock *sk,
 					 const unsigned int pkts)
 {
diff --git a/net/socket.c b/net/socket.c
index 6d261bf..8a4f602 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -117,6 +117,8 @@ static ssize_t sock_writev(struct file *
 			  unsigned long count, loff_t *ppos);
 static ssize_t sock_sendpage(struct file *file, struct page *page,
 			     int offset, size_t size, loff_t *ppos, int more);
+static ssize_t sock_splice_read(struct file *file, loff_t *ppos,
+			        struct pipe_inode_info *pipe, size_t len, unsigned int flags);
 
 /*
  *	Socket files have a set of 'special' operations as well as the generic file ones. These don't appear
@@ -141,6 +143,7 @@ static struct file_operations socket_fil
 	.writev =	sock_writev,
 	.sendpage =	sock_sendpage,
 	.splice_write = generic_splice_sendpage,
+	.splice_read =	sock_splice_read,
 };
 
 /*
@@ -701,6 +704,16 @@ static ssize_t sock_sendpage(struct file
 	return sock->ops->sendpage(sock, page, offset, size, flags);
 }
 
+static ssize_t sock_splice_read(struct file *file, loff_t *ppos,
+			        struct pipe_inode_info *pipe, size_t len, unsigned int flags)
+{
+	struct socket *sock;
+
+	sock = file->private_data;
+
+	return sock->ops->splice_read(sock, ppos, pipe, len, flags);
+}
+
 static struct sock_iocb *alloc_sock_iocb(struct kiocb *iocb,
 		char __user *ubuf, size_t size, struct sock_iocb *siocb)
 {

