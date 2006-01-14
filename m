Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932174AbWANPku@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932174AbWANPku (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jan 2006 10:40:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932161AbWANPku
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jan 2006 10:40:50 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:30864 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932174AbWANPkt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jan 2006 10:40:49 -0500
Date: Sat, 14 Jan 2006 16:41:03 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org,
       vandrove@vc.cvut.cz
Subject: [patch 2.6.15-mm4] sem2mutex: NCPFS
Message-ID: <20060114154103.GA30432@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ingo Molnar <mingo@elte.hu>

semaphore to mutex conversion.

the conversion was generated via scripts, and the result was validated
automatically via a script as well.

build tested.

Signed-off-by: Ingo Molnar <mingo@elte.hu>
----

 fs/ncpfs/file.c           |    4 ++--
 fs/ncpfs/inode.c          |    6 +++---
 fs/ncpfs/ncplib_kernel.c  |    4 ++--
 fs/ncpfs/sock.c           |   34 +++++++++++++++++-----------------
 include/linux/ncp_fs_i.h  |    2 +-
 include/linux/ncp_fs_sb.h |    5 +++--
 6 files changed, 28 insertions(+), 27 deletions(-)

Index: linux/fs/ncpfs/file.c
===================================================================
--- linux.orig/fs/ncpfs/file.c
+++ linux/fs/ncpfs/file.c
@@ -46,7 +46,7 @@ int ncp_make_open(struct inode *inode, i
 		NCP_FINFO(inode)->volNumber, 
 		NCP_FINFO(inode)->dirEntNum);
 	error = -EACCES;
-	down(&NCP_FINFO(inode)->open_sem);
+	mutex_lock(&NCP_FINFO(inode)->open_mutex);
 	if (!atomic_read(&NCP_FINFO(inode)->opened)) {
 		struct ncp_entry_info finfo;
 		int result;
@@ -93,7 +93,7 @@ int ncp_make_open(struct inode *inode, i
 	}
 
 out_unlock:
-	up(&NCP_FINFO(inode)->open_sem);
+	mutex_unlock(&NCP_FINFO(inode)->open_mutex);
 out:
 	return error;
 }
Index: linux/fs/ncpfs/inode.c
===================================================================
--- linux.orig/fs/ncpfs/inode.c
+++ linux/fs/ncpfs/inode.c
@@ -63,7 +63,7 @@ static void init_once(void * foo, kmem_c
 
 	if ((flags & (SLAB_CTOR_VERIFY|SLAB_CTOR_CONSTRUCTOR)) ==
 	    SLAB_CTOR_CONSTRUCTOR) {
-		init_MUTEX(&ei->open_sem);
+		mutex_init(&ei->open_mutex);
 		inode_init_once(&ei->vfs_inode);
 	}
 }
@@ -520,7 +520,7 @@ static int ncp_fill_super(struct super_b
 	}
 
 /*	server->lock = 0;	*/
-	init_MUTEX(&server->sem);
+	mutex_init(&server->mutex);
 	server->packet = NULL;
 /*	server->buffer_size = 0;	*/
 /*	server->conn_status = 0;	*/
@@ -557,7 +557,7 @@ static int ncp_fill_super(struct super_b
 	server->dentry_ttl = 0;	/* no caching */
 
 	INIT_LIST_HEAD(&server->tx.requests);
-	init_MUTEX(&server->rcv.creq_sem);
+	mutex_init(&server->rcv.creq_mutex);
 	server->tx.creq		= NULL;
 	server->rcv.creq	= NULL;
 	server->data_ready	= sock->sk->sk_data_ready;
Index: linux/fs/ncpfs/ncplib_kernel.c
===================================================================
--- linux.orig/fs/ncpfs/ncplib_kernel.c
+++ linux/fs/ncpfs/ncplib_kernel.c
@@ -291,7 +291,7 @@ ncp_make_closed(struct inode *inode)
 	int err;
 
 	err = 0;
-	down(&NCP_FINFO(inode)->open_sem);	
+	mutex_lock(&NCP_FINFO(inode)->open_mutex);
 	if (atomic_read(&NCP_FINFO(inode)->opened) == 1) {
 		atomic_set(&NCP_FINFO(inode)->opened, 0);
 		err = ncp_close_file(NCP_SERVER(inode), NCP_FINFO(inode)->file_handle);
@@ -301,7 +301,7 @@ ncp_make_closed(struct inode *inode)
 				NCP_FINFO(inode)->volNumber,
 				NCP_FINFO(inode)->dirEntNum, err);
 	}
-	up(&NCP_FINFO(inode)->open_sem);
+	mutex_unlock(&NCP_FINFO(inode)->open_mutex);
 	return err;
 }
 
Index: linux/fs/ncpfs/sock.c
===================================================================
--- linux.orig/fs/ncpfs/sock.c
+++ linux/fs/ncpfs/sock.c
@@ -171,9 +171,9 @@ static inline void __ncp_abort_request(s
 
 static inline void ncp_abort_request(struct ncp_server *server, struct ncp_request_reply *req, int err)
 {
-	down(&server->rcv.creq_sem);
+	mutex_lock(&server->rcv.creq_mutex);
 	__ncp_abort_request(server, req, err);
-	up(&server->rcv.creq_sem);
+	mutex_unlock(&server->rcv.creq_mutex);
 }
 
 static inline void __ncptcp_abort(struct ncp_server *server)
@@ -303,20 +303,20 @@ static inline void __ncp_start_request(s
 
 static int ncp_add_request(struct ncp_server *server, struct ncp_request_reply *req)
 {
-	down(&server->rcv.creq_sem);
+	mutex_lock(&server->rcv.creq_mutex);
 	if (!ncp_conn_valid(server)) {
-		up(&server->rcv.creq_sem);
+		mutex_unlock(&server->rcv.creq_mutex);
 		printk(KERN_ERR "ncpfs: tcp: Server died\n");
 		return -EIO;
 	}
 	if (server->tx.creq || server->rcv.creq) {
 		req->status = RQ_QUEUED;
 		list_add_tail(&req->req, &server->tx.requests);
-		up(&server->rcv.creq_sem);
+		mutex_unlock(&server->rcv.creq_mutex);
 		return 0;
 	}
 	__ncp_start_request(server, req);
-	up(&server->rcv.creq_sem);
+	mutex_unlock(&server->rcv.creq_mutex);
 	return 0;
 }
 
@@ -400,7 +400,7 @@ void ncpdgram_rcv_proc(void *s)
 				info_server(server, 0, server->unexpected_packet.data, result);
 				continue;
 			}
-			down(&server->rcv.creq_sem);		
+			mutex_lock(&server->rcv.creq_mutex);
 			req = server->rcv.creq;
 			if (req && (req->tx_type == NCP_ALLOC_SLOT_REQUEST || (server->sequence == reply.sequence && 
 					server->connection == get_conn_number(&reply)))) {
@@ -430,11 +430,11 @@ void ncpdgram_rcv_proc(void *s)
 				     	server->rcv.creq = NULL;
 					ncp_finish_request(req, result);
 					__ncp_next_request(server);
-					up(&server->rcv.creq_sem);
+					mutex_unlock(&server->rcv.creq_mutex);
 					continue;
 				}
 			}
-			up(&server->rcv.creq_sem);
+			mutex_unlock(&server->rcv.creq_mutex);
 		}
 drop:;		
 		_recv(sock, &reply, sizeof(reply), MSG_DONTWAIT);
@@ -472,9 +472,9 @@ static void __ncpdgram_timeout_proc(stru
 void ncpdgram_timeout_proc(void *s)
 {
 	struct ncp_server *server = s;
-	down(&server->rcv.creq_sem);
+	mutex_lock(&server->rcv.creq_mutex);
 	__ncpdgram_timeout_proc(server);
-	up(&server->rcv.creq_sem);
+	mutex_unlock(&server->rcv.creq_mutex);
 }
 
 static inline void ncp_init_req(struct ncp_request_reply* req)
@@ -657,18 +657,18 @@ void ncp_tcp_rcv_proc(void *s)
 {
 	struct ncp_server *server = s;
 
-	down(&server->rcv.creq_sem);
+	mutex_lock(&server->rcv.creq_mutex);
 	__ncptcp_rcv_proc(server);
-	up(&server->rcv.creq_sem);
+	mutex_unlock(&server->rcv.creq_mutex);
 }
 
 void ncp_tcp_tx_proc(void *s)
 {
 	struct ncp_server *server = s;
 	
-	down(&server->rcv.creq_sem);
+	mutex_lock(&server->rcv.creq_mutex);
 	__ncptcp_try_send(server);
-	up(&server->rcv.creq_sem);
+	mutex_unlock(&server->rcv.creq_mutex);
 }
 
 static int do_ncp_rpc_call(struct ncp_server *server, int size,
@@ -833,7 +833,7 @@ int ncp_disconnect(struct ncp_server *se
 
 void ncp_lock_server(struct ncp_server *server)
 {
-	down(&server->sem);
+	mutex_lock(&server->mutex);
 	if (server->lock)
 		printk(KERN_WARNING "ncp_lock_server: was locked!\n");
 	server->lock = 1;
@@ -846,5 +846,5 @@ void ncp_unlock_server(struct ncp_server
 		return;
 	}
 	server->lock = 0;
-	up(&server->sem);
+	mutex_unlock(&server->mutex);
 }
Index: linux/include/linux/ncp_fs_i.h
===================================================================
--- linux.orig/include/linux/ncp_fs_i.h
+++ linux/include/linux/ncp_fs_i.h
@@ -19,7 +19,7 @@ struct ncp_inode_info {
 	__le32	DosDirNum;
 	__u8	volNumber;
 	__le32	nwattr;
-	struct semaphore open_sem;
+	struct mutex open_mutex;
 	atomic_t	opened;
 	int	access;
 	int	flags;
Index: linux/include/linux/ncp_fs_sb.h
===================================================================
--- linux.orig/include/linux/ncp_fs_sb.h
+++ linux/include/linux/ncp_fs_sb.h
@@ -11,6 +11,7 @@
 #include <linux/types.h>
 #include <linux/ncp_mount.h>
 #include <linux/net.h>
+#include <linux/mutex.h>
 
 #ifdef __KERNEL__
 
@@ -51,7 +52,7 @@ struct ncp_server {
 				   receive replies */
 
 	int lock;		/* To prevent mismatch in protocols. */
-	struct semaphore sem;
+	struct mutex mutex;
 
 	int current_size;	/* for packet preparation */
 	int has_subfunction;
@@ -96,7 +97,7 @@ struct ncp_server {
 	struct {
 		struct work_struct tq;		/* STREAM/DGRAM: data/error ready */
 		struct ncp_request_reply* creq;	/* STREAM/DGRAM: awaiting reply from this request */
-		struct semaphore creq_sem;	/* DGRAM only: lock accesses to rcv.creq */
+		struct mutex creq_mutex;	/* DGRAM only: lock accesses to rcv.creq */
 
 		unsigned int state;		/* STREAM only: receiver state */
 		struct {
