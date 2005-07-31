Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261669AbVGaHxy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261669AbVGaHxy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Jul 2005 03:53:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261821AbVGaHxy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Jul 2005 03:53:54 -0400
Received: from 238-071.adsl.pool.ew.hu ([193.226.238.71]:8197 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S261669AbVGaHxw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Jul 2005 03:53:52 -0400
To: linuxram@us.ibm.com
CC: akpm@osdl.org, viro@parcelfarce.linux.theplanet.co.uk, mathurav@us.ibm.com,
       mike@waychison.com, janak@us.ibm.com, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org
In-reply-to: <1122770705.6956.23.camel@localhost> (message from Ram Pai on
	Sat, 30 Jul 2005 17:45:05 -0700)
Subject: Re: [PATCH 1/7] shared subtree
References: <20050725224417.501066000@localhost>
	 <20050725225907.007405000@localhost>
	 <E1DxrzJ-0001uo-00@dorka.pomaz.szeredi.hu>
	 <1122500344.5037.171.camel@localhost>
	 <E1Dy58Z-0002qL-00@dorka.pomaz.szeredi.hu>
	 <1122666893.4715.279.camel@localhost>
	 <E1Dyk4A-0006IL-00@dorka.pomaz.szeredi.hu> <1122770705.6956.23.camel@localhost>
Message-Id: <E1Dz8cx-0003AH-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Sun, 31 Jul 2005 09:52:55 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Ok. I have started implementing your idea. But the implementation is no
> simple.  Its becomes a complex mess. Atleast in the case of pnode
> datastructure implementation, the propogation was all abstracted and
> concentrated in the pnode datastructure. 
> 
> Here is a sample implementation of do_make_slave() with your idea. 
> 
> static int do_make_slave(struct vfsmount *mnt)
> {
>         int err=0;
>         struct vfsmount *peer_mnt;
> 
>         spin_lock(&vfspnode_lock);
>         if (!IS_MNT_SHARED(mnt)) {
>                 spin_unlock(&vfspnode_lock);
>                 err = -EINVAL;
>                 goto out;
>         }
> 
>         peer_mnt = list_entry(mnt->mnt_share.next, struct vfsmount,
> mnt_share);
>         if (peer_mnt == mnt)
>                 peer_mnt = NULL;
> 
>         list_del_init(&mnt->mnt_share);
>         if (peer_mnt) {
>                 /* move the slave list to the peer_mnt */
>                 list_splice(&mnt->mnt_slave, &peer_mnt->mnt_slave);
>                 list_add(&mnt->mnt_slave_list, &peer_mnt->mnt_slave);
>                 set_mnt_slave(mnt);
>         } else {
>                 struct vfsmount *slave_mnt, *t_slave_mnt;
>                 list_for_each_entry_safe(slave_mnt, t_slave_mnt,
>                                 &mnt->mnt_slave, mnt_slave_list) {
>                         CLEAR_MNT_SLAVE(slave_mnt);
>                         list_del_init(&slave_mnt->mnt_slave_list);
>                 }
>         }
>         list_del_init(&mnt->mnt_slave);
>         mnt->mnt_master = peer_mnt;
>         spin_unlock(&vfspnode_lock);
> out:
>         return err;
> }
> 
> Do you still believe that your idea is simpler? 

Well, you have bundled do_make_slave(), pnode_member_to_slave() and
empty_pnode() all into one function.  I think your original split is
quite nice.  If you'd split this function up like that, I think you'd
agree, that the end result is simpler.

Btw. though you don't have a pnode datastructure, that doesn't mean
you can't separate the shared subtree related functions into a
separate pnode.c (or whatever) file.  I think the do_make_* functions
also belong in there, not namespace.c.   

> The most difficult part is, attaching shared vfs tree, which needs
> to be attached at someother shared mount point. The problem here is
> while traversing the propogation tree, one has to build another
> similar propogation tree for the new child mount. Its a 2
> dimensional tree walk, i.e one walk is along the vfstree, and the
> other walk is along the pnode tree for each mount.  Its much easier
> to abstract out the pnode operations and concentrate on them
> separately than mixing the functionality of vfs and pnode in a
> single vfs datastructure.

I think you are bluring the distinction between two separate concepts:
"structure" and "function".

You can concentrate separate "structures" in a single object, without
having to mix the "functions".

The linux 'struct list' is a wonderful way to do this.

C++ inheritance is another (much less wonderful) way.

Mixing "functions" is bad.  Concentrating "structure" is good.

> In my code, I have abstracted out the pnode tree traversing operation
> using a single iterator function pnode_next().

Well, but the pnode traversing is only part of the problem.  In the
end you really need to traverse vfsmounts.  Pnodes are really just a
conceptual helper.  I think Al Viro didn't make that clear enough in
his RFC.

> Think about it, and let me know if it is worth the effort of changing
> the implementation. I sincerely feel it just shifts complexity instead
> of reducing complexity. I can eventually come up with a fully tested
> implementation using your idea, but I am still not convinced that
> it reduces complexity.

I really don't want to force it on you.  If you feel comfortable with
the current code, that's OK.  But keep in mind, that this is a central
part of the kernel, and so the code needs to be understood to the last
little detail, not just by you.  And doing that with >1000 new lines
of code is not an easy task.

So the less code (and less complexity) you are able to make this
functionality work, the easier it will be for others to understand and
accept it.

Miklos
