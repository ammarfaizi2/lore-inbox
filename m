Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932981AbWFZTtg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932981AbWFZTtg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 15:49:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932982AbWFZTtg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 15:49:36 -0400
Received: from ausc60pc101.us.dell.com ([143.166.85.206]:8301 "EHLO
	ausc60pc101.us.dell.com") by vger.kernel.org with ESMTP
	id S932981AbWFZTtf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 15:49:35 -0400
DomainKey-Signature: s=smtpout; d=dell.com; c=nofws; q=dns; b=RVPKPO6h5/0e99EId0pDBJ3yFH5BRWSZhP21PU5AojxVuzGoFr6/O/E4NU9kMuPWrCMp+YmhuxNJj6DaEIL9U4eQVpexhGNSMZzbSbe4l1SuLV/oq3KCClJRgVxBMVOz;
X-IronPort-AV: i="4.06,177,1149483600"; 
   d="scan'208"; a="36258480:sNHT33281874"
Date: Mon, 26 Jun 2006 14:49:37 -0500
From: Matt Domsch <Matt_Domsch@dell.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Corey Minyard <minyard@acm.org>, linux-kernel@vger.kernel.org,
       peter@palfrader.org, openipmi-developer@lists.sourceforge.net
Subject: Re: [PATCH] IPMI: use schedule in kthread
Message-ID: <20060626194937.GA16528@lists.us.dell.com>
References: <20060626140819.GA17804@localdomain> <20060626120048.cff87fac.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060626120048.cff87fac.akpm@osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 26, 2006 at 12:00:48PM -0700, Andrew Morton wrote:
> On Mon, 26 Jun 2006 09:08:19 -0500
> MAILER-DAEMON@osdl.org wrote:
> 
> > The kthread used to speed up polling for IPMI was using udelay
> > when the lower-level state machine told it to do a short delay.
> > This just used CPU and didn't help scheduling, thus causing bad
> > problems with other tasks.  Call schedule() instead.
> > 
> > Signed-off-by: Corey Minyard <minyard@acm.org>
> > 
> > Index: linux-2.6.17/drivers/char/ipmi/ipmi_si_intf.c
> > ===================================================================
> > --- linux-2.6.17.orig/drivers/char/ipmi/ipmi_si_intf.c
> > +++ linux-2.6.17/drivers/char/ipmi/ipmi_si_intf.c
> > @@ -809,7 +809,7 @@ static int ipmi_thread(void *data)
> >  			/* do nothing */
> >  		}
> >  		else if (smi_result == SI_SM_CALL_WITH_DELAY)
> > -			udelay(1);
> > +			schedule();
> >  		else
> >  			schedule_timeout_interruptible(1);
> >  	}
> 
> calling schedule() isn't a lot of use either.
> 
> If CONFIG_PREEMPT it's of no benefit and will just chew CPU.
> 
> If !CONFIG_PREEMPT && !need_resched() then it's a no-op and will chew CPU.
> 
> If !CONFIG_PREEMPT && need_resched() then yes, it'll schedule away.  This
> is pretty much the only time that a simple schedule() is useful.
> 
> 
> What are we actually trying to do in here?

Make up for a lack of poor hardware design.  Most IPMI controllers
that use the standard-specified KCS interface don't implement
interrupts to signal data availability, and its a character-at-a-time
interface.

Without this kernel thread, ordinary operations (ipmitool sensor list)
would take 30 seconds, essentially one character transfer per timer
tick.  Starting applications that would read a lot of IPMI data would
take 5 minutes.  Doing a firmware flash would take 15 minutes.

With the kernel thread, these ops drop to 5-7 seconds, <1 minute, and
~1.5 minutes respectively.  It does this by polling at a rate faster
than the timer tick, in a low-priority kernel thread, any time a
command is outstanding to the controller.  If no commands are
outstanding, it goes to sleep for a tick, then wakes up (in case the
controller itself generates an event so we can capture that).

The trouble is, with udelay(1), it could consume the CPU while waiting
for a command to complete on the controller, without letting other
tasks run.  This exhibited itself as jittery mouse movement as well as
soft lockup messages.

We need to be able to poll at faster-than-timer-tick rates, yet let
other higher-priority apps run.  Hence the schedule().  We're open to
other suggestions, but this seemed minimally intrusive while
accomplishing the goal.  No more soft lockups or jittery mice.

Thanks,
Matt

-- 
Matt Domsch
Software Architect
Dell Linux Solutions linux.dell.com & www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com
