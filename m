Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751266AbWDXUm7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751266AbWDXUm7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 16:42:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751264AbWDXUm6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 16:42:58 -0400
Received: from zombie.ncsc.mil ([144.51.88.131]:5345 "EHLO jazzdrum.ncsc.mil")
	by vger.kernel.org with ESMTP id S1751262AbWDXUm5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 16:42:57 -0400
Subject: Re: [RFC][PATCH 0/11] security: AppArmor - Overview
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Neil Brown <neilb@suse.de>
Cc: Chris Wright <chrisw@sous-sol.org>, James Morris <jmorris@namei.org>,
       Arjan van de Ven <arjan@infradead.org>, Andi Kleen <ak@suse.de>,
       linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
In-Reply-To: <17484.20906.122444.964025@cse.unsw.edu.au>
References: <20060419174905.29149.67649.sendpatchset@ermintrude.int.wirex.com>
	 <1145470463.3085.86.camel@laptopd505.fenrus.org>
	 <p73mzeh2o38.fsf@bragg.suse.de>
	 <1145522524.3023.12.camel@laptopd505.fenrus.org>
	 <20060420192717.GA3828@sorel.sous-sol.org>
	 <1145621926.21749.29.camel@moss-spartans.epoch.ncsc.mil>
	 <20060421173008.GB3061@sorel.sous-sol.org>
	 <1145642853.21749.232.camel@moss-spartans.epoch.ncsc.mil>
	 <17484.20906.122444.964025@cse.unsw.edu.au>
Content-Type: text/plain
Organization: National Security Agency
Date: Mon, 24 Apr 2006 16:45:26 -0400
Message-Id: <1145911526.14804.71.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-04-24 at 14:18 +1000, Neil Brown wrote:
> On Friday April 21, sds@tycho.nsa.gov wrote:
> > On Fri, 2006-04-21 at 10:30 -0700, Chris Wright wrote:
> > > * Stephen Smalley (sds@tycho.nsa.gov) wrote:
> > > > Difficult to evaluate, when the answer whenever a flaw is pointed out is
> > > > "that's not in our threat model."  Easy enough to have a protection
> > > > model match the threat model when the threat model is highly limited
> > > > (and never really documented anywhere, particularly in a way that might
> > > > warn its users of its limitations).
> > > 
> > > I know, there's two questions.  Whether the protection model is valid,
> > > and whether the threat model is worth considering.  So far, I've not
> > > seen anything that's compelling enough to show AppArmor fundamentally
> > > broken.  Ugly and inefficient, yes...broken, not yet.
> > 
> > Access control of any form requires unambiguous identification of
> > subjects and objects in the system.   Paths don't achieve such
> > identification.  Is that broken enough?  If not, what is?  What
> > qualifies as broken?
> 
> I have to disagree with this.  Paths *do* achieve unambiguous
> identification of something.  That something is ..... the path.

A path is not an object; it is a way of referring to an object.  No need
to reason about this abstractly - just look at the kernel's internal
model; where are these mystical path objects and how are they
implemented?  And as a way of referring to an object, paths are
ambiguous identifiers.  Further, that ambiguity is leveraged by AppArmor
to e.g. support multiple profiles for the same program via alternate
paths.

> Think about the name of this system for a minute.  "AppArmor".
> i.e. it is Armour for an Application.  It protects the application.
> It doesn't (as far as I can tell: I'm not an expert and don't work on
> this thing) claim to protect files.  It protects applications.

>From the AppArmor overview on the novellforge page:
"AppArmor security policies completely define what system resources
individual applications can access..."

>From the AppArmor FAQ:
"AppArmor profiles are human-readable text files that mediate access to
files and directories..."

Isn't that claiming to protect files?  If not, please make sure the end
user documentation clearly says "AppArmor is not designed to protect
files."

> It protects them from doing the wrong thing - from doing something
> they weren't designed to do.  i.e. it protects them from being
> subverted by exploiting a bug.
> 
> A large part of the behaviour of an application is the path names that
> it uses and what it does with them.  If an application started doing
> unexpected things with unexpected paths (e.g. exec("/bin/sh") or
> open("/etc/shadow",O_RDONLY)) then this is a sure sign that it has
> been subverted and that AppArmor need to protect it, from itself.

Um, no.  You are trying to protect the rest of the system from
misbehavior by the application.  You aren't protecting the application
at all - you have already said it has been subverted, and it is then
free to corrupt or leak any information it normally has legitimate
access to.  And since you don't care about information flow, you can't
actually guarantee that the rest of the system isn't corrupted by the
application misbehavior; any of your unconfined processes may become the
conduit by which the corruption spills over into the rest of the system.

> While the protection against subversion cannot be complete, it can be
> sufficient to dramatically reduce the chances of privilege
> escalation.   There are lots of wrong things you can get an
> application to do once you find an exploitable bug.  Many of these
> will lead to a crash.  AppArmor will not try to protect against these
> (I suspect).  There are substantially fewer that lead to privilege
> escalation.   AppArmor focusses its effort in terms of profile design
> on exactly these sorts of unplanned behaviours.

I don't see how it achieves such prevention with the limitations I've
already noted, which are design limitations, not just characteristics of
the implementation.

> So I think you still haven't given convincing evidence that AppArmor
> is broken by design.

If it isn't, then is anyone and everyone free to introduce other
path-based mechanisms in the kernel in the future?  Why has that been
frowned upon in the past if there really isn't anything wrong with it?
  
-- 
Stephen Smalley
National Security Agency

