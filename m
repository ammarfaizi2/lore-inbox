Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261808AbUCBVir (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Mar 2004 16:38:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261815AbUCBVir
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Mar 2004 16:38:47 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:59896 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S261808AbUCBVio
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Mar 2004 16:38:44 -0500
Message-ID: <4044FEDE.5000105@mvista.com>
Date: Tue, 02 Mar 2004 13:38:38 -0800
From: George Anzinger <george@mvista.com>
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Amit S. Kale" <amitkale@emsyssoft.com>,
       Daniel Jacobowitz <djacobowitz@mvista.com>
CC: Pavel Machek <pavel@suse.cz>, Tom Rini <trini@kernel.crashing.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       kgdb-bugreport@lists.sourceforge.net
Subject: Re: [Kgdb-bugreport] [KGDB PATCH][1/7] Add / use kernel/Kconfig.kgdb
References: <20040227212301.GC1052@smtp.west.cox.net> <20040227235059.GG425@elf.ucw.cz> <403FEA02.6040506@mvista.com> <200403011454.35346.amitkale@emsyssoft.com>
In-Reply-To: <200403011454.35346.amitkale@emsyssoft.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Amit S. Kale wrote:
> On Saturday 28 Feb 2004 6:38 am, George Anzinger wrote:
> 
>>Pavel Machek wrote:
>>
>>>Hi!
>>>
>>>
>>>>>+config KGDB_THREAD
>>>>>+	bool "KGDB: Thread analysis"
>>>>>+	depends on KGDB
>>>>>+	help
>>>>>+	  With thread analysis enabled, gdb can talk to kgdb stub to list
>>>>>+	  threads and to get stack trace for a thread. This option also
>>>>>enables
>>>>>+	  some code which helps gdb get exact status of thread. Thread
>>>>>analysis
>>>>>+	  adds some overhead to schedule and down functions. You can disable
>>>>>+	  this option if you do not want to compromise on speed.
>>>>
>>>>Lets remove the overhead and eliminate the need for this option in favor
>>>>of always having threads.  Works in the mm kgdb...
>>>
>>>No. Thread analysis is unsuitable for the mainline (manipulates
>>>sched.c in ugly way). It may be okay for -mm, but in such case it
>>>should better be separated.
>>
>>Not in the -mm version.  I agree that sched.c should NEVER be treated this
>>way and it is not in the -mm version.  I also think that, most of the time,
>>it is useful to have the thread stuff, but that may be just my usage...
> 
> 
> If threads stuff didn't introduce any unclean code changes, I too would prefer 
> to have it on all the time. As things stands, threads stuff is rather 
> intrusive.

Lets put the threads stuff in the stub.  The only stuff we need in the kernel is 
the flag that indicateds that the pid hash table has been initialized.

Meanwhile, I would like to make a change to the gdb "info thread" command to do 
a better job of displaying the threads.  Here is what I am proposing:

Gdb would work as it does now if the following set is not done.

A new "set thread_level" command that would take the "bt" level to use on the 
thread display.
A new "set thread_limits command that would take two expressions that would 
reduce to two memory addresses.

Which ever of these is entered last will be active and used by "info thread" as 
follows:

if thread_level is active gdb will do the indicated number of  "up" operations 
and display the result on the info thread line for that thread (note there is 
other info on this line that will not be changed).

if thread_limits is active gdb will do 0 or more "up" commands until the 
resultant PC is NOT between the given limits.

The kernel, at this time, has defined symbols for the thread_limits command (it 
is used in the kernel for its internal display of threads).  I would expect that 
the thread_level version would be the answer for theaded application programs.

Daniel, how does this sound?

-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml

