Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752085AbWFLPuh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752085AbWFLPuh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 11:50:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752081AbWFLPuh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 11:50:37 -0400
Received: from es335.com ([67.65.19.105]:54126 "EHLO mail.es335.com")
	by vger.kernel.org with ESMTP id S1752078AbWFLPuf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 11:50:35 -0400
Subject: Re: [PATCH v2 1/2] iWARP Connection Manager.
From: Tom Tucker <tom@opengridcomputing.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Steve Wise <swise@opengridcomputing.com>, rdreier@cisco.com,
       mshefty@ichips.intel.com, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org, openib-general@openib.org
In-Reply-To: <20060608005452.087b34db.akpm@osdl.org>
References: <20060607200600.9003.56328.stgit@stevo-desktop>
	 <20060607200605.9003.25830.stgit@stevo-desktop>
	 <20060608005452.087b34db.akpm@osdl.org>
Content-Type: text/plain
Date: Mon, 12 Jun 2006 10:54:58 -0500
Message-Id: <1150127698.22704.9.camel@trinity.ogc.int>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew, thanks for the review, comments inline...

On Thu, 2006-06-08 at 00:54 -0700, Andrew Morton wrote:
> On Wed, 07 Jun 2006 15:06:05 -0500
> Steve Wise <swise@opengridcomputing.com> wrote:
> 
> > 
> > This patch provides the new files implementing the iWARP Connection
> > Manager.
> > 
> > Review Changes:
> > 
> > - sizeof -> sizeof()
> > 
> > - removed printks
> > 
> > - removed TT debug code
> > 
> > - cleaned up lock/unlock around switch statements.
> > 
> > - waitqueue -> completion for destroy path.
> >
> > ...
> >
> > +/* 
> > + * This function is called on interrupt context. Schedule events on
> > + * the iwcm_wq thread to allow callback functions to downcall into
> > + * the CM and/or block.  Events are queued to a per-CM_ID
> > + * work_list. If this is the first event on the work_list, the work
> > + * element is also queued on the iwcm_wq thread.
> > + *
> > + * Each event holds a reference on the cm_id. Until the last posted
> > + * event has been delivered and processed, the cm_id cannot be
> > + * deleted. 
> > + */
> > +static void cm_event_handler(struct iw_cm_id *cm_id,
> > +			     struct iw_cm_event *iw_event) 
> > +{
> > +	struct iwcm_work *work;
> > +	struct iwcm_id_private *cm_id_priv;
> > +	unsigned long flags;
> > +
> > +	work = kmalloc(sizeof(*work), GFP_ATOMIC);
> > +	if (!work)
> > +		return;
> 
> This allocation _will_ fail sometimes.  The driver must recover from it. 
> Will it do so?

Er...no. It will lose this event. Depending on the event...the carnage
varies. We'll take a look at this.

> 
> > +EXPORT_SYMBOL(iw_cm_init_qp_attr);
> 
> This file exports a ton of symbols.  It's usual to provide some justifying
> commentary in the changelog when this happens.

This module is a logical instance of the xx_cm where xx is the transport
type. I think there is some discussion warranted on whether or not these
should all be built into and exported by rdma_cm. One rationale would be
that the rdma_cm is the only client for many of these functions (this
being a particularly good example) and doing so would reduce the export
count. Others would be reasonably needed for any application (connect,
etc...)

All that said, we'll be sure to document the exported symbols in a
follow-up patch.

> 
> > +/*
> > + * Copyright (c) 2005 Network Appliance, Inc. All rights reserved.
> > + * Copyright (c) 2005 Open Grid Computing, Inc. All rights reserved.
> > + *
> > + * This software is available to you under a choice of one of two
> > + * licenses.  You may choose to be licensed under the terms of the GNU
> > + * General Public License (GPL) Version 2, available from the file
> > + * COPYING in the main directory of this source tree, or the
> > + * OpenIB.org BSD license below:
> > + *
> > + *     Redistribution and use in source and binary forms, with or
> > + *     without modification, are permitted provided that the following
> > + *     conditions are met:
> > + *
> > + *      - Redistributions of source code must retain the above
> > + *        copyright notice, this list of conditions and the following
> > + *        disclaimer.
> > + *
> > + *      - Redistributions in binary form must reproduce the above
> > + *        copyright notice, this list of conditions and the following
> > + *        disclaimer in the documentation and/or other materials
> > + *        provided with the distribution.
> > + *
> > + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
> > + * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
> > + * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
> > + * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
> > + * BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
> > + * ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
> > + * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
> > + * SOFTWARE.
> > + */
> > +#if !defined(IW_CM_PRIVATE_H)
> > +#define IW_CM_PRIVATE_H
> 
> We normally use #ifndef here.

We'll change this..

> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe netdev" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

