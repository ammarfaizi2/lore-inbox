Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262479AbVESMyj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262479AbVESMyj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 May 2005 08:54:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262489AbVESMyj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 May 2005 08:54:39 -0400
Received: from rev.193.226.233.9.euroweb.hu ([193.226.233.9]:53261 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S262479AbVESMyD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 May 2005 08:54:03 -0400
To: linuxram@us.ibm.com
CC: miklos@szeredi.hu, dhowells@redhat.com, jamie@shareable.org,
       viro@parcelfarce.linux.theplanet.co.uk, akpm@osdl.org,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
In-reply-to: <1116448514.24560.209.camel@localhost> (message from Ram on Wed,
	18 May 2005 13:35:15 -0700)
Subject: Re: [PATCH] fix race in mark_mounts_for_expiry()
References: <E1DYMVf-0000hD-00@dorka.pomaz.szeredi.hu>
	 <E1DYMB6-0000dw-00@dorka.pomaz.szeredi.hu>
	 <E1DYLvb-0000as-00@dorka.pomaz.szeredi.hu>
	 <E1DYLCv-0000W7-00@dorka.pomaz.szeredi.hu>
	 <1116005355.6248.372.camel@localhost>
	 <E1DWf54-0004Z8-00@dorka.pomaz.szeredi.hu>
	 <1116012287.6248.410.camel@localhost>
	 <E1DWfqJ-0004eP-00@dorka.pomaz.szeredi.hu>
	 <1116013840.6248.429.camel@localhost>
	 <E1DWprs-0005D1-00@dorka.pomaz.szeredi.hu>
	 <1116256279.4154.41.camel@localhost>
	 <20050516111408.GA21145@mail.shareable.org>
	 <1116301843.4154.88.camel@localhost>
	 <E1DXm08-0006XD-00@dorka.pomaz.szeredi.hu>
	 <20050517012854.GC32226@mail.shareable.org>
	 <E1DXuiu-0007Mj-00@dorka.pomaz.szeredi.hu>
	 <1116360352.24560.85.camel@localhost>
	 <E1DYI0m-0000K5-00@dorka.pomaz.szeredi.hu>
	 <1116399887.24560.116.camel@localhost>
	 <1116400118.24560.119.camel@localhost> <6865.1116412354@redhat.com>
	 <7230.1116413175@redhat.com> <8247.1116413990@redhat.com>
	 <9498.1116417099@redhat.com> <E1DYNLt-0000nu-00@dorka.pomaz.szeredi! .hu>
	 <E1DYNjR-0000po-00@dorka.pomaz.szeredi.hu>
	 <E1DYRnw-0001J6-00@dorka.pomaz.szeredi.hu>
	 <1116442073.24560.142.camel@localhost>
	 <E1DYU4Z-0001U5-00@dorka.pomaz.szeredi.hu> <1116448514.24560.209.camel@localhost>
Message-Id: <E1DYkWA-0002Jl-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 19 May 2005 14:52:50 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Ok. One more attempt to be clear.
> 
> All the places where get_namespace() is called currently except
> in mark_mounts_for_expiry() are safe because they are called in
> places where it is guaranteed that they will not race with 
> __put_namespace(). 
> 
> For example in clone_namespace(), get_namespace() will not race
> because the task that called the clone has a refcount on the
> namespace and since that task is currently  in the kernel, there is
> no chance for  the task  to go away  decrementing the refcount 
> on that namespace. 
> 
> But the case where the call to get_namespace() is buggy in 
> mark_mounts_for_expiry() is because:
> it is called in a timer context, and the last process referring
> the namespace may just disapper right than.  
>  So what I am proposing is:
> in automouter, while the automount takes place in 
> afs_mntpt_follow_link() increment the refcount of the namespace,
> by calling get_namespace(). This call will not race with __put_namespace
> because the process that is trying to access the
> mountpoint already has a refcount on the namespace and it won't be 
> able to decrement the refcount currently. agree?
> 
> Now later when the automounter tries to unmount the mount 
> call put_namespace() after unmounting. I mean do it in
> mark_mounts_for_expiry(). Also delete the call to get_namespace()) 
> 
> So the race will not happen at all.
> 
> Makes sense? 

Well I imagine it could work, but again it's just a special case for
the automounter stuff.

It still won't solve the recursive mount problem that this discussion
(and your discovery of the race) originated from.

My second patch solves the problem generally (though I'm sure that
it's full of bugs yet), by keeping a reference to the namespace from
each vfsmount in that namespace.  That way, until the vfsmount remains
in the namespace (i.e. until it's unmounted) mnt_namespace can be
safely used for whatever reason (recursive bind, atomount, etc).

So why does it make sense to solve this problem only for the
automounter?

Miklos
