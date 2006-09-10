Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750844AbWIJKNm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750844AbWIJKNm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Sep 2006 06:13:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932077AbWIJKNm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Sep 2006 06:13:42 -0400
Received: from nef2.ens.fr ([129.199.96.40]:8463 "EHLO nef2.ens.fr")
	by vger.kernel.org with ESMTP id S1750844AbWIJKNl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Sep 2006 06:13:41 -0400
Date: Sun, 10 Sep 2006 12:13:38 +0200
From: David Madore <david.madore@ens.fr>
To: Theodore Tso <tytso@mit.edu>,
       Linux Kernel mailing-list <linux-kernel@vger.kernel.org>
Subject: Re: patch to make Linux capabilities into something useful (v 0.3.1)
Message-ID: <20060910101338.GA5865@clipper.ens.fr>
References: <20060905212643.GA13613@clipper.ens.fr> <20060906002730.23586.qmail@web36609.mail.mud.yahoo.com> <20060906100610.GA16395@clipper.ens.fr> <20060906132623.GA15665@clipper.ens.fr> <20060909231805.GC24906@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060909231805.GC24906@thunk.org>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.5.10 (nef2.ens.fr [129.199.96.32]); Sun, 10 Sep 2006 12:13:39 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 09, 2006 at 07:18:05PM -0400, Theodore Tso wrote:
> This is what scares me about your proposal.  I consider it a *feature*
> that unmarked executables inherit no capabilities, since many programs
> were written without consideration about whether or not they might be
> safe to run without privileges.  So the default of not allowing an
> executable to inherit capabilities is in line of the the classic
> security principle of "least privileges".   
> 
> I agree it may be less convenient for a system administrator who is
> used root, cd'ing to a colleagues source tree, su'ing to root, and who
> then types "make" to compile a program, expecting it to work since
> root privileges imply the ability to override filesystem discretionary
> access control --- and then to be rudely surprised when this doesn't
> work in a capabilities-enabled system.  However, I would claim this is
> the correct behaviour!  Would you really want some random operator
> running random Makefiles for some random program downloaded from the
> Internet?  As root?  So as far as I am concerned, forcing make, cc,
> et. al. to not inherit capabilities is a Good Thing.

But root privileges *are* inherited under Unix.  Always.  That's a
historic fact and you can't change it.  How would you explain that a
full set of capabilities gets inherited if a subset does not?  This
can only lead to crazy semantics (you need a special hack for root)
and it will mean that capabilities are almost entirely useless (as
they are now: they are almost unused because they are basically
useless) - if it is impossibly difficult to work with a subset of all
capabilities, people will use all of them, i.e., work as root as they
do now, and you have gained nothing.

Maybe I should have emphasized the following fact about my patch: when
you switch-user from root with something like setresuid(uid,uid,uid),
the permitted/effective sets can remain unaltered if the program has
requested it (using prctl(PR_SET_KEEPCAPS)), but the inheritable set
is always cleared.  Hence, if you want capabilities to be inheritable,
you have to request it explicitly.  Someone who asks that knows what
he is doing, and should be given it.

> Now, perhaps some system owners have a different idea of how they want
> to run, and believe want to trade off more convenience for less
> security.  That's fine, but please don't disable the high security
> mode for the rest of us.  What I would suggest is that perhaps the
> filesystem capabilities patch can be extended to either to allow the
> filesystem superblock define (a) what the default inheritance
> capability mask should be when creating a new file, and (b) what the
> default inheritance capability for that filesystem should be in the
> absence of an explicit capability record.  Both of these should be
> overrideable by a mount option, but for convenience's sake it would be
> convenient to be able to set these values in the superblock.

The superblock is not an option, because there are too many filesystem
types out there.  A sysctl or securebit (although changing the latter
is not implemented for now), on the other hand, would be feasible.
But very messy: first, it means putting back the root hack (need to
specially inherit the full set of permitted, resp. effective
capabilities when {r,s,e}uid==0, resp. euid==0), and second, it means
that nobody will understand the whole picture of when and how
capabilities are inherited.  (Having a rule that nobody understands is
a sure way of getting lousy security: one thing that people *do*
understand under Unix is how/that root privileges are inherited - let
capabilities follow that general rule.)

> As far as negative capabilities, I feel rather strongly these should
> not be separated into separate capability masks.  They can use the
> same framework, sure, but I think the system will be much safer if
> they use a different set of masks.  Otherwise, there can be a whole
> class of mistakes caused by people and applications getting confused
> over which bit positions indicate privileges, and which indicate
> negative privileges.  If you use a separate mask, this avoids this
> problem.

That would mean duplicating a lot of code.

> The other reason why it may not be such a hot idea to mess with the
> inheritance formulas is compatibility with other Unix systems that
> have implemented capabilities following the last Posix draft.  In
> particular, Sun has recently included the Trusted Solaris into the
> base Solaris offering and into Open Solaris, and has been plugging
> them pretty heavily.  It would be unfortunate if Solaris and Linux had
> gratuitously different semantics for how the capabilities API's work.
> It could easily cause security problems in both directions --- when
> trying to port a program written for Linux to Solaris, and vice versa.

It is a fact that POSIX got us into a deep mess by their lack of
foresight: because they couldn't agree on a standard, now everyone has
a different idea of how things should be done.  Linux and Solaris
already have different semantics in this respect, and both are
different from any POSIX draft or from Irix.  I don't think we can
"fix" the mess in this respect, now, no matter how.

The value of my proposal is that it makes root inheritance a normal
case of capability inheritance, so the normal rules of Unix apply.

> The solution is to _extend_ the capabilities system: for example, by
> adding default inheritance masks to cater for system administrators
> who value convenience more than security, and to add new bitmasks for
> negative privileges/capabilities.

Unfortunately, I believe this is impossible to do in a way that will
seem even remotely acceptable.

-- 
     David A. Madore
    (david.madore@ens.fr,
     http://www.madore.org/~david/ )
