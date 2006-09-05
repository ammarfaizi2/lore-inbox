Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030230AbWIETAY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030230AbWIETAY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Sep 2006 15:00:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030228AbWIETAX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Sep 2006 15:00:23 -0400
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:4263 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S1030227AbWIETAV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Sep 2006 15:00:21 -0400
Date: Tue, 5 Sep 2006 20:58:32 +0200
From: Francois Romieu <romieu@fr.zoreil.com>
To: Thomas Klein <osstklei@de.ibm.com>
Cc: Jan-Bernd Themann <ossthema@de.ibm.com>, netdev <netdev@vger.kernel.org>,
       Christoph Raisch <raisch@de.ibm.com>,
       Jan-Bernd Themann <themann@de.ibm.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       linux-ppc <linuxppc-dev@ozlabs.org>, Marcus Eder <meder@de.ibm.com>
Subject: Re: [2.6.19 PATCH 1/7] ehea: interface to network stack
Message-ID: <20060905185832.GA15311@electric-eye.fr.zoreil.com>
References: <200609041237.46528.ossthema@de.ibm.com> <20060904201606.GA24386@electric-eye.fr.zoreil.com> <44FD931A.3080107@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44FD931A.3080107@de.ibm.com>
User-Agent: Mutt/1.4.2.1i
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Klein <osstklei@de.ibm.com> :
[...]
> Somehow I don't get your point concerning the usage of 'k'. We need another
> iterator as the for loops using 'k' use 'i' as their terminating condition.

Something like the code below perhaps (with more local variables maybe):

static int ehea_reg_interrupts(struct net_device *dev)
{
	struct ehea_port *port = netdev_priv(dev);
	struct ehea_port_res *pr;
	int i, ret;

	for (i = 0; i < port->num_def_qps; i++) {
		pr = &port->port_res[i];
		snprintf(pr->int_recv_name, EHEA_IRQ_NAME_SIZE - 1
			 , "%s-recv%d", dev->name, i);
		ret = ibmebus_request_irq(NULL, pr->recv_eq->attr.ist1,
					  ehea_recv_irq_handler, SA_INTERRUPT,
					  pr->int_recv_name, pr);
		if (ret) {
			ehea_error("failed registering irq for ehea_recv_int:"
				   "port_res_nr:%d, ist=%X", i,
				   pr->recv_eq->attr.ist1);
			goto err_free_irq_recv_eq_0;
		}
		if (netif_msg_ifup(port))
			ehea_info("irq_handle 0x%X for funct ehea_recv_int %d "
				  "registered", pr->recv_eq->attr.ist1, i);
	}

	snprintf(port->int_aff_name, EHEA_IRQ_NAME_SIZE - 1,
		 "%s-aff", dev->name);
	ret = ibmebus_request_irq(NULL, port->qp_eq->attr.ist1,
				  ehea_qp_aff_irq_handler,
				  SA_INTERRUPT, port->int_aff_name, port);
	if (ret) {
		ehea_error("failed registering irq for qp_aff_irq_handler:"
			   " ist=%X", port->qp_eq->attr.ist1);
		goto err_free_irq_recv_eq_0;
	}
	if (netif_msg_ifup(port))
		ehea_info("irq_handle 0x%X for function qp_aff_irq_handler "
			  "registered", port->qp_eq->attr.ist1);

	for (i = 0; i < port->num_def_qps + port->num_add_tx_qps; i++) {
		pr = &port->port_res[i];
		snprintf(pr->int_send_name, EHEA_IRQ_NAME_SIZE - 1,
			 "%s-send%d", dev->name, i);
		ret = ibmebus_request_irq(NULL, pr->send_eq->attr.ist1,
					  ehea_send_irq_handler, SA_INTERRUPT,
					  pr->int_send_name, pr);
		if (ret) {
			ehea_error("failed registering irq for ehea_send"
				   " port_res_nr:%d, ist=%X", i,
				   pr->send_eq->attr.ist1);
			goto err_free_irq_send_eq_1;
		}
		if (netif_msg_ifup(port))
			ehea_info("irq_handle 0x%X for function ehea_send_int "
				  "%d registered", pr->send_eq->attr.ist1, i);
	}
out:
	return ret;

err_free_irq_send_eq_1:
	// Post-dec works with unsigned int too.
	while (i-- > 0) {
		u32 ist = port->port_res[i].send_eq->attr.ist1;
		ibmebus_free_irq(NULL, ist, &port->port_res[i]);
	}
	ibmebus_free_irq(NULL, port->qp_eq->attr.ist1, port);
	i = port->num_def_qps;
err_free_irq_recv_eq_0:
	while (i-- > 0) {
		u32 ist = port->port_res[i].recv_eq->attr.ist1;
		ibmebus_free_irq(NULL, ist, &port->port_res[k]);
	}
	goto out;
}
