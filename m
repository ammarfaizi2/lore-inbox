Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261546AbTJWBzt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Oct 2003 21:55:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261552AbTJWBzt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Oct 2003 21:55:49 -0400
Received: from sccrmhc11.comcast.net ([204.127.202.55]:35508 "EHLO
	sccrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S261546AbTJWBzp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Oct 2003 21:55:45 -0400
Subject: Re: posix capabilities inheritance
From: Albert Cahalan <albert@users.sf.net>
To: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Cc: luto@stanford.edu
Content-Type: text/plain
Organization: 
Message-Id: <1066873310.25425.114.camel@cube>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 22 Oct 2003 21:41:51 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andy Lutomirski writes:

> I agree with these problems, but I think the proper
> fix is complicated.  AFAICT, POSIX capability
> evolution, as specified by whatever draft it was,
> is broken, so the hacks in prepare_binprm
> (cap_bprm_set_security in 2.6) are needed to avoid 
> security problems.  Aside from the fact that
> non-inheritable-by-default makes little sense
> (and requires root to get capabilities re-added
> from the file _permitted_ set), POSIX cap
> evolution has some other problems:

You've noticed!  :-)

The people who wrote the code were working from
two different drafts of the spec. I think some
people used draft 16, while others used draft 17.
(or 15 and 16, or 17 and 18 -- a difference of 1)
Between these two drafts there had been BIG changes.
Well, a critical equation changed.

People at SGI, mindlessly cloning the IRIX code,
stuck us with the half-ass set of capability bits
we have today. They ignored the DG-UX implementation
using 256 bits and slightly different equations.
They ignored the fact that the security model will
be terribly inconsistent if you still have apps
making UID-based decisions -- that is, you need to
allocate bits for glibc, XFree86, Linux vendors,
admin tools, various databases, and local site usage.
Yes it's yucky, but it's required. Covering ears
and burying the head won't make this go away.

Nobody thought to have half the bits default
to "on" for stuff currently allowed for regular
users. For example, the right to listen for
incoming network connections could be limited
if this had been given a default-enabled bit.

Then there's the emergency hack done to patch a
security hole that the capability bits introduced.
I think that was back in the early 2.4.x days.

People like to ignore the fact that apps tend
to answer "Do I need setuid-style precautions?"
by examining UID.

People like to ignore the fact that privileged
code, written with setuid in mind, can lead to
all sorts of mayhem if 42% of the privileged
operations are prohibited. Yeah, you'd hope
that a setuid app has great error checking and
can cope... but "hope" shouldn't satisfy you.
We really need a way for app authors to mark a
binary as "always block rights P, Q, and R" and
"block all rights unless given V, W, and X",
with the assumption that an unmarked app requires
an all-or-none situation.

Probably there should be two worlds on the
system. Apps with "funny" rights should be
kept away from UID 0 and setuid apps, while
apps with UID 0 or setuid should be kept
away from "funny" rights. Give the init
process a special ability to cross worlds.

The authors of our code seem to have given up
and moved on. Nobody cleaned up the mess.
Is it any wonder the POSIX draft didn't ever
make it beyond the draft state?

(and damn, WTF is with !capable(...) meaning
that you are capable of performing something?)

One final horror: just imagine trying to write
up some sane documentation for the average admin.
Poorly-understood security mechanisms are a
hazard. BTW, don't forget to imagine documenting
all the interactions with UID, filesystems, etc.

Face it: admins will think in terms of assigning
rights to users, never minding that there are
some weird equations, UID interactions, and
perhaps per-executable bits.


