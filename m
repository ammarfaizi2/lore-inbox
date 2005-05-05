Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261468AbVEEUrZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261468AbVEEUrZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 May 2005 16:47:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262184AbVEEUrZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 May 2005 16:47:25 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:39676 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S261468AbVEEUrT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 May 2005 16:47:19 -0400
Message-ID: <427A8606.1050607@mvista.com>
Date: Thu, 05 May 2005 13:45:58 -0700
From: George Anzinger <george@mvista.com>
Reply-To: george@mvista.com
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050323 Fedora/1.7.6-1.3.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
CC: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       mingo@elte.hu, linux-kernel <linux-kernel@vger.kernel.org>,
       Rajesh Shah <rajesh.shah@intel.com>, John Stultz <johnstul@us.ibm.com>,
       Andi Kleen <ak@suse.de>, Asit K Mallick <asit.k.mallick@intel.com>
Subject: Re: [RFC][PATCH] i386 x86-64 Eliminate Local APIC timer interrupt
References: <20050429172605.A23722@unix-os.sc.intel.com>
In-Reply-To: <20050429172605.A23722@unix-os.sc.intel.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Venkatesh Pallipadi wrote:
> Background: 
> Local APIC timer stops functioning when CPU is in C3 state. As a
> result the local APIC timer interrupt will fire at uncertain times, depending
> on how long we spend in C3 state. And this has two side effects
> * Idle balancing will not happen as we expect it to.
> * Kernel statistics for idle time will not be proper (as we get less LAPIC
>   interrupts when we are idle). This can result in confusing other parts of
>   kernel (like ondemand cpufreq governor) which depends on this idle stats.
> 
> 
> Proposed Fix: 
> Attached is a prototype patch, that tries to eliminate the dependency on 
> local APIC timer for update_process_times(). The patch gets rid of Local APIC 
> timer altogether. We use the timer interrupt (IRQ 0) configured in 
> broadcast mode in IOAPIC instead (Doesn't work with 8259). 
> As changing anything related to basic timer interrupt is a little bit risky, 
> I have a boot parameter currently ("useapictimer") to switch back to original 
> local APIC timer way of doing things.
> 
> This may seem like a overkill to solve this particular problem. But, I feel
> it simplifies things and will have other advantages:
> * Should help dynamick tick as one has to change only global timer interrupt 
>   freq with varying jiffies.
> * Reduces one interrupt per jiffy. 
> * One less interrupt source to worry about.
>

Sorry I missed this when it came out, but,  I think a better way to handle this 
is to use an IPI.  In the non-VST case it can be to all but self, while when a 
given cpu is sleeping we can not send it to that cpu.  The advantages are:
1) The broadcast has a race/ contention on the xtime lock.  The read lock is 
needed by all and the write lock taken by one.  The IPI should be sent AFTER the 
xtime write unlock.
2) It is easy to prune VST sleeping cpus from the list of all to wake.




-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
