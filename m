Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932210AbVHLHEj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932210AbVHLHEj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Aug 2005 03:04:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932348AbVHLHEj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Aug 2005 03:04:39 -0400
Received: from zproxy.gmail.com ([64.233.162.205]:40936 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932210AbVHLHEi convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Aug 2005 03:04:38 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=JBzjejaw+m7afPcx+oG/7xlWdjD8vVKXsQem0tfgbQ24QAG8pAnuB3T5BV2dtXDcue5+xIRVHtqYyy+Z8MDKa3FUjm1oHiUj17Pch/01ZGY0loFQYuLj2pq2INt1T8UllTuvZ7enPoQsy/Zo/pp1NURrkzNUBpPo7exONX665EI=
Message-ID: <86802c44050812000473eeaade@mail.gmail.com>
Date: Fri, 12 Aug 2005 00:04:38 -0700
From: yhlu <yhlu.kernel@gmail.com>
To: Andi Kleen <ak@suse.de>
Subject: Re: [discuss] Re: 2.6.13-rc2 with dual way dual core ck804 MB
Cc: Mike Waychison <mikew@google.com>, YhLu <YhLu@tyan.com>,
       Peter Buckingham <peter@pantasys.com>, linux-kernel@vger.kernel.org,
       "discuss@x86-64.org" <discuss@x86-64.org>
In-Reply-To: <86802c4405081123597239dff7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <3174569B9743D511922F00A0C94314230AF97867@TYANWEB>
	 <20050810232614.GC27628@wotan.suse.de>
	 <86802c4405081016421db9baa5@mail.gmail.com>
	 <20050811000430.GD8974@wotan.suse.de>
	 <86802c4405081017174c22dcd5@mail.gmail.com>
	 <86802c440508101723d4aadef@mail.gmail.com>
	 <20050811002841.GE8974@wotan.suse.de>
	 <86802c440508101743783588df@mail.gmail.com>
	 <20050811005100.GF8974@wotan.suse.de>
	 <86802c4405081123597239dff7@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

andi,

it seems ia64 is after done with the tsc_sync then set the callin_map.

YH

        if (!(sal_platform_features & IA64_SAL_PLATFORM_FEATURE_ITC_DRIFT)) {
                /*
                 * Synchronize the ITC with the BP.  Need to do this
after irqs are
                 * enabled because ia64_sync_itc() calls
smp_call_function_single(), which
                 * calls spin_unlock_bh(), which calls
spin_unlock_bh(), which calls
                 * local_bh_enable(), which bugs out if irqs are not enabled...
                 */
                Dprintk("Going to syncup ITC with BP.\n");
                ia64_sync_itc(0);
        }

        /*
         * Get our bogomips.
         */
        ia64_init_itm();
        calibrate_delay();
        local_cpu_data->loops_per_jiffy = loops_per_jiffy;

#ifdef CONFIG_IA32_SUPPORT
        ia32_gdt_init();
#endif

        /*
         * Allow the master to continue.
         */
        cpu_set(cpuid, cpu_callin_map);


On 8/11/05, yhlu <yhlu.kernel@gmail.com> wrote:
> andi,
> 
> is it possible for
> after the AP1 call_in is done and before AP1 get in tsc_sync_wait
> The AP2 call_in done.  and then AP1 get in tsc_sync_wait and before it
> done, AP2 get in tsc_sync_wait too.
> 
> sync_master can not figure out from AP1 or AP2 because only have
> go[MASTER] and go{SLAVE].
> 
> YH
> 
> On 8/10/05, Andi Kleen <ak@suse.de> wrote:
> > On Wed, Aug 10, 2005 at 05:43:23PM -0700, yhlu wrote:
> > > Yes, I mean more aggressive
> > >
> > > static void __init smp_init(void)
> > > {
> > >         unsigned int i;
> > >
> > >         /* FIXME: This should be done in userspace --RR */
> > >         for_each_present_cpu(i) {
> > >                 if (num_online_cpus() >= max_cpus)
> > >                         break;
> > >                 if (!cpu_online(i))
> > >                         cpu_up(i);
> > >         }
> > >
> > >
> > > let cpu_up take one array instead of one int.
> >
> > It can be done already by just not starting the CPUs and
> > then do it multithreaded from user space using sysfs with
> > the CPU hotplug infrastructure. Unfortunately cpu_up
> > right now has a global semaphore, so it won't save you any
> > time. However it could be done in parallel with other
> > startup jobs.
> >
> > -Andi
> >
>
