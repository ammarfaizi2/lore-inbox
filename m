Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261407AbREQM3w>; Thu, 17 May 2001 08:29:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261409AbREQM3m>; Thu, 17 May 2001 08:29:42 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:49131 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S261407AbREQM3d>;
	Thu, 17 May 2001 08:29:33 -0400
Date: Thu, 17 May 2001 08:29:31 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Andries.Brouwer@cwi.nl
cc: linux-kernel@vger.kernel.org
Subject: Re: Bug in unlink error return
In-Reply-To: <UTC200105171126.NAA37619.aeb@vlet.cwi.nl>
Message-ID: <Pine.GSO.4.21.0105170746590.27492-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 17 May 2001 Andries.Brouwer@cwi.nl wrote:

> Someone complained a moment ago about the error return in unlink.
> And indeed, it used to be correct but since 2.1.132 we return a
> buggy (or at least non-POSIX) error for unlink(directory).
 
> [The EISDIR is correct for rename(), and the cleanup that
> made a nice uniform may_delete() in namei.c introduced this bug.
> The very simple but slightly ugly fix is to write (in vfs_unlink)
> 	error = may_delete(dir, dentry, 0);
> 	if (error == -EISDIR)
> 		error = -EPERM;
> ]
 
IMO that's the case of POSIX being misapplied. Rationale:

	* historically, unlink(2) _did_ work on directories. It was root-only
and thus normal error value was EPERM. It was inherently racy - rmdir(1) was
implemented (suid-root) as 3 calls of unlink(2) (., .. and link from parent),
but it lacked atomicity and could leave corrupted filesystem if killed in
the middle of operation.

	* introduction of rmdir(2) made unlink(2) on directories not only
dangerous, but completely unnecessary. Eventually, operation became prohibited
for everyone.

	* rename(2) is BSDism, especially - overwriting one (dmr considered
it as a bad idea and in the hindsight he was absolutely right on that). In
case of mismatch they (most likely - Kirk) had chosen to use more informative
error value. They could use EPERM, but since nobody was permitted to do
that it would be rather silly.

	Notice that situation with unlink(2) is the same. It's not a matter
of insufficient permissions - operation is simply not allowed, whoever you
are.

	In other words, POSIX describes behaviour that used to make sense on
systems with different semantics of unlink(2). Notice that standard meaning
of EPERM is "privileges are insufficient for requested operation". No longer
accurate in that case and had been inaccurate for many years.

	We can revert to returning EPERM in that case. However, if you could
get Austin Group to accept EISDIR as legitimate error value for that case
the world would make more sense. We had this behaviour for quite a while.
So far userland seems to be OK with that and it definitely makes more sense
than EPERM.

	Moreover, it's consistent with behaviour of rmdir() and rename() -
both use ENOTDIR/EISDIR to report the type mismatch for victim.

