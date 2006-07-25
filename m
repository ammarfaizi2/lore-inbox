Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964842AbWGYTb1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964842AbWGYTb1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jul 2006 15:31:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964843AbWGYTb1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jul 2006 15:31:27 -0400
Received: from a222036.upc-a.chello.nl ([62.163.222.36]:4490 "EHLO
	laptopd505.fenrus.org") by vger.kernel.org with ESMTP
	id S964842AbWGYTb0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jul 2006 15:31:26 -0400
Subject: Re: remove cpu hotplug bustification in cpufreq.
From: Arjan van de Ven <arjan@linux.intel.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Chuck Ebbert <76306.1226@compuserve.com>,
       Ashok Raj <ashok.raj@intel.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Dave Jones <davej@redhat.com>, Andrew Morton <akpm@osdl.org>
In-Reply-To: <20060725185449.GA8074@elte.hu>
References: <200607242023_MC3-1-C5FE-CADB@compuserve.com>
	 <Pine.LNX.4.64.0607241752290.29649@g5.osdl.org>
	 <20060725185449.GA8074@elte.hu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 25 Jul 2006 21:30:44 +0200
Message-Id: <1153855844.8932.56.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-07-25 at 20:54 +0200, Ingo Molnar wrote:
> * Linus Torvalds <torvalds@osdl.org> wrote:
> 
> > The current -git tree will complain about some of the more obvious 
> > problems. If you see a "Lukewarm IQ" message, it's a sign of somebody 
> > re-taking a cpu lock that is already held.
> 
> testing on my latest-rawhide laptop (kernel-2.6.17-1.2445.fc6 and later 
> rpms have this change) seems to have pushed the problem over to another 
> lock:
> 
>   S06cpuspeed/1580 is trying to acquire lock:
>    (&policy->lock){--..}, at: [<c06075f9>] mutex_lock+0x21/0x24
> 
>   but task is already holding lock:
>    (cpu_bitmask_lock){--..}, at: [<c06075f9>] mutex_lock+0x21/0x24
> 
>   which lock already depends on the new lock.


so cpufreq_set_policy() takes policy->lock, and then calls into the
userspace governer code
(__cpufreq_set_policy->cpufreq_governor->cpufreq_governor_userspace)
which calls __cpufreq_driver_target... which does lock_cpu_hotplug().


now on the other side:
store_scaling_governor() has the following code:

        lock_cpu_hotplug();

        /* Do not use cpufreq_set_policy here or the user_policy.max
           will be wrongly overridden */
        mutex_lock(&policy->lock);

so that's the entirely opposite lock order, and a classic AB-BA
deadlock.

Greetings,
     Arjan -- who's just cleaned Linus' wall to prepare it for more head
banging


