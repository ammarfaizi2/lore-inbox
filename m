Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311362AbSCMVjj>; Wed, 13 Mar 2002 16:39:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311382AbSCMVjV>; Wed, 13 Mar 2002 16:39:21 -0500
Received: from 1Cust84.tnt15.sfo3.da.uu.net ([67.218.75.84]:16649 "EHLO
	morrowfield.home") by vger.kernel.org with ESMTP id <S311362AbSCMVjM>;
	Wed, 13 Mar 2002 16:39:12 -0500
Date: Thu, 14 Mar 2002 01:39:14 -0800 (PST)
Message-Id: <200203140939.BAA14739@morrowfield.home>
From: Tom Lord <lord@regexps.com>
To: reiser@namesys.com
CC: andrew@pimlott.ne.mediaone.net, lm@work.bitmover.com,
        Geert.Uytterhoeven@sonycom.com, james@and.org, lm@bitmover.com,
        jaharkes@cs.cmu.edu, linux-kernel@vger.kernel.org
In-Reply-To: <3C8FA608.6040103@namesys.com> (message from Hans Reiser on Wed,
	13 Mar 2002 22:18:32 +0300)
Subject: filesystem transactions (was Re: linux-2.5.4-pre1 - bitkeeper testing)
In-Reply-To: <20020312223738.GB29832@pimlott.ne.mediaone.net> <Pine.GSO.4.21.0203131037240.17582-100000@vervain.sonytel.be> <20020313143720.GA32244@pimlott.ne.mediaone.net> <20020313082647.Y23966@work.bitmover.com> <20020313163045.GA6575@pimlott.ne.mediaone.net> <3C8FA608.6040103@namesys.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On this thread, you (Hans) seem to be referring to some plan you have
for putting versioning functionality in the filesystem and that you
think this somehow gives you (at least significant parts of) revision
control nearly for free.  It isn't clear from just the messages in
this thread exactly what plan for versioning you have in mind.

It's an interesting topic, though.  Is there a document available that
actually specifies what you have in mind?

Leaving aside the question of remote access, a useful filesystem
primitive for revision control would be the ability to quickly create
copy-on-write clones of trees (much like the Subversion model, but as
a true file system, and without the need to store modified files as
diffs).

One could do that reasonably well entirely in user space in a portable
way by using `link(2)' to create the clones and imposing a layer
between libc `open(2)' and the kernel call, though every program on
the system would have to be linked with that special version of
`open'.  An in-kernel implementation would have the slight advantages
that it wouldn't require a special version of `open' and could,
perhaps, at the cost of some complexity, create clone trees more
cheaply when the expected case is that large subtrees will never be
modified in either the original or the copy.

Another user-space approach, less successful at creating clones
quickly but portable, venerable, and not requiring a special version
of `open' is to make the clones read-only and create them with a
program that copies modified files, but links unmodified files to
their identical ancestors in earlier clones.

One can also do cheap tree cloning reasonably well using directory
stacks and an automounter: a solution based on kernel primitives with
no particular impact on the representation of the filesystem on disk,
implementable at a higher level and compatible with all underlying
disk representations.

Of course, automated file backups of the sort described in this thread
for VMS, are not particularly helpful for revision control.

Finally, if clones really are cheap to create, that gives us an 80%
solution for generalized filesystem transactions.  Adding the ability
to do page-based copy-on-write for individual files gives us 90%.  Put
cheap and well designed user-defined name-spaces in combination
with those features, and we can watch Oracle fall down and go boom.

None of these approaches I've mentioned require anything special from
the filesystem representation on disk.  There would be a severe
portability problem and performance limitations to any approach that
does rely on a particular filesystem representation.

So, what exactly is your plan?

-t
