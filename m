Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265353AbUAZWf4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jan 2004 17:35:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265580AbUAZWf4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jan 2004 17:35:56 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:48883 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S265353AbUAZWfx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jan 2004 17:35:53 -0500
Message-ID: <40159623.1050003@mvista.com>
Date: Mon, 26 Jan 2004 14:35:15 -0800
From: George Anzinger <george@mvista.com>
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021202
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Tom Rini <trini@kernel.crashing.org>
CC: "Amit S. Kale" <amitkale@emsyssoft.com>,
       Powerpc Linux <linuxppc-dev@lists.linuxppc.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       KGDB bugreports <kgdb-bugreport@lists.sourceforge.net>
Subject: Re: PPC KGDB changes and some help?
References: <200401212223.13347.amitkale@emsyssoft.com> <20040121184217.GU13454@stop.crashing.org> <20040121192128.GV13454@stop.crashing.org> <20040121192230.GW13454@stop.crashing.org> <20040122174416.GJ15271@stop.crashing.org> <20040122180555.GK15271@stop.crashing.org> <20040123224605.GC15271@stop.crashing.org> <4011B07F.5060409@mvista.com> <20040126204631.GB32525@stop.crashing.org> <40158647.70701@mvista.com> <20040126214246.GD32525@stop.crashing.org>
In-Reply-To: <20040126214246.GD32525@stop.crashing.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tom Rini wrote:
>>>>>+
>>>>>/*
>>>>>* Routines
>>>>>*/
>>>>>static void
>>>>>kgdb_debugger(struct pt_regs *regs)
>>>>>{
>>>>>-	(*linux_debug_hook) (0, 0, 0, regs);
>>>>>+	(*linux_debug_hook) (0, computeSignal(regs->trap), 0, regs);
>>>>>	return;
>>>>>}
>>>>>
>>>>>@@ -52,14 +109,14 @@
>>>>>int
>>>>>kgdb_iabr_match(struct pt_regs *regs)
>>>>>{
>>>>>-	(*linux_debug_hook) (0, 0, 0, regs);
>>>>>+	(*linux_debug_hook) (0, computeSignal(regs->trap), 0, regs);
>>>>>	return 1;
>>>>>}
>>>>>
>>>>>int
>>>>>kgdb_dabr_match(struct pt_regs *regs)
>>>>>{
>>>>>-	(*linux_debug_hook) (0, 0, 0, regs);
>>>>>+	(*linux_debug_hook) (0, computeSignal(regs->trap), 0, regs);
>>>>>	return 1;
>>>>>}
>>>>>
>>>>>
>>>>>Now, not being as well versed in all of the debugging infos that can be
>>>>>passed around, it sounds like this patch could be dropped in the future
>>>>>for a cleaner method using some of the dwarf2 bits being talked about.
>>>>>But I don't know, and clarification and pointers (if so) to how to do
>>>>>this would be appreciated.
>>>>
>>>>I am not sure what this buys you.  I don't think dwarf2 will help here.
>>>
>>>
>>>OK.
>>>
>>>
>>>
>>>>There is a real danger of passing signal info back to gdb as it will want 
>>>>to try to deliver the signal which is a non-compute in most kgdbs in the 
>>>>field.  I did put code in the mm-kgdb to do just this, but usually the 
>>>>arrival of such a signal (other than SIGTRAP) is the end of the kernel.  
>>>>All that is left is to read the tea leaves.
>>>
>>>
>>>The gdb I've been testing this with knows better than to try and send a
>>>singal back, so that's not a worry.  The motivation behind doing this
>>>however is along the lines of "if it ain't broke, don't remove it".  The
>>>original stub was getting all of this information correctly, so why stop
>>>doing it?
>>>
>>
>>OK, but I still don't like losing the return address.  Tell me again, why 
>>do you need three different functions all doing the same thing?
> 
> 
> You get:
> - kgdb_breakpoint => debugger_bpt : This is how the various PPC codes
>   drop you into KGDB.
> - kgdb_iabr_match => debugger_iabr_match : Called from
>   InstructionBreakpoint, exception.
> - kgdb_dabr_match => debugger_dabr_match : Called from do_page_fault,
>   this is a Data Access Breakpoint Register match.
> 
> So we need at least 2 for the KGDB side of things (prototypes) and 3
> just to make it clear.

But they all end up at the exact same place with the same set of parameters. 
The only difference I can see is that some return 1 while the other is void.  It 
seems to me that you could send them all to one of the ones that returns 1. 
Once that is done, then you could just send them all to where ever 
linux_debug_hook points and have it do the signal resolution and return the 1. 
That way that code could look at its return address and see something useful.
> 

-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml

