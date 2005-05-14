Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262557AbVENGMj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262557AbVENGMj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 May 2005 02:12:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262598AbVENGMj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 May 2005 02:12:39 -0400
Received: from rev.193.226.232.93.euroweb.hu ([193.226.232.93]:25610 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S262557AbVENGM0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 May 2005 02:12:26 -0400
To: linuxram@us.ibm.com
CC: viro@parcelfarce.linux.theplanet.co.uk, akpm@osdl.org,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
In-reply-to: <1116013840.6248.429.camel@localhost> (message from Ram on Fri,
	13 May 2005 12:50:40 -0700)
Subject: Re: [PATCH] namespace.c: fix bind mount from foreign namespace
References: <E1DWXeF-00017l-00@dorka.pomaz.szeredi.hu>
	 <20050513170602.GI1150@parcelfarce.linux.theplanet.co.uk>
	 <E1DWdn9-0004O2-00@dorka.pomaz.szeredi.hu>
	 <1116005355.6248.372.camel@localhost>
	 <E1DWf54-0004Z8-00@dorka.pomaz.szeredi.hu>
	 <1116012287.6248.410.camel@localhost>
	 <E1DWfqJ-0004eP-00@dorka.pomaz.szeredi.hu> <1116013840.6248.429.camel@localhost>
Message-Id: <E1DWprs-0005D1-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Sat, 14 May 2005 08:11:20 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(CC restored, because I think this is interesting to others as well)

> > > I dont get it...
> > > 
> > > do you agree that bind mounts accross namespaces should be disallowed?
> > 
> > No.  I think it's a useful feature.  It's actually been discussed at
> > length earlier, that it makes sense if the user can copy private
> > mounts from one session to the other (or even automate this with pam,
> > and a daemon).  Why should they be disallowed?
> 
> I understand that feature and the way to do it is through shared
> subtrees.  

I agree fully, that shared subtrees would be very useful.

> I am against a mount in one namespace being bind mounted in
> another namespace(which Al Viro has implied in his mail). 

I'd rather not speculate on what Al Viro was thinking, it may have
been just a misunderstanding.

> With shared subtree if a bind mount is done
> in one namespace, the bind happens within the same namespace.

Yes.  But that's not fundamentally different from explicitly passing a
mount (through a file descriptor) to a process in a different
namespace, and allowing that process to bind mount it in it's native
namespace.

The end result can be exactly the same, only in the shared subtree
case the binding is implicit, while in the other case it's explicit on
both sides (which makes it perfectly secure even for unprivileged use)

Please explain why you think it's wrong to be able to bind mount from
a different namespace?

> 
> However the operation is mirrored to other namespaces
> that has the same heridity link to this namespace.
> 
> probably I can give an example:
> 
> if namespace  n1 has the following tree
>                    v11
>                   /  \
>                  v12  v13
> 
> v1 is mark shared. (mount --make-shared v1) [ for simplicity I vxy
> means  yth vfsmount in xth namespace ]
> 
> and than n2 is cloned out of n1, than in n2 we have 
>                       v21
>                       / \
>                     v22  v23
> 
> now a bind mount in n1 
>          mount --bind v12 v13
> 
>    will first change the tree in n1 as follows:
> 
>                  v11
>                 /   \
>               v12   v13
>                       \
>                       v14
> where v14 is a bind mount of v12
> 
> 
>   and than due to propogation the tree in n2 will also change to
>                     v21
>                    /   \
>                   v22   v23
>                           \
>                           v24
>   where v24 is a bind mount of v22
> 
> 
> Essentially there is no cross-contamination, as well as it meets
> the requirement of per-user-namespace.

What do you mean by cross contamination?

Thanks,
Miklos
