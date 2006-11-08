Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161191AbWKHQbv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161191AbWKHQbv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 11:31:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161196AbWKHQbv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 11:31:51 -0500
Received: from rrcs-24-153-218-104.sw.biz.rr.com ([24.153.218.104]:10144 "EHLO
	smtp.opengridcomputing.com") by vger.kernel.org with ESMTP
	id S1161191AbWKHQbu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 11:31:50 -0500
Subject: Re: infiniband/hw/amso1100/c2_provider.c: possible NULL dereference
From: Steve WIse <swise@opengridcomputing.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: Tom Tucker <tom@opengridcomputing.com>, openib-general@openib.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <20061108162832.GB4729@stusta.de>
References: <20061108162832.GB4729@stusta.de>
Content-Type: text/plain
Date: Wed, 08 Nov 2006 08:31:47 -0800
Message-Id: <1163003508.4142.0.camel@linux-q667.site>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


yep.  We'll fix this up asap...


Thanks,


Steve.


On Wed, 2006-11-08 at 17:28 +0100, Adrian Bunk wrote:
> The Coverity checker noted the following in 
> drivers/infiniband/hw/amso1100/c2_provider.c:
> 
> <--  snip  -->
> 
> ...
> int c2_register_device(struct c2_dev *dev)
> {
>         int ret;
>         int i;
> 
>         /* Register pseudo network device */
>         dev->pseudo_netdev = c2_pseudo_netdev_init(dev);
>         if (dev->pseudo_netdev) {
>                 ret = register_netdev(dev->pseudo_netdev);
>                 if (ret) {
>                         printk(KERN_ERR PFX
>                                 "Unable to register netdev, ret = %d\n", ret);
>                         free_netdev(dev->pseudo_netdev);
>                         return ret;
>                 }
>         }
> 
>         pr_debug("%s:%u\n", __FUNCTION__, __LINE__);
>         strlcpy(dev->ibdev.name, "amso%d", IB_DEVICE_NAME_MAX);
>         dev->ibdev.owner = THIS_MODULE;
>         dev->ibdev.uverbs_cmd_mask =
>             (1ull << IB_USER_VERBS_CMD_GET_CONTEXT) |
>             (1ull << IB_USER_VERBS_CMD_QUERY_DEVICE) |
>             (1ull << IB_USER_VERBS_CMD_QUERY_PORT) |
>             (1ull << IB_USER_VERBS_CMD_ALLOC_PD) |
>             (1ull << IB_USER_VERBS_CMD_DEALLOC_PD) |
>             (1ull << IB_USER_VERBS_CMD_REG_MR) |
>             (1ull << IB_USER_VERBS_CMD_DEREG_MR) |
>             (1ull << IB_USER_VERBS_CMD_CREATE_COMP_CHANNEL) |
>             (1ull << IB_USER_VERBS_CMD_CREATE_CQ) |
>             (1ull << IB_USER_VERBS_CMD_DESTROY_CQ) |
>             (1ull << IB_USER_VERBS_CMD_REQ_NOTIFY_CQ) |
>             (1ull << IB_USER_VERBS_CMD_CREATE_QP) |
>             (1ull << IB_USER_VERBS_CMD_MODIFY_QP) |
>             (1ull << IB_USER_VERBS_CMD_POLL_CQ) |
>             (1ull << IB_USER_VERBS_CMD_DESTROY_QP) |
>             (1ull << IB_USER_VERBS_CMD_POST_SEND) |
>             (1ull << IB_USER_VERBS_CMD_POST_RECV);
> 
>         dev->ibdev.node_type = RDMA_NODE_RNIC;
>         memset(&dev->ibdev.node_guid, 0, sizeof(dev->ibdev.node_guid));
>         memcpy(&dev->ibdev.node_guid, dev->pseudo_netdev->dev_addr, 6);
> ...                                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> 
> <--  snip  -->
> 
> Above there's an "if (dev->pseudo_netdev)" check, but here it's 
> dereferenced without a check.
> 
> It seems instead of the "if (dev->pseudo_netdev)", there should be some 
> kind of
> 
>   if (!dev->pseudo_netdev)
>   	return -ESOME_ERROR;
> 
> 
> cu
> Adrian
> 

