Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262192AbVCPATp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262192AbVCPATp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 19:19:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262188AbVCPATn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 19:19:43 -0500
Received: from sccrmhc11.comcast.net ([204.127.202.55]:56020 "EHLO
	sccrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S262182AbVCPATP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 19:19:15 -0500
Subject: Re: Capabilities across execve
From: Albert Cahalan <albert@users.sf.net>
To: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Cc: rmk+lkml@arm.linux.org.uk, alexn@dsv.su.se, chrisw@osdl.org, akpm@osdl.org,
       pavel@ucw.cz
Content-Type: text/plain
Date: Tue, 15 Mar 2005 19:04:57 -0500
Message-Id: <1110931497.1949.269.camel@cube>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King, the latest person to notice defects, writes:

> However, the way the kernel is setup today, this seems
> impossible to achieve, which tends to make the whole
> idea of capabilities completely and utterly useless.
>
> How is this stuff supposed to work?  Are my ideas of
> what's supposed to be achievable completely wrong,
> although they look completely reasonable to me.
>
> Don't get me wrong - the capability system seems great at
> permanently revoking capabilities via /proc/sys/kernel/cap-bound,
> and dropping them within an application provided it remains UID0.
> Apart from that, capabilities seem completely useless.
...
> it seems to be something of a lost cause.
...
> my goal of running the script with minimal capabilities
> was completely *impossible* to achieve.

Uh huh. First, some history.

Capability bits were implemented in DG-UX and IRIX.
The two systems did not agree on operation. The draft
POSIX standard, withdrawn for good reason, greatly
changed between draft 16 and draft 17. Settings that
work for one draft are horribly insecure on the other.
Linux capabilities were partly done by the IRIX crew,
working from draft 16. Everyone else had draft 17 or
even draft 13. (and DG-UX had a better system anyway)

Tytso put things well when he wrote: "A lot of innocent
bits have been deforested  while trying work out the
differences between what Linux is doing (which is basically
following Draft 17), and what Trusted Irix is doing (which 
apparently is following Draft 16)."

Then along comes a sendmail exploit. An emergency fix
was produced, breaking an already-defective capability
design.

Note that, unlike DG-UX, our IRIX-inspired design did
not reserve any capability bits for non-kernel use.
This causes an inconsistent security model, with things
like the X server relying on UID. Inconsistency is bad.

OK, so that's how we got into this mess.

Now, how do we get out?

We will always have to deal with old-style apps. Those
few apps that handle capabilities can handle the bad
system we have now, and can handle a system without the
capability syscalls. (for old kernels) These apps can
not handle a changed setup though; to change things we
must make the old syscalls return failure. ANYTHING ELSE
IS VERY UNSAFE.

There is exactly one capability system in popular use.
That would be the one that comes with Solaris. Moving
toward that, via a kernel config option, appears to be
a sane way to get ourselves unstuck from this big mess.
An added advantage that that the Solaris-style method
instantly becomes the standard, especially if Linux is
strongly compatible. This helps with admin training and
portable software.

See if you can find any holes:
http://docs.sun.com/app/docs/doc/816-5175/6mbba7f39?a=view


