Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1162420AbWLBAs5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162420AbWLBAs5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 19:48:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162442AbWLBAs5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 19:48:57 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:49560 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S1162420AbWLBAsz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 19:48:55 -0500
Date: Fri, 1 Dec 2006 16:52:15 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>, torvalds@osdl.org, stable@kernel.org
Subject: Re: Linux 2.6.18.5
Message-ID: <20061202005215.GG1397@sequoia.sous-sol.org>
References: <20061202005118.GF1397@sequoia.sous-sol.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061202005118.GF1397@sequoia.sous-sol.org>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff --git a/Makefile b/Makefile
index d026088..85d8009 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 VERSION = 2
 PATCHLEVEL = 6
 SUBLEVEL = 18
-EXTRAVERSION = .4
+EXTRAVERSION = .5
 NAME=Avast! A bilge rat!
 
 # *DOCUMENTATION*
diff --git a/arch/alpha/Kconfig b/arch/alpha/Kconfig
index 213c785..2b36afd 100644
--- a/arch/alpha/Kconfig
+++ b/arch/alpha/Kconfig
@@ -381,7 +381,7 @@ config ALPHA_EV56
 
 config ALPHA_EV56
 	prompt "EV56 CPU (speed >= 333MHz)?"
-	depends on ALPHA_NORITAKE && ALPHA_PRIMO
+	depends on ALPHA_NORITAKE || ALPHA_PRIMO
 
 config ALPHA_EV56
 	prompt "EV56 CPU (speed >= 400MHz)?"
diff --git a/arch/i386/kernel/microcode.c b/arch/i386/kernel/microcode.c
index 40b44cc..e5520eb 100644
--- a/arch/i386/kernel/microcode.c
+++ b/arch/i386/kernel/microcode.c
@@ -250,14 +250,14 @@ static int find_matching_ucodes (void) 
 		}
 
 		total_size = get_totalsize(&mc_header);
-		if ((cursor + total_size > user_buffer_size) || (total_size < DEFAULT_UCODE_TOTALSIZE)) {
+		if (cursor + total_size > user_buffer_size) {
 			printk(KERN_ERR "microcode: error! Bad data in microcode data file\n");
 			error = -EINVAL;
 			goto out;
 		}
 
 		data_size = get_datasize(&mc_header);
-		if ((data_size + MC_HEADER_SIZE > total_size) || (data_size < DEFAULT_UCODE_DATASIZE)) {
+		if (data_size + MC_HEADER_SIZE > total_size) {
 			printk(KERN_ERR "microcode: error! Bad data in microcode data file\n");
 			error = -EINVAL;
 			goto out;
@@ -460,11 +460,6 @@ static ssize_t microcode_write (struct f
 {
 	ssize_t ret;
 
-	if (len < DEFAULT_UCODE_TOTALSIZE) {
-		printk(KERN_ERR "microcode: not enough data\n"); 
-		return -EINVAL;
-	}
-
 	if ((len >> PAGE_SHIFT) > num_physpages) {
 		printk(KERN_ERR "microcode: too much data (max %ld pages)\n", num_physpages);
 		return -EINVAL;
diff --git a/arch/ia64/sn/kernel/bte.c b/arch/ia64/sn/kernel/bte.c
index 27dee45..c55f487 100644
--- a/arch/ia64/sn/kernel/bte.c
+++ b/arch/ia64/sn/kernel/bte.c
@@ -382,14 +382,13 @@ bte_result_t bte_unaligned_copy(u64 src,
 		 * bcopy to the destination.
 		 */
 
-		/* Add the leader from source */
-		headBteLen = len + (src & L1_CACHE_MASK);
-		/* Add the trailing bytes from footer. */
-		headBteLen += L1_CACHE_BYTES - (headBteLen & L1_CACHE_MASK);
-		headBteSource = src & ~L1_CACHE_MASK;
 		headBcopySrcOffset = src & L1_CACHE_MASK;
 		headBcopyDest = dest;
 		headBcopyLen = len;
+
+		headBteSource = src - headBcopySrcOffset;
+		/* Add the leading and trailing bytes from source */
+		headBteLen = L1_CACHE_ALIGN(len + headBcopySrcOffset);
 	}
 
 	if (headBcopyLen > 0) {
diff --git a/block/scsi_ioctl.c b/block/scsi_ioctl.c
index ed3d3ae..848ac42 100644
--- a/block/scsi_ioctl.c
+++ b/block/scsi_ioctl.c
@@ -286,9 +286,8 @@ static int sg_io(struct file *file, requ
 	 * fill in request structure
 	 */
 	rq->cmd_len = hdr->cmd_len;
+	memset(rq->cmd, 0, BLK_MAX_CDB); /* ATAPI hates garbage after CDB */
 	memcpy(rq->cmd, cmd, hdr->cmd_len);
-	if (sizeof(rq->cmd) != hdr->cmd_len)
-		memset(rq->cmd + hdr->cmd_len, 0, sizeof(rq->cmd) - hdr->cmd_len);
 
 	memset(sense, 0, sizeof(sense));
 	rq->sense = sense;
diff --git a/drivers/char/agp/generic.c b/drivers/char/agp/generic.c
index cc5ea34..d218575 100644
--- a/drivers/char/agp/generic.c
+++ b/drivers/char/agp/generic.c
@@ -1042,7 +1042,7 @@ void *agp_generic_alloc_page(struct agp_
 {
 	struct page * page;
 
-	page = alloc_page(GFP_KERNEL);
+	page = alloc_page(GFP_KERNEL | GFP_DMA32);
 	if (page == NULL)
 		return NULL;
 
diff --git a/drivers/char/agp/intel-agp.c b/drivers/char/agp/intel-agp.c
index 61ac380..64bb579 100644
--- a/drivers/char/agp/intel-agp.c
+++ b/drivers/char/agp/intel-agp.c
@@ -160,7 +160,7 @@ static void *i8xx_alloc_pages(void)
 {
 	struct page * page;
 
-	page = alloc_pages(GFP_KERNEL, 2);
+	page = alloc_pages(GFP_KERNEL | GFP_DMA32, 2);
 	if (page == NULL)
 		return NULL;
 
diff --git a/drivers/media/Kconfig b/drivers/media/Kconfig
index ed4aa4e..9f7e1fe 100644
--- a/drivers/media/Kconfig
+++ b/drivers/media/Kconfig
@@ -54,6 +54,7 @@ config VIDEO_V4L1_COMPAT
 
 config VIDEO_V4L2
 	bool
+	depends on VIDEO_DEV
 	default y
 
 source "drivers/media/video/Kconfig"
diff --git a/drivers/net/tg3.c b/drivers/net/tg3.c
index eafabb2..fa620ae 100644
--- a/drivers/net/tg3.c
+++ b/drivers/net/tg3.c
@@ -6889,8 +6889,10 @@ static int tg3_open(struct net_device *d
 	tg3_full_lock(tp, 0);
 
 	err = tg3_set_power_state(tp, PCI_D0);
-	if (err)
+	if (err) {
+		tg3_full_unlock(tp);
 		return err;
+	}
 
 	tg3_disable_ints(tp);
 	tp->tg3_flags &= ~TG3_FLAG_INIT_COMPLETE;
diff --git a/drivers/net/wireless/bcm43xx/bcm43xx_main.c b/drivers/net/wireless/bcm43xx/bcm43xx_main.c
index f24ba4d..42eecf2 100644
--- a/drivers/net/wireless/bcm43xx/bcm43xx_main.c
+++ b/drivers/net/wireless/bcm43xx/bcm43xx_main.c
@@ -1463,6 +1463,23 @@ static void handle_irq_transmit_status(s
 	}
 }
 
+static void drain_txstatus_queue(struct bcm43xx_private *bcm)
+{
+	u32 dummy;
+
+	if (bcm->current_core->rev < 5)
+		return;
+	/* Read all entries from the microcode TXstatus FIFO
+	 * and throw them away.
+	 */
+	while (1) {
+		dummy = bcm43xx_read32(bcm, BCM43xx_MMIO_XMITSTAT_0);
+		if (!dummy)
+			break;
+		dummy = bcm43xx_read32(bcm, BCM43xx_MMIO_XMITSTAT_1);
+	}
+}
+
 static void bcm43xx_generate_noise_sample(struct bcm43xx_private *bcm)
 {
 	bcm43xx_shm_write16(bcm, BCM43xx_SHM_SHARED, 0x408, 0x7F7F);
@@ -3517,6 +3534,7 @@ int bcm43xx_select_wireless_core(struct 
 	bcm43xx_macfilter_clear(bcm, BCM43xx_MACFILTER_ASSOC);
 	bcm43xx_macfilter_set(bcm, BCM43xx_MACFILTER_SELF, (u8 *)(bcm->net_dev->dev_addr));
 	bcm43xx_security_init(bcm);
+	drain_txstatus_queue(bcm);
 	ieee80211softmac_start(bcm->net_dev);
 
 	/* Let's go! Be careful after enabling the IRQs.
diff --git a/drivers/pcmcia/ds.c b/drivers/pcmcia/ds.c
index 74b3124..95d5e88 100644
--- a/drivers/pcmcia/ds.c
+++ b/drivers/pcmcia/ds.c
@@ -1264,6 +1264,11 @@ static void pcmcia_bus_remove_socket(str
 	socket->pcmcia_state.dead = 1;
 	pccard_register_pcmcia(socket, NULL);
 
+	/* unregister any unbound devices */
+	mutex_lock(&socket->skt_mutex);
+	pcmcia_card_remove(socket, NULL);
+	mutex_unlock(&socket->skt_mutex);
+
 	pcmcia_put_socket(socket);
 
 	return;
diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index 077c1c6..3031078 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -408,6 +408,7 @@ int scsi_execute_async(struct scsi_devic
 		goto free_req;
 
 	req->cmd_len = cmd_len;
+	memset(req->cmd, 0, BLK_MAX_CDB); /* ATAPI hates garbage after CDB */
 	memcpy(req->cmd, cmd, req->cmd_len);
 	req->sense = sioc->sense;
 	req->sense_len = 0;
diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 5d7c726..f75deeb 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -138,6 +138,7 @@ static int fuse_dentry_revalidate(struct
 		struct fuse_entry_out outarg;
 		struct fuse_conn *fc;
 		struct fuse_req *req;
+		struct fuse_req *forget_req;
 
 		/* Doesn't hurt to "reset" the validity timeout */
 		fuse_invalidate_entry_cache(entry);
@@ -151,21 +152,29 @@ static int fuse_dentry_revalidate(struct
 		if (IS_ERR(req))
 			return 0;
 
+		forget_req = fuse_get_req(fc);
+		if (IS_ERR(forget_req)) {
+			fuse_put_request(fc, req);
+			return 0;
+		}
+
 		fuse_lookup_init(req, entry->d_parent->d_inode, entry, &outarg);
 		request_send(fc, req);
 		err = req->out.h.error;
+		fuse_put_request(fc, req);
 		/* Zero nodeid is same as -ENOENT */
 		if (!err && !outarg.nodeid)
 			err = -ENOENT;
 		if (!err) {
 			struct fuse_inode *fi = get_fuse_inode(inode);
 			if (outarg.nodeid != get_node_id(inode)) {
-				fuse_send_forget(fc, req, outarg.nodeid, 1);
+				fuse_send_forget(fc, forget_req,
+						 outarg.nodeid, 1);
 				return 0;
 			}
 			fi->nlookup ++;
 		}
-		fuse_put_request(fc, req);
+		fuse_put_request(fc, forget_req);
 		if (err || (outarg.attr.mode ^ inode->i_mode) & S_IFMT)
 			return 0;
 
@@ -214,6 +223,7 @@ static struct dentry *fuse_lookup(struct
 	struct inode *inode = NULL;
 	struct fuse_conn *fc = get_fuse_conn(dir);
 	struct fuse_req *req;
+	struct fuse_req *forget_req;
 
 	if (entry->d_name.len > FUSE_NAME_MAX)
 		return ERR_PTR(-ENAMETOOLONG);
@@ -222,9 +232,16 @@ static struct dentry *fuse_lookup(struct
 	if (IS_ERR(req))
 		return ERR_PTR(PTR_ERR(req));
 
+	forget_req = fuse_get_req(fc);
+	if (IS_ERR(forget_req)) {
+		fuse_put_request(fc, req);
+		return ERR_PTR(PTR_ERR(forget_req));
+	}
+
 	fuse_lookup_init(req, dir, entry, &outarg);
 	request_send(fc, req);
 	err = req->out.h.error;
+	fuse_put_request(fc, req);
 	/* Zero nodeid is same as -ENOENT, but with valid timeout */
 	if (!err && outarg.nodeid &&
 	    (invalid_nodeid(outarg.nodeid) || !valid_mode(outarg.attr.mode)))
@@ -233,11 +250,11 @@ static struct dentry *fuse_lookup(struct
 		inode = fuse_iget(dir->i_sb, outarg.nodeid, outarg.generation,
 				  &outarg.attr);
 		if (!inode) {
-			fuse_send_forget(fc, req, outarg.nodeid, 1);
+			fuse_send_forget(fc, forget_req, outarg.nodeid, 1);
 			return ERR_PTR(-ENOMEM);
 		}
 	}
-	fuse_put_request(fc, req);
+	fuse_put_request(fc, forget_req);
 	if (err && err != -ENOENT)
 		return ERR_PTR(err);
 
@@ -375,6 +392,13 @@ static int create_new_entry(struct fuse_
 	struct fuse_entry_out outarg;
 	struct inode *inode;
 	int err;
+	struct fuse_req *forget_req;
+
+	forget_req = fuse_get_req(fc);
+	if (IS_ERR(forget_req)) {
+		fuse_put_request(fc, req);
+		return PTR_ERR(forget_req);
+	}
 
 	req->in.h.nodeid = get_node_id(dir);
 	req->out.numargs = 1;
@@ -382,24 +406,24 @@ static int create_new_entry(struct fuse_
 	req->out.args[0].value = &outarg;
 	request_send(fc, req);
 	err = req->out.h.error;
-	if (err) {
-		fuse_put_request(fc, req);
-		return err;
-	}
+	fuse_put_request(fc, req);
+	if (err)
+		goto out_put_forget_req;
+
 	err = -EIO;
 	if (invalid_nodeid(outarg.nodeid))
-		goto out_put_request;
+		goto out_put_forget_req;
 
 	if ((outarg.attr.mode ^ mode) & S_IFMT)
-		goto out_put_request;
+		goto out_put_forget_req;
 
 	inode = fuse_iget(dir->i_sb, outarg.nodeid, outarg.generation,
 			  &outarg.attr);
 	if (!inode) {
-		fuse_send_forget(fc, req, outarg.nodeid, 1);
+		fuse_send_forget(fc, forget_req, outarg.nodeid, 1);
 		return -ENOMEM;
 	}
-	fuse_put_request(fc, req);
+	fuse_put_request(fc, forget_req);
 
 	if (dir_alias(inode)) {
 		iput(inode);
@@ -411,8 +435,8 @@ static int create_new_entry(struct fuse_
 	fuse_invalidate_attr(dir);
 	return 0;
 
- out_put_request:
-	fuse_put_request(fc, req);
+ out_put_forget_req:
+	fuse_put_request(fc, forget_req);
 	return err;
 }
 
diff --git a/include/linux/netfilter_ipv4.h b/include/linux/netfilter_ipv4.h
index ce02c98..5b63a23 100644
--- a/include/linux/netfilter_ipv4.h
+++ b/include/linux/netfilter_ipv4.h
@@ -77,7 +77,7 @@ enum nf_ip_hook_priorities {
 #define SO_ORIGINAL_DST 80
 
 #ifdef __KERNEL__
-extern int ip_route_me_harder(struct sk_buff **pskb);
+extern int ip_route_me_harder(struct sk_buff **pskb, unsigned addr_type);
 extern int ip_xfrm_me_harder(struct sk_buff **pskb);
 extern unsigned int nf_ip_checksum(struct sk_buff *skb, unsigned int hook,
 				   unsigned int dataoff, u_int8_t protocol);
diff --git a/net/bluetooth/hci_sock.c b/net/bluetooth/hci_sock.c
index 1a35d34..316fa7a 100644
--- a/net/bluetooth/hci_sock.c
+++ b/net/bluetooth/hci_sock.c
@@ -120,10 +120,13 @@ void hci_send_to_sock(struct hci_dev *hd
 			if (!hci_test_bit(evt, &flt->event_mask))
 				continue;
 
-			if (flt->opcode && ((evt == HCI_EV_CMD_COMPLETE && 
-					flt->opcode != *(__u16 *)(skb->data + 3)) ||
-					(evt == HCI_EV_CMD_STATUS && 
-					flt->opcode != *(__u16 *)(skb->data + 4))))
+			if (flt->opcode &&
+			    ((evt == HCI_EV_CMD_COMPLETE &&
+			      flt->opcode !=
+			      get_unaligned((__u16 *)(skb->data + 3))) ||
+			     (evt == HCI_EV_CMD_STATUS &&
+			      flt->opcode !=
+			      get_unaligned((__u16 *)(skb->data + 4)))))
 				continue;
 		}
 
diff --git a/net/dccp/ipv6.c b/net/dccp/ipv6.c
index 610c722..3744c24 100644
--- a/net/dccp/ipv6.c
+++ b/net/dccp/ipv6.c
@@ -276,7 +276,7 @@ static void dccp_v6_err(struct sk_buff *
 	__u64 seq;
 
 	sk = inet6_lookup(&dccp_hashinfo, &hdr->daddr, dh->dccph_dport,
-			  &hdr->saddr, dh->dccph_sport, skb->dev->ifindex);
+			  &hdr->saddr, dh->dccph_sport, inet6_iif(skb));
 
 	if (sk == NULL) {
 		ICMP6_INC_STATS_BH(__in6_dev_get(skb->dev), ICMP6_MIB_INERRORS);
diff --git a/net/ieee80211/softmac/ieee80211softmac_io.c b/net/ieee80211/softmac/ieee80211softmac_io.c
index 6ae5a1d..3b67d19 100644
--- a/net/ieee80211/softmac/ieee80211softmac_io.c
+++ b/net/ieee80211/softmac/ieee80211softmac_io.c
@@ -304,7 +304,7 @@ ieee80211softmac_auth(struct ieee80211_a
 		2 +		/* Auth Transaction Seq */
 		2 +		/* Status Code */
 		 /* Challenge Text IE */
-		is_shared_response ? 0 : 1 + 1 + net->challenge_len
+		(is_shared_response ? 1 + 1 + net->challenge_len : 0)
 	);
 	if (unlikely((*pkt) == NULL))
 		return 0;
diff --git a/net/ipv4/ipvs/ip_vs_core.c b/net/ipv4/ipvs/ip_vs_core.c
index 3f47ad8..f594635 100644
--- a/net/ipv4/ipvs/ip_vs_core.c
+++ b/net/ipv4/ipvs/ip_vs_core.c
@@ -813,6 +813,16 @@ ip_vs_out(unsigned int hooknum, struct s
 	skb->nh.iph->saddr = cp->vaddr;
 	ip_send_check(skb->nh.iph);
 
+ 	/* For policy routing, packets originating from this
+ 	 * machine itself may be routed differently to packets
+ 	 * passing through.  We want this packet to be routed as
+ 	 * if it came from this machine itself.  So re-compute
+ 	 * the routing information.
+ 	 */
+ 	if (ip_route_me_harder(pskb, RTN_LOCAL) != 0)
+ 		goto drop;
+	skb = *pskb;
+
 	IP_VS_DBG_PKT(10, pp, skb, 0, "After SNAT");
 
 	ip_vs_out_stats(cp, skb);
diff --git a/net/ipv4/netfilter.c b/net/ipv4/netfilter.c
index 6a9e34b..327ba37 100644
--- a/net/ipv4/netfilter.c
+++ b/net/ipv4/netfilter.c
@@ -8,7 +8,7 @@ #include <net/xfrm.h>
 #include <net/ip.h>
 
 /* route_me_harder function, used by iptable_nat, iptable_mangle + ip_queue */
-int ip_route_me_harder(struct sk_buff **pskb)
+int ip_route_me_harder(struct sk_buff **pskb, unsigned addr_type)
 {
 	struct iphdr *iph = (*pskb)->nh.iph;
 	struct rtable *rt;
@@ -16,10 +16,13 @@ int ip_route_me_harder(struct sk_buff **
 	struct dst_entry *odst;
 	unsigned int hh_len;
 
+	if (addr_type == RTN_UNSPEC)
+		addr_type = inet_addr_type(iph->saddr);
+
 	/* some non-standard hacks like ipt_REJECT.c:send_reset() can cause
 	 * packets with foreign saddr to appear on the NF_IP_LOCAL_OUT hook.
 	 */
-	if (inet_addr_type(iph->saddr) == RTN_LOCAL) {
+	if (addr_type == RTN_LOCAL) {
 		fl.nl_u.ip4_u.daddr = iph->daddr;
 		fl.nl_u.ip4_u.saddr = iph->saddr;
 		fl.nl_u.ip4_u.tos = RT_TOS(iph->tos);
@@ -156,7 +159,7 @@ static int nf_ip_reroute(struct sk_buff 
 		if (!(iph->tos == rt_info->tos
 		      && iph->daddr == rt_info->daddr
 		      && iph->saddr == rt_info->saddr))
-			return ip_route_me_harder(pskb);
+			return ip_route_me_harder(pskb, RTN_UNSPEC);
 	}
 	return 0;
 }
diff --git a/net/ipv4/netfilter/arp_tables.c b/net/ipv4/netfilter/arp_tables.c
index 8d1d7a6..8ba83e8 100644
--- a/net/ipv4/netfilter/arp_tables.c
+++ b/net/ipv4/netfilter/arp_tables.c
@@ -380,6 +380,13 @@ static int mark_source_chains(struct xt_
 			    && unconditional(&e->arp)) {
 				unsigned int oldpos, size;
 
+				if (t->verdict < -NF_MAX_VERDICT - 1) {
+					duprintf("mark_source_chains: bad "
+						"negative verdict (%i)\n",
+								t->verdict);
+					return 0;
+				}
+
 				/* Return: backtrack through the last
 				 * big jump.
 				 */
@@ -409,6 +416,14 @@ static int mark_source_chains(struct xt_
 				if (strcmp(t->target.u.user.name,
 					   ARPT_STANDARD_TARGET) == 0
 				    && newpos >= 0) {
+					if (newpos > newinfo->size -
+						sizeof(struct arpt_entry)) {
+						duprintf("mark_source_chains: "
+							"bad verdict (%i)\n",
+								newpos);
+						return 0;
+					}
+
 					/* This a jump; chase it. */
 					duprintf("Jump rule %u -> %u\n",
 						 pos, newpos);
@@ -431,8 +446,6 @@ static int mark_source_chains(struct xt_
 static inline int standard_check(const struct arpt_entry_target *t,
 				 unsigned int max_offset)
 {
-	struct arpt_standard_target *targ = (void *)t;
-
 	/* Check standard info. */
 	if (t->u.target_size
 	    != ARPT_ALIGN(sizeof(struct arpt_standard_target))) {
@@ -442,18 +455,6 @@ static inline int standard_check(const s
 		return 0;
 	}
 
-	if (targ->verdict >= 0
-	    && targ->verdict > max_offset - sizeof(struct arpt_entry)) {
-		duprintf("arpt_standard_check: bad verdict (%i)\n",
-			 targ->verdict);
-		return 0;
-	}
-
-	if (targ->verdict < -NF_MAX_VERDICT - 1) {
-		duprintf("arpt_standard_check: bad negative verdict (%i)\n",
-			 targ->verdict);
-		return 0;
-	}
 	return 1;
 }
 
@@ -471,7 +472,13 @@ static inline int check_entry(struct arp
 		return -EINVAL;
 	}
 
+	if (e->target_offset + sizeof(struct arpt_entry_target) > e->next_offset)
+		return -EINVAL;
+
 	t = arpt_get_target(e);
+	if (e->target_offset + t->u.target_size > e->next_offset)
+		return -EINVAL;
+
 	target = try_then_request_module(xt_find_target(NF_ARP, t->u.user.name,
 							t->u.user.revision),
 					 "arpt_%s", t->u.user.name);
@@ -641,7 +648,7 @@ static int translate_table(const char *n
 
 	if (ret != 0) {
 		ARPT_ENTRY_ITERATE(entry0, newinfo->size,
-				   cleanup_entry, &i);
+				cleanup_entry, &i);
 		return ret;
 	}
 
@@ -1204,6 +1211,8 @@ err1:
 static void __exit arp_tables_fini(void)
 {
 	nf_unregister_sockopt(&arpt_sockopts);
+	xt_unregister_target(&arpt_error_target);
+	xt_unregister_target(&arpt_standard_target);
 	xt_proto_fini(NF_ARP);
 }
 
diff --git a/net/ipv4/netfilter/ip_conntrack_helper_h323.c b/net/ipv4/netfilter/ip_conntrack_helper_h323.c
index 9a39e29..afe7039 100644
--- a/net/ipv4/netfilter/ip_conntrack_helper_h323.c
+++ b/net/ipv4/netfilter/ip_conntrack_helper_h323.c
@@ -1417,7 +1417,7 @@ static int process_rcf(struct sk_buff **
 		DEBUGP
 		    ("ip_ct_ras: set RAS connection timeout to %u seconds\n",
 		     info->timeout);
-		ip_ct_refresh_acct(ct, ctinfo, NULL, info->timeout * HZ);
+		ip_ct_refresh(ct, *pskb, info->timeout * HZ);
 
 		/* Set expect timeout */
 		read_lock_bh(&ip_conntrack_lock);
@@ -1465,7 +1465,7 @@ static int process_urq(struct sk_buff **
 	info->sig_port[!dir] = 0;
 
 	/* Give it 30 seconds for UCF or URJ */
-	ip_ct_refresh_acct(ct, ctinfo, NULL, 30 * HZ);
+	ip_ct_refresh(ct, *pskb, 30 * HZ);
 
 	return 0;
 }
diff --git a/net/ipv4/netfilter/ip_nat_standalone.c b/net/ipv4/netfilter/ip_nat_standalone.c
index 6db485f..c508544 100644
--- a/net/ipv4/netfilter/ip_nat_standalone.c
+++ b/net/ipv4/netfilter/ip_nat_standalone.c
@@ -275,7 +275,8 @@ #ifdef CONFIG_XFRM
 		       ct->tuplehash[!dir].tuple.src.u.all
 #endif
 		    )
-			return ip_route_me_harder(pskb) == 0 ? ret : NF_DROP;
+			if (ip_route_me_harder(pskb, RTN_UNSPEC))
+				ret = NF_DROP;
 	}
 	return ret;
 }
diff --git a/net/ipv4/netfilter/ip_tables.c b/net/ipv4/netfilter/ip_tables.c
index 048514f..e964436 100644
--- a/net/ipv4/netfilter/ip_tables.c
+++ b/net/ipv4/netfilter/ip_tables.c
@@ -404,6 +404,13 @@ mark_source_chains(struct xt_table_info 
 			    && unconditional(&e->ip)) {
 				unsigned int oldpos, size;
 
+				if (t->verdict < -NF_MAX_VERDICT - 1) {
+					duprintf("mark_source_chains: bad "
+						"negative verdict (%i)\n",
+								t->verdict);
+					return 0;
+				}
+
 				/* Return: backtrack through the last
 				   big jump. */
 				do {
@@ -441,6 +448,13 @@ #endif
 				if (strcmp(t->target.u.user.name,
 					   IPT_STANDARD_TARGET) == 0
 				    && newpos >= 0) {
+					if (newpos > newinfo->size -
+						sizeof(struct ipt_entry)) {
+						duprintf("mark_source_chains: "
+							"bad verdict (%i)\n",
+								newpos);
+						return 0;
+					}
 					/* This a jump; chase it. */
 					duprintf("Jump rule %u -> %u\n",
 						 pos, newpos);
@@ -474,27 +488,6 @@ cleanup_match(struct ipt_entry_match *m,
 }
 
 static inline int
-standard_check(const struct ipt_entry_target *t,
-	       unsigned int max_offset)
-{
-	struct ipt_standard_target *targ = (void *)t;
-
-	/* Check standard info. */
-	if (targ->verdict >= 0
-	    && targ->verdict > max_offset - sizeof(struct ipt_entry)) {
-		duprintf("ipt_standard_check: bad verdict (%i)\n",
-			 targ->verdict);
-		return 0;
-	}
-	if (targ->verdict < -NF_MAX_VERDICT - 1) {
-		duprintf("ipt_standard_check: bad negative verdict (%i)\n",
-			 targ->verdict);
-		return 0;
-	}
-	return 1;
-}
-
-static inline int
 check_match(struct ipt_entry_match *m,
 	    const char *name,
 	    const struct ipt_ip *ip,
@@ -552,12 +545,18 @@ check_entry(struct ipt_entry *e, const c
 		return -EINVAL;
 	}
 
+	if (e->target_offset + sizeof(struct ipt_entry_target) > e->next_offset)
+		return -EINVAL;
+
 	j = 0;
 	ret = IPT_MATCH_ITERATE(e, check_match, name, &e->ip, e->comefrom, &j);
 	if (ret != 0)
 		goto cleanup_matches;
 
 	t = ipt_get_target(e);
+	ret = -EINVAL;
+	if (e->target_offset + t->u.target_size > e->next_offset)
+			goto cleanup_matches;
 	target = try_then_request_module(xt_find_target(AF_INET,
 						     t->u.user.name,
 						     t->u.user.revision),
@@ -575,12 +574,7 @@ check_entry(struct ipt_entry *e, const c
 	if (ret)
 		goto err;
 
-	if (t->u.kernel.target == &ipt_standard_target) {
-		if (!standard_check(t, size)) {
-			ret = -EINVAL;
-			goto cleanup_matches;
-		}
-	} else if (t->u.kernel.target->checkentry
+	if (t->u.kernel.target->checkentry
 		   && !t->u.kernel.target->checkentry(name, e, target, t->data,
 						      t->u.target_size
 						      - sizeof(*t),
@@ -730,7 +724,7 @@ translate_table(const char *name,
 
 	if (ret != 0) {
 		IPT_ENTRY_ITERATE(entry0, newinfo->size,
-				  cleanup_entry, &i);
+				cleanup_entry, &i);
 		return ret;
 	}
 
@@ -1531,15 +1525,22 @@ check_compat_entry_size_and_hooks(struct
 		return -EINVAL;
 	}
 
+	if (e->target_offset + sizeof(struct compat_xt_entry_target) >
+								e->next_offset)
+		return -EINVAL;
+
 	off = 0;
 	entry_offset = (void *)e - (void *)base;
 	j = 0;
 	ret = IPT_MATCH_ITERATE(e, compat_check_calc_match, name, &e->ip,
 			e->comefrom, &off, &j);
 	if (ret != 0)
-		goto out;
+		goto cleanup_matches;
 
 	t = ipt_get_target(e);
+	ret = -EINVAL;
+	if (e->target_offset + t->u.target_size > e->next_offset)
+			goto cleanup_matches;
 	target = try_then_request_module(xt_find_target(AF_INET,
 						     t->u.user.name,
 						     t->u.user.revision),
@@ -1547,7 +1548,7 @@ check_compat_entry_size_and_hooks(struct
 	if (IS_ERR(target) || !target) {
 		duprintf("check_entry: `%s' not found\n", t->u.user.name);
 		ret = target ? PTR_ERR(target) : -ENOENT;
-		goto out;
+		goto cleanup_matches;
 	}
 	t->u.kernel.target = target;
 
@@ -1574,7 +1575,10 @@ check_compat_entry_size_and_hooks(struct
 
 	(*i)++;
 	return 0;
+
 out:
+	module_put(t->u.kernel.target->me);
+cleanup_matches:
 	IPT_MATCH_ITERATE(e, cleanup_match, &j);
 	return ret;
 }
@@ -1597,18 +1601,16 @@ static inline int compat_copy_match_from
 	ret = xt_check_match(match, AF_INET, dm->u.match_size - sizeof(*dm),
 			     name, hookmask, ip->proto,
 			     ip->invflags & IPT_INV_PROTO);
-	if (ret)
-		return ret;
 
-	if (m->u.kernel.match->checkentry
+	if (!ret && m->u.kernel.match->checkentry
 	    && !m->u.kernel.match->checkentry(name, ip, match, dm->data,
 					      dm->u.match_size - sizeof(*dm),
 					      hookmask)) {
 		duprintf("ip_tables: check failed for `%s'.\n",
 			 m->u.kernel.match->name);
-		return -EINVAL;
+		ret = -EINVAL;
 	}
-	return 0;
+	return ret;
 }
 
 static int compat_copy_entry_from_user(struct ipt_entry *e, void **dstptr,
@@ -1630,7 +1632,7 @@ static int compat_copy_entry_from_user(s
 	ret = IPT_MATCH_ITERATE(e, compat_copy_match_from_user, dstptr, size,
 			name, &de->ip, de->comefrom);
 	if (ret)
-		goto out;
+		goto err;
 	de->target_offset = e->target_offset - (origsize - *size);
 	t = ipt_get_target(e);
 	target = t->u.kernel.target;
@@ -1653,22 +1655,18 @@ static int compat_copy_entry_from_user(s
 			      name, e->comefrom, e->ip.proto,
 			      e->ip.invflags & IPT_INV_PROTO);
 	if (ret)
-		goto out;
+		goto err;
 
-	ret = -EINVAL;
-	if (t->u.kernel.target == &ipt_standard_target) {
-		if (!standard_check(t, *size))
-			goto out;
-	} else if (t->u.kernel.target->checkentry
+	if (t->u.kernel.target->checkentry
 		   && !t->u.kernel.target->checkentry(name, de, target,
 				t->data, t->u.target_size - sizeof(*t),
 				de->comefrom)) {
 		duprintf("ip_tables: compat: check failed for `%s'.\n",
 			 t->u.kernel.target->name);
-		goto out;
+		ret = -EINVAL;
+		goto err;
 	}
-	ret = 0;
-out:
+ err:
 	return ret;
 }
 
@@ -1682,7 +1680,7 @@ translate_compat_table(const char *name,
 		unsigned int *hook_entries,
 		unsigned int *underflows)
 {
-	unsigned int i;
+	unsigned int i, j;
 	struct xt_table_info *newinfo, *info;
 	void *pos, *entry0, *entry1;
 	unsigned int size;
@@ -1700,21 +1698,21 @@ translate_compat_table(const char *name,
 	}
 
 	duprintf("translate_compat_table: size %u\n", info->size);
-	i = 0;
+	j = 0;
 	xt_compat_lock(AF_INET);
 	/* Walk through entries, checking offsets. */
 	ret = IPT_ENTRY_ITERATE(entry0, total_size,
 				check_compat_entry_size_and_hooks,
 				info, &size, entry0,
 				entry0 + total_size,
-				hook_entries, underflows, &i, name);
+				hook_entries, underflows, &j, name);
 	if (ret != 0)
 		goto out_unlock;
 
 	ret = -EINVAL;
-	if (i != number) {
+	if (j != number) {
 		duprintf("translate_compat_table: %u not %u entries\n",
-			 i, number);
+			 j, number);
 		goto out_unlock;
 	}
 
@@ -1773,8 +1771,10 @@ translate_compat_table(const char *name,
 free_newinfo:
 	xt_free_table_info(newinfo);
 out:
+	IPT_ENTRY_ITERATE(entry0, total_size, cleanup_entry, &j);
 	return ret;
 out_unlock:
+	compat_flush_offsets();
 	xt_compat_unlock(AF_INET);
 	goto out;
 }
@@ -1994,6 +1994,9 @@ compat_do_ipt_get_ctl(struct sock *sk, i
 {
 	int ret;
 
+	if (!capable(CAP_NET_ADMIN))
+		return -EPERM;
+
 	switch (cmd) {
 	case IPT_SO_GET_INFO:
 		ret = get_info(user, len, 1);
diff --git a/net/ipv4/netfilter/iptable_mangle.c b/net/ipv4/netfilter/iptable_mangle.c
index 4e7998b..f7b8906 100644
--- a/net/ipv4/netfilter/iptable_mangle.c
+++ b/net/ipv4/netfilter/iptable_mangle.c
@@ -157,7 +157,8 @@ #ifdef CONFIG_IP_ROUTE_FWMARK
 		|| (*pskb)->nfmark != nfmark
 #endif
 		|| (*pskb)->nh.iph->tos != tos))
-		return ip_route_me_harder(pskb) == 0 ? ret : NF_DROP;
+		if (ip_route_me_harder(pskb, RTN_UNSPEC))
+			ret = NF_DROP;
 
 	return ret;
 }
diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index f136cec..87b7fe5 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -892,23 +892,32 @@ #ifndef CONFIG_XFRM
 	return 1; 
 #else
 	struct udp_sock *up = udp_sk(sk);
-  	struct udphdr *uh = skb->h.uh;
+  	struct udphdr *uh;
 	struct iphdr *iph;
 	int iphlen, len;
   
-	__u8 *udpdata = (__u8 *)uh + sizeof(struct udphdr);
-	__u32 *udpdata32 = (__u32 *)udpdata;
+	__u8 *udpdata;
+	__u32 *udpdata32;
 	__u16 encap_type = up->encap_type;
 
 	/* if we're overly short, let UDP handle it */
-	if (udpdata > skb->tail)
+	len = skb->len - sizeof(struct udphdr);
+	if (len <= 0)
 		return 1;
 
 	/* if this is not encapsulated socket, then just return now */
 	if (!encap_type)
 		return 1;
 
-	len = skb->tail - udpdata;
+	/* If this is a paged skb, make sure we pull up
+	 * whatever data we need to look at. */
+	if (!pskb_may_pull(skb, sizeof(struct udphdr) + min(len, 8)))
+		return 1;
+
+	/* Now we can get the pointers */
+	uh = skb->h.uh;
+	udpdata = (__u8 *)uh + sizeof(struct udphdr);
+	udpdata32 = (__u32 *)udpdata;
 
 	switch (encap_type) {
 	default:
diff --git a/net/ipv6/netfilter/ip6_tables.c b/net/ipv6/netfilter/ip6_tables.c
index c9d6b23..751548a 100644
--- a/net/ipv6/netfilter/ip6_tables.c
+++ b/net/ipv6/netfilter/ip6_tables.c
@@ -444,6 +444,13 @@ mark_source_chains(struct xt_table_info 
 			    && unconditional(&e->ipv6)) {
 				unsigned int oldpos, size;
 
+				if (t->verdict < -NF_MAX_VERDICT - 1) {
+					duprintf("mark_source_chains: bad "
+						"negative verdict (%i)\n",
+								t->verdict);
+					return 0;
+				}
+
 				/* Return: backtrack through the last
 				   big jump. */
 				do {
@@ -481,6 +488,13 @@ #endif
 				if (strcmp(t->target.u.user.name,
 					   IP6T_STANDARD_TARGET) == 0
 				    && newpos >= 0) {
+					if (newpos > newinfo->size -
+						sizeof(struct ip6t_entry)) {
+						duprintf("mark_source_chains: "
+							"bad verdict (%i)\n",
+								newpos);
+						return 0;
+					}
 					/* This a jump; chase it. */
 					duprintf("Jump rule %u -> %u\n",
 						 pos, newpos);
@@ -514,27 +528,6 @@ cleanup_match(struct ip6t_entry_match *m
 }
 
 static inline int
-standard_check(const struct ip6t_entry_target *t,
-	       unsigned int max_offset)
-{
-	struct ip6t_standard_target *targ = (void *)t;
-
-	/* Check standard info. */
-	if (targ->verdict >= 0
-	    && targ->verdict > max_offset - sizeof(struct ip6t_entry)) {
-		duprintf("ip6t_standard_check: bad verdict (%i)\n",
-			 targ->verdict);
-		return 0;
-	}
-	if (targ->verdict < -NF_MAX_VERDICT - 1) {
-		duprintf("ip6t_standard_check: bad negative verdict (%i)\n",
-			 targ->verdict);
-		return 0;
-	}
-	return 1;
-}
-
-static inline int
 check_match(struct ip6t_entry_match *m,
 	    const char *name,
 	    const struct ip6t_ip6 *ipv6,
@@ -592,12 +585,19 @@ check_entry(struct ip6t_entry *e, const 
 		return -EINVAL;
 	}
 
+	if (e->target_offset + sizeof(struct ip6t_entry_target) >
+								e->next_offset)
+		return -EINVAL;
+
 	j = 0;
 	ret = IP6T_MATCH_ITERATE(e, check_match, name, &e->ipv6, e->comefrom, &j);
 	if (ret != 0)
 		goto cleanup_matches;
 
 	t = ip6t_get_target(e);
+	ret = -EINVAL;
+	if (e->target_offset + t->u.target_size > e->next_offset)
+			goto cleanup_matches;
 	target = try_then_request_module(xt_find_target(AF_INET6,
 							t->u.user.name,
 							t->u.user.revision),
@@ -615,12 +615,7 @@ check_entry(struct ip6t_entry *e, const 
 	if (ret)
 		goto err;
 
-	if (t->u.kernel.target == &ip6t_standard_target) {
-		if (!standard_check(t, size)) {
-			ret = -EINVAL;
-			goto cleanup_matches;
-		}
-	} else if (t->u.kernel.target->checkentry
+	if (t->u.kernel.target->checkentry
 		   && !t->u.kernel.target->checkentry(name, e, target, t->data,
 						      t->u.target_size
 						      - sizeof(*t),
@@ -770,7 +765,7 @@ translate_table(const char *name,
 
 	if (ret != 0) {
 		IP6T_ENTRY_ITERATE(entry0, newinfo->size,
-				  cleanup_entry, &i);
+				   cleanup_entry, &i);
 		return ret;
 	}
 
@@ -780,7 +775,7 @@ translate_table(const char *name,
 			memcpy(newinfo->entries[i], entry0, newinfo->size);
 	}
 
-	return ret;
+	return 0;
 }
 
 /* Gets counters. */
diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
index 3d54f24..7ecfe82 100644
--- a/net/ipv6/udp.c
+++ b/net/ipv6/udp.c
@@ -314,14 +314,13 @@ static void udpv6_err(struct sk_buff *sk
 {
 	struct ipv6_pinfo *np;
 	struct ipv6hdr *hdr = (struct ipv6hdr*)skb->data;
-	struct net_device *dev = skb->dev;
 	struct in6_addr *saddr = &hdr->saddr;
 	struct in6_addr *daddr = &hdr->daddr;
 	struct udphdr *uh = (struct udphdr*)(skb->data+offset);
 	struct sock *sk;
 	int err;
 
-	sk = udp_v6_lookup(daddr, uh->dest, saddr, uh->source, dev->ifindex);
+	sk = udp_v6_lookup(daddr, uh->dest, saddr, uh->source, inet6_iif(skb));
    
 	if (sk == NULL)
 		return;
@@ -415,7 +414,7 @@ static void udpv6_mcast_deliver(struct u
 
 	read_lock(&udp_hash_lock);
 	sk = sk_head(&udp_hash[ntohs(uh->dest) & (UDP_HTABLE_SIZE - 1)]);
-	dif = skb->dev->ifindex;
+	dif = inet6_iif(skb);
 	sk = udp_v6_mcast_next(sk, uh->dest, daddr, uh->source, saddr, dif);
 	if (!sk) {
 		kfree_skb(skb);
@@ -496,7 +495,7 @@ static int udpv6_rcv(struct sk_buff **ps
 	 * check socket cache ... must talk to Alan about his plans
 	 * for sock caches... i'll skip this for now.
 	 */
-	sk = udp_v6_lookup(saddr, uh->source, daddr, uh->dest, dev->ifindex);
+	sk = udp_v6_lookup(saddr, uh->source, daddr, uh->dest, inet6_iif(skb));
 
 	if (sk == NULL) {
 		if (!xfrm6_policy_check(NULL, XFRM_POLICY_IN, skb))
diff --git a/net/netfilter/Kconfig b/net/netfilter/Kconfig
index a9894dd..e1c27b7 100644
--- a/net/netfilter/Kconfig
+++ b/net/netfilter/Kconfig
@@ -197,7 +197,9 @@ config NETFILTER_XT_TARGET_SECMARK
 
 config NETFILTER_XT_TARGET_CONNSECMARK
 	tristate '"CONNSECMARK" target support'
-	depends on NETFILTER_XTABLES && (NF_CONNTRACK_SECMARK || IP_NF_CONNTRACK_SECMARK)
+	depends on NETFILTER_XTABLES && \
+		   ((NF_CONNTRACK && NF_CONNTRACK_SECMARK) || \
+		    (IP_NF_CONNTRACK && IP_NF_CONNTRACK_SECMARK))
 	help
 	  The CONNSECMARK target copies security markings from packets
 	  to connections, and restores security markings from connections
@@ -342,7 +344,7 @@ config NETFILTER_XT_MATCH_MULTIPORT
 
 config NETFILTER_XT_MATCH_PHYSDEV
 	tristate '"physdev" match support'
-	depends on NETFILTER_XTABLES && BRIDGE_NETFILTER
+	depends on NETFILTER_XTABLES && BRIDGE && BRIDGE_NETFILTER
 	help
 	  Physdev packet matching matches against the physical bridge ports
 	  the IP packet arrived on or will leave by.
