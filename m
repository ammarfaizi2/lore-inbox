Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269714AbUHZVd2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269714AbUHZVd2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 17:33:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269696AbUHZVaP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 17:30:15 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:49642 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S269677AbUHZV2z
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 17:28:55 -0400
Date: Thu, 26 Aug 2004 22:28:53 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Linus Torvalds <torvalds@osdl.org>
Cc: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
       Rik van Riel <riel@redhat.com>, Diego Calleja <diegocg@teleline.es>,
       jamie@shareable.org, christophe@saout.de, christer@weinigel.se,
       spam@tnonline.net, akpm@osdl.org, wichert@wiggy.net, jra@samba.org,
       reiser@namesys.com, hch@lst.de, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org, flx@namesys.com,
       reiserfs-list@namesys.com
Subject: [some sanity for a change] possible design issues for hybrids
Message-ID: <20040826212853.GA21964@parcelfarce.linux.theplanet.co.uk>
References: <Pine.LNX.4.44.0408261356330.27909-100000@chimarrao.boston.redhat.com> <200408262128.41326.vda@port.imtp.ilyichevsk.odessa.ua> <Pine.LNX.4.58.0408261132150.2304@ppc970.osdl.org> <20040826191323.GY21964@parcelfarce.linux.theplanet.co.uk> <20040826203228.GZ21964@parcelfarce.linux.theplanet.co.uk> <Pine.LNX.4.58.0408261344150.2304@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0408261344150.2304@ppc970.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[subject changed and *please* let's keep the wankfest out of that branch;
we are talking about possible ways to handle hybrids, *NOT* their desirability,
effect on DARPA funding, size of KDE developers' genitals experienced by
Aunt Tillie, etc.]

On Thu, Aug 26, 2004 at 01:47:37PM -0700, Linus Torvalds wrote:
> Hey, that's a valid reason for doing -EBUSY for normal bind-mounts, but it
> actually _is_ what we want for an "implied-by-way-of-container-mount". 
> After all, when you do a "rm foo", you do mean "remove the container foo".
> 
> I replied to your earlier off-list mail in private, so let's re-iterate
> for the list: the easiest way to handle this is to just have a "mount
> option", and have "MNT_ALLOWUNLINK" that gets set for containers, and that
> users could possibly choose to set for regular mounts too (as a mount
> option) if they really want to (and if we want them to).
> 
> So there's no reason we'd have to drop existing mount behaviour only 
> because we also have special files that look like mountpoints. 

All right, let's see where that would take us.

1) we would need to find all vfsmounts over given dentry.  Probably a cyclic
list (we want to check if there are normal mounts/bindings among those and
we want to dissolve them if there's none).

2) we would need to do something about locking, since mount trees in other
guys' namespaces are protected by semaphores of their own.

3) what do we do on umount(2)?  We can get a bunch of vfsmounts hanging off
it.  MNT_DETACH will have no problems, but normal umount() is a different
story.  Note that it's not just hybrid-related problem - implementing the
mount traps will cause the same kind of trouble,

4) OK, we have those hybrids and want to create vfsmounts when crossing a
mountpoint.  When do they go away, anyway?  When we don't reference them
anymore?  Right now "attached to mount tree" == "+1 to refcount" and detaching
happens explicitly - outside of the "dropping the final reference" path.
Might become a locking issue.

5) Creation of these vfsmounts: fs should somehow tell us whether it wants
one or not (at the very least, we should stop *somewhere*).  Can we use
the same dentry/inode?  I'm not sure and I really doubt that we'd like that.

6) if it's a method, where should it live, *especially* if we want them on
device nodes.  Note that inode_operations belongs to underlying fs, so it's
not particulary good place for device case.

7) automount folks want partially shared mount trees (well, mirrored,
actually).  The basic idea is that while namespace boundary is a trust
boundary, we might want to be able to say "I trust this guy to handle
that subtree under /home/stuff/foobar/mounts".  It's the same situation
as with shared mappings (I want separate address space, but I'm willing
to share that chunk of memory with other process), except that we want
it to be allowed to become asymmetric (shared r/o mapping with somebody
else having it r/w).   That stuff (and mount traps) is the next pending
major work on the mount trees.  We probably want hybrids work to go with it,
since they affect the same data structures and need more or less the same
changes.
[And yes, this is the open season on design discussions for shared subtrees -
automount folks are welcome to join]

8) what should happen when something is mounted on top of directory-over-file?
How do we treat such beasts?  What are the implications?

9) how do we recognize such mountpoints in the path lookups?  It *is* a
hot path, so we should be careful in that area; the impact will be felt
by everything in the system.

10) how do we deal with directories, anyway?  Mixing "attributes" with
normal directory contents is going to be fun, what with lseek() insanity.
That's not an issue for hybrids, but it is one for anybody who wants
any sort of common metadata exported that way.  Note that it's really
important for fs writers - having two different pieces of code to export
the same information (for directories and non-directories resp.) is going
to become a prime breeding ground for bugs.

11) if we go for your "here's stuff that belongs in device node viewed
as directory", how would that play with fs metadata exporters?  Again,
due to the insanity of lseek() on directories it's *very* hard to deal
with unions, when parts of directory come from different chunks of code.

That's it for starters.  Technical answers/questions/comments are welcome.
Generic masturbation => over there in the parent thread, please.
