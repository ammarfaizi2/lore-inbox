Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750936AbVJFUSw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750936AbVJFUSw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Oct 2005 16:18:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751345AbVJFUSw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Oct 2005 16:18:52 -0400
Received: from 223-177.adsl.pool.ew.hu ([193.226.223.177]:24068 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S1750936AbVJFUSv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Oct 2005 16:18:51 -0400
To: trond.myklebust@fys.uio.no
CC: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
In-reply-to: <1128626258.31797.34.camel@lade.trondhjem.org> (message from
	Trond Myklebust on Thu, 06 Oct 2005 15:17:38 -0400)
Subject: Re: [RFC] atomic create+open
References: <E1ENWt1-000363-00@dorka.pomaz.szeredi.hu>
	 <1128616864.8396.32.camel@lade.trondhjem.org>
	 <E1ENZ8u-0003JS-00@dorka.pomaz.szeredi.hu>
	 <E1ENZCQ-0003K3-00@dorka.pomaz.szeredi.hu>
	 <1128619526.16534.8.camel@lade.trondhjem.org>
	 <E1ENZZl-0003OO-00@dorka.pomaz.szeredi.hu>
	 <1128620528.16534.26.camel@lade.trondhjem.org>
	 <E1ENZu1-0003SP-00@dorka.pomaz.szeredi.hu>
	 <1128623899.31797.14.camel@lade.trondhjem.org>
	 <E1ENani-0003c4-00@dorka.pomaz.szeredi.hu> <1128626258.31797.34.camel@lade.trondhjem.org>
Message-Id: <E1ENcAr-0003jz-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 06 Oct 2005 22:17:05 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > 
> > When open_namei() gets around to following the mounts, it is not there
> > any more, so the dentry for /mnt/foo (the NFS one is returned) and
> > NFS's ->open is called on the file, which returns -ENOENT.  But
> > open(..., O_CREAT, ...) should never return -ENOENT.
> 
> ...and so the VFS can recognise the case, and be made to retry the
> operation.
> A more difficult race to deal with occurs if you allow a mount while
> inside d_revalidate(). In that case NFS can end up opening the wrong
> file.

Yes, in fact all my examples should have been for ->d_revalidate(),
since it's not possible that ->lookup() be called for a mounted
dentry.

> Both these two races could, however, be fixed by moving the
> __follow_mount() in open_namei() inside the section that is protected by
> the parent directory i_sem.

No.  Only the namespace semaphore could protect against mount/umount,
but you don't want to take that in lookup logic.

> In any case, all you are doing here is showing that the situation w.r.t.
> mount races and lookup+create+open is difficult. I see nothing that
> convinces me that a special atomic create+open will help to resolve
> those races.

I just think that filesystem code should _never_ need to care about
mounts.  If you want to do the lookup+open, you somehow will have to
deal with mounts, which is ugly.

> Nor do I see that adding a special atomic create+open will help me avoid
> intents for the case of atomic lookup+open(). As far as I'm concerned,
> the case of lookup+create+open is just a special case of lookup+open.

IMO the lookup+open optimization is not valid, because dealing with
mounts is the job of the VFS and not the filesystem.

Path lookup usually ends in a sequence of ->lookup (or
->d_revalidate), then following mounts, then doing the operation.  You
shouldn't try to merge the ->lookup and the ->fsop into one operation.
That way leads to madness.

Miklos
