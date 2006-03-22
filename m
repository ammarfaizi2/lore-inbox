Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751362AbWCVQew@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751362AbWCVQew (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 11:34:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751363AbWCVQew
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 11:34:52 -0500
Received: from a1819.adsl.pool.eol.hu ([81.0.120.41]:7318 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S1751361AbWCVQev (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 11:34:51 -0500
To: trond.myklebust@fys.uio.no
CC: chrisw@sous-sol.org, matthew@wil.cx, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org
In-reply-to: <1143042976.12871.34.camel@lade.trondhjem.org> (message from
	Trond Myklebust on Wed, 22 Mar 2006 10:56:16 -0500)
Subject: Re: DoS with POSIX file locks?
References: <E1FLIlF-0007zR-00@dorka.pomaz.szeredi.hu>
	 <20060320121107.GE8980@parisc-linux.org>
	 <E1FLJLs-00085u-00@dorka.pomaz.szeredi.hu>
	 <20060320123950.GF8980@parisc-linux.org>
	 <E1FLJsF-0008A7-00@dorka.pomaz.szeredi.hu>
	 <20060320153202.GH8980@parisc-linux.org>
	 <1142878975.7991.13.camel@lade.trondhjem.org>
	 <E1FLdPd-00020d-00@dorka.pomaz.szeredi.hu>
	 <1142962083.7987.37.camel@lade.trondhjem.org>
	 <E1FLl7L-0002u9-00@dorka.pomaz.szeredi.hu>
	 <20060321191605.GB15997@sorel.sous-sol.org>
	 <E1FLwjC-0000kJ-00@dorka.pomaz.szeredi.hu>
	 <1143025967.12871.9.camel@lade.trondhjem.org>
	 <E1FM2Gi-0001LF-00@dorka.pomaz.szeredi.hu> <1143042976.12871.34.camel@lade.trondhjem.org>
Message-Id: <E1FM6Hd-0001l9-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 22 Mar 2006 17:34:05 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > > > i concur with Trond, there's no sane way to get rid of it w/out
> > > > > formalizing CLONE_FILES and locks on exec
> > > > 
> > > > Probably there is.  It would involve allocating a separate
> > > > lock-owner-ID stored in files_struct but separate from it.  But it's
> > > > more complicated than simply not propagating locks on exec in the
> > > > CLONE_FILES case.
> > > 
> > > That doesn't solve the fundamental problem.
> > > 
> > > You would still have to be able to tell a remote server that some locks
> > > which previously belonged to one owner are being reallocated to several
> > > owners.
> > 
> > No changing of lock owner is involved, that's the whole point.
> 
> You still don't get it.

No!  You don't get it! ;)

> For NFS/CIFS/... the locks on the server _also_ have a lock
> owner. The local lockowner is completely and utterly irrelevant.

You mean the "local lockowner being stable" is irrelevant.

Yes that is true, but the patch not only makes the local lockowner
stable, it makes the "owner" stable.  And that is the important part
for NFS, etc.

The remote lockowner has to be derived from the owner, which used to
be current->files, but is changed to current->file->owner.

The fact that current->file->owner will remain stable across the exec
will mean that locking will behave consistently for local _and_ remote
filesystems.

Now I'm not saying I want to keep this weird semantics of always
inheriting locks on exec.  All I'm saying that it's _possible_.

Miklos

