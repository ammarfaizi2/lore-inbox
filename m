Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751408AbWFAFvR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751408AbWFAFvR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 01:51:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751790AbWFAFvQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 01:51:16 -0400
Received: from rune.pobox.com ([208.210.124.79]:61826 "EHLO rune.pobox.com")
	by vger.kernel.org with ESMTP id S1751408AbWFAFvQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 01:51:16 -0400
Date: Thu, 1 Jun 2006 00:50:57 -0500
From: Nathan Lynch <ntl@pobox.com>
To: Ashok Raj <ashok.raj@intel.com>
Cc: Dave Jones <davej@redhat.com>,
       Dominik Brodowski <linux@dominikbrodowski.net>,
       Arjan van de Ven <arjan@infradead.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org,
       Michal Piotrowski <michal.k.k.piotrowski@gmail.com>,
       Ingo Molnar <mingo@elte.hu>, nanhai.zou@intel.com,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>
Subject: Re: [patch 00/61] ANNOUNCE: lock validator -V1
Message-ID: <20060601055056.GI8934@localdomain>
References: <6bffcb0e0605291528qe24a0a3r3841c37c5323de6a@mail.gmail.com> <20060529224107.GA6037@elte.hu> <20060529230908.GC333@redhat.com> <1148967947.3636.4.camel@laptopd505.fenrus.org> <20060530141006.GG14721@redhat.com> <1148998762.3636.65.camel@laptopd505.fenrus.org> <20060530145852.GA6566@redhat.com> <20060530171118.GA30909@dominikbrodowski.de> <20060530193947.GG17218@redhat.com> <20060530125357.A21581@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060530125357.A21581@unix-os.sc.intel.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ashok Raj wrote:
> On Tue, May 30, 2006 at 03:39:47PM -0400, Dave Jones wrote:
> 
> > So, that last part pretty highlights that we knew about this problem, and meant to
> > come back and fix it later. Surprise surprise, no one came back and fixed it.
> > 
> 
> There was another iteration after his, and currently we keep track of
> the owner in lock_cpu_hotplug()->__lock_cpu_hotplug(). So if we are in 
> same thread context we dont acquire locks.
> 
>     if (lock_cpu_hotplug_owner != current) {
>         if (interruptible)
>             ret = down_interruptible(&cpucontrol);
>         else
>             down(&cpucontrol);
>     }
> 
> 
> the lock and unlock kept track of the depth as well, so we know when to release

Can we please kill this recursive locking hack in the cpu hotplug code
in 2.6.18/soon?  It's papering over the real problem, and I worry that
if it's allowed to sit there, other users will start to take
"advantage" of it.  Perhaps, at the very least, cpufreq could be made
to handle this itself instead of polluting the core code...


> We didnt hear any better suggestions (from cpufreq folks), so we left it in 
> that state (atlease the same thread doenst try to take the lock twice) 
> that resulted in deadlocks earlier.

Fix (and document!) the ordering of lock acquisitions in cpufreq?
