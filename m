Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264348AbUEXX4h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264348AbUEXX4h (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 May 2004 19:56:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264352AbUEXX4h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 May 2004 19:56:37 -0400
Received: from fw.osdl.org ([65.172.181.6]:23432 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264348AbUEXX4c (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 May 2004 19:56:32 -0400
Date: Mon, 24 May 2004 16:56:30 -0700
From: Chris Wright <chrisw@osdl.org>
To: Andy Lutomirski <luto@myrealbox.com>
Cc: Chris Wright <chrisw@osdl.org>, Stephen Smalley <sds@epoch.ncsc.mil>,
       Albert Cahalan <albert@users.sourceforge.net>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       olaf+list.linux-kernel@olafdietsche.de
Subject: Re: [PATCH] caps, compromise version (was Re: [PATCH] scaled-back caps, take 4)
Message-ID: <20040524165630.H21045@build.pdx.osdl.net>
References: <fa.dt4cg55.jnqvr5@ifi.uio.no> <40AABE49.1050401@myrealbox.com> <20040519003013.L21045@build.pdx.osdl.net> <200405241638.07296.luto@myrealbox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200405241638.07296.luto@myrealbox.com>; from luto@myrealbox.com on Mon, May 24, 2004 at 04:38:07PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Andy Lutomirski (luto@myrealbox.com) wrote:
> > 
> > Hehe, arm wrestling could be entertaining ;-)  I'm in favor of the most
> > conservative change, which I feel is in my patch.  But I'm game to
> > continue to pick on each.
> 
> 
> I like your legacy mode.  I don't like making processes inherit
> non-legacyness.  (With your patch, some daemon might be secure
> when started from initscripts but insecure when started from the
> command line, if root ended up in non-legacy mode.)

Hmm, that was intentional (my very first cut at this thing cleared it,
but that patch had many other broken behaviours).  Specifically because
it goes through pI, which POSIX draft says is untouched through exec.

> You've also convinced me that an inheritable mask is good, because
> it may make some IRIX apps work.  It's also necessary for this patch
> to be safe.
> 
> I don't like touching the inode in the security module (you
> forgot to check nosuid, for one thing).

Yup, I changed that since then, using the secflags approach you did.

> So here's another shot at it:
> 
> "Legacy mode" is controlled by a new bit in task_struct called
> keep_all_caps (controlled by PRCTL_SET_KEEPALLCAPS).  This bit turns
> off setuid emulation completely (except for setfsuid).

I had same idea.  I wished we could hijack keep_capabilities as a
bit vector.

> The evolution rules are:
> pP' = (fP & X) | (pI & pP) [with the setuid-nonroot fix]
> pE' = (pE | fP) & pP'
> pI' = full
> 
> This time around, I haven't touched the unsafeness rules.
> 
> The magic is in the setuid emulation:
> 	if (current->uid == 0 || current->euid == 0)
> 		cap_set_full(current->cap_inheritable);
> 	else
> 		cap_clear(current->cap_inheritable);
> 
> So, unless a program plays with it's inheritable mask,
> root will not pick up caps on exec (which is good -- it
> means it's safe to chroot somewhere, disable all caps
> except CAP_SETUID, and let untrusted code play around.)
> But, if you start as root and setuid away, _even with
> keepcaps_, you lose the caps on exec.  Which is the broken
> behavior we want to preserve.
> 
> So, to avoid this, new code can either set keep_all_caps
> or just explicitly enable inheritance after setuid, in
> which case it just works.
> 
> I have pI' = full because otherwise it's just one more
> (partially) user-controlled variable that programs need
> to worry about.  (And because anything else would break
> root.)

How do you keep passing down the same caps through multiple execs?

> As for the rest of the changes:
> 
> The code no longer assumes that pI<pP, so I yanked all checks
> on the inheritable mask.  On the other hand, it makes no
> sense to me for capset when changing lots of processes'
> masks to affect the inheritable mask.  So I made it leave
> it alone, except when changing current.
> 
> keep_all_caps is clearly not entirely necessary.  I can take
> it out if anyone objects.
> 
> I yanked all capset sanity checks from kernel/capability.c --
> they were duplicates anyway.
> 
> And I left the old (IMHO pointless) behavior that one needs to hack
> init in order to use CAP_SETPCAP.
> 
> [Side note: for cap_bset to be useful, I think there needs to be
> an operation "atomically remove these caps from all tasks."  I
> don't see one.]

Yeah.  It depends on the definition of useful.  Get a couple privileged
tasks running (which may fork/exec from time to time), then clamp down
the machine is one form of useful.  In general, I don't cap_bset is that
useful though.

> This patch also should work fine if VFS capabilities are
> introduced (there's an fP mask which defaults to (setuid-
> root ? full : 0).
> 
> Patch against 2.6.6-mm4 (-mm5 didn't like my filesystem...).
> It's not as well tested as it should be.  The old cap.cc
> tool still works (but remember to set inheritable).  I
> don't have a tool yet to play with keep_all_caps.

I can add this to the test stuff to play with it.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
