Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267353AbUGNTDl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267353AbUGNTDl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jul 2004 15:03:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267382AbUGNTDl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jul 2004 15:03:41 -0400
Received: from zeus.kernel.org ([204.152.189.113]:61317 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S267353AbUGNTDW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jul 2004 15:03:22 -0400
Subject: Re: XFS: how to NOT null files on fsck?
To: cw@f00f.org (Chris Wedgwood)
Date: Wed, 14 Jul 2004 20:49:03 +0200 (CEST)
From: "Anton Ertl" <anton@mips.complang.tuwien.ac.at>
Cc: linux-kernel@vger.kernel.org, jk-lkml@sci.fi (Jan Knutar),
       lkml@tlinx.org (L A Walsh)
In-Reply-To: <20040713203246.GB6614@taniwha.stupidest.org>
Reply-To: anton@mips.complang.tuwien.ac.at
X-Mailer: ELM [version 2.5 PL7]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E1BkooR-0003OC-Em@a4.complang.tuwien.ac.at>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wedgwood wrote:
> 
> On Tue, Jul 13, 2004 at 03:33:23PM +0200, Anton Ertl wrote:
> 
> > If the owner of the file is not the former owner of the block, the FS
> > certainly should not put the block in the file.
> 
> sorry, i dont understand that

I'll try to put it another way:

If a free block was last allocated to a file belonging to user U, then
it may be ok (it's not a security problem) to put the block in a
file belonging to user U on recovery; if not, then it's certainly not
ok to put it into such a file without erasing it first.

If you don't understand that, please let me know where I am losing
you.

> > How do you test?
> 
> running the code and pressing reset or similar

Ok, I was thinking about this testing methodology, too.  That's not
what I call easy, and it has led to the current situation where many
applications are not safe against the not-so-nice crash semantics of
many file systems.

> > Right, but that's not sufficient.  I am not an expert on ext3, but
> > from the description I have read that's all it guarantees.  If an
> > application does a meta-data update, and then a data update, the
> > disk state on crash might be that the data update was done and the
> > meta-data update was not, which is not any of the states that ever
> > existed logically.
> 
> i don't see how for ordered updates that can occur,  otherwise they
> wouldn't be ordered

Full-blown ordering is hard in a file system that overwrites allocated
blocks.  E.g., consider writing a little bit to block A, then writing
something to block B, then writing something to block A again.  For
proper in-order semantics these writes have to occur in that order,
and the first write to block A must not already include the second
write; this becomes complicated with lazy writing.  Soft Updates do
funny things with the cache to get the ordering of operations right.

I don't know if ext3 data=ordered does any of this, but the
description "data updates are flushed to disk before transactions
commit" does not sound like it does.

OTOH, the data=ordered approach may be good enough for most
applications (which deal with whole files rather than changes to parts
of a file), so maybe any further effort will not provide enough
benefit to gain much popularity.  It's certainly much nicer than any
eager-meta-data-update system like (apparently) XFS.

> > Applications can be tested against that relatively easily by killing
> > the application and seeing if the files are ok.
> 
> i've seen both KDE emacs loose data by crashing, does the fix for that
> belong in the fs too?

Application crashing?  No; I don't see how the file system can fix
that.

I have never seen Emacs lose data from crashing or (more frequently)
being killed.  Do you have an idea what went wrong in your case and
how they 

In any case, if the developers have a hard time protecting even
against application crashes/kills, I would not expect them to go to
the effort and succeed in protecting against not-so-nice FS crash
semantics.

> > I am talking about ways that data can be lost because the file
> > system does not have the nice semantics of a fully synchronous one.
> 
> mount -o sync

Very slow, and I would not trust it, because it probably receives very
little testing.

> > The in-order guarantee is something that can be implemented
> > relatively efficiently
> 
> let's see a patch, please give details of performance differences

Take a look at <http://www.complang.tuwien.ac.at/czezatke/lfs.html>.
For performance results look at Section 7 of
<http://www.complang.tuwien.ac.at/papers/czezatke%26ertl00/>.  I would
not recommend using that stuff instead of any of the established FSs,
but it may be good enough to answer your questions.

> what you want a much more high-level semantics in the filesystem which
> possibly will have large performance implications.

I don't think that the performance implications are large in typical
situations, in crontrast to the solution you proposed (mount -o sync).

>  im not sure such
> semantics are *required* to be in the fs or should be there

Required by whom?  Me?  Yes!

> also, this is fixing the relatively rare case where the system
> crashes, which to be quite honest is a bigger concern, why no seek
> solutinos that deal with more common failure modes like applications
> crashing or bahaving badly?

What I am proposing is extending the solutions for that to also work
for the system crash case.  This will increase the incentive for the
programmers to fix the application crash case.

BTW, the way my current hardware acts up, system crashes are more
frequent than application crashes, and certainly more frequent than
applications behaving badly.

- anton

