Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964875AbVHIQkh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964875AbVHIQkh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Aug 2005 12:40:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964878AbVHIQkg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Aug 2005 12:40:36 -0400
Received: from adsl-266.mirage.euroweb.hu ([193.226.239.10]:31495 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S964874AbVHIQkf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Aug 2005 12:40:35 -0400
To: trond.myklebust@fys.uio.no
CC: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
In-reply-to: <1123594460.8245.15.camel@lade.trondhjem.org> (message from Trond
	Myklebust on Tue, 09 Aug 2005 09:34:20 -0400)
Subject: Re: [RFC] atomic open(..., O_CREAT | ...)
References: <E1E2G68-0006H2-00@dorka.pomaz.szeredi.hu>
	 <1123541926.8249.8.camel@lade.trondhjem.org>
	 <E1E2OoL-0006xQ-00@dorka.pomaz.szeredi.hu> <1123594460.8245.15.camel@lade.trondhjem.org>
Message-Id: <E1E2X9A-0007Uk-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 09 Aug 2005 18:40:12 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Intents are meant as optimisations, not replacements for existing
> operations. I'm therefore not really comfortable about having them
> return errors at all.

In my case they are not an optimization, rather the only way to
correctly perform an open with O_CREAT.

> > > +		nd->intent.open.file = NULL;
> > 
> > Why is this NULL assignment needed?  nd will not be used after this.
> > 
> > > +	}
> > > +	path_release(nd);
> > > +}
> > > +
> > > 
> 
> It could be dropped. The reason for putting it in is that some parts of
> the VFS may restart a path walk operation if it fails (see for instance
> the ESTALE handling).

If you use the nameidata after path_release_open_intent(), you're
screwed anyway, since nd->mnt and nd->dentry have already been
released.

If there's any chance that the path walk restart thing will invoke the
filesystems open code twice (I doubt it), then the filesystem must
make sure to check intent.open.file, whether it has already been set,
and fput() it before setting it another time.

> Why do we want to keep this behaviour? It is undocumented, it is
> non-posix, and it appears to do nothing you cannot do with the existing
> access() call.
> 
> Are there any applications using it? If so, which ones, and why?

I have absolutely no idea. 

Looking closer, there's a problem with O_TRUNC as well:

	namei_flags = flags;
	if ((namei_flags+1) & O_ACCMODE)
		namei_flags++;
	if (namei_flags & O_TRUNC)
		namei_flags |= 2;

So if flags is O_RDONLY|O_TRUNC, intent.open.flags will be
FMODE_WRITE|FMODE_READ|O_TRUNC, but filp->f_mode will be FMODE_READ.

This is also undocumented (or rather documented to be undefined), but
the behavior is perfectly logical, and I can imagine some application
relying on it.

Miklos


