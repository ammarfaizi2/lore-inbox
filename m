Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266455AbUAVWgW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jan 2004 17:36:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266458AbUAVWgW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jan 2004 17:36:22 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:34551 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S266455AbUAVWgT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jan 2004 17:36:19 -0500
Message-ID: <40105047.8020207@mvista.com>
Date: Thu, 22 Jan 2004 14:35:51 -0800
From: George Anzinger <george@mvista.com>
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021202
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Amit S. Kale" <amitkale@emsyssoft.com>
CC: Tom Rini <trini@kernel.crashing.org>,
       Hollis Blanchard <hollisb@us.ibm.com>,
       KGDB bugreports <kgdb-bugreport@lists.sourceforge.net>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Powerpc Linux <linuxppc-dev@lists.linuxppc.org>
Subject: Re: PPC KGDB changes and some help?
References: <20040120172708.GN13454@stop.crashing.org> <30216351-4CEF-11D8-A2A1-000A95A0560C@us.ibm.com> <20040122154529.GE15271@stop.crashing.org> <200401222136.10887.amitkale@emsyssoft.com>
In-Reply-To: <200401222136.10887.amitkale@emsyssoft.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Amit S. Kale wrote:
> On Thursday 22 Jan 2004 9:15 pm, Tom Rini wrote:
> 
>>On Thu, Jan 22, 2004 at 09:25:19AM -0600, Hollis Blanchard wrote:
>>
>>>On Jan 22, 2004, at 9:07 AM, Tom Rini wrote:
>>>
>>>>On Wed, Jan 21, 2004 at 03:12:25PM -0800, George Anzinger wrote:
>>>>
>>>>>A question I have been meaning to ask:  Why is the arch/common
>>>>>connection
>>>>>via a structure of addresses instead of just calls?  I seems to me
>>>>>that
>>>>>just calling is a far cleaner way to do things here.  All the struct
>>>>>seems
>>>>>to offer is a way to change the backend on the fly.  I don't thing we
>>>>>ever
>>>>>want to do that.  Am I missing something?
>>>>
>>>>I imagine it's a style thing.  I don't have a preference either way.
>>>
>>>I think we in PPC land have gotten used to that "style" because we have
>>>one kernel that supports different "platforms", i.e. it selects the
>>>appropriate code at runtime as George says. In general that's a little
>>>bit slower and a little bit bigger.
>>>
>>>Unless you need to choose among PPC KGDB functions at runtime, which I
>>>don't think you do, you don't need it...
>>
>>That's certainly true, so if (and if I understand Georges question
>>right) Amit wants to change kgdb_arch into a set of required functions,
>>with stubs in, say, kernel/kgdbdummy.c, (and just keep the flags / etc
>>in the struct), that's fine with me.
> 
> 
> The penalty of keeping them consolidated in a structure isn't so high. I 
> prefer to keep them that way. I'll work on reducing number of initialization 
> functions, though.
> 
> I have to do something about early connect though. Powerpc kgdb on 8260 is 
> definitely capable of starting debugging right at architecture setup time. 
> It's just that kgdbstub.c isn't ready yet.
> 
> How about changing the code in kgdbstub to allow kgdb to be configured in one 
> of the following ways:
> Late kgdb - kgdb comes up after smp_init in the kernel boot sequence. kgdb8250 
> can be used with more flexibility through kernel command line options. One 
> can boot a kgdb kernel without activating kgdb. Works with the interface 
> chosen by kernel command line (kgdb8250 and kgdbeth for the moment).

If we get to kgdb via a command line, we should be able to have all the command 
line options.  I do recommend that we choose where we put the code, however. 
Some command line options are looked at FAR later in the boot.  The order of the 
command line option dispatch is the same as the link order.  This is why mm kgdb 
has the command line stuff in include/asm/bugs.h  (actually this file is only 
included by one .c file).  This, by the way, is way before the console starts 
spewing boot stuff (or is available) so no messages here.  Usually one would 
only do this by hand so it is real clear what is happening.

Any thing earlier than this should, IMHO, only happen if the user hard codes a 
breakpoint() (which by the way, is not the same as BREAKPOINT, which is an 
instruction, while breakpoint() is a function).  In the x86 kernel with the mm 
kgdb all that this function needs to do is to set up the trap vector for single 
steps and breakpoint instructions.  I think I also set up one or two others just 
to be safe.  This code can be redone, so no test is made to see if it has 
already been done.

I reading some of the comments here, I get the impression that some kgdbs try to 
connect when nothing is wrong and no command line request has been made to do 
so.  I think this should not be done.
> 
> Command line flexibilty is of great help if you have to test on 2-3 servers (I 
> used to do that a lot at Veritas). The same kernel can be compiled with 
> drivers needed by all of them plus kgdb. Command line options choose port no 
> and speeds depending on machine hardware connections. I guess it's of little 
> use on embedded systems where usually a new kernel has to be compiled for 
> each board.
> 
> Early kgdb - kgdb comes up right at the begining of start_kernel at the cost 
> of flexibility. It doesn't show any messages such as "waiting for gdb". All 
> configurations have to be compiled in through menuconfig. Once a kernel is 
> built, it'll always run with kgdb and with 8250 at a fixed port and speed.

But this would only be used if the user hard coded a break point.  It is useful, 
but early command line is, most of the time, good enough.  I guess the concern I 
have here is that you are saying either or and I want both from the same 
configuration.
> 
> i386 architecture will support both kgdb configuration.
> KGDB in powerpc 8260 will be of early kgdb type. Other powerpc arches (550 etc 
> will depend on whether the interface can be initialized early or later)

I would hope that there will always be something we can use.  Most cards have 
serial ports...


-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml

