Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751425AbWFOODe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751425AbWFOODe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jun 2006 10:03:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751424AbWFOODe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jun 2006 10:03:34 -0400
Received: from es335.com ([67.65.19.105]:23637 "EHLO mail.es335.com")
	by vger.kernel.org with ESMTP id S1751422AbWFOODd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jun 2006 10:03:33 -0400
Subject: RE: [openib-general] [PATCH v2 1/7] AMSO1100 Low Level Driver.
From: Steve Wise <swise@opengridcomputing.com>
To: Bob Sharp <bsharp@NetEffect.com>
Cc: openib-general <openib-general@openib.org>, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
In-Reply-To: <1150378863.22603.12.camel@stevo-desktop>
References: <5E701717F2B2ED4EA60F87C8AA57B7CC05D4E2D8@venom2>
	 <1150378863.22603.12.camel@stevo-desktop>
Content-Type: text/plain
Date: Thu, 15 Jun 2006 09:03:31 -0500
Message-Id: <1150380211.22603.17.camel@stevo-desktop>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-06-15 at 08:41 -0500, Steve Wise wrote:
> On Wed, 2006-06-14 at 20:35 -0500, Bob Sharp wrote:
> 
> > > +void c2_ae_event(struct c2_dev *c2dev, u32 mq_index)
> > > +{
> > > +
> 
> <snip>
> 
> > > +	case C2_RES_IND_EP:{
> > > +
> > > +		struct c2wr_ae_connection_request *req =
> > > +			&wr->ae.ae_connection_request;
> > > +		struct iw_cm_id *cm_id =
> > > +			(struct iw_cm_id *)resource_user_context;
> > > +
> > > +		pr_debug("C2_RES_IND_EP event_id=%d\n", event_id);
> > > +		if (event_id != CCAE_CONNECTION_REQUEST) {
> > > +			pr_debug("%s: Invalid event_id: %d\n",
> > > +				__FUNCTION__, event_id);
> > > +			break;
> > > +		}
> > > +		cm_event.event = IW_CM_EVENT_CONNECT_REQUEST;
> > > +		cm_event.provider_data = (void*)(unsigned
> > long)req->cr_handle;
> > > +		cm_event.local_addr.sin_addr.s_addr = req->laddr;
> > > +		cm_event.remote_addr.sin_addr.s_addr = req->raddr;
> > > +		cm_event.local_addr.sin_port = req->lport;
> > > +		cm_event.remote_addr.sin_port = req->rport;
> > > +		cm_event.private_data_len =
> > > +			be32_to_cpu(req->private_data_length);
> > > +
> > > +		if (cm_event.private_data_len) {
> > 
> > 
> > It looks to me as if pdata is leaking here since it is not tracked and
> > the upper layers do not free it.  Also, if pdata is freed after the call
> > to cm_id->event_handler returns, it exposes an issue in user space where
> > the private data is garbage.  I suspect the iwarp cm should be copying
> > this data before it returns.
> > 
> 
> Good catch.  
> 
> Yes, I think the IWCM should copy the private data in the upcall.  If it
> does, then the amso driver doesn't need to kmalloc()/copy at all.  It
> can pass a ptr to its MQ entry directly...
> 

Now that I've looked more into this, I'm not sure there's a simple way
for the IWCM to copy the pdata on the upcall.  Currently, the IWCM's
event upcall, cm_event_handler(), simply queues the work for processing
on a workqueue thread.  So there's no per-event logic at all there.
Lemme think on this more.  Stay tuned.  

Either way, the amso driver has a memory leak...

Steve.


