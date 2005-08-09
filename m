Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964899AbVHIRS3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964899AbVHIRS3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Aug 2005 13:18:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964898AbVHIRS3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Aug 2005 13:18:29 -0400
Received: from pat.uio.no ([129.240.130.16]:26257 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S964896AbVHIRS2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Aug 2005 13:18:28 -0400
Subject: Re: [RFC] atomic open(..., O_CREAT | ...)
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
In-Reply-To: <E1E2X9A-0007Uk-00@dorka.pomaz.szeredi.hu>
References: <E1E2G68-0006H2-00@dorka.pomaz.szeredi.hu>
	 <1123541926.8249.8.camel@lade.trondhjem.org>
	 <E1E2OoL-0006xQ-00@dorka.pomaz.szeredi.hu>
	 <1123594460.8245.15.camel@lade.trondhjem.org>
	 <E1E2X9A-0007Uk-00@dorka.pomaz.szeredi.hu>
Content-Type: text/plain
Date: Tue, 09 Aug 2005 13:18:08 -0400
Message-Id: <1123607889.8245.107.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-4.048, required 12,
	autolearn=disabled, AWL 0.77, FORGED_RCVD_HELO 0.05,
	RCVD_IN_SORBS_DUL 0.14, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ty den 09.08.2005 Klokka 18:40 (+0200) skreiv Miklos Szeredi:
> > Intents are meant as optimisations, not replacements for existing
> > operations. I'm therefore not really comfortable about having them
> > return errors at all.
> 
> In my case they are not an optimization, rather the only way to
> correctly perform an open with O_CREAT.

How so? In NFS the only case that can be tricky is O_EXCL, and that
simply _cannot_ be done inside nfs_lookup without confusing the VFS. 
Instead, we always create a negative dentry, and then do the actual
atomic exclusive create inside vfs_create().

We can do the ordinary atomic open(O_CREAT) inside nfs_lookup though. If
that fails, then we simply return the error as an ERR_PTR in the dentry
(i.e. the lookup won't succeed).

The only case which we have that can be iffy is the case of open() on an
existing dentry. If that fails, then we drop the dentry and force an
uncached lookup in order to get it all right.

> > > > +		nd->intent.open.file = NULL;
> > > 
> > > Why is this NULL assignment needed?  nd will not be used after this.
> > > 
> > > > +	}
> > > > +	path_release(nd);
> > > > +}
> > > > +
> > > > 
> > 
> > It could be dropped. The reason for putting it in is that some parts of
> > the VFS may restart a path walk operation if it fails (see for instance
> > the ESTALE handling).
> 
> If you use the nameidata after path_release_open_intent(), you're
> screwed anyway, since nd->mnt and nd->dentry have already been
> released.

There is quite a bit of code out there that assumes it is free to stuff
things into nd->mnt and nd->dentry. Some of it is Al Viro's code, some
of it is from other people.
For instance, the ESTALE handling will just save nd->mnt/nd->dentry
before calling __link_path_walk(), then restore + retry if the ESTALE
error comes up.

> If there's any chance that the path walk restart thing will invoke the
> filesystems open code twice (I doubt it), then the filesystem must
> make sure to check intent.open.file, whether it has already been set,
> and fput() it before setting it another time.

The only user of that code is NFSv4, and we will never even try to
allocate a file if the OPEN call returned an ESTALE.

> > Why do we want to keep this behaviour? It is undocumented, it is
> > non-posix, and it appears to do nothing you cannot do with the existing
> > access() call.
> > 
> > Are there any applications using it? If so, which ones, and why?
> 
> I have absolutely no idea. 
> 
> Looking closer, there's a problem with O_TRUNC as well:
> 
> 	namei_flags = flags;
> 	if ((namei_flags+1) & O_ACCMODE)
> 		namei_flags++;
> 	if (namei_flags & O_TRUNC)
> 		namei_flags |= 2;
> 
> So if flags is O_RDONLY|O_TRUNC, intent.open.flags will be
> FMODE_WRITE|FMODE_READ|O_TRUNC, but filp->f_mode will be FMODE_READ.

That is a bug that needs to be fixed in the intent.open.flags. We don't
ever want to be opening the file for writing at the filesystem level
when the user specified open for read.

Cheers,
  Trond

