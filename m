Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261214AbUCDAaJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Mar 2004 19:30:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261244AbUCDAaJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Mar 2004 19:30:09 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:5364 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S261214AbUCDA2U
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Mar 2004 19:28:20 -0500
Message-ID: <4046780D.7020700@mvista.com>
Date: Wed, 03 Mar 2004 16:27:57 -0800
From: George Anzinger <george@mvista.com>
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Tom Rini <trini@kernel.crashing.org>
CC: "Amit S. Kale" <amitkale@emsyssoft.com>, Pavel Machek <pavel@ucw.cz>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       kgdb-bugreport@lists.sourceforge.net
Subject: Re: [Kgdb-bugreport] [PATCH] Kill kgdb_serial
References: <20040302213901.GF20227@smtp.west.cox.net> <20040302230018.GL20227@smtp.west.cox.net> <40451CCA.4070907@mvista.com> <200403031113.02822.amitkale@emsyssoft.com> <20040303151628.GQ20227@smtp.west.cox.net>
In-Reply-To: <20040303151628.GQ20227@smtp.west.cox.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tom Rini wrote:
> On Wed, Mar 03, 2004 at 11:13:02AM +0530, Amit S. Kale wrote:
> 
> 
>>On Wednesday 03 Mar 2004 5:16 am, George Anzinger wrote:
>>
>>>Tom Rini wrote:
>>>
>>>>On Tue, Mar 02, 2004 at 11:31:43PM +0100, Pavel Machek wrote:
>>>>
>>>>>Hi!
>>>>>
>>>>>
>>>>>>>Tom Rini wrote:
>>>>>>>
>>>>>>>>Hello.  The following interdiff kills kgdb_serial in favor of function
>>>>>>>>names.  This only adds a weak function for kgdb_flush_io, and
>>>>>>>>documents when it would need to be provided.
>>>>>>>
>>>>>>>It looks like you are also dumping any notion of building a kernel that
>>>>>>>can choose which method of communication to use for kgdb at run time. 
>>>>>>>Is this so?
>>>>>>
>>>>>>Yes, as this is how Andrew suggested we do it.  It becomes quite ugly if
>>>>>>you try and allow for any 2 of 3 methods.
>>>>>
>>>>>I do not think that having kgdb_serial is so ugly. Are there any other
>>>>>uglyness associated with that?
>>>>
>>>>More precisely:
>>>>http://lkml.org/lkml/2004/2/11/224
>>>
>>>Andrew seems to be comming from the point of view of a developer rather
>>>than a developer/ maintainer.
>>>
>>>So, the counter argument is the user who is sending the thing into the
>>>field and wants to send just one binary kernel to all locations.  But then
>>>he needs to debug some problem that will work fine over the lan and later
>>>one that requires an early connection which the lan can not, as yet, do.  I
>>>agree that for you or me, this is not an issue, but what of the IT folks...
>>
>>This is the same reason specifying 8250 parameters on a kernel command line is 
>>good. If one builds a different kernel for each test machine, fixing kgdb 
>>interface parameters during a build doesn't cause any problems. I don't think 
>>compiling different kernels is good when you have more than 2 machines (of 
>>same architecture). It's much easier to build a single kernel with drivers 
>>required by all of them and then boot them with kgdb as and when required 
>>with interface parameters coming from grug.conf (or equivalent on other 
>>archs).
> 
> 
> But that's not what you get with kgdb_serial.  You get the possibility
> of serial from point A to B and you will have eth from point B onward,
> if compiled in.  With an arch serial driver you get the possibility of
> serial (or arch serial or whatever) from point A to B and eth from point
> B onward, if compiled in.

I don't think we want to switch.  Rather we want to say something like: If no 
eth (or other input) options are on the command line then its is serial.  If eth 
(or other input) is there, that is what we use.

This does leave open what happens when "eth" is given and we hit a breakpoint 
prior to looking at the command line, but now this just fails so we would be 
hard put to do worse.
> 
> 
>>kgdb_serial isn't ugly. It's just a function switch, similar to several of 
>>them in the kernel. ppc is ugly, but that's anyway the case because of so 
>>many varieties of ppc. If we are trying to make ppc code clean, it makes more 
>>sense to move this weak function thing into ppc specific files IMHO.
> 
> 
> I think you missed the point.  The problem isn't with providing weak
> functions, the problem is trying to set the function pointer.  PPC
> becomes quite clean since the next step is to kill off
> PPC_SIMPLE_SERIAL and just have kgdb_read/write_debug_char in the
> relevant serial drivers.

No, you just set the default at configure time.  It is just done in such away as 
to allow it to be overridden.


> 

-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml

