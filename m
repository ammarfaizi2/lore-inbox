Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261362AbVG1J6z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261362AbVG1J6z (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 05:58:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261359AbVG1J6z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 05:58:55 -0400
Received: from 238-071.adsl.pool.ew.hu ([193.226.238.71]:54029 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S261355AbVG1J5z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 05:57:55 -0400
To: linuxram@us.ibm.com
CC: akpm@osdl.org, viro@parcelfarce.linux.theplanet.co.uk, mathurav@us.ibm.com,
       mike@waychison.com, janak@us.ibm.com, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org
In-reply-to: <1122500344.5037.171.camel@localhost> (message from Ram Pai on
	Wed, 27 Jul 2005 14:39:05 -0700)
Subject: Re: [PATCH 1/7] shared subtree
References: <20050725224417.501066000@localhost>
	 <20050725225907.007405000@localhost>
	 <E1DxrzJ-0001uo-00@dorka.pomaz.szeredi.hu> <1122500344.5037.171.camel@localhost>
Message-Id: <E1Dy58Z-0002qL-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 28 Jul 2005 11:57:11 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > This is an example, where having struct pnode just complicates things.
> > If there was no struct pnode, this function would be just one line:
> > setting the shared flag.
> So your comment is mostly about getting rid of pnode and distributing
> the pnode functionality in the vfsmount structure.

Yes, sorry if I didn't make it clear.

> I know you are thinking of just having the necessary propogation list in
> the vfsmount structure itself.  Yes true with that implementation the
> complication is reduced in this part of the code, but really complicates
> the propogation traversal routines. 

On the contrary, I think it will simplify the traversal routines.

Here's an iterator function I coded up.  Not tested at all (may not
even compile):

struct vfsmount {
	/* ... */
        
	struct list_head mnt_share;      /* circular list of shared mounts */
	struct list_head mnt_slave_list; /* list of slave mounts */
	struct list_head mnt_slave;      /* slave list entry */
	struct vfsmount *master;         /* slave is on master->mnt_slave_list */
};

static inline struct vfsmount *next_shared(struct vfsmount *p)
{
	return list_entry(p->mnt_share.next, struct vfsmount, mnt_share);
}

static inline struct vfsmount *first_slave(struct vfsmount *p)
{
	return list_entry(p->mnt_slave_list.next, struct vfsmount, mnt_slave);
}

static inline struct vfsmount *next_slave(struct vfsmount *p)
{
	return list_entry(p->mnt_slave.next, struct vfsmount, mnt_slave);
}

static struct vfsmount *propagation_next(struct vfsmount *p,
					 struct vfsmount *base)
{
	/* first iterate over the slaves */
	if (!list_empty(&p->mnt_slave_list))
		return first_slave(p);

	while (1) {
		struct vfsmount *q;

		/* more vfsmounts belong to the pnode? */
		if (!list_empty(&p->mnt_share)) {
			p = next_shared(p);
			if (list_empty(&p->mnt_slave) && p != base)
				return p;
		}
		if (p == base)
			break;
		
		BUG_ON(list_empty(&p->mnt_slave));

		/* more slaves? */
		q = next_slave(p);
		if (p->master != q)
			return q;

		/* back at master */
		p = q;
	}

	return NULL;
}

