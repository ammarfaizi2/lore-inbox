Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261340AbUCHW0Y (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Mar 2004 17:26:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261347AbUCHW0Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Mar 2004 17:26:24 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:17653 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S261340AbUCHW0U
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Mar 2004 17:26:20 -0500
Message-ID: <404CF305.3080101@mvista.com>
Date: Mon, 08 Mar 2004 14:26:13 -0800
From: George Anzinger <george@mvista.com>
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Tom Rini <trini@kernel.crashing.org>
CC: "Amit S. Kale" <amitkale@emsyssoft.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, pavel@ucw.cz
Subject: Re: kgdb for mainline kernel: core-lite [patch 1/3]
References: <200403081504.30840.amitkale@emsyssoft.com> <20040308030722.01948c93.akpm@osdl.org> <200403081650.18641.amitkale@emsyssoft.com> <200403081714.05521.amitkale@emsyssoft.com> <20040308151912.GD15065@smtp.west.cox.net>
In-Reply-To: <20040308151912.GD15065@smtp.west.cox.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tom Rini wrote:
> On Mon, Mar 08, 2004 at 05:14:05PM +0530, Amit S. Kale wrote:
> 
>>On Monday 08 Mar 2004 4:50 pm, Amit S. Kale wrote:
>>
>>>On Monday 08 Mar 2004 4:37 pm, Andrew Morton wrote:
>>>
>>>>"Amit S. Kale" <amitkale@emsyssoft.com> wrote:
>>>>
>>>>>On Monday 08 Mar 2004 3:56 pm, Andrew Morton wrote:
>>>>> > "Amit S. Kale" <amitkale@emsyssoft.com> wrote:
>>>>> > > Here are features that are present only in full kgdb:
>>>>> > >  1. Thread support  (aka info threads)
>>>>> >
>>>>> > argh, disaster.  I discussed this with Tom a week or so ago when it
>>>>> > looked like this it was being chopped out and I recall being told
>>>>> > that the discussion was referring to something else.
>>>>> >
>>>>> > Ho-hum, sorry.  Can we please put this back in?
>>>>>
>>>>> Err., well this is one of the particularly dirty parts of kgdb. That's
>>>>>why it's been kept away. It takes care of correct thread backtraces in
>>>>>some rare cases.
>>>>
>>>>Let me just make sure we're taking about the same thing here.  Are you
>>>>saying that with kgdb-lite, `info threads' is completely missing, or does
>>>>it just not work correctly with threads (as opposed to heavyweight
>>>>processes)?
>>>
>>>info threads shows a list of threads. Heavy/light weight processes doesn't
>>>matter. Thread frame shown is incorrect.
>>>
>>>I looked at i386 dependent code again. Following code in it is incorrect. I
>>>never noticed it because this code is rarely used in full version of kgdb:
>>>
>>>+void sleeping_thread_to_gdb_regs(unsigned long *gdb_regs, struct
>>>task_struct *p)
>>>....
>>>+	gdb_regs[_EBP] = *(int *)p->thread.esp;
>>>
>>>We can't guss ebp this way. This line should be removed.
>>>
>>>+	gdb_regs[_DS] = __KERNEL_DS;
>>>+	gdb_regs[_ES] = __KERNEL_DS;
>>>+	gdb_regs[_PS] = 0;
>>>+	gdb_regs[_CS] = __KERNEL_CS;
>>>+	gdb_regs[_PC] = p->thread.eip;
>>>+	gdb_regs[_ESP] = p->thread.esp;
>>>
>>>This should be gdb_regs[_ESP] = &p->thread.esp
>>
>>That's not correct it. It should be gdb_regs[_ESP] = p->thread.esp;
>>Even with these changes I can't get thread listing correctly.
>>
>>Here is the intrusive piece of code that helps get thread state correctly. Any 
>>ideas on cleaning it?
> 
> 
> Here's where what Andi said about being able to get the pt_regs stuff
> off the stack (I think that's what he said at least) started to confuse
> me slightly.  But if I understand it right (and I never got around to
> testing this) we can replace the do_schedule() stuffs at least with
> something like kgdb_get_pt_regs(), since (and I lost my notes on this,
> so it's probably not quite right) (thread_info->esp0)-1

I don't see any problem here.  All I do is to detect that the thread is not 
current on ANY cpu and send up the regs that switch to saved in the task struct. 
  GDB can then figure out the rest from the dwarft2 frames.  At this time it 
helps to have the compile option to do frames turned on.  This is so that gdb 
will use the frame register to back out of switch to.  It all works well in my kgdb.
> 

-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml

