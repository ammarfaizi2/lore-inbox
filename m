Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964918AbVJZUKe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964918AbVJZUKe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Oct 2005 16:10:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964916AbVJZUKe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Oct 2005 16:10:34 -0400
Received: from 238-193.adsl.pool.ew.hu ([193.226.238.193]:57099 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S964914AbVJZUKd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Oct 2005 16:10:33 -0400
To: bulb@ucw.cz
CC: viro@ftp.linux.org.uk, akpm@osdl.org, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org
In-reply-to: <20051026195240.GB15046@efreet.light.src> (message from Jan Hudec
	on Wed, 26 Oct 2005 21:52:41 +0200)
Subject: Re: [PATCH 2/8] VFS: per inode statfs (core)
References: <E1EU5bT-0005sq-00@dorka.pomaz.szeredi.hu> <20051025042519.GJ7992@ftp.linux.org.uk> <E1EUHbq-0006t6-00@dorka.pomaz.szeredi.hu> <20051026173150.GB11769@efreet.light.src> <E1EUqm3-00013A-00@dorka.pomaz.szeredi.hu> <20051026195240.GB15046@efreet.light.src>
Message-Id: <E1EUrb7-0001AU-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 26 Oct 2005 22:10:09 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > > > > This patch adds a statfs method to inode operations.  This is invoked
> > > > > > whenever the dentry is available (not called from sys_ustat()) and the
> > > > > > filesystem implements this method.  Otherwise the normal
> > > > > > s_op->statfs() will be called.
> > > > > > 
> > > > > > This change is backward compatible, but calls to vfs_statfs() should
> > > > > > be changed to vfs_dentry_statfs() whenever possible.
> > > > > 
> > > > > What the fuck for?  statfs() returns data that by definition should
> > > > > not depend on inode within a filesystem.
> > > > 
> > > > Exactly.  But it's specified nowhere that there has to be a one-one
> > > > mapping between remote filesystem - local filesystem.
> > > 
> > > Unfortunately making statfs alone aware of them does not help. Most useful
> > > tools that use statfs go to /proc/mouts, read all the entries and invoke
> > > statfs for each path. So if for some non-root path different values are
> > > returned, these tools won't see them anyway. So try to think about how to
> > > provide the info about subfilesystems first.
> > 
> > 'df .': tried it and it did not do what was expected, but that can
> > definitely be fixed
> 
> It *did* what was expected -- walked back up to the mountpoint and called
> statfs there.

Yes, but I didn't expect that it would do that.  Why?  Because I asked
it for free space in the current directory and not at the mountpoint.

Since it's not _expecting_ subfilesystems to exist, it's
understandable that it did not perform well.

> And it cannot be fixed (without loss of functionality) unless
> you somehow tell it where the boundary of the subfilesystem lies.

Of course it can be fixed.  Just always let it do
statfs(path_supplied_by_user).  If there are no subfses the results
will be the same.  If there _are_ subfses the results will be more
meaningful, not less.

> > 'stat -f .': actually works
> 
> Sure it does. I don't expect many people to use that manually though.
> 
> > foo-filemanager: before copying a file or directory tree, checks for
> > free space in destination directory
> 
> While most others simply don't care -- if it fails, it fails. Looking up the
> free space beforehand is only a heurisitics anyway, as the free space can
> change between the stat and the copy anyway.

Being a heuristic doesn't prevent it from being used.  And if you have
one subfilesystem with zero free space, and one with lots, you _will_
get burned if statfs() happens to report the zero space for every path
within the mount.

> > None of the above examples need (and use) /etc/mtab or /proc/mounts.
> > 
> > Just because the info is not available about the placement of the
> > subfilesystems, doesn't mean that the subfilesystems don't actually
> > exist.
> 
> No, it does not. But it does mean that some applications that should know
> about them won't know and will give even more confusing results.

How will they give more confusing results?  Please ellaborate.

Miklos
