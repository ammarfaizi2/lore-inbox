Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750846AbWIFNgI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750846AbWIFNgI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Sep 2006 09:36:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750894AbWIFNgI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Sep 2006 09:36:08 -0400
Received: from mtagate5.de.ibm.com ([195.212.29.154]:12499 "EHLO
	mtagate5.de.ibm.com") by vger.kernel.org with ESMTP
	id S1750846AbWIFNgD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Sep 2006 09:36:03 -0400
From: Jan-Bernd Themann <ossthema@de.ibm.com>
To: Francois Romieu <romieu@fr.zoreil.com>
Subject: Re: [2.6.19 PATCH 1/7] ehea: interface to network stack
Date: Wed, 6 Sep 2006 14:53:38 +0200
User-Agent: KMail/1.8.2
Cc: Thomas Klein <osstklei@de.ibm.com>, netdev <netdev@vger.kernel.org>,
       Christoph Raisch <raisch@de.ibm.com>,
       Jan-Bernd Themann <themann@de.ibm.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       linux-ppc <linuxppc-dev@ozlabs.org>, Marcus Eder <meder@de.ibm.com>
References: <200609041237.46528.ossthema@de.ibm.com> <44FD931A.3080107@de.ibm.com> <20060905185832.GA15311@electric-eye.fr.zoreil.com>
In-Reply-To: <20060905185832.GA15311@electric-eye.fr.zoreil.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609061453.38619.ossthema@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

ok, I admit this solution looks a bit nicer. We changed it in a similar way.

Jan-Bernd

On Tuesday 05 September 2006 20:58, Francois Romieu wrote:
> Thomas Klein <osstklei@de.ibm.com> :
> [...]
> > Somehow I don't get your point concerning the usage of 'k'. We need another
> > iterator as the for loops using 'k' use 'i' as their terminating condition.
> 
> Something like the code below perhaps (with more local variables maybe):
> 
> static int ehea_reg_interrupts(struct net_device *dev)
> {
> 	struct ehea_port *port = netdev_priv(dev);
> 	struct ehea_port_res *pr;
> 	int i, ret;
> 
> 	for (i = 0; i < port->num_def_qps; i++) {
> 		pr = &port->port_res[i];
> 		snprintf(pr->int_recv_name, EHEA_IRQ_NAME_SIZE - 1
> 			 , "%s-recv%d", dev->name, i);
> 		ret = ibmebus_request_irq(NULL, pr->recv_eq->attr.ist1,
> 					  ehea_recv_irq_handler, SA_INTERRUPT,
> 					  pr->int_recv_name, pr);
> 		if (ret) {
> 			ehea_error("failed registering irq for ehea_recv_int:"
> 				   "port_res_nr:%d, ist=%X", i,
> 				   pr->recv_eq->attr.ist1);
> 			goto err_free_irq_recv_eq_0;
> 		}
> 		if (netif_msg_ifup(port))
> 			ehea_info("irq_handle 0x%X for funct ehea_recv_int %d "
> 				  "registered", pr->recv_eq->attr.ist1, i);
> 	}
> 
> 	snprintf(port->int_aff_name, EHEA_IRQ_NAME_SIZE - 1,
> 		 "%s-aff", dev->name);
> 	ret = ibmebus_request_irq(NULL, port->qp_eq->attr.ist1,
> 				  ehea_qp_aff_irq_handler,
> 				  SA_INTERRUPT, port->int_aff_name, port);
> 	if (ret) {
> 		ehea_error("failed registering irq for qp_aff_irq_handler:"
> 			   " ist=%X", port->qp_eq->attr.ist1);
> 		goto err_free_irq_recv_eq_0;
> 	}
> 	if (netif_msg_ifup(port))
> 		ehea_info("irq_handle 0x%X for function qp_aff_irq_handler "
> 			  "registered", port->qp_eq->attr.ist1);
> 
> 	for (i = 0; i < port->num_def_qps + port->num_add_tx_qps; i++) {
> 		pr = &port->port_res[i];
> 		snprintf(pr->int_send_name, EHEA_IRQ_NAME_SIZE - 1,
> 			 "%s-send%d", dev->name, i);
> 		ret = ibmebus_request_irq(NULL, pr->send_eq->attr.ist1,
> 					  ehea_send_irq_handler, SA_INTERRUPT,
> 					  pr->int_send_name, pr);
> 		if (ret) {
> 			ehea_error("failed registering irq for ehea_send"
> 				   " port_res_nr:%d, ist=%X", i,
> 				   pr->send_eq->attr.ist1);
> 			goto err_free_irq_send_eq_1;
> 		}
> 		if (netif_msg_ifup(port))
> 			ehea_info("irq_handle 0x%X for function ehea_send_int "
> 				  "%d registered", pr->send_eq->attr.ist1, i);
> 	}
> out:
> 	return ret;
> 
> err_free_irq_send_eq_1:
> 	// Post-dec works with unsigned int too.
> 	while (i-- > 0) {
> 		u32 ist = port->port_res[i].send_eq->attr.ist1;
> 		ibmebus_free_irq(NULL, ist, &port->port_res[i]);
> 	}
> 	ibmebus_free_irq(NULL, port->qp_eq->attr.ist1, port);
> 	i = port->num_def_qps;
> err_free_irq_recv_eq_0:
> 	while (i-- > 0) {
> 		u32 ist = port->port_res[i].recv_eq->attr.ist1;
> 		ibmebus_free_irq(NULL, ist, &port->port_res[k]);
> 	}
> 	goto out;
> }
> 
