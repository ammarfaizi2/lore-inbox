Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282874AbRLLXVy>; Wed, 12 Dec 2001 18:21:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282877AbRLLXVs>; Wed, 12 Dec 2001 18:21:48 -0500
Received: from host154.207-175-42.redhat.com ([207.175.42.154]:56176 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S282874AbRLLXVc>; Wed, 12 Dec 2001 18:21:32 -0500
Date: Wed, 12 Dec 2001 18:21:07 -0500
From: Benjamin LaHaise <bcrl@redhat.com>
To: davem@redhat.com, torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com, jgarzik@mandrakesoft.com,
        jes@trained-monkey.org, ionut@cs.columbia.edu, akpm@zip.com.au
Subject: [PATCH] v2.5.1-pre10-02_kvec_net.diff
Message-ID: <20011212182107.B28056@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hey folks,

This patch follows on the 01_kvec patch to convert the skbuff fragment 
structure over to a kveclet.  I got carried away tidying up the network 
drivers a bit in doing this, plus fixed a bug in ns83820.c.  To make 
backwards compatibility for drivers a bit easier, I introduced #defines 
in skbuff.h for skb_frag_{offset,length,page} which should be added to 
2.4 too.  Dave, is this good for you?  Comments?  Hopefully all the driver 
authors I've hit are included on the cc, my apologies if not.  This still 
works for me on the ns83820 and 3c59x drivers.  Cheers,

		-ben
-- 
Fish.

diff -urN 01_kvec-v2.5.1-pre10/drivers/net/3c59x.c 02_kvec_net-v2.5.1-pre10/drivers/net/3c59x.c
--- 01_kvec-v2.5.1-pre10/drivers/net/3c59x.c	Fri Nov  9 16:41:42 2001
+++ 02_kvec_net-v2.5.1-pre10/drivers/net/3c59x.c	Wed Dec 12 17:46:15 2001
@@ -1976,7 +1976,10 @@
 	/* Calculate the next Tx descriptor entry. */
 	int entry = vp->cur_tx % TX_RING_SIZE;
 	struct boom_tx_desc *prev_entry = &vp->tx_ring[(vp->cur_tx-1) % TX_RING_SIZE];
+	struct boom_tx_desc *desc = &vp->tx_ring[entry];
 	unsigned long flags;
+	int len, i;
+	void *buf;
 
 	if (vortex_debug > 6) {
 		printk(KERN_DEBUG "boomerang_start_xmit()\n");
@@ -1995,42 +1998,41 @@
 
 	vp->tx_skbuff[entry] = skb;
 
-	vp->tx_ring[entry].next = 0;
+	desc->next = 0;
 #if DO_ZEROCOPY
 	if (skb->ip_summed != CHECKSUM_HW)
-			vp->tx_ring[entry].status = cpu_to_le32(skb->len | TxIntrUploaded);
+		desc->status = cpu_to_le32(skb->len | TxIntrUploaded);
 	else
-			vp->tx_ring[entry].status = cpu_to_le32(skb->len | TxIntrUploaded | AddTCPChksum);
+		desc->status = cpu_to_le32(skb->len | TxIntrUploaded | AddTCPChksum);
 
-	if (!skb_shinfo(skb)->nr_frags) {
-		vp->tx_ring[entry].frag[0].addr = cpu_to_le32(pci_map_single(vp->pdev, skb->data,
-										skb->len, PCI_DMA_TODEVICE));
-		vp->tx_ring[entry].frag[0].length = cpu_to_le32(skb->len | LAST_FRAG);
-	} else {
-		int i;
-
-		vp->tx_ring[entry].frag[0].addr = cpu_to_le32(pci_map_single(vp->pdev, skb->data,
-										skb->len-skb->data_len, PCI_DMA_TODEVICE));
-		vp->tx_ring[entry].frag[0].length = cpu_to_le32(skb->len-skb->data_len);
-
-		for (i = 0; i < skb_shinfo(skb)->nr_frags; i++) {
-			skb_frag_t *frag = &skb_shinfo(skb)->frags[i];
-
-			vp->tx_ring[entry].frag[i+1].addr =
-					cpu_to_le32(pci_map_single(vp->pdev,
-											   (void*)page_address(frag->page) + frag->page_offset,
-											   frag->size, PCI_DMA_TODEVICE));
-
-			if (i == skb_shinfo(skb)->nr_frags-1)
-					vp->tx_ring[entry].frag[i+1].length = cpu_to_le32(frag->size|LAST_FRAG);
-			else
-					vp->tx_ring[entry].frag[i+1].length = cpu_to_le32(frag->size);
-		}
+	buf = skb->data;
+	len = skb->len;
+	if (skb_shinfo(skb)->nr_frags)
+		len -= skb->data_len;
+
+	for (i=0; ; i++) {
+		skb_frag_t *frag;
+		u32 last = 0;
+		u32 addr = pci_map_single(vp->pdev, buf, len, PCI_DMA_TODEVICE);
+
+		/* No more fragments? */
+		if (i == skb_shinfo(skb)->nr_frags)
+			last = cpu_to_le32(LAST_FRAG);
+
+		desc->frag[i].addr = cpu_to_le32(addr);
+		desc->frag[i].length = cpu_to_le32(len) | last;
+
+		if (last)
+			break;
+
+		frag = &skb_shinfo(skb)->frags[i];
+		buf = page_address(skb_frag_page(frag)) + skb_frag_offset(frag);
+		len = skb_frag_length(frag);
 	}
 #else
-	vp->tx_ring[entry].addr = cpu_to_le32(pci_map_single(vp->pdev, skb->data, skb->len, PCI_DMA_TODEVICE));
-	vp->tx_ring[entry].length = cpu_to_le32(skb->len | LAST_FRAG);
-	vp->tx_ring[entry].status = cpu_to_le32(skb->len | TxIntrUploaded);
+	desc->addr = cpu_to_le32(pci_map_single(vp->pdev, skb->data, skb->len, PCI_DMA_TODEVICE));
+	desc->length = cpu_to_le32(skb->len | LAST_FRAG);
+	desc->status = cpu_to_le32(skb->len | TxIntrUploaded);
 #endif
 
 	spin_lock_irqsave(&vp->lock, flags);
diff -urN 01_kvec-v2.5.1-pre10/drivers/net/8139cp.c 02_kvec_net-v2.5.1-pre10/drivers/net/8139cp.c
--- 01_kvec-v2.5.1-pre10/drivers/net/8139cp.c	Mon Nov 19 18:19:42 2001
+++ 02_kvec_net-v2.5.1-pre10/drivers/net/8139cp.c	Wed Dec 12 17:58:27 2001
@@ -663,10 +663,10 @@
 			u32 len, mapping;
 			u32 ctrl;
 
-			len = this_frag->size;
+			len = skb_frag_length(this_frag);
 			mapping = pci_map_single(cp->pdev,
-						 ((void *) page_address(this_frag->page) +
-						  this_frag->page_offset),
+						 (page_address(skb_frag_page(this_frag)) +
+						  skb_frag_offset(this_frag)),
 						 len, PCI_DMA_TODEVICE);
 			eor = (entry == (CP_TX_RING_SIZE - 1)) ? RingEnd : 0;
 #ifdef CP_TX_CHECKSUM
diff -urN 01_kvec-v2.5.1-pre10/drivers/net/acenic.c 02_kvec_net-v2.5.1-pre10/drivers/net/acenic.c
--- 01_kvec-v2.5.1-pre10/drivers/net/acenic.c	Mon Nov 19 18:19:42 2001
+++ 02_kvec_net-v2.5.1-pre10/drivers/net/acenic.c	Wed Dec 12 17:50:55 2001
@@ -2635,15 +2635,15 @@
 			skb_frag_t *frag = &skb_shinfo(skb)->frags[i];
 			struct tx_ring_info *info;
 
-			len += frag->size;
+			len += skb_frag_length(frag);
 			info = ap->skb->tx_skbuff + idx;
 			desc = ap->tx_ring + idx;
 
-			mapping = pci_map_page(ap->pdev, frag->page,
-					       frag->page_offset, frag->size,
+			mapping = pci_map_page(ap->pdev, skb_frag_page(frag),
+					       skb_frag_offset(frag), skb_frag_length(frag),
 					       PCI_DMA_TODEVICE);
 
-			flagsize = (frag->size << 16);
+			flagsize = (skb_frag_length(frag) << 16);
 			if (skb->ip_summed == CHECKSUM_HW)
 				flagsize |= BD_FLG_TCP_UDP_SUM;
 			idx = (idx + 1) % TX_RING_ENTRIES;
@@ -2662,7 +2662,7 @@
 				info->skb = NULL;
 			}
 			info->mapping = mapping;
-			info->maplen = frag->size;
+			info->maplen = skb_frag_length(frag);
 			ace_load_tx_bd(desc, mapping, flagsize);
 		}
 	}
diff -urN 01_kvec-v2.5.1-pre10/drivers/net/ns83820.c 02_kvec_net-v2.5.1-pre10/drivers/net/ns83820.c
--- 01_kvec-v2.5.1-pre10/drivers/net/ns83820.c	Fri Nov  9 16:45:35 2001
+++ 02_kvec_net-v2.5.1-pre10/drivers/net/ns83820.c	Wed Dec 12 17:28:29 2001
@@ -957,11 +957,13 @@
 		if (!nr_frags)
 			break;
 
-		buf = pci_map_single_high(dev->pci_dev, frag->page, 0,
-					  frag->size, PCI_DMA_TODEVICE);
+		buf = pci_map_single_high(dev->pci_dev, skb_frag_page(frag),
+					  skb_frag_offset(frag),
+					  skb_frag_length(frag),
+					  PCI_DMA_TODEVICE);
 		dprintk("frag: buf=%08Lx  page=%08lx\n",
 			(long long)buf, (long)(frag->page - mem_map));
-		len = frag->size;
+		len = skb_frag_length(frag);
 		frag++;
 		nr_frags--;
 	}
diff -urN 01_kvec-v2.5.1-pre10/drivers/net/starfire.c 02_kvec_net-v2.5.1-pre10/drivers/net/starfire.c
--- 01_kvec-v2.5.1-pre10/drivers/net/starfire.c	Sun Sep 30 15:26:07 2001
+++ 02_kvec_net-v2.5.1-pre10/drivers/net/starfire.c	Wed Dec 12 17:37:29 2001
@@ -1134,11 +1134,13 @@
 		if (skb_first_frag_len(skb) == 1)
 			has_bad_length = 1;
 		else {
-			for (i = 0; i < skb_shinfo(skb)->nr_frags; i++)
-				if (skb_shinfo(skb)->frags[i].size == 1) {
+			for (i = 0; i < skb_shinfo(skb)->nr_frags; i++) {
+				skb_frag_t *frag = &skb_shinfo(skb)->frags[i];
+				if (skb_frag_length(frag)) == 1) {
 					has_bad_length = 1;
 					break;
 				}
+			}
 		}
 
 		if (has_bad_length)
@@ -1188,13 +1190,17 @@
 #ifdef ZEROCOPY
 	for (i = 0; i < skb_shinfo(skb)->nr_frags; i++) {
 		skb_frag_t *this_frag = &skb_shinfo(skb)->frags[i];
+		void *addr = page_address(skb_frag_page(this_frag))
+			     + skb_frag_offset(this_frag);
+		int len = skb_frag_length(this_frag);
 
 		/* we already have the proper value in entry */
 		np->tx_info[entry].frag_mapping[i] =
-			pci_map_single(np->pci_dev, page_address(this_frag->page) + this_frag->page_offset, this_frag->size, PCI_DMA_TODEVICE);
+			pci_map_single(np->pci_dev, addr, len,
+				       PCI_DMA_TODEVICE);
 
 		np->tx_ring[entry].frag[i].addr = cpu_to_le32(np->tx_info[entry].frag_mapping[i]);
-		np->tx_ring[entry].frag[i].len = cpu_to_le32(this_frag->size);
+		np->tx_ring[entry].frag[i].len = cpu_to_le32(len);
 		if (debug > 5) {
 			printk(KERN_DEBUG "%s: Tx #%d frag %d len %4.4x.\n",
 			       dev->name, np->cur_tx, i,
diff -urN 01_kvec-v2.5.1-pre10/drivers/net/sungem.c 02_kvec_net-v2.5.1-pre10/drivers/net/sungem.c
--- 01_kvec-v2.5.1-pre10/drivers/net/sungem.c	Sun Oct 21 13:36:54 2001
+++ 02_kvec_net-v2.5.1-pre10/drivers/net/sungem.c	Wed Dec 12 17:38:21 2001
@@ -714,10 +714,10 @@
 			dma_addr_t mapping;
 			u64 this_ctrl;
 
-			len = this_frag->size;
+			len = skb_frag_length(this_frag);
 			mapping = pci_map_page(gp->pdev,
-					       this_frag->page,
-					       this_frag->page_offset,
+					       skb_frag_page(this_frag),
+					       skb_frag_offset(this_frag),
 					       len, PCI_DMA_TODEVICE);
 			this_ctrl = ctrl;
 			if (frag == skb_shinfo(skb)->nr_frags - 1)
diff -urN 01_kvec-v2.5.1-pre10/drivers/net/sunhme.c 02_kvec_net-v2.5.1-pre10/drivers/net/sunhme.c
--- 01_kvec-v2.5.1-pre10/drivers/net/sunhme.c	Fri Oct 12 18:35:53 2001
+++ 02_kvec_net-v2.5.1-pre10/drivers/net/sunhme.c	Wed Dec 12 17:59:51 2001
@@ -2336,12 +2336,11 @@
 		for (frag = 0; frag < skb_shinfo(skb)->nr_frags; frag++) {
 			skb_frag_t *this_frag = &skb_shinfo(skb)->frags[frag];
 			u32 len, mapping, this_txflags;
+			void *addr = page_address(skb_frag_page(this_frag)) +
+				     skb_frag_offset(this_frag);
 
-			len = this_frag->size;
-			mapping = hme_dma_map(hp,
-					      ((void *) page_address(this_frag->page) +
-					       this_frag->page_offset),
-					      len, DMA_TODEVICE);
+			len = skb_frag_length(this_frag);
+			mapping = hme_dma_map(hp, addr, len, DMA_TODEVICE);
 			this_txflags = tx_flags;
 			if (frag == skb_shinfo(skb)->nr_frags - 1)
 				this_txflags |= TXFLAG_EOP;
Binary files 01_kvec-v2.5.1-pre10/include/linux/.skbuff.h.swp and 02_kvec_net-v2.5.1-pre10/include/linux/.skbuff.h.swp differ
diff -urN 01_kvec-v2.5.1-pre10/include/linux/skbuff.h 02_kvec_net-v2.5.1-pre10/include/linux/skbuff.h
--- 01_kvec-v2.5.1-pre10/include/linux/skbuff.h	Wed Dec 12 13:39:29 2001
+++ 02_kvec_net-v2.5.1-pre10/include/linux/skbuff.h	Wed Dec 12 17:42:24 2001
@@ -107,14 +107,11 @@
 
 #define MAX_SKB_FRAGS 6
 
-typedef struct skb_frag_struct skb_frag_t;
+typedef struct kveclet skb_frag_t;
 
-struct skb_frag_struct
-{
-	struct page *page;
-	__u16 page_offset;
-	__u16 size;
-};
+#define skb_frag_page(f)	((f)->page)
+#define skb_frag_offset(f)	((f)->offset)
+#define skb_frag_length(f)	((f)->length)
 
 /* This data is invariant across clones and lives at
  * the end of the header data, ie. at skb->end.
diff -urN 01_kvec-v2.5.1-pre10/net/core/datagram.c 02_kvec_net-v2.5.1-pre10/net/core/datagram.c
--- 01_kvec-v2.5.1-pre10/net/core/datagram.c	Thu Apr 12 15:11:39 2001
+++ 02_kvec_net-v2.5.1-pre10/net/core/datagram.c	Wed Dec 12 17:52:04 2001
@@ -227,7 +227,7 @@
 
 		BUG_TRAP(start <= offset+len);
 
-		end = start + skb_shinfo(skb)->frags[i].size;
+		end = start + skb_shinfo(skb)->frags[i].length;
 		if ((copy = end-offset) > 0) {
 			int err;
 			u8  *vaddr;
@@ -237,7 +237,7 @@
 			if (copy > len)
 				copy = len;
 			vaddr = kmap(page);
-			err = memcpy_toiovec(to, vaddr + frag->page_offset +
+			err = memcpy_toiovec(to, vaddr + frag->offset +
 					     offset-start, copy);
 			kunmap(page);
 			if (err)
@@ -303,7 +303,7 @@
 
 		BUG_TRAP(start <= offset+len);
 
-		end = start + skb_shinfo(skb)->frags[i].size;
+		end = start + skb_shinfo(skb)->frags[i].length;
 		if ((copy = end-offset) > 0) {
 			unsigned int csum2;
 			int err = 0;
@@ -314,8 +314,9 @@
 			if (copy > len)
 				copy = len;
 			vaddr = kmap(page);
-			csum2 = csum_and_copy_to_user(vaddr + frag->page_offset +
-						      offset-start, to, copy, 0, &err);
+			csum2 = csum_and_copy_to_user(vaddr + frag->offset +
+						      offset-start, to, copy,
+						      0, &err);
 			kunmap(page);
 			if (err)
 				goto fault;
diff -urN 01_kvec-v2.5.1-pre10/net/core/skbuff.c 02_kvec_net-v2.5.1-pre10/net/core/skbuff.c
--- 01_kvec-v2.5.1-pre10/net/core/skbuff.c	Tue Aug  7 11:30:50 2001
+++ 02_kvec_net-v2.5.1-pre10/net/core/skbuff.c	Wed Dec 12 16:33:26 2001
@@ -744,7 +744,7 @@
 	int i;
 
 	for (i=0; i<nfrags; i++) {
-		int end = offset + skb_shinfo(skb)->frags[i].size;
+		int end = offset + skb_shinfo(skb)->frags[i].length;
 		if (end > len) {
 			if (skb_cloned(skb)) {
 				if (!realloc)
@@ -756,7 +756,7 @@
 				put_page(skb_shinfo(skb)->frags[i].page);
 				skb_shinfo(skb)->nr_frags--;
 			} else {
-				skb_shinfo(skb)->frags[i].size = len-offset;
+				skb_shinfo(skb)->frags[i].length = len - offset;
 			}
 		}
 		offset = end;
@@ -833,9 +833,9 @@
 	/* Estimate size of pulled pages. */
 	eat = delta;
 	for (i=0; i<skb_shinfo(skb)->nr_frags; i++) {
-		if (skb_shinfo(skb)->frags[i].size >= eat)
+		if (skb_shinfo(skb)->frags[i].length >= eat)
 			goto pull_pages;
-		eat -= skb_shinfo(skb)->frags[i].size;
+		eat -= skb_shinfo(skb)->frags[i].length;
 	}
 
 	/* If we need update frag list, we are in troubles.
@@ -900,14 +900,14 @@
 	eat = delta;
 	k = 0;
 	for (i=0; i<skb_shinfo(skb)->nr_frags; i++) {
-		if (skb_shinfo(skb)->frags[i].size <= eat) {
+		if (skb_shinfo(skb)->frags[i].length <= eat) {
 			put_page(skb_shinfo(skb)->frags[i].page);
-			eat -= skb_shinfo(skb)->frags[i].size;
+			eat -= skb_shinfo(skb)->frags[i].length;
 		} else {
 			skb_shinfo(skb)->frags[k] = skb_shinfo(skb)->frags[i];
 			if (eat) {
-				skb_shinfo(skb)->frags[k].page_offset += eat;
-				skb_shinfo(skb)->frags[k].size -= eat;
+				skb_shinfo(skb)->frags[k].offset += eat;
+				skb_shinfo(skb)->frags[k].length -= eat;
 				eat = 0;
 			}
 			k++;
@@ -947,7 +947,7 @@
 
 		BUG_TRAP(start <= offset+len);
 
-		end = start + skb_shinfo(skb)->frags[i].size;
+		end = start + skb_shinfo(skb)->frags[i].length;
 		if ((copy = end-offset) > 0) {
 			u8 *vaddr;
 
@@ -955,8 +955,8 @@
 				copy = len;
 
 			vaddr = kmap_skb_frag(&skb_shinfo(skb)->frags[i]);
-			memcpy(to, vaddr+skb_shinfo(skb)->frags[i].page_offset+
-			       offset-start, copy);
+			memcpy(to, vaddr + skb_shinfo(skb)->frags[i].offset +
+			       offset - start, copy);
 			kunmap_skb_frag(vaddr);
 
 			if ((len -= copy) == 0)
@@ -1020,7 +1020,7 @@
 
 		BUG_TRAP(start <= offset+len);
 
-		end = start + skb_shinfo(skb)->frags[i].size;
+		end = start + skb_shinfo(skb)->frags[i].length;
 		if ((copy = end-offset) > 0) {
 			unsigned int csum2;
 			u8 *vaddr;
@@ -1029,8 +1029,8 @@
 			if (copy > len)
 				copy = len;
 			vaddr = kmap_skb_frag(frag);
-			csum2 = csum_partial(vaddr + frag->page_offset +
-					     offset-start, copy, 0);
+			csum2 = csum_partial(vaddr + frag->offset +
+					     offset - start, copy, 0);
 			kunmap_skb_frag(vaddr);
 			csum = csum_block_add(csum, csum2, pos);
 			if (!(len -= copy))
@@ -1096,7 +1096,7 @@
 
 		BUG_TRAP(start <= offset+len);
 
-		end = start + skb_shinfo(skb)->frags[i].size;
+		end = start + skb_shinfo(skb)->frags[i].length;
 		if ((copy = end-offset) > 0) {
 			unsigned int csum2;
 			u8 *vaddr;
@@ -1105,7 +1105,7 @@
 			if (copy > len)
 				copy = len;
 			vaddr = kmap_skb_frag(frag);
-			csum2 = csum_partial_copy_nocheck(vaddr + frag->page_offset +
+			csum2 = csum_partial_copy_nocheck(vaddr + frag->offset +
 						      offset-start, to, copy, 0);
 			kunmap_skb_frag(vaddr);
 			csum = csum_block_add(csum, csum2, pos);
diff -urN 01_kvec-v2.5.1-pre10/net/ipv4/ip_fragment.c 02_kvec_net-v2.5.1-pre10/net/ipv4/ip_fragment.c
--- 01_kvec-v2.5.1-pre10/net/ipv4/ip_fragment.c	Fri Sep  7 14:01:21 2001
+++ 02_kvec_net-v2.5.1-pre10/net/ipv4/ip_fragment.c	Wed Dec 12 17:53:06 2001
@@ -542,7 +542,7 @@
 		skb_shinfo(clone)->frag_list = skb_shinfo(head)->frag_list;
 		skb_shinfo(head)->frag_list = NULL;
 		for (i=0; i<skb_shinfo(head)->nr_frags; i++)
-			plen += skb_shinfo(head)->frags[i].size;
+			plen += skb_shinfo(head)->frags[i].length;
 		clone->len = clone->data_len = head->data_len - plen;
 		head->data_len -= clone->len;
 		head->len -= clone->len;
diff -urN 01_kvec-v2.5.1-pre10/net/ipv4/tcp.c 02_kvec_net-v2.5.1-pre10/net/ipv4/tcp.c
--- 01_kvec-v2.5.1-pre10/net/ipv4/tcp.c	Tue Oct 30 18:08:12 2001
+++ 02_kvec_net-v2.5.1-pre10/net/ipv4/tcp.c	Wed Dec 12 16:35:31 2001
@@ -752,7 +752,7 @@
 	if (i) {
 		skb_frag_t *frag = &skb_shinfo(skb)->frags[i-1];
 		return page == frag->page &&
-			off == frag->page_offset+frag->size;
+			off == frag->offset + frag->length;
 	}
 	return 0;
 }
@@ -762,8 +762,8 @@
 {
 	skb_frag_t *frag = &skb_shinfo(skb)->frags[i];
 	frag->page = page;
-	frag->page_offset = off;
-	frag->size = size;
+	frag->offset = off;
+	frag->length = size;
 	skb_shinfo(skb)->nr_frags = i+1;
 }
 
@@ -872,7 +872,7 @@
 
 		i = skb_shinfo(skb)->nr_frags;
 		if (can_coalesce(skb, i, page, offset)) {
-			skb_shinfo(skb)->frags[i-1].size += copy;
+			skb_shinfo(skb)->frags[i-1].length += copy;
 		} else if (i < MAX_SKB_FRAGS) {
 			get_page(page);
 			fill_page_desc(skb, i, page, offset, copy);
@@ -1135,7 +1135,7 @@
 
 				/* Update the skb. */
 				if (merge) {
-					skb_shinfo(skb)->frags[i-1].size += copy;
+					skb_shinfo(skb)->frags[i-1].length += copy;
 				} else {
 					fill_page_desc(skb, i, page, off, copy);
 					if (TCP_PAGE(sk)) {
diff -urN 01_kvec-v2.5.1-pre10/net/ipv4/tcp_output.c 02_kvec_net-v2.5.1-pre10/net/ipv4/tcp_output.c
--- 01_kvec-v2.5.1-pre10/net/ipv4/tcp_output.c	Mon Nov  5 12:46:12 2001
+++ 02_kvec_net-v2.5.1-pre10/net/ipv4/tcp_output.c	Wed Dec 12 17:54:59 2001
@@ -382,7 +382,7 @@
 		skb->data_len = len - pos;
 
 		for (i=0; i<nfrags; i++) {
-			int size = skb_shinfo(skb)->frags[i].size;
+			int size = skb_shinfo(skb)->frags[i].length;
 			if (pos + size > len) {
 				skb_shinfo(skb1)->frags[k] = skb_shinfo(skb)->frags[i];
 
@@ -396,9 +396,9 @@
 					 * 2. Split is accurately. We make this.
 					 */
 					get_page(skb_shinfo(skb)->frags[i].page);
-					skb_shinfo(skb1)->frags[0].page_offset += (len-pos);
-					skb_shinfo(skb1)->frags[0].size -= (len-pos);
-					skb_shinfo(skb)->frags[i].size = len-pos;
+					skb_shinfo(skb1)->frags[0].offset += (len-pos);
+					skb_shinfo(skb1)->frags[0].length -= (len-pos);
+					skb_shinfo(skb)->frags[i].length = len-pos;
 					skb_shinfo(skb)->nr_frags++;
 				}
 				k++;
