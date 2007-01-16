Return-Path: <linux-kernel-owner+w=401wt.eu-S932257AbXAPCDh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932257AbXAPCDh (ORCPT <rfc822;w@1wt.eu>);
	Mon, 15 Jan 2007 21:03:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932248AbXAPCDf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Jan 2007 21:03:35 -0500
Received: from 64.221.212.177.ptr.us.xo.net ([64.221.212.177]:25129 "EHLO
	ext.agami.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932224AbXAPCD3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Jan 2007 21:03:29 -0500
X-Greylist: delayed 510 seconds by postgrey-1.27 at vger.kernel.org; Mon, 15 Jan 2007 21:03:27 EST
From: Nate Diller <nate@agami.com>
To: Nate Diller <nate.diller@gmail.com>, Andrew Morton <akpm@osdl.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       Benjamin LaHaise <bcrl@kvack.org>,
       Alexander Viro <viro@zeniv.linux.org.uk>,
       Suparna Bhattacharya <suparna@in.ibm.com>,
       Kenneth W Chen <kenneth.w.chen@intel.com>,
       David Brownell <dbrownell@users.sourceforge.net>,
       Christoph Hellwig <hch@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       netdev@vger.kernel.org, ocfs2-devel@oss.oracle.com, linux-aio@kvack.org,
       xfs-masters@oss.sgi.com
Date: Mon, 15 Jan 2007 17:54:50 -0800
Message-Id: <20070116015450.9764.34762.patchbomb.py@nate-64.agami.com>
In-Reply-To: <20070116015450.9764.37697.patchbomb.py@nate-64.agami.com>
Subject: [PATCH -mm 1/10][RFC] aio: scm remove struct siocb
X-OriginalArrivalTime: 16 Jan 2007 01:54:55.0956 (UTC) FILETIME=[5231A140:01C73911]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

this patch removes struct sock_iocb

Its purpose seems to have dwindled to a mere container for struct
scm_cookie, and all of the users of scm_cookie seem to require
re-initializing it each time anyway.  Besides, keeping such data around from
one call to the next seems to me like a layering violation, if not a bug,
considering that the sync IO code can use this call path too.

All scm_cookie users are converted to unconditionally allocate on the stack,
and sock_iocb and all its helpers are removed.  This also simplifies the
socket aio submission path (is that even used?)

---

 include/net/scm.h        |    2 
 include/net/sock.h       |   26 ---------
 net/netlink/af_netlink.c |   18 ++----
 net/socket.c             |  131 +++++++++++------------------------------------
 net/unix/af_unix.c       |   77 ++++++++++-----------------
 5 files changed, 68 insertions(+), 186 deletions(-)

---

diff -urpN -X dontdiff a/include/net/scm.h b/include/net/scm.h
--- a/include/net/scm.h	2006-11-29 13:57:37.000000000 -0800
+++ b/include/net/scm.h	2007-01-10 12:10:19.000000000 -0800
@@ -23,7 +23,6 @@ struct scm_cookie
 #ifdef CONFIG_SECURITY_NETWORK
 	u32			secid;		/* Passed security ID 	*/
 #endif
-	unsigned long		seq;		/* Connection seqno	*/
 };
 
 extern void scm_detach_fds(struct msghdr *msg, struct scm_cookie *scm);
@@ -56,7 +55,6 @@ static __inline__ int scm_send(struct so
 	scm->creds.gid = p->gid;
 	scm->creds.pid = p->tgid;
 	scm->fp = NULL;
-	scm->seq = 0;
 	unix_get_peersec_dgram(sock, scm);
 	if (msg->msg_controllen <= 0)
 		return 0;
diff -urpN -X dontdiff a/include/net/sock.h b/include/net/sock.h
--- a/include/net/sock.h	2007-01-10 11:50:54.000000000 -0800
+++ b/include/net/sock.h	2007-01-10 12:15:35.000000000 -0800
@@ -75,10 +75,9 @@
  * between user contexts and software interrupt processing, whereas the
  * mini-semaphore synchronizes multiple users amongst themselves.
  */
-struct sock_iocb;
 typedef struct {
 	spinlock_t		slock;
-	struct sock_iocb	*owner;
+	void			*owner;
 	wait_queue_head_t	wq;
 	/*
 	 * We express the mutex-alike socket_lock semantics
@@ -656,29 +655,6 @@ static inline void __sk_prot_rehash(stru
 #define SOCK_BINDADDR_LOCK	4
 #define SOCK_BINDPORT_LOCK	8
 
-/* sock_iocb: used to kick off async processing of socket ios */
-struct sock_iocb {
-	struct list_head	list;
-
-	int			flags;
-	int			size;
-	struct socket		*sock;
-	struct sock		*sk;
-	struct scm_cookie	*scm;
-	struct msghdr		*msg, async_msg;
-	struct kiocb		*kiocb;
-};
-
-static inline struct sock_iocb *kiocb_to_siocb(struct kiocb *iocb)
-{
-	return (struct sock_iocb *)iocb->private;
-}
-
-static inline struct kiocb *siocb_to_kiocb(struct sock_iocb *si)
-{
-	return si->kiocb;
-}
-
 struct socket_alloc {
 	struct socket socket;
 	struct inode vfs_inode;
diff -urpN -X dontdiff a/net/netlink/af_netlink.c b/net/netlink/af_netlink.c
--- a/net/netlink/af_netlink.c	2007-01-10 11:53:12.000000000 -0800
+++ b/net/netlink/af_netlink.c	2007-01-10 12:10:19.000000000 -0800
@@ -1106,7 +1106,6 @@ static inline void netlink_rcv_wake(stru
 static int netlink_sendmsg(struct kiocb *kiocb, struct socket *sock,
 			   struct msghdr *msg, size_t len)
 {
-	struct sock_iocb *siocb = kiocb_to_siocb(kiocb);
 	struct sock *sk = sock->sk;
 	struct netlink_sock *nlk = nlk_sk(sk);
 	struct sockaddr_nl *addr=msg->msg_name;
@@ -1119,9 +1118,7 @@ static int netlink_sendmsg(struct kiocb 
 	if (msg->msg_flags&MSG_OOB)
 		return -EOPNOTSUPP;
 
-	if (NULL == siocb->scm)
-		siocb->scm = &scm;
-	err = scm_send(sock, msg, siocb->scm);
+	err = scm_send(sock, msg, &scm);
 	if (err < 0)
 		return err;
 
@@ -1155,7 +1152,7 @@ static int netlink_sendmsg(struct kiocb 
 	NETLINK_CB(skb).dst_group = dst_group;
 	NETLINK_CB(skb).loginuid = audit_get_loginuid(current->audit_context);
 	selinux_get_task_sid(current, &(NETLINK_CB(skb).sid));
-	memcpy(NETLINK_CREDS(skb), &siocb->scm->creds, sizeof(struct ucred));
+	memcpy(NETLINK_CREDS(skb), &scm.creds, sizeof(struct ucred));
 
 	/* What can I do? Netlink is asynchronous, so that
 	   we will have to save current capabilities to
@@ -1189,7 +1186,6 @@ static int netlink_recvmsg(struct kiocb 
 			   struct msghdr *msg, size_t len,
 			   int flags)
 {
-	struct sock_iocb *siocb = kiocb_to_siocb(kiocb);
 	struct scm_cookie scm;
 	struct sock *sk = sock->sk;
 	struct netlink_sock *nlk = nlk_sk(sk);
@@ -1230,17 +1226,15 @@ static int netlink_recvmsg(struct kiocb 
 	if (nlk->flags & NETLINK_RECV_PKTINFO)
 		netlink_cmsg_recv_pktinfo(msg, skb);
 
-	if (NULL == siocb->scm) {
-		memset(&scm, 0, sizeof(scm));
-		siocb->scm = &scm;
-	}
-	siocb->scm->creds = *NETLINK_CREDS(skb);
+	memset(&scm, 0, sizeof(scm));
+
+	scm.creds = *NETLINK_CREDS(skb);
 	skb_free_datagram(sk, skb);
 
 	if (nlk->cb && atomic_read(&sk->sk_rmem_alloc) <= sk->sk_rcvbuf / 2)
 		netlink_dump(sk);
 
-	scm_recv(sock, msg, siocb->scm, flags);
+	scm_recv(sock, msg, &scm, flags);
 
 out:
 	netlink_rcv_wake(sk);
diff -urpN -X dontdiff a/net/socket.c b/net/socket.c
--- a/net/socket.c	2007-01-10 11:51:10.000000000 -0800
+++ b/net/socket.c	2007-01-10 12:10:19.000000000 -0800
@@ -551,14 +551,8 @@ void sock_release(struct socket *sock)
 static inline int __sock_sendmsg(struct kiocb *iocb, struct socket *sock,
 				 struct msghdr *msg, size_t size)
 {
-	struct sock_iocb *si = kiocb_to_siocb(iocb);
 	int err;
 
-	si->sock = sock;
-	si->scm = NULL;
-	si->msg = msg;
-	si->size = size;
-
 	err = security_socket_sendmsg(sock, msg, size);
 	if (err)
 		return err;
@@ -569,15 +563,9 @@ static inline int __sock_sendmsg(struct 
 int sock_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
 {
 	struct kiocb iocb;
-	struct sock_iocb siocb;
-	int ret;
 
 	init_sync_kiocb(&iocb, NULL);
-	iocb.private = &siocb;
-	ret = __sock_sendmsg(&iocb, sock, msg, size);
-	if (-EIOCBQUEUED == ret)
-		ret = wait_on_sync_kiocb(&iocb);
-	return ret;
+	return __sock_sendmsg(&iocb, sock, msg, size);
 }
 
 int kernel_sendmsg(struct socket *sock, struct msghdr *msg,
@@ -602,13 +590,6 @@ static inline int __sock_recvmsg(struct 
 				 struct msghdr *msg, size_t size, int flags)
 {
 	int err;
-	struct sock_iocb *si = kiocb_to_siocb(iocb);
-
-	si->sock = sock;
-	si->scm = NULL;
-	si->msg = msg;
-	si->size = size;
-	si->flags = flags;
 
 	err = security_socket_recvmsg(sock, msg, size, flags);
 	if (err)
@@ -621,15 +602,9 @@ int sock_recvmsg(struct socket *sock, st
 		 size_t size, int flags)
 {
 	struct kiocb iocb;
-	struct sock_iocb siocb;
-	int ret;
 
 	init_sync_kiocb(&iocb, NULL);
-	iocb.private = &siocb;
-	ret = __sock_recvmsg(&iocb, sock, msg, size, flags);
-	if (-EIOCBQUEUED == ret)
-		ret = wait_on_sync_kiocb(&iocb);
-	return ret;
+	return __sock_recvmsg(&iocb, sock, msg, size, flags);
 }
 
 int kernel_recvmsg(struct socket *sock, struct msghdr *msg,
@@ -649,11 +624,6 @@ int kernel_recvmsg(struct socket *sock, 
 	return result;
 }
 
-static void sock_aio_dtor(struct kiocb *iocb)
-{
-	kfree(iocb->private);
-}
-
 static ssize_t sock_sendpage(struct file *file, struct page *page,
 			     int offset, size_t size, loff_t *ppos, int more)
 {
@@ -669,47 +639,13 @@ static ssize_t sock_sendpage(struct file
 	return sock->ops->sendpage(sock, page, offset, size, flags);
 }
 
-static struct sock_iocb *alloc_sock_iocb(struct kiocb *iocb,
-					 struct sock_iocb *siocb)
-{
-	if (!is_sync_kiocb(iocb)) {
-		siocb = kmalloc(sizeof(*siocb), GFP_KERNEL);
-		if (!siocb)
-			return NULL;
-		iocb->ki_dtor = sock_aio_dtor;
-	}
-
-	siocb->kiocb = iocb;
-	iocb->private = siocb;
-	return siocb;
-}
-
-static ssize_t do_sock_read(struct msghdr *msg, struct kiocb *iocb,
-		struct file *file, const struct iovec *iov,
-		unsigned long nr_segs)
-{
-	struct socket *sock = file->private_data;
-	size_t size = 0;
-	int i;
-
-	for (i = 0; i < nr_segs; i++)
-		size += iov[i].iov_len;
-
-	msg->msg_name = NULL;
-	msg->msg_namelen = 0;
-	msg->msg_control = NULL;
-	msg->msg_controllen = 0;
-	msg->msg_iov = (struct iovec *)iov;
-	msg->msg_iovlen = nr_segs;
-	msg->msg_flags = (file->f_flags & O_NONBLOCK) ? MSG_DONTWAIT : 0;
-
-	return __sock_recvmsg(iocb, sock, msg, size, msg->msg_flags);
-}
-
 static ssize_t sock_aio_read(struct kiocb *iocb, const struct iovec *iov,
 				unsigned long nr_segs, loff_t pos)
 {
-	struct sock_iocb siocb, *x;
+	struct msghdr msg;
+	struct socket *sock = iocb->ki_filp->private_data;
+	size_t size = 0;
+	int i;
 
 	if (pos != 0)
 		return -ESPIPE;
@@ -717,41 +653,27 @@ static ssize_t sock_aio_read(struct kioc
 	if (iocb->ki_left == 0)	/* Match SYS5 behaviour */
 		return 0;
 
-
-	x = alloc_sock_iocb(iocb, &siocb);
-	if (!x)
-		return -ENOMEM;
-	return do_sock_read(&x->async_msg, iocb, iocb->ki_filp, iov, nr_segs);
-}
-
-static ssize_t do_sock_write(struct msghdr *msg, struct kiocb *iocb,
-			struct file *file, const struct iovec *iov,
-			unsigned long nr_segs)
-{
-	struct socket *sock = file->private_data;
-	size_t size = 0;
-	int i;
-
 	for (i = 0; i < nr_segs; i++)
 		size += iov[i].iov_len;
 
-	msg->msg_name = NULL;
-	msg->msg_namelen = 0;
-	msg->msg_control = NULL;
-	msg->msg_controllen = 0;
-	msg->msg_iov = (struct iovec *)iov;
-	msg->msg_iovlen = nr_segs;
-	msg->msg_flags = (file->f_flags & O_NONBLOCK) ? MSG_DONTWAIT : 0;
-	if (sock->type == SOCK_SEQPACKET)
-		msg->msg_flags |= MSG_EOR;
+	msg.msg_name = NULL;
+	msg.msg_namelen = 0;
+	msg.msg_control = NULL;
+	msg.msg_controllen = 0;
+	msg.msg_iov = (struct iovec *)iov;
+	msg.msg_iovlen = nr_segs;
+	msg.msg_flags = (iocb->ki_filp->f_flags & O_NONBLOCK) ? MSG_DONTWAIT : 0;
 
-	return __sock_sendmsg(iocb, sock, msg, size);
+	return __sock_recvmsg(iocb, sock, &msg, size, msg.msg_flags);
 }
 
 static ssize_t sock_aio_write(struct kiocb *iocb, const struct iovec *iov,
 			  unsigned long nr_segs, loff_t pos)
 {
-	struct sock_iocb siocb, *x;
+	struct msghdr msg;
+	struct socket *sock = iocb->ki_filp->private_data;
+	size_t size = 0;
+	int i;
 
 	if (pos != 0)
 		return -ESPIPE;
@@ -759,11 +681,20 @@ static ssize_t sock_aio_write(struct kio
 	if (iocb->ki_left == 0)	/* Match SYS5 behaviour */
 		return 0;
 
-	x = alloc_sock_iocb(iocb, &siocb);
-	if (!x)
-		return -ENOMEM;
+	for (i = 0; i < nr_segs; i++)
+		size += iov[i].iov_len;
+
+	msg.msg_name = NULL;
+	msg.msg_namelen = 0;
+	msg.msg_control = NULL;
+	msg.msg_controllen = 0;
+	msg.msg_iov = (struct iovec *)iov;
+	msg.msg_iovlen = nr_segs;
+	msg.msg_flags = (iocb->ki_filp->f_flags & O_NONBLOCK) ? MSG_DONTWAIT : 0;
+	if (sock->type == SOCK_SEQPACKET)
+		msg.msg_flags |= MSG_EOR;
 
-	return do_sock_write(&x->async_msg, iocb, iocb->ki_filp, iov, nr_segs);
+	return __sock_sendmsg(iocb, sock, &msg, size);
 }
 
 /*
diff -urpN -X dontdiff a/net/unix/af_unix.c b/net/unix/af_unix.c
--- a/net/unix/af_unix.c	2007-01-10 11:51:11.000000000 -0800
+++ b/net/unix/af_unix.c	2007-01-10 12:10:19.000000000 -0800
@@ -1267,7 +1267,6 @@ static void unix_attach_fds(struct scm_c
 static int unix_dgram_sendmsg(struct kiocb *kiocb, struct socket *sock,
 			      struct msghdr *msg, size_t len)
 {
-	struct sock_iocb *siocb = kiocb_to_siocb(kiocb);
 	struct sock *sk = sock->sk;
 	struct unix_sock *u = unix_sk(sk);
 	struct sockaddr_un *sunaddr=msg->msg_name;
@@ -1277,11 +1276,9 @@ static int unix_dgram_sendmsg(struct kio
 	unsigned hash;
 	struct sk_buff *skb;
 	long timeo;
-	struct scm_cookie tmp_scm;
+	struct scm_cookie scm;
 
-	if (NULL == siocb->scm)
-		siocb->scm = &tmp_scm;
-	err = scm_send(sock, msg, siocb->scm);
+	err = scm_send(sock, msg, &scm);
 	if (err < 0)
 		return err;
 
@@ -1314,10 +1311,10 @@ static int unix_dgram_sendmsg(struct kio
 	if (skb==NULL)
 		goto out;
 
-	memcpy(UNIXCREDS(skb), &siocb->scm->creds, sizeof(struct ucred));
-	if (siocb->scm->fp)
-		unix_attach_fds(siocb->scm, skb);
-	unix_get_secdata(siocb->scm, skb);
+	memcpy(UNIXCREDS(skb), &scm.creds, sizeof(struct ucred));
+	if (scm.fp)
+		unix_attach_fds(&scm, skb);
+	unix_get_secdata(&scm, skb);
 
 	skb->h.raw = skb->data;
 	err = memcpy_fromiovec(skb_put(skb,len), msg->msg_iov, len);
@@ -1401,7 +1398,7 @@ restart:
 	unix_state_runlock(other);
 	other->sk_data_ready(other, len);
 	sock_put(other);
-	scm_destroy(siocb->scm);
+	scm_destroy(&scm);
 	return len;
 
 out_unlock:
@@ -1411,7 +1408,7 @@ out_free:
 out:
 	if (other)
 		sock_put(other);
-	scm_destroy(siocb->scm);
+	scm_destroy(&scm);
 	return err;
 }
 
@@ -1419,18 +1416,15 @@ out:
 static int unix_stream_sendmsg(struct kiocb *kiocb, struct socket *sock,
 			       struct msghdr *msg, size_t len)
 {
-	struct sock_iocb *siocb = kiocb_to_siocb(kiocb);
 	struct sock *sk = sock->sk;
 	struct sock *other = NULL;
 	struct sockaddr_un *sunaddr=msg->msg_name;
 	int err,size;
 	struct sk_buff *skb;
 	int sent=0;
-	struct scm_cookie tmp_scm;
+	struct scm_cookie scm;
 
-	if (NULL == siocb->scm)
-		siocb->scm = &tmp_scm;
-	err = scm_send(sock, msg, siocb->scm);
+	err = scm_send(sock, msg, &scm);
 	if (err < 0)
 		return err;
 
@@ -1486,9 +1480,9 @@ static int unix_stream_sendmsg(struct ki
 		 */
 		size = min_t(int, size, skb_tailroom(skb));
 
-		memcpy(UNIXCREDS(skb), &siocb->scm->creds, sizeof(struct ucred));
-		if (siocb->scm->fp)
-			unix_attach_fds(siocb->scm, skb);
+		memcpy(UNIXCREDS(skb), &scm.creds, sizeof(struct ucred));
+		if (scm.fp)
+			unix_attach_fds(&scm, skb);
 
 		if ((err = memcpy_fromiovec(skb_put(skb,size), msg->msg_iov, size)) != 0) {
 			kfree_skb(skb);
@@ -1507,9 +1501,7 @@ static int unix_stream_sendmsg(struct ki
 		sent+=size;
 	}
 
-	scm_destroy(siocb->scm);
-	siocb->scm = NULL;
-
+	scm_destroy(&scm);
 	return sent;
 
 pipe_err_free:
@@ -1520,8 +1512,7 @@ pipe_err:
 		send_sig(SIGPIPE,current,0);
 	err = -EPIPE;
 out_err:
-	scm_destroy(siocb->scm);
-	siocb->scm = NULL;
+	scm_destroy(&scm);
 	return sent ? : err;
 }
 
@@ -1559,8 +1550,7 @@ static int unix_dgram_recvmsg(struct kio
 			      struct msghdr *msg, size_t size,
 			      int flags)
 {
-	struct sock_iocb *siocb = kiocb_to_siocb(iocb);
-	struct scm_cookie tmp_scm;
+	struct scm_cookie scm;
 	struct sock *sk = sock->sk;
 	struct unix_sock *u = unix_sk(sk);
 	int noblock = flags & MSG_DONTWAIT;
@@ -1593,17 +1583,14 @@ static int unix_dgram_recvmsg(struct kio
 	if (err)
 		goto out_free;
 
-	if (!siocb->scm) {
-		siocb->scm = &tmp_scm;
-		memset(&tmp_scm, 0, sizeof(tmp_scm));
-	}
-	siocb->scm->creds = *UNIXCREDS(skb);
-	unix_set_secdata(siocb->scm, skb);
+	memset(&scm, 0, sizeof(scm));
+	scm.creds = *UNIXCREDS(skb);
+	unix_set_secdata(&scm, skb);
 
 	if (!(flags & MSG_PEEK))
 	{
 		if (UNIXCB(skb).fp)
-			unix_detach_fds(siocb->scm, skb);
+			unix_detach_fds(&scm, skb);
 	}
 	else 
 	{
@@ -1620,11 +1607,11 @@ static int unix_dgram_recvmsg(struct kio
 		   
 		*/
 		if (UNIXCB(skb).fp)
-			siocb->scm->fp = scm_fp_dup(UNIXCB(skb).fp);
+			scm.fp = scm_fp_dup(UNIXCB(skb).fp);
 	}
 	err = size;
 
-	scm_recv(sock, msg, siocb->scm, flags);
+	scm_recv(sock, msg, &scm, flags);
 
 out_free:
 	skb_free_datagram(sk,skb);
@@ -1672,8 +1659,7 @@ static int unix_stream_recvmsg(struct ki
 			       struct msghdr *msg, size_t size,
 			       int flags)
 {
-	struct sock_iocb *siocb = kiocb_to_siocb(iocb);
-	struct scm_cookie tmp_scm;
+	struct scm_cookie scm;
 	struct sock *sk = sock->sk;
 	struct unix_sock *u = unix_sk(sk);
 	struct sockaddr_un *sunaddr=msg->msg_name;
@@ -1700,10 +1686,7 @@ static int unix_stream_recvmsg(struct ki
 	 * while sleeps in memcpy_tomsg
 	 */
 
-	if (!siocb->scm) {
-		siocb->scm = &tmp_scm;
-		memset(&tmp_scm, 0, sizeof(tmp_scm));
-	}
+	memset(&scm, 0, sizeof(scm));
 
 	mutex_lock(&u->readlock);
 
@@ -1743,13 +1726,13 @@ static int unix_stream_recvmsg(struct ki
 
 		if (check_creds) {
 			/* Never glue messages from different writers */
-			if (memcmp(UNIXCREDS(skb), &siocb->scm->creds, sizeof(siocb->scm->creds)) != 0) {
+			if (memcmp(UNIXCREDS(skb), &scm.creds, sizeof(scm.creds)) != 0) {
 				skb_queue_head(&sk->sk_receive_queue, skb);
 				break;
 			}
 		} else {
 			/* Copy credentials */
-			siocb->scm->creds = *UNIXCREDS(skb);
+			scm.creds = *UNIXCREDS(skb);
 			check_creds = 1;
 		}
 
@@ -1776,7 +1759,7 @@ static int unix_stream_recvmsg(struct ki
 			skb_pull(skb, chunk);
 
 			if (UNIXCB(skb).fp)
-				unix_detach_fds(siocb->scm, skb);
+				unix_detach_fds(&scm, skb);
 
 			/* put the skb back if we didn't use it up.. */
 			if (skb->len)
@@ -1787,7 +1770,7 @@ static int unix_stream_recvmsg(struct ki
 
 			kfree_skb(skb);
 
-			if (siocb->scm->fp)
+			if (scm.fp)
 				break;
 		}
 		else
@@ -1795,7 +1778,7 @@ static int unix_stream_recvmsg(struct ki
 			/* It is questionable, see note in unix_dgram_recvmsg.
 			 */
 			if (UNIXCB(skb).fp)
-				siocb->scm->fp = scm_fp_dup(UNIXCB(skb).fp);
+				scm.fp = scm_fp_dup(UNIXCB(skb).fp);
 
 			/* put message back and return */
 			skb_queue_head(&sk->sk_receive_queue, skb);
@@ -1804,7 +1787,7 @@ static int unix_stream_recvmsg(struct ki
 	} while (size);
 
 	mutex_unlock(&u->readlock);
-	scm_recv(sock, msg, siocb->scm, flags);
+	scm_recv(sock, msg, &scm, flags);
 out:
 	return copied ? : err;
 }
