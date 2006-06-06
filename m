Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751315AbWFFXAf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751315AbWFFXAf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jun 2006 19:00:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751304AbWFFXAf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jun 2006 19:00:35 -0400
Received: from mx1.redhat.com ([66.187.233.31]:29927 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751302AbWFFXAe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jun 2006 19:00:34 -0400
Date: Tue, 6 Jun 2006 19:05:04 -0400
From: Don Zickus <dzickus@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: ak@suse.de, shaohua.li@intel.com, miles.lane@gmail.com, jeremy@goop.org,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6.17-rc5-mm2] crash when doing second suspend: BUG in arch/i386/kernel/nmi.c:174
Message-ID: <20060606230504.GC11696@redhat.com>
References: <4480C102.3060400@goop.org> <1149576246.32046.166.camel@sli10-desk.sh.intel.com> <20060606141755.GN2839@redhat.com> <200606061618.15415.ak@suse.de> <20060606214553.GB11696@redhat.com> <20060606151507.613edaad.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060606151507.613edaad.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 06, 2006 at 03:15:07PM -0700, Andrew Morton wrote:
> On Tue, 6 Jun 2006 17:45:53 -0400
> Don Zickus <dzickus@redhat.com> wrote:
> 
> > On Tue, Jun 06, 2006 at 04:18:15PM +0200, Andi Kleen wrote:
> > > 
> > > > Because he is using a i386 machine, the nmi watchdog is disabled by
> > > > default. 
> > > 
> > > I changed that - it's now on by default on i386 too.
> > > 
> > > -Andi
> > 
> > I am trying to create a patch for this problem and it just dawned on me,
> > how does one store the previous state in a suspend/resume path if the code
> > hotplugs all the cpus first?  CPU0 is easy because an explicit
> > suspend/resume path is called, but it seems to be called last after all
> > the other cpus have been removed.  How do I save the state?
> 
> I'm really struggling to understand this question.  If you're referring to
> some per-cpu state then a CPU hotplug handler would be appropriate?

Sorry.  I got ahead of myself.  My concern is how the suspend/resume code
works with device drivers on an SMP system.  My initial impression was
that the subsystem registers with the suspend/resume layer and upon such
actions those registered functions are called.  

Inside those functions I saved the previous state of the watchdog timer.
However, I learned today that my understanding was incorrect.  Instead
first the _hotplug_ code is called for every cpu _except_ cpu0.  The
_suspend/resume_ functions are only called in the context of _cpu0_.  

This breaks the design I have because upon resuming the watchdog timers
automatically start on all cpus (except cpu0 because I saved the previous
state through the handlers), regardless of what the previous state was.  

So my question is/was what is the proper way to handle processor level
subsystems during the suspend/resume path on an SMP system.  I really
don't understand the hotplug path nor the suspend/resume path very well.  

I didn't want to register a hotplug handler because a hotplug event is
really different than a suspend event (I want to _save_ info during a
suspend event).  The documentation I was reading seemed to suggest that
hotplug/suspend/smp was a work-in-progress. 

Is the typical approach to just hack in an extra parameter to the
start/stop functions of the nmi_watchdog letting the function know it is
coming through the suspend/resume path? 

Any tips, code, other docs would be helpful.

Cheers,
Don
