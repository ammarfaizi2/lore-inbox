Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268218AbRG2XT2>; Sun, 29 Jul 2001 19:19:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268220AbRG2XTS>; Sun, 29 Jul 2001 19:19:18 -0400
Received: from barbados.bluemug.com ([63.195.182.101]:7442 "EHLO
	barbados.bluemug.com") by vger.kernel.org with ESMTP
	id <S268218AbRG2XTF>; Sun, 29 Jul 2001 19:19:05 -0400
Date: Sun, 29 Jul 2001 16:19:03 -0700
To: linux-kernel@vger.kernel.org
Subject: Re: ext3-2.4-0.9.4
Message-ID: <20010729161902.P30957@bluemug.com>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <20010729011552.B9350@emma1.emma.line.org> <Pine.LNX.4.33L.0107282046560.11893-100000@imladris.rielhome.conectiva> <20010729020812.D9350@emma1.emma.line.org> <20010728195132.M30957@bluemug.com> <20010729112810.C9109@emma1.emma.line.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010729112810.C9109@emma1.emma.line.org>
X-PGP-ID: 5C09BB33
X-PGP-Fingerprint: C518 67A5 F5C5 C784 A196  B480 5C97 3BBD 5C09 BB33
From: Mike Touloumtzis <miket@bluemug.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Sun, Jul 29, 2001 at 11:28:10AM +0200, Matthias Andree wrote:
> 
> How can autoconf figure if you need to fsync() the directory? Apart from
> that, which Unix MTA uses autoconf?

My point was not that they should be using autoconf;
I don't know if they are or not.  My point was that
they should use existing published interfaces that are
reasonable, rather than push for guarantees that impose
new requirements on filesystems.  And even without
autoconf it's not hard to figure out what system you're
running on.

    rename(tmpfile, spoolfile);
#ifdef __linux___
    fsync(tmpdir);
    fsync(spooldir);
#endif
    /* transaction is complete */

> 
> Remember, the whole discussion is about getting rid of the need for
> chattr +S and offering the admin the chance to mount or flag a directory
> for synchronous meta data updates.

Right; and I'm arguing that the way to get rid of the need
for chattr +S is to incorporate directory fsync() in the
MTAs, not to cram more features into the filesystems.

Problem: MTA needs to know when rename() has been forced
to disk.

Solution 1: MTA authors use fsync(dirfd) on Linux.

Analysis: This is not the most portable solution, but it
should work on any FS that supports Linux semantics.  You
can't expect such semantics on FAT and other filesystems
that are just supported for compatibility reasons.  But you
could, say, switch filesystems for performance reasons, and
not have your MTA start mysteriously failing, because you
are using the official, documented API to do what you want
to do (at the very least you would be in a much stronger
position when pushing a bug fix :-).

Solution 2: Linux semantics are changed so that rename()
returns only when the data hits the disk.  All filesystems
are expected to implement this change.

Analysis: This sucks.  It precludes some filesystem design
choices, prevents users from making a speed/reliability
tradeoff, and makes each filesystem more complex.

Solution 3: Some filesystems implement synchronous
directory updates for renames, using filesystem-specific
feature flags, chattr, etc.

Analysis: I wouldn't want to try to dictate anything to
the FS authors, but this solution seems inferior to me.
Each filesystem would have to implement such a flag to
become "MTA compatible".  Why add a complex feature to the
filesystem when it can already be accessed via a userspace
API?  It will be more complex for administrators too --
they will have to know which filesystems implement the
synchronous directory metadata.

There are lots of filesystems out there.  Why not use
an interface they should all support rather than ask for
per-filesystem, filesystem-specific improvements?

miket
