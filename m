Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262798AbVG2TzV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262798AbVG2TzV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 15:55:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262775AbVG2TzK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 15:55:10 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:30115 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S262795AbVG2Ty7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 15:54:59 -0400
Subject: Re: [PATCH 1/7] shared subtree
From: Ram Pai <linuxram@us.ibm.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Andrew Morton <akpm@osdl.org>, viro@parcelfarce.linux.theplanet.co.uk,
       Avantika Mathur <mathurav@us.ibm.com>, mike@waychison.com,
       janak@us.ibm.com, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <E1Dy58Z-0002qL-00@dorka.pomaz.szeredi.hu>
References: <20050725224417.501066000@localhost>
	 <20050725225907.007405000@localhost>
	 <E1DxrzJ-0001uo-00@dorka.pomaz.szeredi.hu>
	 <1122500344.5037.171.camel@localhost>
	 <E1Dy58Z-0002qL-00@dorka.pomaz.szeredi.hu>
Content-Type: text/plain
Organization: IBM 
Message-Id: <1122666893.4715.279.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 29 Jul 2005 12:54:54 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-07-28 at 02:57, Miklos Szeredi wrote:
> > > This is an example, where having struct pnode just complicates things.
> > > If there was no struct pnode, this function would be just one line:
> > > setting the shared flag.
> > So your comment is mostly about getting rid of pnode and distributing
> > the pnode functionality in the vfsmount structure.
> 
> Yes, sorry if I didn't make it clear.
> 
> > I know you are thinking of just having the necessary propogation list in
> > the vfsmount structure itself.  Yes true with that implementation the
> > complication is reduced in this part of the code, but really complicates
> > the propogation traversal routines. 
> 
> On the contrary, I think it will simplify the traversal routines.
> 
> Here's an iterator function I coded up.  Not tested at all (may not
> even compile):

Your suggested code has bugs. But I understand what you are aiming at. 

Maybe you are right. I will try out a implementation using your idea.

Hmm.. lots of code change, and testing.

> 
> struct vfsmount {
> 	/* ... */
>         
> 	struct list_head mnt_share;      /* circular list of shared mounts */
> 	struct list_head mnt_slave_list; /* list of slave mounts */
> 	struct list_head mnt_slave;      /* slave list entry */
> 	struct vfsmount *master;         /* slave is on master->mnt_slave_list */
> };
> 
> static inline struct vfsmount *next_shared(struct vfsmount *p)
> {
> 	return list_entry(p->mnt_share.next, struct vfsmount, mnt_share);
> }
> 
> static inline struct vfsmount *first_slave(struct vfsmount *p)
> {
> 	return list_entry(p->mnt_slave_list.next, struct vfsmount, mnt_slave);
> }
> 
> static inline struct vfsmount *next_slave(struct vfsmount *p)
> {
> 	return list_entry(p->mnt_slave.next, struct vfsmount, mnt_slave);
> }
> 
> static struct vfsmount *propagation_next(struct vfsmount *p,
> 					 struct vfsmount *base)
> {
> 	/* first iterate over the slaves */
> 	if (!list_empty(&p->mnt_slave_list))
> 		return first_slave(p);

I think this code should be
		if (!list_empty(&p->mnt_slave))
			return next_slave(p);

Right? I think I get the idea. 



RP

> 
> 	while (1) {
> 		struct vfsmount *q;
> 
> 		/* more vfsmounts belong to the pnode? */
> 		if (!list_empty(&p->mnt_share)) {
> 			p = next_shared(p);
> 			if (list_empty(&p->mnt_slave) && p != base)
> 				return p;
> 		}
> 		if (p == base)
> 			break;
> 		
> 		BUG_ON(list_empty(&p->mnt_slave));
> 
> 		/* more slaves? */
> 		q = next_slave(p);
> 		if (p->master != q)
> 			return q;
> 
> 		/* back at master */
> 		p = q;
> 	}
> 
> 	return NULL;
> }
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-fsdevel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

