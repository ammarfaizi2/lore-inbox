Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261669AbUCPNop (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 08:44:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261653AbUCPNop
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 08:44:45 -0500
Received: from kempelen.iit.bme.hu ([152.66.241.120]:35475 "EHLO
	kempelen.iit.bme.hu") by vger.kernel.org with ESMTP id S261669AbUCPNon
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 08:44:43 -0500
Date: Tue, 16 Mar 2004 14:43:54 +0100 (MET)
Message-Id: <200403161343.i2GDhsV12878@kempelen.iit.bme.hu>
From: Miklos Szeredi <mszeredi@inf.bme.hu>
To: serue@us.ibm.com
CC: linux-kernel@vger.kernel.org
In-reply-to: <20040315214207.GA26615@escher.cs.wm.edu> (serue@us.ibm.com)
Subject: Re: unionfs
References: <200403080952.i289qsU12658@kempelen.iit.bme.hu> <20040311151343.GA943@escher.cs.wm.edu> <200403111544.i2BFi7O06675@kempelen.iit.bme.hu> <20040315214207.GA26615@escher.cs.wm.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I was just re-reading the linux-fsdevel archives from june of 2000.
> I'm guessing the reason you're not getting a response from Al is that
> he never did unionfs.  He did union mounts, and made clear that they
> are not related.  Union mounts would only work at the top level, the
> union would not recurse down the (union-)mounted trees.

(Reading that thread...)

OK, now I understand better.  Although I can't find any code/patch for
union mount either.

> Performance-wise this could become very, very slow very quickly, but
> if we replace the vfsmount which is found by using
> mount_hashtable + hash(vfsmnt, dentry) to find what is mounted on top
> of a particular dentry with a vfsmount_stackable struct, which contains,
> say,
> 
> struct vfsmount_stackable {
> 	  struct vfsmount *vfsmnt;
> 	  int mount_flags;  /* 1 = read, 2 = write, 3 = hide */
> 	  struct vfsmount_stackable *next;
> };
> 
> then perhaps it might be reasonably simple to have __follow_down and
> follow_mount make use of this structure.  We make sure to keep the
> vfsmount_stackable list in order mounted priority, so that when we
> come to one of these lists, we can just do something like
> 
> while (vfsmount_stacked) {
> 	  ret = stacked_lookup(vfsmount_stacked->vfsmnt, vfsmnt_stacked->dentry,
> 			  remaining_pathname);
> 	  if (ret)
> 		  return ret;
> 	  vfsmnt_stacked = vfsmnt_stacked->next;
> }
> 
> return NULL;
> 
> Thoughts?

Yes, this sounds like a good way to implement a unionfs-like
functionality.  Something a bit more general would be to have a
path_walk(const char *remaining_path, struct nameidata *nd) operation
of vfsmount, which if non-null would be used to perform the rest of
the lookup.  This could then perform the looped lookup trials you
describe, but could be used for other special lookup methods.

Thanks for your comments,
Miklos

