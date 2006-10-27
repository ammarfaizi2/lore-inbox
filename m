Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751093AbWJ0Q0a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751093AbWJ0Q0a (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Oct 2006 12:26:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751136AbWJ0Q0a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Oct 2006 12:26:30 -0400
Received: from mx1.redhat.com ([66.187.233.31]:32465 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751093AbWJ0Q0a (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Oct 2006 12:26:30 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <1161965410.1306.47.camel@moss-spartans.epoch.ncsc.mil> 
References: <1161965410.1306.47.camel@moss-spartans.epoch.ncsc.mil>  <1161960520.16681.380.camel@moss-spartans.epoch.ncsc.mil> <1161884706.16681.270.camel@moss-spartans.epoch.ncsc.mil> <1161880487.16681.232.camel@moss-spartans.epoch.ncsc.mil> <1161867101.16681.115.camel@moss-spartans.epoch.ncsc.mil> <1161810725.16681.45.camel@moss-spartans.epoch.ncsc.mil> <16969.1161771256@redhat.com> <8567.1161859255@redhat.com> <22702.1161878644@redhat.com> <24017.1161882574@redhat.com> <2340.1161903200@redhat.com> <4786.1161963766@redhat.com> 
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: David Howells <dhowells@redhat.com>, aviro@redhat.com,
       linux-kernel@vger.kernel.org, selinux@tycho.nsa.gov,
       chrisw@sous-sol.org, jmorris@namei.org
Subject: Re: Security issues with local filesystem caching 
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Fri, 27 Oct 2006 17:25:23 +0100
Message-ID: <5506.1161966323@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Smalley <sds@tycho.nsa.gov> wrote:

> > I was also wondering if I could generalise it to handle all cache types,
> > but the permissions checks are probably going to be quite different for
> > each type.  For instance, CacheFiles uses files on a mounted fs, whilst
> > CacheFS uses a block device.
> 
> So in the latter case, the daemon supplies the path of a block device
> node?

No.  In the latter case, there is no userspace daemon.  As there are no
dentries, filenames and paths in CacheFS, keeping track of the cull table
consumes a less space than for CacheFiles.

You start the cache by mounting it:

	mount -t cachefs /dev/hdx9 /cachefs

Then it's online.  However, you might want to check that whoever's calling
mount has permission to bring a cache online...

Actually, I think the permission to bring a cache online applies in all cases,
and is probably separate from checking that CacheFiles(d) is permitted to
mangle the filesystem it's using for a cache.  With CacheFS, we could do the
equivalent and do a MAC check to make sure we're permitted to read and write
the blockdev, as you suggest in the next bit:

> I suppose the hook could internally check the type of inode to decide what
> checks to apply, using the checks I previously sketched when it is a
> directory and using a different set of checks for the block device
> (substituting a write check against the block device for the
> directory-specific checks).  The hook interface itself would look the same
> IIUC, i.e. providing the (mnt, dentry) pair to which the path resolved and
> the secid to which the context resolved.

So, to summarise, is it worth having two checks:

 (1) Permission to bring a cache online or to take a cache offline.

 (2) Permission for the process bringing the cache online (cachefilesd or
     mount) to access the backing store, be it a set of files and directories,
     or be it a blockdev.

David
