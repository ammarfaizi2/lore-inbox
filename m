Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964979AbVHIVTk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964979AbVHIVTk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Aug 2005 17:19:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964981AbVHIVTk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Aug 2005 17:19:40 -0400
Received: from adsl-266.mirage.euroweb.hu ([193.226.239.10]:26380 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S964979AbVHIVTj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Aug 2005 17:19:39 -0400
To: trond.myklebust@fys.uio.no
CC: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
In-reply-to: <1123621890.8245.211.camel@lade.trondhjem.org> (message from
	Trond Myklebust on Tue, 09 Aug 2005 17:11:30 -0400)
Subject: Re: [RFC] atomic open(..., O_CREAT | ...)
References: <E1E2G68-0006H2-00@dorka.pomaz.szeredi.hu>
	 <1123541926.8249.8.camel@lade.trondhjem.org>
	 <E1E2OoL-0006xQ-00@dorka.pomaz.szeredi.hu>
	 <1123594460.8245.15.camel@lade.trondhjem.org>
	 <E1E2X9A-0007Uk-00@dorka.pomaz.szeredi.hu>
	 <1123607889.8245.107.camel@lade.trondhjem.org>
	 <E1E2Y92-0007Zv-00@dorka.pomaz.szeredi.hu>
	 <1123612734.8245.150.camel@lade.trondhjem.org>
	 <E1E2aw6-0007oY-00@dorka.pomaz.szeredi.hu> <1123621890.8245.211.camel@lade.trondhjem.org>
Message-Id: <E1E2bVT-0007tW-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 09 Aug 2005 23:19:31 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Really?
> 
> static int __emul_lookup_dentry(const char *name, struct nameidata *nd)
> {
> 		.....
> 		if (path_walk(name, nd) == 0) {
> 			if (nd->dentry->d_inode) {
> 				dput(old_dentry);
> 				mntput(old_mnt);
> 				return 1;
> 			}
> 			path_release(nd);
> 		}
> 		nd->dentry = old_dentry;
> 		nd->mnt = old_mnt;
> 		nd->last = last;
> 		nd->last_type = last_type;
> 	}
> 	return 1;
> }

I see what you are getting at.  But notice, that every (relevant)
field of nameidata is reinitialized, except nd->flags, which is
_obviously_ not changed by either path_walk() or path_release().

So your argument doesn't hold.

You basically argue, that intent.open.file must be zeroed, because
someone might call path_release_open_intent() twice, which very
obviously does not make any sense, unless it does some magic like the
above (which it should not), in which case it might as well be aware,
that it has to save/restore the intent.open.file field as well.

> Currently, yes. The only caller of open_namei() is filp_open(). That was
> not always the case previously.
> 
> If we think it will never be the case in the future, then there is an
> argument for merging the two and/or making open_namei() and inlined
> function.

Yes, that would make sense.

Miklos
