Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261722AbULBSr0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261722AbULBSr0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Dec 2004 13:47:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261724AbULBSr0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Dec 2004 13:47:26 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:8152 "EHLO e33.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S261722AbULBSrW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Dec 2004 13:47:22 -0500
Subject: Re: Jiffy based timers/timeouts can expire too soon.
From: john stultz <johnstul@us.ibm.com>
To: David Vrabel <dvrabel@arcom.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, mann@vmware.com
In-Reply-To: <41AF3D50.4090707@arcom.com>
References: <41AF3D50.4090707@arcom.com>
Content-Type: text/plain
Message-Id: <1102013246.13294.19.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Thu, 02 Dec 2004 10:47:27 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-12-02 at 08:05, David Vrabel wrote:
> Jiffy based timers and timeouts can expire too soon because the timer 
> interrupt accounts for lost ticks and can increment jiffies by more than 1.
> 
> Consider the following:
> 
>      unsigned long timeout = jiffies + 1;
> 
>     <--- timer interrupt here:
>          jiffies += 2 (i.e., catching up one missed interrupt)
> 
>     if (time_after(jiffies, timeout))
> 	/* but 1 tick worth of time hasn't (necessarily) elapsed */

Well, hopefully the lost tick detection code won't over compensate, so
it shouldn't be an issue. However, as Tim Mann pointed out it, due to
interrupt delay and queuing, it is seen on virtualized systems.

See http://www.ussg.iu.edu/hypermail/linux/kernel/0411.2/2293.html for
his explanation.

> This was originally observed on an ARM platform[1] but the i386 timer 
> interrupt appears to behave in a similar way.
> 
> Is this solution here to:
> 
> 1. Not use jiffies for timers/timeouts with only a few ticks?
> 
> or
> 
> 2. Have two independant "jiffies": the existing one which is used for 
> the wallclock only; and one which counts the number of timer interrupts 
> and will guarantee that timers don't expire prematurely?
> 
> or
> 
> 3. Something else?

Ideally (in my mind), we need to first get a stable and reliable time
base that isn't affected by lost interrupts. This is what I've been
(unfortunately not very frequently) working on w/ my time of day re-work
(See http://lwn.net/Articles/100665/ - although this is somewhat out of
date as I've been re-working some bits and need to post a new set of
patches soon). 

Once that is done, we can convert the timer subsystem to use units of
nanoseconds, rather then jiffies for its time accounting. Interrupt
delay, loss, and queuing then become a latency issue, rather then a
correctness one.

However, patches speak louder then words (and I need to do less talking
and more coding), so don't let me keep you from implementing your own
solution. 

thanks
-john

