Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261268AbSKGPmW>; Thu, 7 Nov 2002 10:42:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261301AbSKGPmW>; Thu, 7 Nov 2002 10:42:22 -0500
Received: from p11.n-lapop01.stsn.com ([12.129.240.11]:50519 "EHLO
	lapop.smtp.stsn.com") by vger.kernel.org with ESMTP
	id <S261268AbSKGPmS>; Thu, 7 Nov 2002 10:42:18 -0500
Message-ID: <3DCA99F4.4090703@mvista.com>
Date: Thu, 07 Nov 2002 10:51:00 -0600
From: Corey Minyard <cminyard@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux ppc; en-US; rv:1.1) Gecko/20020828
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Zwane Mwaikambo <zwane@holomorphy.com>
CC: Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
       John Levon <levon@movementarian.org>
Subject: Re: NMI handling rework
References: <Pine.LNX.4.44.0211070103540.27141-100000@montezuma.mastecende.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 07 Nov 2002 15:55:43.0296 (UTC) FILETIME=[20B79400:01C28676]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zwane Mwaikambo wrote:

>On Thu, 7 Nov 2002, Corey Minyard wrote:
>
>  
>
>>Ingo et al...
>>
>>Since a lot of things have started tying into the NMI handler (oprofile, 
>>nmi watchdog, memory errors, bus error, now the IPMI watchdog), I think 
>>it better to use a request/release mechanism for the NMI handlers. 
>> Plus, I think the current NMI code is actually not correct, it's 
>>theoretically possible to miss NMIs if two occur at the same time.  So 
>>    
>>
>
>How? The NMI interrupt should be internally masked till IRET. I think your 
>code is ok, but i don't see how it takes care of concurrent users such as 
>oprofile and the nmi watchdog, the nmi watchdog already programs its own 
>interrupt interval if its shared, what is the intended base NMI interval? 
>How about handlers requiring a different interrupt interval? I have code 
>which does the following;
>
NMIs cannot be masked, they are by definition non-maskable :-).  You can 
get an NMI while executing an NMI.

NMIs are edge-triggered going into the processor.  For external 
level-generating inputs, this is fine, because if two NMIs are occuring, 
you would handle the first, clear it, and there's some code that will 
turn off and back on the external NMI, if it is still asserted (by 
another input) you would get another NMI.  From what I can tell (by 
inference, not by direct documentation) at least the IO APIC version is 
pulsed, because there is no code to turn it off.  If a pulsed and 
another NMI occur at the same time, it is possible to miss one.  It may 
be that this is not important.  If so, it's easy to change it to only 
handle the first one (since the handlers are supposed to return a value 
saying if they handle the NMI or not).  I'm not sure about this, maybe 
someone who is more familiar with the hardware could comment?

>base NMI poll function with time interval T;
>master queue with slots per timeout;
>slots with task queues which are flushed whenever we hit the timeout;
>
>you can therefore add tasks in with specific time intervals which will get 
>triggered. This code currently is only running the nmi watchdog, but i'll 
>be experimenting with various other handlers. I'll post a URL soon.
>
>To support external devices which trigger NMI we can simply check wether 
>we have hit an nmi interval period, if not we run through the NMI handler 
>lists.
>
An NMI-based timer?  I can see the use if you REALLY need accurate 
intervals, but you can't do much in an NMI, no spinlocks, even.

-Corey

