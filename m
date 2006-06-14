Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965022AbWFNQLM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965022AbWFNQLM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jun 2006 12:11:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965019AbWFNQLM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jun 2006 12:11:12 -0400
Received: from es335.com ([67.65.19.105]:29211 "EHLO mail.es335.com")
	by vger.kernel.org with ESMTP id S965016AbWFNQLK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jun 2006 12:11:10 -0400
Subject: Re: [openib-general] [PATCH v2 1/2] iWARP Connection Manager.
From: Steve Wise <swise@opengridcomputing.com>
To: Sean Hefty <sean.hefty@intel.com>
Cc: Andrew Morton <akpm@osdl.org>, netdev@vger.kernel.org, rdreier@cisco.com,
       linux-kernel@vger.kernel.org, openib-general@openib.org
In-Reply-To: <1150235196.17394.91.camel@stevo-desktop>
References: <000001c68f31$78910fe0$24268686@amr.corp.intel.com>
	 <1150235196.17394.91.camel@stevo-desktop>
Content-Type: text/plain
Date: Wed, 14 Jun 2006 11:11:08 -0500
Message-Id: <1150301468.28999.22.camel@stevo-desktop>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-06-13 at 16:46 -0500, Steve Wise wrote:
> On Tue, 2006-06-13 at 14:36 -0700, Sean Hefty wrote:
> > >> Er...no. It will lose this event. Depending on the event...the carnage
> > >> varies. We'll take a look at this.
> > >>
> > >
> > >This behavior is consistent with the Infiniband CM (see
> > >drivers/infiniband/core/cm.c function cm_recv_handler()).  But I think
> > >we should at least log an error because a lost event will usually stall
> > >the rdma connection.
> > 
> > I believe that there's a difference here.  For the Infiniband CM, an allocation
> > error behaves the same as if the received MAD were lost or dropped.  Since MADs
> > are unreliable anyway, it's not so much that an IB CM event gets lost, as it
> > doesn't ever occur.  A remote CM should retry the send, which hopefully allows
> > the connection to make forward progress.
> > 
> 
> hmm.  Ok.  I see.  I misunderstood the code in cm_recv_handler().
> 
> Tom and I have been talking about what we can do to not drop the event.
> Stay tuned.

Here's a simple solution that solves the problem:  

For any given cm_id, there are a finite (and small) number of
outstanding CM events that can be posted.  So we just pre-allocate them
when the cm_id is created and keep them on a free list hanging off of
the cm_id struct.  Then the event handler function will pull from this
free list.  

The only case where there is any non-finite issue is on the passive
listening cm_id.  Each incoming connection request will consume a work
struct.  So based on client connects, we could run out of work structs.
However, the CMA has the concept of a backlog, which is defined as the
max number of pending unaccepted connection requests.  So we allocate
these work structs based on that number (or a computation based on that
number), and if we run out, we simply drop the incoming connection
request due to backlog overflow (I suggest we log the drop event too).
When a MPA connection request is dropped, the (IETF conforming) MPA
client will eventually time out the connection and the consumer can
retry.

Comments?



