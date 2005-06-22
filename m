Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262839AbVFVHv5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262839AbVFVHv5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 03:51:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262896AbVFVHtq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 03:49:46 -0400
Received: from 238-071.adsl.pool.ew.hu ([193.226.238.71]:13064 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S262483AbVFVHQu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 03:16:50 -0400
To: akpm@osdl.org
CC: miklos@szeredi.hu, pavel@ucw.cz, linux-kernel@vger.kernel.org
In-reply-to: <20050621233914.69a5c85e.akpm@osdl.org> (message from Andrew
	Morton on Tue, 21 Jun 2005 23:39:14 -0700)
Subject: Re: -mm -> 2.6.13 merge status (fuse)
References: <20050620235458.5b437274.akpm@osdl.org>
	<E1Dkfu2-0005Ju-00@dorka.pomaz.szeredi.hu>
	<20050621142820.GC2015@openzaurus.ucw.cz>
	<E1DkkRE-0005mt-00@dorka.pomaz.szeredi.hu>
	<20050621220619.GC2815@elf.ucw.cz>
	<E1Dkyas-0006wu-00@dorka.pomaz.szeredi.hu> <20050621233914.69a5c85e.akpm@osdl.org>
Message-Id: <E1DkzTO-00072F-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 22 Jun 2005 09:16:34 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> It would be helpful if we could have a brief description of the feature
> which you're discussing here.  We discussed this a couple of months back,
> but I've forgotten most of it and it was off-list I think.
> 
> Doing `grep uid fs/fuse/*.c' gets us to the implementation, yes?
> 
> Which parts are controversial?

The controversial part is fuse_allow_task() called from
fuse_permission() and fuse_revalidate() (fs/fuse/dir.c).

This function (as explained by the header comment) disallows access to
the filesystem for any task, which the filesystem owner (the user who
did the mount) is not allowed to ptrace.

The rationale is that accessing the filesystem gives the filesystem
implementor ptrace like capabilities (detailed in
Documentation/filesystems/fuse.txt)

It is controversial, because obviously root owned tasks are not
ptrace-able by the user, and so these tasks will be denied access to
the user mounted filesystem (-EACCESS is returned on stat() or any
other file operation).

However nobody raised _any_ concrete technical problem associated with
this, and the 4 years of widespread use didn't turn up any either.  So
IMO it's "ugly" only in people's heads and not in reality.

> How _should_ we implement unprivileged mounts, if not this way?

A lot of the earlier discussion centered around making private
namespaces usable, and so segregating user mounts.  However because
suid/sgid programs can still gain elevated privileges in a private
namespace the above check is still necessary.

So private namespaces are alone not a solution.

I also suggested (and implemented a patch) which hides the user
mounts, based on the above check.  This would mean, that root and
other users would simply not see the user's mount instead of getting
an error.  This was also received with very little enthusiasm.

A further suggested alternative was to confine user mounts to a single
directory (e.g. '/mnt/usermounts').  This would solve the problem if
every daemon and suid/sgid program was tought to not enter this
directory.  This is quite impractical.  Besides this is a very
inflexible solution.

I'm still waiting for a practical alternative.  I don't consider
practical the opinion held by quite a few people:

   "let's integrate FUSE now, without unpriv mounts, maybe we'll find
    a better solution later"

I consider it highly unlikely, that any time will be better than now.

Thanks,
Miklos

  
