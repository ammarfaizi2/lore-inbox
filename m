Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932625AbVJEORy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932625AbVJEORy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Oct 2005 10:17:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932631AbVJEORy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Oct 2005 10:17:54 -0400
Received: from 41-052.adsl.zetnet.co.uk ([194.247.41.52]:36620 "EHLO
	mail.esperi.org.uk") by vger.kernel.org with ESMTP id S932625AbVJEORx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Oct 2005 10:17:53 -0400
To: Marc Perkel <marc@perkel.com>
Cc: Luke Kenneth Casson Leighton <lkcl@lkcl.net>, linux-kernel@vger.kernel.org
Subject: Re: what's next for the linux kernel?
References: <20051002204703.GG6290@lkcl.net> <4342DC4D.8090908@perkel.com>
From: Nix <nix@esperi.org.uk>
X-Emacs: the Swiss Army of Editors.
Date: Wed, 05 Oct 2005 15:17:36 +0100
In-Reply-To: <4342DC4D.8090908@perkel.com> (Marc Perkel's message of "4 Oct
 2005 20:47:53 +0100")
Message-ID: <87oe64jben.fsf@amaterasu.srvr.nix>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Corporate Culture,
 linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 4 Oct 2005, Marc Perkel announced authoritatively:
> Reiser 4 - The idea of building a file system on top of a database is
> the right way to go. Reiser is onto something here and this is a
> technology that needs to be built upon. It's current condition is a
> little on the week side - no ACLs for example - but the underlying
> concept is ound.

Well, it's not a `technology' (whatever that means). It's an idea, and
an implementation: a unified namespace built atop a database. Parts of
it make sense (the unified namespace: look at /sys for a bunch of fairly
recent unification); much of it makes sense but is hard to implement
(e.g. plugins); much makes conceptual sense but breaks POSIX in horrible
ways (files-as-directories, possibly meta-directories with arbitrary
content, at least if you're allowed to do all POSIX-allowed things to
that content: what happens to stat() now if some bugger removes a file's
creation time or size, or moves it out to some parent directory? Does
that even make sense? Whether or not it's allowed, you've broken a good
few existing programs.)

> Novell Netware type permissions.

... are an administrative *nightmare*. One of the major advantages of
the perhaps-overly-simplistic Unix permissions model is that a simple
`ls -l' can show you the complete permissions of a lot of files in a few
screensful, in an easily-comprehensible manner.

Ever tried doing that with a directory with most files having ACLs?
Until we have better userspace tools, across-the-board ACLs are a
non-starter. Now admittedly the iprovements are minor (e.g. highlighting
things with ACLs differing from the norm), but the fact remains that
they are *not here yet*.

>                                  ACLs are a step in the right
> direction but Linux isn't any where near where Novell was back in
> 1990. Linux lets you - for example - to delete files that you have no
> read or write access rights to. Netware on the other hand prevents you
> from deleting files that you can't write to and if you have no right
> it is as if the file isn't there. You can't even see it in the
> directory.

Oh, joy. So now I can't remove a writable directory if someone else has
created a file I can't write to in it, even if that directory is owned
by me. That sounds really unpleasant to me.

What next? Forbidding unlink() of running executables?

>             Netware also has inherited permissions like Windows and
> Samba has and this is doing it right.

s/right/wrong/

Look at a NetWare permission on some file and you can't tell what the
effective permission is, because it depends on inherited ones as well.
Look at an effective permission and you can't tell which parts of it
will change if you change the inherited permission. Change an inherited
permission and some of the inheritees' permissions might suddenly make
no sense. The UI errs on the side of showing you effective permissions,
which makes most sense, but is still far from ideal.

Unix has inherited permissions in one sense: you can't get at a file
via some path if one of the directories in that path is unreadable.
Even *that* causes regular problems, such that sendmail (for instance)
needs special code to check for this case.

And you want to make this *more* complex?

Remember: complexity is the enemy of security.

>                                       File systems and individual
> directories should be able to be flagged as casesensitive/insensitive.

Only if you're willing to change POSIX to include a call to check filenames
for identity, and rewrite every POSIX app to use such a call where filenames
are compared, *and* discard one or more of the following (I think you can't
avoid losing at least two, actually):

- user-settable locales via LC_* and LANG
- the property that directories may contain only one file of a given name
- the property that a rename from name A to name B and then back to name A
  again yields a file with the same name it started with
- the property that open ("foo", ... | O_CREAT) yields a file named `foo'
  for all `foo'

I doubt that losing any of these properties would be considered
acceptable, and as for rewriting every app on earth that does filename
comparison, no chance.

It would also require case-conversion and locale-handling code, probably
including UTF-8 canoncalization code, inside the kernel. This would
greatly increase kernel complexity for a very small reward, and lead to
Al Viro's early death from cerebral aneurysm combined with involuntary
projectile vomiting. This cannot be considered a good thing.

>                            Permissions need to be fine grained and
> easy to use.

This is an impossible combination, especially if you add `secure' to
that list. Fine-grained capabilities on executable files, now *that*
is a nice thing to mostly-replace the odious setuid bit with.

> The bootup sequence of Linux is pathetic. What an ungodly mess. The

`The' bootup sequence? There are a number of alternative init systems
under development, some in use by reasonably major distros.

> FSTAB file needs to go and a smarter system needs to be developed. I

What's wrong with it? Sure, it doesn't solve all problems
(e.g. automounting; that's why we have automounters), and some of its
fields are passing obsolete (e.g.  the fs_freq field), but that doesn't
make it *bad*. Those problems it aims to solve, it solves well.

Now /etc/mtab, *that* is an abomination, and a small kernel improvement
(allowing arbitrary flag strings to be passed by mount into the kernel
solely for display in the appropriate /proc/mounts field) could
eliminate it and replace it entirely with /proc/mounts.

> I think development needs to be done to make the kernel cleaner and

This has long been a goal.

> smarter

`Smarter' is easy to *say*. Defining what it *means* is another matter.
Myself I consider the new pluggable I/O schedulers and pluggable
packet schedulers make the kernel `smarter'. Perhaps you do not.

>         rather than just bigger

This has never been a *goal*. It's a side-effect, that's all.

>                                 and faster.

Faster is important, especially on very small and very large hardware,
where unusual things can become bottlenecks.

>                                             It's time to look at what
> users need

What? Not in the kernel, it isn't. Users never see the
kernel. Sysadmins, sure; glibc, sure; users, no. Not even userspace
programs, except inasmuch as their requirements are reflected by new
demands on the kernel.

>            and try to make Linux somewhat more windows like in being
> able to smartly recover from problems.

In my experience Windows tries to smartly recover, fails, and implodes
in a heap, telling all and sundry to `contact your system
administrator'. When you *are* the system administrator, this is less
than helpful.

One thing that *would* be nice is an improvement on errno, which is
a terribly coarse-grained error handling system. Something like the
sa_siginfo field, so you can pass additional info back with errors...
but for now that can be kludged around by passing back errors by
filling up buffers passed in other parameters.

errno seems to be Good Enough, but it's... *primitive*.

(What did Plan 9 do? Error strings?)

>                                        Perhaps better error messages
> that your traditional kernel panic or hex dump screen of death.

The `traditional kernel panic' includes a backtrace; if you have kernel
syslogging or the serial console turned on, this can even work if
process scheduling and disk I/O are both dead.

Linux doesn't do `hex dump screens of death'.

A number of userspace tools like smartd provide nice warnings of some
critical non-kernel system failures in whatever way you see fit (my
systems send me an email and a page and shut themselves down if they
overheat or suffer a disk failure; much more elaborate things are
possible). But, again, this is not a kernel thing.

> The big challenge for Linux is to be able to put it in the hands of
> people who don't want to dedicate their entire life to understanding
> all the little quirks that we have become used to. The slogan should
> be "this just works"

This is the distributors' job (those who want to do that). One
disadvantage of `just works' systems is that they tend to be fiercely
complex and thus, when they *do* fail, the failures are correspondingly
hard to diagnose. (This is not always true: udev just works and is much
*less* complex than the system it replaces, with almost entirely
non-opaque failure modes. This comes, I think, of designing it properly
from the start. Kudos to Greg K-H!)

There will always be openings for less elaborate systems, I think.

>                      and is intuitive.

`The only intuitive interface is the nipple.'

> Linux Visionary

*chuckle*

-- 
`Next: FEMA neglects to take into account the possibility of
fire in Old Balsawood Town (currently in its fifth year of drought
and home of the General Grant Home for Compulsive Arsonists).'
            --- James Nicoll
