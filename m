Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261327AbVEXRGO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261327AbVEXRGO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 May 2005 13:06:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261157AbVEXRES
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 May 2005 13:04:18 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.146]:15547 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261154AbVEXRCq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 May 2005 13:02:46 -0400
Date: Tue, 24 May 2005 22:31:33 +0530
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: Andi Kleen <ak@muc.de>
Cc: Ashok Raj <ashok.raj@intel.com>, zwane@arm.linux.org.uk,
       discuss@x86-64.org, shaohua.li@intel.com, linux-kernel@vger.kernel.org,
       rusty@rustcorp.com.au
Subject: Re: [discuss] Re: [patch 0/4] CPU hot-plug support for x86_64
Message-ID: <20050524170133.GA10807@in.ibm.com>
Reply-To: vatsa@in.ibm.com
References: <20050520221622.124069000@csdlinux-2.jf.intel.com> <20050523164046.GB39821@muc.de> <20050523095450.A8193@unix-os.sc.intel.com> <20050523171212.GF39821@muc.de> <20050523104046.B8692@unix-os.sc.intel.com> <20050524114812.GA86233@muc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050524114812.GA86233@muc.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 24, 2005 at 01:48:12PM +0200, Andi Kleen wrote:
> On Mon, May 23, 2005 at 10:40:46AM -0700, Ashok Raj wrote:
> > I think so, if we can ensure none is delivered to the partially up cpu
> > we probably are covered.
> 
> You mean not delivered to its APIC or not delivered as an visible
> interrupt in the instruction stream?

I think Ashok is referring to first.
> 
> The later can be ensured, the first not. I guess if the first is a problem
> you could add a function to ack all pending interrupts after initial sti.

I dont think it is that simple. 

First, do we handle the pending interrupt as normal interrupts? For ex: in 
case of call function interrupt, do we read the call_data_struct, which may be
stale if we are handling a stale IPI (IPI that was sent to us but caller
didnt wait for us to read the call_data_struct)?

Ideally we have to drop (not handle) such stale interrupts. Which 
means add a flag in the interrupt handler. If flag is set, interrupt
is dropped otherwise it is handled. This flag may be set by the upcoming
CPU before doing STI. It may be cleared by it after a brief time after STI.
And this may affect the fast path.

Alternately we may register dummy handlers for various IRQs, sti, wait
for pending IRQs to be flushed and then register the real handlers (and
_then_ set the CPU in the online map?)

Secondly, I think there is another subtle race if we broadcast IPIs. Consider 
this:

	CPU0			CPU1

				Puts itself Offline

	smp_call_function

	   broadcasts IPI
					IPI queued on CPU1

					Wants to come online now

					spin_lock(call_lock)	
	
	spin_lock(call_lock)		cpu_set(cpu1, online_map);
	
					spin_unlock(call_lock);
	
					

		broadcast IPI	
		wait_for_all_cpus
		(including CPU1)
					sti();

					gets IPI, but decides to not handle
					it since it may be a stale IPI

		

This causes CPU0 to wait forever? Not sure if I have missed some h/w subtelity 
here.

This problem could probably be prevented if cpu1 is set in the online_map
after the sti.

	
> 
> e.g. we can assume the CPU will deliver everything pending after two
> instruction after the sti and when there are interrupts left in the APIC 
> you can ack them. But why would they not be raised as real interruptions
> at this point anyways?
> 
> 
> > Iam not a 100% sure about above either, if the smp_call_function 
> > is started with 3 cpus initially, and 1 just came up, the counts in 
> > the smp_call data struct could be set to 3 as a result of the new cpu 
> > received this broadcast as well, and we might quit earlier in the wait.
> 
> In the worst case a smp_call_function would be delayed for the whole
> boot up time of a new CPU which should be quite bounded. The longest
> delay in there is probably the bogomips calibrate, but I believe
> Venkatesh recently sped that up greatly anyways so it should not be 
> an issue anymore. If the delay is < 1s that is probably tolerable.
> 
> Or do I miss some shade of the problem you are worried about?

The problem is at the time smp_call_function was running on CPU0 say,
only CPU1 and CPU2 were online. So it decides that it has to wait for
2 CPUs to ack the IPI. Next it broadcasts the IPI. At this particular
point, CPU3 is coming up and is yet to do a STI. Meanwhile, CPU1 and CPU2
ACK CPU0's call_function IPI. Hence smp_call_function on CPU0 decides to 
return, which makes call_data_struct stale (since it was on the stack). After 
this CPU3 does a STI and gets now the call_function IPI. If it were to handle
this IPI normally, it will read the stale call_data_struct and may 
crash. Ideally, CPU3 should have dropped that stale IPI.

I think doing a send_IPI_mask is a safe solution for this problem,
unless h/w avoids broadcasting IPIs to offline CPUs.


-- 


Thanks and Regards,
Srivatsa Vaddagiri,
Linux Technology Center,
IBM Software Labs,
Bangalore, INDIA - 560017
