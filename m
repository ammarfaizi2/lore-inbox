Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751244AbWGYMnS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751244AbWGYMnS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jul 2006 08:43:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751245AbWGYMnS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jul 2006 08:43:18 -0400
Received: from pool-72-66-202-44.ronkva.east.verizon.net ([72.66.202.44]:26051
	"EHLO turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S1751244AbWGYMnS (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jul 2006 08:43:18 -0400
Message-Id: <200607251243.k6PChFFS023856@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.2
To: Joshua Hudson <joshudson@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: what is necessary for directory hard links
In-Reply-To: Your message of "Mon, 24 Jul 2006 21:49:01 PDT."
             <bda6d13a0607242149j4f1492ag47bd8e3e1f0607da@mail.gmail.com>
From: Valdis.Kletnieks@vt.edu
References: <6ARGK-19L-5@gated-at.bofh.it> <6B8og-1iB-17@gated-at.bofh.it> <E1G4Kpi-0001Os-AK@be1.lrz> <bda6d13a0607221113s7e583492x783651eb9613b87f@mail.gmail.com> <17604.27801.796726.164279@gargle.gargle.HOWL> <200607240725.k6O7PTp1012347@turing-police.cc.vt.edu> <bda6d13a0607240921x78049eefraae775e4c6c0ba5c@mail.gmail.com> <200607241822.k6OIMJcY014229@turing-police.cc.vt.edu>
            <bda6d13a0607242149j4f1492ag47bd8e3e1f0607da@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1153831394_4984P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Tue, 25 Jul 2006 08:43:14 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1153831394_4984P
Content-Type: text/plain; charset="us-ascii"
Content-Id: <23847.1153831394.1@turing-police.cc.vt.edu>

On Mon, 24 Jul 2006 21:49:01 PDT, Joshua Hudson said:
> On 7/24/06, Valdis.Kletnieks@vt.edu <Valdis.Kletnieks@vt.edu> wrote:

> [case of 3^4 directories ]
> > Yes, you have to search *every* directory under x, y, and z.
> With a mesh graph like that one, you are right.  Rather like my
> test cases to see if the  loop-detection algorithm is working.

And why bother allowing it, if a mesh like that isn't something you want
to support and do it well?

> > And this is an artificially small
> > directory tree.  Think about a /usr/src/ that has 4 or 5 linux-kernel
> > trees in it, with some 1,650 directories per tree...
> Interesting case.

Not an "interesting case" - that's the real world.  You allow hard
links to directories, somebody on this list *is* going to hardlink their
directory of driver code into several kernel trees so they can regression
test compiles against multiple trees.

You don't want to deal with the results of allowing that, don't allow that. ;)

> > > So what it's going to do is try to find z under /a/b/c/d.
> >
> > Even if that's sufficient (which it isn't), it's going to be painful to lock
> > the filesystem for 20 or 30 seconds while you walk everything to make sure
> > there's no problem.
> 
> Maybe someday I'll work out a system by which much less is locked.
> Conceptually, all that is requred to lock for the algorithm
> to work is creating hard-links to directories and renaming directories
> cross-directory.

You need to lock a *lot* of stuff - otherwise 2 separate links can race and
form a loop, even though they are operating in very different parts of
the directory graph.

You can't even answer the question "Will a proposed link cause a loop?"
without locking the tree, since you have to search the whole tree.  An
apparently unrelated change in a part of the tree you've already searched
can cause a loop because what you started with isn't what you finished
with (see the unrelated thread about locking or copying the process list
so 'ps' doesn't race for the sort of issues involved).

> > (which it isn't)
> Counterexample? I should swear that any cycle created by rename must
> pass through the new parent into the victim and back to the new parent.

> > So what it's going to do is try to find z under /a/b/c/d.

I meant that 'z' may not be "under" a/b/c/d in the conventional sense -
the criterion is the much flabbier "must be reachable from" (which leads
to the "have to enumerate the whole frikking filesystem" issue).  d could
contain a link back "up" to e/f/g, which links back "down" to 'h/i/j/k",
and h/i/j/k/l has a link back "up" to something that eventually leads to z.

And you still haven't explained what '..' means in this context.  I'm
sure programmers will be *thrilled* to have to deal with this:

mkdir a b c
mkdir b/a b/d a/a
ln b/a a/z
ln c/b b/a
# Now watch the fun with a context-sensitive '../a':
cd a/z; cd ../a <- succeeds, but leaves you elsewhere
cd b/a; cd ../a <- succeeds, and leaves you where you started
cd c/a; cd ../a <- fails

(To be fair, most programs that have issues with this are racy against
renames of ../a already - but this one can cause fun and games even on a
filesystem mounted r/o and apparently immutable...)

--==_Exmh_1153831394_4984P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.4 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFExhHicC3lWbTT17ARAmP+AKCZjt0GBzC5fTmCVU61tgwwBTfAhQCeMP1p
gxIG9VZwbYHmkDSM9W7aKWg=
=lGeu
-----END PGP SIGNATURE-----

--==_Exmh_1153831394_4984P--
