Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264069AbTDWO4Y (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 10:56:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264071AbTDWO4Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 10:56:24 -0400
Received: from smtp4.wanadoo.fr ([193.252.22.28]:18555 "EHLO
	mwinf0302.wanadoo.fr") by vger.kernel.org with ESMTP
	id S264069AbTDWO4O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 10:56:14 -0400
From: Duncan Sands <baldrick@wanadoo.fr>
To: Dave Jones <davej@codemonkey.org.uk>
Subject: Re: BUGed to death
Date: Wed, 23 Apr 2003 17:08:14 +0200
User-Agent: KMail/1.5.1
Cc: "Martin J. Bligh" <mbligh@aracnet.com>, Andrew Morton <akpm@digeo.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
References: <80690000.1050351598@flay> <200304151357.32819.baldrick@wanadoo.fr> <20030415120457.GA11998@suse.de>
In-Reply-To: <20030415120457.GA11998@suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200304231708.14330.baldrick@wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The spinlock code sticks out as a possible good target.
> Any takers for benchmarking ?

How about this one  (i386 only)?
Before: vmlinux -> 28730335 bytes
After: vmlinux -> 28738567 bytes (+8k, i.e. +0.03%)
This is with a fairly maximal .config.
	
 asm-i386/mmu_context.h |    3 +--
 asm-i386/spinlock.h    |   18 ++++++------------
 linux/aio.h            |    4 ++--
 linux/bio.h            |    3 +--
 linux/buffer_head.h    |    3 +--
 linux/dcache.h         |    3 +--
 linux/highmem.h        |    3 +--
 linux/netdevice.h      |    2 +-
 linux/nfs_fs.h         |    3 +--
 linux/quotaops.h       |    6 ++----
 linux/skbuff.h         |   15 +++++----------
 linux/smp_lock.h       |    3 +--
 net/irda/vlsi_ir.h     |    5 +----
 net/sctp/sm.h          |    3 +--
 net/tcp.h              |    2 +-
 rxrpc/call.h           |    3 +--
 rxrpc/connection.h     |    3 +--
 rxrpc/message.h        |    3 +--
 rxrpc/peer.h           |    3 +--
 rxrpc/transport.h      |    3 +--
 20 files changed, 31 insertions(+), 60 deletions(-)


diff -Nru a/include/asm-i386/mmu_context.h b/include/asm-i386/mmu_context.h
--- a/include/asm-i386/mmu_context.h	Wed Apr 23 17:03:35 2003
+++ b/include/asm-i386/mmu_context.h	Wed Apr 23 17:03:35 2003
@@ -45,8 +45,7 @@
 #ifdef CONFIG_SMP
 	else {
 		cpu_tlbstate[cpu].state = TLBSTATE_OK;
-		if (cpu_tlbstate[cpu].active_mm != next)
-			BUG();
+		BUG_ON(cpu_tlbstate[cpu].active_mm != next);
 		if (!test_and_set_bit(cpu, &next->cpu_vm_mask)) {
 			/* We were in lazy tlb mode and leave_mm disabled 
 			 * tlb flush IPI delivery. We must reload %cr3.
diff -Nru a/include/asm-i386/spinlock.h b/include/asm-i386/spinlock.h
--- a/include/asm-i386/spinlock.h	Wed Apr 23 17:03:35 2003
+++ b/include/asm-i386/spinlock.h	Wed Apr 23 17:03:35 2003
@@ -70,10 +70,8 @@
 static inline void _raw_spin_unlock(spinlock_t *lock)
 {
 #ifdef CONFIG_DEBUG_SPINLOCK
-	if (lock->magic != SPINLOCK_MAGIC)
-		BUG();
-	if (!spin_is_locked(lock))
-		BUG();
+	BUG_ON(lock->magic != SPINLOCK_MAGIC);
+	BUG_ON(!spin_is_locked(lock));
 #endif
 	__asm__ __volatile__(
 		spin_unlock_string
@@ -91,10 +89,8 @@
 {
 	char oldval = 1;
 #ifdef CONFIG_DEBUG_SPINLOCK
-	if (lock->magic != SPINLOCK_MAGIC)
-		BUG();
-	if (!spin_is_locked(lock))
-		BUG();
+	BUG_ON(lock->magic != SPINLOCK_MAGIC);
+	BUG_ON(!spin_is_locked(lock));
 #endif
 	__asm__ __volatile__(
 		spin_unlock_string
@@ -174,8 +170,7 @@
 static inline void _raw_read_lock(rwlock_t *rw)
 {
 #ifdef CONFIG_DEBUG_SPINLOCK
-	if (rw->magic != RWLOCK_MAGIC)
-		BUG();
+	BUG_ON(rw->magic != RWLOCK_MAGIC);
 #endif
 	__build_read_lock(rw, "__read_lock_failed");
 }
@@ -183,8 +178,7 @@
 static inline void _raw_write_lock(rwlock_t *rw)
 {
 #ifdef CONFIG_DEBUG_SPINLOCK
-	if (rw->magic != RWLOCK_MAGIC)
-		BUG();
+	BUG_ON(rw->magic != RWLOCK_MAGIC);
 #endif
 	__build_write_lock(rw, "__write_lock_failed");
 }
diff -Nru a/include/linux/aio.h b/include/linux/aio.h
--- a/include/linux/aio.h	Wed Apr 23 17:03:35 2003
+++ b/include/linux/aio.h	Wed Apr 23 17:03:35 2003
@@ -153,8 +153,8 @@
 int FASTCALL(io_submit_one(struct kioctx *ctx, struct iocb *user_iocb,
 				  struct iocb *iocb));
 
-#define get_ioctx(kioctx)	do { if (unlikely(atomic_read(&(kioctx)->users) <= 0)) BUG(); atomic_inc(&(kioctx)->users); } while (0)
-#define put_ioctx(kioctx)	do { if (unlikely(atomic_dec_and_test(&(kioctx)->users))) __put_ioctx(kioctx); else if (unlikely(atomic_read(&(kioctx)->users) < 0)) BUG(); } while (0)
+#define get_ioctx(kioctx)	do { BUG_ON(atomic_read(&(kioctx)->users) <= 0); atomic_inc(&(kioctx)->users); } while (0)
+#define put_ioctx(kioctx)	do { if (unlikely(atomic_dec_and_test(&(kioctx)->users))) __put_ioctx(kioctx); else BUG_ON(atomic_read(&(kioctx)->users) < 0); } while (0)
 
 #include <linux/aio_abi.h>
 
diff -Nru a/include/linux/bio.h b/include/linux/bio.h
--- a/include/linux/bio.h	Wed Apr 23 17:03:35 2003
+++ b/include/linux/bio.h	Wed Apr 23 17:03:35 2003
@@ -242,8 +242,7 @@
 	local_irq_save(*flags);
 	addr = (unsigned long) kmap_atomic(bio_page(bio), KM_BIO_SRC_IRQ);
 
-	if (addr & ~PAGE_MASK)
-		BUG();
+	BUG_ON(addr & ~PAGE_MASK);
 
 	return (char *) addr + bio_offset(bio);
 }
diff -Nru a/include/linux/buffer_head.h b/include/linux/buffer_head.h
--- a/include/linux/buffer_head.h	Wed Apr 23 17:03:35 2003
+++ b/include/linux/buffer_head.h	Wed Apr 23 17:03:35 2003
@@ -122,8 +122,7 @@
 /* If we *know* page->private refers to buffer_heads */
 #define page_buffers(page)					\
 	({							\
-		if (!PagePrivate(page))				\
-			BUG();					\
+		BUG_ON(!PagePrivate(page));			\
 		((struct buffer_head *)(page)->private);	\
 	})
 #define page_has_buffers(page)	PagePrivate(page)
diff -Nru a/include/linux/dcache.h b/include/linux/dcache.h
--- a/include/linux/dcache.h	Wed Apr 23 17:03:35 2003
+++ b/include/linux/dcache.h	Wed Apr 23 17:03:35 2003
@@ -267,8 +267,7 @@
 static inline struct dentry *dget(struct dentry *dentry)
 {
 	if (dentry) {
-		if (!atomic_read(&dentry->d_count))
-			BUG();
+		BUG_ON(!atomic_read(&dentry->d_count));
 		atomic_inc(&dentry->d_count);
 	}
 	return dentry;
diff -Nru a/include/linux/highmem.h b/include/linux/highmem.h
--- a/include/linux/highmem.h	Wed Apr 23 17:03:35 2003
+++ b/include/linux/highmem.h	Wed Apr 23 17:03:35 2003
@@ -61,8 +61,7 @@
 {
 	void *kaddr;
 
-	if (offset + size > PAGE_SIZE)
-		BUG();
+	BUG_ON(offset + size > PAGE_SIZE);
 
 	kaddr = kmap_atomic(page, KM_USER0);
 	memset((char *)kaddr + offset, 0, size);
diff -Nru a/include/linux/netdevice.h b/include/linux/netdevice.h
--- a/include/linux/netdevice.h	Wed Apr 23 17:03:35 2003
+++ b/include/linux/netdevice.h	Wed Apr 23 17:03:35 2003
@@ -794,7 +794,7 @@
 	unsigned long flags;
 
 	local_irq_save(flags);
-	if (!test_bit(__LINK_STATE_RX_SCHED, &dev->state)) BUG();
+	BUG_ON(!test_bit(__LINK_STATE_RX_SCHED, &dev->state));
 	list_del(&dev->poll_list);
 	clear_bit(__LINK_STATE_RX_SCHED, &dev->state);
 	local_irq_restore(flags);
diff -Nru a/include/linux/nfs_fs.h b/include/linux/nfs_fs.h
--- a/include/linux/nfs_fs.h	Wed Apr 23 17:03:35 2003
+++ b/include/linux/nfs_fs.h	Wed Apr 23 17:03:35 2003
@@ -260,8 +260,7 @@
 	if (file)
 		cred = (struct rpc_cred *)file->private_data;
 #ifdef RPC_DEBUG
-	if (cred && cred->cr_magic != RPCAUTH_CRED_MAGIC)
-		BUG();
+	BUG_ON(cred && cred->cr_magic != RPCAUTH_CRED_MAGIC);
 #endif
 	return cred;
 }
diff -Nru a/include/linux/quotaops.h b/include/linux/quotaops.h
--- a/include/linux/quotaops.h	Wed Apr 23 17:03:35 2003
+++ b/include/linux/quotaops.h	Wed Apr 23 17:03:35 2003
@@ -44,8 +44,7 @@
 
 static __inline__ void DQUOT_INIT(struct inode *inode)
 {
-	if (!inode->i_sb)
-		BUG();
+	BUG_ON(!inode->i_sb);
 	if (sb_any_quota_enabled(inode->i_sb) && !IS_NOQUOTA(inode))
 		inode->i_sb->dq_op->initialize(inode, -1);
 }
@@ -53,8 +52,7 @@
 static __inline__ void DQUOT_DROP(struct inode *inode)
 {
 	if (IS_QUOTAINIT(inode)) {
-		if (!inode->i_sb)
-			BUG();
+		BUG_ON(!inode->i_sb);
 		inode->i_sb->dq_op->drop(inode);	/* Ops must be set when there's any quota... */
 	}
 }
diff -Nru a/include/linux/skbuff.h b/include/linux/skbuff.h
--- a/include/linux/skbuff.h	Wed Apr 23 17:03:35 2003
+++ b/include/linux/skbuff.h	Wed Apr 23 17:03:35 2003
@@ -792,12 +792,9 @@
 	return len + skb_headlen(skb);
 }
 
-#define SKB_PAGE_ASSERT(skb) do { if (skb_shinfo(skb)->nr_frags) \
-					BUG(); } while (0)
-#define SKB_FRAG_ASSERT(skb) do { if (skb_shinfo(skb)->frag_list) \
-					BUG(); } while (0)
-#define SKB_LINEAR_ASSERT(skb) do { if (skb_is_nonlinear(skb)) \
-					BUG(); } while (0)
+#define SKB_PAGE_ASSERT(skb) BUG_ON(skb_shinfo(skb)->nr_frags)
+#define SKB_FRAG_ASSERT(skb) BUG_ON(skb_shinfo(skb)->frag_list)
+#define SKB_LINEAR_ASSERT(skb) BUG_ON(skb_is_nonlinear(skb))
 
 /*
  *	Add data to an sk_buff
@@ -859,8 +856,7 @@
 static inline char *__skb_pull(struct sk_buff *skb, unsigned int len)
 {
 	skb->len -= len;
-	if (skb->len < skb->data_len)
-		BUG();
+	BUG_ON(skb->len < skb->data_len);
 	return skb->data += len;
 }
 
@@ -1122,8 +1118,7 @@
 static inline void *kmap_skb_frag(const skb_frag_t *frag)
 {
 #ifdef CONFIG_HIGHMEM
-	if (in_irq())
-		BUG();
+	BUG_ON(in_irq());
 
 	local_bh_disable();
 #endif
diff -Nru a/include/linux/smp_lock.h b/include/linux/smp_lock.h
--- a/include/linux/smp_lock.h	Wed Apr 23 17:03:35 2003
+++ b/include/linux/smp_lock.h	Wed Apr 23 17:03:35 2003
@@ -49,8 +49,7 @@
 
 static inline void unlock_kernel(void)
 {
-	if (unlikely(current->lock_depth < 0))
-		BUG();
+	BUG_ON(current->lock_depth < 0);
 	if (likely(--current->lock_depth < 0))
 		put_kernel_lock();
 }
diff -Nru a/include/net/irda/vlsi_ir.h b/include/net/irda/vlsi_ir.h
--- a/include/net/irda/vlsi_ir.h	Wed Apr 23 17:03:35 2003
+++ b/include/net/irda/vlsi_ir.h	Wed Apr 23 17:03:35 2003
@@ -615,10 +615,7 @@
 	 *    case status has RD_ACTIVE set
 	 */
 
-	if ((a & ~DMA_MASK_MSTRPAGE)>>24 != MSTRPAGE_VALUE) {
-		BUG();
-		return;
-	}
+	BUG_ON((a & ~DMA_MASK_MSTRPAGE)>>24 != MSTRPAGE_VALUE);
 
 	a &= DMA_MASK_MSTRPAGE;  /* clear highbyte to make sure we won't write
 				  * to status - just in case MSTRPAGE_VALUE!=0
diff -Nru a/include/net/sctp/sm.h b/include/net/sctp/sm.h
--- a/include/net/sctp/sm.h	Wed Apr 23 17:03:35 2003
+++ b/include/net/sctp/sm.h	Wed Apr 23 17:03:35 2003
@@ -441,8 +441,7 @@
 /* Run sctp_add_cmd() generating a BUG() if there is a failure.  */
 static inline void sctp_add_cmd_sf(sctp_cmd_seq_t *seq, sctp_verb_t verb, sctp_arg_t obj)
 {
-	if (unlikely(!sctp_add_cmd(seq, verb, obj)))
-		BUG();
+	BUG_ON(!sctp_add_cmd(seq, verb, obj));
 }
 
 /* Check VTAG of the packet matches the sender's own tag OR its peer's
diff -Nru a/include/net/tcp.h b/include/net/tcp.h
--- a/include/net/tcp.h	Wed Apr 23 17:03:35 2003
+++ b/include/net/tcp.h	Wed Apr 23 17:03:35 2003
@@ -1361,7 +1361,7 @@
 		if (tp->ucopy.memory > sk->rcvbuf) {
 			struct sk_buff *skb1;
 
-			if (sock_owned_by_user(sk)) BUG();
+			BUG_ON(sock_owned_by_user(sk));
 
 			while ((skb1 = __skb_dequeue(&tp->ucopy.prequeue)) != NULL) {
 				sk->backlog_rcv(sk, skb1);
diff -Nru a/include/rxrpc/call.h b/include/rxrpc/call.h
--- a/include/rxrpc/call.h	Wed Apr 23 17:03:35 2003
+++ b/include/rxrpc/call.h	Wed Apr 23 17:03:35 2003
@@ -187,8 +187,7 @@
 
 static inline void rxrpc_get_call(struct rxrpc_call *call)
 {
-	if (atomic_read(&call->usage)<=0)
-		BUG();
+	BUG_ON(atomic_read(&call->usage)<=0);
 	atomic_inc(&call->usage);
 	/*printk("rxrpc_get_call(%p{u=%d})\n",(C),atomic_read(&(C)->usage));*/
 }
diff -Nru a/include/rxrpc/connection.h b/include/rxrpc/connection.h
--- a/include/rxrpc/connection.h	Wed Apr 23 17:03:35 2003
+++ b/include/rxrpc/connection.h	Wed Apr 23 17:03:35 2003
@@ -66,8 +66,7 @@
 
 static inline void rxrpc_get_connection(struct rxrpc_connection *conn)
 {
-	if (atomic_read(&conn->usage)<0)
-		BUG();
+	BUG_ON(atomic_read(&conn->usage)<0);
 	atomic_inc(&conn->usage);
 	//printk("rxrpc_get_conn(%p{u=%d})\n",conn,atomic_read(&conn->usage));
 }
diff -Nru a/include/rxrpc/message.h b/include/rxrpc/message.h
--- a/include/rxrpc/message.h	Wed Apr 23 17:03:35 2003
+++ b/include/rxrpc/message.h	Wed Apr 23 17:03:35 2003
@@ -53,8 +53,7 @@
 extern void __rxrpc_put_message(struct rxrpc_message *msg);
 static inline void rxrpc_put_message(struct rxrpc_message *msg)
 {
-	if (atomic_read(&msg->usage)<=0)
-		BUG();
+	BUG_ON(atomic_read(&msg->usage)<=0);
 	if (atomic_dec_and_test(&msg->usage))
 		__rxrpc_put_message(msg);
 }
diff -Nru a/include/rxrpc/peer.h b/include/rxrpc/peer.h
--- a/include/rxrpc/peer.h	Wed Apr 23 17:03:35 2003
+++ b/include/rxrpc/peer.h	Wed Apr 23 17:03:35 2003
@@ -69,8 +69,7 @@
 
 static inline void rxrpc_get_peer(struct rxrpc_peer *peer)
 {
-	if (atomic_read(&peer->usage)<0)
-		BUG();
+	BUG_ON(atomic_read(&peer->usage)<0);
 	atomic_inc(&peer->usage);
 	//printk("rxrpc_get_peer(%p{u=%d})\n",peer,atomic_read(&peer->usage));
 }
diff -Nru a/include/rxrpc/transport.h b/include/rxrpc/transport.h
--- a/include/rxrpc/transport.h	Wed Apr 23 17:03:35 2003
+++ b/include/rxrpc/transport.h	Wed Apr 23 17:03:35 2003
@@ -85,8 +85,7 @@
 
 static inline void rxrpc_get_transport(struct rxrpc_transport *trans)
 {
-	if (atomic_read(&trans->usage)<=0)
-		BUG();
+	BUG_ON(atomic_read(&trans->usage)<=0);
 	atomic_inc(&trans->usage);
 	//printk("rxrpc_get_transport(%p{u=%d})\n",trans,atomic_read(&trans->usage));
 }

