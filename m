Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262015AbULPUjQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262015AbULPUjQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Dec 2004 15:39:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262014AbULPUjP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Dec 2004 15:39:15 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:39406 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S262012AbULPUie
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Dec 2004 15:38:34 -0500
Message-ID: <41C1F23E.9020006@mvista.com>
Date: Thu, 16 Dec 2004 12:38:22 -0800
From: George Anzinger <george@mvista.com>
Reply-To: george@mvista.com
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.2) Gecko/20040308
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Anton Blanchard <anton@samba.org>
CC: john stultz <johnstul@us.ibm.com>, David Vrabel <dvrabel@arcom.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>, mann@vmware.com
Subject: Re: Jiffy based timers/timeouts can expire too soon.
References: <41AF3D50.4090707@arcom.com> <1102013246.13294.19.camel@cog.beaverton.ibm.com> <20041202232803.GA6387@krispykreme.ozlabs.ibm.com>
In-Reply-To: <20041202232803.GA6387@krispykreme.ozlabs.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anton Blanchard wrote:
>  
> 
>>Well, hopefully the lost tick detection code won't over compensate, so
>>it shouldn't be an issue. However, as Tim Mann pointed out it, due to
>>interrupt delay and queuing, it is seen on virtualized systems.
> 
> 
> We saw this on ppc64 on earlier 2.6 kernels. There were some bugs with
> the VM where interrupts would get disabled for a long time (we saw 20+
> second periods). A SCSI timeout would occur on another CPU and at that
> time irqs would get reenabled and 20 seconds of time would get replayed.
> 
> A bunch of timers would go off early and the SCSI adapter would explode.

The problem is that "most" code believes jiffies is right.  Under long interrupt 
off times, it is not.  I suspect that most of the early timers came from code 
that set the timer with the interrupt system off.  Some might say they got what 
they deserved :).

In the HRT patch, we always correct jiffies to the real value (by marking the 
TSC value at the last jiffie push and using that plus the current TSC to 
correct).  It would be rather easy to provide an interface to get the current 
real current jiffie, but it is another thing to correct all the code that uses 
jiffie.  Attempts to make jiffie a macro pick up far too many uses of the word 
in several name spaces to make it a reasonable thing to do.
-
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/

