Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261862AbUC0Snq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Mar 2004 13:43:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261851AbUC0Snq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Mar 2004 13:43:46 -0500
Received: from dkw.ci.uv.es ([147.156.1.46]:28033 "EHLO dkw.uv.es")
	by vger.kernel.org with ESMTP id S261862AbUC0Sm4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Mar 2004 13:42:56 -0500
Date: Sat, 27 Mar 2004 19:42:00 +0100
From: uaca@alumni.uv.es
To: linux-net@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, davem@redhat.com, kuznet@ms2.inr.ac.ru
Subject: [PATCH] PACKET_MMAP limit removal
Message-ID: <20040327184200.GA29991@pusa.informat.uv.es>
References: <20040322170520.GA3685@pusa.informat.uv.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040322170520.GA3685@pusa.informat.uv.es>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Please apply, tested

This patches fixes the following BUG I posted previosly


On Mon, Mar 22, 2004 at 06:05:20PM +0100, uaca@alumni.uv.es wrote:
> 
[...]
>      + another is a memory leakage when two or more calls
>        to setsockopt with PACKET_RX_RING is done on the same
>        socket. pg_vec and io_vec vectors are not deallocated.


This patch also it removes the current limit on the number of frames
PACKET_MMAP can hold. Currently the buffer can hold only
0.15 seconds at a 1 Gb/s in a 32 bit architecture, half
this amount in a 64 bit machine.

With this patch, PACKET_MMAP requires __less memory__
to hold the buffer.

I have rearranged the most used members of struct packet_opt so they
fit in a single cache line.

Any comment would be greatly appreciated

	Ulisses


--- linux-2.6.4/net/packet/af_packet.c	2004-02-18 04:58:40.000000000 +0100
+++ linux-2.6.4-uac/net/packet/af_packet.c	2004-03-27 18:54:07.000000000 +0100
@@ -27,20 +27,22 @@
  *					interrupt locking and some slightly
  *					dubious gcc output. Can you read
  *					compiler: it said _VOLATILE_
  *	Richard Kooijman	:	Timestamp fixes.
  *		Alan Cox	:	New buffers. Use sk->mac.raw.
  *		Alan Cox	:	sendmsg/recvmsg support.
  *		Alan Cox	:	Protocol setting support
  *	Alexey Kuznetsov	:	Untied from IPv4 stack.
  *	Cyrus Durgin		:	Fixed kerneld for kmod.
  *	Michal Ostrowski        :       Module initialization cleanup.
+ *         Ulises Alonso        :       Frame number limit removal and 
+ *                                      packet_set_ring memory leak.
  *
  *		This program is free software; you can redistribute it and/or
  *		modify it under the terms of the GNU General Public License
  *		as published by the Free Software Foundation; either version
  *		2 of the License, or (at your option) any later version.
  *
  */
  
 #include <linux/config.h>
 #include <linux/types.h>
@@ -161,44 +163,61 @@
 };
 #endif
 #ifdef CONFIG_PACKET_MMAP
 static int packet_set_ring(struct sock *sk, struct tpacket_req *req, int closing);
 #endif
 
 static void packet_flush_mclist(struct sock *sk);
 
 struct packet_opt
 {
+	struct tpacket_stats	stats;
+#ifdef CONFIG_PACKET_MMAP
+	unsigned long		*pg_vec;
+	unsigned int		head;
+	unsigned int            frames_per_block;
+	unsigned int		frame_size;
+	unsigned int		frame_max;
+	int			copy_thresh;
+#endif
 	struct packet_type	prot_hook;
 	spinlock_t		bind_lock;
 	char			running;	/* prot_hook is attached*/
 	int			ifindex;	/* bound device		*/
 	unsigned short		num;
-	struct tpacket_stats	stats;
 #ifdef CONFIG_PACKET_MULTICAST
 	struct packet_mclist	*mclist;
 #endif
 #ifdef CONFIG_PACKET_MMAP
 	atomic_t		mapped;
-	unsigned long		*pg_vec;
-	unsigned int		pg_vec_order;
+	unsigned int            pg_vec_order;
 	unsigned int		pg_vec_pages;
 	unsigned int		pg_vec_len;
-
-	struct tpacket_hdr	**iovec;
-	unsigned int		frame_size;
-	unsigned int		iovmax;
-	unsigned int		head;
-	int			copy_thresh;
 #endif
 };
 
+#ifdef CONFIG_PACKET_MMAP
+
+static inline unsigned long packet_lookup_frame(struct packet_opt *po, unsigned int position)
+{
+	unsigned int pg_vec_pos, frame_offset;
+	unsigned long frame;
+
+	pg_vec_pos = position / po->frames_per_block;
+	frame_offset = position % po->frames_per_block;
+
+	frame = (unsigned long) (po->pg_vec[pg_vec_pos] + (frame_offset * po->frame_size));
+	
+	return frame;
+}
+#endif
+
 #define pkt_sk(__sk) ((struct packet_opt *)(__sk)->sk_protinfo)
 
 void packet_sock_destruct(struct sock *sk)
 {
 	BUG_TRAP(!atomic_read(&sk->sk_rmem_alloc));
 	BUG_TRAP(!atomic_read(&sk->sk_wmem_alloc));
 
 	if (!sock_flag(sk, SOCK_DEAD)) {
 		printk("Attempt to release alive packet socket: %p\n", sk);
 		return;
@@ -579,25 +598,25 @@
 				skb_set_owner_r(copy_skb, sk);
 		}
 		snaplen = po->frame_size - macoff;
 		if ((int)snaplen < 0)
 			snaplen = 0;
 	}
 	if (snaplen > skb->len-skb->data_len)
 		snaplen = skb->len-skb->data_len;
 
 	spin_lock(&sk->sk_receive_queue.lock);
-	h = po->iovec[po->head];
-
+	h = (struct tpacket_hdr *)packet_lookup_frame(po, po->head);
+	
 	if (h->tp_status)
 		goto ring_is_full;
-	po->head = po->head != po->iovmax ? po->head+1 : 0;
+	po->head = po->head != po->frame_max ? po->head+1 : 0;
 	po->stats.tp_packets++;
 	if (copy_skb) {
 		status |= TP_STATUS_COPY;
 		__skb_queue_tail(&sk->sk_receive_queue, copy_skb);
 	}
 	if (!po->stats.tp_drops)
 		status &= ~TP_STATUS_LOSING;
 	spin_unlock(&sk->sk_receive_queue.lock);
 
 	memcpy((u8*)h + macoff, skb->data, snaplen);
@@ -1478,24 +1497,27 @@
 #define packet_poll datagram_poll
 #else
 
 unsigned int packet_poll(struct file * file, struct socket *sock, poll_table *wait)
 {
 	struct sock *sk = sock->sk;
 	struct packet_opt *po = pkt_sk(sk);
 	unsigned int mask = datagram_poll(file, sock, wait);
 
 	spin_lock_bh(&sk->sk_receive_queue.lock);
-	if (po->iovec) {
-		unsigned last = po->head ? po->head-1 : po->iovmax;
+	if (po->pg_vec) {
+		unsigned last = po->head ? po->head-1 : po->frame_max;
+		struct tpacket_hdr *h;
 
-		if (po->iovec[last]->tp_status)
+		h = (struct tpacket_hdr *)packet_lookup_frame(po, last);
+
+		if (h->tp_status)
 			mask |= POLLIN | POLLRDNORM;
 	}
 	spin_unlock_bh(&sk->sk_receive_queue.lock);
 	return mask;
 }
 
 
 /* Dirty? Well, I still did not learn better way to account
  * for user mmaps.
  */
@@ -1541,42 +1563,45 @@
 			free_pages(pg_vec[i], order);
 		}
 	}
 	kfree(pg_vec);
 }
 
 
 static int packet_set_ring(struct sock *sk, struct tpacket_req *req, int closing)
 {
 	unsigned long *pg_vec = NULL;
-	struct tpacket_hdr **io_vec = NULL;
 	struct packet_opt *po = pkt_sk(sk);
 	int was_running, num, order = 0;
 	int err = 0;
-
+	
 	if (req->tp_block_nr) {
 		int i, l;
-		int frames_per_block;
 
 		/* Sanity tests and some calculations */
+
+		if (po->pg_vec)
+			return -EBUSY;
+
 		if ((int)req->tp_block_size <= 0)
 			return -EINVAL;
 		if (req->tp_block_size&(PAGE_SIZE-1))
 			return -EINVAL;
 		if (req->tp_frame_size < TPACKET_HDRLEN)
 			return -EINVAL;
 		if (req->tp_frame_size&(TPACKET_ALIGNMENT-1))
 			return -EINVAL;
-		frames_per_block = req->tp_block_size/req->tp_frame_size;
-		if (frames_per_block <= 0)
+
+		po->frames_per_block = req->tp_block_size/req->tp_frame_size;
+		if (po->frames_per_block <= 0)
 			return -EINVAL;
-		if (frames_per_block*req->tp_block_nr != req->tp_frame_nr)
+		if (po->frames_per_block*req->tp_block_nr != req->tp_frame_nr)
 			return -EINVAL;
 		/* OK! */
 
 		/* Allocate page vector */
 		while ((PAGE_SIZE<<order) < req->tp_block_size)
 			order++;
 
 		err = -ENOMEM;
 
 		pg_vec = kmalloc(req->tp_block_nr*sizeof(unsigned long*), GFP_KERNEL);
@@ -1589,34 +1614,30 @@
 			pg_vec[i] = __get_free_pages(GFP_KERNEL, order);
 			if (!pg_vec[i])
 				goto out_free_pgvec;
 
 			pend = virt_to_page(pg_vec[i] + (PAGE_SIZE << order) - 1);
 			for (page = virt_to_page(pg_vec[i]); page <= pend; page++)
 				SetPageReserved(page);
 		}
 		/* Page vector is allocated */
 
-		/* Draw frames */
-		io_vec = kmalloc(req->tp_frame_nr*sizeof(struct tpacket_hdr*), GFP_KERNEL);
-		if (io_vec == NULL)
-			goto out_free_pgvec;
-		memset(io_vec, 0, req->tp_frame_nr*sizeof(struct tpacket_hdr*));
-
 		l = 0;
 		for (i=0; i<req->tp_block_nr; i++) {
 			unsigned long ptr = pg_vec[i];
+			struct tpacket_hdr *header;
 			int k;
 
-			for (k=0; k<frames_per_block; k++, l++) {
-				io_vec[l] = (struct tpacket_hdr*)ptr;
-				io_vec[l]->tp_status = TP_STATUS_KERNEL;
+			for (k=0; k<po->frames_per_block; k++) {
+				
+				header = (struct tpacket_hdr*)ptr;
+				header->tp_status = TP_STATUS_KERNEL;
 				ptr += req->tp_frame_size;
 			}
 		}
 		/* Done */
 	} else {
 		if (req->tp_frame_nr)
 			return -EINVAL;
 	}
 
 	lock_sock(sk);
@@ -1635,51 +1656,47 @@
 		
 	synchronize_net();
 
 	err = -EBUSY;
 	if (closing || atomic_read(&po->mapped) == 0) {
 		err = 0;
 #define XC(a, b) ({ __typeof__ ((a)) __t; __t = (a); (a) = (b); __t; })
 
 		spin_lock_bh(&sk->sk_receive_queue.lock);
 		pg_vec = XC(po->pg_vec, pg_vec);
-		io_vec = XC(po->iovec, io_vec);
-		po->iovmax = req->tp_frame_nr-1;
+		po->frame_max = req->tp_frame_nr-1;
 		po->head = 0;
 		po->frame_size = req->tp_frame_size;
 		spin_unlock_bh(&sk->sk_receive_queue.lock);
 
 		order = XC(po->pg_vec_order, order);
 		req->tp_block_nr = XC(po->pg_vec_len, req->tp_block_nr);
 
 		po->pg_vec_pages = req->tp_block_size/PAGE_SIZE;
-		po->prot_hook.func = po->iovec ? tpacket_rcv : packet_rcv;
+		po->prot_hook.func = po->pg_vec ? tpacket_rcv : packet_rcv;
 		skb_queue_purge(&sk->sk_receive_queue);
 #undef XC
 		if (atomic_read(&po->mapped))
 			printk(KERN_DEBUG "packet_mmap: vma is busy: %d\n", atomic_read(&po->mapped));
 	}
 
 	spin_lock(&po->bind_lock);
 	if (was_running && !po->running) {
 		sock_hold(sk);
 		po->running = 1;
 		po->num = num;
 		dev_add_pack(&po->prot_hook);
 	}
 	spin_unlock(&po->bind_lock);
 
 	release_sock(sk);
 
-	if (io_vec)
-		kfree(io_vec);
-
 out_free_pgvec:
 	if (pg_vec)
 		free_pg_vec(pg_vec, order, req->tp_block_nr);
 out:
 	return err;
 }
 
 static int packet_mmap(struct file *file, struct socket *sock, struct vm_area_struct *vma)
 {
 	struct sock *sk = sock->sk;
