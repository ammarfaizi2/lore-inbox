Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261300AbUCDASl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Mar 2004 19:18:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261317AbUCDARh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Mar 2004 19:17:37 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:31983 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S261300AbUCDAQH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Mar 2004 19:16:07 -0500
Message-ID: <4046753E.7030004@mvista.com>
Date: Wed, 03 Mar 2004 16:15:58 -0800
From: George Anzinger <george@mvista.com>
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Amit S. Kale" <amitkale@emsyssoft.com>
CC: Daniel Jacobowitz <djacobowitz@mvista.com>, Pavel Machek <pavel@suse.cz>,
       Tom Rini <trini@kernel.crashing.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       kgdb-bugreport@lists.sourceforge.net
Subject: Re: [Kgdb-bugreport] [KGDB PATCH][1/7] Add / use kernel/Kconfig.kgdb
References: <20040227212301.GC1052@smtp.west.cox.net> <200403011454.35346.amitkale@emsyssoft.com> <4044FEDE.5000105@mvista.com> <200403031100.24647.amitkale@emsyssoft.com>
In-Reply-To: <200403031100.24647.amitkale@emsyssoft.com>
Content-Type: multipart/mixed;
 boundary="------------020600020203030407030204"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is a multi-part message in MIME format.
--------------020600020203030407030204
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Amit S. Kale wrote:
> On Wednesday 03 Mar 2004 3:08 am, George Anzinger wrote:
> 
>>Amit S. Kale wrote:
>>
>>>On Saturday 28 Feb 2004 6:38 am, George Anzinger wrote:
>>>
>>>>Pavel Machek wrote:
>>>>
>>>>>Hi!
>>>>>
>>>>>
>>>>>>>+config KGDB_THREAD
>>>>>>>+	bool "KGDB: Thread analysis"
>>>>>>>+	depends on KGDB
>>>>>>>+	help
>>>>>>>+	  With thread analysis enabled, gdb can talk to kgdb stub to list
>>>>>>>+	  threads and to get stack trace for a thread. This option also
>>>>>>>enables
>>>>>>>+	  some code which helps gdb get exact status of thread. Thread
>>>>>>>analysis
>>>>>>>+	  adds some overhead to schedule and down functions. You can disable
>>>>>>>+	  this option if you do not want to compromise on speed.
>>>>>>
>>>>>>Lets remove the overhead and eliminate the need for this option in
>>>>>>favor of always having threads.  Works in the mm kgdb...
>>>>>
>>>>>No. Thread analysis is unsuitable for the mainline (manipulates
>>>>>sched.c in ugly way). It may be okay for -mm, but in such case it
>>>>>should better be separated.
>>>>
>>>>Not in the -mm version.  I agree that sched.c should NEVER be treated
>>>>this way and it is not in the -mm version.  I also think that, most of
>>>>the time, it is useful to have the thread stuff, but that may be just my
>>>>usage...
>>>
>>>If threads stuff didn't introduce any unclean code changes, I too would
>>>prefer to have it on all the time. As things stands, threads stuff is
>>>rather intrusive.
>>
>>Lets put the threads stuff in the stub.  The only stuff we need in the
>>kernel is the flag that indicateds that the pid hash table has been
>>initialized.
>>
>>Meanwhile, I would like to make a change to the gdb "info thread" command
>>to do a better job of displaying the threads.  Here is what I am proposing:
>>
>>Gdb would work as it does now if the following set is not done.
>>
>>A new "set thread_level" command that would take the "bt" level to use on
>>the thread display.
>>A new "set thread_limits command that would take two expressions that would
>>reduce to two memory addresses.
>>
>>Which ever of these is entered last will be active and used by "info
>>thread" as follows:
>>
>>if thread_level is active gdb will do the indicated number of  "up"
>>operations and display the result on the info thread line for that thread
>>(note there is other info on this line that will not be changed).
> 
> 
> You can already do a backtrace on all threads using gdb command
> "thread apply all backtrace".
> 
> 
>>if thread_limits is active gdb will do 0 or more "up" commands until the
>>resultant PC is NOT between the given limits.
> 
> 
> How does a user specify PC? There are umpteen number of kernel entry points 
> (irqs, exceptions, system calls).

We are not interested in that.  There are two entry points in the kernel:

void scheduling_functions_start_here(void);
void scheduling_functions_end_here(void);

that bound the area we don't want to show the task in in the info thread 
command.  $PC is the same as $ESP in the x86, but it is defined in all archs 
regardless of the particular local name for the stack pointer.

> 
> 
>>The kernel, at this time, has defined symbols for the thread_limits command
>>(it is used in the kernel for its internal display of threads).  I would
>>expect that the thread_level version would be the answer for theaded
>>application programs.
>>
>>Daniel, how does this sound?
> 
> 
> 
> The problem with kernel backtraces not stopping at kernel entry points is a 
> tough one. gdbmod at kgdb.sourceforge.net attempts to do that. This gdb 
> detects if we are debugging a kernel. If we are, a few things kick in like 
> scanning of modules instead of .so libraries and stopping backtraces earlier.

Stopping "bt" is a different problem, one which should be addressed by fixing up 
the debug frame records to indicate where the bottom of the stack is.  I have 
code for this for the x86, but it uses CPP macros rather than the gas interface 
for such which is rather restrictive.
> 
> GDB uses main as the function where backtraces stop unless overridden. This is 
> broken by definition for multithreaded programs becauses non initial threads 
> don't start from main. Kernel too doesn't have main and has several entry 
> points.
> 
> If there is a way for gdb to know entry points from the kernel, it would be 
> very easy to maintain. Say a .entrypoint section that lists pc ranges of 
> entry points. GDB then stop a backtrace as soon as it enters one of these 
> ranges.

No, this is not enough.  It needs to also know to stop when the interrupt/ trap 
returns to user space.  You might try the attached patch.  Be warned, however, 
that it requires a CVS gdb (I found broken code).

-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml

--------------020600020203030407030204
Content-Type: application/x-gzip;
 name="kgdb-dwarf2-2.6.0-1.0.patch.gz"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="kgdb-dwarf2-2.6.0-1.0.patch.gz"

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
95Hm/wCdtZ7zx5sAAA==
--------------020600020203030407030204--

