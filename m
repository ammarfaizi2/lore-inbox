Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266445AbUGJVjh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266445AbUGJVjh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jul 2004 17:39:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266448AbUGJVjh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jul 2004 17:39:37 -0400
Received: from 66-79-15-219.clec.nworla.commercial.madisonriver.net ([66.79.15.219]:6529
	"EHLO lade.trondhjem.org") by vger.kernel.org with ESMTP
	id S266445AbUGJVix convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jul 2004 17:38:53 -0400
Subject: Re: umount() and NFS races in 2.4.26
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Thomas Moestl <moestl@ibr.cs.tu-bs.de>, linux-kernel@vger.kernel.org,
       Alexander Viro <viro@parcelfarce.linux.theplanet.co.uk>
In-Reply-To: <20040709143242.GB11168@logos.cnet>
References: <20040708180709.GA7704@timesink.dyndns.org>
	 <20040709143242.GB11168@logos.cnet>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Message-Id: <1089495528.5406.10.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sat, 10 Jul 2004 16:38:48 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

På fr , 09/07/2004 klokka 09:32, skreiv Marcelo Tosatti:
> > - The NFS async unlink code (fs/nfs/unlink.c) does keep a dentry for
> >   later asynchronous processing, but the mount point is unbusied via
> >   path_release() once sys_unlink() returns (fs/namei.c). While it
> >   does a dget() on the dentry, this is insufficient to prevent an
> >   umount(); when one would happen in the right time window, it seems
> >   that it would initially get past the busy check:
> > 	if (atomic_read(&mnt->mnt_count) == 2 || flags & MNT_DETACH) {
> >   (fs/namespace.c, do_umount()), but invalidate_inodes() in kill_super()
> >   (fs/super.c) would then fail because of the inode referenced from
> >   the dentry needed for the async unlink (which cannot be removed
> >   by shrink_dcache_parent() because the NFS code did dget() it).
> > 
> >   Please note that this problem is only conjectured, as it turned out
> >   to not be our culprit. It looks not completely trivial to fix to me,
> >   I believe it might require some changes that would affect other FS
> >   implementations. It is not a true SMP race, if it exists it would
> >   affect UP systems as well.
> 
> Trond?

Known problem, but a fix is not trivial since the unlink() procedure
does not take a nameidata structure argument (which would be needed in
order to figure out which vfs_mount struct to mntget()).

If someone can figure out a way to fix it, then a patch would be
welcome, but I'm on holiday until the Linux Kernel Summit starts, so
don't expect any immediate action from me...

Cheers,
 Trond
