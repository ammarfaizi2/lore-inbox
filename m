Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932436AbWE3TkO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932436AbWE3TkO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 15:40:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932438AbWE3TkN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 15:40:13 -0400
Received: from mx1.redhat.com ([66.187.233.31]:21740 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932436AbWE3TkL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 15:40:11 -0400
Date: Tue, 30 May 2006 15:39:47 -0400
From: Dave Jones <davej@redhat.com>
To: Dominik Brodowski <linux@dominikbrodowski.net>,
       Arjan van de Ven <arjan@infradead.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org,
       Michal Piotrowski <michal.k.k.piotrowski@gmail.com>,
       Ingo Molnar <mingo@elte.hu>, nanhai.zou@intel.com, ashok.raj@intel.com
Subject: Re: [patch 00/61] ANNOUNCE: lock validator -V1
Message-ID: <20060530193947.GG17218@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Dominik Brodowski <linux@dominikbrodowski.net>,
	Arjan van de Ven <arjan@infradead.org>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	Michal Piotrowski <michal.k.k.piotrowski@gmail.com>,
	Ingo Molnar <mingo@elte.hu>, nanhai.zou@intel.com,
	ashok.raj@intel.com
References: <20060529212109.GA2058@elte.hu> <6bffcb0e0605291528qe24a0a3r3841c37c5323de6a@mail.gmail.com> <20060529224107.GA6037@elte.hu> <20060529230908.GC333@redhat.com> <1148967947.3636.4.camel@laptopd505.fenrus.org> <20060530141006.GG14721@redhat.com> <1148998762.3636.65.camel@laptopd505.fenrus.org> <20060530145852.GA6566@redhat.com> <20060530171118.GA30909@dominikbrodowski.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060530171118.GA30909@dominikbrodowski.de>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 30, 2006 at 07:11:18PM +0200, Dominik Brodowski wrote:
 
 > On Tue, May 30, 2006 at 10:58:52AM -0400, Dave Jones wrote:
 > > On Tue, May 30, 2006 at 04:19:22PM +0200, Arjan van de Ven wrote:
 > > 
 > >  > >  > One
 > >  > >  > ---
 > >  > >  > store_scaling_governor takes policy->lock and then calls __cpufreq_set_policy
 > >  > >  > __cpufreq_set_policy calls __cpufreq_governor
 > >  > >  > __cpufreq_governor  calls __cpufreq_driver_target via cpufreq_governor_performance
 > >  > >  > __cpufreq_driver_target calls lock_cpu_hotplug() (which takes the hotplug lock)
 > >  > >  > 
 > >  > >  > 
 > >  > >  > Two
 > >  > >  > ---
 > >  > >  > cpufreq_stats_init lock_cpu_hotplug() and then calls cpufreq_stat_cpu_callback
 > >  > >  > cpufreq_stat_cpu_callback calls cpufreq_update_policy
 > >  > >  > cpufreq_update_policy takes the policy->lock
 > >  > >  > 
 > >  > >  > 
 > >  > >  > so this looks like a real honest AB-BA deadlock to me...
 > >  > > 
 > >  > > This looks a little clearer this morning.  I missed the fact that sys_init_module
 > >  > > isn't completely serialised, only the loading part. ->init routines can and will be
 > >  > > called in parallel.
 > >  > > 
 > >  > > I don't see where cpufreq_update_policy takes policy->lock though.
 > >  > > In my tree it just takes the per-cpu data->lock.
 > >  > 
 > >  > isn't that basically the same lock?
 > > 
 > > Ugh, I've completely forgotten how this stuff fits together.
 > > 
 > > Dominik, any clues ?
 > 
 > That's indeed a possible deadlock situation -- what's the
 > cpufreq_update_policy() call needed for in cpufreq_stat_cpu_callback anyway?

Oh wow. Reading the commit message of this change rings alarm bells.

change c32b6b8e524d2c337767d312814484d9289550cf has this to say..

    [PATCH] create and destroy cpufreq sysfs entries based on cpu notifiers
    
    cpufreq entries in sysfs should only be populated when CPU is online state.
     When we either boot with maxcpus=x and then boot the other cpus by echoing
    to sysfs online file, these entries should be created and destroyed when
    CPU_DEAD is notified.  Same treatement as cache entries under sysfs.
    
    We place the processor in the lowest frequency, so hw managed P-State
    transitions can still work on the other threads to save power.
    
    Primary goal was to just make these directories appear/disapper dynamically.
    
    There is one in this patch i had to do, which i really dont like myself but
    probably best if someone handling the cpufreq infrastructure could give
    this code right treatment if this is not acceptable.  I guess its probably
    good for the first cut.
    
    - Converting lock_cpu_hotplug()/unlock_cpu_hotplug() to disable/enable preempt.
      The locking was smack in the middle of the notification path, when the
      hotplug is already holding the lock. I tried another solution to avoid this
      so avoid taking locks if we know we are from notification path. The solution
      was getting very ugly and i decided this was probably good for this iteration
      until someone who understands cpufreq could do a better job than me.

So, that last part pretty highlights that we knew about this problem, and meant to
come back and fix it later. Surprise surprise, no one came back and fixed it.

		Dave

-- 
http://www.codemonkey.org.uk
