Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261421AbVEPH0p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261421AbVEPH0p (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 May 2005 03:26:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261234AbVEPH0o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 May 2005 03:26:44 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:10119 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261423AbVEPHL2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 May 2005 03:11:28 -0400
Subject: Re: [PATCH] namespace.c: fix bind mount from foreign namespace
From: Ram <linuxram@us.ibm.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: viro@parcelfarce.linux.theplanet.co.uk, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
In-Reply-To: <E1DWprs-0005D1-00@dorka.pomaz.szeredi.hu>
References: <E1DWXeF-00017l-00@dorka.pomaz.szeredi.hu>
	 <20050513170602.GI1150@parcelfarce.linux.theplanet.co.uk>
	 <E1DWdn9-0004O2-00@dorka.pomaz.szeredi.hu>
	 <1116005355.6248.372.camel@localhost>
	 <E1DWf54-0004Z8-00@dorka.pomaz.szeredi.hu>
	 <1116012287.6248.410.camel@localhost>
	 <E1DWfqJ-0004eP-00@dorka.pomaz.szeredi.hu>
	 <1116013840.6248.429.camel@localhost>
	 <E1DWprs-0005D1-00@dorka.pomaz.szeredi.hu>
Content-Type: text/plain
Organization: IBM 
Message-Id: <1116256279.4154.41.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 16 May 2005 08:11:19 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-05-13 at 23:11, Miklos Szeredi wrote:
> (CC restored, because I think this is interesting to others as well)
> 
> > > > I dont get it...
> > > > 
> > > > do you agree that bind mounts accross namespaces should be disallowed?
> > > 
> > > No.  I think it's a useful feature.  It's actually been discussed at
> > > length earlier, that it makes sense if the user can copy private
> > > mounts from one session to the other (or even automate this with pam,
> > > and a daemon).  Why should they be disallowed?
> > 
> > I understand that feature and the way to do it is through shared
> > subtrees.  
> 
> I agree fully, that shared subtrees would be very useful.
> 
> > I am against a mount in one namespace being bind mounted in
> > another namespace(which Al Viro has implied in his mail). 
> 
> I'd rather not speculate on what Al Viro was thinking, it may have
> been just a misunderstanding.

Can somebody who know internals of Al Viro's thinking help here?


> 
> > With shared subtree if a bind mount is done
> > in one namespace, the bind happens within the same namespace.
> 
> Yes.  But that's not fundamentally different from explicitly passing a
> mount (through a file descriptor) to a process in a different
> namespace, and allowing that process to bind mount it in it's native
> namespace.
> 
> The end result can be exactly the same, only in the shared subtree
> case the binding is implicit, while in the other case it's explicit on
> both sides (which makes it perfectly secure even for unprivileged use)
> 
> Please explain why you think it's wrong to be able to bind mount from
> a different namespace?


If It is allowed, the concept of namespaces itself becomes
nebulous.  one could bind mount the root vfsmount of all the other
namespace in their own namespace and then it all becomes one big tree
with all the other namespaces as a subtree.

why would we need this feature? what extra advantage would this feature
provide us? Is the advantage of this feature already discussed in this
thread? (maybe i missed it).


> 
> > 
> > However the operation is mirrored to other namespaces
> > that has the same heridity link to this namespace.
> > 
> > probably I can give an example:
> > 
> > if namespace  n1 has the following tree
> >                    v11
> >                   /  \
> >                  v12  v13
> > 
> > v1 is mark shared. (mount --make-shared v1) [ for simplicity I vxy
> > means  yth vfsmount in xth namespace ]
> > 
> > and than n2 is cloned out of n1, than in n2 we have 
> >                       v21
> >                       / \
> >                     v22  v23
> > 
> > now a bind mount in n1 
> >          mount --bind v12 v13
> > 
> >    will first change the tree in n1 as follows:
> > 
> >                  v11
> >                 /   \
> >               v12   v13
> >                       \
> >                       v14
> > where v14 is a bind mount of v12
> > 
> > 
> >   and than due to propogation the tree in n2 will also change to
> >                     v21
> >                    /   \
> >                   v22   v23
> >                           \
> >                           v24
> >   where v24 is a bind mount of v22
> > 
> > 
> > Essentially there is no cross-contamination, as well as it meets
> > the requirement of per-user-namespace.
> 
> What do you mean by cross contamination?

A vfsmount in one namespace bound to a mountpoint in another 
namespace.

RP



> 
> Thanks,
> Miklos

