Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751341AbWCMOs5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751341AbWCMOs5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 09:48:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751357AbWCMOs5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 09:48:57 -0500
Received: from ruault.com ([81.57.109.127]:58799 "EHLO ruault.com")
	by vger.kernel.org with ESMTP id S1751341AbWCMOs4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 09:48:56 -0500
Message-ID: <4415863E.5060704@ruault.com>
Date: Mon, 13 Mar 2006 15:48:30 +0100
From: Charles-Edouard Ruault <ce@ruault.com>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051018)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
CC: Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] timer-irq-driven soft-watchdog, cleanups
References: <43EF8388.10202@ruault.com> <20060215185120.6c35eca2.akpm@osdl.org>	 <58cb370e0602160533n3325ba03yfedaf4e55278521d@mail.gmail.com>	 <20060216122045.7a664bc6.akpm@osdl.org>	 <58cb370e0602170347qeddb390u680895fd2f0aab7d@mail.gmail.com>	 <20060217130801.GA16115@elte.hu>	 <58cb370e0602170646h3d0cddo8b042eab251d9365@mail.gmail.com>	 <20060217201123.GB29025@elte.hu> <58cb370e0602171415q1b040e7er1e7849212f95f2b7@mail.gmail.com>
In-Reply-To: <58cb370e0602171415q1b040e7er1e7849212f95f2b7@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:

>On 2/17/06, Ingo Molnar <mingo@elte.hu> wrote:
>  
>
>>* Bartlomiej Zolnierkiewicz <bzolnier@gmail.com> wrote:
>>
>>    
>>
>>>Sorry but I have enough more high priority issues to take care of and
>>>I'm not going to spend any more time on soft lockups even if they are
>>>really problems in IDE subsystem.  If this is not fixed before 2.6.16
>>>I'm submitting patch to Linus making DETECT_SOFTLOCKUP depend on
>>>"CONFIG_IDE=n"... at least users will be able to use their systems
>>>instead of seeing lockups.
>>>      
>>>
>>i have lots of IDE based systems (they dont use PIO though) and i'm not
>>seeing these. I'll oppose such a patch if it's to hide genuine issues -
>>the 10 seconds tolerance is already generous i think. I'll of course fix
>>any false positives which are the fault of the softlockup-watchdog, but
>>from your mails it appears to me that the IDE warnings are indeed
>>genuine.
>>
>>If the source of the delay is hard to fix you can temporarily work it
>>around in the code by putting in the touch_softlockup_watchdog() lines -
>>that will also document the places that cause long delays - which is a
>>good thing.
>>
>>It is entirely feasible to put a touch_softlockup_watchdog() call into
>>every PIO OP - even a single-byte PIO related IN/OUT instruction takes a
>>couple of microseconds, so a touch_softlockup_watchdog() wont even show
>>up on the radar.
>>    
>>
>
>OK, I'll just add touch_softlockup_watchdog() if needed but first lets
>wait for results of your patch.
>
>Note that I'll invest my time on this which could be invested into other
>things and I don't see it as top-priority issue if you differ in your opinion
>you should be the person fixing affected drivers.
>
>The conclusion of the rant is:  people making changes at higher layers
>should start paying maintenance costs of their changes.  Over few years
>of maintaining IDE I learned quite a lot about block layer, VFS, VM, ACPI,
>PM, IRQ routing, scheduling, sysfs etc (I'm not talking about interface
>changes but about bugs/changes which are reported by end users
>and driver maintainers are end-point).  This is all good but distracts me
>from my primary task and now it is turn for people hacking on generic
>code to learn few driver specific things... :)
>
>No wonder that nobody wants to hack drivers: less fame, more flames,
>and actually besides knowing hardware you need to know a lot about
>kernel in general to do your job right.  I hope that Andrew is reading this.
>
>End of whining.
>
>  
>
>>>DETECT_SOFTLOCKUP should be an aim in development not a method of
>>>forcing driver maintainers to work on specific issues...
>>>      
>>>
>>well, 10+ seconds delays on a running system are not really acceptable,
>>and can cause other problems. The softlockup-watchdog is optional and
>>can be easily turned off in the .config.
>>    
>>
>
>It is "y" by default so anybody saying "y" to DEBUG_KERNEL will get it as
>added bonus and moreover DEBUG_KERNEL is "y" in x86_64 defconfig.
>
>Bartlomiej
>  
>
Guys,
sorry for having been silent for so long ... since i had the problem, i
upgraded to 2.6.15.6 and i experienced the problem again over the week-end.
My point it that it appears that the BUG: soft lockup detected on CPU#0!
message is legitimate in my case since my machine really freezes
periodically because of ide timeouts.
What i'm trying to figure out is why are the IDE timeouts occuring ?
Both my DVD burner & CD burner usually work fine ( i had been able to
burn a DVD a few hours before the problem occured , i'm able to read CDs
& DVDs fine ).
However, the problem seems to occur only when trying to rip CDs. It
appears that both drives get confused .... ( see logs, both are
reporting timeouts/erros ).
Mar 11 17:41:47 ruault kernel: hdd: ATAPI reset
complete                                                                   
Mar 11 17:41:57 ruault kernel: hdc: irq timeout: status=0x80 { Busy }
Mar 11 17:41:57 ruault kernel: ide: failed opcode was:
unknown                                                             
Mar 11 17:41:57 ruault kernel: hdd: status timeout: status=0x80 { Busy }
Mar 11 17:41:57 ruault kernel: ide: failed opcode was:
unknown                                                             
Mar 11 17:41:57 ruault kernel: hdd: drive not ready for command
Mar 11 17:41:57 ruault kernel: hdd: ATAPI reset
complete                                                                   
Mar 11 17:42:17 ruault kernel: hdc: irq timeout: status=0x80 { Busy }
Mar 11 17:42:17 ruault kernel: ide: failed opcode was:
unknown                                                             
Mar 11 17:42:17 ruault kernel: hdd: status timeout: status=0x80 { Busy }
Mar 11 17:42:17 ruault kernel: ide: failed opcode was:
unknown                                                             
Mar 11 17:42:17 ruault kernel: hdd: drive not ready for command
Mar 11 17:42:17 ruault kernel: BUG: soft lockup detected on
CPU#0!                                                         
Mar 11 17:42:17 ruault kernel:
Mar 11 17:42:17 ruault kernel: Pid: 0, comm:             
swapper                                                          
Mar 11 17:42:17 ruault kernel: EIP: 0060:[<c0272c55>] CPU: 0
Mar 11 17:42:17 ruault kernel: EIP is at
ide_inb+0x5/0x10                                                                  

Mar 11 17:42:17 ruault kernel:  EFLAGS: 00000206    Tainted: P      
(2.6.15.6)
Mar 11 17:42:17 ruault kernel: EAX: 00000180 EBX: 03aba395 ECX: f2b9d721
EDX: 00000177                                     
Mar 11 17:42:17 ruault kernel: ESI: 00000088 EDI: c0419e30 EBP: c0419ec4
DS: 007b ES: 007b
Mar 11 17:42:17 ruault kernel: CR0: 8005003b CR2: b7fe2000 CR3: 32e1b000
CR4: 000006d0

And i can confirm that when this happens the machine is totally
unresponsive, as before i had to reboot the machine with a hard reset
after a while.
So my question is what could be causing this behaviour ? is this a bug
in the IDE driver ? a hardware problem with my drives ( as i said they
appear to be working fine otherwise ), another hardware problem with my
motherboard ?
What could i do to help troubleshoot the problem ?
Thanks in advance.

PS: I do not subscribe to the list so please CC me when replying ....

-- 
Charles-Edouard Ruault
GPG key Id E4D2B80C

