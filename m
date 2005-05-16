Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261482AbVEPItX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261482AbVEPItX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 May 2005 04:49:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261467AbVEPIrL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 May 2005 04:47:11 -0400
Received: from rev.193.226.232.93.euroweb.hu ([193.226.232.93]:26381 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S261405AbVEPIpX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 May 2005 04:45:23 -0400
To: linuxram@us.ibm.com
CC: viro@parcelfarce.linux.theplanet.co.uk, akpm@osdl.org,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
In-reply-to: <1116256279.4154.41.camel@localhost> (message from Ram on Mon, 16
	May 2005 08:11:19 -0700)
Subject: Re: [PATCH] namespace.c: fix bind mount from foreign namespace
References: <E1DWXeF-00017l-00@dorka.pomaz.szeredi.hu>
	 <20050513170602.GI1150@parcelfarce.linux.theplanet.co.uk>
	 <E1DWdn9-0004O2-00@dorka.pomaz.szeredi.hu>
	 <1116005355.6248.372.camel@localhost>
	 <E1DWf54-0004Z8-00@dorka.pomaz.szeredi.hu>
	 <1116012287.6248.410.camel@localhost>
	 <E1DWfqJ-0004eP-00@dorka.pomaz.szeredi.hu>
	 <1116013840.6248.429.camel@localhost>
	 <E1DWprs-0005D1-00@dorka.pomaz.szeredi.hu> <1116256279.4154.41.camel@localhost>
Message-Id: <E1DXbD5-0007UI-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 16 May 2005 10:44:23 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Can somebody who know internals of Al Viro's thinking help here?

There's only one person... :)

> > Please explain why you think it's wrong to be able to bind mount from
> > a different namespace?
> 
> 
> If It is allowed, the concept of namespaces itself becomes
> nebulous.  one could bind mount the root vfsmount of all the other
> namespace in their own namespace and then it all becomes one big tree
> with all the other namespaces as a subtree.

1) you need not recursively bind the whole tree of the private
   namespace.  In fact you can only do that by hand, since the kernel
   won't do it (!recurse || check_mnt(old_nd.mnt) in do_loopback).

2) you won't see changes made in other namespace, they are still
   separate, they are just sharing some filesystems, just as after
   clone, or just as after propagation within a shared subtree.

3) this is not automatic, so no filesystems in the other namespace are
   visible unless there's an explicit action by processes both in the
   originating namespace and the destination namespace.

4) in fact, the process in the originating namespace can single out a
   mount and just send a file descriptor refering to that mount
   (e.g. by binding it to a temporary directory, opening the root,
   detaching from the mountpoint, and then sending the file descriptor
   to the receiving process).  This way the receiving process will see
   no other mounts in the originating namespace, and can only bind
   from that single mount.

> why would we need this feature? what extra advantage would this feature
> provide us? Is the advantage of this feature already discussed in this
> thread? (maybe i missed it).

http://lkml.org/lkml/2005/4/25/47

It was suggested as a way of sharing mounts between sessions (as
opposed to shared subtrees, which shares mounts between parent/child
process).

I'm not saying that that this is the way to do it.  But it does seem
to me a useful feature.

And since it doesn't add _any_ complexity to the kernel, I think it
would be rather stupid to remove it.

> > What do you mean by cross contamination?
> 
> A vfsmount in one namespace bound to a mountpoint in another 
> namespace.

A vfsmount can only be in a single namespace at a time, since each
mount tree is rooted in a single namespace.  So what you are saying is
impossible.

This feature is about binding a mount (copying a vfsmount in
clone_mnt()), which happens to be in a different namespace.  After the
vfsmount is cloned, and is attached to the process's native namespace
it's in that namespace solely.

The bug being discussed, is an administrative error, of setting
mnt_namespace to the wrong value, which causes the mount to be
un-removable.  So there was never a question of "cross contamination".

Miklos
