Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932389AbVJZL15@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932389AbVJZL15 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Oct 2005 07:27:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932540AbVJZL14
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Oct 2005 07:27:56 -0400
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:47071 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S932389AbVJZL14 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Oct 2005 07:27:56 -0400
Subject: Re: 2.6.14-rc5-rt6  -- False NMI lockup detects
From: Steven Rostedt <rostedt@goodmis.org>
To: george@mvista.com
Cc: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>,
       john stultz <johnstul@us.ibm.com>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <435E8EDE.30306@mvista.com>
References: <1130250219.21118.11.camel@localhost.localdomain>
	 <20051025142848.GA7642@elte.hu>
	 <1130268292.21118.22.camel@localhost.localdomain>
	 <435E8EDE.30306@mvista.com>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Wed, 26 Oct 2005 07:27:26 -0400
Message-Id: <1130326046.21118.65.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-10-25 at 13:00 -0700, George Anzinger wrote:
> Steven Rostedt wrote:
> > On Tue, 2005-10-25 at 16:28 +0200, Ingo Molnar wrote:
> > 
> >>* Steven Rostedt <rostedt@goodmis.org> wrote:
> >>
> >>
> >>>Hi Ingo and Thomas,
> >>>
> >>>On some of my machines, I've been experiencing false NMI lockups.  
> >>>This usually happens on slower machines, and taking a look into this, 
> >>>it seems to be due to a short time where no processes are using 
> >>>timers, and the ktimer interrupts aren't needed. So the APIC timer, 
> >>>which now is used only for the ktimers, has a five second pause, and 
> >>>causes the NMI to go off.  The NMI uses the apic timer to determine 
> >>>lockups.
> >>
> >>this would be a bug - the jiffy tick should be processed every 1 msec, 
> >>regardless of whether there are any ktimers pending. (in the future we 
> >>want to use a special ktimer for the jiffy tick, but that's not 
> >>implemented yet.)
> >>
> > 
> > 
> > Isn't the jiffy tick implemented with the PIT when possible? So the apic
> > is only used when a timer is needed.  Also note that this "lockup"
> > happens on boot up while things are being initialized, so not many
> > things may be using the timer.
> 
> Somewhere in the not too distant past the NMI watchdog was moved from the PIT tick to the APIC 
> timer.  Might want to move it back, at least for now...

Ingo,

So what's the fix here?  The PIT is used for jiffies and the NMI lockup
uses the apic timer to test against.  So if there isn't a ktimer that
goes off for 5 seconds (usually on slower machines), you get a false
positive for a lockup.  Is this really a bug that the apic doesn't go
off for 5 seconds?

So, do we move the NMI detect back to the PIT, or use a more generic
solution that I supplied?  I actually prefer my generic solution because
1. we don't need to worry about which timers we are using at the moment.
2. Like you said, it can be used later on with things like dynamic
ticks, or tickless solutions.

-- Steve


