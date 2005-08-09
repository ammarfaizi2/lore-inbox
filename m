Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750792AbVHISjI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750792AbVHISjI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Aug 2005 14:39:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750812AbVHISjI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Aug 2005 14:39:08 -0400
Received: from pat.uio.no ([129.240.130.16]:33767 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S1750792AbVHISjG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Aug 2005 14:39:06 -0400
Subject: Re: [RFC] atomic open(..., O_CREAT | ...)
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
In-Reply-To: <E1E2Y92-0007Zv-00@dorka.pomaz.szeredi.hu>
References: <E1E2G68-0006H2-00@dorka.pomaz.szeredi.hu>
	 <1123541926.8249.8.camel@lade.trondhjem.org>
	 <E1E2OoL-0006xQ-00@dorka.pomaz.szeredi.hu>
	 <1123594460.8245.15.camel@lade.trondhjem.org>
	 <E1E2X9A-0007Uk-00@dorka.pomaz.szeredi.hu>
	 <1123607889.8245.107.camel@lade.trondhjem.org>
	 <E1E2Y92-0007Zv-00@dorka.pomaz.szeredi.hu>
Content-Type: text/plain
Date: Tue, 09 Aug 2005 14:38:54 -0400
Message-Id: <1123612734.8245.150.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-2.49, required 12,
	autolearn=disabled, AWL 2.32, FORGED_RCVD_HELO 0.05,
	RCVD_IN_SORBS_DUL 0.14, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ty den 09.08.2005 Klokka 19:44 (+0200) skreiv Miklos Szeredi:

> > There is quite a bit of code out there that assumes it is free to stuff
> > things into nd->mnt and nd->dentry. Some of it is Al Viro's code, some
> > of it is from other people.
> > For instance, the ESTALE handling will just save nd->mnt/nd->dentry
> > before calling __link_path_walk(), then restore + retry if the ESTALE
> > error comes up.
> 
> Yeah, but how is that relevant to the fact, that after
> path_release_*() _nothing_ will be valid in the nameidata, not
> nd->mnt, not nd->dentry, and not nd->intent.open.file.  So what's the
> point in setting it to NULL if it must never be used anyway?

path_release() does _not_ invalidate the nameidata. Look for instance at
__emul_lookup_dentry(), which clearly makes use of that fact.

> > > If there's any chance that the path walk restart thing will invoke the
> > > filesystems open code twice (I doubt it), then the filesystem must
> > > make sure to check intent.open.file, whether it has already been set,
> > > and fput() it before setting it another time.
> > 
> > The only user of that code is NFSv4, and we will never even try to
> > allocate a file if the OPEN call returned an ESTALE.
> 
> That's why I doubted that this is an issue.
> 
> > > > Why do we want to keep this behaviour? It is undocumented, it is
> > > > non-posix, and it appears to do nothing you cannot do with the existing
> > > > access() call.
> > > > 
> > > > Are there any applications using it? If so, which ones, and why?
> > > 
> > > I have absolutely no idea. 
> > > 
> > > Looking closer, there's a problem with O_TRUNC as well:
> > > 
> > > 	namei_flags = flags;
> > > 	if ((namei_flags+1) & O_ACCMODE)
> > > 		namei_flags++;
> > > 	if (namei_flags & O_TRUNC)
> > > 		namei_flags |= 2;
> > > 
> > > So if flags is O_RDONLY|O_TRUNC, intent.open.flags will be
> > > FMODE_WRITE|FMODE_READ|O_TRUNC, but filp->f_mode will be FMODE_READ.
> > 
> > That is a bug that needs to be fixed in the intent.open.flags. We don't
> > ever want to be opening the file for writing at the filesystem level
> > when the user specified open for read.
> 
> No, it's being opened for read.  The namei_flags (and hence
> intent.open.flags) will have FMODE_WRITE, so that the permission is
> checked for write.

Firstly, the open_namei() flags field is not a "permissions" field. It
contains open mode information. The calculation of the open permissions
flags is done by open_namei() itself.

Secondly, what advantage is there in allowing callers of open_namei() to
be able to override the MAY_WRITE check when doing open(O_TRUNC)? This
is a calculation that should be done _once_ in order to always get it
right, and it should therefore be done in open_namei() together with the
rest of the permissions calculation.

Cheers,
  Trond

