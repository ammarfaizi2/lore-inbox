Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263148AbVGaApW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263148AbVGaApW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Jul 2005 20:45:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263149AbVGaApP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Jul 2005 20:45:15 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:59051 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263148AbVGaApL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Jul 2005 20:45:11 -0400
Subject: Re: [PATCH 1/7] shared subtree
From: Ram Pai <linuxram@us.ibm.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Andrew Morton <akpm@osdl.org>, viro@parcelfarce.linux.theplanet.co.uk,
       Avantika Mathur <mathurav@us.ibm.com>, mike@waychison.com,
       janak@us.ibm.com, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <E1Dyk4A-0006IL-00@dorka.pomaz.szeredi.hu>
References: <20050725224417.501066000@localhost>
	 <20050725225907.007405000@localhost>
	 <E1DxrzJ-0001uo-00@dorka.pomaz.szeredi.hu>
	 <1122500344.5037.171.camel@localhost>
	 <E1Dy58Z-0002qL-00@dorka.pomaz.szeredi.hu>
	 <1122666893.4715.279.camel@localhost>
	 <E1Dyk4A-0006IL-00@dorka.pomaz.szeredi.hu>
Content-Type: text/plain
Organization: IBM 
Message-Id: <1122770705.6956.23.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sat, 30 Jul 2005 17:45:05 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-07-29 at 22:39, Miklos Szeredi wrote:
> > > static struct vfsmount *propagation_next(struct vfsmount *p,
> > > 					 struct vfsmount *base)
> > > {
> > > 	/* first iterate over the slaves */
> > > 	if (!list_empty(&p->mnt_slave_list))
> > > 		return first_slave(p);
> > 
> > I think this code should be
> > 		if (!list_empty(&p->mnt_slave))
> > 			return next_slave(p);
> > 
> > Right? I think I get the idea. 
> 
> This is a depth-first search, so first_slave() is right.

Ok. I have started implementing your idea. But the implementation is no
simple.  Its becomes a complex mess. Atleast in the case of pnode
datastructure implementation, the propogation was all abstracted and
concentrated in the pnode datastructure. 

Here is a sample implementation of do_make_slave() with your idea. 

static int do_make_slave(struct vfsmount *mnt)
{
        int err=0;
        struct vfsmount *peer_mnt;

        spin_lock(&vfspnode_lock);
        if (!IS_MNT_SHARED(mnt)) {
                spin_unlock(&vfspnode_lock);
                err = -EINVAL;
                goto out;
        }

        peer_mnt = list_entry(mnt->mnt_share.next, struct vfsmount,
mnt_share);
        if (peer_mnt == mnt)
                peer_mnt = NULL;

        list_del_init(&mnt->mnt_share);
        if (peer_mnt) {
                /* move the slave list to the peer_mnt */
                list_splice(&mnt->mnt_slave, &peer_mnt->mnt_slave);
                list_add(&mnt->mnt_slave_list, &peer_mnt->mnt_slave);
                set_mnt_slave(mnt);
        } else {
                struct vfsmount *slave_mnt, *t_slave_mnt;
                list_for_each_entry_safe(slave_mnt, t_slave_mnt,
                                &mnt->mnt_slave, mnt_slave_list) {
                        CLEAR_MNT_SLAVE(slave_mnt);
                        list_del_init(&slave_mnt->mnt_slave_list);
                }
        }
        list_del_init(&mnt->mnt_slave);
        mnt->mnt_master = peer_mnt;
        spin_unlock(&vfspnode_lock);
out:
        return err;
}

Do you still believe that your idea is simpler? 

The most difficult part is, attaching shared vfs tree, which needs to be
attached at someother shared mount point. The problem here is while
traversing the propogation tree, one has to build another similar
propogation tree for the new child mount. Its a 2 dimensional tree walk,
i.e one walk is along the vfstree, and the other walk is along the pnode
tree for each mount.  Its much easier to abstract out the pnode
operations and concentrate on them separately than mixing the
functionality of vfs and pnode in a single vfs datastructure.

In my code, I have abstracted out the pnode tree traversing operation
using a single iterator function pnode_next().

Think about it, and let me know if it is worth the effort of changing
the implementation. I sincerely feel it just shifts complexity instead
of reducing complexity. I can eventually come up with a fully tested
implementation using your idea, but I am still not convinced that
it reduces complexity.


RP

> 
> Here's a less buggy (and even more simplified) version of the
> function.  Note: it must be called with 'origin' either on a slave
> list or at the root pnode.  That's because the function checks if the
> all vfsmounts in a pnode have been traversed by looking at the
> emptiness of mnt_slave.  So if origin was in a slave pnode, but is not
> the actual slave link, the algorithm will go off the starting pnode
> and up to it's master.
> 
> So here's a preparation function that finds the right place to start
> the propagation.
> 
> static struct vfsmount *propagation_first(struct vfsmount *p)
> {
> 	struct vfsmount *q = p;
> 
> 	while (list_empty(&q->mnt_slave)) {
> 		q = next_shared(q);
> 		if (q == p)
> 			break;
> 	}
> 	return q;
> }
> 
> static struct vfsmount *propagation_next(struct vfsmount *p,
> 					 struct vfsmount *origin)
> {
> 	/* are there any slaves of this mount? */
> 	if (!list_empty(&p->mnt_slave_list))
> 		return first_slave(p);
> 
> 	while (1) {
> 		/* if p->mnt_share is empty, this is a no-op */
> 		p = next_shared(p);
> 
> 		/* finished traversing? */
> 		if (p == origin)
> 			break;
> 
> 		/* more vfsmounts belong to the pnode? */
> 		if (list_empty(&p->mnt_slave))
> 			return p;
> 		
> 		/* more slaves? */
> 		if (p->mnt_slave.next != &p->mnt_master->mnt_slave_list)
> 			return next_slave(p);
> 
> 		/* back at master */
> 		p = p->mnt_master;
> 	}
> 
> 	return NULL;
> }
> 

