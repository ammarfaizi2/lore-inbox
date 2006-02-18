Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751206AbWBRMqb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751206AbWBRMqb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Feb 2006 07:46:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751210AbWBRMqb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Feb 2006 07:46:31 -0500
Received: from schihei.net ([81.169.184.117]:38159 "EHLO schihei.org")
	by vger.kernel.org with ESMTP id S1751206AbWBRMqa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Feb 2006 07:46:30 -0500
In-Reply-To: <20060218005712.13620.82908.stgit@localhost.localdomain>
References: <20060218005532.13620.79663.stgit@localhost.localdomain> <20060218005712.13620.82908.stgit@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <ADDBC190-7388-4904-9ECB-489F1D199AB1@schihei.de>
Cc: linux-kernel@vger.kernel.org, linuxppc64-dev@ozlabs.org,
       openib-general@openib.org, SCHICKHJ@de.ibm.com, RAISCH@de.ibm.com,
       HNGUYEN@de.ibm.com, MEDER@de.ibm.com
Content-Transfer-Encoding: 7bit
From: Heiko J Schick <info@schihei.de>
Subject: Re: [openib-general] [PATCH 04/22] OF adapter probing
Date: Sat, 18 Feb 2006 13:46:10 +0100
To: Roland Dreier <rolandd@cisco.com>
X-Mailer: Apple Mail (2.746.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Roland,

sorry, this file is not used anymore. The functions

	int hipz_count_adapters(void);
	int hipz_probe_adapters(char **adapter_list);
	u64 hipz_get_adapter_handle(char *adapter);

nowadays handled by the IBMEBUS [1] bus device driver.

[1]: http://www.kernel.org/git/?p=linux/kernel/git/torvalds/ 
linux-2.6.git;a=commit;h=d7a301033f1990188f65abf4fe8e5b90ef0e3888

Regards,
	Heiko

On Feb 18, 2006, at 1:57 AM, Roland Dreier wrote:

> From: Roland Dreier <rolandd@cisco.com>
>
> hipz_probe_adapters() looks a little funny -- it seems to bail out
> of all the remaining adapters if one of them isn't quite right.
> ---
>
>  drivers/infiniband/hw/ehca/hcp_sense.c |  144 +++++++++++++++++++++ 
> +++++++++++
>  drivers/infiniband/hw/ehca/hcp_sense.h |  136 +++++++++++++++++++++ 
> +++++++++
>  2 files changed, 280 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/infiniband/hw/ehca/hcp_sense.c b/drivers/ 
> infiniband/hw/ehca/hcp_sense.c
> new file mode 100644
> index 0000000..83fa4a3
> --- /dev/null
> +++ b/drivers/infiniband/hw/ehca/hcp_sense.c
> @@ -0,0 +1,144 @@
> +/*
> + *  IBM eServer eHCA Infiniband device driver for Linux on POWER
> + *
> + *  ehca detection and query code for POWER
> + *
> + *  Authors: Heiko J Schick <schickhj@de.ibm.com>
> + *
> + *  Copyright (c) 2005 IBM Corporation
> + *
> + *  All rights reserved.
> + *
> + *  This source code is distributed under a dual license of GPL  
> v2.0 and OpenIB
> + *  BSD.
> + *
> + * OpenIB BSD License
> + *
> + * Redistribution and use in source and binary forms, with or without
> + * modification, are permitted provided that the following  
> conditions are met:
> + *
> + * Redistributions of source code must retain the above copyright  
> notice, this
> + * list of conditions and the following disclaimer.
> + *
> + * Redistributions in binary form must reproduce the above  
> copyright notice,
> + * this list of conditions and the following disclaimer in the  
> documentation
> + * and/or other materials
> + * provided with the distribution.
> + *
> + * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND  
> CONTRIBUTORS "AS IS"
> + * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT  
> LIMITED TO, THE
> + * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A  
> PARTICULAR PURPOSE
> + * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR  
> CONTRIBUTORS BE
> + * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,  
> EXEMPLARY, OR
> + * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,  
> PROCUREMENT OF
> + * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR
> + * BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF  
> LIABILITY, WHETHER
> + * IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR  
> OTHERWISE)
> + * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF  
> ADVISED OF THE
> + * POSSIBILITY OF SUCH DAMAGE.
> + *
> + *  $Id: hcp_sense.c,v 1.10 2006/02/06 10:17:34 schickhj Exp $
> + */
> +
> +#define DEB_PREFIX "snse"
> +
> +#include "ehca_kernel.h"
> +#include "ehca_tools.h"
> +
> +int hipz_count_adapters(void)
> +{
> +	int num = 0;
> +	struct device_node *dn = NULL;
> +
> +	EDEB_EN(7, "");
> +
> +	while ((dn = of_find_node_by_name(dn, "lhca"))) {
> +		num++;
> +	}
> +
> +	of_node_put(dn);
> +
> +	if (num == 0) {
> +		EDEB_ERR(4, "No lhca node name was found in the"
> +			 " Open Firmware device tree.");
> +		return -ENODEV;
> +	}
> +
> +	EDEB(6, " ... found %x adapter(s)", num);
> +
> +	EDEB_EX(7, "num=%x", num);
> +
> +	return num;
> +}
> +
> +int hipz_probe_adapters(char **adapter_list)
> +{
> +	int ret = 0;
> +	int num = 0;
> +	struct device_node *dn = NULL;
> +	char *loc;
> +
> +	EDEB_EN(7, "adapter_list=%p", adapter_list);
> +
> +	while ((dn = of_find_node_by_name(dn, "lhca"))) {
> +		loc = get_property(dn, "ibm,loc-code", NULL);
> +		if (loc == NULL) {
> +			EDEB_ERR(4, "No ibm,loc-code property for"
> +				 " lhca Open Firmware device tree node.");
> +			ret = -ENODEV;
> +			goto probe_adapters0;
> +		}
> +
> +		adapter_list[num] = loc;
> +		EDEB(6, " ... found adapter[%x] with loc-code: %s", num, loc);
> +		num++;
> +	}
> +
> +      probe_adapters0:
> +	of_node_put(dn);
> +
> +	EDEB_EX(7, "ret=%x", ret);
> +
> +	return ret;
> +}
> +
> +u64 hipz_get_adapter_handle(char *adapter)
> +{
> +	struct device_node *dn = NULL;
> +	char *loc;
> +	u64 *u64data = NULL;
> +	u64 ret = 0;
> +
> +	EDEB_EN(7, "adapter=%p", adapter);
> +
> +	while ((dn = of_find_node_by_name(dn, "lhca"))) {
> +		loc = get_property(dn, "ibm,loc-code", NULL);
> +		if (loc == NULL) {
> +			EDEB_ERR(4, "No ibm,loc-code property for"
> +				 " lhca Open Firmware device tree node.");
> +			goto get_adapter_handle0;
> +		}
> +
> +		if (strcmp(loc, adapter) == 0) {
> +			u64data =
> +			    (u64 *) get_property(dn, "ibm,hca-handle", NULL);
> +			break;
> +		}
> +	}
> +
> +	if (u64data == NULL) {
> +		EDEB_ERR(4, "No ibm,hca-handle property for"
> +			 " lhca Open Firmware device tree node with"
> +			 " ibm,loc-code: %s.", adapter);
> +		goto get_adapter_handle0;
> +	}
> +
> +	ret = *u64data;
> +
> +      get_adapter_handle0:
> +	of_node_put(dn);
> +
> +	EDEB_EX(7, "ret=%lx",ret);
> +
> +	return ret;
> +}
> diff --git a/drivers/infiniband/hw/ehca/hcp_sense.h b/drivers/ 
> infiniband/hw/ehca/hcp_sense.h
> new file mode 100644
> index 0000000..a49040b
> --- /dev/null
> +++ b/drivers/infiniband/hw/ehca/hcp_sense.h
> @@ -0,0 +1,136 @@
> +/*
> + *  IBM eServer eHCA Infiniband device driver for Linux on POWER
> + *
> + *  ehca detection and query code for POWER
> + *
> + *  Authors: Heiko J Schick <schickhj@de.ibm.com>
> + *
> + *  Copyright (c) 2005 IBM Corporation
> + *
> + *  All rights reserved.
> + *
> + *  This source code is distributed under a dual license of GPL  
> v2.0 and OpenIB
> + *  BSD.
> + *
> + * OpenIB BSD License
> + *
> + * Redistribution and use in source and binary forms, with or without
> + * modification, are permitted provided that the following  
> conditions are met:
> + *
> + * Redistributions of source code must retain the above copyright  
> notice, this
> + * list of conditions and the following disclaimer.
> + *
> + * Redistributions in binary form must reproduce the above  
> copyright notice,
> + * this list of conditions and the following disclaimer in the  
> documentation
> + * and/or other materials
> + * provided with the distribution.
> + *
> + * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND  
> CONTRIBUTORS "AS IS"
> + * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT  
> LIMITED TO, THE
> + * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A  
> PARTICULAR PURPOSE
> + * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR  
> CONTRIBUTORS BE
> + * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,  
> EXEMPLARY, OR
> + * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,  
> PROCUREMENT OF
> + * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR
> + * BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF  
> LIABILITY, WHETHER
> + * IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR  
> OTHERWISE)
> + * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF  
> ADVISED OF THE
> + * POSSIBILITY OF SUCH DAMAGE.
> + *
> + *  $Id: hcp_sense.h,v 1.11 2006/02/06 10:17:34 schickhj Exp $
> + */
> +
> +#ifndef HCP_SENSE_H
> +#define HCP_SENSE_H
> +
> +int hipz_count_adapters(void);
> +int hipz_probe_adapters(char **adapter_list);
> +u64 hipz_get_adapter_handle(char *adapter);
> +
> +/* query hca response block */
> +struct query_hca_rblock {
> +	u32 cur_reliable_dg;
> +	u32 cur_qp;
> +	u32 cur_cq;
> +	u32 cur_eq;
> +	u32 cur_mr;
> +	u32 cur_mw;
> +	u32 cur_ee_context;
> +	u32 cur_mcast_grp;
> +	u32 cur_qp_attached_mcast_grp;
> +	u32 reserved1;
> +	u32 cur_ipv6_qp;
> +	u32 cur_eth_qp;
> +	u32 cur_hp_mr;
> +	u32 reserved2[3];
> +	u32 max_rd_domain;
> +	u32 max_qp;
> +	u32 max_cq;
> +	u32 max_eq;
> +	u32 max_mr;
> +	u32 max_hp_mr;
> +	u32 max_mw;
> +	u32 max_mrwpte;
> +	u32 max_special_mrwpte;
> +	u32 max_rd_ee_context;
> +	u32 max_mcast_grp;
> +	u32 max_qps_attached_all_mcast_grp;
> +	u32 max_qps_attached_mcast_grp;
> +	u32 max_raw_ipv6_qp;
> +	u32 max_raw_ethy_qp;
> +	u32 internal_clock_frequency;
> +	u32 max_pd;
> +	u32 max_ah;
> +	u32 max_cqe;
> +	u32 max_wqes_wq;
> +	u32 max_partitions;
> +	u32 max_rr_ee_context;
> +	u32 max_rr_qp;
> +	u32 max_rr_hca;
> +	u32 max_act_wqs_ee_context;
> +	u32 max_act_wqs_qp;
> +	u32 max_sge;
> +	u32 max_sge_rd;
> +	u32 memory_page_size_supported;
> +	u64 max_mr_size;
> +	u32 local_ca_ack_delay;
> +	u32 num_ports;
> +	u32 vendor_id;
> +	u32 vendor_part_id;
> +	u32 hw_ver;
> +	u64 node_guid;
> +	u64 hca_cap_indicators;
> +	u32 data_counter_register_size;
> +	u32 max_shared_rq;
> +	u32 max_isns_eq;
> +	u32 max_neq;
> +} __attribute__ ((packed));
> +
> +/* query port response block */
> +struct query_port_rblock {
> +	u32 state;
> +	u32 bad_pkey_cntr;
> +	u32 lmc;
> +	u32 lid;
> +	u32 subnet_timeout;
> +	u32 qkey_viol_cntr;
> +	u32 sm_sl;
> +	u32 sm_lid;
> +	u32 capability_mask;
> +	u32 init_type_reply;
> +	u32 pkey_tbl_len;
> +	u32 gid_tbl_len;
> +	u64 gid_prefix;
> +	u32 port_nr;
> +	u16 pkey_entries[16];
> +	u8  reserved1[32];
> +	u32 trent_size;
> +	u32 trbuf_size;
> +	u64 max_msg_sz;
> +	u32 max_mtu;
> +	u32 vl_cap;
> +	u8  reserved2[1900];
> +	u64 guid_entries[255];
> +} __attribute__ ((packed));
> +
> +#endif
> _______________________________________________
> openib-general mailing list
> openib-general@openib.org
> http://openib.org/mailman/listinfo/openib-general
>
> To unsubscribe, please visit http://openib.org/mailman/listinfo/ 
> openib-general
>

