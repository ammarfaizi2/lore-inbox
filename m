Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268878AbRG0QZI>; Fri, 27 Jul 2001 12:25:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268879AbRG0QY6>; Fri, 27 Jul 2001 12:24:58 -0400
Received: from ACAP-DEV.NAS.CMU.EDU ([128.2.6.63]:47622 "EHLO
	acap-dev.nas.cmu.edu") by vger.kernel.org with ESMTP
	id <S268878AbRG0QYt>; Fri, 27 Jul 2001 12:24:49 -0400
Date: Fri, 27 Jul 2001 12:24:56 -0400
Message-Id: <200107271624.f6RGOu8U010566@acap-dev.nas.cmu.edu>
From: Lawrence Greenfield <leg+@andrew.cmu.edu>
X-Mailer: BatIMail version 3.2
To: linux-kernel@vger.kernel.org
In-Reply-To: <3B60EDD3.2CE54732@zip.com.au>
Subject: Re: ext3-2.4-0.9.4
In-Reply-To: <20010726174844.W17244@emma1.emma.line.org> <E15PnTJ-0003z0-00@the-village.bc.nu> <9jpftj$356$1@penguin.transmeta.com> <20010726095452.L27780@work.bitmover.com>,		<20010726095452.L27780@work.bitmover.com> <996167751.209473.2263.nullmailer@bozar.algorithm.com.au> <3B60EDD3.2CE54732@zip.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Hi,

I'm one of those icky application programmers attempting to make
reliable software across different versions of Unix.

We need to get data to disk portably, quickly, and reliably.

I love it when I see things like:  "No, Linus is right and the MTA
guys are just wrong."

This sort of attitude is just ridiculous.  Unix had a defined set of
semantics.  This might have been stupid semantics, but it had them.
Then journalling filesystems, softupdates, and Linux async updates
came along and destroyed those semantics, preventing those of us who
want to write reliable applications using the filesystem from doing
so.  At least Oracle doesn't change the definition of COMMIT.

When I contacted the Linux JFS team about the semantics of link(), I
was told that there is _no way_ of forcing a link() to disk.  Not an
fsync() on the file, not an fsync() on the directory, just _not
possible_.

Great.

Then we come to ext2.  "Oh, just call fsync() on the directory and
you'll be fine."  Well, wait, a second, if ext2 isn't ordering the
metadata writes, a crash at the wrong time (whether or not I've called
fsync()) may lose directory entries---even directory entries unrelated
to the files I'm doing operations on!  Greeeeat.

Thus why all reasonably paranoid MTAs and other mail programs say "use
chattr +S on ext2"---we need ordered metadata writes.

Ok, journalled filesystems are better.  At least crashes aren't going
to affect random files on disk.  But since link() and the like don't
force a commit, we need some way---some reasonably portable way---of
getting that on disk.  On softupdates, calling fsync() on a file
forces all directory entries pointing to that file to disk.  This is
pretty reasonable.  1 fsync() call.

Why do we all cringe when we're told to call fsync() on the directory?
Several reasons:
. not needed on any other variety of Unix
. two fsync() calls force two different syncronization points: the
  application is forcing ordering on the OS that may not be needed.
  (Thus performance doesn't "fly" when you need multiple fsyncs.)
. directory may have other modifications going on that we're not
  interested in

You want to help performance?  Give us an fsync() that works on
multiple file descriptors at once, or an async fsync() call.  Don't
make us fight the OS on getting data to disk.

Larry

