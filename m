Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267254AbUIJHfB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267254AbUIJHfB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Sep 2004 03:35:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267313AbUIJHe7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Sep 2004 03:34:59 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:56511 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S266845AbUIJHdY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Sep 2004 03:33:24 -0400
Date: Fri, 10 Sep 2004 08:33:17 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Hans Reiser <reiser@namesys.com>
Cc: Paul Jakma <paul@clubi.ie>, "Theodore Ts'o" <tytso@mit.edu>,
       Robin Rosenberg <robin.rosenberg.lists@dewire.com>,
       William Stearns <wstearns@pobox.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: silent semantic changes in reiser4 (brief attempt to document the idea ofwhat reiser4 wants to do with metafiles and why
Message-ID: <20040910073317.GL23987@parcelfarce.linux.theplanet.co.uk>
References: <Pine.LNX.4.58.0409071658120.2985@sparrow> <200409080009.52683.robin.rosenberg.lists@dewire.com> <20040909090342.GA30303@thunk.org> <4140ABB6.6050702@namesys.com> <Pine.LNX.4.61.0409092136160.23011@fogarty.jakma.org> <4140FBE7.6020704@namesys.com> <Pine.LNX.4.61.0409100212080.23011@fogarty.jakma.org> <414135E6.8050103@namesys.com> <20040910055308.GJ23987@parcelfarce.linux.theplanet.co.uk> <4141560E.1090000@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4141560E.1090000@namesys.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 10, 2004 at 12:21:50AM -0700, Hans Reiser wrote:
> I don't think that "Liar." is an appropriate response.

To a bold-faced lie?  Yes, it is.

> If you sent a 
> response, just quote it.

I've already posted Message-Id, but if you prefer a quote, fine, here it is:

============================================================================
On Wed, Sep 08, 2004 at 01:21:45PM +0530, Sriram Karra wrote:
> Perhaps this is one? Message-ID: <413578C9.8020305@namesys.com>

OK...

One note before replying: current code deadlocks even if you make ->link()
*ALWAYS* return an error.  It doesn't get to calling the method.  No amount
of "disallow hard links to <something>" is going to help here, obviously.

<quote>
Cycle detection:

We should either 1) make hard links only link to the file aspect of the
file-directory duality, and persons who want to link to the directory
aspect must use symlinks (best short term answer), or 2) ask Alexander
Smith to help us with applying his cycle detection algorithm and gain
the benefit of being able to hard link to directories (if it works well,
best long term answer).
</quote>

... which doesn't address the problem at all.  The question is what to do
with seeing directory "aspect..." in more than one place when we have many
links to file in question.  So much for (1).  And (2) is not feasible with
on-disk fs both due to memory, CPU and IO costs _and_ due to exclusion from
hell you'll need to make it safe.

Re: ambiguity - lots and lots of handwaving on both sides.  FWIW, I agree
with Hans in one (and only one) respect here - openat() as a primary API
(and not a convenient libc function) is an atrocity.  Simply because it
doesn't address operations beyond open (unlinkat(2), anyone?).

However, I still haven't seen any strong arguments for need of this "metas"
stuff _or_ the need to export mode/ownership as files, both for regular
files and for directories.  Aside of "we can do that" [if we solve the
locking issues] and "xattrs are atrocious" [yes, they are; it doesn't make
alternative mechanism any better] there was nothing that even pretended to
be a technical reason.

Note that we also have fun issues with device nodes (Linus' "show partitions"
vs. "show metadata from hosting filesystem"), which makes it even more dubious.
We also have symlinks to deal with (do they have attributes?  where should
that be exported?).

Reserved names have one more problem: to be useful, they'd have to be
hardcoded into applications.  And that will create hell with use of
such applications on existing filesystems.  Again, no feasible scheme
to deal with that in userland code had been proposed so far, AFAICS.

Locking: see above - links to regular files would create directories seen
in many places.  With all related issues...
