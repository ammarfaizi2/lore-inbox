Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261794AbUCKWt3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Mar 2004 17:49:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261804AbUCKWt3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Mar 2004 17:49:29 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:60924 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S261794AbUCKWtZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Mar 2004 17:49:25 -0500
Message-ID: <4050ECEC.8050301@mvista.com>
Date: Thu, 11 Mar 2004 14:49:16 -0800
From: George Anzinger <george@mvista.com>
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Tom Rini <trini@kernel.crashing.org>
CC: "Amit S. Kale" <amitkale@emsyssoft.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Pavel Machek <pavel@suse.cz>, kgdb-bugreport@lists.sourceforge.net
Subject: Re: [KGDB PATCH][7/7] Move debugger_entry()
References: <20040227212301.GC1052@smtp.west.cox.net> <200403011538.44953.amitkale@emsyssoft.com> <40453023.6000004@mvista.com> <200403031115.44125.amitkale@emsyssoft.com> <4050D92B.7000802@mvista.com> <20040311222749.GK5169@smtp.west.cox.net>
In-Reply-To: <20040311222749.GK5169@smtp.west.cox.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tom Rini wrote:
> On Thu, Mar 11, 2004 at 01:24:59PM -0800, George Anzinger wrote:
> 
>>Amit S. Kale wrote:
>>
>>>On Wednesday 03 Mar 2004 6:38 am, George Anzinger wrote:
>>>
>>>
>>>>Amit S. Kale wrote:
>>>>
>>>>
>>>>>OK to checkin.
>>>>>
>>>>>-Amit
>>>>>
>>>>>On Saturday 28 Feb 2004 3:24 am, Tom Rini wrote:
>>>>>
>>>>>
>>>>>>Hello.  When we use kgdboe, we can't use it until do_basic_setup() is
>>>>>>done. So we have two options, not allow kgdboe to use the initial
>>>>>>breakpoint or move debugger_entry() to be past the point where kgdboe
>>>>>>will be usable. I've opted for the latter, as if an earlier breakpoint
>>>>>>is needed you can still use serial and throw
>>>>>>kgdb_schedule_breakpoint/breakpoint where desired.
>>>>>>
>>>>>>--- linux-2.6.3-rc4/init/main.c	2004-02-17 09:51:19.000000000 -0700
>>>>>>+++ linux-2.6.3-rc4-kgdb/init/main.c	2004-02-17 
>>>>>>11:33:51.854388988 -0700
>>>>>>@@ -581,6 +582,7 @@ static int init(void * unused)
>>>>>>
>>>>>>	smp_init();
>>>>>>	do_basic_setup();
>>>>>>+	debugger_entry();
>>>>
>>>>It would be nice to not need this.  Could it be a side effect of
>>>>configuring the interface or some such so we don't have to patch
>>>>init/main.c
>>>
>>>
>>>I attempted doing this when I was trying to code a netpoll independent 
>>>ethernet interface. I couldn't do without it. I needed one hook to kgdb in 
>>>init to mark completion of smp_init. If an interface was ready, that hook 
>>>called breakpoint. A similar hook was placed in interface initialization 
>>>code, it called breakpoint, if kgdb core was ready on account of smp_init 
>>>completion.
>>>
>>
>>I guess the real question is why do you need to wait so long?  What is it 
>>that needs to be done prior to this call?
> 
> 
> For kgdboe, you need to wait for the ethernet driver, networking, etc.
> Without going and trying to do some big special case, that's when it has
> to be, for kgdboe.
> 
> For serial, esp if you make kgdb_arch_init() handle kgdb_serial pointer,
> it can happen much earlier.  In fact, in that case you could probably
> throw breakpoint() in as first line of C (PPC32) or close to it (some
> mappings needed i386, sh, others, generally speaking).

So the question is do we cater to the worst or the best?  If I put kgdb or what 
ever on the command line, I would like to see the connection ASAP what ever the 
connection is.  So possibly, the command line parse part of kgdb sets a flag it 
it can not do the break NOW.  The late bloomer code finds this flag when doing 
the kgdboe or what ever set up and enters at that time.  Puts a little more 
smarts in the command line part, but gets things rolling ASAP regardless of the 
interface.  This, of course, assumes that the kgdboe or what ever has an 
independent way of getting entered as soon as it can be set up, i.e. its 
prerequisites are satisfied.
> 

-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml

