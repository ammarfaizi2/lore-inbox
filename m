Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161321AbWHJPGg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161321AbWHJPGg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 11:06:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161314AbWHJPGg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 11:06:36 -0400
Received: from mtagate4.de.ibm.com ([195.212.29.153]:17817 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP
	id S1161321AbWHJPGb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 11:06:31 -0400
Message-ID: <44DB427B.5090201@de.ibm.com>
Date: Thu, 10 Aug 2006 16:28:11 +0200
From: Jan-Bernd Themann <ossthema@de.ibm.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060719)
MIME-Version: 1.0
To: michael@ellerman.id.au
CC: netdev <netdev@vger.kernel.org>, Thomas Klein <tklein@de.ibm.com>,
       linux-ppc <linuxppc-dev@ozlabs.org>,
       Christoph Raisch <raisch@de.ibm.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Marcus Eder <meder@de.ibm.com>
Subject: Re: [PATCH 1/6] ehea: interface to network stack
References: <44D99EFC.3000105@de.ibm.com> <1155190553.9801.38.camel@localhost.localdomain>
In-Reply-To: <1155190553.9801.38.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michael,

thanks for your very helpful comments so far, we'll provide a patch with these and other fixes
very soon.

See comments below.

Jan-Bernd

Michael Ellerman wrote:
 > Hi Jan-Bernd,
 >
 > Comments below the code they refer to.
 >
 > On Wed, 2006-08-09 at 10:38 +0200, Jan-Bernd Themann wrote:
 >> Signed-off-by: Jan-Bernd Themann <themann@de.ibm.com>
 >
 >>   drivers/net/ehea/ehea_main.c | 2738 +++++++++++++++++++++++++++++++++++++++++++
 >>   1 file changed, 2738 insertions(+)
 >
 >> --- linux-2.6.18-rc4-orig/drivers/net/ehea/ehea_main.c	1969-12-31 16:00:00.000000000 -0800
 >> +++ kernel/drivers/net/ehea/ehea_main.c	2006-08-08 23:59:39.683357016 -0700
 >> @@ -0,0 +1,2738 @@
 >> +/*
 >> + *  linux/drivers/net/ehea/ehea_main.c
 >
 > Putting the file name in the file is fairly redundant IMHO.
 >
 >> + *  eHEA ethernet device driver for IBM eServer System p
 >
 > What's the actual hardware that this is for? System p covers a whole
 > range of machines, do they really all support this driver?
 >
 >> + *  (C) Copyright IBM Corp. 2006
 >> + *
 >> + *  Authors:
 >> + *       Christoph Raisch <raisch@de.ibm.com>
 >> + *       Jan-Bernd Themann <themann@de.ibm.com>
 >> + *       Heiko-Joerg Schick <schickhj@de.ibm.com>
 >> + *       Thomas Klein <tklein@de.ibm.com>
 >> + *
 >> + *
 >> + * This program is free software; you can redistribute it and/or modify
 >> + * it under the terms of the GNU General Public License as published by
 >> + * the Free Software Foundation; either version 2, or (at your option)
 >> + * any later version.
 >> + *
 >> + * This program is distributed in the hope that it will be useful,
 >> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
 >> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.	 See the
 >> + * GNU General Public License for more details.
 >> + *
 >> + * You should have received a copy of the GNU General Public License
 >> + * along with this program; if not, write to the Free Software
 >> + * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
 >> + */
 >> +
 >> +#define DEB_PREFIX "main"
 >> +
 >> +#include <linux/in.h>
 >> +#include <linux/ip.h>
 >> +#include <linux/tcp.h>
 >> +#include <linux/udp.h>
 >> +#include <linux/if.h>
 >> +#include <linux/list.h>
 >> +#include <net/ip.h>
 >> +
 >> +#include "ehea.h"
 >> +#include "ehea_qmr.h"
 >> +#include "ehea_phyp.h"
 >> +
 >> +
 >> +MODULE_LICENSE("GPL");
 >> +MODULE_AUTHOR("Christoph Raisch <raisch@de.ibm.com>");
 >> +MODULE_DESCRIPTION("IBM eServer HEA Driver");
 >> +MODULE_VERSION(EHEA_DRIVER_VERSION);
 >> +
 >> +static int __devinit ehea_probe(struct ibmebus_dev *dev,
 >> +				const struct of_device_id *id);
 >> +static int __devexit ehea_remove(struct ibmebus_dev *dev);
 >> +static int ehea_sense_port_attr(struct ehea_adapter *adapter, int portnum);
 >
 > I haven't looked closely, but can you rearrange the functions so you
 > don't need these forward declarations?

yes, rearrangement is possible. Done.

 >
 >> +int ehea_trace_level = 5;
 >> +
 >> +static struct net_device_stats *ehea_get_stats(struct net_device *dev)
 >> +{
 >> +	int i;
 >> +	u64 hret = H_HARDWARE;
 >
 > You unconditionally assign to hret below.
 >
 >> +	u64 rx_packets = 0;
 >
 > Why not just update stats->rx_packets directly?
 >
 >> +	struct ehea_port *port = (struct ehea_port*)dev->priv;
 >> +	struct ehea_adapter *adapter = port->adapter;
 >
 > I don't think you need adapter, you only use it in one place, just
 > access it through port->adapter->handle (below).

done

 >
 >> +	struct hcp_query_ehea_port_cb_2 *cb2 = NULL;
 >> +	struct net_device_stats *stats = &port->stats;
 >> +
 >> +	EDEB_EN(7, "net_device=%p", dev);
 >> +
 >> +	cb2 = kzalloc(H_CB_ALIGNMENT, GFP_KERNEL);
 >> +	if (!cb2) {
 >> +		EDEB_ERR(4, "No memory for cb2");
 >> +		goto get_stat_exit;
 >
 > You leak cb2 here.
 >

done

 >> +	}
 >> +
 >> +	hret = ehea_h_query_ehea_port(adapter->handle,
 >> +				      port->logical_port_id,
 >> +				      H_PORT_CB2,
 >> +				      H_PORT_CB2_ALL,
 >> +				      cb2);
 >> +
 >> +	if (hret != H_SUCCESS) {
 >> +		EDEB_ERR(4, "query_ehea_port failed for cb2");
 >> +		goto get_stat_exit;
 >> +	}
 >> +
 >> +	EDEB_DMP(7, (u8*)cb2,
 >> +		 sizeof(struct hcp_query_ehea_port_cb_2), "After HCALL");
 >> +
 >> +	for (i = 0; i < port->num_def_qps; i++) {
 >> +		rx_packets += port->port_res[i].rx_packets;
 >> +	}
 >> +
 >> +	stats->tx_packets = cb2->txucp + cb2->txmcp + cb2->txbcp;
 >> +	stats->multicast = cb2->rxmcp;
 >> +	stats->rx_errors = cb2->rxuerr;
 >> +	stats->rx_bytes = cb2->rxo;
 >> +	stats->tx_bytes = cb2->txo;
 >> +	stats->rx_packets = rx_packets;
 >> +
 >> +get_stat_exit:
 >> +	EDEB_EX(7, "");
 >> +	return stats;
 >> +}
 >> +
 >> +static inline u32 ehea_get_send_lkey(struct ehea_port_res *pr)
 >> +{
 >> +	return pr->send_mr.lkey;
 >> +}
 >
 > Get rid of this, it's only used once.
 >

done

 >> +static inline u32 ehea_get_recv_lkey(struct ehea_port_res *pr)
 >> +{
 >> +	return pr->recv_mr.lkey;
 >> +}
 >
 > And this one only twice? Is it really useful?
 >

done

 >> +
 >> +#define EHEA_OD_ADDR(address, segment) (((address) & (PAGE_SIZE - 1)) \
 >> +					| ((segment) << 12));
 >> +
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
 > This two functions seem useless or wrong.
 >

removed

 >> +static inline int ehea_refill_rq1(struct ehea_port_res *port_res, int arr_index,
 >> +				  int nr_of_wqes)
 >> +{
 >> +	int i;
 >> +	int ret = 0;
 >> +	struct ehea_qp *qp;
 >> +	int skb_arr_rq1_len = port_res->skb_arr_rq1_len;
 >> +	struct sk_buff **skb_arr_rq1 = port_res->skb_arr_rq1;
 >> +	EDEB_EN(7, "port_res=%p, arr_index=%d, nr_of_wqes=%d, arr_rq1_len=%d",
 >> +		port_res, arr_index, nr_of_wqes, skb_arr_rq1_len);
 >> +
 >> +	qp = port_res->qp;
 >
 > You don't need the qp variable, just use port_res->qp below.
 >

done

 >> +	if (unlikely(nr_of_wqes == 0))
 >> +		return -EINVAL;
 >
 > Newline needed here.
 >

done

 >> +	for (i = 0; i < nr_of_wqes; i++) {
 >> +		int index = ((skb_arr_rq1_len + arr_index) - i)
 >> +		    % skb_arr_rq1_len;
 >
 > The wrapped line should be indented further to the right.
 >

done

 >> +		if (!skb_arr_rq1[index]) {
 >> +			skb_arr_rq1[index] = dev_alloc_skb(EHEA_LL_PKT_SIZE);
 >> +
 >> +			if (!skb_arr_rq1[index]) {
 >> +				EDEB_ERR(4, "No mem for skb/%d wqes filled", i);
 >> +				ret = -ENOMEM;
 >> +				break;
 >> +			}
 >> +		}
 >> +	}
 >> +	/* Ring doorbell */
 >> +	ehea_update_rq1a(qp, nr_of_wqes);
 >> +	EDEB_EX(7, "");
 >> +	return ret;
 >> +}
 >> +
 >> +static int ehea_init_fill_rq1(struct ehea_port_res *port_res, int nr_rq1a)
 >> +{
 >> +	int i;
 >> +	int ret = 0;
 >> +	struct ehea_qp *qp;
 >> +	EDEB_EN(7, "port_res=%p, nr_rq1a=%d", port_res, nr_rq1a);
 >> +	qp = port_res->qp;
 >> +
 >> +	for (i = 0; i < port_res->skb_arr_rq1_len; i++) {
 >> +		port_res->skb_arr_rq1[i] = dev_alloc_skb(EHEA_LL_PKT_SIZE);
 >> +		if (!port_res->skb_arr_rq1[i]) {
 >> +			EDEB_ERR(4, "dev_alloc_skb failed. Only %d skb filled.",
 >> +				 i);
 >> +			ret = -ENOMEM;
 >> +			break;
 >> +		}
 >> +	}
 >> +	/* Ring doorbell */
 >> +	ehea_update_rq1a(qp, nr_rq1a);
 >> +	EDEB_EX(7, "");
 >> +	return ret;
 >> +}
 >> +
 >> +static inline int ehea_refill_rq2_def(struct ehea_port_res *pr, int nr_of_wqes)
 >> +{
 >> +	int i;
 >> +	int ret = 0;
 >> +	struct ehea_qp *qp;
 >> +	struct ehea_rwqe *rwqe;
 >> +	int skb_arr_rq2_len = pr->skb_arr_rq2_len;
 >> +	struct sk_buff **skb_arr_rq2 = pr->skb_arr_rq2;
 >> +
 >> +	EDEB_EN(8, "pr=%p, nr_of_wqes=%d", pr, nr_of_wqes);
 >> +	if (nr_of_wqes == 0)
 >> +		return -EINVAL;
 >> +	qp = pr->qp;
 >> +	for (i = 0; i < nr_of_wqes; i++) {
 >> +		int index = pr->skb_rq2_index++;
 >> +		struct sk_buff *skb = dev_alloc_skb(EHEA_RQ2_PKT_SIZE
 >> +						    + NET_IP_ALIGN);
 >> +
 >> +		if (!skb) {
 >> +			EDEB_ERR(4, "dev_alloc_skb nr %d failed", i);
 >> +			ret = -ENOMEM;
 >> +			break;
 >> +		}
 >> +		skb_reserve(skb, NET_IP_ALIGN);
 >> +		pr->skb_rq2_index %= skb_arr_rq2_len;
 >> +		skb_arr_rq2[index] = skb;
 >> +		rwqe = ehea_get_next_rwqe(qp, 2);
 >> +		rwqe->wr_id = EHEA_BMASK_SET(EHEA_WR_ID_TYPE, EHEA_RWQE2_TYPE)
 >> +		            | EHEA_BMASK_SET(EHEA_WR_ID_INDEX, index);
 >> +		rwqe->sg_list[0].l_key = ehea_get_recv_lkey(pr);
 >> +		rwqe->sg_list[0].vaddr = get_rwqe_addr((u64)skb->data);
 >> +		rwqe->sg_list[0].len = EHEA_RQ2_PKT_SIZE;
 >> +		rwqe->data_segments = 1;
 >> +	}
 >> +
 >> +	/* Ring doorbell */
 >> +	iosync();
 >> +	ehea_update_rq2a(qp, i);
 >> +	EDEB_EX(8, "");
 >> +	return ret;
 >> +}
 >> +
 >> +
 >> +static inline int ehea_refill_rq2(struct ehea_port_res *pr, int nr_of_wqes)
 >> +{
 >> +	return ehea_refill_rq2_def(pr, nr_of_wqes);
 >> +}
 >
 > Why do you need this function?
 >

this is for near future features

 >> +static inline int ehea_refill_rq3_def(struct ehea_port_res *pr, int nr_of_wqes)
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
 >> +			EDEB_ERR(4, "No memory for skb. Only %d rwqe filled.",
 >> +				 i);
 >> +			ret = -ENOMEM;
 >> +			break;
 >> +		}
 >> +		skb_reserve(skb, NET_IP_ALIGN);
 >> +
 >> +		rwqe = ehea_get_next_rwqe(qp, 3);
 >> +		pr->skb_rq3_index %= skb_arr_rq3_len;
 >> +		skb_arr_rq3[index] = skb;
 >> +		rwqe->wr_id = EHEA_BMASK_SET(EHEA_WR_ID_TYPE, EHEA_RWQE3_TYPE)
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
 >
 > You "Ring doorbell" in four places, but only in two do you do iosync(),
 > that might be ok, but it looks suspicious. Also, what is the iosync
 > trying to achieve?
 >

That is ok. We do a iosync to make sure that the hardware sees the entire
wqe we put on the queue. For RQ1, we don't put something on the queue that
has to be read by the hea hardware -> no iosync needed

 > ehea_refill_rq3_def() and ehea_refill_rq2_def() look quite similar, can
 > they be combined?
 >

Well, it seems to be a tradeoff between a function with lots of parameters
and two separate functions. Our choice was the last option.

 >> +
 >> +
 >> +static inline int ehea_refill_rq3(struct ehea_port_res *pr, int nr_of_wqes)
 >> +{
 >> +	return ehea_refill_rq3_def(pr, nr_of_wqes);
 >> +}
 >> +
 >> +
 >> +static inline int ehea_check_cqe(struct ehea_cqe *cqe, int *rq_num)
 >> +{
 >> +	*rq_num = (cqe->type & EHEA_CQE_TYPE_RQ) >> 5;
 >> +	EDEB(7, "RQ used=%d, status=%X", *rq_num, cqe->status);
 >> +	if ((cqe->status & EHEA_CQE_STAT_ERR_MASK) == 0)
 >> +		return 0;
 >> +	if (((cqe->status & EHEA_CQE_STAT_ERR_TCP) != 0)
 >> +	    && (cqe->header_length == 0))
 >> +		return 0;
 >> +	else
 >> +		printk("WARNING: Packet discarded. Wrong TCP/UDP chksum"
 >> +		       "and header_length != 0. cqe->status=%X", cqe->status);
 >> +
 >> +	return -EINVAL;
 >> +}
 >> +
 >> +static inline void ehea_fill_skb_ll(struct net_device *dev,
 >> +				    struct sk_buff *skb, struct ehea_cqe *cqe)
 >> +{
 >> +	int length = cqe->num_bytes_transfered - 4;	/*remove CRC */
 >> +	EDEB_EN(7, "dev=%p, skb=%p, cqe=%p", dev, skb, cqe);
 >> +	memcpy(skb->data, ((char*)cqe) + 64, length);
 >> +	skb_put(skb, length);
 >> +	skb->dev = dev;
 >> +	skb->ip_summed = CHECKSUM_UNNECESSARY;
 >> +	skb->protocol = eth_type_trans(skb, dev);
 >> +	EDEB_EX(7, "");
 >> +}
 >> +
 >> +static inline void ehea_fill_skb(struct net_device *dev,
 >> +				 struct sk_buff *skb, struct ehea_cqe *cqe)
 >> +{
 >> +	int length = cqe->num_bytes_transfered - 4;	/*remove CRC */
 >> +	EDEB_EN(7, "dev=%p, skb=%p, cqe=%p", dev, skb, cqe);
 >> +	skb_put(skb, length);
 >> +	skb->dev = dev;
 >> +	skb->ip_summed = CHECKSUM_UNNECESSARY;
 >> +	skb->protocol = eth_type_trans(skb, dev);
 >> +	EDEB_EX(7, "");
 >> +}
 >
 > What's the difference between the above two functions?
 >

the first one has an additional copy. But you are right, we get rid of
ehea_fill_skb_ll

 >> +#define EHEA_MAX_RWQE 1000
 >
 > Should probably be in a header.
 >

agreed

 >> +static int ehea_poll(struct net_device *dev, int *budget)
 >> +{
 >> +	struct ehea_port *port = (struct ehea_port*)dev->priv;
 >> +	struct ehea_port_res *port_res = &port->port_res[0];
 >> +	struct ehea_cqe *cqe;
 >> +	struct ehea_qp *qp = port_res->qp;
 >> +	int wqe_index = 0;
 >> +	int last_wqe_index = 0;
 >> +	int x = 0;
 >> +	int processed = 0;
 >> +	int processed_RQ1 = 0;
 >> +	int processed_RQ2 = 0;
 >> +	int processed_RQ3 = 0;
 >> +	int rq;
 >> +	int intreq;
 >> +	struct sk_buff **skb_arr_rq1 = port_res->skb_arr_rq1;
 >> +	struct sk_buff **skb_arr_rq2 = port_res->skb_arr_rq2;
 >> +	struct sk_buff **skb_arr_rq3 = port_res->skb_arr_rq3;
 >> +	int skb_arr_rq1_len = port_res->skb_arr_rq1_len;
 >> +	int my_quota = min(*budget, dev->quota);
 >> +
 >> +	EDEB_EN(7, "dev=%p, port_res=%p, budget=%d, quota=%d, qp_nr=%x",
 >> +		dev, port_res, *budget, dev->quota,
 >> +		port_res->qp->init_attr.qp_nr);
 >> +	my_quota = min(my_quota, EHEA_MAX_RWQE);
 >> +
 >> +	/* rq0 is low latency RQ */
 >> +	cqe = ehea_poll_rq1(qp, &wqe_index);
 >> +	while ((my_quota > 0) && cqe) {
 >> +		ehea_inc_rq1(qp);
 >> +		processed_RQ1++;
 >> +		processed++;
 >> +		my_quota--;
 >> +
 >> +		EDEB_DMP(6, (u8*)cqe, 4 * 16, "CQE");
 >> +		last_wqe_index = wqe_index;
 >> +		rmb();
 >> +		if (!ehea_check_cqe(cqe, &rq)) {
 >> +			struct sk_buff *skb;
 >> +			if (rq == 1) {	/* LL RQ1 */
 >> +				void *pref;
 >> +
 >> +				x = (wqe_index + 1) % skb_arr_rq1_len;
 >> +				pref = (void*)skb_arr_rq1[x];
 >> +				prefetchw(pref);
 >> +				prefetchw(pref + EHEA_CACHE_LINE);
 >> +
 >> +				x = (wqe_index + 1) % skb_arr_rq1_len;
 >> +				pref = (void*)(skb_arr_rq1[x]->data);
 >> +				prefetchw(pref);
 >> +				prefetchw(pref + EHEA_CACHE_LINE);
 >> +
 >> +				skb = skb_arr_rq1[wqe_index];
 >> +				if (unlikely(!skb)) {
 >> +					EDEB_ERR(4, "LL SBK=NULL, wqe_index=%d",
 >> +						 wqe_index);
 >> +					skb = dev_alloc_skb(EHEA_LL_PKT_SIZE);
 >> +					if (!skb)
 >> +						panic("Alloc SKB failed");
 >> +				}
 >> +				skb_arr_rq1[wqe_index] = NULL;
 >> +				ehea_fill_skb_ll(dev, skb, cqe);
 >> +			} else if (rq == 2) {	/* RQ2 */
 >> +				void *pref;
 >> +				int skb_index = EHEA_BMASK_GET(EHEA_WR_ID_INDEX,
 >> +							       cqe->wr_id);
 >> +				x = (skb_index + 1) % port_res->skb_arr_rq2_len;
 >> +				pref = (void*)skb_arr_rq2[x];
 >> +				prefetchw(pref);
 >> +				prefetchw(pref + EHEA_CACHE_LINE);
 >> +
 >> +				x = (skb_index + 1) % port_res->skb_arr_rq2_len;
 >> +				pref = (void*)(skb_arr_rq2[x]->data);
 >> +
 >> +				prefetch(pref);
 >> +				prefetch(pref + EHEA_CACHE_LINE);
 >> +				prefetch(pref + EHEA_CACHE_LINE * 2);
 >> +				prefetch(pref + EHEA_CACHE_LINE * 3);
 >> +				skb = skb_arr_rq2[skb_index];
 >> +
 >> +				if (unlikely(!skb)) {
 >> +					EDEB_ERR(4, "rq2: SKB=NULL, index=%d",
 >> +						 skb_index);
 >> +					break;
 >> +				}
 >> +				skb_arr_rq2[skb_index] = NULL;
 >> +				ehea_fill_skb(dev, skb, cqe);
 >> +				processed_RQ2++;
 >> +			} else {
 >> +				void *pref;
 >> +				int skb_index = EHEA_BMASK_GET(EHEA_WR_ID_INDEX,
 >> +							       cqe->wr_id);
 >> +				x = (skb_index + 1) % port_res->skb_arr_rq3_len;
 >> +				pref = (void*)skb_arr_rq3[x];
 >> +				prefetchw(pref);
 >> +				prefetchw(pref + EHEA_CACHE_LINE);
 >> +
 >> +				x = (skb_index + 1) % port_res->skb_arr_rq3_len;
 >> +				pref = (void*)(skb_arr_rq3[x]->data);
 >> +				prefetch(pref);
 >> +				prefetch(pref + EHEA_CACHE_LINE);
 >> +				prefetch(pref + EHEA_CACHE_LINE * 2);
 >> +				prefetch(pref + EHEA_CACHE_LINE * 3);
 >> +
 >> +				skb = skb_arr_rq3[skb_index];
 >> +				if (unlikely(!skb)) {
 >> +					EDEB_ERR(4, "rq3: SKB=NULL, index=%d",
 >> +						 skb_index);
 >> +					break;
 >> +				}
 >> +				skb_arr_rq3[skb_index] = NULL;
 >> +				ehea_fill_skb(dev, skb, cqe);
 >> +				processed_RQ3++;
 >> +			}
 >> +
 >> +			EDEB(6, "About to pass SKB: dev=%p\n"
 >> +			     "skb=%p skb->data=%p skb->len=%d"
 >> +			     " skb->data_len=0x%x nr_frags=%d",
 >> +			     dev,
 >> +			     skb,
 >> +			     skb->data,
 >> +			     skb->len,
 >> +			     skb->data_len, skb_shinfo(skb)->nr_frags);
 >> +			if (cqe->status & EHEA_CQE_VLAN_TAG_XTRACT) {
 >> +				EDEB(7, "VLAN TAG extracted: %4x, vgrp=%p",
 >> +				     cqe->vlan_tag, port->vgrp);
 >> +				EDEB(7, "vlan_devices[vlan_tag]=%p",
 >> +				     port->vgrp->vlan_devices[cqe->vlan_tag]);
 >> +				vlan_hwaccel_receive_skb(skb, port->vgrp,
 >> +							 cqe->vlan_tag);
 >> +			} else {
 >> +				EDEB(7, "netif_receive_skb");
 >> +				netif_receive_skb(skb);
 >> +			}
 >> +			EDEB(7, "SKB passed (netif_receive(skb) called)");
 >> +
 >> +		} else {
 >> +			struct sk_buff *skb;
 >> +
 >> +			EDEB_ERR(4, "cqe->status indicating error: CQE:");
 >> +			EDEB_DMP(4, (u8*)cqe, 4 * 16, "");
 >> +			if (rq == 2) {
 >> +				processed_RQ2++;
 >> +				skb = skb_arr_rq2[
 >> +					EHEA_BMASK_GET(EHEA_WR_ID_INDEX,
 >> +							  cqe->wr_id)];
 >> +				skb_arr_rq2[EHEA_BMASK_GET(EHEA_WR_ID_INDEX,
 >> +							  cqe->wr_id)] = NULL;
 >> +				dev_kfree_skb(skb);
 >> +			}
 >> +			if (rq == 3) {
 >> +				processed_RQ3++;
 >> +				skb = skb_arr_rq3[
 >> +					EHEA_BMASK_GET(EHEA_WR_ID_INDEX,
 >> +								cqe->wr_id)];
 >> +				skb_arr_rq3[EHEA_BMASK_GET(EHEA_WR_ID_INDEX,
 >> +							  cqe->wr_id)] = NULL;
 >> +				dev_kfree_skb(skb);
 >> +			}
 >> +		}
 >> +		cqe = ehea_poll_rq1(qp, &wqe_index);
 >> +	}
 >> +
 >> +	dev->quota -= processed;
 >> +	*budget -= processed;
 >> +
 >> +	port_res->p_state.ehea_poll += 1;
 >> +
 >> +	port_res->rx_packets += processed;
 >> +
 >> +	ehea_refill_rq1(port_res, last_wqe_index, processed_RQ1);
 >> +	ehea_refill_rq2(port_res, processed_RQ2);
 >> +	ehea_refill_rq3(port_res, processed_RQ3);
 >> +
 >> +	intreq = ((port_res->p_state.ehea_poll & 0xF) == 0xF);
 >> +
 >> +	EDEB_EX(7, "processed=%d, *budget=%d, dev->quota=%d",
 >> +		processed, *budget, dev->quota);
 >> +
 >> +	if (!cqe || intreq) {
 >> +		netif_rx_complete(dev);
 >> +		ehea_reset_cq_ep(port_res->recv_cq);
 >> +		ehea_reset_cq_n1(port_res->recv_cq);
 >> +		cqe = ipz_qeit_get_valid(&qp->ipz_rqueue1);
 >> +		EDEB(7, "CQE=%p, break ehea_poll while loop", cqe);
 >> +		if (!cqe || intreq)
 >> +			return 0;
 >> +		if (!netif_rx_reschedule(dev, my_quota))
 >> +			return 0;
 >> +	}
 >> +	return 1;
 >> +}
 >
 > This function is _way_ too big.
 >

Ok, we will make it smaller

 >> +#define MAX_SENDCOMP_QUOTA 400
 >> +void ehea_send_irq_tasklet(unsigned long data)
 >> +{
 >> +	int quota = MAX_SENDCOMP_QUOTA;
 >> +	int skb_index;
 >> +	int cqe_counter = 0;
 >> +	int swqe_av = 0;
 >> +	unsigned long flags;
 >> +	struct sk_buff *skb;
 >> +	struct ehea_cqe *cqe;
 >> +	struct ehea_port_res *port_res = (struct ehea_port_res*)data;
 >> +	struct ehea_cq *send_cq = port_res->send_cq;
 >> +	struct net_device *dev = port_res->port->netdev;
 >> +
 >> +	EDEB_EN(7, "port_res=%p", port_res);
 >> +
 >> +	do {
 >> +		cqe = ehea_poll_cq(send_cq);
 >> +		if (!cqe) {
 >> +			EDEB(7, "No further cqe found");
 >> +			ehea_reset_cq_ep(send_cq);
 >> +			ehea_reset_cq_n1(send_cq);
 >> +			cqe = ehea_poll_cq(send_cq);
 >> +			if (!cqe) {
 >> +				EDEB(7, "No cqe found after having"
 >> +				     " reset N1/EP\n");
 >> +				break;
 >> +			}
 >> +		}
 >> +		cqe_counter++;
 >> +		EDEB(7, "CQE found on Send-CQ:");
 >> +		EDEB_DMP(7, (u8*)cqe, 4 * 16, "");
 >> +		rmb();
 >> +		if (likely(EHEA_BMASK_GET(EHEA_WR_ID_TYPE, cqe->wr_id)
 >> +			   == EHEA_SWQE2_TYPE)) {	/* is swqe format 2 */
 >> +			int i;
 >> +			int index = EHEA_BMASK_GET(EHEA_WR_ID_INDEX,
 >> +						     cqe->wr_id);
 >> +			for (i = 0; i < EHEA_BMASK_GET(EHEA_WR_ID_REFILL,
 >> +						       cqe->wr_id); i++) {
 >> +
 >> +				skb_index = ((index - i
 >> +					      + port_res->skb_arr_sq_len)
 >> +					     % port_res->skb_arr_sq_len);
 >> +				skb = port_res->skb_arr_sq[skb_index];
 >> +				port_res->skb_arr_sq[skb_index] = NULL;
 >> +
 >> +				if (unlikely(!skb)) {
 >> +					EDEB_ERR(4, "s_irq_tasklet: SKB=NULL "
 >> +						 "WQ_ID=%lX, loop=%d, index=%d",
 >> +						 cqe->wr_id, i, skb_index);
 >> +					break;
 >> +				}
 >> +				dev_kfree_skb(skb);
 >> +			}
 >> +		}
 >> +		swqe_av += EHEA_BMASK_GET(EHEA_WR_ID_REFILL, cqe->wr_id);
 >> +		quota--;
 >> +	} while (quota > 0);
 >> +
 >> +	ehea_update_feca(send_cq, cqe_counter);
 >> +
 >> +	atomic_add(swqe_av, &port_res->swqe_avail);
 >> +	EDEB(7, "port_res->swqe_avail=%d",
 >> +	     atomic_read(&port_res->swqe_avail));
 >> +
 >> +	if (unlikely(netif_queue_stopped(dev))) {
 >> +		spin_lock_irqsave(&port_res->netif_queue, flags);
 >> +		if (unlikely((atomic_read(&port_res->swqe_avail)
 >> +			      >= EHEA_SWQE_REFILL_TH))) {
 >> +			EDEB(7, "port %d swqes_avail >=10 (%d),"
 >> +			     "netif_wake_queue called",
 >> +			     port_res->port->logical_port_id,
 >> +			     atomic_read(&port_res->swqe_avail));
 >> +			netif_wake_queue(port_res->port->netdev);
 >> +		}
 >> +		spin_unlock_irqrestore(&port_res->netif_queue, flags);
 >> +	}
 >> +
 >> +	if (unlikely(cqe))
 >> +		tasklet_hi_schedule(&port_res->send_comp_task);
 >> +
 >> +	EDEB_EX(7, "");
 >> +}
 >
 > This one's pretty big too.
 >

Done

 >> +
 >> +irqreturn_t ehea_send_irq_handler(int irq, void *param, struct pt_regs *regs)
 >> +{
 >> +	struct ehea_port_res *pr = (struct ehea_port_res*)param;
 >> +	EDEB_EN(7, "irq=%d, param=%p, pt_regs=%p", irq, param, regs);
 >> +	tasklet_hi_schedule(&pr->send_comp_task);
 >> +	EDEB_EX(7, "");
 >> +	return IRQ_HANDLED;
 >> +}
 >> +
 >> +irqreturn_t ehea_recv_irq_handler(int irq, void *param, struct pt_regs * regs)
 >> +{
 >> +	struct ehea_port_res *pr = (struct ehea_port_res*)param;
 >> +	struct ehea_port *port = pr->port;
 >> +	EDEB_EN(7, "irq=%d, param=%p, pt_regs=%p", irq, param, regs);
 >> +	netif_rx_schedule(port->netdev);
 >> +	EDEB_EX(7, "");
 >> +	return IRQ_HANDLED;
 >> +}
 >> +
 >> +irqreturn_t ehea_qp_aff_irq_handler(int irq, void *param, struct pt_regs * regs)
 >> +{
 >> +	struct ehea_port *port = (struct ehea_port*)param;
 >> +	struct ehea_eqe *eqe;
 >> +	u32 qp_token;
 >> +
 >> +	EDEB_EN(7, "irq=%d, param=%p, pt_regs=%p", irq, param, regs);
 >> +	eqe = (struct ehea_eqe*)ehea_poll_eq(port->qp_eq);
 >
 > Suspicious cast?
 >

ehea_poll_eq changed so that this cast is not necessary anymore

 >> +	EDEB(7, "eqe=%p", eqe);
 >> +	while (eqe) {
 >> +		EDEB(7, "*eqe=%lx", *(u64*)eqe);
 >> +		eqe = (struct ehea_eqe*)ehea_poll_eq(port->qp_eq);
 >> +		qp_token = EHEA_BMASK_GET(EHEA_EQE_QP_TOKEN, eqe->entry);
 >
 > You don't seem to use qp_token?
 >

planned for recovery, we are working on that

 >> +		EDEB(7, "next eqe=%p", eqe);
 >> +	}
 >> +
 >> +	EDEB_EX(7, "");
 >> +	return IRQ_HANDLED;
 >> +}
 >> +
 >> +static struct ehea_port *ehea_get_port(struct ehea_adapter *adapter,
 >> +				       int logical_port)
 >> +{
 >> +	int i;
 >> +
 >> +	for (i = 0; i < adapter->num_ports; i++)
 >> +		if (adapter->port[i]->logical_port_id == logical_port)
 >> +			return adapter->port[i];
 >> +	return NULL;
 >> +}
 >> +
 >> +static void ehea_parse_eqe(struct ehea_adapter *adapter, u64 eqe)
 >> +{
 >> +	int ret = -EINVAL;
 >> +	u8 ec = 0;
 >> +	u8 portnum = 0;
 >> +	struct ehea_port *port = NULL;
 >
 > You don't need to initialise these three variables.
 >

true

 >> +
 >> +	EDEB_EN(7, "eqe=%lx", eqe);
 >> +
 >> +	ec = EHEA_BMASK_GET(NEQE_EVENT_CODE, eqe);
 >> +
 >> +	switch (ec) {
 >> +	case EHEA_EC_PORTSTATE_CHG:	/* port state change */
 >> +		EDEB(7, "Port state change");
 >> +		portnum = EHEA_BMASK_GET(NEQE_PORTNUM, eqe);
 >> +		port = ehea_get_port(adapter, portnum);
 >> +
 >> +		if (!port) {
 >> +			EDEB_ERR(4, "Unknown portnum %x", portnum);
 >> +			break;
 >> +		}
 >> +
 >> +		if (EHEA_BMASK_GET(NEQE_PORT_UP, eqe)) {
 >> +			if (!netif_carrier_ok(port->netdev)) {
 >> +				ret = ehea_sense_port_attr(adapter, portnum);
 >> +				if (ret) {
 >> +					EDEB_ERR(4, "Failed resensing port");
 >> +					break;
 >> +				}
 >> +
 >> +				printk("%s: Logical port up: %dMbps %s Duplex",
 >> +				       port->netdev->name,
 >> +				       port->port_speed,
 >> +				       port->full_duplex ==
 >> +				       1 ? "Full" : "Half");
 >> +
 >> +				netif_carrier_on(port->netdev);
 >> +				netif_wake_queue(port->netdev);
 >> +			}
 >> +		} else
 >> +			if (netif_carrier_ok(port->netdev)) {
 >> +				printk("%s: Logical port down",
 >> +				       port->netdev->name);
 >> +				netif_carrier_off(port->netdev);
 >> +				netif_stop_queue(port->netdev);
 >> +			}
 >> +
 >> +		if (EHEA_BMASK_GET(NEQE_EXTSWITCH_PORT_UP, eqe))
 >> +			printk("%s: Physical port up", port->netdev->name);
 >> +		else
 >> +			printk("%s: Physical port down", port->netdev->name);
 >> +
 >> +		if (EHEA_BMASK_GET(NEQE_EXTSWITCH_PRIMARY, eqe))
 >> +			printk("Externel switch port is primary port");
 >> +		else
 >> +			printk("Externel switch port is backup port");
 >
 > These printks should probably use KERN_DEBUG, or netif_msg_foo().
 >

I guess, KERN_INFO would be a good choice

 >> +		break;
 >> +	case EHEA_EC_ADAPTER_MALFUNC:	/* adapter malfunction */
 >> +		EDEB_ERR(4, "Adapter malfunction");
 >> +		break;
 >> +	case EHEA_EC_PORT_MALFUNC:	/* port malfunction */
 >> +		EDEB_ERR(4, "Port malfunction");
 >> +		/* TODO Determine the port structure of the malfunctioning port
 >> +		 * netif_carrier_off(port->netdev);
 >> +		 * netif_stop_queue(port->netdev);
 >> +		 */
 >> +		break;
 >
 > The two malfunction states could probably use a printk(KERN_WARNING .. )
 > for now.
 >

done

 >> +	default:
 >> +		EDEB_ERR(4, "Unknown event code %x", ec);
 >> +		break;
 >> +	}
 >> +
 >> +	EDEB_EX(7, "");
 >> +}
 >> +
 >> +void ehea_neq_tasklet(unsigned long data)
 >> +{
 >> +	struct ehea_adapter *adapter = (struct ehea_adapter*)data;
 >> +	struct ehea_eqe *eqe;
 >> +	u64 event_mask;
 >> +
 >> +	EDEB_EN(7, "");
 >> +	eqe = (struct ehea_eqe*)ehea_poll_eq(adapter->neq);
 >> +	EDEB(7, "eqe=%p", eqe);
 >> +
 >> +	while (eqe) {
 >> +		EDEB(7, "*eqe=%lx", eqe->entry);
 >> +		ehea_parse_eqe(adapter, eqe->entry);
 >> +		eqe = (struct ehea_eqe*)ehea_poll_eq(adapter->neq);
 >> +		EDEB(7, "next eqe=%p", eqe);
 >> +	}
 >
 > I think I've seen this code before.
 >

there is a similar function, but it will be used for a different
error recovery

 >> +
 >> +	event_mask = EHEA_BMASK_SET(NELR_PORTSTATE_CHG, 1)
 >> +		   | EHEA_BMASK_SET(NELR_ADAPTER_MALFUNC, 1)
 >> +		   | EHEA_BMASK_SET(NELR_PORT_MALFUNC, 1);
 >> +
 >> +	ehea_h_reset_events(adapter->handle,
 >> +			    adapter->neq->ipz_eq_handle, event_mask);
 >> +	EDEB_EX(7, "");
 >> +}
 >> +
 >> +irqreturn_t ehea_interrupt_neq(int irq, void *param, struct pt_regs *regs)
 >> +{
 >> +	struct ehea_adapter *adapter = (struct ehea_adapter*)param;
 >> +	EDEB_EN(7, "dev_id=%p", adapter);
 >> +	tasklet_hi_schedule(&adapter->neq_tasklet);
 >> +	EDEB_EX(7, "");
 >> +	return IRQ_HANDLED;
 >> +}
 >> +
 >> +
 >> +
 >> +static void ehea_fill_port_res(struct ehea_port_res *pr)
 >> +{
 >> +	struct ehea_qp_init_attr *init_attr = &pr->qp->init_attr;
 >> +
 >> +	/* RQ 1 */
 >> +	ehea_init_fill_rq1(pr, init_attr->act_nr_rwqes_rq1
 >> +			   - init_attr->act_nr_rwqes_rq2
 >> +			   - init_attr->act_nr_rwqes_rq3 - 1);
 >> +
 >> +	/* RQ 2 */
 >> +	ehea_refill_rq2(pr, init_attr->act_nr_rwqes_rq2);
 >> +
 >> +	/* RQ 3 */
 >> +	ehea_refill_rq3(pr, init_attr->act_nr_rwqes_rq3);
 >> +}
 >> +
 >> +static int ehea_reg_interrupts(struct net_device *dev)
 >> +{
 >> +	int ret = -EINVAL;
 >> +	int i;
 >> +	struct ehea_port *port = (struct ehea_port*)dev->priv;
 >> +	struct ehea_port_res *pr = &port->port_res[0];
 >
 > Don't need to initalise pr.
 >

done

 >> +
 >> +	EDEB_EN(7, "");
 >> +	for (i = 0; i < port->num_def_qps; i++) {
 >> +		pr = &port->port_res[i];
 >> +		snprintf(pr->int_recv_name, EHEA_IRQ_NAME_SIZE - 1
 >> +			 , "%s-recv%d", dev->name, i);
 >> +		ret = ibmebus_request_irq(NULL,
 >> +					  pr->recv_eq->attr.ist1,
 >> +					  ehea_recv_irq_handler,
 >> +					  SA_INTERRUPT, pr->int_recv_name, pr);
 >> +		if (ret) {
 >> +			EDEB_ERR(4, "Failed registering irq for ehea_recv_int:"
 >> +				 "port_res_nr:%d, ist=%X", i,
 >> +				 pr->recv_eq->attr.ist1);
 >> +			goto failure;
 >> +		}
 >> +		EDEB(7, "irq_handle 0x%X for function ehea_recv_int %d "
 >> +		     " registered", pr->recv_eq->attr.ist1, i);
 >> +	}
 >> +
 >> +	snprintf(port->int_aff_name, EHEA_IRQ_NAME_SIZE - 1,
 >> +		 "%s-aff", dev->name);
 >> +	ret = ibmebus_request_irq(NULL,
 >> +				  port->qp_eq->attr.ist1,
 >> +				  ehea_qp_aff_irq_handler,
 >> +				  SA_INTERRUPT, port->int_aff_name, port);
 >> +	if (ret) {
 >> +		EDEB_ERR(4, "Failed registering irq for qp_aff_irq_handler:"
 >> +			 " ist=%X", port->qp_eq->attr.ist1);
 >> +		goto failure;
 >> +	}
 >> +	EDEB(7, "irq_handle 0x%X for function qp_aff_irq_handler registered",
 >> +	     port->qp_eq->attr.ist1);
 >> +
 >> +	for (i = 0; i < port->num_def_qps + port->num_tx_qps; i++) {
 >> +		pr = &port->port_res[i];
 >> +		snprintf(pr->int_send_name, EHEA_IRQ_NAME_SIZE - 1,
 >> +			 "%s-send%d", dev->name, i);
 >> +		ret = ibmebus_request_irq(NULL,
 >> +					  pr->send_eq->attr.ist1,
 >> +					  ehea_send_irq_handler,
 >> +					  SA_INTERRUPT, pr->int_send_name,
 >> +					  pr);
 >> +		if (ret) {
 >> +			EDEB_ERR(4, "Registering irq for ehea_send failed"
 >> +				 " port_res_nr:%d, ist=%X", i,
 >> +				 pr->send_eq->attr.ist1);
 >> +			goto failure;
 >> +		}
 >> +		EDEB(7, "irq_handle 0x%X for function ehea_send_int %d"
 >> +		     " registered", pr->send_eq->attr.ist1, i);
 >> +	}
 >
 > You seem to be iterating over some of the port_res structs twice, is
 > that what you intended?
 >

yes

 >> +failure:
 >> +	EDEB_EX(7, "ret=%d", ret);
 >> +	return ret;
 >
 > No further cleanup required? Should you be calling ehea_free_interrupts?
 >

good point, a proper error handling will be included

 >> +}
 >> +
 >> +static void ehea_free_interrupts(struct net_device *dev)
 >> +{
 >> +	struct ehea_port *port = (struct ehea_port*)dev->priv;
 >> +	int i;
 >> +
 >> +	EDEB_EN(7, "");
 >> +	/* send */
 >> +	for (i = 0; i < port->num_def_qps + port->num_tx_qps; i++) {
 >> +		ibmebus_free_irq(NULL, port->port_res[i].send_eq->attr.ist1,
 >> +				 &port->port_res[i]);
 >> +		EDEB(7, "free send interrupt for res %d with handle 0x%X",
 >> +		     i, port->port_res[i].send_eq->attr.ist1);
 >> +	}
 >> +
 >> +	/* receive */
 >> +	for (i = 0; i < port->num_def_qps; i++) {
 >> +		ibmebus_free_irq(NULL, port->port_res[i].recv_eq->attr.ist1,
 >> +				 &port->port_res[i]);
 >> +		EDEB(7, "free recv intterupt for res %d with handle 0x%X",
 >> +		     i, port->port_res[i].recv_eq->attr.ist1);
 >> +	}
 >> +	/* associated events */
 >> +	ibmebus_free_irq(NULL, port->qp_eq->attr.ist1, port);
 >> +	EDEB(7, "associated event interrupt for handle 0x%X freed",
 >> +	     port->qp_eq->attr.ist1);
 >> +	EDEB_EX(7, "");
 >> +}
 >> +
 >> +static int ehea_configure_port(struct ehea_port *port)
 >> +{
 >> +	int ret = -EINVAL;
 >> +	u64 hret = H_HARDWARE;
 >> +	struct hcp_query_ehea_port_cb_0 *ehea_port_cb_0 = NULL;
 >> +	u64 mask = 0;
 >> +	int i;
 >> +
 >> +	EDEB_EN(7, "");
 >> +
 >> +	ehea_port_cb_0 = kzalloc(H_CB_ALIGNMENT, GFP_KERNEL);
 >> +
 >> +	if (!ehea_port_cb_0) {
 >> +		EDEB_ERR(4, "No memory for ehea_port control block");
 >> +		ret = -ENOMEM;
 >> +		goto kzalloc_failed;
 >> +	}
 >> +
 >> +	ehea_port_cb_0->port_rc = EHEA_BMASK_SET(PXLY_RC_VALID, 1)
 >> +				| EHEA_BMASK_SET(PXLY_RC_IP_CHKSUM, 1)
 >> +				| EHEA_BMASK_SET(PXLY_RC_TCP_UDP_CHKSUM, 1)
 >> +                		| EHEA_BMASK_SET(PXLY_RC_VLAN_XTRACT, 1)
 >> +                		| EHEA_BMASK_SET(PXLY_RC_VLAN_TAG_FILTER,
 >> +				                 PXLY_RC_VLAN_FILTER)
 >> +				| EHEA_BMASK_SET(PXLY_RC_JUMBO_FRAME, 1);
 >> +
 >> +	for (i = 0; i < port->num_def_qps; i++) {
 >> +		ehea_port_cb_0->default_qpn_array[i] =
 >> +		    port->port_res[i].qp->init_attr.qp_nr;
 >> +
 >> +		EDEB(7, "default_qpn_array[%d]=%d",
 >> +		     i, port->port_res[i].qp->init_attr.qp_nr);
 >> +	}
 >> +
 >> +	EDEB(7, "ehea_port_cb_0");
 >> +	EDEB_DMP(7, (u8*)ehea_port_cb_0, sizeof(*ehea_port_cb_0), "");
 >> +
 >> +	mask = EHEA_BMASK_SET(H_PORT_CB0_PRC, 1)
 >> +	       | EHEA_BMASK_SET(H_PORT_CB0_DEFQPNARRAY, 1);
 >> +
 >> +	hret = ehea_h_modify_ehea_port(port->adapter->handle,
 >> +				       port->logical_port_id,
 >> +				       H_PORT_CB0,
 >> +				       mask,
 >> +				       (void*)ehea_port_cb_0);
 >> +
 >> +	if (hret != H_SUCCESS) {
 >> +		goto modify_ehea_port_failed;
 >> +	}
 >> +
 >> +	ret = 0;
 >> +
 >> +modify_ehea_port_failed:
 >> +	kfree(ehea_port_cb_0);
 >> +
 >> +kzalloc_failed:
 >> +	EDEB_EX(7, "ret=%d", ret);
 >> +	return ret;
 >> +}
 >> +
 >> +
 >> +static int ehea_gen_smrs(struct ehea_port_res *pr)
 >> +{
 >> +	u64 hret = H_HARDWARE;
 >
 > No need to set hret. You do that a lot, int foo = 0; foo = bar();
 >
 >> +	struct ehea_adapter *adapter = pr->port->adapter;
 >> +	EDEB_EN(7, "ehea_port_res=%p", pr);
 >> +	hret = hipz_h_register_smr(adapter->handle,
 >> +				   adapter->mr.handle,
 >> +				   adapter->mr.vaddr,
 >> +				   EHEA_MR_ACC_CTRL,
 >> +				   adapter->pd,
 >> +				   &pr->send_mr);
 >> +	if (hret != H_SUCCESS)
 >> +		goto ehea_gen_smrs_err1;
 >> +
 >> +	hret = hipz_h_register_smr(adapter->handle,
 >> +				   adapter->mr.handle,
 >> +				   adapter->mr.vaddr,
 >> +				   EHEA_MR_ACC_CTRL,
 >> +				   adapter->pd,
 >> +				   &pr->recv_mr);
 >> +	if (hret != H_SUCCESS)
 >> +		goto ehea_gen_smrs_err2;
 >> +	EDEB_EX(7, "");
 >> +	return 0;
 >> +
 >> +ehea_gen_smrs_err2:
 >> +	hret = ehea_h_free_resource_mr(adapter->handle, pr->send_mr.handle);
 >> +	if (hret != H_SUCCESS)
 >> +		EDEB_ERR(4, "Could not free SMR");
 >> +ehea_gen_smrs_err1:
 >> +	return -EINVAL;
 >> +}
 >> +
 >> +static void ehea_rem_smrs(struct ehea_port_res *pr)
 >> +{
 >> +	u64 hret = H_HARDWARE;
 >> +	struct ehea_adapter *adapter = pr->port->adapter;
 >> +	EDEB_EN(7, "ehea_port_res=%p", pr);
 >> +	hret = ehea_h_free_resource_mr(adapter->handle, pr->send_mr.handle);
 >> +	if (hret != H_SUCCESS)
 >> +		EDEB_ERR(4, "Could not free send SMR for pr=%p", pr);
 >> +
 >> +	hret = ehea_h_free_resource_mr(adapter->handle, pr->recv_mr.handle);
 >> +	if (hret != H_SUCCESS)
 >> +		EDEB_ERR(4, "Could not free receive SMR for pr=%p", pr);
 >> +	EDEB_EX(7, "");
 >> +}
 >
 > It's a bit worrying that this routine can fail, but returns void, ie. it
 > can't report failure to its caller. (but perhaps it's ok).
 >
 >> +
 >> +static int ehea_init_port_res(struct ehea_port *port, struct ehea_port_res *pr,
 >> +			      struct port_res_cfg *pr_cfg, int queue_token)
 >> +{
 >> +	int ret = -EINVAL;
 >> +	int max_rq_entries = 0;
 >> +	enum ehea_eq_type eq_type = EHEA_EQ;
 >> +	struct ehea_qp_init_attr *init_attr;
 >> +	struct ehea_adapter *adapter = port->adapter;
 >> +
 >> +	EDEB_EN(7, "port=%p, pr=%p", port, pr);
 >> +
 >> +	memset(pr, 0, sizeof(struct ehea_port_res));
 >> +
 >> +	pr->port = port;
 >> +	spin_lock_init(&pr->send_lock);
 >> +	spin_lock_init(&pr->recv_lock);
 >> +	spin_lock_init(&pr->xmit_lock);
 >> +	spin_lock_init(&pr->netif_queue);
 >> +
 >> +	pr->recv_eq = ehea_create_eq(adapter, eq_type,
 >> +				     EHEA_MAX_ENTRIES_EQ, 0);
 >> +	if (!pr->recv_eq) {
 >> +		EDEB_ERR(4, "ehea_create_eq failed (recv_eq)");
 >> +		goto ehea_init_port_res_err1;
 >> +	}
 >> +	pr->send_eq = ehea_create_eq(adapter, eq_type,
 >> +				     EHEA_MAX_ENTRIES_EQ, 0);
 >> +	if (!pr->send_eq) {
 >> +		EDEB_ERR(4, "ehea_create_eq failed (send_eq)");
 >> +		goto ehea_init_port_res_err2;
 >> +	}
 >> +
 >> +	pr->recv_cq = ehea_create_cq(adapter, pr_cfg->max_entries_rcq,
 >> +				     pr->recv_eq->ipz_eq_handle,
 >> +				     port->logical_port_id);
 >> +	if (!pr->recv_cq) {
 >> +		EDEB_ERR(4, "ehea_create_cq failed (cq_recv)");
 >> +		goto ehea_init_port_res_err3;
 >> +	}
 >> +
 >> +	pr->send_cq = ehea_create_cq(adapter, pr_cfg->max_entries_scq,
 >> +				     pr->send_eq->ipz_eq_handle,
 >> +				     port->logical_port_id);
 >> +	if (!pr->send_cq) {
 >> +		EDEB_ERR(4, "ehea_create_cq failed (cq_send)");
 >> +		goto ehea_init_port_res_err4;
 >> +	}
 >> +
 >> +	init_attr = (struct ehea_qp_init_attr*)
 >> +	    kzalloc(sizeof(struct ehea_qp_init_attr), GFP_KERNEL);
 >> +
 >> +	if (!init_attr) {
 >> +		EDEB_ERR(4, "no mem for init_attr struct");
 >> +		ret = -ENOMEM;
 >> +		goto ehea_init_port_res_err5;
 >> +	}
 >> +
 >> +	init_attr->low_lat_rq1 = 1;
 >> +	init_attr->signalingtype = 1;	/* generate CQE if specified in WQE */
 >> +	init_attr->rq_count = 3;
 >> +	init_attr->qp_token = queue_token;
 >> +
 >> +	init_attr->max_nr_send_wqes = pr_cfg->max_entries_sq;
 >> +	init_attr->max_nr_rwqes_rq1 = pr_cfg->max_entries_rq1;
 >> +	init_attr->max_nr_rwqes_rq2 = pr_cfg->max_entries_rq2;
 >> +	init_attr->max_nr_rwqes_rq3 = pr_cfg->max_entries_rq3;
 >> +
 >> +	init_attr->wqe_size_enc_sq = EHEA_SG_SQ;
 >> +	init_attr->wqe_size_enc_rq1 = EHEA_SG_RQ1;
 >> +	init_attr->wqe_size_enc_rq2 = EHEA_SG_RQ2;
 >> +	init_attr->wqe_size_enc_rq3 = EHEA_SG_RQ3;
 >> +
 >> +	init_attr->rq2_threshold = EHEA_RQ2_THRESHOLD;
 >> +	init_attr->rq3_threshold = EHEA_RQ3_THRESHOLD;
 >> +	init_attr->port_nr = port->logical_port_id;
 >> +	init_attr->send_cq_handle = pr->send_cq->ipz_cq_handle;
 >> +	init_attr->recv_cq_handle = pr->recv_cq->ipz_cq_handle;
 >> +	init_attr->aff_eq_handle = port->qp_eq->ipz_eq_handle;
 >> +
 >> +	pr->qp = ehea_create_qp(adapter, adapter->pd, init_attr);
 >> +	if (!pr->qp) {
 >> +		EDEB_ERR(4, "could not create queue pair");
 >> +		goto ehea_init_port_res_err6;
 >> +	}
 >> +
 >> +	/* SQ */
 >> +	max_rq_entries = init_attr->act_nr_send_wqes;
 >> +	pr->skb_arr_sq = (struct sk_buff**)vmalloc(sizeof(struct sk_buff*)
 >> +						    * (max_rq_entries + 1));
 >> +	if (!pr->skb_arr_sq) {
 >> +		EDEB_ERR(4, "vmalloc for skb_arr_sq failed");
 >> +		goto ehea_init_port_res_err7;
 >> +	}
 >> +	memset(pr->skb_arr_sq, 0, sizeof(void*) * (max_rq_entries + 1));
 >> +	pr->skb_sq_index = 0;
 >> +	pr->skb_arr_sq_len = max_rq_entries + 1;
 >> +
 >> +	/* RQ 1 */
 >> +	max_rq_entries = init_attr->act_nr_rwqes_rq1;
 >> +	pr->skb_arr_rq1 = (struct sk_buff**)vmalloc(sizeof(struct sk_buff*)
 >> +						     * (max_rq_entries + 1));
 >> +	if (!pr->skb_arr_rq1) {
 >> +		EDEB_ERR(4, "vmalloc for skb_arr_rq1 failed");
 >> +		goto ehea_init_port_res_err8;
 >> +	}
 >> +	memset(pr->skb_arr_rq1, 0, sizeof(void*) * (max_rq_entries + 1));
 >> +	pr->skb_arr_rq1_len = max_rq_entries + 1;
 >> +
 >> +	/* RQ 2 */
 >> +	max_rq_entries = init_attr->act_nr_rwqes_rq2;
 >> +	pr->skb_arr_rq2 = (struct sk_buff**)vmalloc(sizeof(struct sk_buff*)
 >> +						     * (max_rq_entries + 1));
 >> +	if (!pr->skb_arr_rq2) {
 >> +		EDEB_ERR(4, "vmalloc for skb_arr_rq2 failed");
 >> +		goto ehea_init_port_res_err9;
 >> +	}
 >> +	memset(pr->skb_arr_rq2, 0, sizeof(void*) * (max_rq_entries + 1));
 >> +	pr->skb_arr_rq2_len = max_rq_entries;
 >> +	pr->skb_rq2_index = 0;
 >> +
 >> +	/* RQ 3 */
 >> +	max_rq_entries = init_attr->act_nr_rwqes_rq3;
 >> +	pr->skb_arr_rq3 = (struct sk_buff**)vmalloc(sizeof(struct sk_buff*)
 >> +						     * (max_rq_entries + 1));
 >> +	if (!pr->skb_arr_rq3) {
 >> +		EDEB_ERR(4, "vmalloc for skb_arr_rq3 failed");
 >> +		goto ehea_init_port_res_err10;
 >> +	}
 >> +	memset(pr->skb_arr_rq3, 0, sizeof(void*) * (max_rq_entries + 1));
 >> +	pr->skb_arr_rq3_len = max_rq_entries;
 >> +	pr->skb_rq3_index = 0;
 >
 > You shouldn't need the sk_buff** casts here. You probably should use
 > kzalloc here, instead of vmalloc + memset. Depends on how big
 > max_rq_entries can be.
 >
 >> +
 >> +	if (ehea_gen_smrs(pr) != 0)
 >> +		goto ehea_init_port_res_err11;
 >> +	tasklet_init(&pr->send_comp_task, ehea_send_irq_tasklet,
 >> +		     (unsigned long)pr);
 >> +	atomic_set(&pr->swqe_avail, EHEA_MAX_ENTRIES_SQ - 1);
 >> +
 >> +	kfree(init_attr);
 >> +	ret = 0;
 >> +	goto done;
 >> +
 >> +ehea_init_port_res_err11:
 >> +	vfree(pr->skb_arr_rq3);
 >> +ehea_init_port_res_err10:
 >> +	vfree(pr->skb_arr_rq2);
 >> +ehea_init_port_res_err9:
 >> +	vfree(pr->skb_arr_rq1);
 >> +ehea_init_port_res_err8:
 >> +	vfree(pr->skb_arr_sq);
 >> +ehea_init_port_res_err7:
 >> +	ehea_destroy_qp(pr->qp);
 >> +ehea_init_port_res_err6:
 >> +	kfree(init_attr);
 >> +ehea_init_port_res_err5:
 >> +	ehea_destroy_cq(pr->send_cq);
 >> +ehea_init_port_res_err4:
 >> +	ehea_destroy_cq(pr->recv_cq);
 >> +ehea_init_port_res_err3:
 >> +	ehea_destroy_eq(pr->send_eq);
 >> +ehea_init_port_res_err2:
 >> +	ehea_destroy_eq(pr->recv_eq);
 >> +ehea_init_port_res_err1:
 >> +done:
 >> +	EDEB_EX(7, "ret=%d", ret);
 >> +	return ret;
 >> +}
 >
 > You can vfree/kfree a NULL pointer, so you can probably amalgamate some
 > of these error cases if you initialise the pointers to NULL at the
 > beginning.
 >

very good point, this mechanism can also be used for ehea_destroy_xx
which will simplify the error path.
done

 >> +
 >> +static int ehea_clean_port_res(struct ehea_port *port, struct ehea_port_res *pr)
 >> +{
 >> +	int i;
 >> +	int ret = -EINVAL;
 >> +
 >> +	EDEB_EN(7, "Not completed yet...");
 >> +
 >> +	ret = ehea_destroy_qp(pr->qp);
 >> +	if (ret)
 >> +		EDEB_ERR(4, "could not destroy queue pair");
 >> +
 >> +	ret = ehea_destroy_cq(pr->send_cq);
 >> +	if (ret)
 >> +		EDEB_ERR(4, "could not destroy send_cq");
 >> +
 >> +	ret = ehea_destroy_cq(pr->recv_cq);
 >> +	if (ret)
 >> +		EDEB_ERR(4, "could not destroy recv_cq");
 >> +
 >> +	ret = ehea_destroy_eq(pr->send_eq);
 >> +	if (ret)
 >> +		EDEB_ERR(4, "could not destroy send_eq");
 >> +
 >> +	ret = ehea_destroy_eq(pr->recv_eq);
 >> +	if (ret)
 >> +		EDEB_ERR(4, "could not destroy recv_eq");
 >
 > If these are leaking memory they're probably worth a printk.
 >
 >> +	for (i = 0; i < pr->skb_arr_rq1_len; i++) {
 >> +		if (pr->skb_arr_rq1[i])
 >> +			dev_kfree_skb(pr->skb_arr_rq1[i]);
 >> +	}
 >> +
 >> +	for (i = 0; i < pr->skb_arr_rq2_len; i++)
 >> +		if (pr->skb_arr_rq2[i])
 >> +			dev_kfree_skb(pr->skb_arr_rq2[i]);
 >> +
 >> +	for (i = 0; i < pr->skb_arr_rq3_len; i++)
 >> +		if (pr->skb_arr_rq3[i])
 >> +			dev_kfree_skb(pr->skb_arr_rq3[i]);
 >> +
 >> +	for (i = 0; i < pr->skb_arr_sq_len; i++)
 >> +		if (pr->skb_arr_sq[i])
 >> +			dev_kfree_skb(pr->skb_arr_sq[i]);
 >> +
 >> +	vfree(pr->skb_arr_sq);
 >> +	vfree(pr->skb_arr_rq1);
 >> +	vfree(pr->skb_arr_rq2);
 >> +	vfree(pr->skb_arr_rq3);
 >> +
 >> +	ehea_rem_smrs(pr);
 >> +	EDEB_EX(7, "ret=%d", ret);
 >> +	return ret;
 >> +}
 >> +
 >> +static inline void write_ip_start_end(struct ehea_swqe *swqe,
 >> +				      const struct sk_buff *skb)
 >> +{
 >> +
 >> +	swqe->ip_start = (u8)(((u64)skb->nh.iph) - ((u64)skb->data));
 >> +	swqe->ip_end = (u8)(swqe->ip_start + skb->nh.iph->ihl * 4 - 1);
 >> +}
 >
 >> +static inline void write_tcp_offset_end(struct ehea_swqe *swqe,
 >> +					const struct sk_buff *skb)
 >> +{
 >> +	swqe->tcp_offset = (u8)(swqe->ip_end + 1 + offsetof(struct tcphdr,
 >> +							    check));
 >> +	swqe->tcp_end = (u16)skb->len - 1;
 >> +}
 >> +
 >> +static inline void write_udp_offset_end(struct ehea_swqe *swqe,
 >> +					const struct sk_buff *skb)
 >> +{
 >> +	swqe->tcp_offset = (u8)(swqe->ip_end + 1 + offsetof(struct udphdr,
 >> +							    check));
 >> +	swqe->tcp_end = (u16)skb->len - 1;
 >> +}
 >
 > These three need some explanation at best.
 >

ok, done

 >> +
 >> +static inline void write_swqe2_data(struct sk_buff *skb,
 >> +				    struct net_device *dev,
 >> +				    struct ehea_swqe *swqe,
 >> +				    u32 lkey)
 >> +{
 >> +	int skb_data_size, nfrags, headersize, i, sg1entry_contains_frag_data;
 >> +	struct ehea_vsgentry *sg_list;
 >> +	struct ehea_vsgentry *sg1entry;
 >> +	struct ehea_vsgentry *sgentry;
 >> +	u8 *imm_data;
 >> +	u64 tmp_addr;
 >> +	skb_frag_t *frag;
 >> +	EDEB_EN(7, "");
 >> +
 >> +	skb_data_size = skb->len - skb->data_len;
 >> +	nfrags = skb_shinfo(skb)->nr_frags;
 >> +	sg1entry = &swqe->u.immdata_desc.sg_entry;
 >> +	sg_list = (struct ehea_vsgentry*)&swqe->u.immdata_desc.sg_list;
 >> +	imm_data = &swqe->u.immdata_desc.immediate_data[0];
 >> +	swqe->descriptors = 0;
 >> +	sg1entry_contains_frag_data = 0;
 >> +
 >> +	if ((dev->features & NETIF_F_TSO) && skb_shinfo(skb)->gso_size) {
 >> +		/* Packet is TCP with TSO enabled */
 >> +		swqe->tx_control |= EHEA_SWQE_TSO;
 >> +		swqe->mss = skb_shinfo(skb)->gso_size;
 >> +		/* copy only eth/ip/tcp headers to immediate data and
 >> +		 * the rest of skb->data to sg1entry
 >> +		 */
 >> +		headersize = ETH_HLEN + (skb->nh.iph->ihl * 4)
 >> +		    + skb->h.th->doff * 4;
 >> +		skb_data_size = skb->len - skb->data_len;
 >> +
 >> +		if (skb_data_size >= headersize) {
 >> +			/* copy immediate data */
 >> +			memcpy(imm_data, skb->data, headersize);
 >> +			swqe->immediate_data_length = headersize;
 >> +
 >> +			if (skb_data_size > headersize) {
 >> +				/* set sg1entry data */
 >> +				sg1entry->l_key = lkey;
 >> +				sg1entry->len = skb_data_size - headersize;
 >> +
 >> +				tmp_addr = (u64)(skb->data + headersize);
 >> +				sg1entry->vaddr =
 >> +					get_swqe_addr(tmp_addr, 0);
 >> +
 >> +				swqe->descriptors++;
 >> +			}
 >> +		} else
 >> +			EDEB_ERR(4, "Cannot handle fragmented headers");
 >> +	} else {
 >> +		/* Packet is any nonTSO type
 >> +		 *
 >> +		 * Copy as much as possible skb->data to immediate data and
 >> +		 * the rest to sg1entry
 >> +		 */
 >> +		if (skb_data_size >= SWQE2_MAX_IMM) {
 >> +			/* copy immediate data */
 >> +			memcpy(imm_data, skb->data, SWQE2_MAX_IMM);
 >> +
 >> +			swqe->immediate_data_length = SWQE2_MAX_IMM;
 >> +
 >> +			if (skb_data_size > SWQE2_MAX_IMM) {
 >> +				/* copy sg1entry data */
 >> +				sg1entry->l_key = lkey;
 >> +				sg1entry->len = skb_data_size - SWQE2_MAX_IMM;
 >> +				tmp_addr = (u64)(skb->data + SWQE2_MAX_IMM);
 >> +				sg1entry->vaddr = get_swqe_addr(tmp_addr, 0);
 >> +				swqe->descriptors++;
 >> +			}
 >> +		} else {
 >> +			memcpy(imm_data, skb->data, skb_data_size);
 >> +			swqe->immediate_data_length = skb_data_size;
 >> +		}
 >> +	}
 >> +
 >> +	/* write descriptors */
 >> +	if (nfrags > 0) {
 >> +		if (swqe->descriptors == 0) {
 >> +			/* sg1entry not yet used */
 >> +			frag = &skb_shinfo(skb)->frags[0];
 >> +
 >> +			/* copy sg1entry data */
 >> +			sg1entry->l_key = lkey;
 >> +			sg1entry->len = frag->size;
 >> +			tmp_addr =  (u64)(page_address(frag->page) +
 >> +					    frag->page_offset);
 >> +			sg1entry->vaddr = get_swqe_addr(tmp_addr,
 >> +							EHEA_MR_TX_DATA_PN);
 >> +			swqe->descriptors++;
 >> +			sg1entry_contains_frag_data = 1;
 >> +		}
 >> +
 >> +		for (i = sg1entry_contains_frag_data; i < nfrags; i++) {
 >> +
 >> +			frag = &skb_shinfo(skb)->frags[i];
 >> +			sgentry = &sg_list[i - sg1entry_contains_frag_data];
 >> +
 >> +			sgentry->l_key = lkey;
 >> +			sgentry->len = frag->size;
 >> +
 >> +			tmp_addr = (u64)(page_address(frag->page)
 >> +					 + frag->page_offset);
 >> +			sgentry->vaddr = get_swqe_addr(tmp_addr,
 >> +						       EHEA_MR_TX_DATA_PN + i);
 >> +		}
 >> +	}
 >> +
 >> +	EDEB_EX(7, "");
 >> +}
 >> +
 >> +static int ehea_ioctl(struct net_device *dev, struct ifreq *ifr, int cmd)
 >> +{
 >> +	EDEB_ERR(4, "ioctl not supported: dev=%s cmd=%d", dev->name, cmd);
 >> +	return -EOPNOTSUPP;
 >> +}
 >> +
 >> +static u64 ehea_broadcast_reg_helper(struct ehea_port *port, u32 hcallid)
 >> +{
 >> +	u64 hret = H_HARDWARE;
 >> +	u8 reg_type = 0;
 >> +
 >> +	if (hcallid == H_REG_BCMC) {
 >> +		EDEB(7, "REGistering MAC for broadcast");
 >> +	} else {
 >> +		EDEB(7, "DEREGistering MAC for broadcast");
 >> +	}
 >> +
 >> +	/* De/Register untagged packets */
 >> +	reg_type = EHEA_BCMC_BROADCAST | EHEA_BCMC_UNTAGGED;
 >> +	hret = ehea_h_reg_dereg_bcmc(port->adapter->handle,
 >> +				     port->logical_port_id,
 >> +				     reg_type, port->mac_addr, 0, hcallid);
 >> +	if (hret != H_SUCCESS)
 >> +		goto hcall_failed;
 >> +
 >> +	/* De/Register VLAN packets */
 >> +	reg_type = EHEA_BCMC_BROADCAST | EHEA_BCMC_VLANID_ALL;
 >> +	hret = ehea_h_reg_dereg_bcmc(port->adapter->handle,
 >> +				     port->logical_port_id,
 >> +				     reg_type, port->mac_addr, 0, hcallid);
 >> +hcall_failed:
 >
 > unregister here?
 >
 >> +	return hret;
 >> +}
 >> +
 >> +static int ehea_set_mac_addr(struct net_device *dev, void *sa)
 >> +{
 >> +	int ret = -EOPNOTSUPP;
 >> +	u64 hret = H_HARDWARE;
 >> +	struct hcp_query_ehea_port_cb_0 *ehea_port_cb_0 = NULL;
 >> +	struct ehea_port *port = (struct ehea_port*)dev->priv;
 >> +	struct sockaddr *mac_addr = (struct sockaddr*)sa;
 >> +
 >> +	EDEB_EN(7, "devname=%s", dev->name);
 >> +	EDEB_DMP(7, (u8*)&(mac_addr->sa_data[0]), 14, "");
 >> +
 >> +	if (!is_valid_ether_addr(mac_addr->sa_data)) {
 >> +		ret = -EADDRNOTAVAIL;
 >> +		goto invalid_mac;
 >> +	}
 >> +
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
 > Don't need casts, memcpy takes void *. You should use ETH_ALEN
 > (include/linux/if_ether.h) instead of 6.
 >

done

 >> +
 >> +	ehea_port_cb_0->port_mac_addr = ehea_port_cb_0->port_mac_addr >> 16;
 >> +
 >> +	EDEB(7, "ehea_port_cb_0");
 >> +	EDEB_DMP(7, (u8*)ehea_port_cb_0,
 >> +		 sizeof(struct hcp_query_ehea_port_cb_0), "");
 >> +
 >> +	hret = ehea_h_modify_ehea_port(port->adapter->handle,
 >> +				       port->logical_port_id,
 >> +				       H_PORT_CB0,
 >> +				       EHEA_BMASK_SET(H_PORT_CB0_MAC, 1),
 >> +				       (void*)ehea_port_cb_0);
 >> +	if (hret != H_SUCCESS) {
 >> +		ret = -EOPNOTSUPP;
 >> +		goto hcall_failed;
 >> +	}
 >> +
 >> +	memcpy(dev->dev_addr, mac_addr->sa_data, dev->addr_len);
 >> +
 >> +	/* Deregister old MAC in PHYP */
 >> +	hret = ehea_broadcast_reg_helper(port, H_DEREG_BCMC);
 >> +	if (hret) {
 >> +		ret = -EOPNOTSUPP;
 >> +		goto hcall_failed;
 >
 > What happens here? No mac? Old mac?
 >

good question, we have to think about a reasonable recovery strategy

 >> +	}
 >> +
 >> +	port->mac_addr = ehea_port_cb_0->port_mac_addr << 16;
 >> +
 >> +	/* Register new MAC in PHYP */
 >> +	hret = ehea_broadcast_reg_helper(port, H_REG_BCMC);
 >> +	if (hret) {
 >> +		ret = -EOPNOTSUPP;
 >> +		goto hcall_failed;
 >> +	}
 >> +
 >> +	ret = 0;
 >> +
 >> +hcall_failed:
 >> +	kfree(ehea_port_cb_0);
 >> +
 >> +kzalloc_failed:
 >> +invalid_mac:
 >> +	EDEB_EX(7, "ret=%d", ret);
 >> +	return ret;
 >> +}
 >> +
 >> +static void ehea_promiscuous(struct net_device *dev, int enable)
 >> +{
 >> +	struct ehea_port *port = dev->priv;
 >> +
 >> +	if (!port->promisc) {
 >> +		if (enable) {
 >> +			/* Enable promiscuous mode */
 >> +			EDEB(7, "Enabling IFF_PROMISC");
 >> +			EDEB_ERR(4, "Enable promiscuous mode: "
 >> +				 "not yet implemented");
 >> +			port->promisc = EHEA_ENABLE;
 >> +		}
 >> +	} else {
 >> +		if (!enable) {
 >> +			/* Disable promiscuous mode */
 >> +			EDEB(7, "Disabling IFF_PROMISC");
 >> +			EDEB_ERR(4, "Disable promiscuous mode: "
 >> +				 "not yet implemented");
 >> +			port->promisc = EHEA_DISABLE;
 >> +		}
 >> +	}
 >> +}
 >> +
 >> +static u64 ehea_multicast_reg_helper(struct ehea_port *port,
 >> +				     u64 mc_mac_addr,
 >> +				     u32 hcallid)
 >> +{
 >> +	u64 hret = H_HARDWARE;
 >> +	u8 reg_type = 0;
 >> +
 >> +	reg_type = EHEA_BCMC_SCOPE_ALL | EHEA_BCMC_MULTICAST
 >> +		 | EHEA_BCMC_UNTAGGED;
 >> +
 >> +	hret = ehea_h_reg_dereg_bcmc(port->adapter->handle,
 >> +				     port->logical_port_id,
 >> +				     reg_type, mc_mac_addr, 0, hcallid);
 >> +	if (hret)
 >> +		goto hcall_failed;
 >> +
 >> +	reg_type = EHEA_BCMC_SCOPE_ALL | EHEA_BCMC_MULTICAST
 >> +		 | EHEA_BCMC_VLANID_ALL;
 >> +
 >> +	hret = ehea_h_reg_dereg_bcmc(port->adapter->handle,
 >> +				     port->logical_port_id,
 >> +				     reg_type, mc_mac_addr, 0, hcallid);
 >> +hcall_failed:
 >> +	return hret;
 >> +}
 >> +
 >> +static int ehea_drop_multicast_list(struct net_device *dev)
 >> +{
 >> +	int ret = 0;
 >> +	u64 hret = H_HARDWARE;
 >> +	struct ehea_port *port = dev->priv;
 >> +	struct ehea_mc_list *mc_entry = port->mc_list;
 >> +	struct list_head *pos;
 >> +	struct list_head *temp;
 >> +
 >> +	EDEB_EN(7, "devname=%s", dev->name);
 >> +
 >> +	if (!list_empty(&mc_entry->list)) {
 >> +		list_for_each_safe(pos, temp, &(port->mc_list->list)) {
 >> +			mc_entry = list_entry(pos, struct ehea_mc_list, list);
 >> +
 >> +			EDEB(7, "Deregistering MAC %lx", mc_entry->macaddr);
 >> +
 >> +			hret = ehea_multicast_reg_helper(port,
 >> +							 mc_entry->macaddr,
 >> +							 H_DEREG_BCMC);
 >> +			if (hret) {
 >> +				EDEB_ERR(4, "Failed deregistering mcast MAC");
 >> +				ret = -EINVAL;
 >> +			}
 >> +
 >> +			list_del(pos);
 >> +			kfree(mc_entry);
 >> +		}
 >> +	}
 >
 > You don't need the if.
 >
 >

ok, removed

 > Ok, I'm tired now, I might read the rest later.
 >
 > cheers
 >


