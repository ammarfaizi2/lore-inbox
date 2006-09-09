Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751150AbWIIALQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751150AbWIIALQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Sep 2006 20:11:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751191AbWIIALQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Sep 2006 20:11:16 -0400
Received: from web36612.mail.mud.yahoo.com ([209.191.85.29]:11950 "HELO
	web36612.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751150AbWIIALO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Sep 2006 20:11:14 -0400
Message-ID: <20060909001113.97649.qmail@web36612.mail.mud.yahoo.com>
X-RocketYMMF: rancidfat
Date: Fri, 8 Sep 2006 17:11:13 -0700 (PDT)
From: Casey Schaufler <casey@schaufler-ca.com>
Reply-To: casey@schaufler-ca.com
Subject: Re: patch to make Linux capabilities into something useful (v 0.3.1)
To: David Madore <david.madore@ens.fr>,
       Linux Kernel mailing-list <linux-kernel@vger.kernel.org>
Cc: Pavel Machek <pavel@ucw.cz>
In-Reply-To: <20060908225118.GB877@clipper.ens.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--- David Madore <david.madore@ens.fr> wrote:

> On Fri, Sep 08, 2006 at 12:52:39PM +0200, Pavel
> Machek wrote:
> > Well, you claim it is as safe as possible, and it
> is not quite. 
> 
> I claim "safe enough". :-)
> 
> > I can bet someone will get the fork() case wrong:
> > 
> > f = fork();
> > kill(f);
> > 
> > fork will return -1, and kill will kill _all_ the
> processes.
> 
> Someone who writes code like that deserves to get
> all his processes killed. :-p

Sure, but usually the person who wrote that
code was never bitten by it and is now a
marketing consultant on another continent.
Sloppy error handling remains rampant throughout
the programming community and there is
nothing more likely to get bitten by it
than a change to the privilege model.
Since the original author no longer gives
a horse's pitute about the issue the problem
is yours.

> fork() can fail for a million reasons,
> some of which, on
> most systems, can be provoked by a malicious
> attacker (such as filling
> all available process slots).

Failures of fork() are sufficiently rare
that there is way too much code with the
aforementioned problem to treat it lightly.
 
> > If you can find another uid to hijack, that other
> uid has bad
> > problems. And I do not think you'll commonly find
> another uid to
> > hijack.
> 
> How about another gid, then?  Should we reset all
> caps on sgid exec?

One advantage of the POSIX model, which
uses the capability set off the file, is
that it ignores setuid/setgid in favor of
getting the capabilities from the CAP
attribute. With the file attribute you keep
the setuid'ness independent. If there's
no capability set, you get no capabilities.

> Ultimately a compromise is to be reached between
> security and
> flexibility...  The problem is, I don't know who
> should make the
> decision.

Me! Me!
 
> > And there are easier ways to get out of jail with
> your proposed
> > capabilities: you do not restrict ptrace, so you
> can just ptrace any
> > other process with same uid, and hijack it.
> 
> That's true.  The restrictions on process killing
> (which Serge
> introduced) should probably be applied to ptrace()
> also.
> 
> > (You probably want to introduce CAP_REG_PTRACE).
> 
> Good idea.  I did, in version 0.4.2.
> 
> > Or just remove CAP_REG_XUID_EXEC when removing any
> other CAP_REG...?
> 
> Doable, but ugly (or so I think): there are many
> paths that set
> caps...  A simpler solution would be to remove the
> test on
> CAP_REG_SXID and instead test on all regular caps
> simultaneously.
> Still, I really don't like the idea.
> 
> > It is not too bad; you'll usually not want
> restricted programs to exec
> > anything setuid... (Do you have example where
> > restricted-but-should-be-able-to-setuid-exec makes
> sense?)
> 
> Well, I could imagine that a paranoid sysadmin might
> want some users'
> processes to run without this or that capability
> (perhaps
> CAP_REG_PTRACE or some other yet-to-be-defined
> capability).  This
> doesn't mean that they shouldn't be able to run a
> game which runs sgid
> in order to write the score file.

A likely scenario might be the 3rd party program
that you really are sure about trusting. You
give it a capability set that has nothing in it
(hence runs without capability regardless of
the capabilities of the parent). That's part
of the rationale behind the POSIX scheme, that
some programs you just don't want to ever run
privileged, period. But POSIX only deals with
going "above" base, which is why I like the
notion of your "underprivileged" scheme as a
seperate addition.


Casey Schaufler
casey@schaufler-ca.com
