Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284708AbRLEU72>; Wed, 5 Dec 2001 15:59:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284737AbRLEU7L>; Wed, 5 Dec 2001 15:59:11 -0500
Received: from samba.sourceforge.net ([198.186.203.85]:13331 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S284704AbRLEU5E>;
	Wed, 5 Dec 2001 15:57:04 -0500
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15374.35262.151232.521493@argo.ozlabs.ibm.com>
Date: Thu, 6 Dec 2001 07:55:26 +1100 (EST)
To: "David S. Miller" <davem@redhat.com>
Cc: rth@redhat.com, davidm@hpl.hp.com, schwab@suse.de,
        linux-ia64@linuxia64.org, marcelo@conectiva.com.br,
        torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: alpha bug in signal handling
In-Reply-To: <20011205.032304.102576056.davem@redhat.com>
In-Reply-To: <20011204171426.B7982@redhat.com>
	<15373.33622.236872.92057@napali.hpl.hp.com>
	<20011204190048.B8179@redhat.com>
	<20011205.032304.102576056.davem@redhat.com>
X-Mailer: VM 6.75 under Emacs 20.7.2
Reply-To: paulus@samba.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller writes:

>    From: Richard Henderson <rth@redhat.com>
>    Date: Tue, 4 Dec 2001 19:00:48 -0800
> 
>    On Tue, Dec 04, 2001 at 06:15:50PM -0800, David Mosberger wrote:
>    > Oh, sorry, I was referring to teh *other* problem... ;-)
>    > 
>    > What I meant is that the check for re-scheduling
>    > (current->need_resched) and signal deliverify (current->sigpending)
>    > needs to be done with interrupts turned off, and the interrupts need
>    > to be left off until user space is reached.  Otherwise, you could get
>    > an interrupt which would wake up a higher priority task or post a
>    > signal between the check and the return to user space.
>    > 
>    > I didn't see this interrupt disabling in the Alpha version of entry.S,
>    > but I have to admit my Alpha assembly is getting quite rusty.
>    
>    Oh, yes, I see.  This should fix it.
>    
> I don't understand why this is even necessary.

I think David (Mosberger, not Miller :) is right here, and in fact
this is also wrong on PPC at the moment.  However, the worst case is
that the reschedule or signal delivery will get delayed until the next
interrupt on that cpu (max 1/HZ seconds).  Since it is a pretty narrow
window for the race I think it would be hard to observe the effect of
the bug.

> What if the interrupt comes in on another processor.  How does this
> return from trap behavior avoid that interrupt modifying the signal
> and/or scheduling state wrt. the current cpu's task?

If the interrupt comes in on another processor, then we call schedule()
on that processor and it does an IPI if it thinks that this processor
should reschedule.

The logic requires that we do the signal/schedule checks on exit to
userland.  The scenario where they can get missed is where we are
returning to userland, and we get an interrupt just after we have done
the checks.  Suppose the interrupt routine raises a signal or wakes up
a task.  On the return from the interrupt routine it won't do the
signal/schedule checks because we are returning to the kernel
mainline.  When we get back there it just completes the return to
userspace without doing the checks (since we have already done them).

Paul.
