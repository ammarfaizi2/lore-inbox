Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262449AbUKVWa2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262449AbUKVWa2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 17:30:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262445AbUKVW2c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 17:28:32 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:43771 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S262437AbUKVWZU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 17:25:20 -0500
Date: Mon, 22 Nov 2004 14:25:07 -0800
From: Greg KH <greg@kroah.com>
To: Roland Dreier <roland@topspin.com>
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: Re: [PATCH][RFC/v1][4/12] Add InfiniBand SA (Subnet Administration) query support
Message-ID: <20041122222507.GB15634@kroah.com>
References: <20041122713.SDrx8l5Z4XR5FsjB@topspin.com> <20041122713.g6bh6aqdXIN4RJYR@topspin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041122713.g6bh6aqdXIN4RJYR@topspin.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 22, 2004 at 07:13:48AM -0800, Roland Dreier wrote:
> 
> Index: linux-bk/drivers/infiniband/core/Makefile
> ===================================================================

Please hack your submit script to not add these headers, when importing
to bk they end up showing up in the change log comments :(

> --- /dev/null	1970-01-01 00:00:00.000000000 +0000
> +++ linux-bk/drivers/infiniband/core/sa_query.c	2004-11-21 21:25:53.928200384 -0800
> @@ -0,0 +1,815 @@
> +/*
> + * This software is available to you under a choice of one of two
> + * licenses.  You may choose to be licensed under the terms of the GNU
> + * General Public License (GPL) Version 2, available at
> + * <http://www.fsf.org/copyleft/gpl.html>, or the OpenIB.org BSD
> + * license, available in the LICENSE.TXT file accompanying this
> + * software.  These details are also available at
> + * <http://openib.org/license.html>.
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
> + * Copyright (c) 2004 Topspin Communications.  All rights reserved.

No email address of who to bug with issues?

> + *
> + * $Id$

Not needed :)

> + */
> +
> +#include <linux/module.h>
> +#include <linux/init.h>
> +#include <linux/err.h>
> +#include <linux/random.h>
> +#include <linux/spinlock.h>
> +#include <linux/slab.h>
> +#include <linux/pci.h>
> +#include <linux/kref.h>
> +#include <linux/idr.h>
> +
> +#include <ib_pack.h>
> +#include <ib_sa.h>
> +
> +MODULE_AUTHOR("Roland Dreier");
> +MODULE_DESCRIPTION("InfiniBand subnet administration query support");
> +MODULE_LICENSE("Dual BSD/GPL");
> +
> +struct ib_sa_hdr {
> +	u64			sm_key;
> +	u16			attr_offset;
> +	u16			reserved;
> +	ib_sa_comp_mask		comp_mask;
> +} __attribute__ ((packed));

Why is this packed?

> +struct ib_sa_mad {
> +	struct ib_mad_hdr	mad_hdr;
> +	struct ib_rmpp_hdr	rmpp_hdr;
> +	struct ib_sa_hdr	sa_hdr;
> +	u8			data[200];
> +} __attribute__ ((packed));

Same here?

> +
> +struct ib_sa_sm_ah {
> +	struct ib_ah        *ah;
> +	struct kref          ref;
> +};
> +
> +struct ib_sa_port {
> +	struct ib_mad_agent *agent;
> +	struct ib_mr        *mr;
> +	struct ib_sa_sm_ah  *sm_ah;
> +	struct work_struct   update_task;
> +	spinlock_t           ah_lock;
> +	u8                   port_num;
> +};
> +
> +struct ib_sa_device {
> +	int                     start_port, end_port;
> +	struct ib_event_handler event_handler;
> +	struct ib_sa_port port[0];
> +};
> +
> +struct ib_sa_query {
> +	void (*callback)(struct ib_sa_query *, int, struct ib_sa_mad *);
> +	void (*release)(struct ib_sa_query *);
> +	struct ib_sa_port  *port;
> +	struct ib_sa_mad   *mad;
> +	struct ib_sa_sm_ah *sm_ah;
> +	DECLARE_PCI_UNMAP_ADDR(mapping)
> +	int                 id;
> +};
> +
> +struct ib_sa_path_query {
> +	void (*callback)(int, struct ib_sa_path_rec *, void *);
> +	void *context;
> +	struct ib_sa_query sa_query;
> +};
> +
> +struct ib_sa_mcmember_query {
> +	void (*callback)(int, struct ib_sa_mcmember_rec *, void *);
> +	void *context;
> +	struct ib_sa_query sa_query;
> +};
> +
> +static void ib_sa_add_one(struct ib_device *device);
> +static void ib_sa_remove_one(struct ib_device *device);
> +
> +static struct ib_client sa_client = {
> +	.name   = "sa",
> +	.add    = ib_sa_add_one,
> +	.remove = ib_sa_remove_one
> +};
> +
> +static spinlock_t idr_lock;
> +DEFINE_IDR(query_idr);

Should this be global or static?

> +
> +static spinlock_t tid_lock;
> +static u32 tid;
> +
> +enum {
> +        IB_SA_ATTR_CLASS_PORTINFO    = 0x01,
> +        IB_SA_ATTR_NOTICE            = 0x02,
> +        IB_SA_ATTR_INFORM_INFO       = 0x03,
> +        IB_SA_ATTR_NODE_REC          = 0x11,
> +        IB_SA_ATTR_PORT_INFO_REC     = 0x12,
> +        IB_SA_ATTR_SL2VL_REC         = 0x13,
> +        IB_SA_ATTR_SWITCH_REC        = 0x14,
> +        IB_SA_ATTR_LINEAR_FDB_REC    = 0x15,
> +        IB_SA_ATTR_RANDOM_FDB_REC    = 0x16,
> +        IB_SA_ATTR_MCAST_FDB_REC     = 0x17,
> +        IB_SA_ATTR_SM_INFO_REC       = 0x18,
> +        IB_SA_ATTR_LINK_REC          = 0x20,
> +        IB_SA_ATTR_GUID_INFO_REC     = 0x30,
> +        IB_SA_ATTR_SERVICE_REC       = 0x31,
> +        IB_SA_ATTR_PARTITION_REC     = 0x33,
> +        IB_SA_ATTR_RANGE_REC         = 0x34,
> +        IB_SA_ATTR_PATH_REC          = 0x35,
> +        IB_SA_ATTR_VL_ARB_REC        = 0x36,
> +        IB_SA_ATTR_MC_GROUP_REC      = 0x37,
> +        IB_SA_ATTR_MC_MEMBER_REC     = 0x38,
> +	IB_SA_ATTR_TRACE_REC         = 0x39,
> +	IB_SA_ATTR_MULTI_PATH_REC    = 0x3a,
> +	IB_SA_ATTR_SERVICE_ASSOC_REC = 0x3b
> +};

Oops, tabs vs. spaces.

Care to use the __bitwise field here so that you can have sparse check
to see that you are actually using the proper enum values in all places?
See the kobject_action code for an example of this.

> +
> +#define PATH_REC_FIELD(field) \
> +	.struct_offset_bytes = offsetof(struct ib_sa_path_rec, field),		\
> +	.struct_size_bytes   = sizeof ((struct ib_sa_path_rec *) 0)->field,	\
> +	.field_name          = "sa_path_rec:" #field
> +
> +static const struct ib_field path_rec_table[] = {
> +	{ RESERVED,
> +	  .offset_words = 0,
> +	  .offset_bits  = 0,
> +	  .size_bits    = 32 },

What is "RESERVED"?  I must be missing a previous patch somewhere, I
currently don't see all of the series yet.

thanks,

greg k-h
