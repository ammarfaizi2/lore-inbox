Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964938AbWFAKuj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964938AbWFAKuj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 06:50:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965022AbWFAKuj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 06:50:39 -0400
Received: from mailgw3.ericsson.se ([193.180.251.60]:32952 "EHLO
	mailgw3.ericsson.se") by vger.kernel.org with ESMTP id S964938AbWFAKui
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 06:50:38 -0400
Message-ID: <447EC677.2090001@ericsson.com>
Date: Thu, 01 Jun 2006 12:50:31 +0200
From: Preben Traerup <Preben.Trarup@ericsson.com>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: fastboot@lists.osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [Fastboot] [RFC][PATCH] Add missing notifier before crashing
References: <20060530183359.a8d5d736.akiyama.nobuyuk@jp.fujitsu.com>	<20060530145658.GC6536@in.ibm.com>	<20060531182045.9db2fac9.akiyama.nobuyuk@jp.fujitsu.com> <20060531154322.GA8475@in.ibm.com>
In-Reply-To: <20060531154322.GA8475@in.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 01 Jun 2006 10:50:32.0180 (UTC) FILETIME=[34478340:01C68569]
X-Brightmail-Tracker: AAAAAA==
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vivek Goyal wrote:

>On Wed, May 31, 2006 at 06:20:45PM +0900, Akiyama, Nobuyuki wrote:
>  
>
>>Hello Vivek-san,
>>
>>On Tue, 30 May 2006 10:56:58 -0400
>>Vivek Goyal <vgoyal@in.ibm.com> wrote:
>>
>>    
>>
>>>On Tue, May 30, 2006 at 06:33:59PM +0900, Akiyama, Nobuyuki wrote:
>>>      
>>>
>>>>Hello,
>>>>
>>>>The panic notifier(i.e. panic_notifier_list) does not be called
>>>>if kdump is activated because crash_kexec() does not return.
>>>>And there is nothing to notify of crash before crashing by SysRq-c.
>>>>
>>>>Although notify_die() exists, the function depends on architecture.
>>>>If notify_die() is added in panic and SysRq respectively like existing
>>>>implementation, the code will be ugly.
>>>>I think that adding a generic hook in crash_kexec() is better to simplify
>>>>the code. The panic_notifier_list-user will have nothing to do.
>>>>If you want to catch SysRq, use the crash_notifier_list.
>>>>
>>>>        
>>>>
>>>What's the use of introducing crash_notifier_list? Who is going to use
>>>it for what purpose?
>>>
>>>Probably we don't want to create any such infrastructure because carries
>>>the risk of hanging in between and reducing the reliability of dump 
>>>operation.
>>>      
>>>
>>I really understand what you concern about.
>>But a certain program indeed needs some processing before
>>crashing even if panic occurs.
>>Now standard kernel includes some panic_notifier_list-user,
>>these are the familiar examples.
>>    
>>
>
>I see the panic_notifier_list but I am afraid that we can not afford
>to send the crash/panic notifications if system admin has chosen to load
>the kdump kernel and has decided to take a dump in case of a crash event.
>This might very seriously compromise the reliability of kdump. IIRC, we
>recently saw an issue with powerpc where we did not even start booting into
>the second kernel as system lost way somewhere while handling notifiers.
>
>So far on a panic event kernel only used to display the panic string
>and halt the system but now it tries to do much more. That is boot
>into the second kernel and caputure the dump. Of course, one can argue
>that I want to implement a different policy in case of system crash. In
>that case probably we should not load the kdump kernel at all.
>
>panic_notifier_list helps in this regard that multiple subsystem can
>register their own policy and policy will be excuted in the registered
>priority order. Given the nature of kdump, I feel it is kind of 
>mutually exclusive and can not co-exist with other policies. Otherwise, we 
>will end up calling all other policies first and trigger booting into
>the second kernel last. This is equivalent to giving higher priority to
>all other policies and least priority to kdump.
>
>  
>
>>As other example, a cluster support software needs to clean up
>>current environment and to take over immediately.  > To do so, the cluster software immediately and surely want to
>>know the current node dies.
>>Some mission critical systems demand to start taking over
>>within a few milli-second after the system dies.
>>
>>    
>>
>
>I am no failover expert, but a quick thought suggests me that doing
>anything after the panic is not reliable. So should't all failover
>mechanisms depend on auto detecting that failure has occurred instead
>of failing system informing that I am about to fail so you better take
>over. Something like syncying two systems with a hearbeat message kind
>of thing and if main node fails, it will stop generating hearbeat
>messages and spare node will take over.
>  
>
In the type of systems we build, we very much would like both 
kexec/kdump to be reliable and
a method for early panic notification to external systems.

We need kernel dumping i.e. for verification of a Telco server indeed 
crashed only because some HW malfunction
was detected.  As these situations occur very seldomly as much reliable 
information is very much appriciated.

On the other hand, for Telco servers running under full load, we simply 
can't afford waisting any time in waiting
for others servers to take over.
Informing other servers about them taking over has the single highest 
priority for servers running in production!
-Doing notification directly in the panic function would only cost a few 
CPU cycles.
-Setting up some external watchdog functionality would most likely cost 
1 millisecond. (factor 1.000.000)
-Doing notification in dump kernel would take seconds. (factor 
1.000.000.000)

Too me it seems the issue can be boiled down to these two issues:

issue 1:
We need early panic notification in the kernel.
 From the kernel dumping people could you please give some information 
about what could kind of
functionality could be acceptable in an early panic notification function.
The most simple solution is simply to hardcode outb() directly in the 
panic function in panic.c.
A more flexible solution would be to allow something like this

if (function pointer)
  call function pointer

and the called function could do outb on what ever suits the system.

Using a function pointer allows each vendor to execute whatever is 
needed in their environment and avoids every vendor to
alter the panic function to suit their purpose ?

issue 2:
Just something nice to have:
I do actually not know if this is an issue, as I am not working with 
reading the kernel dumps,
that is if the information is already available in the dump.

The panic function is called with a buffer as argument. Could this 
buffer somehow be  transferred
to the dumping kernel i.e. for storage in special loggin systems..

./Preben












