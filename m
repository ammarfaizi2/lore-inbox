Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269067AbUIHJge@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269067AbUIHJge (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Sep 2004 05:36:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269059AbUIHJgd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Sep 2004 05:36:33 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:55255 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S269058AbUIHJg2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Sep 2004 05:36:28 -0400
Date: Wed, 8 Sep 2004 10:36:25 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Sriram Karra <karra@shakti.homelinux.net>
Cc: Hans Reiser <reiser@namesys.com>, Paul Jakma <paul@clubi.ie>,
       David Masover <ninja@slaphack.com>,
       Horst von Brand <vonbrand@inf.utfsm.cl>, Pavel Machek <pavel@ucw.cz>,
       Jamie Lokier <jamie@shareable.org>, Chris Wedgwood <cw@f00f.org>,
       Linus Torvalds <torvalds@osdl.org>, Christoph Hellwig <hch@lst.de>,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: silent semantic changes with reiser4
Message-ID: <20040908093624.GW23987@parcelfarce.linux.theplanet.co.uk>
References: <200408311931.i7VJV8kt028102@laptop11.inf.utfsm.cl> <41352279.7020307@slaphack.com> <41356321.4030307@namesys.com> <Pine.LNX.4.61.0409030037540.23011@fogarty.jakma.org> <413809EF.8060102@namesys.com> <20040903070034.GM23987@parcelfarce.linux.theplanet.co.uk> <xeq3656pnqpa.fsf@codc1-xdm1.cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xeq3656pnqpa.fsf@codc1-xdm1.cisco.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

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
