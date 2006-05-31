Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965082AbWEaSg0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965082AbWEaSg0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 May 2006 14:36:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965083AbWEaSg0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 May 2006 14:36:26 -0400
Received: from hera.kernel.org ([140.211.167.34]:54944 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S965082AbWEaSgZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 May 2006 14:36:25 -0400
To: linux-kernel@vger.kernel.org
From: Stephen Hemminger <shemminger@osdl.org>
Subject: Re: [PATCH 2/2] iWARP Core Changes.
Date: Wed, 31 May 2006 11:36:01 -0700
Organization: OSDL
Message-ID: <20060531113601.7a68b4a6@localhost.localdomain>
References: <20060531182650.3308.81538.stgit@stevo-desktop>
	<20060531182654.3308.41372.stgit@stevo-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Trace: build.pdx.osdl.net 1149100557 22384 10.8.0.54 (31 May 2006 18:35:57 GMT)
X-Complaints-To: abuse@osdl.org
NNTP-Posting-Date: Wed, 31 May 2006 18:35:57 +0000 (UTC)
X-Newsreader: Sylpheed-Claws 2.1.0 (GTK+ 2.8.6; i486-pc-linux-gnu)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 May 2006 13:26:55 -0500
Steve Wise <swise@opengridcomputing.com> wrote:

> 
> This patch contains modifications to the existing rdma header files,
> core files, drivers, and ulp files to support iWARP.
> ---
> 
>  drivers/infiniband/core/Makefile             |    4 
>  drivers/infiniband/core/addr.c               |    8 -
>  drivers/infiniband/core/cache.c              |    8 -
>  drivers/infiniband/core/cm.c                 |    3 
>  drivers/infiniband/core/cma.c                |  349 +++++++++++++++++++++++---
>  drivers/infiniband/core/device.c             |    6 
>  drivers/infiniband/core/mad.c                |   11 +
>  drivers/infiniband/core/sa_query.c           |    5 
>  drivers/infiniband/core/smi.c                |   18 +
>  drivers/infiniband/core/sysfs.c              |   18 +
>  drivers/infiniband/core/ucm.c                |    5 
>  drivers/infiniband/core/user_mad.c           |    9 -
>  drivers/infiniband/hw/ipath/ipath_verbs.c    |    2 
>  drivers/infiniband/hw/mthca/mthca_provider.c |    2 
>  drivers/infiniband/ulp/ipoib/ipoib_main.c    |    8 +
>  drivers/infiniband/ulp/srp/ib_srp.c          |    2 
>  include/rdma/ib_addr.h                       |   15 +
>  include/rdma/ib_verbs.h                      |   39 +++
>  18 files changed, 427 insertions(+), 85 deletions(-)
> 
> diff --git a/drivers/infiniband/core/Makefile b/drivers/infiniband/core/Makefile
> index 68e73ec..163d991 100644
> --- a/drivers/infiniband/core/Makefile
> +++ b/drivers/infiniband/core/Makefile
> @@ -1,7 +1,7 @@
>  infiniband-$(CONFIG_INFINIBAND_ADDR_TRANS)	:= ib_addr.o rdma_cm.o
>  
>  obj-$(CONFIG_INFINIBAND) +=		ib_core.o ib_mad.o ib_sa.o \
> -					ib_cm.o $(infiniband-y)
> +					ib_cm.o iw_cm.o $(infiniband-y)
>  obj-$(CONFIG_INFINIBAND_USER_MAD) +=	ib_umad.o
>  obj-$(CONFIG_INFINIBAND_USER_ACCESS) +=	ib_uverbs.o ib_ucm.o
>  
> @@ -14,6 +14,8 @@ ib_sa-y :=			sa_query.o
>  
>  ib_cm-y :=			cm.o
>  
> +iw_cm-y :=			iwcm.o
> +
>  rdma_cm-y :=			cma.o
>  
>  ib_addr-y :=			addr.o
> diff --git a/drivers/infiniband/core/addr.c b/drivers/infiniband/core/addr.c
> index d294bbc..5a9be54 100644
> --- a/drivers/infiniband/core/addr.c
> +++ b/drivers/infiniband/core/addr.c
> @@ -60,12 +60,15 @@ static LIST_HEAD(req_list);
>  static DECLARE_WORK(work, process_req, NULL);
>  static struct workqueue_struct *addr_wq;
>  
> -static int copy_addr(struct rdma_dev_addr *dev_addr, struct net_device *dev,
> +int copy_addr(struct rdma_dev_addr *dev_addr, struct net_device *dev,
>  		     unsigned char *dst_dev_addr)

If you have to make this global choose a better name than 'copy_addr'
and change dst_dev_addr to be const.

