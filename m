Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030196AbWD0RBx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030196AbWD0RBx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 13:01:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965167AbWD0RBx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 13:01:53 -0400
Received: from hera.kernel.org ([140.211.167.34]:63364 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S965158AbWD0RBw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 13:01:52 -0400
To: linux-kernel@vger.kernel.org
From: Stephen Hemminger <shemminger@osdl.org>
Subject: Re: [PATCH 3/6] open iscsi iser transport provider code
Date: Thu, 27 Apr 2006 10:01:22 -0700
Organization: OSDL
Message-ID: <20060427100122.071b8a6a@localhost.localdomain>
References: <Pine.LNX.4.44.0604271530400.16463-100000@zuben>
	<Pine.LNX.4.44.0604271531260.16463-100000@zuben>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Trace: build.pdx.osdl.net 1146157280 25324 10.8.0.54 (27 Apr 2006 17:01:20 GMT)
X-Complaints-To: abuse@osdl.org
NNTP-Posting-Date: Thu, 27 Apr 2006 17:01:20 +0000 (UTC)
X-Newsreader: Sylpheed-Claws 2.0.0 (GTK+ 2.8.6; i486-pc-linux-gnu)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Apr 2006 15:31:52 +0300 (IDT)
Or Gerlitz <ogerlitz@voltaire.com> wrote:

> Signed-off-by: Or Gerlitz <ogerlitz@voltaire.com>
> 
> --- /usr/src/linux-2.6.17-rc3/drivers/infiniband/ulp/iser-x/iscsi_iser.c	1970-01-01 02:00:00.000000000 +0200
> +++ /usr/src/linux-2.6.17-rc3/drivers/infiniband/ulp/iser/iscsi_iser.c	2006-04-26 12:50:11.000000000 +0300
> @@ -0,0 +1,800 @@
> +/*
> + * iSCSI Initiator over iSER Data-Path
> + *
> + * Copyright (C) 2004 Dmitry Yusupov
> + * Copyright (C) 2004 Alex Aizman
> + * Copyright (C) 2005 Mike Christie
> + * Copyright (c) 2005, 2006 Voltaire, Inc. All rights reserved.
> + * maintained by openib-general@openib.org
> + *
> + * This software is available to you under a choice of one of two
> + * licenses.  You may choose to be licensed under the terms of the GNU
> + * General Public License (GPL) Version 2, available from the file
> + * COPYING in the main directory of this source tree, or the
> + * OpenIB.org BSD license below:
> + *
> + *     Redistribution and use in source and binary forms, with or
> + *     without modification, are permitted provided that the following
> + *     conditions are met:
> + *
> + *	- Redistributions of source code must retain the above
> + *	  copyright notice, this list of conditions and the following
> + *	  disclaimer.
> + *
> + *	- Redistributions in binary form must reproduce the above
> + *	  copyright notice, this list of conditions and the following
> + *	  disclaimer in the documentation and/or other materials
> + *	  provided with the distribution.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
> + * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
> + * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
> + * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
> + * BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
> + * ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
> + * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
> + * SOFTWARE.
> + *
> + * Credits:
> + *	Christoph Hellwig
> + *	FUJITA Tomonori
> + *	Arne Redlich
> + *	Zhenyu Wang
> + * Modified by:
> + *      Erez Zilber
> + *
> + *
> + * $Id: iscsi_iser.c 6643 2006-04-26 10:01:01Z ogerlitz $
> + */
> +
> +#include <linux/types.h>
> +#include <linux/list.h>
> +#include <linux/hardirq.h>
> +#include <linux/kfifo.h>
> +#include <linux/blkdev.h>
> +#include <linux/init.h>
> +#include <linux/ioctl.h>
> +#include <linux/devfs_fs_kernel.h>
> +#include <linux/cdev.h>
> +#include <linux/in.h>
> +#include <linux/net.h>
> +#include <linux/scatterlist.h>
> +#include <linux/delay.h>
> +
> +#include <net/sock.h>
> +
> +#include <asm/uaccess.h>
> +
> +#include <scsi/scsi_cmnd.h>
> +#include <scsi/scsi_device.h>
> +#include <scsi/scsi_eh.h>
> +#include <scsi/scsi_request.h>
> +#include <scsi/scsi_tcq.h>
> +#include <scsi/scsi_host.h>
> +#include <scsi/scsi.h>
> +#include <scsi/scsi_transport_iscsi.h>
> +
> +#include "iscsi_iser.h"
> +
> +static unsigned int iscsi_max_lun = 512;
> +module_param_named(max_lun, iscsi_max_lun, uint, S_IRUGO);
> +
> +#define DRV_VER	     "$Rev: 227 $"
> +#define DRV_DATE     "$LastChangedDate: 2006-03-22 16:47:30 +0200 (Wed, 22 Mar 2006) $"
> +

Don't use your magic revision control tags, they won't be updated by other 
revision control systems.
