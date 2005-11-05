Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932221AbVKEXzA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932221AbVKEXzA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Nov 2005 18:55:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932222AbVKEXzA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Nov 2005 18:55:00 -0500
Received: from fmr22.intel.com ([143.183.121.14]:17109 "EHLO
	scsfmr002.sc.intel.com") by vger.kernel.org with ESMTP
	id S932221AbVKEXy7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Nov 2005 18:54:59 -0500
Date: Sat, 5 Nov 2005 15:54:07 -0800
From: Ashok Raj <ashok.raj@intel.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Ashok Raj <ashok.raj@intel.com>, rjw@sisk.pl, linux-kernel@vger.kernel.org,
       davej@codemonkey.org.uk, mingo@elte.hu, linux@brodo.de,
       venkatesh.pallipadi@intel.com
Subject: Re: 2.6.14-git3: scheduling while atomic from cpufreq on Athlon64
Message-ID: <20051105155407.A31099@unix-os.sc.intel.com>
References: <200510311606.36615.rjw@sisk.pl> <200510312045.32908.rjw@sisk.pl> <20051031124216.A18213@unix-os.sc.intel.com> <200511012007.19762.rjw@sisk.pl> <20051101111417.A31379@unix-os.sc.intel.com> <20051104143035.120fe158.akpm@osdl.org> <20051105151944.A30804@unix-os.sc.intel.com> <20051105153304.09a1a4dc.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20051105153304.09a1a4dc.akpm@osdl.org>; from akpm@osdl.org on Sat, Nov 05, 2005 at 03:33:04PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 05, 2005 at 03:33:04PM -0800, Andrew Morton wrote:
> Ashok Raj <ashok.raj@intel.com> wrote:
> >
> > Now we leave a trace in current->flags indicating current thread already 
> >  is under cpucontrol lock held, so we dont attempt to do this another time.
> > 
> > ..
> > +#define PF_HOTPLUG_CPU	0x01000000	/* Currently performing CPU hotplug */
> >
> 
> It's still hacky - I mean, we could use this trick to avoid recursion onto
> any lock in the kernel whenever we get ourselves into a mess.  We'd gain an
> awful lot of PF_* flags.
> 
> So we should still view this as a temporary fix.
> 
> I don't think I've seen an analysis of the actual deadlock yet.  Are you
> able to provide a stack trace of the offending callpath?

Hi Andrew,

we call the exact same functions in cpufreq during startup and in
response to cpu hotplug events, to create or destroy
sysfs entries /sys/devices/system/cpu/cpuX/cpufreq/*. cpufreq_add_dev().

problem is cpufreq_set_policy()  eventually ends up calling
__cpufreq_driver_target() during the CPU_ONLINE, and CPU_DOWN_PREPARE
that takes cpucontrol lock.

Since when we already in the cpu notifier callbacks, cpucontrol is already 
held by the cpu_up() or the cpu_down() that caused the double lock.

i dont see a panic, but just when we try to do cpu_down, or cpu_up that
thread would just lock out waiting to acquire the cpucontrol the second
time.

Hope this helps.
-- 
Cheers,
Ashok Raj
- Open Source Technology Center
