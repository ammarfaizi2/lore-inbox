Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265029AbUFVRrR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265029AbUFVRrR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 13:47:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264936AbUFVRqp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 13:46:45 -0400
Received: from mail8.fw-bc.sony.com ([160.33.98.75]:1437 "EHLO
	mail8.fw-bc.sony.com") by vger.kernel.org with ESMTP
	id S265043AbUFVRjB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 13:39:01 -0400
Message-ID: <40D86E51.2080108@am.sony.com>
Date: Tue, 22 Jun 2004 10:37:21 -0700
From: Geoff Levand <geoffrey.levand@am.sony.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.1) Gecko/20031030
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: ganzinger@mvista.com
CC: Mark Gross <mgross@linux.jf.intel.com>,
       Arjan van de Ven <arjanv@redhat.com>,
       high-res-timers-discourse@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] high-res-timers patches for 2.6.6
References: <40C7BE29.9010600@am.sony.com> <20040611062256.GB13100@devserv.devel.redhat.com> <40CA3342.9020105@mvista.com> <200406140828.08924.mgross@linux.intel.com> <40D7662A.2030006@am.sony.com> <40D76C76.7000509@mvista.com>
In-Reply-To: <40D76C76.7000509@mvista.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

George Anzinger wrote:
> Geoff Levand wrote:
> 
>> Mark Gross wrote:
>>
>>> On Friday 11 June 2004 15:33, George Anzinger wrote:
>>>
>>>> I have been thinking of a major rewrite which would leave this code 
>>>> alone,
>>>> but would introduce an additional list and, of course, overhead for
>>>> high-res timers. This will take some time and be sub optimal, so I 
>>>> wonder
>>>> if it is needed.
>>>
>>>
>>>
>>>
>>> What would your goal for the major rewrite be?
>>> Redesign the implementation?
>>> Clean up / re-factor the current design?
>>> Add features?
>>>
>>> I've been wondering lately if a significant restructuring of the 
>>> implementation could be done.  Something bottom's up that enabled 
>>> changing / using different time bases without rebooting and coexisted 
>>> nicely with HPET.
>>>
>>> Something along the lines of;
>>> * abstracting the time base's, calibration and computation of the 
>>> next interrupt time into a polymorphic interface along with the 
>>> implementation of a few of your time bases (ACPI, TSC) as a stand 
>>> allown patch.
>>> * implement yet another polymorphic interface for the interrupt 
>>> source used by the patch, along with a few interrupt sources (PIT, 
>>> APIC, HPET <-- new )
>>> * Implement a simple RTC-like charactor driver using the above for 
>>> testing and integration.  * Finally a patch to integrate the first 3 
>>> with the POSIX timers code.
>>>
>>> What do you think?
>>>
>>>
>>> --mgross
>>>
>>
>> Mark,
>>
>> Generally I agree with your ideas on what needs fixing up, but I'm 
>> concerned that the run-time binding of this kind of design would have 
>> too much overhead for time-critical code paths.  Do you think it is 
>> useful to have run-time selection of the time base and interrupt 
>> source?   In my work we have a known fixed hardware configuration that 
>> has limited timers, so I don't really see a need for runtime 
>> configuration there.
> 
> 
> Well, I don't see much added overhead, (save memory).  We already 
> dispatch interrupts via indirect function calls in irq.c.  And the core 
> clock functions (used by gettimeofday, for example) are also indirected 
> today (this to allow pm-timer, TSC, or PIT at boot time).  All we would 
> do is put both of our possibilities in the list.  The only place we add 
> overhead is in an indirect to the "proper" hardware timer for the 
> sub-jiffie interrupt.
> 

If that's the case, then Mark's proposal sounds like a good way to 
abstract the arch dependent code.  Someone mentioned to me that distro 
vendors would like the idea of runtime configuration because they could 
use a single kernel binary to support many different hardware 
configurations.  I suppose if needed some optimization can be done later.

Mark, do you have time to do a first cut at the interfaces?  It seems 
you've been thinking about this, and I'd like to see your ideas.  It 
would be great if you could put together a sample hrtime.h.  If you are 
short on time, I could put something together, but I think you are the 
guy to do this.

 From what I've been told, Renesas did an HRT port to the SH arch on a 
recent kernel.  I'm trying to get the code so that there will be three 
arch's (i386, ppc32 & sh) to work against when doing the arch 
independent interface.

Another thing that seems to be a sore point is the HRT core.  I think 
there's a good consensus that the current use of preprocessor 
conditionals makes the code pretty hairy, but what alternatives are there?

If the HRT code is always compiled in, that would simplify things alot, 
but then there would always be a small performance hit in the compares, 
and a slightly bigger code size.  Is this acceptable?  Also, something 
would need to be arranged to take care of the non-supported arch's.  Any 
ideas here?

Another way would be to pull out the HRT operations into separate 
functions that could be conditionally included or replaced with no-op 
versions based on a config option.  I don't know if this would be 
do-able, or if the result would be very clean though...

George also mentioned an idea of a second 'timer slave list'.   Any 
other ideas here?


-Geoff




