Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263411AbTEIS5V (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 May 2003 14:57:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263415AbTEIS5V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 May 2003 14:57:21 -0400
Received: from MEREDITH.DEMENTIA.ORG ([128.2.120.216]:26889 "EHLO
	meredith.dementia.org") by vger.kernel.org with ESMTP
	id S263411AbTEIS5S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 May 2003 14:57:18 -0400
Date: Fri, 9 May 2003 15:09:51 -0400 (EDT)
From: Derrick J Brashear <shadow@dementia.org>
X-X-Sender: shadow@johnstown.andrew.cmu.edu
To: David Howells <dhowells@redhat.com>
cc: openafs-devel@openafs.org, linux-kernel@vger.kernel.org
Subject: Re: Adding an "acceptable" interface to the Linux kernel for AFS 
In-Reply-To: <525.1052502033@warthog.warthog>
Message-ID: <Pine.GSO.4.55L-032.0305091456240.736@johnstown.andrew.cmu.edu>
References: <525.1052502033@warthog.warthog>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 9 May 2003, David Howells wrote:

>
> > > I'm wondering how attached OpenAFS is to this interface? Can OpenAFS be
> > > altered to use the following access points instead:
> >
> > Generally I think this interface will work.
>
> It would be nice, though, not to have to worry about differentiating between
> pioctls that take a path and those that don't inside of the core kernel.

I think it may be safe to not deal with them and assume some other
interface (sysctl or something appropriate) will be used.

> > >  (1) setpag(pag_t pag)
> >
> > If you don't specify a pag it should allocate you one, and for
> > non-priviledged users this should be the only allowed mode.
>
> Thinking about it, this shouldn't take an argument at all, and should just put
> its caller into a completely new PAG with a unique ID.

There are valid reasons to allow a PAG to be specified, but only with
priviledge. e.g. user mode protocol translator (afs to nfs)

> "I" being the calling process? That can be done. I could just define that it
> is permissible for the PAG pointer to be NULL. This makes support for the init
> process easier, as I don't have to compile in a PAG for it.

Yes, I as the caller.

> > Currently it's possible to set a token when you have no pag, and these
> > become associated with the uid that set them. (The pag number is not the uid;
> > Instead any process without a pag but with a uid that has tokens associated
> > with it gets those tokens.) As long as the above don't bind tightly to a pag,
> > sure.
>
> So you'd have a list of tokens associated with the user too?

A uid could have tokens associated with it. They'd get used only for
PAGless processes running as that uid. Join a PAG and they stop being
visible to you (the caller)


> I suppose I could give both the PAG and the user lists, and search the PAG
> first, then the user, but what detemines the user? The PAG, the opener of a
> file or the current process?

The uid of the current process. Again, if you're in a PAG you don't get
uid tokens. You could create 2 PAG number spaces, 1 using uid
and one sequential alloc, but then you need more management I guess (or to
assume kernel code will be able to provide hooks for accepting tokens
regardless of PAG and just let people who care deal in their code)


> > As to pioctl, will it be able to handle things where path cannot be stat'd
> > in advance? For instance, the prefetching hint (VIOCPREFETCH), if you
> > could stat it, it wouldn't be a prefetch. Another concern there would be
> > dangling mount points (a mount point you still have to a volume that's
> > been deleted) when calling VIOC_AFS_DELETE_MT_PT or VIOC_AFS_STAT_MT_PT.
>
> The latter pair of pioctls you've mentioned both require the directory holding
> the mount point to be locally available as a kernel inode, and both of them
> require the path to that directory to be supplied as the path argument to
> pioctl rather than the path of the mountpoint, so I don't see that there'd be
> a problem there.
>
> I don't have documentation on VIOCPREFETCH, but if it's anything like the
> other two, then it shouldn't be a problem either.

Takes a path to attempt to prefetch as a text string.


