Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965085AbWHUMqE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965085AbWHUMqE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Aug 2006 08:46:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965092AbWHUMqD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Aug 2006 08:46:03 -0400
Received: from mailgw.voltaire.com ([193.47.165.252]:39808 "EHLO
	mailgw.voltaire.com") by vger.kernel.org with ESMTP id S965088AbWHUMqA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Aug 2006 08:46:00 -0400
Subject: Re: [openib-general] [PATCH 08/13] IB/ehca: qp
From: Hal Rosenstock <halr@voltaire.com>
To: Roland Dreier <rolandd@cisco.com>
Cc: openib-general@openib.org, linux-kernel@vger.kernel.org,
       linuxppc-dev@ozlabs.org, Christoph Raisch <RAISCH@de.ibm.com>,
       HNGUYEN@de.ibm.com, MEDER@de.ibm.com
In-Reply-To: <20068171311.7Z4EtLP0ZYtya78R@cisco.com>
References: <20068171311.7Z4EtLP0ZYtya78R@cisco.com>
Content-Type: text/plain
Organization: 
Message-Id: <1156164265.9855.196633.camel@hal.voltaire.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 21 Aug 2006 08:44:53 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-08-17 at 16:11, Roland Dreier wrote:

[snip...]

> diff --git a/drivers/infiniband/hw/ehca/ehca_sqp.c b/drivers/infiniband/hw/ehca/ehca_sqp.c
> new file mode 100644
> index 0000000..d2c5552
> --- /dev/null
> +++ b/drivers/infiniband/hw/ehca/ehca_sqp.c
> @@ -0,0 +1,123 @@
> +/*
> + *  IBM eServer eHCA Infiniband device driver for Linux on POWER
> + *
> + *  SQP functions
> + *
> + *  Authors: Khadija Souissi <souissi@de.ibm.com>
> + *           Heiko J Schick <schickhj@de.ibm.com>

[snip...]

> +
> +extern int ehca_create_aqp1(struct ehca_shca *shca, struct ehca_sport *sport);
> +extern int ehca_destroy_aqp1(struct ehca_sport *sport);
> +
> +extern int ehca_port_act_time;
> +
> +/**
> + * ehca_define_sqp - Defines special queue pair 1 (GSI QP). When special queue
> + * pair is created successfully, the corresponding port gets active.
> + *
> + * Define Special Queue pair 0 (SMI QP) is still not supported.
> + *
> + * @qp_init_attr: Queue pair init attributes with port and queue pair type
> + */
> +
> +u64 ehca_define_sqp(struct ehca_shca *shca,
> +		    struct ehca_qp *ehca_qp,
> +		    struct ib_qp_init_attr *qp_init_attr)
> +{
> +
> +	u32 pma_qp_nr = 0;
> +	u32 bma_qp_nr = 0;
> +	u64 ret = H_SUCCESS;
> +	u8 port = qp_init_attr->port_num;
> +	int counter = 0;
> +
> +	EDEB_EN(7, "port=%x qp_type=%x",
> +		port, qp_init_attr->qp_type);
> +
> +	shca->sport[port - 1].port_state = IB_PORT_DOWN;
> +
> +	switch (qp_init_attr->qp_type) {
> +	case IB_QPT_SMI:
> +		/* function not supported yet */
> +		break;
> +	case IB_QPT_GSI:
> +		ret = hipz_h_define_aqp1(shca->ipz_hca_handle,
> +					 ehca_qp->ipz_qp_handle,
> +					 ehca_qp->galpas.kernel,
> +					 (u32) qp_init_attr->port_num,
> +					 &pma_qp_nr, &bma_qp_nr);
> +
> +		if (ret != H_SUCCESS) {
> +			EDEB_ERR(4, "Can't define AQP1 for port %x. rc=%lx",
> +				    port, ret);
> +			goto ehca_define_aqp1;
> +		}
> +		break;
> +	default:
> +		ret = H_PARAMETER;
> +		goto ehca_define_aqp1;
> +	}
> +
> +	while ((shca->sport[port - 1].port_state != IB_PORT_ACTIVE) &&
> +	       (counter < ehca_port_act_time)) {
> +		EDEB(6, "... wait until port %x is active",
> +			port);
> +		msleep_interruptible(1000);
> +		counter++;
> +	}
> +
> +	if (counter == ehca_port_act_time) {
> +		EDEB_ERR(4, "Port %x is not active.", port);
> +		ret = H_HARDWARE;
> +	}
> +
> +ehca_define_aqp1:
> +	EDEB_EX(7, "ret=%lx", ret);
> +
> +	return ret;
> +}

I, for one, was hoping that the timer based transition to active for QP1
would have been resolved before being submitted. Any idea on the plan to
resolve this ?

-- Hal



