Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262555AbSJBSeO>; Wed, 2 Oct 2002 14:34:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262556AbSJBSeO>; Wed, 2 Oct 2002 14:34:14 -0400
Received: from phoenix.infradead.org ([195.224.96.167]:12551 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S262555AbSJBSeM>; Wed, 2 Oct 2002 14:34:12 -0400
Date: Wed, 2 Oct 2002 19:39:40 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Valdis.Kletnieks@vt.edu
Cc: linux-kernel@vger.kernel.org, linux-security-module@wirex.com
Subject: Re: [RFC] LSM changes for 2.5.38
Message-ID: <20021002193940.A16376@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Valdis.Kletnieks@vt.edu, linux-kernel@vger.kernel.org,
	linux-security-module@wirex.com
References: <20020927003210.A2476@sgi.com> <Pine.GSO.4.33.0209270743170.22771-100000@raven> <20020927175510.B32207@infradead.org> <200209271809.g8RI92e6002126@turing-police.cc.vt.edu> <20020927191943.A2204@infradead.org> <200209271854.g8RIsPe6002510@turing-police.cc.vt.edu> <20020927195919.A4635@infradead.org> <200209301419.g8UEJI6E001699@turing-police.cc.vt.edu> <20021001175500.A26635@infradead.org> <200210021755.g92HtGLw010852@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200210021755.g92HtGLw010852@turing-police.cc.vt.edu>; from Valdis.Kletnieks@vt.edu on Wed, Oct 02, 2002 at 01:55:14PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 02, 2002 at 01:55:14PM -0400, Valdis.Kletnieks@vt.edu wrote:
> On Tue, 01 Oct 2002 17:55:00 BST, Christoph Hellwig said:
> 
> > For gods sake, what interface do you want to /bin/mv?  network device don't have
> > associated special files in Linux (or BSD).  I'm talking about SIOCSIFNAME.
> 
> Well, I figured that you must have meant something else, since ioctl() is
> hooked, so an attacker couldn't use THAT method if the security module didn't
> want him to.

Just that no 'security' module implements a special handler for it. E.g. in
selinux it ends up in

		/* default case assumes that the command will go
   		 * to the file's ioctl() function.
      		 */
      		default:
      			error = file_has_perm(current, file, FILE__IOCTL);

> Of course, that means we probably should pull that ioctl() hook too, since
> obviously there's ways to bypass it.

Right.  an hook for ->ioctl() is completly useless.  Remember that ioctl
is nothing but a magic backdoor to add syscalls.  You need to do the
permission check in code that actually knows what it is doing, not in
the dispatcher.

> So we shouldn't deploy a check on module parameters to prevent renaming
> an interface, and we shouldn't bother having OTHER checks to stop it
> because they could always load a module and bypass it

You should add a check where the name isactually assigned in this case.
Not that I think a check on the device name is generally a good idea..

> - if you feel THAT
> strongly that the whole concept of a security framework is that pointless,
> you're free not to use it. ;)

You've missed the point.  I never wanted to use it.  I care about the crap
that it adds to the kernel which I do want to use, develop and keep
clean.

> > How does the lsm author know what the option x=y means for my module?  In my
> 
> Umm.. the same way that *I* noticed that 'eth=0' has a security implication.

Without ever seeing that module?

> It seems to me that you're arguing both sides here - first you say that
> a full code audit is needed so you know 'WTF is going on', and then you're
> saying that it's impossible to know.

The person who performs the audit can know it.  But how often will that be
the author of the LSM module? 

> OK - so to summarize:  You're saying that somebody conceives of a reasonable
> security model, finds a set of 10 or 15 hooks that implement 95% of what
> he needs, but there's a code path that a hook doesn't catch that lets a user
> subvert the model - and then it's a *BAD THING* that the kernel be modified
> to *actually solve a problem*?

It's not bad to solve a problem.  It's a bad idea trying to 'solve' a problem
you don';t understand fully.

> Somehow, this goes against the whole spirit of the Linux kernel - I wonder
> what miniscule percent of the current kernel wasn't done to solve a problem...

Adding random hack without resolving the underlying problem is not the
way linux kernel development usually works.

