Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262446AbVC2HXI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262446AbVC2HXI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 02:23:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262560AbVC2HXI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 02:23:08 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:31930 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S262446AbVC2HCw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 02:02:52 -0500
Message-ID: <4248FD8D.6030208@pobox.com>
Date: Tue, 29 Mar 2005 02:02:37 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: Andrew Morton <akpm@osdl.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>,
       Netdev <netdev@oss.sgi.com>
Subject: Re: [PATCH] s390: qeth tcp segmentation offload
References: <200503290533.j2T5X0ZZ028790@hera.kernel.org>
In-Reply-To: <200503290533.j2T5X0ZZ028790@hera.kernel.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linux Kernel Mailing List wrote:
> ChangeSet 1.2231.1.121, 2005/03/28 19:50:10-08:00, pavlic@de.ibm.com
> 
> 	[PATCH] s390: qeth tcp segmentation offload
> 	
> 	Add support for TCP Segmentation Offload to the qeth network driver.
> 	
> 	Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
> 	Signed-off-by: Andrew Morton <akpm@osdl.org>
> 	Signed-off-by: Linus Torvalds <torvalds@osdl.org>
> 
> +static inline void
> +qeth_eddp_copy_data_tcp(char *dst, struct qeth_eddp_data *eddp, int len,
> +			u32 *hcsum)
> +{
> +	struct skb_frag_struct *frag;
> +	int left_in_frag;
> +	int copy_len;
> +	u8 *src;
> +
> +	QETH_DBF_TEXT(trace, 5, "eddpcdtc");
> +	if (skb_shinfo(eddp->skb)->nr_frags == 0) {
> +		memcpy(dst, eddp->skb->data + eddp->skb_offset, len);
> +		*hcsum = csum_partial(eddp->skb->data + eddp->skb_offset, len,
> +				      *hcsum);
> +		eddp->skb_offset += len;
> +	} else {
> +		while (len > 0) {
> +			if (eddp->frag < 0) {
> +				/* we're in skb->data */
> +				left_in_frag = qeth_get_skb_data_len(eddp->skb)
> +						- eddp->skb_offset;
> +				src = eddp->skb->data + eddp->skb_offset;
> +			} else {
> +				frag = &skb_shinfo(eddp->skb)->
> +					frags[eddp->frag];
> +				left_in_frag = frag->size - eddp->frag_offset;
> +				src = (u8 *)(
> +					(page_to_pfn(frag->page) << PAGE_SHIFT)+
> +					frag->page_offset + eddp->frag_offset);
> +			}
> +			if (left_in_frag <= 0) {
> +				eddp->frag++;
> +				eddp->frag_offset = 0;
> +				continue;
> +			}
> +			copy_len = min(left_in_frag, len);
> +			memcpy(dst, src, copy_len);
> +			*hcsum = csum_partial(src, copy_len, *hcsum);
> +			dst += copy_len;
> +			eddp->frag_offset += copy_len;
> +			eddp->skb_offset += copy_len;
> +			len -= copy_len;
> +		}
> +	}
> +}

Please help me understand:  why add all this TSO code (zerocopy), if you 
are adding memcpy() under the hood?

Was this reviewed on netdev?  or by any network developer?

Overall this patch adds a whole lot of code that must be VERY intimate 
with the net stack, a huge maintenance burden that is likely to be rife 
with out-of-date code and bugs over time.



> +static inline void
> +qeth_eddp_create_segment_data_tcp(struct qeth_eddp_context *ctx,
> +				  struct qeth_eddp_data *eddp, int data_len,
> +				  u32 hcsum)
> +{
> +	u8 *page;
> +	int page_remainder;
> +	int page_offset;
> +	struct qeth_eddp_element *element;
> +	int first_lap = 1;
> +
> +	QETH_DBF_TEXT(trace, 5, "eddpcsdt");
> +	page = ctx->pages[ctx->offset >> PAGE_SHIFT];
> +	page_offset = ctx->offset % PAGE_SIZE;
> +	element = &ctx->elements[ctx->num_elements];
> +	while (data_len){
> +		page_remainder = PAGE_SIZE - page_offset;
> +		if (page_remainder < data_len){
> +			qeth_eddp_copy_data_tcp(page + page_offset, eddp,
> +						page_remainder, &hcsum);
> +			element->length += page_remainder;
> +			if (first_lap)
> +				element->flags = SBAL_FLAGS_FIRST_FRAG;
> +			else
> +				element->flags = SBAL_FLAGS_MIDDLE_FRAG;
> +			ctx->num_elements++;
> +			element++;
> +			data_len -= page_remainder;
> +			ctx->offset += page_remainder;
> +			page = ctx->pages[ctx->offset >> PAGE_SHIFT];
> +			page_offset = 0;
> +			element->addr = page + page_offset;
> +		} else {
> +			qeth_eddp_copy_data_tcp(page + page_offset, eddp,
> +						data_len, &hcsum);
> +			element->length += data_len;
> +			if (!first_lap)
> +				element->flags = SBAL_FLAGS_LAST_FRAG;
> +			ctx->num_elements++;
> +			ctx->offset += data_len;
> +			data_len = 0;
> +		}
> +		first_lap = 0;
> +	}
> +	((struct tcphdr *)eddp->th_in_ctx)->check = csum_fold(hcsum);
> +}
> +
> +static inline u32
> +qeth_eddp_check_tcp4_hdr(struct qeth_eddp_data *eddp, int data_len)
> +{
> +	u32 phcsum; /* pseudo header checksum */
> +
> +	QETH_DBF_TEXT(trace, 5, "eddpckt4");
> +	eddp->th.tcp.h.check = 0;
> +	/* compute pseudo header checksum */
> +	phcsum = csum_tcpudp_nofold(eddp->nh.ip4.h.saddr, eddp->nh.ip4.h.daddr,
> +				    eddp->thl + data_len, IPPROTO_TCP, 0);
> +	/* compute checksum of tcp header */
> +	return csum_partial((u8 *)&eddp->th, eddp->thl, phcsum);
> +}
> +
> +static inline u32
> +qeth_eddp_check_tcp6_hdr(struct qeth_eddp_data *eddp, int data_len)
> +{
> +	u32 proto;
> +	u32 phcsum; /* pseudo header checksum */
> +
> +	QETH_DBF_TEXT(trace, 5, "eddpckt6");
> +	eddp->th.tcp.h.check = 0;
> +	/* compute pseudo header checksum */
> +	phcsum = csum_partial((u8 *)&eddp->nh.ip6.h.saddr,
> +			      sizeof(struct in6_addr), 0);
> +	phcsum = csum_partial((u8 *)&eddp->nh.ip6.h.daddr,
> +			      sizeof(struct in6_addr), phcsum);
> +	proto = htonl(IPPROTO_TCP);
> +	phcsum = csum_partial((u8 *)&proto, sizeof(u32), phcsum);
> +	return phcsum;
> +}
> +
> +static inline struct qeth_eddp_data *
> +qeth_eddp_create_eddp_data(struct qeth_hdr *qh, u8 *nh, u8 nhl, u8 *th, u8 thl)
> +{
> +	struct qeth_eddp_data *eddp;
> +
> +	QETH_DBF_TEXT(trace, 5, "eddpcrda");
> +	eddp = kmalloc(sizeof(struct qeth_eddp_data), GFP_ATOMIC);
> +	if (eddp){
> +		memset(eddp, 0, sizeof(struct qeth_eddp_data));
> +		eddp->nhl = nhl;
> +		eddp->thl = thl;
> +		memcpy(&eddp->qh, qh, sizeof(struct qeth_hdr));
> +		memcpy(&eddp->nh, nh, nhl);
> +		memcpy(&eddp->th, th, thl);
> +		eddp->frag = -1; /* initially we're in skb->data */
> +	}
> +	return eddp;
> +}
> +
> +static inline void
> +__qeth_eddp_fill_context_tcp(struct qeth_eddp_context *ctx,
> +			     struct qeth_eddp_data *eddp)
> +{
> +	struct tcphdr *tcph;
> +	int data_len;
> +	u32 hcsum;
> +
> +	QETH_DBF_TEXT(trace, 5, "eddpftcp");
> +	eddp->skb_offset = sizeof(struct qeth_hdr) + eddp->nhl + eddp->thl;
> +	tcph = eddp->skb->h.th;
> +	while (eddp->skb_offset < eddp->skb->len) {
> +		data_len = min((int)skb_shinfo(eddp->skb)->tso_size,
> +			       (int)(eddp->skb->len - eddp->skb_offset));
> +		/* prepare qdio hdr */
> +		if (eddp->qh.hdr.l2.id == QETH_HEADER_TYPE_LAYER2){
> +			eddp->qh.hdr.l2.pkt_length = data_len + ETH_HLEN +
> +						     eddp->nhl + eddp->thl -
> +						     sizeof(struct qeth_hdr);
> +#ifdef CONFIG_QETH_VLAN
> +			if (eddp->mac.h_proto == __constant_htons(ETH_P_8021Q))
> +				eddp->qh.hdr.l2.pkt_length += VLAN_HLEN;
> +#endif /* CONFIG_QETH_VLAN */
> +		} else
> +			eddp->qh.hdr.l3.length = data_len + eddp->nhl +
> +						 eddp->thl;
> +		/* prepare ip hdr */
> +		if (eddp->skb->protocol == ETH_P_IP){
> +			eddp->nh.ip4.h.tot_len = data_len + eddp->nhl +
> +						 eddp->thl;
> +			eddp->nh.ip4.h.check = 0;
> +			eddp->nh.ip4.h.check =
> +				ip_fast_csum((u8 *)&eddp->nh.ip4.h,
> +						eddp->nh.ip4.h.ihl);
> +		} else
> +			eddp->nh.ip6.h.payload_len = data_len + eddp->thl;
> +		/* prepare tcp hdr */
> +		if (data_len == (eddp->skb->len - eddp->skb_offset)){
> +			/* last segment -> set FIN and PSH flags */
> +			eddp->th.tcp.h.fin = tcph->fin;
> +			eddp->th.tcp.h.psh = tcph->psh;
> +		}
> +		if (eddp->skb->protocol == ETH_P_IP)
> +			hcsum = qeth_eddp_check_tcp4_hdr(eddp, data_len);
> +		else
> +			hcsum = qeth_eddp_check_tcp6_hdr(eddp, data_len);
> +		/* fill the next segment into the context */
> +		qeth_eddp_create_segment_hdrs(ctx, eddp);
> +		qeth_eddp_create_segment_data_tcp(ctx, eddp, data_len, hcsum);
> +		if (eddp->skb_offset >= eddp->skb->len)
> +			break;
> +		/* prepare headers for next round */
> +		if (eddp->skb->protocol == ETH_P_IP)
> +			eddp->nh.ip4.h.id++;
> +		eddp->th.tcp.h.seq += data_len;
> +	}
> +}
> +
> +static inline int
> +qeth_eddp_fill_context_tcp(struct qeth_eddp_context *ctx,
> +			   struct sk_buff *skb, struct qeth_hdr *qhdr)
> +{
> +	struct qeth_eddp_data *eddp = NULL;
> +
> +	QETH_DBF_TEXT(trace, 5, "eddpficx");
> +	/* create our segmentation headers and copy original headers */
> +	if (skb->protocol == ETH_P_IP)
> +		eddp = qeth_eddp_create_eddp_data(qhdr, (u8 *)skb->nh.iph,
> +				skb->nh.iph->ihl*4,
> +				(u8 *)skb->h.th, skb->h.th->doff*4);
> +	else
> +		eddp = qeth_eddp_create_eddp_data(qhdr, (u8 *)skb->nh.ipv6h,
> +				sizeof(struct ipv6hdr),
> +				(u8 *)skb->h.th, skb->h.th->doff*4);
> +
> +	if (eddp == NULL) {
> +		QETH_DBF_TEXT(trace, 2, "eddpfcnm");
> +		return -ENOMEM;
> +	}
> +	if (qhdr->hdr.l2.id == QETH_HEADER_TYPE_LAYER2) {
> +		memcpy(&eddp->mac, eth_hdr(skb), ETH_HLEN);
> +#ifdef CONFIG_QETH_VLAN
> +		if (eddp->mac.h_proto == __constant_htons(ETH_P_8021Q)) {
> +			eddp->vlan[0] = __constant_htons(skb->protocol);
> +			eddp->vlan[1] = htons(vlan_tx_tag_get(skb));
> +		}
> +#endif /* CONFIG_QETH_VLAN */
> +	}
> +	/* the next flags will only be set on the last segment */
> +	eddp->th.tcp.h.fin = 0;
> +	eddp->th.tcp.h.psh = 0;
> +	eddp->skb = skb;
> +	/* begin segmentation and fill context */
> +	__qeth_eddp_fill_context_tcp(ctx, eddp);
> +	kfree(eddp);
> +	return 0;
> +}
> +
> +static inline void
> +qeth_eddp_calc_num_pages(struct qeth_eddp_context *ctx, struct sk_buff *skb,
> +			 int hdr_len)
> +{
> +	int skbs_per_page;
> +
> +	QETH_DBF_TEXT(trace, 5, "eddpcanp");
> +	/* can we put multiple skbs in one page? */
> +	skbs_per_page = PAGE_SIZE / (skb_shinfo(skb)->tso_size + hdr_len);
> +	if (skbs_per_page > 1){
> +		ctx->num_pages = (skb_shinfo(skb)->tso_segs + 1) /
> +				 skbs_per_page + 1;
> +		ctx->elements_per_skb = 1;
> +	} else {
> +		/* no -> how many elements per skb? */
> +		ctx->elements_per_skb = (skb_shinfo(skb)->tso_size + hdr_len +
> +				     PAGE_SIZE) >> PAGE_SHIFT;
> +		ctx->num_pages = ctx->elements_per_skb *
> +				 (skb_shinfo(skb)->tso_segs + 1);
> +	}
> +	ctx->num_elements = ctx->elements_per_skb *
> +			    (skb_shinfo(skb)->tso_segs + 1);
> +}
> +
> +static inline struct qeth_eddp_context *
> +qeth_eddp_create_context_generic(struct qeth_card *card, struct sk_buff *skb,
> +				 int hdr_len)
> +{
> +	struct qeth_eddp_context *ctx = NULL;
> +	u8 *addr;
> +	int i;
> +
> +	QETH_DBF_TEXT(trace, 5, "creddpcg");
> +	/* create the context and allocate pages */
> +	ctx = kmalloc(sizeof(struct qeth_eddp_context), GFP_ATOMIC);
> +	if (ctx == NULL){
> +		QETH_DBF_TEXT(trace, 2, "ceddpcn1");
> +		return NULL;
> +	}
> +	memset(ctx, 0, sizeof(struct qeth_eddp_context));
> +	ctx->type = QETH_LARGE_SEND_EDDP;
> +	qeth_eddp_calc_num_pages(ctx, skb, hdr_len);
> +	if (ctx->elements_per_skb > QETH_MAX_BUFFER_ELEMENTS(card)){
> +		QETH_DBF_TEXT(trace, 2, "ceddpcis");
> +		kfree(ctx);
> +		return NULL;
> +	}
> +	ctx->pages = kmalloc(ctx->num_pages * sizeof(u8 *), GFP_ATOMIC);
> +	if (ctx->pages == NULL){
> +		QETH_DBF_TEXT(trace, 2, "ceddpcn2");
> +		kfree(ctx);
> +		return NULL;
> +	}
> +	memset(ctx->pages, 0, ctx->num_pages * sizeof(u8 *));
> +	for (i = 0; i < ctx->num_pages; ++i){
> +		addr = (u8 *)__get_free_page(GFP_ATOMIC);
> +		if (addr == NULL){
> +			QETH_DBF_TEXT(trace, 2, "ceddpcn3");
> +			ctx->num_pages = i;
> +			qeth_eddp_free_context(ctx);
> +			return NULL;
> +		}
> +		memset(addr, 0, PAGE_SIZE);
> +		ctx->pages[i] = addr;
> +	}
> +	ctx->elements = kmalloc(ctx->num_elements *
> +				sizeof(struct qeth_eddp_element), GFP_ATOMIC);
> +	if (ctx->elements == NULL){
> +		QETH_DBF_TEXT(trace, 2, "ceddpcn4");
> +		qeth_eddp_free_context(ctx);
> +		return NULL;
> +	}
> +	memset(ctx->elements, 0,
> +	       ctx->num_elements * sizeof(struct qeth_eddp_element));
> +	/* reset num_elements; will be incremented again in fill_buffer to
> +	 * reflect number of actually used elements */
> +	ctx->num_elements = 0;
> +	return ctx;
> +}
> +
> +static inline struct qeth_eddp_context *
> +qeth_eddp_create_context_tcp(struct qeth_card *card, struct sk_buff *skb,
> +			     struct qeth_hdr *qhdr)
> +{
> +	struct qeth_eddp_context *ctx = NULL;
> +
> +	QETH_DBF_TEXT(trace, 5, "creddpct");
> +	if (skb->protocol == ETH_P_IP)
> +		ctx = qeth_eddp_create_context_generic(card, skb,
> +			sizeof(struct qeth_hdr) + skb->nh.iph->ihl*4 +
> +			skb->h.th->doff*4);
> +	else if (skb->protocol == ETH_P_IPV6)
> +		ctx = qeth_eddp_create_context_generic(card, skb,
> +			sizeof(struct qeth_hdr) + sizeof(struct ipv6hdr) +
> +			skb->h.th->doff*4);
> +	else
> +		QETH_DBF_TEXT(trace, 2, "cetcpinv");
> +
> +	if (ctx == NULL) {
> +		QETH_DBF_TEXT(trace, 2, "creddpnl");
> +		return NULL;
> +	}
> +	if (qeth_eddp_fill_context_tcp(ctx, skb, qhdr)){
> +		QETH_DBF_TEXT(trace, 2, "ceddptfe");
> +		qeth_eddp_free_context(ctx);
> +		return NULL;
> +	}
> +	atomic_set(&ctx->refcnt, 1);
> +	return ctx;
> +}
> +
> +struct qeth_eddp_context *
> +qeth_eddp_create_context(struct qeth_card *card, struct sk_buff *skb,
> +			 struct qeth_hdr *qhdr)
> +{
> +	QETH_DBF_TEXT(trace, 5, "creddpc");
> +	switch (skb->sk->sk_protocol){
> +	case IPPROTO_TCP:
> +		return qeth_eddp_create_context_tcp(card, skb, qhdr);
> +	default:
> +		QETH_DBF_TEXT(trace, 2, "eddpinvp");
> +	}
> +	return NULL;
> +}
> +
> +
> diff -Nru a/drivers/s390/net/qeth_eddp.h b/drivers/s390/net/qeth_eddp.h
> --- /dev/null	Wed Dec 31 16:00:00 196900
> +++ b/drivers/s390/net/qeth_eddp.h	2005-03-28 21:33:12 -08:00
> @@ -0,0 +1,85 @@
> +/*
> + * linux/drivers/s390/net/qeth_eddp.c ($Revision: 1.5 $)
> + *
> + * Header file for qeth enhanced device driver pakcing.
> + *
> + * Copyright 2004 IBM Corporation
> + *
> + *    Author(s): Thomas Spatzier <tspat@de.ibm.com>
> + *
> + *    $Revision: 1.5 $	 $Date: 2005/03/24 09:04:18 $
> + *
> + */
> +#ifndef __QETH_EDDP_H__
> +#define __QETH_EDDP_H__
> +
> +struct qeth_eddp_element {
> +	u32 flags;
> +	u32 length;
> +	void *addr;
> +};
> +
> +struct qeth_eddp_context {
> +	atomic_t refcnt;
> +	enum qeth_large_send_types type;
> +	int num_pages;			    /* # of allocated pages */
> +	u8 **pages;			    /* pointers to pages */
> +	int offset;			    /* offset in ctx during creation */
> +	int num_elements;		    /* # of required 'SBALEs' */
> +	struct qeth_eddp_element *elements; /* array of 'SBALEs' */
> +	int elements_per_skb;		    /* # of 'SBALEs' per skb **/
> +};
> +
> +struct qeth_eddp_context_reference {
> +	struct list_head list;
> +	struct qeth_eddp_context *ctx;
> +};
> +
> +extern struct qeth_eddp_context *
> +qeth_eddp_create_context(struct qeth_card *,struct sk_buff *,struct qeth_hdr *);
> +
> +extern void
> +qeth_eddp_put_context(struct qeth_eddp_context *);
> +
> +extern int
> +qeth_eddp_fill_buffer(struct qeth_qdio_out_q *,struct qeth_eddp_context *,int);
> +
> +extern void
> +qeth_eddp_buf_release_contexts(struct qeth_qdio_out_buffer *);
> +
> +extern int
> +qeth_eddp_check_buffers_for_context(struct qeth_qdio_out_q *,
> +				    struct qeth_eddp_context *);
> +/*
> + * Data used for fragmenting a IP packet.
> + */
> +struct qeth_eddp_data {
> +	struct qeth_hdr qh;
> +	struct ethhdr mac;
> +	u16 vlan[2];
> +	union {
> +		struct {
> +			struct iphdr h;
> +			u8 options[40];
> +		} ip4;
> +		struct {
> +			struct ipv6hdr h;
> +		} ip6;
> +	} nh;
> +	u8 nhl;
> +	void *nh_in_ctx;	/* address of nh within the ctx */
> +	union {
> +		struct {
> +			struct tcphdr h;
> +			u8 options[40];
> +		} tcp;
> +	} th;
> +	u8 thl;
> +	void *th_in_ctx;	/* address of th within the ctx */
> +	struct sk_buff *skb;
> +	int skb_offset;
> +	int frag;
> +	int frag_offset;
> +} __attribute__ ((packed));
> +
> +#endif /* __QETH_EDDP_H__ */
> diff -Nru a/drivers/s390/net/qeth_main.c b/drivers/s390/net/qeth_main.c
> --- a/drivers/s390/net/qeth_main.c	2005-03-28 21:33:12 -08:00
> +++ b/drivers/s390/net/qeth_main.c	2005-03-28 21:33:12 -08:00
> @@ -61,6 +61,7 @@
