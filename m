Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262687AbTJ3Rbh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Oct 2003 12:31:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262691AbTJ3Rbh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Oct 2003 12:31:37 -0500
Received: from mho.net ([64.58.22.195]:14722 "EHLO sm1420")
	by vger.kernel.org with ESMTP id S262687AbTJ3Rbe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Oct 2003 12:31:34 -0500
Date: Thu, 30 Oct 2003 10:23:38 -0700 (MST)
From: Alex Belits <abelits@phobos.illtel.denver.co.us>
X-X-Sender: abelits@sm1420.belits.com
To: "Ihar 'Philips' Filipau" <filia@softhome.net>
cc: trelane@digitasaru.net,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: Things that Longhorn seems to be doing right
In-Reply-To: <3FA0F1B7.7000409@softhome.net>
Message-ID: <Pine.LNX.4.58.0310301007340.11170@sm1420.belits.com>
References: <LUlv.31e.5@gated-at.bofh.it> <M7iG.41B.7@gated-at.bofh.it>
 <MagC.82U.7@gated-at.bofh.it> <Maqe.8l3.9@gated-at.bofh.it>
 <3FA0F1B7.7000409@softhome.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Oct 2003, Ihar 'Philips' Filipau wrote:

> >>Keep in mind that just because Windows does thing a certain way
> >>doesn't mean we have to provide the same functionality in exactly the
> >>same way.
> >>Also keep in mind that Microsoft very deliberately blurs what they do
> >>in their "kernel" versus what they provide via system libraries (i.e.,
> >>API's provided via their DLL's, or shared libraries).
> >
> > Indeed, although certain things could be half-kernel, half-user
> >   (OK, 0.01% kernel, 99.99% user, e.g. userspace daemon that
> >   intercepts certain writes).  Of course, at that point, you might
> >   make a special library to interact with the daemon directly, although
> >   it's then not at all like just calling write().
> >
>
>    I beleive this is 100% user space issue.
>
>    And I think if one really want to do something like this - Gnome's
> VFS is a good candidate for this. They already have all abstractions in
> place.

  Why not just provide a general-purpose interface for:

1. Userspace-visible transactions. A userspace process can mark a set of
fd, inodes, files, or "whatever this set of processes did since now", and
tell the filesystem to keep a log of changes to that. Journaling will then
mark relevant changes (and possibly create an additional log depending on
the design, or pass the log-related information to another userspace
program), and treat them as a transaction, with the possibility of
rollback on kernel-originated error, userspace request, or, possibly, a
transaction manager daemon, that may have its own reason to fail the
transaction.

2. Update notifications. A set of files or directories, or whatever a
certain set of processes accesses, is being monitored, and the list
of changes (pages, byte ranges, lists of created/deleted directory
entries) is somehow maintained and being passed to a set of processes.
Processes can have passive monitoring (they will know what has been
changed -- good for indexers and other kinds of application-specific
daemons) or intrusive pass-through monitoring (the change is not applied
until the process confirms it, and transaction interface applies to this
if enabled -- this will be a performance hit, and can be done for, say, a
distributed transaction manager).

3. Pluggable directory generator -- a userspace process can tell the
system to make an object that looks exactly like a directory, except that
its contents are provided by the process, that is being queried when the
directory is accessed.

Obviously, the need for performance/asyncronous access and security
requirements should be addressed in the implementations of those things,
however relatively small scope of the interfaces can allow to do that in a
more or less sane manner. Then userspace can have all kinds of indexing
monstrosities, transaction-using databases, transaction managers, etc.

-- 
Alex
