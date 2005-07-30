Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263072AbVG3U0m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263072AbVG3U0m (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Jul 2005 16:26:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263161AbVG3UYO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Jul 2005 16:24:14 -0400
Received: from cerebus.immunix.com ([198.145.28.33]:40916 "EHLO
	ermintrude.int.immunix.com") by vger.kernel.org with ESMTP
	id S263072AbVG3UXX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Jul 2005 16:23:23 -0400
Date: Sat, 30 Jul 2005 13:18:52 -0700
From: Tony Jones <tonyj@suse.de>
To: serge@hallyn.com
Cc: serue@us.ibm.com, lkml <linux-kernel@vger.kernel.org>,
       Chris Wright <chrisw@osdl.org>, Stephen Smalley <sds@epoch.ncsc.mil>,
       James Morris <jmorris@redhat.com>, Andrew Morton <akpm@osdl.org>,
       Michael Halcrow <mhalcrow@us.ibm.com>, steve@immunix.com
Subject: Re: [patch 0/15] lsm stacking v0.3: intro
Message-ID: <20050730201852.GA8223@immunix.com>
References: <20050727181732.GA22483@serge.austin.ibm.com> <20050730050701.GA22901@immunix.com> <20050730190222.GA12473@vino.hallyn.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050730190222.GA12473@vino.hallyn.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Serge

> > 5) /*
> >  * Workarounds for the fact that get and setprocattr are used only by
> >  * selinux.  (Maybe)
> >  */
> > 
> > No complaints on selinux getting to avoid the (module), they are intree.
> > Just a FYI that SubDomain/AppArmor uses these hooks also.
> 
> And is it ok with using the "some_data (apparmor)" convention?

Yes.  Our use of setprocattr is thru a library fn so I just made the change
there.  We'll have to change our user tools (that read /proc/pid/attr/current
but thats fine too).

> The special handling of selinux is intended to be temporary, due to the
> large base of installed userspace which hasn't yet been updated.  I
> would imagine that at some point that code would go away.

I assumed it was due to this. Doesn't inconvenience us any and it it helps 
SELinux it's fine w/ me.


Of more concern is ps -Z (pstools).

We had to have the pstools maintainer extend the set of characters that it
considered valid from the getprocattr.    I forget the details but IIRC he 
wanted to know (for ?documentation?) every character that could be returned 
by our getprocattr hook (which for us is pretty much any character thats 
valid in a pathname -- though IIRC we forgot one).

Anyway, I'm guessing (at least with pstools 3.2.5) that '(' is not one of
the valid characters. IIRC ps gives up when it sees a "non-valid" character.

I wrote a trivial little lsm which just returns 'foobar' for any getprocattr.

# cat /proc/2322/attr/current 
unconstrained (subdomain)
foobar (foobar)

# ps -Z -p 2322
LABEL                             PID TTY          TIME CMD
unconstrained                    2322 ttyS0    00:00:00 bash

Even if ps did return them all, I think it could create a usability problem.  
There was another LSM (forget which) which wanted to return a large blob 
from getprocattr, I recall like a page? in size which obviously caused problems
for ps -Z both in terms of content and especially length.

> > I noticed the conditional CONFIG_SECURITY_STACKER code went away, previously
> > it would look at the value chain head only for the !case. But this comment
> > still remains.
> 
> Yes, after I added the unlink function, it started to seem that the
> special cases for !CONFIG_SECURITY_STACKER wouldn't be any faster than
> the stacker versions.  They still might be, but I'll have to think about
> it.  If I just ditch those, then I can probably ditch the whole

Esp since James' suggestion would impact it. I'd imagine you would always want
array[0] for this case, no?

I was just pointing out the legacy comment. Thats all.

Thanks again

Tony
