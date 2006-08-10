Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161338AbWHJP17@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161338AbWHJP17 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 11:27:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161345AbWHJP17
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 11:27:59 -0400
Received: from mtagate6.de.ibm.com ([195.212.29.155]:12075 "EHLO
	mtagate6.de.ibm.com") by vger.kernel.org with ESMTP
	id S1161338AbWHJP15 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 11:27:57 -0400
Message-ID: <44DB4782.9050602@de.ibm.com>
Date: Thu, 10 Aug 2006 16:49:38 +0200
From: Jan-Bernd Themann <ossthema@de.ibm.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060719)
MIME-Version: 1.0
To: Alexey Dobriyan <adobriyan@gmail.com>
CC: netdev@vger.kernel.org, linuxppc-dev@ozlabs.org,
       linux-kernel@vger.kernel.org, Marcus Eder <meder@de.ibm.com>,
       Christoph Raisch <raisch@de.ibm.com>, Thomas Klein <tklein@de.ibm.com>
Subject: Re: [PATCH 1/6] ehea: interface to network stack
References: <44D99EFC.3000105@de.ibm.com> <20060809130646.GA6846@martell.zuzino.mipt.ru>
In-Reply-To: <20060809130646.GA6846@martell.zuzino.mipt.ru>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

thanks for your comments!

We'll post a modified patch very soon.

Jan-Bernd

Alexey Dobriyan wrote:
> On Wed, Aug 09, 2006 at 10:38:20AM +0200, Jan-Bernd Themann wrote:
>> --- linux-2.6.18-rc4-orig/drivers/net/ehea/ehea_main.c
>> +++ kernel/drivers/net/ehea/ehea_main.c
> 
>> +static inline u64 get_swqe_addr(u64 tmp_addr, int addr_seg)
>> +{
>> +	u64 addr;
>> +	addr = tmp_addr;
>> +	return addr;
>> +}
>> +
>> +static inline u64 get_rwqe_addr(u64 tmp_addr)
>> +{
>> +	return tmp_addr;
>> +}
> 
> The point of this exercise?

has been removed

> 
>> +static inline int ehea_refill_rq3_def(struct ehea_port_res *pr, int nr_of_wqes)
> 
> Way too big to be inline function.
> 
>> +{
>> +	int i;
>> +	int ret = 0;
>> +	struct ehea_qp *qp;
>> +	struct ehea_rwqe *rwqe;
>> +	int skb_arr_rq3_len = pr->skb_arr_rq3_len;
>> +	struct sk_buff **skb_arr_rq3 = pr->skb_arr_rq3;
>> +	EDEB_EN(8, "pr=%p, nr_of_wqes=%d", pr, nr_of_wqes);
>> +	if (nr_of_wqes == 0)
>> +		return -EINVAL;
>> +	qp = pr->qp;
>> +	for (i = 0; i < nr_of_wqes; i++) {
>> +		int index = pr->skb_rq3_index++;
>> +		struct sk_buff *skb = dev_alloc_skb(EHEA_MAX_PACKET_SIZE
>> +						    + NET_IP_ALIGN);
>> +
>> +		if (!skb) {
>> +			EDEB_ERR(4, "No memory for skb. Only %d rwqe 
>> filled.",
>> +				 i);
>> +			ret = -ENOMEM;
>> +			break;
>> +		}
>> +		skb_reserve(skb, NET_IP_ALIGN);
>> +
>> +		rwqe = ehea_get_next_rwqe(qp, 3);
>> +		pr->skb_rq3_index %= skb_arr_rq3_len;
>> +		skb_arr_rq3[index] = skb;
>> +		rwqe->wr_id = EHEA_BMASK_SET(EHEA_WR_ID_TYPE, 
>> EHEA_RWQE3_TYPE)
>> +		    | EHEA_BMASK_SET(EHEA_WR_ID_INDEX, index);
>> +		rwqe->sg_list[0].l_key = ehea_get_recv_lkey(pr);
>> +		rwqe->sg_list[0].vaddr = get_rwqe_addr((u64)skb->data);
>> +		rwqe->sg_list[0].len = EHEA_MAX_PACKET_SIZE;
>> +		rwqe->data_segments = 1;
>> +	}
>> +
>> +	/* Ring doorbell */
>> +	iosync();
>> +	ehea_update_rq3a(qp, i);
>> +	EDEB_EX(8, "");
>> +	return ret;
>> +}
>> +
>> +
>> +static inline int ehea_refill_rq3(struct ehea_port_res *pr, int nr_of_wqes)
>> +{
>> +	return ehea_refill_rq3_def(pr, nr_of_wqes);
>> +}
> 
> ehea_refill_rq3[123] appears to be 1:1 wrappers around
> ehea_refill_rq3[123]_def. Any idea behind them?
> 

introduced for near future features

>> +	init_attr = (struct ehea_qp_init_attr*)
>> +	    kzalloc(sizeof(struct ehea_qp_init_attr), GFP_KERNEL);
> 
> Useless cast.
> 

removed

>> +	pr->skb_arr_sq = (struct sk_buff**)vmalloc(sizeof(struct sk_buff*)
>> +						    * (max_rq_entries + 1));
> 
> Useless cast

removed
> 
>> +	pr->skb_arr_rq1 = (struct sk_buff**)vmalloc(sizeof(struct sk_buff*)
>> +						     * (max_rq_entries + 1));
> 
>> +	pr->skb_arr_rq2 = (struct sk_buff**)vmalloc(sizeof(struct sk_buff*)
>> +						     * (max_rq_entries + 1));
> 
>> +	pr->skb_arr_rq3 = (struct sk_buff**)vmalloc(sizeof(struct sk_buff*)
>> +						     * (max_rq_entries + 1));
> 
>> +static int ehea_ioctl(struct net_device *dev, struct ifreq *ifr, int cmd)
>> +{
>> +	EDEB_ERR(4, "ioctl not supported: dev=%s cmd=%d", dev->name, cmd);
> 
> Then copy NULL into ->do_ioctl!
> 

done

>> +	return -EOPNOTSUPP;
>> +}
> 
>> +	ehea_port_cb_0 = kzalloc(H_CB_ALIGNMENT, GFP_KERNEL);
>> +
>> +	if (!ehea_port_cb_0) {
>> +		EDEB_ERR(4, "No memory for ehea_port control block");
>> +		ret = -ENOMEM;
>> +		goto kzalloc_failed;
>> +	}
>> +
>> +	memcpy((u8*)(&(ehea_port_cb_0->port_mac_addr)),
>> +	       (u8*)&(mac_addr->sa_data[0]), 6);
> 
> No casts on memcpy arguments.

done

> 
>> +	memcpy((u8*)&ehea_mcl_entry->macaddr, mc_mac_addr, ETH_ALEN);
> 
>> +static inline void ehea_xmit2(struct sk_buff *skb,
>> +			      struct net_device *dev, struct ehea_swqe *swqe,
>> +			      u32 lkey)
>> +{
>> +	int nfrags;
>> +	unsigned short skb_protocol = skb->protocol;
> 
> Useless variable. And it should be __be16, FYI.
> 

changed

>> +	nfrags = skb_shinfo(skb)->nr_frags;
>> +	EDEB_EN(7, "skb->nfrags=%d (0x%X)", nfrags, nfrags);
>> +
>> +	if (skb_protocol == ETH_P_IP) {
> 
> ITYM, htons(ETH_P_IP).
> 

good point, thx

>> +static inline void ehea_xmit3(struct sk_buff *skb,
>> +			      struct net_device *dev, struct ehea_swqe *swqe)
>> +{
>> +	int i;
>> +	skb_frag_t *frag;
>> +	int nfrags = skb_shinfo(skb)->nr_frags;
>> +	u8 *imm_data = &swqe->u.immdata_nodesc.immediate_data[0];
>> +	u64 skb_protocol = skb->protocol;
> 
> Useless var.

removed

> 
>> +
>> +	EDEB_EN(7, "");
>> +	if (likely(skb_protocol == ETH_P_IP)) {
> 
> 				   htons(ETH_P_IP)
> 

