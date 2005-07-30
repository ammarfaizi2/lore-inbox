Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262938AbVG3Fk3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262938AbVG3Fk3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Jul 2005 01:40:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262940AbVG3FkW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Jul 2005 01:40:22 -0400
Received: from 238-071.adsl.pool.ew.hu ([193.226.238.71]:9747 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S262938AbVG3FkS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Jul 2005 01:40:18 -0400
To: linuxram@us.ibm.com
CC: akpm@osdl.org, viro@parcelfarce.linux.theplanet.co.uk, mathurav@us.ibm.com,
       mike@waychison.com, janak@us.ibm.com, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org
In-reply-to: <1122666893.4715.279.camel@localhost> (message from Ram Pai on
	Fri, 29 Jul 2005 12:54:54 -0700)
Subject: Re: [PATCH 1/7] shared subtree
References: <20050725224417.501066000@localhost>
	 <20050725225907.007405000@localhost>
	 <E1DxrzJ-0001uo-00@dorka.pomaz.szeredi.hu>
	 <1122500344.5037.171.camel@localhost>
	 <E1Dy58Z-0002qL-00@dorka.pomaz.szeredi.hu> <1122666893.4715.279.camel@localhost>
Message-Id: <E1Dyk4A-0006IL-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Sat, 30 Jul 2005 07:39:22 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > static struct vfsmount *propagation_next(struct vfsmount *p,
> > 					 struct vfsmount *base)
> > {
> > 	/* first iterate over the slaves */
> > 	if (!list_empty(&p->mnt_slave_list))
> > 		return first_slave(p);
> 
> I think this code should be
> 		if (!list_empty(&p->mnt_slave))
> 			return next_slave(p);
> 
> Right? I think I get the idea. 

This is a depth-first search, so first_slave() is right.

Here's a less buggy (and even more simplified) version of the
function.  Note: it must be called with 'origin' either on a slave
list or at the root pnode.  That's because the function checks if the
all vfsmounts in a pnode have been traversed by looking at the
emptiness of mnt_slave.  So if origin was in a slave pnode, but is not
the actual slave link, the algorithm will go off the starting pnode
and up to it's master.

So here's a preparation function that finds the right place to start
the propagation.

static struct vfsmount *propagation_first(struct vfsmount *p)
{
	struct vfsmount *q = p;

	while (list_empty(&q->mnt_slave)) {
		q = next_shared(q);
		if (q == p)
			break;
	}
	return q;
}

static struct vfsmount *propagation_next(struct vfsmount *p,
					 struct vfsmount *origin)
{
	/* are there any slaves of this mount? */
	if (!list_empty(&p->mnt_slave_list))
		return first_slave(p);

	while (1) {
		/* if p->mnt_share is empty, this is a no-op */
		p = next_shared(p);

		/* finished traversing? */
		if (p == origin)
			break;

		/* more vfsmounts belong to the pnode? */
		if (list_empty(&p->mnt_slave))
			return p;
		
		/* more slaves? */
		if (p->mnt_slave.next != &p->mnt_master->mnt_slave_list)
			return next_slave(p);

		/* back at master */
		p = p->mnt_master;
	}

	return NULL;
}

