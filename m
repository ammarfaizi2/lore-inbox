Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265098AbUFWAQX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265098AbUFWAQX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 20:16:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265103AbUFWAQX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 20:16:23 -0400
Received: from mail8.fw-bc.sony.com ([160.33.98.75]:502 "EHLO
	mail8.fw-bc.sony.com") by vger.kernel.org with ESMTP
	id S265098AbUFWAQQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 20:16:16 -0400
Message-ID: <40D8CBA4.8090100@am.sony.com>
Date: Tue, 22 Jun 2004 17:15:32 -0700
From: Geoff Levand <geoffrey.levand@am.sony.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.1) Gecko/20031030
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: george@mvista.com
CC: Mark Gross <mgross@linux.jf.intel.com>,
       Arjan van de Ven <arjanv@redhat.com>,
       high-res-timers-discourse@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] high-res-timers patches for 2.6.6
References: <40C7BE29.9010600@am.sony.com> <20040611062256.GB13100@devserv.devel.redhat.com> <40CA3342.9020105@mvista.com> <200406140828.08924.mgross@linux.intel.com> <40D7662A.2030006@am.sony.com> <40D76C76.7000509@mvista.com> <40D86E51.2080108@am.sony.com> <40D8BBAC.2070503@mvista.com>
In-Reply-To: <40D8BBAC.2070503@mvista.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm thinking we should drop this discussion from LKML, and start a new 
thread on the high-res-timers-discourse list.  If anyone has an 
interest, please join us there:

<https://lists.sourceforge.net/lists/listinfo/high-res-timers-discourse>

-Geoff

George Anzinger wrote:
> Geoff Levand wrote:
> 
>> George Anzinger wrote:
>>
>>> Geoff Levand wrote:
>>>
>>>> Mark Gross wrote:
>>>>
>>>>> On Friday 11 June 2004 15:33, George Anzinger wrote:
>>>>>
>>>>>> I have been thinking of a major rewrite which would leave this 
>>>>>> code alone,
>>>>>> but would introduce an additional list and, of course, overhead for
>>>>>> high-res timers. This will take some time and be sub optimal, so I 
>>>>>> wonder
>>>>>> if it is needed.
>>>>>
>>>>>
>>>>>
>>>>>
>>>>>
>>>>>
>>>>> What would your goal for the major rewrite be?
>>>>> Redesign the implementation?
>>>>> Clean up / re-factor the current design?
>>>>> Add features?
>>>>>
>>>>> I've been wondering lately if a significant restructuring of the 
>>>>> implementation could be done.  Something bottom's up that enabled 
>>>>> changing / using different time bases without rebooting and 
>>>>> coexisted nicely with HPET.
>>>>>
>>>>> Something along the lines of;
>>>>> * abstracting the time base's, calibration and computation of the 
>>>>> next interrupt time into a polymorphic interface along with the 
>>>>> implementation of a few of your time bases (ACPI, TSC) as a stand 
>>>>> allown patch.
>>>>> * implement yet another polymorphic interface for the interrupt 
>>>>> source used by the patch, along with a few interrupt sources (PIT, 
>>>>> APIC, HPET <-- new )
>>>>> * Implement a simple RTC-like charactor driver using the above for 
>>>>> testing and integration.  * Finally a patch to integrate the first 
>>>>> 3 with the POSIX timers code.
>>>>>
>>>>> What do you think?
>>>>>
>>>>>
>>>>> --mgross
>>>>>
>>>>
>>>> Mark,
>>>>
>>>> Generally I agree with your ideas on what needs fixing up, but I'm 
>>>> concerned that the run-time binding of this kind of design would 
>>>> have too much overhead for time-critical code paths.  Do you think 
>>>> it is useful to have run-time selection of the time base and 
>>>> interrupt source?   In my work we have a known fixed hardware 
>>>> configuration that has limited timers, so I don't really see a need 
>>>> for runtime configuration there.
>>>
>>>
>>>
>>>
>>> Well, I don't see much added overhead, (save memory).  We already 
>>> dispatch interrupts via indirect function calls in irq.c.  And the 
>>> core clock functions (used by gettimeofday, for example) are also 
>>> indirected today (this to allow pm-timer, TSC, or PIT at boot time).  
>>> All we would do is put both of our possibilities in the list.  The 
>>> only place we add overhead is in an indirect to the "proper" hardware 
>>> timer for the sub-jiffie interrupt.
>>>
>>
>> If that's the case, then Mark's proposal sounds like a good way to 
>> abstract the arch dependent code.  Someone mentioned to me that distro 
>> vendors would like the idea of runtime configuration because they 
>> could use a single kernel binary to support many different hardware 
>> configurations.  I suppose if needed some optimization can be done later.
>>
>> Mark, do you have time to do a first cut at the interfaces?  It seems 
>> you've been thinking about this, and I'd like to see your ideas.  It 
>> would be great if you could put together a sample hrtime.h.  If you 
>> are short on time, I could put something together, but I think you are 
>> the guy to do this.
>>
>>  From what I've been told, Renesas did an HRT port to the SH arch on a 
>> recent kernel.  I'm trying to get the code so that there will be three 
>> arch's (i386, ppc32 & sh) to work against when doing the arch 
>> independent interface.
> 
> 
> MV has ported HRT to PPC, MIPS, and, I think, a couple of ARM processors.
> 
>>
>> Another thing that seems to be a sore point is the HRT core.  I think 
>> there's a good consensus that the current use of preprocessor 
>> conditionals makes the code pretty hairy, but what alternatives are 
>> there?
>>
>> If the HRT code is always compiled in, that would simplify things 
>> alot, but then there would always be a small performance hit in the 
>> compares, and a slightly bigger code size.  Is this acceptable?  Also, 
>> something would need to be arranged to take care of the non-supported 
>> arch's.  Any ideas here?
> 
> 
> I think the best thing is to include an include/asm/hrtime.h in each 
> arch.  The file could be empty.  (I, at one time, suggested a 
> modification of the build environment such that such a file could be put 
> in the asm-generic/ directory and would be found if no such file was 
> found in the archs asm/ directory, but, alas, the powers that be DID NOT 
> LIKE THAT.)  In any case, this would allow the including file 
> (include/hrtime.h) to determine that the arch was not supported (i.e. it 
> did not define the required functions) and define dummys that would 
> satisfy the externals and also prevent the registration of the HR clocks.
> 
>>
>> Another way would be to pull out the HRT operations into separate 
>> functions that could be conditionally included or replaced with no-op 
>> versions based on a config option.  I don't know if this would be 
>> do-able, or if the result would be very clean though...
> 
> 
> As it stands "most" timer and clock functions are dispatched through the 
> k_clocks array.  We don't use different functions here at this time 
> except for the monotonic clock_settime(), but, if we wanted to duplicate 
> most of the code, this might be a way to go.  (Note, that the current 
> code has a test for existence of the function address and uses a default 
> if no such exists.  This was to avoid the indirect function call which, 
> I think, is rather expensive.)
> 
>>
>> George also mentioned an idea of a second 'timer slave list'.   Any 
>> other ideas here?
> 
> 
> I am tempted to send a message to Linus on this issue.  The problem is 
> that separating the two lists adds overhead and is just not the clean 
> way to do it. The up side is that those who don't want HRT will see less 
> impact on the normal timer code.
> 
> Oh, and by the way, I welcome all the help you can give on these 
> issues.  Thanks.


