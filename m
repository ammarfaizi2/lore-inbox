Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267215AbUBSOJK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 09:09:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267264AbUBSOJK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 09:09:10 -0500
Received: from thunk.org ([140.239.227.29]:7557 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S267215AbUBSOJE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 09:09:04 -0500
Date: Thu, 19 Feb 2004 09:08:47 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: tridge@samba.org
Cc: Pascal Schmidt <der.eremit@email.de>, linux-kernel@vger.kernel.org
Subject: Re: UTF-8 and case-insensitivity
Message-ID: <20040219140847.GA5718@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>, tridge@samba.org,
	Pascal Schmidt <der.eremit@email.de>, linux-kernel@vger.kernel.org
References: <1qHAR-2Wm-49@gated-at.bofh.it> <1qIwr-5GB-11@gated-at.bofh.it> <1qIwr-5GB-9@gated-at.bofh.it> <1qIQ1-5WR-27@gated-at.bofh.it> <1qIZt-6b9-11@gated-at.bofh.it> <1qJsF-6Be-45@gated-at.bofh.it> <E1Atbi7-0004tf-O7@localhost> <16436.2817.900018.285167@samba.org> <20040219024426.GA3901@thunk.org> <16436.11148.231014.822067@samba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16436.11148.231014.822067@samba.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
X-Habeas-SWE-1: winter into spring
X-Habeas-SWE-2: brightly anticipated
X-Habeas-SWE-3: like Habeas SWE (tm)
X-Habeas-SWE-4: Copyright 2002 Habeas (tm)
X-Habeas-SWE-5: Sender Warranted Email (SWE) (tm). The sender of this
X-Habeas-SWE-6: email in exchange for a license for this Habeas
X-Habeas-SWE-7: warrant mark warrants that this is a Habeas Compliant
X-Habeas-SWE-8: Message (HCM) and not spam. Please report use of this
X-Habeas-SWE-9: mark in spam to <http://www.habeas.com/report/>.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 19, 2004 at 02:20:44PM +1100, tridge@samba.org wrote:
> Currently dnotify doesn't give you the filename that is being
> added/deleted/renamed. It just tells you that something has happened,
> but not enough to actually maintain a name cache in user space.
> 
> That could be changed, so that on a dnotify event you do a fcntl() to
> ask for the name of the file. Or perhaps we could cram it into the
> structure the signal handler gets passed? I doubt that would make
> sense, but maybe some signal guru can tell me otherwise. Maybe we
> could even invent a new dnotify system where you do a read on a file
> descriptor to get details on what event happened, and give some
> "everything has changed" error when you run out of buffers.

Yes, that's what I was suggesting.  One advantage of such a scheme is
that it's not just for Windows compatibility.  A more rich directory
change notification scheme would also be useful for graphical file
managers, automatic indexing tools, and many, many other applications.

No, it's not everything you were requesting, but it may very well
represent three-quarters of a loaf, instead of nothing.

> If that happened then we could build our own dcache in user space, but
> it will be a very second rate dcache, with a racy and slow update
> mechanism that will in itself chew cpu. Maybe thats the best we can
> do, or maybe I should be asking distro vendors if they would consider
> a case-insensitive patch, especially the vendors aiming for
> "enterprise" scalability which might include serving windows clients.

I don't know that the update mechanism has to seriously chew that much
CPU.  It can certainly can be designed to minimize the amount of CPU
that is consumed, especially if it is read via a file descriptor so
that multiple updates can be sent via a single read() system call,
instead of sending a signal every single time a directory entry is
created, renamed, or deleted.

The problem with a case-insentive patch is that for most modern
filesystems (i.e., any filesystem that does better than O(1) directory
searches), it will have to involve a format change, since the case
insensitivity has to be built into the hash function or the tree
comparison fucture, or both.  At this point, the filesystem author has
to make the choice of whether to try to solve the Windows-specific
problem, in which case the fundamental filesystem format would have to
be tailored to the Windows case mapping table, or try to solve the
more general I18N case mapping problem.  (Lots of luck!  It's
constantly changing over time as new character sets are added or
modified...)  Yes, a few such filesystems might have this support
already, but I doubt distributions would be willing to accept patches
that make filesystem format-incompatible changes just for the sake of
accelerating Samba operations.

I don't know if the distributions would be willing to accept a
case-insensitive patch, but my suspicions is that it would be
difficult, and I would argue that it might be more efficient to get a
richer directory change notification system, for the reasons I argued
above.

						- Ted
