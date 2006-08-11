Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932177AbWHKQJ0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932177AbWHKQJ0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Aug 2006 12:09:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932180AbWHKQJ0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Aug 2006 12:09:26 -0400
Received: from mtagate4.uk.ibm.com ([195.212.29.137]:11414 "EHLO
	mtagate4.uk.ibm.com") by vger.kernel.org with ESMTP id S932177AbWHKQJY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Aug 2006 12:09:24 -0400
Message-ID: <44DCABB1.2090300@de.ibm.com>
Date: Fri, 11 Aug 2006 18:09:21 +0200
From: Thomas Klein <osstklei@de.ibm.com>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: Michael Neuling <mikey@neuling.org>
CC: linux-ppc <linuxppc-dev@ozlabs.org>,
       Jan-Bernd Themann <ossthema@de.ibm.com>,
       netdev <netdev@vger.kernel.org>, Thomas Klein <tklein@de.ibm.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Christoph Raisch <raisch@de.ibm.com>,
       Jan-Bernd Themann <themann@de.ibm.com>, Marcus Eder <meder@de.ibm.com>,
       Thomas Klein <osstklei@de.ibm.com>
Subject: Re: [PATCH 3/6] ehea: queue management
References: <44D99F38.8010306@de.ibm.com> <20060811000540.200CE67B6B@ozlabs.org>
In-Reply-To: <20060811000540.200CE67B6B@ozlabs.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mikey,

first of all thanks a lot for the effort you invested to review our code.
We're quite happy about the improvements we made due to your comments.
See our answers below.

Kind regards
Thomas



Michael Neuling wrote:
> Please add comments to make the code more readable, especially at the
> start of functions/structures to describe what they do.  A large readme
> at the start of ehea_main.c which gave an overview of the driver design
> would be really useful.

We'll improve comments over the next patch iterations.

>> +static int ipz_queue_ctor(struct ipz_queue *queue,
>> +                      const u32 nr_of_pages,
>> +                      const u32 pagesize, const u32 qe_size,
>> +                      const u32 nr_of_sg)
>> +{
>> +    int f;
>> +    EDEB_EN(7, "nr_of_pages=%x pagesize=%x qe_size=%x",
>> +            nr_of_pages, pagesize, qe_size);
>> +    queue->queue_length = nr_of_pages * pagesize;
>> +    queue->queue_pages = vmalloc(nr_of_pages * sizeof(void *));
>
>> +    if (!queue->queue_pages) {
>> +            EDEB(4, "ERROR!! didn't get the memory");
>> +            return 0;
>> +    }
>> +    memset(queue->queue_pages, 0, nr_of_pages * sizeof(void *));
>> +
>> +    for (f = 0; f < nr_of_pages; f++) {
>> +            (queue->queue_pages)[f] =
>> +                (struct ipz_page *)get_zeroed_page(GFP_KERNEL);
>> +            if (!(queue->queue_pages)[f]) {
>> +                    break;
>> +            }
>> +    }
>> +    if (f < nr_of_pages) {
>> +            int g;
>> +            EDEB_ERR(4, "couldn't get 0ed pages queue=%p f=%x "
>> +                     "nr_of_pages=%x", queue, f, nr_of_pages);
>> +            for (g = 0; g < f; g++) {
>> +                    free_page((unsigned long)(queue->queue_pages)[g]);
>> +            }
>> +            return 0;
>
> If you return here when calling from ehea_create_eq, I think you are
> leaking the queue->queue_pages allocation (the pages they point to are
> freed correctly).

You're right. Fixed it.


>> +void ehea_cq_delete(struct ehea_cq *cq)
>> +{
>> +    vfree(cq);
>> +}
>
> This is used in only two places.  Do we need it?

No. The ehea_?q_new()/ehea_?q_delete() functions were entirely removed.

>
> If we do... can we static inline?
>


>> +    hret = ehea_h_alloc_resource_cq(adapter->handle,
>> +                                    cq,
>> +                                    &cq->attr,
>> +                                    &cq->ipz_cq_handle, &cq->galpas);
>
> hret set twice...

Fixed.

>
>
>
>> +    if (hret != H_SUCCESS) {
>> +            EDEB_ERR(4, "ehea_h_alloc_resource_cq failed. hret=%lx", hret);
>> +            goto create_cq_exit1;
>> +    }
>> +
>> +    ipz_rc = ipz_queue_ctor(&cq->ipz_queue, cq->attr.nr_pages,
>> +                            EHEA_PAGESIZE, sizeof(struct ehea_cqe), 0);
>> +    if (!ipz_rc)
>> +            goto create_cq_exit2;
>> +
>> +    hret = H_SUCCESS;
>> +
>> +    for (counter = 0; counter < cq->attr.nr_pages; counter++) {
>> +            vpage = ipz_qpageit_get_inc(&cq->ipz_queue);
>
> vpga set twice...

vpage gets assigned to rpage via the virt_to_abs() call. So using
it again afterwards is ok.

>
>> +            if (!vpage) {
>> +                    EDEB_ERR(4, "ipz_qpageit_get_inc() "
>> +                             "returns NULL adapter=%p", adapter);
>> +                    goto create_cq_exit3;
>> +            }
>> +
>> +            rpage = virt_to_abs(vpage);
>> +
>> +            hret = ehea_h_register_rpage_cq(adapter->handle,
>> +                                            cq->ipz_cq_handle,
>> +                                            0,
>> +                                            HIPZ_CQ_REGISTER_ORIG,
>> +                                            rpage, 1, cq->galpas.kernel);
>> +
>> +            if (hret < H_SUCCESS) {
>> +                    EDEB_ERR(4, "ehea_h_register_rpage_cq() failed "
>> +                             "ehea_cq=%p hret=%lx "
>> +                             "counter=%i act_pages=%i",
>> +                             cq, hret, counter, cq->attr.nr_pages);
>> +                    goto create_cq_exit3;
>> +            }
>> +
>> +            if (counter == (cq->attr.nr_pages - 1)) {
>> +                    vpage = ipz_qpageit_get_inc(&cq->ipz_queue);
>> +
>> +                    if ((hret != H_SUCCESS) || (vpage)) {
>> +                            EDEB_ERR(4, "Registration of pages not "
>> +                                     "complete ehea_cq=%p hret=%lx",
>> +                                     cq, hret)
>> +                            goto create_cq_exit3;
>> +                    }
>> +            } else {
>> +                    if ((hret != H_PAGE_REGISTERED) || (vpage == 0)) {
>> +                            EDEB_ERR(4, "Registration of page failed "
>> +                                     "ehea_cq=%p hret=%lx"
>> +                                     "counter=%i act_pages=%i",
>> +                                     cq, hret, counter, cq->attr.nr_pages);
>> +                            goto create_cq_exit3;
>> +                    }
>> +            }
>> +    }


>> +void ehea_eq_delete(struct ehea_eq *eq)
>> +{
>> +    vfree(eq);
>> +}
>
> Again, is this really needed and what about static inline?

removed. see above.


>> +struct ehea_qp *ehea_qp_new(void) {
>> +    struct ehea_qp *qp = vmalloc(sizeof(*qp));
>> +    if (qp != 0) {
>
> if (qp) ??

removed. see above.


>> +static inline u32 map_swqe_size(u8 swqe_enc_size)
>> +{
>> +    return 128 << swqe_enc_size;
>> +}
>> +
>> +static inline u32 map_rwqe_size(u8 rwqe_enc_size)
>> +{
>> +    return 128 << rwqe_enc_size;
>> +}
>
> Snap!  These are identical...

Agreed. Functions were replaced by a single map_wqe_size() function.


>> +                    hret = ehea_h_register_rpage_mr(adapter->handle,
>> +                                                    adapter->mr.handle,
>> +                                                    0,
>> +                                                    0,
>> +                                                    (u64)pt_abs,
>> +                                                    num_pages);
>
> They probably don't all need their own line.

Agreed.

>
>> +                    nr_pages -= num_pages;
>> +            } else {
>> +                    u64 abs_adr = virt_to_abs((void *)(((u64)start)
>> +                                                       + (k * PAGE_SIZE)));
>> +                    hret = ehea_h_register_rpage_mr(adapter->handle,
>> +                                                    adapter->mr.handle,
>> +                                                    0,
>> +                                                    0,
>> +                                                    abs_adr,
>> +                                                    1);
>
> Ditto.

Agreed.


>> +    if (nr_pages > 1)
>> +            hret = ehea_h_register_rpage_mr(adapter->handle,
>> +                                            mr->handle,
>> +                                            0,
>> +                                            0,
>> +                                            (u64)pt_abs,
>> +                                            nr_pages);
>> +    else
>> +            hret = ehea_h_register_rpage_mr(adapter->handle,
>> +                                            mr->handle,
>> +                                            0,
>> +                                            0,
>> +                                            first_page,
>> +                                            1);
>
> hret = ehea_h_register_rpage_mr(adapter->handle, mr->handle, 0,
>                               0, (nr_pages > 1)?(u64)pt_abs:first_page,
>                               nr_pages);
> Simpler?

It would have to be
hret = ehea_h_register_rpage_mr(adapter->handle, mr->handle, 0,
                                0, (nr_pages > 1)?(u64)pt_abs:first_page,
                                (nr_pages > 1)?nr_pages:1);

It's more sophisticated but surely not more readable to have this in a function call.

>
> Or get ehea_h_register_rpage_mr to do this for you?  You seem to do this
> same decode twice?

You're basically right, but the ehea_h_*() function are by design not supposed
to contain such logic but to simply execute the hcall with the given parameters.
I confess we need a few more lines of code doing it our way but we prefer to
be consistent in this case.


>> +/* tx control flags for swqe */
>> +#define EHEA_SWQE_CRC                    0x8000
>> +#define EHEA_SWQE_IP_CHECKSUM            0x4000
>> +#define EHEA_SWQE_TCP_CHECKSUM           0x2000
>> +#define EHEA_SWQE_TSO                    0x1000
>> +#define EHEA_SWQE_SIGNALLED_COMPLETION   0x0800
>> +#define EHEA_SWQE_VLAN_INSERT            0x0400
>> +#define EHEA_SWQE_IMM_DATA_PRESENT   0x0200
>> +#define EHEA_SWQE_DESCRIPTORS_PRESENT    0x0100
>> +#define EHEA_SWQE_WRAP_CTL_REC           0x0080
>> +#define EHEA_SWQE_WRAP_CTL_FORCE         0x0040
>> +#define EHEA_SWQE_BIND                   0x0020
>> +#define EHEA_SWQE_PURGE                  0x0010
>> +
>> +#define SWQE_HEADER_SIZE 32
>
> This is never used...

Used in ehea_main.c in function ehea_post_nwqe()

>
> Would be nice to document some of the names here.  What are SWQE, RWQE,
> WQE, CQE, IPZ etc?

Agreed. Added comment sections which explains the abbreviations.


>> +#define EHEA_EQE_VALID           EHEA_BMASK_IBM(0, 0)
>> +#define EHEA_EQE_IS_CQE          EHEA_BMASK_IBM(1, 1)
>> +#define EHEA_EQE_IDENTIFIER      EHEA_BMASK_IBM(2, 7)
>> +#define EHEA_EQE_QP_CQ_NUMBER    EHEA_BMASK_IBM(8, 31)
>> +#define EHEA_EQE_QP_TOKEN        EHEA_BMASK_IBM(32, 63)
>> +#define EHEA_EQE_CQ_TOKEN        EHEA_BMASK_IBM(32, 63)
>> +#define EHEA_EQE_KEY             EHEA_BMASK_IBM(32, 63)
>
> 3 the same here?

Yes, it's correct. Those defines are used to operate on different data
sources, so it's possible that the same bits have to be accessed.

>
>> +#define EHEA_EQE_PORT_NUMBER     EHEA_BMASK_IBM(56, 63)
>> +#define EHEA_EQE_EQ_NUMBER       EHEA_BMASK_IBM(48, 63)
>> +#define EHEA_EQE_SM_ID           EHEA_BMASK_IBM(48, 63)
>
> 2 the same here?

ditto

>
>> +#define EHEA_EQE_SM_MECH_NUMBER  EHEA_BMASK_IBM(48, 55)
>> +#define EHEA_EQE_SM_PORT_NUMBER  EHEA_BMASK_IBM(56, 63)
>> +
>> +struct ehea_eqe {
>> +    u64 entry;
>> +};
>
> ehea_ege.. what is that and why a struct if only 1 item?  Comments
> please.

Already answered in separate mail.

>
> In ehea_main.c you use this with a ehea_poll_eq which returns a void *
> Mostly you cast to a (struct ehea_eqe *) but you don't need to.

Agreed. Done.

>> +static inline struct ehea_cqe *ehea_poll_rq1(struct ehea_qp *qp, int *wqe_in
>> +static inline void ehea_inc_rq1(struct ehea_qp *qp)
>> +static inline struct ehea_cqe *ehea_poll_cq(struct ehea_cq *my_cq)
>
> Can we stick all these functions in the .c and put only the prototypes here?

These functions must be inline due to performance considerations and therefore
have to stay in the header file.

>> +/*
>> + *  linux/drivers/net/ehea/ehea_ethtool.c
>> + *
>> + *  eHEA ethernet device driver for IBM eServer System p
>> + *
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
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.      See the
>> + * GNU General Public License for more details.
>> + *
>> + * You should have received a copy of the GNU General Public License
>> + * along with this program; if not, write to the Free Software
>> + * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
>> + */
>> +
>> +static int netdev_nway_reset(struct net_device *dev)
>> +{
>> +    printk("nway reset\n");
>> +    return 0;
>> +}
>> +
>> +static void netdev_get_pauseparam(struct net_device *dev,
>> +                              struct ethtool_pauseparam *pauseparam)
>> +{
>> +    printk("get pauseparam\n");
>> +}
>> +
>> +static int netdev_set_pauseparam(struct net_device *dev,
>> +                             struct ethtool_pauseparam *pauseparam)
>> +{
>> +    printk("set pauseparam\n");
>> +    return 0;
>> +}
>> +
>> +static u32 netdev_get_rx_csum(struct net_device *dev)
>> +{
>> +    printk("set rx_csum\n");
>> +    return 0;
>> +}
>> +
>> +static int netdev_set_rx_csum(struct net_device *dev, u32 value)
>> +{
>> +    printk("set rx_csum\n");
>> +    return 0;
>> +}
>> +
>> +static int netdev_self_test_count(struct net_device *dev)
>> +{
>> +    printk("self test count\n");
>> +    return 0;
>> +}
>> +
>> +static void netdev_self_test(struct net_device *dev, struct ethtool_test *te
> st,
>> +                         u64 *value)
>> +{
>> +    printk("self test\n");
>> +}
>> +
>> +static int netdev_phys_id(struct net_device *dev, u32 value)
>> +{
>> +    printk("physical id\n");
>> +    return 0;
>> +}
>
> These are yet to be done?

Exactly.

>> _______________________________________________
>> Linuxppc-dev mailing list
>> Linuxppc-dev@ozlabs.org
>> https://ozlabs.org/mailman/listinfo/linuxppc-dev
>>
>
> I hope this helps...

It helped a lot! Thank you very much :-)


