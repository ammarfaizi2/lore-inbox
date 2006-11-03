Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753014AbWKCNmT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753014AbWKCNmT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Nov 2006 08:42:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753015AbWKCNmT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Nov 2006 08:42:19 -0500
Received: from pat.uio.no ([129.240.10.4]:45306 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S1753013AbWKCNmS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Nov 2006 08:42:18 -0500
Subject: Re: Security issues with local filesystem caching
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: David Howells <dhowells@redhat.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, Karl MacMillan <kmacmill@redhat.com>,
       jmorris@namei.org, chrisw@sous-sol.org, selinux@tycho.nsa.gov,
       linux-kernel@vger.kernel.org, aviro@redhat.com
In-Reply-To: <12984.1162549621@redhat.com>
References: <1162502667.6071.66.camel@lade.trondhjem.org>
	 <1162496968.6071.38.camel@lade.trondhjem.org>
	 <1162402218.32614.230.camel@moss-spartans.epoch.ncsc.mil>
	 <1162387735.32614.184.camel@moss-spartans.epoch.ncsc.mil>
	 <16969.1161771256@redhat.com> <31035.1162330008@redhat.com>
	 <4417.1162395294@redhat.com> <25037.1162487801@redhat.com>
	 <32754.1162499917@redhat.com>   <12984.1162549621@redhat.com>
Content-Type: text/plain
Date: Fri, 03 Nov 2006 08:41:31 -0500
Message-Id: <1162561291.5635.64.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.194, required 12,
	autolearn=disabled, AWL 1.67, RCVD_IN_SORBS_DUL 0.14,
	UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-11-03 at 10:27 +0000, David Howells wrote:

> Anyway, it's not just vfs_mkdir(), there's also vfs_create(), vfs_rename(),
> vfs_unlink(), vfs_setxattr(), vfs_getxattr(), and I'm going to need a
> vfs_lookup() or something (a pathwalk to next dentry).
> 
> Yes, I'd prefer not to have to use these, but that doesn't seem to be an
> option.

It is not as if we care about an extra context switch here, and we
really don't want to do that file i/o in the context of the rpciod
process if we can avoid it. It might be nice to be able to do those
calls that only involve lookup+read in the context of the user's process
in order to avoid the context switch when paging in data from the cache,
but writing to it both can and should be done as a write-behind process.

IOW: we should rather set up a separate workqueue to write data to disk,
and just concentrate on working out a way to lookup and read data with
no fsuid/fsgid changes and preferably a minimum of selinux magic.

> > > Also I should be setting security labels on the files I create.
> > 
> > To what end? These files shouldn't need to be made visible to userland
> > at all.
> 
> But they are visible to userland and they have to be visible to userland.  They
> exist in the filesystem in which the cache resides, and they need to be visible
> so that cachefilesd can do the culling work.  If you were thinking of using
> "deleted" files, remember that I want it to be persistent across reboots, or
> even when an NFS inode is flushed from memory to make space and then reloaded
> later.

No. I was thinking of keeping the cache on its own partition and using
kernel mounts. cachefilesd could possibly mount the thing in its own
private namespace.

Trond

