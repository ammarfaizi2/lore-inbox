Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263962AbUFNUtz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263962AbUFNUtz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jun 2004 16:49:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264236AbUFNUtz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jun 2004 16:49:55 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:17653 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S264226AbUFNUtw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jun 2004 16:49:52 -0400
Message-ID: <40CE0F2B.2000408@mvista.com>
Date: Mon, 14 Jun 2004 13:48:43 -0700
From: George Anzinger <george@mvista.com>
Reply-To: ganzinger@mvista.com
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mark Gross <mgross@linux.jf.intel.com>
CC: Arjan van de Ven <arjanv@redhat.com>,
       Geoff Levand <geoffrey.levand@am.sony.com>,
       high-res-timers-discourse@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] high-res-timers patches for 2.6.6
References: <40C7BE29.9010600@am.sony.com> <20040611062256.GB13100@devserv.devel.redhat.com> <40CA3342.9020105@mvista.com> <200406140828.08924.mgross@linux.intel.com>
In-Reply-To: <200406140828.08924.mgross@linux.intel.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Gross wrote:
> On Friday 11 June 2004 15:33, George Anzinger wrote:
> 
>>I have been thinking of a major rewrite which would leave this code alone,
>>but would introduce an additional list and, of course, overhead for
>>high-res timers. This will take some time and be sub optimal, so I wonder
>>if it is needed.
> 
> 
> What would your goal for the major rewrite be?
> Redesign the implementation?
> Clean up / re-factor the current design?
> Add features?

Mostly I would like to make it "clean" enough to get the community to accept it. 
  As I look at the current implemtation, the biggest intrusion into the "normal" 
kernel is in the timer list area.  Thus, my thinking is to introduce a second or 
slave list which would only be used by HR timers.  This list would be "checked" 
by putting a "normal" i.e. add_timer, timer in place to mark the jiffie that a 
HR timer was to expire in.  The "check" code would then set up the HR interrupt 
to expire the timer.

I am also considering removing a lot of the ifdefs one way or another.  AND, I 
think I can make the whole thing configureable at boot time just as the 
pm/TSC/etc. timers are.
> 
> I've been wondering lately if a significant restructuring of the 
> implementation could be done.  Something bottom's up that enabled changing / 
> using different time bases without rebooting and coexisted nicely with HPET.
> 
> Something along the lines of;
> * abstracting the time base's, calibration and computation of the next 
> interrupt time into a polymorphic interface along with the implementation of 
> a few of your time bases (ACPI, TSC) as a stand allown patch.

Uh, is this something like the current TSC/ pmtimer/ HPET/ PIT selection code in 
the x86?  Or do you have something else in mind here.  Given the goal of 
integration with and inclusion in the kernel.org kernel, I don't want to wander 
too far from what they are doing now.

> * implement yet another polymorphic interface for the interrupt source used by 
> the patch, along with a few interrupt sources (PIT, APIC, HPET <-- new )
> * Implement a simple RTC-like charactor driver using the above for testing and 
> integration.  

I am not sure what wants to be done here.  I have to keep in mind that x86 is 
only one of many archs.  I would like to keep it as simple as possible in this 
area.  See the include/linux/hrtime.h file for the arch interface we are now using.

> * Finally a patch to integrate the first 3 with the POSIX timers code.
> 
> What do you think?
> 
> 
> --mgross
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml

