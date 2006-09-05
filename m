Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965085AbWIEPJS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965085AbWIEPJS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Sep 2006 11:09:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965087AbWIEPJS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Sep 2006 11:09:18 -0400
Received: from mtagate1.uk.ibm.com ([195.212.29.134]:22846 "EHLO
	mtagate1.uk.ibm.com") by vger.kernel.org with ESMTP id S965085AbWIEPJQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Sep 2006 11:09:16 -0400
Message-ID: <44FD931A.3080107@de.ibm.com>
Date: Tue, 05 Sep 2006 17:09:14 +0200
From: Thomas Klein <osstklei@de.ibm.com>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: Francois Romieu <romieu@fr.zoreil.com>
CC: Jan-Bernd Themann <ossthema@de.ibm.com>, netdev <netdev@vger.kernel.org>,
       Christoph Raisch <raisch@de.ibm.com>,
       Jan-Bernd Themann <themann@de.ibm.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       linux-ppc <linuxppc-dev@ozlabs.org>, Marcus Eder <meder@de.ibm.com>,
       Thomas Klein <tklein@de.ibm.com>
Subject: Re: [2.6.19 PATCH 1/7] ehea: interface to network stack
References: <200609041237.46528.ossthema@de.ibm.com> <20060904201606.GA24386@electric-eye.fr.zoreil.com>
In-Reply-To: <20060904201606.GA24386@electric-eye.fr.zoreil.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Francois,

thanks for your review and your comments. See below our answers.

Regards
Thomas



Francois Romieu wrote:

 >> +    cb2 = kzalloc(H_CB_ALIGNMENT, GFP_KERNEL);
 >> +    if (!cb2) {
 >> +            ehea_error("no mem for cb2");
 >> +            goto kzalloc_failed;
 >
 > It's better when the label tell what it does than where it comes from.
 > If it's numbered too, one can check them without going back and forth.
 >> +    stats->tx_packets = cb2->txucp + cb2->txmcp + cb2->txbcp;
 >> +    stats->multicast = cb2->rxmcp;
 >> +    stats->rx_errors = cb2->rxuerr;
 >> +    stats->rx_bytes = cb2->rxo;
 >> +    stats->tx_bytes = cb2->txo;
 >> +    stats->rx_packets = rx_packets;
 >> +
 >> +hcall_failed:
 >> +        kfree(cb2);
 >
 > Tab was turned into spaces.

Fixed.

 >> +static inline int ehea_refill_rq1(struct ehea_port_res *pr, int index,
 >
 > Avoid inline ?

Inline declaration was removed from this one and several other functions.

 >> +    for (i = 0; i < nr_of_wqes; i++) {
 >> +            if (!skb_arr_rq1[index]) {
 >> +                    skb_arr_rq1[index] = dev_alloc_skb(EHEA_LL_PKT_SIZE);
 >
 > netdev_alloc_skb ?

Agreed & done.

 >
 >> +
 >> +                    if (!skb_arr_rq1[index]) {
 >> +                            ehea_error("no mem for skb/%d wqes filled", i);
 >> +                            ret = -ENOMEM;
 >
 > The caller does not check the returned value.

Agreed. fn returns void now.

 >> +            if (!skb_arr_rq1[i]) {
 >> +                    ehea_error("no mem for skb/%d skbs filled.", i);
 >> +                    ret = -ENOMEM;
 >> +                    goto exit0;
 >
 > s/exit0/out/

Goto target naming was reworked throughout the whole driver and basically
uses the style used by Dave M. and Jeff G. in the Tigon3 driver.

 >> +static inline int ehea_check_cqe(struct ehea_cqe *cqe, int *rq_num)
 >> +{
 >> +    *rq_num = (cqe->type & EHEA_CQE_TYPE_RQ) >> 5;
 >> +    if ((cqe->status & EHEA_CQE_STAT_ERR_MASK) == 0)
 >> +            return 0;
 >> +    if (((cqe->status & EHEA_CQE_STAT_ERR_TCP) != 0)
 >> +        && (cqe->header_length == 0))
 >
 > && on the previous line please.

Changed at all occurences.

 >> +static inline struct sk_buff *get_skb_by_index(struct sk_buff **skb_array,
 >> +                                           int arr_len,
 >> +                                           struct ehea_cqe *cqe)
 >> +{
 >> +    int skb_index = EHEA_BMASK_GET(EHEA_WR_ID_INDEX, cqe->wr_id);
 >> +    struct sk_buff *skb;
 >> +    void *pref;
 >> +    int x;
 >> +
 >> +    x = skb_index + 1;
 >> +    x &= (arr_len - 1);
 >> +
 >> +    pref = (void*)skb_array[x];
 >
 > Useless cast.

Agreed -> removed.

 >> +                            if (unlikely(!skb)) {
 >> +                                    if (netif_msg_rx_err(port))
 >> +                                            ehea_error("LL rq1: skb=NULL");
 >> +                                            skb = dev_alloc_skb(EHEA_LL_PKT_SIZE);
 >
 > Tab/space

Fixed.

 >> +irqreturn_t ehea_qp_aff_irq_handler(int irq, void *param, struct pt_regs * regs)
 >
 > static ?

Agreed.

 >> +int ehea_sense_port_attr(struct ehea_port *port)
 >
 > static ?

No -> used in ehea_ethtool.c

 >> +    } else {
 >> +            if (hret == H_AUTHORITY)
 >> +            {
 >
 > Misplaced curly brace.

Fixed.

 >
 >> +                    ehea_info("Hypervisor denied setting port speed. Either"
 >> +                              " this partition is not authorized to set "
 >> +                              "port speed or another partition has modified"
 >> +                              " port speed first.");
 >> +                    ret = -EPERM;
 >> +            } else
 >> +            {
 >
 > Misplaced curly brace.

Fixed.

 >
 >> +                    ret = -EIO;
 >> +                    ehea_error("Failed setting port speed");
 >> +            }
 >> +    }
 >> +    netif_carrier_on(port->netdev);
 >> +exit0:
 >> +    kfree(cb4);
 >
 > cb4 is NULL. Not wrong per se but I'd rather move the label one line down.

Agreed.

 >> +void ehea_neq_tasklet(unsigned long data)
 >
 > static ?

Agreed.

 >> +irqreturn_t ehea_interrupt_neq(int irq, void *param, struct pt_regs *regs)
 >
 > static ?

Agreed.

 >> +{
 >> +    struct ehea_adapter *adapter = (struct ehea_adapter*)param;
 >
 > Useless cast.

Fixed.

 >> +static int ehea_fill_port_res(struct ehea_port_res *pr)
 >> +{
 >> +    int ret;
 >> +    struct ehea_qp_init_attr *init_attr = &pr->qp->init_attr;
 >> +
 >> +    /* RQ 1 */
 >> +    ret = ehea_init_fill_rq1(pr, init_attr->act_nr_rwqes_rq1
 >> +                                 - init_attr->act_nr_rwqes_rq2
 >> +                                 - init_attr->act_nr_rwqes_rq3 - 1);
 >> +    /* RQ 2 */
 >
 > Useless comment.

Removed.

 >> +                    for (k = 0; k < i; k++) {
 >> +                            u32 ist = port->port_res[k].recv_eq->attr.ist1;
 >> +                            ibmebus_free_irq(NULL, ist, &port->port_res[k]);
 >> +                    }
 >> +                    goto failure;
 >
 > Poor label (and bloaty release practice too: remove k, reuse "i" below
 > and more importantly release the things in allocation-reversed order).

Somehow I don't get your point concerning the usage of 'k'. We need another
iterator as the for loops using 'k' use 'i' as their terminating condition.

 >
 >> +            }
 >> +            if (netif_msg_ifup(port))
 >> +                    ehea_info("irq_handle 0x%X for funct ehea_recv_int %d "
 >> +                              "registered", pr->recv_eq->attr.ist1, i);
 >> +    }
 >> +
 >> +    snprintf(port->int_aff_name, EHEA_IRQ_NAME_SIZE - 1,
 >> +             "%s-aff", dev->name);
 >> +    ret = ibmebus_request_irq(NULL, port->qp_eq->attr.ist1,
 >> +                              ehea_qp_aff_irq_handler,
 >> +                              SA_INTERRUPT, port->int_aff_name, port);
 >> +    if (ret) {
 >> +            ehea_error("failed registering irq for qp_aff_irq_handler:"
 >> +                       " ist=%X", port->qp_eq->attr.ist1);
 >> +            goto failure2;
 >> +    }
 >> +    if (netif_msg_ifup(port))
 >> +            ehea_info("irq_handle 0x%X for function qp_aff_irq_handler "
 >> +                      "registered", port->qp_eq->attr.ist1);
 >> +
 >> +    for (i = 0; i < port->num_def_qps + port->num_add_tx_qps; i++) {
 >> +            pr = &port->port_res[i];
 >> +            snprintf(pr->int_send_name, EHEA_IRQ_NAME_SIZE - 1,
 >> +                     "%s-send%d", dev->name, i);
 >> +            ret = ibmebus_request_irq(NULL, pr->send_eq->attr.ist1,
 >> +                                      ehea_send_irq_handler,
 >> +                                      SA_INTERRUPT, pr->int_send_name,
 >> +                                      pr);
 >> +            if (ret) {
 >> +                    ehea_error("failed registering irq for ehea_send"
 >> +                               " port_res_nr:%d, ist=%X", i,
 >> +                               pr->send_eq->attr.ist1);
 >> +                    for (k = 0; k < i; k++) {
 >> +                            u32 ist = port->port_res[k].send_eq->attr.ist1;
 >> +                            ibmebus_free_irq(NULL, ist, &port->port_res[i]);
 >> +                    }
 >> +                    goto failure3;
 >> +            }
 >> +            if (netif_msg_ifup(port))
 >> +                    ehea_info("irq_handle 0x%X for function ehea_send_int "
 >> +                              "%d registered", pr->send_eq->attr.ist1, i);
 >> +    }
 >> +    return ret;
 >> +failure3:
 >> +    for (i = 0; i < port->num_def_qps; i++)
 >> +            ibmebus_free_irq(NULL, port->port_res[i].recv_eq->attr.ist1,
 >> +                             &port->port_res[i]);
 >
 > Compare with:
 >               u32 ist = port->port_res[k].recv_eq->attr.ist1;
 >               ibmebus_free_irq(NULL, ist, &port->port_res[k]);
 >
 > It was the first loop above. :o/

Agreed, that's slightly prettier.

 >> +    /* send */
 >> +    for (i = 0; i < port->num_def_qps + port->num_add_tx_qps; i++) {
 >> +            ibmebus_free_irq(NULL, port->port_res[i].send_eq->attr.ist1,
 >> +                             &port->port_res[i]);
 >
 > Please add a local 'struct shnortz *foo = port->port_res + i;'

Agreed & done.

 >> +    cb0->port_rc = EHEA_BMASK_SET(PXLY_RC_VALID, 1)
 >> +                 | EHEA_BMASK_SET(PXLY_RC_IP_CHKSUM, 1)
 >> +                 | EHEA_BMASK_SET(PXLY_RC_TCP_UDP_CHKSUM, 1)
 >> +                     | EHEA_BMASK_SET(PXLY_RC_VLAN_XTRACT, 1)
 >
 > Tab/space

Fixed.

 >> +static int ehea_init_port_res(struct ehea_port *port, struct ehea_port_res *pr,
 >> +                          struct port_res_cfg *pr_cfg, int queue_token)
 >> +{
 >> +    struct ehea_adapter *adapter = port->adapter;
 >> +    struct ehea_qp_init_attr *init_attr = NULL;
 >
 > Useless initialization.

init_attr must be initialized as there are goto statements which may
pass the init_attr = kzalloc() statement and jump to ehea_init_port_res_err
where we want to kfree() init_attr without having to care for its state.

 >> +    pr->send_eq = ehea_create_eq(adapter, eq_type, EHEA_MAX_ENTRIES_EQ, 0);
 >> +    if (!pr->send_eq) {
 >> +            ehea_error("create_eq failed (send_eq)");
 >> +            ret = -EIO;
 >> +            goto ehea_init_port_res_err;
 >
 > Should factor 'ret = -EIO' before the sequence.

Ok, done.

 >> +    if (!ret) {
 >> +            ehea_destroy_cq(pr->send_cq);
 >> +            ehea_destroy_cq(pr->recv_cq);
 >> +            ehea_destroy_eq(pr->send_eq);
 >> +            ehea_destroy_eq(pr->recv_eq);
 >> +
 >> +            for (i = 0; i < pr->rq1_skba.len; i++)
 >> +                    if (pr->rq1_skba.arr[i])
 >> +                            dev_kfree_skb(pr->rq1_skba.arr[i]);
 >> +
 >> +            for (i = 0; i < pr->rq2_skba.len; i++)
 >> +                    if (pr->rq2_skba.arr[i])
 >> +                            dev_kfree_skb(pr->rq2_skba.arr[i]);
 >> +
 >> +            for (i = 0; i < pr->rq3_skba.len; i++)
 >> +                    if (pr->rq3_skba.arr[i])
 >> +                            dev_kfree_skb(pr->rq3_skba.arr[i]);
 >> +
 >> +            for (i = 0; i < pr->sq_skba.len; i++)
 >> +                    if (pr->sq_skba.arr[i])
 >> +                            dev_kfree_skb(pr->sq_skba.arr[i]);
 >
 > Feels like a 0..4 loop is missing above.

The send queue and the receive queues are not related to eachother
in any way. Thus using a joint array for them isn't appropriate.

 >> +static int ehea_start_xmit(struct sk_buff *skb, struct net_device *dev)
 >> +{
 >> +    struct ehea_port *port = netdev_priv(dev);
 >> +    struct ehea_port_res *pr;
 >> +    struct ehea_swqe *swqe;
 >> +    unsigned long flags;
 >> +    u32 lkey;
 >> +    int swqe_index;
 >> +
 >> +    pr = &port->port_res[0];
 >
 > Initialization and declaration can happen at the same time.

Agreed.

 >> +    if (unlikely(atomic_read(&pr->swqe_avail) <= 1)) {
 >> +            spin_lock_irqsave(&pr->netif_queue, flags);
 >> +            if (unlikely(atomic_read(&pr->swqe_avail) <= 1)) {
 >> +                    netif_stop_queue(dev);
 >> +                    pr->queue_stopped = 1;
 >> +                    spin_unlock_irqrestore(&pr->netif_queue, flags);
 >> +                    return NETDEV_TX_BUSY;
 >
 > 1 - this is considered a severe bug. You should stop queueing before it
 >     happens.
 > 2 - don't mix spinlocked sections and stealth return.

Fixed.

 >> +port_res_setup_failed:
 >> +    for(k = 0; k < i; k++) {
 >> +            ehea_clean_port_res(port, &port->port_res[k]);
 >
 > Useless k ?

No, i is used as terminating condition and may not be reused as iterator
in this loop.

 >> +int ehea_up(struct net_device *dev)
 >> +int ehea_open(struct net_device *dev)
 >
 > static

Agreed.

 >> +{
 >> +    int ret;
 >> +    struct ehea_port *port = netdev_priv(dev);
 >> +
 >> +    down(&port->port_lock);
 >> +
 >> +    if (netif_msg_ifup(port))
 >> +            ehea_info("enabling port %s", dev->name);
 >> +        ret = ehea_up(dev);
 >
 > Broken indent.

Fixed.

 >> +    dev->open = ehea_open;
 >> +    dev->poll = ehea_poll;
 >> +    dev->weight = 64;
 >> +    dev->stop = ehea_stop;
 >> +    dev->hard_start_xmit = ehea_start_xmit;
 >> +    dev->get_stats = ehea_get_stats;
 >> +    dev->set_multicast_list = ehea_set_multicast_list;
 >> +    dev->set_mac_address = ehea_set_mac_addr;
 >> +    dev->change_mtu = ehea_change_mtu;
 >> +    dev->vlan_rx_register = ehea_vlan_rx_register;
 >> +    dev->vlan_rx_add_vid = ehea_vlan_rx_add_vid;
 >> +    dev->vlan_rx_kill_vid = ehea_vlan_rx_kill_vid;
 >> +    dev->features = NETIF_F_SG | NETIF_F_FRAGLIST | NETIF_F_TSO
 >> +                  | NETIF_F_HIGHDMA | NETIF_F_HW_CSUM | NETIF_F_HW_VLAN_TX
 >> +                  | NETIF_F_HW_VLAN_RX | NETIF_F_HW_VLAN_FILTER
 >> +                  | NETIF_F_LLTX;
 >> +    dev->tx_timeout = &ehea_tx_watchdog;
 >> +    dev->watchdog_timeo = EHEA_WATCH_DOG_TIMEOUT;
 >> +
 >> +    INIT_WORK(&port->reset_task,
 >> +              (void (*)(void *)) ehea_reset_port, dev);
 >
 > Why not modify ehea_reset_port ?

Done.

 >> +    ehea_set_ethtool_ops(dev);
 >
 > This function does not appear in the current patch.

It appears in [2.6.19 PATCH 4/7] ehea: ethtool interface

 >> +int check_module_parm(void)
 >
 > static

Agreed.

 >> +    if ((rq1_entries < EHEA_MIN_ENTRIES_QP)
 >> +        || (rq1_entries > EHEA_MAX_ENTRIES_RQ1)) {
 >
 > || is misplaced.

Changed at all occurences.

 >> +static struct of_device_id ehea_device_table[] = {
 >> +    {
 >> +     .name = "lhea",
 >> +     .compatible = "IBM,lhea",
 >> +     },
 >
 > Indent seems strange.

Fixed.

 >> +    printk("IBM eHEA ethernet device driver (Release %s)\n", DRV_VERSION);
 >
 > Missing KERN_XYZ

KERN_INFO set.


