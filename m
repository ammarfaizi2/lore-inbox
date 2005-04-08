Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262810AbVDHNzg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262810AbVDHNzg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Apr 2005 09:55:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262808AbVDHNze
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Apr 2005 09:55:34 -0400
Received: from alog0501.analogic.com ([208.224.223.38]:23984 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S262820AbVDHNzS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Apr 2005 09:55:18 -0400
Date: Fri, 8 Apr 2005 09:54:32 -0400 (EDT)
From: "Richard B. Johnson" <linux-os@analogic.com>
Reply-To: linux-os@analogic.com
To: Daniel Jacobowitz <dan@debian.org>
cc: Jan Harkes <jaharkes@cs.cmu.edu>,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Linux-2.6.11 can't disable CAD
In-Reply-To: <20050408130522.GA32099@nevyn.them.org>
Message-ID: <Pine.LNX.4.61.0504080938480.6960@chaos.analogic.com>
References: <Pine.LNX.4.61.0504071102590.4871@chaos.analogic.com>
 <20050407202059.GA414@delft.aura.cs.cmu.edu> <Pine.LNX.4.61.0504071639060.4895@chaos.analogic.com>
 <20050408130522.GA32099@nevyn.them.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Apr 2005, Daniel Jacobowitz wrote:

> On Thu, Apr 07, 2005 at 04:50:32PM -0400, Richard B. Johnson wrote:
>> On Thu, 7 Apr 2005, Jan Harkes wrote:
>>
>>> On Thu, Apr 07, 2005 at 11:16:14AM -0400, Richard B. Johnson wrote:
>>>> In the not-too distant past, one could disable Ctl-Alt-DEL.
>>>> Can't do it anymore.
>>> ...
>>>> Observe that reboot() returns 0 and `strace` understands what
>>>> parameters were passed. The result is that, if I hit Ctl-Alt-Del,
>>>> `init` will still execute the shutdown-order (INIT 0).
>>>
>>> Actually, if CAD is enabled in the kernel, it will just reboot.
>>> If CAD is disabled in the kernel a SIGINT is sent to pid 1 (/sbin/init).
>>>
>>
>> No, that's not how it ever worked. There are parameters that are
>> available in the reboot-system call that define the operation that
>> will occur when the 3-finger salute occurs.
>>
>> Execute man 2 reboot.
>
> Take your own advice.  From the man page:
>
>       LINUX_REBOOT_CMD_CAD_ON
>              (RB_ENABLE_CAD, 0x89abcdef).  CAD is enabled.  This means
>              that the CAD keystroke will immediately cause the action
>              associated with LINUX_REBOOT_CMD_RESTART.
>
>       LINUX_REBOOT_CMD_CAD_OFF
>              (RB_DISABLE_CAD, 0).  CAD is disabled. This means that the CAD
>              keystroke will cause a SIGINT signal to be sent to init
>              (process 1), whereupon this process may decide upon a
>              proper action (maybe: kill all processes, sync, reboot).
>
> -- 
> Daniel Jacobowitz
> CodeSourcery, LLC
>

The 'init' in use is not SYS-V init. Instead, it is the startup
program, mother-of-all-programs, of a complete embedded system
that has no shells, etc. It's just a system that's designed to
make images.

There are handlers in place for all signals, either to ignore
signals or to perform things like X-ON and X-OFF. This 'init'
will never shut down the system. It doesn't know how. It also
ignores any "harmful" signals and, in fact, will never exit
the main program. Again, it doesn't know how. It just forks off
some processes and then sleeps, occasionally waking to
get and throw away the exit-status of some child's
children.

Also, this has been working for many years. It is unknown
how many linux-versions this worked with since it was first
tested with 2.4.x circa 2000 to 2001.

It appears that the 'C' runtime library is now trapping
reboot() and turning it into a single-parameter function
call. It is possible that the correct 4-parameter reboot()
is not even making it to the kernel. I am investigating this.
I made another function called disable() that will directly
make a system-call, thereby bypassing the 'C' runtime library
altogether. I am working on this.


Cheers,
Dick Johnson
Penguin : Linux version 2.6.11 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by Dictator Bush.
                  98.36% of all statistics are fiction.
