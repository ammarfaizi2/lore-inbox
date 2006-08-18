Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030442AbWHROol@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030442AbWHROol (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 10:44:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030447AbWHROol
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 10:44:41 -0400
Received: from nf-out-0910.google.com ([64.233.182.191]:58164 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1030441AbWHROoj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 10:44:39 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=VGG601wtFq9sAt7fli4IrKe90IZnP/pI76fSUjNIQgu7VEpVmIcoM66s9GssG+J2zR73A5ocdLD4AuzPoDKdLeX0+vh4ezjGQbeJ3tbNLbBk+AjJvmQUATsf5AuXT11K7laGP/37xd6uUZFsoyXO0RbT3Z55secNjo6IxCIqDUI=
Date: Fri, 18 Aug 2006 18:44:29 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Jan-Bernd Themann <ossthema@de.ibm.com>
Cc: netdev@vger.kernel.org, Christoph Raisch <raisch@de.ibm.com>,
       Jan-Bernd Themann <themann@de.ibm.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       linux-ppc <linuxppc-dev@ozlabs.org>, Marcus Eder <meder@de.ibm.com>,
       Thomas Klein <osstklei@de.ibm.com>, Thomas Klein <tklein@de.ibm.com>
Subject: Re: [2.6.19 PATCH 1/7] ehea: interface to network stack
Message-ID: <20060818144429.GF5201@martell.zuzino.mipt.ru>
References: <200608181329.02042.ossthema@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200608181329.02042.ossthema@de.ibm.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 18, 2006 at 01:29:01PM +0200, Jan-Bernd Themann wrote:
> --- linux-2.6.18-rc4-orig/drivers/net/ehea/ehea_main.c
> +++ kernel/drivers/net/ehea/ehea_main.c

> +static struct net_device_stats *ehea_get_stats(struct net_device *dev)
> +{
> +	int i;
> +	u64 hret = H_HARDWARE;

Useless assignment here and everywhere.

> +	u64 rx_packets = 0;
> +	struct ehea_port *port = netdev_priv(dev);
> +	struct hcp_query_ehea_port_cb_2 *cb2 = NULL;
> +	struct net_device_stats *stats = &port->stats;
> +
> +	cb2 = kzalloc(H_CB_ALIGNMENT, GFP_KERNEL);
> +	if (!cb2) {
> +		ehea_error("no mem for cb2");
> +		goto get_stat_exit;
> +	}
> +
> +	hret = ehea_h_query_ehea_port(port->adapter->handle,
> +				      port->logical_port_id,
> +				      H_PORT_CB2,
> +				      H_PORT_CB2_ALL,
> +				      cb2);

> +static inline int ehea_refill_rq1(struct ehea_port_res *pr, int index,
> +				  int nr_of_wqes)
> +{
> +	int i;
> +	int ret = 0;
> +	struct sk_buff **skb_arr_rq1 = pr->skb_arr_rq1;
> +	int max_index_mask = pr->skb_arr_rq1_len - 1;
> +
> +	if (!nr_of_wqes)
> +		return 0;
> +
> +	for (i = 0; i < nr_of_wqes; i++) {
> +		if (!skb_arr_rq1[index]) {
> +			skb_arr_rq1[index] = dev_alloc_skb(EHEA_LL_PKT_SIZE);
> +
> +			if (!skb_arr_rq1[index]) {
> +				ehea_error("no mem for skb/%d wqes filled", i);
> +				ret = -ENOMEM;
> +				break;
> +			}
> +		}
> +		index--;
> +		index &= max_index_mask;
> +	}
> +	/* Ring doorbell */
> +	ehea_update_rq1a(pr->qp, i);
> +
> +	return ret;
> +}
> +
> +static int ehea_init_fill_rq1(struct ehea_port_res *pr, int nr_rq1a)
> +{
> +	int i;
> +	int ret = 0;
> +	struct sk_buff **skb_arr_rq1 = pr->skb_arr_rq1;
> +
> +	for (i = 0; i < pr->skb_arr_rq1_len; i++) {
> +		skb_arr_rq1[i] = dev_alloc_skb(EHEA_LL_PKT_SIZE);
> +		if (!skb_arr_rq1[i]) {
> +			ehea_error("no mem for skb/%d skbs filled.", i);
> +			ret = -ENOMEM;
> +			goto nomem;
> +		}
> +	}
> +	/* Ring doorbell */
> +	ehea_update_rq1a(pr->qp, nr_rq1a);
> +nomem:
> +	return ret;
> +}
> +
> +static inline int ehea_refill_rq2_def(struct ehea_port_res *pr, int nr_of_wqes)
> +{
> +	int i;
> +	int ret = 0;
> +	struct ehea_qp *qp;
> +	struct ehea_rwqe *rwqe;
> +	struct sk_buff **skb_arr_rq2 = pr->skb_arr_rq2;
> +	int index, max_index_mask;
> +
> +	if (!nr_of_wqes)
> +		return 0;
> +
> +	qp = pr->qp;
> +
> +	index = pr->skb_rq2_index;
> +	max_index_mask = pr->skb_arr_rq2_len - 1;
> +	for (i = 0; i < nr_of_wqes; i++) {
> +		struct sk_buff *skb = dev_alloc_skb(EHEA_RQ2_PKT_SIZE
> +						    + NET_IP_ALIGN);
> +		if (!skb) {
> +			ehea_error("no mem for skb/%d wqes filled", i);
> +			ret = -ENOMEM;
> +			break;
> +		}
> +		skb_reserve(skb, NET_IP_ALIGN);
> +
> +		skb_arr_rq2[index] = skb;
> +
> +		rwqe = ehea_get_next_rwqe(qp, 2);
> +		rwqe->wr_id = EHEA_BMASK_SET(EHEA_WR_ID_TYPE, EHEA_RWQE2_TYPE)
> +		            | EHEA_BMASK_SET(EHEA_WR_ID_INDEX, index);
> +		rwqe->sg_list[0].l_key = pr->recv_mr.lkey;
> +		rwqe->sg_list[0].vaddr = (u64)skb->data;
> +		rwqe->sg_list[0].len = EHEA_RQ2_PKT_SIZE;
> +		rwqe->data_segments = 1;
> +
> +		index++;
> +		index &= max_index_mask;
> +	}
> +	pr->skb_rq2_index = index;
> +
> +	/* Ring doorbell */
> +	iosync();
> +	ehea_update_rq2a(qp, i);
> +	return ret;
> +}
> +
> +
> +static inline int ehea_refill_rq2(struct ehea_port_res *pr, int nr_of_wqes)
> +{
> +	return ehea_refill_rq2_def(pr, nr_of_wqes);
> +}
> +
> +static inline int ehea_refill_rq3_def(struct ehea_port_res *pr, int nr_of_wqes)
> +{
> +	int i;
> +	int ret = 0;
> +	struct ehea_qp *qp = pr->qp;
> +	struct ehea_rwqe *rwqe;
> +	int skb_arr_rq3_len = pr->skb_arr_rq3_len;
> +	struct sk_buff **skb_arr_rq3 = pr->skb_arr_rq3;
> +	int index, max_index_mask;
> +
> +	if (nr_of_wqes == 0)
> +		return -EINVAL;
> +        
> +	index = pr->skb_rq3_index;
> +	max_index_mask = skb_arr_rq3_len - 1;
> +	for (i = 0; i < nr_of_wqes; i++) {
> +		struct sk_buff *skb = dev_alloc_skb(EHEA_MAX_PACKET_SIZE
> +						    + NET_IP_ALIGN);
> +		if (!skb) {
> +			ehea_error("no mem for skb/%d wqes filled", i);
> +			ret = -ENOMEM;
> +			break;
> +		}
> +		skb_reserve(skb, NET_IP_ALIGN);
> +
> +		rwqe = ehea_get_next_rwqe(qp, 3);
> +
> +		skb_arr_rq3[index] = skb;
> +
> +		rwqe->wr_id = EHEA_BMASK_SET(EHEA_WR_ID_TYPE, EHEA_RWQE3_TYPE)
> +			    | EHEA_BMASK_SET(EHEA_WR_ID_INDEX, index);
> +		rwqe->sg_list[0].l_key = pr->recv_mr.lkey;
> +		rwqe->sg_list[0].vaddr = (u64)skb->data;
> +		rwqe->sg_list[0].len = EHEA_MAX_PACKET_SIZE;
> +		rwqe->data_segments = 1;
> +
> +		index++;
> +		index &= max_index_mask;
> +	}
> +	pr->skb_rq3_index = index;
> +
> +	/* Ring doorbell */
> +	iosync();
> +	ehea_update_rq3a(qp, i);
> +	return ret;
> +}

This one looks too big to be inlined as well as other similalry named
functions.

> +static inline int ehea_refill_rq3(struct ehea_port_res *pr, int nr_of_wqes)
> +{
> +	return ehea_refill_rq3_def(pr, nr_of_wqes);
> +}
> +
> +static inline int ehea_check_cqe(struct ehea_cqe *cqe, int *rq_num)
> +{
> +	*rq_num = (cqe->type & EHEA_CQE_TYPE_RQ) >> 5;
> +	if ((cqe->status & EHEA_CQE_STAT_ERR_MASK) == 0)
> +		return 0;
> +	if (((cqe->status & EHEA_CQE_STAT_ERR_TCP) != 0)
> +	    && (cqe->header_length == 0))
> +		return 0;
> +	return -EINVAL;
> +}
> +
> +static inline void ehea_fill_skb(struct net_device *dev,
> +				 struct sk_buff *skb, struct ehea_cqe *cqe)
> +{
> +	int length = cqe->num_bytes_transfered - 4;	/*remove CRC */
> +	skb_put(skb, length);
> +	skb->dev = dev;
> +	skb->ip_summed = CHECKSUM_UNNECESSARY;
> +	skb->protocol = eth_type_trans(skb, dev);
> +}

> +static int ehea_init_port_res(struct ehea_port *port, struct ehea_port_res *pr,
> +			      struct port_res_cfg *pr_cfg, int queue_token)
> +{
> +	int ret = -EINVAL;
> +	int max_rq_entries = 0;
> +	enum ehea_eq_type eq_type = EHEA_EQ;
> +	struct ehea_qp_init_attr *init_attr = NULL;
> +	struct ehea_adapter *adapter = port->adapter;
> +
> +	memset(pr, 0, sizeof(struct ehea_port_res));
> +
> +	pr->skb_arr_rq3 = NULL;
> +	pr->skb_arr_rq2 = NULL;
> +	pr->skb_arr_rq1 = NULL;
> +	pr->skb_arr_sq = NULL;
> +	pr->qp = NULL;
> +	pr->send_cq = NULL;
> +	pr->recv_cq = NULL;
> +	pr->send_eq = NULL;
> +	pr->recv_eq = NULL;

After memset unneeded. ;-)

> +static int ehea_clean_port_res(struct ehea_port *port, struct ehea_port_res *pr)

Freeing/deallocating/cleaning functions usually return void. The fact
that you always return -EINVAL only reaffirmes my belief. ;-)

> +{
> +	int i;
> +	int ret = -EINVAL;
> +
> +	ehea_destroy_qp(pr->qp);
> +	ehea_destroy_cq(pr->send_cq);
> +	ehea_destroy_cq(pr->recv_cq);
> +	ehea_destroy_eq(pr->send_eq);
> +	ehea_destroy_eq(pr->recv_eq);
> +
> +	for (i = 0; i < pr->skb_arr_rq1_len; i++) {
> +		if (pr->skb_arr_rq1[i])
> +			dev_kfree_skb(pr->skb_arr_rq1[i]);
> +	}
> +
> +	for (i = 0; i < pr->skb_arr_rq2_len; i++)
> +		if (pr->skb_arr_rq2[i])
> +			dev_kfree_skb(pr->skb_arr_rq2[i]);
> +
> +	for (i = 0; i < pr->skb_arr_rq3_len; i++)
> +		if (pr->skb_arr_rq3[i])
> +			dev_kfree_skb(pr->skb_arr_rq3[i]);
> +
> +	for (i = 0; i < pr->skb_arr_sq_len; i++)
> +		if (pr->skb_arr_sq[i])
> +			dev_kfree_skb(pr->skb_arr_sq[i]);
> +
> +	vfree(pr->skb_arr_sq);
> +	vfree(pr->skb_arr_rq1);
> +	vfree(pr->skb_arr_rq2);
> +	vfree(pr->skb_arr_rq3);
> +
> +	ehea_rem_smrs(pr);
> +	return ret;
> +}

> +static inline void write_swqe2_data(struct sk_buff *skb,
> +				    struct net_device *dev,
> +				    struct ehea_swqe *swqe,
> +				    u32 lkey)
> +{

Way too big.

> +	int skb_data_size, nfrags, headersize, i, sg1entry_contains_frag_data;
> +	struct ehea_vsgentry *sg_list;
> +	struct ehea_vsgentry *sg1entry;
> +	struct ehea_vsgentry *sgentry;
> +	u8 *imm_data;
> +	u64 tmp_addr;
> +	skb_frag_t *frag;
> +
> +	skb_data_size = skb->len - skb->data_len;
> +	nfrags = skb_shinfo(skb)->nr_frags;
> +	sg1entry = &swqe->u.immdata_desc.sg_entry;
> +	sg_list = (struct ehea_vsgentry*)&swqe->u.immdata_desc.sg_list;
> +	imm_data = &swqe->u.immdata_desc.immediate_data[0];
> +	swqe->descriptors = 0;
> +	sg1entry_contains_frag_data = 0;
> +
> +	if ((dev->features & NETIF_F_TSO) && skb_shinfo(skb)->gso_size) {
> +		/* Packet is TCP with TSO enabled */
> +		swqe->tx_control |= EHEA_SWQE_TSO;
> +		swqe->mss = skb_shinfo(skb)->gso_size;
> +		/* copy only eth/ip/tcp headers to immediate data and
> +		 * the rest of skb->data to sg1entry
> +		 */
> +		headersize = ETH_HLEN + (skb->nh.iph->ihl * 4)
> +				      + (skb->h.th->doff * 4);
> +
> +		skb_data_size = skb->len - skb->data_len;
> +
> +		if (skb_data_size >= headersize) {
> +			/* copy immediate data */
> +			memcpy(imm_data, skb->data, headersize);
> +			swqe->immediate_data_length = headersize;
> +
> +			if (skb_data_size > headersize) {
> +				/* set sg1entry data */
> +				sg1entry->l_key = lkey;
> +				sg1entry->len = skb_data_size - headersize;
> +
> +				tmp_addr = (u64)(skb->data + headersize);
> +				sg1entry->vaddr = tmp_addr;
> +				swqe->descriptors++;
> +			}
> +		} else
> +			ehea_error("cannot handle fragmented headers");
> +	} else {
> +		/* Packet is any nonTSO type
> +		 *
> +		 * Copy as much as possible skb->data to immediate data and
> +		 * the rest to sg1entry
> +		 */
> +		if (skb_data_size >= SWQE2_MAX_IMM) {
> +			/* copy immediate data */
> +			memcpy(imm_data, skb->data, SWQE2_MAX_IMM);
> +
> +			swqe->immediate_data_length = SWQE2_MAX_IMM;
> +
> +			if (skb_data_size > SWQE2_MAX_IMM) {
> +				/* copy sg1entry data */
> +				sg1entry->l_key = lkey;
> +				sg1entry->len = skb_data_size - SWQE2_MAX_IMM;
> +				tmp_addr = (u64)(skb->data + SWQE2_MAX_IMM);
> +				sg1entry->vaddr = tmp_addr;
> +				swqe->descriptors++;
> +			}
> +		} else {
> +			memcpy(imm_data, skb->data, skb_data_size);
> +			swqe->immediate_data_length = skb_data_size;
> +		}
> +	}
> +
> +	/* write descriptors */
> +	if (nfrags > 0) {
> +		if (swqe->descriptors == 0) {
> +			/* sg1entry not yet used */
> +			frag = &skb_shinfo(skb)->frags[0];
> +
> +			/* copy sg1entry data */
> +			sg1entry->l_key = lkey;
> +			sg1entry->len = frag->size;
> +			tmp_addr =  (u64)(page_address(frag->page)
> +					  + frag->page_offset);
> +			sg1entry->vaddr = tmp_addr;
> +			swqe->descriptors++;
> +			sg1entry_contains_frag_data = 1;
> +		}
> +
> +		for (i = sg1entry_contains_frag_data; i < nfrags; i++) {
> +
> +			frag = &skb_shinfo(skb)->frags[i];
> +			sgentry = &sg_list[i - sg1entry_contains_frag_data];
> +
> +			sgentry->l_key = lkey;
> +			sgentry->len = frag->size;
> +
> +			tmp_addr = (u64)(page_address(frag->page)
> +					 + frag->page_offset);
> +			sgentry->vaddr = tmp_addr;
> +		}
> +	}
> +}

Got it?

> +static inline void ehea_xmit2(struct sk_buff *skb,
> +			      struct net_device *dev, struct ehea_swqe *swqe,
> +			      u32 lkey)
> +{
> +	int nfrags;
> +	nfrags = skb_shinfo(skb)->nr_frags;
> +
> +	if (skb->protocol == htons(ETH_P_IP)) {
> +		/* IPv4 */
> +		swqe->tx_control |= EHEA_SWQE_CRC
> +				 | EHEA_SWQE_IP_CHECKSUM
> +				 | EHEA_SWQE_TCP_CHECKSUM
> +				 | EHEA_SWQE_IMM_DATA_PRESENT
> +				 | EHEA_SWQE_DESCRIPTORS_PRESENT;
> +
> +		write_ip_start_end(swqe, skb);
> +
> +		if (skb->nh.iph->protocol == IPPROTO_UDP) {
> +			if ((skb->nh.iph->frag_off & IP_MF)
> +			    || (skb->nh.iph->frag_off & IP_OFFSET))
> +				/* IP fragment, so don't change cs */
> +				swqe->tx_control &= ~EHEA_SWQE_TCP_CHECKSUM;
> +			else
> +				write_udp_offset_end(swqe, skb);
> +
> +		} else if (skb->nh.iph->protocol == IPPROTO_TCP) {
> +			write_tcp_offset_end(swqe, skb);
> +		}
> +
> +		/* icmp (big data) and ip segmentation packets (all other ip
> +		   packets) do not require any special handling */
> +
> +	} else {
> +		/* Other Ethernet Protocol */
> +		swqe->tx_control |= EHEA_SWQE_CRC
> +				 | EHEA_SWQE_IMM_DATA_PRESENT
> +				 | EHEA_SWQE_DESCRIPTORS_PRESENT;
> +	}
> +
> +	write_swqe2_data(skb, dev, swqe, lkey);
> +}
> +
> +static inline void ehea_xmit3(struct sk_buff *skb,
> +			      struct net_device *dev, struct ehea_swqe *swqe)
> +{
> +	int i;
> +	skb_frag_t *frag;
> +	int nfrags = skb_shinfo(skb)->nr_frags;
> +	u8 *imm_data = &swqe->u.immdata_nodesc.immediate_data[0];
> +
> +	if (likely(skb->protocol == htons(ETH_P_IP))) {
> +		/* IPv4 */
> +		write_ip_start_end(swqe, skb);
> +
> +		if (skb->nh.iph->protocol == IPPROTO_TCP) {
> +			swqe->tx_control |= EHEA_SWQE_CRC
> +					 | EHEA_SWQE_IP_CHECKSUM
> +					 | EHEA_SWQE_TCP_CHECKSUM
> +					 | EHEA_SWQE_IMM_DATA_PRESENT;
> +
> +			write_tcp_offset_end(swqe, skb);
> +
> +		} else if (skb->nh.iph->protocol == IPPROTO_UDP) {
> +			if ((skb->nh.iph->frag_off & IP_MF)
> +			    || (skb->nh.iph->frag_off & IP_OFFSET))
> +				/* IP fragment, so don't change cs */
> +				swqe->tx_control |= EHEA_SWQE_CRC
> +						 | EHEA_SWQE_IMM_DATA_PRESENT;
> +			else {
> +				swqe->tx_control |= EHEA_SWQE_CRC
> +						 | EHEA_SWQE_IP_CHECKSUM
> +						 | EHEA_SWQE_TCP_CHECKSUM
> +						 | EHEA_SWQE_IMM_DATA_PRESENT;
> +
> +				write_udp_offset_end(swqe, skb);
> +			}
> +		} else {
> +			/* icmp (big data) and
> +			   ip segmentation packets (all other ip packets) */
> +			swqe->tx_control |= EHEA_SWQE_CRC
> +					 | EHEA_SWQE_IP_CHECKSUM
> +					 | EHEA_SWQE_IMM_DATA_PRESENT;
> +		}
> +	} else {
> +		/* Other Ethernet Protocol */
> +		swqe->tx_control |= EHEA_SWQE_CRC | EHEA_SWQE_IMM_DATA_PRESENT;
> +	}
> +	/* copy (immediate) data */
> +	if (nfrags == 0) {
> +		/* data is in a single piece */
> +		memcpy(imm_data, skb->data, skb->len);
> +	} else {
> +		/* first copy data from the skb->data buffer ... */
> +		memcpy(imm_data, skb->data, skb->len - skb->data_len);
> +		imm_data += skb->len - skb->data_len;
> +
> +		/* ... then copy data from the fragments */
> +		for (i = 0; i < nfrags; i++) {
> +			frag = &skb_shinfo(skb)->frags[i];
> +			memcpy(imm_data,
> +			       page_address(frag->page) + frag->page_offset,
> +			       frag->size);
> +			imm_data += frag->size;
> +		}
> +	}
> +	swqe->immediate_data_length = skb->len;
> +	dev_kfree_skb(skb);
> +}

Ditto.

> +static void ehea_vlan_rx_register(struct net_device *dev,
> +				  struct vlan_group *grp)
> +{
> +	u64 hret = H_HARDWARE;
> +	struct hcp_query_ehea_port_cb_1 *cb1 = NULL;
> +	struct ehea_port *port = netdev_priv(dev);
> +	struct ehea_adapter *adapter = port->adapter;
> +
> +	port->vgrp = grp;
> +
> +	cb1 = kzalloc(H_CB_ALIGNMENT, GFP_KERNEL);
> +	if (!cb1) {
> +		ehea_error("no mem for cb1");
> +		goto vlan_reg_exit;
> +	}
> +
> +	if (grp)
> +		memset(cb1->vlan_filter, 0, sizeof(cb1->vlan_filter));
> +	else
> +		memset(cb1->vlan_filter, 1, sizeof(cb1->vlan_filter));

Just to be sure, this should be 1 not 0xff?

> +	hret = ehea_h_modify_ehea_port(adapter->handle,
> +				       port->logical_port_id,
> +				       H_PORT_CB1,
> +				       H_PORT_CB1_ALL,
> +				       cb1);
> +	if (hret != H_SUCCESS)
> +		ehea_error("modify_ehea_port failed");
> +
> +	kfree(cb1);
> +
> +vlan_reg_exit:
> +	return;
> +}

> +void ehea_clean_all_port_res(struct ehea_port *port)
> +{
> +	int ret;
> +	int i;
> +	for(i = 0; i < port->num_def_qps + port->num_tx_qps; i++)
> +		ehea_clean_port_res(port, &port->port_res[i]);
> +
> +	ret = ehea_destroy_eq(port->qp_eq);
> +}

ret is entirely useless.

> +int __init ehea_module_init(void)
static

> +{
> +	int ret = -EINVAL;
> +
> +	printk("IBM eHEA Ethernet Device Driver (Release %s)\n", DRV_VERSION);
> +
> +	ret = ibmebus_register_driver(&ehea_driver);
> +	if (ret) {
> +		ehea_error("failed registering eHEA device driver on ebus");
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}

Pass ret to upper layer. Simplest way is:

	static int __init ehea_module_init(void)
	{
		return ibmebus_register_driver(&ehea_driver);
	}

