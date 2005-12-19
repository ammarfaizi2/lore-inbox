Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964962AbVLSUug@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964962AbVLSUug (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Dec 2005 15:50:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964963AbVLSUug
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Dec 2005 15:50:36 -0500
Received: from mx.pathscale.com ([64.160.42.68]:65172 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S964962AbVLSUug (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Dec 2005 15:50:36 -0500
Subject: Re: [openib-general] Re: [PATCH 10/13]  [RFC] ipath verbs, part 1
From: Ralph Campbell <ralphc@pathscale.com>
To: "Paul E. McKenney" <paulmck@us.ibm.com>
Cc: Roland Dreier <rolandd@cisco.com>, linux-kernel@vger.kernel.org,
       openib-general@openib.org
In-Reply-To: <20051218195922.GC31184@us.ibm.com>
References: <200512161548.zxp6FKcabEu47EnS@cisco.com>
	 <200512161548.W9sJn4CLmdhnSTcH@cisco.com>
	 <20051218195922.GC31184@us.ibm.com>
Content-Type: text/plain
Date: Mon, 19 Dec 2005 12:50:27 -0800
Message-Id: <1135025427.6397.21.camel@brick.internal.keyresearch.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The quick answer is the qp_list is traversed w/o the lock held in
ipath_ib_rcv().  The intent is to be able to do a lookup on the GID
to get a reference to the struct ipath_mcast and then walk the qp_list
w/o locks being held while processing the received packets at
interrupt level.


On Sun, 2005-12-18 at 11:59 -0800, Paul E. McKenney wrote:
> On Fri, Dec 16, 2005 at 03:48:55PM -0800, Roland Dreier wrote:
> > First half of ipath verbs driver
> 
> Some RCU-related questions interspersed.  Basic question is "where is
> the lock-free read-side traversal?"
> 
> 						Thanx, Paul
> 
> > ---
> > 
> >  drivers/infiniband/hw/ipath/ipath_verbs.c | 3244 +++++++++++++++++++++++++++++
> >  1 files changed, 3244 insertions(+), 0 deletions(-)
> >  create mode 100644 drivers/infiniband/hw/ipath/ipath_verbs.c
...
> > +/*
> > + * Insert the multicast GID into the table and
> > + * attach the QP structure.
> > + * Return zero if both were added.
> > + * Return EEXIST if the GID was already in the table but the QP was added.
> > + * Return ESRCH if the QP was already attached and neither structure was added.
> > + */
> > +static int ipath_mcast_add(struct ipath_mcast *mcast,
> > +			   struct ipath_mcast_qp *mqp)
> > +{
> > +	struct rb_node **n = &mcast_tree.rb_node;
> > +	struct rb_node *pn = NULL;
> > +	unsigned long flags;
> > +
> > +	spin_lock_irqsave(&mcast_lock, flags);
> > +
> > +	while (*n) {
> > +		struct ipath_mcast *tmcast;
> > +		struct ipath_mcast_qp *p;
> > +		int ret;
> > +
> > +		pn = *n;
> > +		tmcast = rb_entry(pn, struct ipath_mcast, rb_node);
> > +
> > +		ret = memcmp(mcast->mgid.raw, tmcast->mgid.raw,
> > +			     sizeof(union ib_gid));
> > +		if (ret < 0) {
> > +			n = &pn->rb_left;
> > +			continue;
> > +		}
> > +		if (ret > 0) {
> > +			n = &pn->rb_right;
> > +			continue;
> > +		}
> > +
> > +		/* Search the QP list to see if this is already there. */
> > +		list_for_each_entry_rcu(p, &tmcast->qp_list, list) {
> 
> Given that we hold the global mcast_lock, how is RCU helping here?

Its not really. I'm just trying to be consistent where ever the
qp_list is traversed.

> Is there a lock-free read-side traversal path somewhere that I am
> missing?

The lock free traversal is in ipath_ib_rcv() which is an interrupt
routine.

> > +			if (p->qp == mqp->qp) {
> > +				spin_unlock_irqrestore(&mcast_lock, flags);
> > +				return ESRCH;
> > +			}
> > +		}
> > +		list_add_tail_rcu(&mqp->list, &tmcast->qp_list);
> 
> Ditto...
> 
> > +		spin_unlock_irqrestore(&mcast_lock, flags);
> > +		return EEXIST;
> > +	}
> > +
> > +	list_add_tail_rcu(&mqp->list, &mcast->qp_list);
> 
> Ditto...
> 
> > +		spin_unlock_irqrestore(&mcast_lock, flags);
> > +
> > +	atomic_inc(&mcast->refcount);
> > +	rb_link_node(&mcast->rb_node, pn, n);
> > +	rb_insert_color(&mcast->rb_node, &mcast_tree);
> > +
> > +	spin_unlock_irqrestore(&mcast_lock, flags);
> > +
> > +	return 0;
> > +}

-- 
Ralph Campbell <ralphc@pathscale.com>

