Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263370AbUANXUn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jan 2004 18:20:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266352AbUANXSB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jan 2004 18:18:01 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:52718 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S266336AbUANXQl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jan 2004 18:16:41 -0500
Message-ID: <4005A827.80704@mvista.com>
Date: Wed, 14 Jan 2004 12:35:51 -0800
From: George Anzinger <george@mvista.com>
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021202
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Amit S. Kale" <amitkale@emsyssoft.com>
CC: Matt Mackall <mpm@selenic.com>, Pavel Machek <pavel@ucw.cz>,
       kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@zip.com.au>
Subject: Re: kgdb cleanups
References: <20040109183826.GA795@elf.ucw.cz> <20040112064923.GX18208@waste.org> <40045AC7.2070300@mvista.com> <200401141834.51536.amitkale@emsyssoft.com>
In-Reply-To: <200401141834.51536.amitkale@emsyssoft.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Amit S. Kale wrote:
> On Wednesday 14 Jan 2004 2:23 am, George Anzinger wrote:
> 
>>
>>>>An alternate possibility is an array of pointer to struct kgdb_hook
>>>>which allows one to define the struct contents as below and to build the
>>>>array, all at compile/link time.  A legal entry MUST define get and put,
>>>>but why not define them all, using dummy functions for the ones that
>>>>make no sense in a particular interface.
>>>
>>>Throwing all the stubs in a special section could work well too. Then
>>>we could add an avail() function so that early boot debugging could
>>>discover if each one was available. The serial code could use this to
>>>kickstart itself while the eth code could test a local initialized
>>>flag and say "not a chance". Which gives us all the architecture to
>>>throw in other trivial interfaces (parallel, bus-snoopers, etc.).
>>
>>I am thinking of something more like what was done with the x86 timer code.
>>Each timer option sets up a structure with an array of pointers to each
>>option. There it is done at compile time, and the runtime code tries each. 
>>There it is done in order, but here we want to do it a bit differently.
>>
>>Maybe we could have an "available" flag or just assume that the address
>>being !=0 for getdebugchar means it is "available".  I think there should
>>be a prefered intface set at config time.  Possibly over ride this with the
>>command line.  Then have a back up order in case kgdb wants to communicate
>>prior to the prefered one being available.
>>
>>We would also have a rule that the command line over ride only works if
>>communication has not yet been established.  Here, we would also like
>>control from gdb/kgdb so we could switch to a different interface, but
>>under gdb control at this point.  Either a maintaince command or setting
>>the "channel" with a memory modify command.  We would want this to take
>>effect only after the current command is acknowledged.
> 
> 
> I have something similar in my patches.
> Each interface has kgdb_hook function, which returns failure if an interface 
> isn't ready.

Keep in mind that an interface may be ready to communicate and still not able to 
handle the ^C break.  The reason is that the ^C requires interrupt support which 
is not available until rather late in the bring up.  In particular, trying to 
register an interrupt routine prior to the memory subsystem being able to do an 
alloc causes failure to register the interrupt function, which does cause and 
error return from request_irq().  The version in the common.patch seems to keep 
this information but does nothing with it.  I think it would be better to try 
again later and to keep trying until the request is successful.  See for 
example, the kgdb patch in Andrew's mm breakout.



-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml

