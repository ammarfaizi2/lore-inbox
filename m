Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751681AbWGZRNM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751681AbWGZRNM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jul 2006 13:13:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751708AbWGZRNM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jul 2006 13:13:12 -0400
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:64268 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1751681AbWGZRNK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jul 2006 13:13:10 -0400
Date: Wed, 26 Jul 2006 18:12:57 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Dave Jones <davej@redhat.com>, Ingo Molnar <mingo@elte.hu>,
       Linus Torvalds <torvalds@osdl.org>,
       Chuck Ebbert <76306.1226@compuserve.com>,
       Arjan van de Ven <arjan@linux.intel.com>,
       Ashok Raj <ashok.raj@intel.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: remove cpu hotplug bustification in cpufreq.
Message-ID: <20060726171257.GC6868@flint.arm.linux.org.uk>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@osdl.org>,
	Chuck Ebbert <76306.1226@compuserve.com>,
	Arjan van de Ven <arjan@linux.intel.com>,
	Ashok Raj <ashok.raj@intel.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@osdl.org>
References: <200607242023_MC3-1-C5FE-CADB@compuserve.com> <Pine.LNX.4.64.0607241752290.29649@g5.osdl.org> <20060725185449.GA8074@elte.hu> <20060725204624.GF13829@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060725204624.GF13829@redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 25, 2006 at 04:46:24PM -0400, Dave Jones wrote:
> On Tue, Jul 25, 2006 at 08:54:49PM +0200, Ingo Molnar wrote:
>  > 
>  > * Linus Torvalds <torvalds@osdl.org> wrote:
>  > 
>  > > The current -git tree will complain about some of the more obvious 
>  > > problems. If you see a "Lukewarm IQ" message, it's a sign of somebody 
>  > > re-taking a cpu lock that is already held.
>  > testing on my latest-rawhide laptop (kernel-2.6.17-1.2445.fc6 and later 
>  > rpms have this change) seems to have pushed the problem over to another 
>  > lock:
>  > 
>  >   S06cpuspeed/1580 is trying to acquire lock:
>  >    (&policy->lock){--..}, at: [<c06075f9>] mutex_lock+0x21/0x24
>  > 
>  >   but task is already holding lock:
>  >    (cpu_bitmask_lock){--..}, at: [<c06075f9>] mutex_lock+0x21/0x24
>  > 
>  >   which lock already depends on the new lock.
>  > 
>  > and we also get the:
>  > 
>  >   Lukewarm IQ detected in hotplug locking
>  > 
>  > message :-| Find the full bootlog below. And i dont understand the 
>  > cpufreq code well enough to fix this. In fact, does anyone understand 
>  > it? :-/
> 
> Things used to be fairly simple until hotplug cpu came along :-/
> Each day, I'm getting more of the opinion that my patch just ripping
> out this garbage is the right solution.

Not sure if I'm reading your sentiment correctly, but...

It came from the ARM tree, where it had one specific problem to solve -
how to change the CPU core frequency in a safe way.

"Safe way" means informing drivers that they need to quiesce their DMA,
_carefully_ reprogramming the SDRAM timings so we don't lose system
memory, etc.  Locking was (iirc) semaphore based because we used notifier
lists and the like which could sleep (and drivers did and continue to
sleep in the callbacks).

It then got battered into working for x86, which brought a new realm of
locking issues.

Maybe the right answer back in years gone by was to be hard-nosed about
it and said "hands off, this is ARM only, invent your own".

Therefore, if you are intending throwing out cpufreq, I'd like to replace
it with the ARM-only version instead - we _require_ this infrastructure
for the correct operation of some ARM platforms.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
