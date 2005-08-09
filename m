Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964951AbVHIUnR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964951AbVHIUnR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Aug 2005 16:43:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964949AbVHIUnR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Aug 2005 16:43:17 -0400
Received: from adsl-266.mirage.euroweb.hu ([193.226.239.10]:25351 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S964948AbVHIUnQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Aug 2005 16:43:16 -0400
To: trond.myklebust@fys.uio.no
CC: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
In-reply-to: <1123612734.8245.150.camel@lade.trondhjem.org> (message from
	Trond Myklebust on Tue, 09 Aug 2005 14:38:54 -0400)
Subject: Re: [RFC] atomic open(..., O_CREAT | ...)
References: <E1E2G68-0006H2-00@dorka.pomaz.szeredi.hu>
	 <1123541926.8249.8.camel@lade.trondhjem.org>
	 <E1E2OoL-0006xQ-00@dorka.pomaz.szeredi.hu>
	 <1123594460.8245.15.camel@lade.trondhjem.org>
	 <E1E2X9A-0007Uk-00@dorka.pomaz.szeredi.hu>
	 <1123607889.8245.107.camel@lade.trondhjem.org>
	 <E1E2Y92-0007Zv-00@dorka.pomaz.szeredi.hu> <1123612734.8245.150.camel@lade.trondhjem.org>
Message-Id: <E1E2aw6-0007oY-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 09 Aug 2005 22:42:58 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > There is quite a bit of code out there that assumes it is free to stuff
> > > things into nd->mnt and nd->dentry. Some of it is Al Viro's code, some
> > > of it is from other people.
> > > For instance, the ESTALE handling will just save nd->mnt/nd->dentry
> > > before calling __link_path_walk(), then restore + retry if the ESTALE
> > > error comes up.
> > 
> > Yeah, but how is that relevant to the fact, that after
> > path_release_*() _nothing_ will be valid in the nameidata, not
> > nd->mnt, not nd->dentry, and not nd->intent.open.file.  So what's the
> > point in setting it to NULL if it must never be used anyway?
> 
> path_release() does _not_ invalidate the nameidata. Look for instance at
> __emul_lookup_dentry(), which clearly makes use of that fact.

Trond, wake up!  __emul_lookup_dentry() does nothing of the sort.
Neither does anything else.  In theory it could, but that's not a
reason to do a confusing thing like that.

> Firstly, the open_namei() flags field is not a "permissions" field. It
> contains open mode information. The calculation of the open permissions
> flags is done by open_namei() itself.

Based on flags.  It's just a FMODE_* -> MAY_* transformation

> Secondly, what advantage is there in allowing callers of open_namei() to
> be able to override the MAY_WRITE check when doing open(O_TRUNC)? This
> is a calculation that should be done _once_ in order to always get it
> right, and it should therefore be done in open_namei() together with the
> rest of the permissions calculation.

I think the _only_ caller of open_namei() is filp_open(), so this is
not much of an issue, but yeah, you could do it that way too.

Or you could initialize nameidata from filp_open().

Miklos
