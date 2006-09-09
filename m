Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965177AbWIJDoW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965177AbWIJDoW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Sep 2006 23:44:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965180AbWIJDoV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Sep 2006 23:44:21 -0400
Received: from thunk.org ([69.25.196.29]:22681 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S965177AbWIJDoU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Sep 2006 23:44:20 -0400
Date: Sat, 9 Sep 2006 19:18:05 -0400
From: Theodore Tso <tytso@mit.edu>
To: David Madore <david.madore@ens.fr>
Cc: Linux Kernel mailing-list <linux-kernel@vger.kernel.org>
Subject: Re: patch to make Linux capabilities into something useful (v 0.3.1)
Message-ID: <20060909231805.GC24906@thunk.org>
Mail-Followup-To: Theodore Tso <tytso@mit.edu>,
	David Madore <david.madore@ens.fr>,
	Linux Kernel mailing-list <linux-kernel@vger.kernel.org>
References: <20060905212643.GA13613@clipper.ens.fr> <20060906002730.23586.qmail@web36609.mail.mud.yahoo.com> <20060906100610.GA16395@clipper.ens.fr> <20060906132623.GA15665@clipper.ens.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060906132623.GA15665@clipper.ens.fr>
User-Agent: Mutt/1.5.11
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 06, 2006 at 03:26:23PM +0200, David Madore wrote:
> I emphasize that the filesystem support patch described above, alone,
> will *not* solve the inheritability problem (as my patch does), since
> unmarked executables continue to inherit no caps at all.  With my
> patch, they behave as though they had a full inheritable set,
> something which is required if we want to make something useful of
> capabilities on non-caps-aware programs.

This is what scares me about your proposal.  I consider it a *feature*
that unmarked executables inherit no capabilities, since many programs
were written without consideration about whether or not they might be
safe to run without privileges.  So the default of not allowing an
executable to inherit capabilities is in line of the the classic
security principle of "least privileges".   

I agree it may be less convenient for a system administrator who is
used root, cd'ing to a colleagues source tree, su'ing to root, and who
then types "make" to compile a program, expecting it to work since
root privileges imply the ability to override filesystem discretionary
access control --- and then to be rudely surprised when this doesn't
work in a capabilities-enabled system.  However, I would claim this is
the correct behaviour!  Would you really want some random operator
running random Makefiles for some random program downloaded from the
Internet?  As root?  So as far as I am concerned, forcing make, cc,
et. al. to not inherit capabilities is a Good Thing.

Now, perhaps some system owners have a different idea of how they want
to run, and believe want to trade off more convenience for less
security.  That's fine, but please don't disable the high security
mode for the rest of us.  What I would suggest is that perhaps the
filesystem capabilities patch can be extended to either to allow the
filesystem superblock define (a) what the default inheritance
capability mask should be when creating a new file, and (b) what the
default inheritance capability for that filesystem should be in the
absence of an explicit capability record.  Both of these should be
overrideable by a mount option, but for convenience's sake it would be
convenient to be able to set these values in the superblock.


As far as negative capabilities, I feel rather strongly these should
not be separated into separate capability masks.  They can use the
same framework, sure, but I think the system will be much safer if
they use a different set of masks.  Otherwise, there can be a whole
class of mistakes caused by people and applications getting confused
over which bit positions indicate privileges, and which indicate
negative privileges.  If you use a separate mask, this avoids this
problem.


The other reason why it may not be such a hot idea to mess with the
inheritance formulas is compatibility with other Unix systems that
have implemented capabilities following the last Posix draft.  In
particular, Sun has recently included the Trusted Solaris into the
base Solaris offering and into Open Solaris, and has been plugging
them pretty heavily.  It would be unfortunate if Solaris and Linux had
gratuitously different semantics for how the capabilities API's work.
It could easily cause security problems in both directions --- when
trying to port a program written for Linux to Solaris, and vice versa.

The solution is to _extend_ the capabilities system: for example, by
adding default inheritance masks to cater for system administrators
who value convenience more than security, and to add new bitmasks for
negative privileges/capabilities.

Regards,

					- Ted
