Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932402AbVHIBww@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932402AbVHIBww (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Aug 2005 21:52:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932404AbVHIBww
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Aug 2005 21:52:52 -0400
Received: from thunk.org ([69.25.196.29]:46800 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S932402AbVHIBwv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Aug 2005 21:52:51 -0400
Date: Mon, 8 Aug 2005 21:50:48 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: David Wagner <daw-usenet@taverner.CS.Berkeley.EDU>
Cc: linux-kernel@vger.kernel.org
Subject: Re: understanding Linux capabilities brokenness
Message-ID: <20050809015048.GA14204@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	David Wagner <daw-usenet@taverner.CS.Berkeley.EDU>,
	linux-kernel@vger.kernel.org
References: <20050808211241.GA22446@clipper.ens.fr> <20050808223238.GA523@clipper.ens.fr> <dd8r9s$eqn$1@taverner.CS.Berkeley.EDU>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dd8r9s$eqn$1@taverner.CS.Berkeley.EDU>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 08, 2005 at 11:53:33PM +0000, David Wagner wrote:
> David Madore  wrote:
> >This does not tell me, then, why CAP_SETPCAP was globally disabled by
> >default, nor why passing of capabilities across execve() was entirely
> >removed instead of being fixed.
> 
> I do not know of any good reason.  Perhaps the few folks who knew enough
> to fix it properly didn't feel like bothering; it beats me.
> 
> Messing with capabilities is scary.  As far as I can tell, there never was
> any coherent "design" to the semantics of POSIX capabilities in Linux.
> It's had a little bit of a feeling of a muddle of accumulated gunk,
> so unless you understand it really well, it's hard to know what any
> changes you make are safe.  This may have scared people away from fixing
> it "the right way".  But if you're volunteering to do the analysis and
> figure out how to fix it, I say, sounds good to me.

The POSIX specification for capabilities requires filesystem support,
so that each executables can be marked with three capability sets ---
which indicate which capabilities are asserted when the executable
starts, which capabilities the executable is allowed to request, and
which capabilities the executable is allowed to inherit from its
parent process.  This effectively takes a single setuid bit and splits
it into a hundred-odd bits.  

This was never implemented for a number of reasons.  (1) When the
capabilities support was first merged, extended attributes support
wasn't in any of the filesystems currently integrated, which is a
prerequisite for storing the capability masks on a per-file basis.
(2) There was some debate about whether or not this method was the
course of wisdom, which has probably decreased the enthusiasm for
actually doing the remaining bits of work.

The basic concern with this is that usability experts have shown that
most users have trouble with the 12 bits of the Unix permissions
model.  Splitting a single setuid bit into 100-odd bits makes the
manageability problem much, much harder.  Note that many some setuid
programs don't necessarily check error returns, and sometimes turning
off permissions can sometimes open up vulnerabilities.

(For example, this wasn't directly related to POSIX capaibilities, but
way back when, one version of Ultrix caused setuid() to return EPERM
if the uid was greater than 32,000 decimal.  This was probably caused
by a clueless library implementor implement some specification which
stated that the uid had to be less than 32k.  We discovered this
problem at MIT Project Athena when users with uid's above 32,000 would
get root privileges when they logged in, because /bin/login at the
time didn't check the error returns of setuid(), since _obviously_
when root calls setuid(), it never fails, right?)

Another problem with the POSIX capabilities is that most of the
programs that system administrators run to look for setuid programs
will miss programs that have capabilities encoded in extended
attributes.  This problem could be fixed by requiring the setuid bit
to be set before paying attention to the capability EA's; but this
could lead to surprising results if the filesystem is mounted on a
system that doesn't use filesystem capabilities at all.

Yet another issue is that the POSIX capabilities model means that a
default executable, such as gcc for example, is not allowed to inherit
_any_ capabilities, even if it is run from a setuid root shell.  This
is good from a security point of view, since it means that people
can't get in trouble by doing silly things like typing
"./configure;make" as root and expect any of the build tools to have
override arbitrary file controls.  The bad news is that system
administrators aren't particularly happy when their own private tools
have to especially marked to allow them to run with elevated
privileges.

						- Ted
