Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964888AbVHIRo2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964888AbVHIRo2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Aug 2005 13:44:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932559AbVHIRo2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Aug 2005 13:44:28 -0400
Received: from adsl-266.mirage.euroweb.hu ([193.226.239.10]:49156 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S932557AbVHIRo1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Aug 2005 13:44:27 -0400
To: trond.myklebust@fys.uio.no
CC: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
In-reply-to: <1123607889.8245.107.camel@lade.trondhjem.org> (message from
	Trond Myklebust on Tue, 09 Aug 2005 13:18:08 -0400)
Subject: Re: [RFC] atomic open(..., O_CREAT | ...)
References: <E1E2G68-0006H2-00@dorka.pomaz.szeredi.hu>
	 <1123541926.8249.8.camel@lade.trondhjem.org>
	 <E1E2OoL-0006xQ-00@dorka.pomaz.szeredi.hu>
	 <1123594460.8245.15.camel@lade.trondhjem.org>
	 <E1E2X9A-0007Uk-00@dorka.pomaz.szeredi.hu> <1123607889.8245.107.camel@lade.trondhjem.org>
Message-Id: <E1E2Y92-0007Zv-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 09 Aug 2005 19:44:08 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > > > +		nd->intent.open.file = NULL;
> > > > 
> > > > Why is this NULL assignment needed?  nd will not be used after this.
> > > > 
> > > > > +	}
> > > > > +	path_release(nd);
> > > > > +}
> > > > > +
> > > > > 
> > > 
> > > It could be dropped. The reason for putting it in is that some parts of
> > > the VFS may restart a path walk operation if it fails (see for instance
> > > the ESTALE handling).
> > 
> > If you use the nameidata after path_release_open_intent(), you're
> > screwed anyway, since nd->mnt and nd->dentry have already been
> > released.
> 
> There is quite a bit of code out there that assumes it is free to stuff
> things into nd->mnt and nd->dentry. Some of it is Al Viro's code, some
> of it is from other people.
> For instance, the ESTALE handling will just save nd->mnt/nd->dentry
> before calling __link_path_walk(), then restore + retry if the ESTALE
> error comes up.

Yeah, but how is that relevant to the fact, that after
path_release_*() _nothing_ will be valid in the nameidata, not
nd->mnt, not nd->dentry, and not nd->intent.open.file.  So what's the
point in setting it to NULL if it must never be used anyway?

> > If there's any chance that the path walk restart thing will invoke the
> > filesystems open code twice (I doubt it), then the filesystem must
> > make sure to check intent.open.file, whether it has already been set,
> > and fput() it before setting it another time.
> 
> The only user of that code is NFSv4, and we will never even try to
> allocate a file if the OPEN call returned an ESTALE.

That's why I doubted that this is an issue.

> > > Why do we want to keep this behaviour? It is undocumented, it is
> > > non-posix, and it appears to do nothing you cannot do with the existing
> > > access() call.
> > > 
> > > Are there any applications using it? If so, which ones, and why?
> > 
> > I have absolutely no idea. 
> > 
> > Looking closer, there's a problem with O_TRUNC as well:
> > 
> > 	namei_flags = flags;
> > 	if ((namei_flags+1) & O_ACCMODE)
> > 		namei_flags++;
> > 	if (namei_flags & O_TRUNC)
> > 		namei_flags |= 2;
> > 
> > So if flags is O_RDONLY|O_TRUNC, intent.open.flags will be
> > FMODE_WRITE|FMODE_READ|O_TRUNC, but filp->f_mode will be FMODE_READ.
> 
> That is a bug that needs to be fixed in the intent.open.flags. We don't
> ever want to be opening the file for writing at the filesystem level
> when the user specified open for read.

No, it's being opened for read.  The namei_flags (and hence
intent.open.flags) will have FMODE_WRITE, so that the permission is
checked for write.

So I thing the bug is not in the calculation of namei_flags, rather
the fact that intent.open.flags is set to namei_flags, rather than the
original open flags.  

Miklos


