Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267205AbUIJISm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267205AbUIJISm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Sep 2004 04:18:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267223AbUIJISm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Sep 2004 04:18:42 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:10704 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S267205AbUIJISa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Sep 2004 04:18:30 -0400
Date: Fri, 10 Sep 2004 09:18:27 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Hans Reiser <reiser@namesys.com>
Cc: Paul Jakma <paul@clubi.ie>, "Theodore Ts'o" <tytso@mit.edu>,
       Robin Rosenberg <robin.rosenberg.lists@dewire.com>,
       William Stearns <wstearns@pobox.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: silent semantic changes in reiser4 (brief attempt to document the idea ofwhat reiser4 wants to do with metafiles and why
Message-ID: <20040910081827.GM23987@parcelfarce.linux.theplanet.co.uk>
References: <20040909090342.GA30303@thunk.org> <4140ABB6.6050702@namesys.com> <Pine.LNX.4.61.0409092136160.23011@fogarty.jakma.org> <4140FBE7.6020704@namesys.com> <Pine.LNX.4.61.0409100212080.23011@fogarty.jakma.org> <414135E6.8050103@namesys.com> <20040910055308.GJ23987@parcelfarce.linux.theplanet.co.uk> <4141560E.1090000@namesys.com> <20040910073317.GL23987@parcelfarce.linux.theplanet.co.uk> <41415BCF.9090405@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41415BCF.9090405@namesys.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 10, 2004 at 12:46:23AM -0700, Hans Reiser wrote:
> >file-directory duality, and persons who want to link to the directory
> >aspect must use symlinks (best short term answer), or 2) ask Alexander
> >Smith to help us with applying his cycle detection algorithm and gain
> >the benefit of being able to hard link to directories (if it works well,
> >best long term answer).
> ></quote>
> >
> >... which doesn't address the problem at all.  The question is what to do
> >with seeing directory "aspect..." in more than one place when we have many
> >links to file in question. 
> >
> You don't allow people to see the directory aspect in more than one 
> place.....

And which place would that be?  Concrete example: we have 4 links to the
same inode in /bin - /bin/gzip, /bin/gunzip, /bin/zcat and /bin/uncompress.
What should happen upon attempts to look at the metadata of /bin/gzip and
/bin/gunzip simultaneously from completely unrelated processes?  Where
can these guys be found and in case if you say "whoever looks first wins,
another guy gets -EBUSY or some other error" keep in mind that user-triggerable
DoS tend to make sysadmins quite unhappy.
 
> >So much for (1).  And (2) is not feasible with
> >on-disk fs both due to memory, CPU and IO costs _and_ due to exclusion from
> >hell you'll need to make it safe.
> > 
> >
> Your statement regarding 2) is unsupported by technical argument and I 
> think wrong as well.

Uhh...  Hans, think for a second - any algorithm would have to be able to
tell if adding an edge to graph would create a loop.  Consider the following
graph: take two full binary trees of depth N, order their leaves, revert the
edges in one of them and for each leaf of the first tree add an edge leading
to corresponding leaf of the second one.  (IOW, for N=2 you'll get 14 nodes
with the following edges: A->A0, A->A1, A0->A00, A0->A01, A1->A10, A1->A11,
A00->B00, A01->B01, A10->B10, A11->B11, B00->B0, B01->B0, B10->B1, B11->B1,
B0->B, B1->B).  Now, give that tree to your algorithm and start asking if
adding an edge between given two nodes would add a loop.  You'll get
exponential time complexity.  Moreover, the number of nodes you would have
to examine is also exponential.

Note that guy specifically mentioned that his filesystem had been in-core
one.  With disk-based fs you'll either have to keep the entire graph
in-core *or* you will have to walk the damn thing pulling it from disk.

And you need an exclusion against graph modifications while you are looking
through it.  Have fun...

> >Re: ambiguity - lots and lots of handwaving on both sides.  FWIW, I agree
> >with Hans in one (and only one) respect here - openat() as a primary API
> >(and not a convenient libc function) is an atrocity.  Simply because it
> >doesn't address operations beyond open (unlinkat(2), anyone?).
> >
> >However, I still haven't seen any strong arguments for need of this "metas"
> >stuff _or_ the need to export mode/ownership as files, both for regular
> >files and for directories.  Aside of "we can do that" [if we solve the
> >locking issues] and "xattrs are atrocious" [yes, they are; it doesn't make
> >alternative mechanism any better] there was nothing that even pretended to
> >be a technical reason.
> > 
> >
> Closure is very technical as a reason. It seems to be above your head 
> though. I can say more about it, but not before bed....

The word "closure" has more than enough meanings, so I am afraid that
unless you care to specify what exactly you are talking about it will
remain above my head - I am not a telepath.
