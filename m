Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423164AbWF1FUc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423164AbWF1FUc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 01:20:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423183AbWF1FT4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 01:19:56 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:19115 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1423164AbWF1FTn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 01:19:43 -0400
Date: Wed, 28 Jun 2006 06:19:35 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, herbert@13thfloor.at,
       serue@us.ibm.com
Subject: Re: [PATCH 20/20] honor r/w changes at do_remount() time
Message-ID: <20060628051935.GA29920@ftp.linux.org.uk>
References: <20060627221436.77CCB048@localhost.localdomain> <20060627221457.04ADBF71@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060627221457.04ADBF71@localhost.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 27, 2006 at 03:14:57PM -0700, Dave Hansen wrote:
> 
> Originally from: Herbert Poetzl <herbert@13thfloor.at>
> 
> This is the core of the read-only bind mount patch set.
> 
> Note that this does _not_ add a "ro" option directly to
> the bind mount operation.  If you require such a mount,
> you must first do the bind, then follow it up with a
> 'mount -o remount,ro' operation.
 
I guess the fundamental problem I have with that approach is that it's
a cop-out - we just declare rw state of vfsmount independent from that
of filesystem and add a "if a flag is set, act upon vfsmount".

And yes, some of that does make sense.  Fine, let's separate that
stuff; but then we'd better decide what rw superblock *is*.

We have a number of vfsmounts over given superblock.  OK, some are
"we don't even ask them to be r/w".  Some are "we want them r/w, but
don't actually use as such at the moment".  Some are "pinned down for
write now".  And we do get logics for "can't make it r/o right now".

But look - we have the _same_ logics for superblock itself.  Only it's
full of holes.  And since you have rw states for those completely
unrelated to those of vfsmount, we get a ridiculous situation - we
*do* mark the moments when superblock becomes impossible to remount
r/o and we even mostly get the moments when it ceases to be busy
writing (unlinked-but-opened files are major exception).  But we can't
use that information.

So "can we remount superblock ro?" turns into kinda-sorta duplicate of
the same for vfsmounts, but it's racy as hell and bloody incomplete;
we don't even get "if some vfsmount over it is busy writing, we won't
remount r/o".  Approximation is done, but that's it.  E.g. mkdir() in
progress does *not* stop remount of superblock r/o (it does prevent
remount of vfsmount with your patchset).

FWIW, I suspect that the root of the problem is that we confuse different
states of filesystem.  E.g. one obviously useful feature would be to have
soft r/o - filesystem that is (from the driver POV) mounted readonly,
but would get transparently switched r/w at the first request.  And you
have all vfsmount-side infrastructure for that, BTW.  Add something like
mechanism we use for expiry and you've got a very tasty feature for e.g.
laptop users: e.g. userland asking to switch fs soft-ro every 15 minutes
and if nobody had wanted it r/w since the last time, do the transition;
if asked r/w again, r/w it goes on its own.  IOW, there's more to it than
one bit.  And I'm talking about superblock state...

BTW, it might be worth doing the following:
	* reintroduce the list of vfsmounts over given superblock (protected
by vfsmount_lock)
	* keep ro flag separate from counter and split it in two.
	* all decrements are with atomic_dec_and_lock()
	* all increments are with atomic_add_unless() + spin_lock() +
check flags + atomic_add_return() + possible spin_unlock
	* if writers count goes from non-zero to zero or vice versa
increment/decrement superblock counter (number of vfsmounts that really
want write access).
	* make the moments when i_nlink hits 0 bump the superblock writers
count; drop it when such sucker gets freed on final iput.
	* kill the sodding "traverse the list of opened files" logics in
remounting superblock r/o.  Instead of that, grab spinlock, check writers
count, bail out if non-zero, grab vfsmount_lock, traverse the list over
superblock and set one of the flags, drop the locks and proceed.
	* when remounting superblock r/w, traverse the list and knock out
the same flag.

At least that way we'd get the majority of "can remount ro" logics right...

Another fun issues:
	a) MS_REC handling with MS_BIND remounts (trivial)
	b) figuring out what (if anything) should be done with propagation
when we have shared subtrees... (not trivial at all)
