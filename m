Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290679AbSARMLb>; Fri, 18 Jan 2002 07:11:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290677AbSARMLX>; Fri, 18 Jan 2002 07:11:23 -0500
Received: from mons.uio.no ([129.240.130.14]:39100 "EHLO mons.uio.no")
	by vger.kernel.org with ESMTP id <S290679AbSARMLG>;
	Fri, 18 Jan 2002 07:11:06 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15432.4299.720181.998342@charged.uio.no>
Date: Fri, 18 Jan 2002 13:10:51 +0100
To: Alexander Viro <viro@math.psu.edu>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.5.3-pre1] Fix NFS dentry lookup behaviour
In-Reply-To: <Pine.GSO.4.21.0201171720390.11155-100000@weyl.math.psu.edu>
In-Reply-To: <Pine.LNX.4.33.0201171414220.3114-100000@penguin.transmeta.com>
	<Pine.GSO.4.21.0201171720390.11155-100000@weyl.math.psu.edu>
X-Mailer: VM 6.92 under 21.1 (patch 14) "Cuyahoga Valley" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Alexander Viro <viro@math.psu.edu> writes:

     > Nothing, especially since it will happen automatically when we
     > switch to slightly different handling of cwd/root (no
     > user-visible changes, will allow union-mounts - basically,
     > cleanup of first and last steps of path_walk()).

So what is the plan? I've raised the issue of open(".") on Linux
Fsdevel several times, and ended up getting nowhere. This is the first
time I've heard mention of a planned cleanup of path_walk.
I'll be happy to drop that part of the patch if you can confirm that it
will solve the following problem.

Reminder of the problem
-----------------------
For NFS the current code *is broken* since we don't get called back at
all in path_walk() for the special case of accessing cwd. That has 2
consequences:

  - open(".") may succeed even if cwd is know to be a stale dentry.

  - The attribute cache, and hence also the data cache, does not get
    revalidated. This breaks close-to-open semantics for those who
    require it, and leads to silly inconsistencies: typically 'ls -l'
    returning gratuitous "file 'blah' does not exist" errors.

Putting cache revalidation in ->open() itself would be a pain: there
is no way of detecting whether or the attributes were checked during
the dcache lookup, so it would mean that we end up duplicating a lot
of cache checks for the non-cwd case.

Using the existing inode->i_op->revalidate() is also not an option,
since it might break other filesystems, and is in any case scheduled
for deletion due to being ill-defined.

If we could use d_revalidate(), then that would be OK as far as I'm
concerned, however this too was deemed unacceptable when raised on
linux-fsdevel.

Cheers,
  Trond
