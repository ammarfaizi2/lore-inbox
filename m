Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261984AbUENSGe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261984AbUENSGe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 May 2004 14:06:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261988AbUENSGd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 May 2004 14:06:33 -0400
Received: from facesaver.epoch.ncsc.mil ([144.51.25.10]:41401 "EHLO
	epoch.ncsc.mil") by vger.kernel.org with ESMTP id S261984AbUENSGa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 May 2004 14:06:30 -0400
Subject: Re: [PATCH] capabilites, take 2
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Albert Cahalan <albert@users.sourceforge.net>
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       luto@myrealbox.com, Chris Wright <chrisw@osdl.org>,
       olaf+list.linux-kernel@olafdietsche.de, Valdis.Kletnieks@vt.edu
In-Reply-To: <1084547976.952.644.camel@cube>
References: <1084536213.951.615.camel@cube>
	 <1084548061.17741.119.camel@moss-spartans.epoch.ncsc.mil>
	 <1084547976.952.644.camel@cube>
Content-Type: text/plain
Organization: National Security Agency
Message-Id: <1084557969.18592.21.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Fri, 14 May 2004 14:06:09 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-05-14 at 11:19, Albert Cahalan wrote:
> I just read that. It's a very unfair marketing document.
> Among other things, it suggests that a capability system
> is stuck with about 40 bits while their own version of
> capabilities (a duck is a duck...) has 80 bits. Lovely,
> but not exactly groundbreaking.

You missed the point.  Capability scheme maps far too many operations to
a single capability; CAP_SYS_ADMIN in Linux is a good example.  TE model
defers organization of operations into equivalence classes to the policy
writer.

>  There is the bit about
> a 3-argument security call, but a careful reading will
> reveal that one argument is unused (NULL?) when dealing
> with abilities like "can set the clock".

But very useful when dealing with CAP_DAC_OVERRIDE and friends.

> About the only thing of interest is that capability
> transitions can be arbitrary. You're not limited to
> an obscure set of equations that nobody can agree on.

Because there is no one-size-fits-all equation for all transitions.

> The cost: complicated site-specific config files and
> the inability to support capability-aware apps that
> set+clear their own bits.

Complexity pushed to userspace, where it can be analyzed appropriately
via tools and tailored for the transition in question.  Central
management of the capabilities based on equivalence classes (types), as
opposed to having to manage a distributed nightmare of capability bits
on your filesystems.  Applications that can transition to other domains,
but only if so authorized by the policy.

> Eh, why? That's mostly a search-and-replace on the name,
> since capable() makes a perfectly fine LSM hook.

It doesn't offer sufficient granularity, either for operation (which you
_could_ address by introducing new capabilities, but the hooks are more
easily extensible) or for object.

> So what about the old-Oracle problem? You have a
> server that needs the ability to hog and lock memory.
> Is there an almost-empty SELinux policy that would
> provide this while leaving the rest of the system
> acting as UNIX-like systems have always acted?
> If so, we have a winner.

See "relaxed policy" or "targeted policy" in recent discussions on the
Fedora mailing lists; coming soon to a rawhide near you.  Not exactly
the same thing (it is a policy where most processes run essentially
unconfined except for a targeted set that you define like apache, bind,
etc), but you could certainly tweak it to this end (i.e. you put oracle
into a domain that gives it the one capability you desire).

> One still does need to provide apps with a way to
> answer "can I do FOO, BAR, and BAZ?" and "am I
> running with elevated privileges?". Some way to
> dispose of unneeded privileges would be good too.
> Hopefully extra libraries wouldn't be needed.

SELinux provides a policy API already, and a userspace library for
accessing it (and caching decisions from it).  It also provides (via the
AT_SECURE auxv entry) notification that a domain transition has
occurred, and this is already used by glibc secure mode.  Privileges are
dropped via domain transitions.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency

