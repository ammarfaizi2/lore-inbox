Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261811AbUCCAXK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Mar 2004 19:23:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262282AbUCCAXJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Mar 2004 19:23:09 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:22770 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S261811AbUCCAXA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Mar 2004 19:23:00 -0500
Message-ID: <4045254E.5010505@mvista.com>
Date: Tue, 02 Mar 2004 16:22:38 -0800
From: George Anzinger <george@mvista.com>
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Tom Rini <trini@kernel.crashing.org>
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       kgdb-bugreport@lists.sourceforge.net, amit@av.mvista.com,
       Pavel Machek <pavel@suse.cz>
Subject: Re: [Kgdb-bugreport] [KGDB][RFC] Send a fuller T packet
References: <20040302220233.GG20227@smtp.west.cox.net> <404518AD.40606@mvista.com> <20040302233635.GM20227@smtp.west.cox.net>
In-Reply-To: <20040302233635.GM20227@smtp.west.cox.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tom Rini wrote:
> On Tue, Mar 02, 2004 at 03:28:45PM -0800, George Anzinger wrote:
> 
> 
>>Tom Rini wrote:
>>
>>>Hello.  Since a 'T' packet is allowed to send back information on an
>>>arbitrary number of registers, and on PPC32 we've always been including
>>>information on the stack pointer and program counter, I was wondering
>>>what people thought of the following patch:
>>>
>>>diff -u linux-2.6.3/include/asm-x86_64/kgdb.h 
>>>linux-2.6.3/include/asm-x86_64/kgdb.h
>>>--- linux-2.6.3/include/asm-x86_64/kgdb.h	2004-02-27 
>>>11:30:37.445782703 -0700
>>>+++ linux-2.6.3/include/asm-x86_64/kgdb.h	2004-03-02 
>>>14:42:47.854532793 -0700
>>>@@ -48,6 +48,10 @@
>>>/* Number of bytes of registers.  */
>>>#define NUMREGBYTES (_LASTREG*8)
>>>
>>>+#define PC_REGNUM	_PC	/* Program Counter */
>>>+#define SP_REGNUM	_RSP	/* Stack Pointer */
>>>+#define PTRACE_PC	rip	/* Program Counter, in ptrace regs. */
>>
>>I would really like to keep this stuff out of kgdb.h since it may be 
>>included by the user to pick up the BREAKPOINT() (which, by the way we 
>>should standardize as I note that here it has () while not on the current 
>>x86).
> 
> 
> It's BREAKPOINT() everywhere:
Yeah, something you changed?  Oh well, I will just have to learn to put the "()" 
in :)
> $ grep BREAKPOINT include/asm-*/kgdb.h
> include/asm-i386/kgdb.h:#define BREAKPOINT() asm("   int $3");
> include/asm-ppc/kgdb.h:#define BREAKPOINT()             asm(".long 0x7d821008") /* twge r2, r2 */
> include/asm-x86_64/kgdb.h:#define BREAKPOINT() asm("   int $3");
> 
> 
>>Isn't there a kgdb_local.h which is used only by kdgd and friends?  We 
>>really do want to keep the name space as clean as possible to prevent 
>>possible conflicts.
> 
> 
> The simple answer is you don't call BREAKPOINT() in your code anywhere.
> You call breakpoint() or kgdb_schedule_breakpoint().

Uh, why?  Last I knew that was a real function.  Most of the time I just want a 
simple breakpoint.  I surly don't want the register dumps and such that a 
function call causes, not to mention that it may do something else that is not 
friendly.


> The split here is different in that <linux/kgdb.h> should be standalone
> (it's not, _yet_).

Yeah, but it will most likely include asm/kgdb.h....
> 
> But this is all an aside to my question. :)

Right, my answer on that is if it reduces the line traffic yes, if not, no. 
Because then it is just bloat.
> 

-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml

