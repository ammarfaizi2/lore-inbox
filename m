Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261480AbULAWyE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261480AbULAWyE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Dec 2004 17:54:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261479AbULAWyE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Dec 2004 17:54:04 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:64909 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S261485AbULAWxo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Dec 2004 17:53:44 -0500
Date: Wed, 1 Dec 2004 16:53:12 -0600
From: Brent Casavant <bcasavan@sgi.com>
Reply-To: Brent Casavant <bcasavan@sgi.com>
To: Andi Kleen <ak@suse.de>
cc: "Boehm, Hans" <hans.boehm@hp.com>, Ray Bryant <raybry@sgi.com>,
       Andreas Schwab <schwab@suse.de>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-ia64@vger.kernel.org, lse-tech <lse-tech@lists.sourceforge.net>,
       holt@sgi.com, Dean Roe <roe@sgi.com>,
       John Hawkes <hawkes@tomahawk.engr.sgi.com>
Subject: Re: [Lse-tech] scalability of signal delivery for Posix Threads
In-Reply-To: <20041122213448.GA16153@wotan.suse.de>
Message-ID: <Pine.SGI.4.58.0412011613440.26337@kzerza.americas.sgi.com>
References: <65953E8166311641A685BDF71D865826058B5C@cacexc12.americas.cpqcorp.net>
 <20041122213448.GA16153@wotan.suse.de>
Organization: "Silicon Graphics, Inc."
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Nov 2004, Andi Kleen wrote:

> > I think this is a more general issue.  Special casing one
>
> It just cannot be done in the general case without slowing
> down sigaction significantly. Or maybe it can, but nobody
> has proposed a way to do it so far.

Sorry for the late reply, but I just inheirited some of this work
from Ray and am catching up.

At a high level the seqlock seemed like the right idea, though
neither it nor seqcount is appropriate since in the case of signal
processing we can't tolerate consuming stale information and redoing
the operation.

But it got me thinking in a good direction.  We could add a per-task
shadow copy of the per-process sighand_struct.  Added to sighand_struct
would be a generation number.  Whenever we perform an operation that
currently consumes data in the sighand_struct, we would first check the
shadow copy generation number against the per-process generation number.
If there is a mismatch, the per-process siglock is taken and the shadow
copy is updated, then the siglock is dropped.  Whether or not this update
was necessary, we complete the signal processing using only the shadow copy.

Whenever the per-process sighand_struct needs updating, the structure
would be updated as normal, and as a last operation before unlocking
the generation number would be bumped.

This lazy update method would not suffer a significant slowdown during
a sigaction(2) call.  The only potentially significant penalty occurs at
the time of signal delivery when a signal disposition/handler has changed.
Even this would be limited to a memcpy() of the sighand_struct->action --
which is not significant unless the disposition/handler is changing rapidly

Does this seem like a solution that would be worth pursuing?  I see some
potential pitfalls in that siglock protects more than sighand itself, and
that IRQs would not be disabled except during the shadowing operation.

There would be a race where the generation numbers match, so we begin
using the shadowed data, but simultaneously another task updates the
per-process sighand_struct.  This causes no direct ill effect as the
shadowed data is coherent, however I'm not sure whether an application
could possibly be sensitive to this race.  It seems that any such
application already suffers from a race as to which task obtains the
siglock first, but we are at least guaranteed that if signal delivery
begins, it is complete through signal_wake_up() before the racing
sigaction(2) begins.  I suspect there's nothing to worry about here, but
I haven't convinced myself of this quite yet.

I see that signal_wake_up() currently requires interrupts be disabled
on its behalf by holding siglock.  Under this new scheme it may be
necessary to lock interrupts without taking siglock itself, unless a
way can be found to make signal_wake_up() interrupt-safe.

Anyway, all that to once again ask if this seems like a beneficial
or feasible method to pursue?  Any glaring holes?  Any opinion as
to whether we should track the generation for the sighand_struct as a
whole, or for each individual element of sighand_struct->action
(seems like overkill to me, but it was casually suggested in hallway
chatter)?

Thanks,
Brent Casavant

-- 
Brent Casavant                          If you had nothing to fear,
bcasavan@sgi.com                        how then could you be brave?
Silicon Graphics, Inc.                    -- Queen Dama, Source Wars
