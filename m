Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266138AbUAUXBV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jan 2004 18:01:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266140AbUAUXBV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jan 2004 18:01:21 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:51184 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S266138AbUAUXBM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jan 2004 18:01:12 -0500
Message-ID: <400F0490.6000209@mvista.com>
Date: Wed, 21 Jan 2004 15:00:32 -0800
From: George Anzinger <george@mvista.com>
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021202
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Amit S. Kale" <amitkale@emsyssoft.com>
CC: Pavel Machek <pavel@suse.cz>, Linux Kernel <linux-kernel@vger.kernel.org>,
       KGDB bugreports <kgdb-bugreport@lists.sourceforge.net>,
       Matt Mackall <mpm@selenic.com>, discuss@x86-64.org
Subject: Re: KGDB 2.0.3 with fixes and development in ethernet interface
References: <200401161759.59098.amitkale@emsyssoft.com> <200401171459.01794.amitkale@emsyssoft.com> <40099301.6000202@mvista.com> <200401211916.49520.amitkale@emsyssoft.com>
In-Reply-To: <200401211916.49520.amitkale@emsyssoft.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Amit S. Kale wrote:
> On Sunday 18 Jan 2004 1:24 am, George Anzinger wrote:
> 
>>Amit S. Kale wrote:
>>
>>>On Saturday 17 Jan 2004 6:53 am, George Anzinger wrote:
>>>
:

>>>>>This seems to be needed (if I unselect CONFIG_KGDB_THREAD, I get
>>>>>compile error on x86-64).
>>>>
>>>>Amit, could you explain why this is an option?  It seems very useful and
>>>>not really too much code...
>>>
>>>It saves all registers before switch_to. It does that two times at
>>>present. Once (implicit) register save by gcc and an explicit register
>>>save in arch/<proc>/kernel/entry.S Second register save in kern_schedule
>>>generates a pt_regs structure which gdb can get all registers at once
>>>from. If it's omited, gdb has to figure out where gcc has saved registers
>>>from the non-standards code in switch_to, which it can't do correctly all
>>>the time.
>>>
>>>We can have a check for (a new variable) debugger_enabled before calling
>>>kern_schedule. That'll be add negligible overhead and will allow extra
>>>thread info to be saved only when a debugger is enabled. There will not
>>>be any need for CONFIG_KGDB_THREAD also.
>>
>>I don't seem to have such a problem with the mm kgdb.  No kern_schedule
>>there...
> 
> 
> 
> Have you confirmed that you see correct values for all the registers? I had 
> found some problems with gdb not being able to locate all the registers 
> correctly. Explanation on the problem below:
> 
> Besides getting gdb's fault there  is one more benefit of kern_schedule. All 
> threads are shown by gdb as sleeping _at_ the place where schedule call is 
> present: So instead of gdb showing all threads sleeping in __switch_to, it 
> shows several functions. That's better than having to look at back trace of 
> each thread to figure out what it is.

The mm version of kgdb does this, but by lying to gdb during the info thread 
command.  IMNSHO, the real way to do this is to process the info thread output 
with an awk script, but I haven't done that just yet.  The problem with lying to 
gdb is that it sometimes remembers...
> 
> This functionality is complemented by printing of thread names in 2.0.X kgdb 
> info threads listing. 

as in the mm version.
> 
> Now back to gdb problem of not being able to locate registers.
> schedule results in code of this form:
> 
> schedule:
> framesetup
> registers save
> ...
> ...
> save registers
> change esp
> call switchto
> restore registers
> ...
I have not analyzed this as yet.  However, it does seem to me to be the same 
problem as trying to bt through an interrupt frame.  The correct way to do this 
is to build the dwarf frame descriptors.  I have done this for the interrupt 
frame and intend to send said patch out in a day or so.

Could be I should look at the above and do the right thing for it also.
> ...
> 
> GDB can't analyze code other than frame setup and registers save. It may not 
> show values of variables that are present in registers correctly. This used 
> to be a problem some time ago (gdb 5.X). Perhaps gdb 6.x does a better job.
> hmm...
> May be its time I should look at gdb's x86 register info code again.

The latter gdbs (not sure when) are using dwarf frame code.  The asm code needs 
to be anotated to make this work.  There is a problem I reported a couple of 
days ago with the dwarf expression code.  I think it is fixed, but that would 
still be the cvs version of gdb.

I think I would rather NOT modify kernel code and put up with the register loss 
in some cases.  I am MUCH more concerned with unexpected behavior due to the 
code changes.  Heisenberg is NOT our friend.

-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml

