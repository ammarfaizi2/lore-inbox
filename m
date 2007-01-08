Return-Path: <linux-kernel-owner+w=401wt.eu-S932094AbXAHUwb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932094AbXAHUwb (ORCPT <rfc822;w@1wt.eu>);
	Mon, 8 Jan 2007 15:52:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932663AbXAHUwb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Jan 2007 15:52:31 -0500
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2]:47352 "EHLO
	filer.fsl.cs.sunysb.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932094AbXAHUw2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Jan 2007 15:52:28 -0500
Date: Mon, 8 Jan 2007 15:51:31 -0500
Message-Id: <200701082051.l08KpV8b011212@agora.fsl.cs.sunysb.edu>
From: Erez Zadok <ezk@cs.sunysb.edu>
To: Andrew Morton <akpm@osdl.org>
Cc: "Josef 'Jeff' Sipek" <jsipek@cs.sunysb.edu>, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, hch@infradead.org, viro@ftp.linux.org.uk,
       torvalds@osdl.org, mhalcrow@us.ibm.com,
       David Quigley <dquigley@cs.sunysb.edu>, Erez Zadok <ezk@cs.sunysb.edu>
Subject: Re: [PATCH 01/24] Unionfs: Documentation 
In-reply-to: Your message of "Mon, 08 Jan 2007 11:18:52 PST."
             <20070108111852.ee156a90.akpm@osdl.org> 
X-MailKey: Erez_Zadok
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20070108111852.ee156a90.akpm@osdl.org>, Andrew Morton writes:
> On Sun,  7 Jan 2007 23:12:53 -0500
> "Josef 'Jeff' Sipek" <jsipek@cs.sunysb.edu> wrote:
> 
> > +Modifying a Unionfs branch directly, while the union is mounted, is
> > +currently unsupported.
> 
> Does this mean that if I have /a/b/ and /c/d/ unionised under /mnt/union, I
> am not allowed to alter anything under /a/b/ and /c/d/?  That I may only
> alter stuff under /mnt/union?
> 
> If so, that sounds like a significant limitation.

This is worth a discussion.  While I agree with Shaya's point that this is
no different than editing a raw disk partition directly, there's a
difference here in that the lower layer here is exposing something that
users use all the time -- a namespace tree.  So while most users know not to
muck with a raw disk of a mounted f/s, they don't know they're not supposed
to modify a lower f/s of a stackable f/s.

BTW, this is a problem with all stackable file systems, including ecryptfs.
To be fair, our Unionfs users have come up against this problem, usually for
the first time they use Unionfs :-).  Then we tell not to do that, but that
if they have to, to run "uniondbg -g" afterward to force a flushing of
Unionfs caches.  This practical suggestion worked well for our Unionfs users
so far.

Now, we've discussed a number of possible solutions.  Thanks to suggestions
we got at OLS, we discussed a way to hide the lower namespace, or make it
readonly, using existing kernel facilities.  But my understanding is that
even it'd work, it'd only address new processes: if an existing process has
an open fd in a lower branch before we "lock up" the lower branch's name
space, that process may still be able to make lower-level changes.
Detecting such processes may not be easy.  What to do with them, once
detected, is also unclear.  We welcome suggestions.

The ultimate solution is to revise the page cache and VM subsystem to have a
Unified Cache Manager, as John Heidemann did in 1995 (see SOSP'95).  But
that's a huge amount of work and it's unclear that it's worth the added
complexity.

Our goal in this (large) set of Unionfs patches was to try and keep it as
small, understandable, and stable as possible.  If, however, the community
feels that we should address these concerns, we'd be happy to.  But first
we'd like to hear what the community thinks might be the best solution to
this that balances functionality with the desire to keep complexity down.

Another possibility is that after, hopefully, both Unionfs and ecryptfs are
in, and some more user experience has been accumulated, that we'll look into
addressing this page-cache consistency problem for all stacked f/s.

> > Any such change can cause Unionfs to oops, or stay
> > silent and even RESULT IN DATA LOSS.
> 
> With a rather rough user interface ;)

Jeff, I don't think it's acceptable to OOPS.  If I recall, when ext3 detects
a severe corruption of its data structures (often due to hardware
disk/memory errors), it will sometimes downgrade the file system into
readonly mode; this emergency procedure is meant to reduce the chance of
further corruption.  If we know of obvious cases in which Unionfs oopses
when someone modifies lower files, then we should address them in a similar
manner.  Better yet, if in some cases we suspect someone modified lower
files, then one possibility is to flush unionfs's caches (ala uniondbg -g),
which would presumably sync up unionfs's cached info.

> Also, is it possible to add new branches to an existing union mount?  And
> to take old ones away?

Yes, you can add branches, remove branches, and upgrade/downgrade them b/t
readonly and readwrite.  We used to allow this on any of the branches, even
inserting/deleting in the middle, and it worked.  But that complicated the
code considerably, and after a couple of years of experience, we found out
that most users just wanted to add/del a new top-level branch.  So we
stripped out the older, more complicated code.  What we have in this set of
patches allows users to add/del/change top-level branches mostly.

Cheers,
Erez.
