Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262128AbTJXMmH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Oct 2003 08:42:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262161AbTJXMmG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Oct 2003 08:42:06 -0400
Received: from thunk.org ([140.239.227.29]:52096 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S262128AbTJXMmB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Oct 2003 08:42:01 -0400
Date: Fri, 24 Oct 2003 08:41:50 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Andy Lutomirski <luto@stanford.edu>
Cc: linux-kernel@vger.kernel.org, glasgow@beer.net,
       albert@users.sourceforge.net
Subject: Re: posix capabilities inheritance
Message-ID: <20031024124150.GA5609@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Andy Lutomirski <luto@stanford.edu>, linux-kernel@vger.kernel.org,
	glasgow@beer.net, albert@users.sourceforge.net
References: <fa.n4rmmgg.2423pm@ifi.uio.no> <fa.l1oevhb.1s5k583@ifi.uio.no> <3F98E674.6090104@stanford.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F98E674.6090104@stanford.edu>
User-Agent: Mutt/1.5.4i
X-Habeas-SWE-1: winter into spring
X-Habeas-SWE-2: brightly anticipated
X-Habeas-SWE-3: like Habeas SWE (tm)
X-Habeas-SWE-4: Copyright 2002 Habeas (tm)
X-Habeas-SWE-5: Sender Warranted Email (SWE) (tm). The sender of this
X-Habeas-SWE-6: email in exchange for a license for this Habeas
X-Habeas-SWE-7: warrant mark warrants that this is a Habeas Compliant
X-Habeas-SWE-8: Message (HCM) and not spam. Please report use of this
X-Habeas-SWE-9: mark in spam to <http://www.habeas.com/report/>.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 24, 2003 at 01:44:36AM -0700, Andy Lutomirski wrote:
> 
> 1. pI is currently almost useless.  If a process really wants a capability 
> to be dropped after exec, it can drop it itself.  So redefine pI to mean 
> "these are the only capabilities that this process or its children may 
> _ever_ hold."

A lot of the reasons why it looks useless is because we don't have
filesystem support.  The intent behind the POSIX capabilities system
is that system administrator can control which privileges are
conferred upon a program when it is exec'ed, as well as which
privileges it is allowed to inherit.  (The idea behind this is that
even if the exec'ing process wishes to bequeath some super-user
capabilities across an exec, unless that program has been audited and
cleared by the site security officer as being cleared to accept that
additional capability, it shouldn't be given it.)  In addition, of
course, the exec'ing process ought to be allowed to control what
capabilities it is willing to bequeth.  

Hence the capabilities inheritance algorithm of:

	pP' = fP | (fI & pI)

> 2. fE is useless.  It doesn't seem to have much of a point, and it just 
> adds complexity.  (e.g. look at Windows privileges.  they start unenabled, 
> and programs have to jump through hoops to use them.  I see no security 
> benefit.) So remove fE entirely.

It has a lot of point.  It's there for the same reason why just
because you have the root password, you don't want to run as root all
the time.  (At least, sane people don't...)  You might make mistakes.  

A very basic rule of security is that you only use the least amount of
privileges to get the job done.  That way, if you make a mistake, and
get tricked into accessing the wrong file (say, because you failed to
check for .. in pathnames supplied by an untrusted user), you limit
the amount of damage done because of your bone-headed mistake.

Is this more complexity?  Yes.  But security generally means more
complexity.  Deal with it.  If you don't like, it you can just always
run with fE set to fP, just as you just login as root and run with
root privileges all the time.  As long as you're careful, and never
accidentally type the command rm -rf /, why bother with non-root
accounts on a single-user machine?

(And if you really need help answering that question, then let's just
agree to disagree, and remind me to never hire you to be a system
administrator on any of my machines....)

> 3. The current use of the capability bits is not as fine-grained as it 
> could be, and lacks the ability to restrict normal users.  

No.  Bad, bad, bad, bad, bad idea.

A lot of the rules of when capabilities can be dropped and inherited
assume that capabilities enhance privileges, and do not take
privileges away.  A very different calculus emerges when you start
restricting what a normal user can do, especially when this mixes with
setuid (non-root) or setgid programs.  A lot of programs don't do
error checking, and if you can change basic assumptions of what works
and doesn't work, you can actually cause security breaches where none
previously existed.

One of the reasons why fP, fE, and fI are all set to zero was because
in a previous attempt to try to emulate capabilities, the old
"backwards compatibility" algorithm of how to treat setuid root
programs allowed the exec'ing process to control what privileges could
be inherited by a setuid root program.  This was really bad, since it
meant that a setuid root program could have some capabilities (such as
filesystem descretionary access controls override), but not others,
and a failure to check error returns (since after all a setuid root
program would *always* succeed, right?), caused a security hole.

It is for similar reasons that chroot requires root privileges.  One
might think that restricting what part of the filesystem can be seen
by a process shouldn't require root privileges, except that by
changing the environment, it can fool setuid or setgid programs into
doing the wrong thing.

So any scheme that restricts normal user privileges **must** have
different access controls and different semantics than schemes which
allow a process with superuser privileges from dropping some or all of
its capabilities.  It's fundamentally a different thing, and should
not be conflated together.  That way only lies madness.  (And security
holes.)

						- Ted
