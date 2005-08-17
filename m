Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751172AbVHQRLL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751172AbVHQRLL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Aug 2005 13:11:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751173AbVHQRLL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Aug 2005 13:11:11 -0400
Received: from mail1.utc.com ([192.249.46.190]:50153 "EHLO mail1.utc.com")
	by vger.kernel.org with ESMTP id S1751172AbVHQRLK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Aug 2005 13:11:10 -0400
Message-ID: <43036F80.2020406@cybsft.com>
Date: Wed, 17 Aug 2005 12:10:24 -0500
From: "K.R. Foley" <kr@cybsft.com>
Organization: Cybersoft Solutions, Inc.
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Steven Rostedt <rostedt@goodmis.org>, Thomas Gleixner <tglx@linutronix.de>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.13-rc6-rt6
References: <20050816170805.GA12959@elte.hu> <1124214647.5764.40.camel@localhost.localdomain> <1124215631.5764.43.camel@localhost.localdomain> <1124218245.5764.52.camel@localhost.localdomain> <1124252419.5764.83.camel@localhost.localdomain> <1124257580.5764.105.camel@localhost.localdomain> <20050817064750.GA8395@elte.hu> <1124287505.5764.141.camel@localhost.localdomain> <1124288677.5764.154.camel@localhost.localdomain> <1124295214.5764.163.camel@localhost.localdomain> <20050817162324.GA24495@elte.hu>
In-Reply-To: <20050817162324.GA24495@elte.hu>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> * Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> 
>>On Wed, 2005-08-17 at 10:24 -0400, Steven Rostedt wrote:
>>
>>
>>>OK the output from netconsole still seems like netconsole itself is
>>>causing some problems.  But I think it is also showing this lockup. I'll
>>>recompile my kernel as UP and see if netconsole works fine.
>>
>>Well, the UP kernel boots on my laptop, but netconsole gives strange 
>>warnings.
>>
>>OK, what's the scoop with the illegal_API_call?  What is it about, and 
>>what is the expected work around?
> 
> 
> this is a recent change: i've started flagging "naked" use of 
> local_irq_disable(), because it's a problem on PREEMPT_RT and it's a 
> potential SMP bug on upstream kernels. A local_irq_disable() is 
> converted either to raw_local_irq_disable() when justified (it's mostly 
> only justified for lowlevel arch code), or is eliminated totally.  
> (either by merging it into a nearby spin_lock API call, or by removing 
> it altogether, making sure that code doesnt break).
> 
> Right now we print a warning on the first such API use, and then shut up 
> about it. All local_irq_() APIs map to NOPs. (we keep the PF_IRQSOFF 
> flag for compatibility, but only to get irqs_off() right which in turn 
> shuts off a number of BUG_ON(!irqs_disabled()) warnings, and it doesnt 
> have any other functional purpose.)
> 
> the desired end-result would be the total elimination of local_irq_*() 
> API calls.
> 
> 
>>I'm also getting the following output on shutdown:
>>
>>NET: Registered protocol family 31
>>Bluetooth: HCI device and connection manager initialized
>>Bluetooth: HCI socket layer initialized
>>Bluetooth: L2CAP ver 2.7
>>Bluetooth: L2CAP socket layer initialized
>>Bluetooth: RFCOMM ver 1.5
>>Bluetooth: RFCOMM socket layer initialized
>>Bluetooth: RFCOMM TTY layer initialized
>>BUG: nonzero lock count 1 at exit time?
>>            nfsd: 4696 [f7183830, 115]
>> [<c0136922>] check_no_held_locks+0x62/0x330 (8)
>> [<c011df67>] do_exit+0x257/0x480 (32)
>> [<c013d052>] __module_put_and_exit+0x52/0x70 (40)
>> [<f8d54583>] nfsd+0x2b3/0x340 [nfsd] (12)
>> [<f8d542d0>] nfsd+0x0/0x340 [nfsd] (48)
>> [<c010140d>] kernel_thread_helper+0x5/0x18 (16)
>>---------------------------
>>| preempt count: 00000000 ]
>>| 0-level deep critical section nesting:
>>----------------------------------------
>>
>>------------------------------
>>| showing all locks held by: |  (nfsd/4696 [f7183830, 116]):
>>------------------------------
>>
>>#001:             [c038e184] {kernel_sem.lock}
>>... acquired at:               lock_kernel+0x21/0x40
>>
>>BUG: nfsd/4696, BKL held at task exit time!
> 



> 
> hm, it seems nfsd forgets to do an unlock_kernel() in some exit path it 
> seems? We are enforcing strict balanced lock use in PREEMPT_RT - the 
> upstream kernel is more relaxed about it.
> 

This one has been biting me in the shorts since going to the 2.6.13-rc? 
RT series on my older SMP system at home. In every case the system hangs 
on shutdown and requires a hard reset. I just hadn't had the time to 
check into it. I was just in the process of building 2.6.13-rc6 without 
RT to check if it still happened. Guess I won't bother now. :-)

Aug 16 11:11:09 porky kernel: BUG: nonzero lock count 1 at exit time?
Aug 16 11:11:09 porky kernel:             nfsd: 4476 [dd1691a0, 115]
Aug 16 11:11:09 porky kernel:  [<c010418e>] dump_stack+0x1e/0x20 (20)
Aug 16 11:11:09 porky kernel:  [<c013b7ff>] 
check_no_held_locks+0x1af/0x370 (36)
Aug 16 11:11:09 porky kernel:  [<c0122e3f>] do_exit+0x26f/0x480 (44)
Aug 16 11:11:09 porky kernel:  [<c01413c1>] 
__module_put_and_exit+0x51/0x70 (16)
Aug 16 11:11:09 porky kernel:  [<e5a8558d>] nfsd+0x2bd/0x340 [nfsd] (68)
Aug 16 11:11:09 porky kernel:  [<c0101315>] 
kernel_thread_helper+0x5/0x10 (65485
2124)
Aug 16 11:11:09 porky kernel: ---------------------------
Aug 16 11:11:09 porky kernel: | preempt count: 00000000 ]
Aug 16 11:11:09 porky kernel: | 0-level deep critical section nesting:
Aug 16 11:11:09 porky kernel: ----------------------------------------
Aug 16 11:11:09 porky kernel:
Aug 16 11:11:09 porky kernel: ------------------------------
Aug 16 11:11:09 porky kernel: | showing all locks held by: |  (nfsd/4476 
[dd1691
a0, 116]):
Aug 16 11:11:09 porky kernel: ------------------------------
Aug 16 11:11:09 porky kernel:
Aug 16 11:11:09 porky kernel: #001:             [c0390fe4] {kernel_sem.lock}
Aug 16 11:11:09 porky kernel: ... acquired at: 
lock_kernel+0x28/0x50
Aug 16 11:11:09 porky kernel:
Aug 16 11:11:09 porky kernel: BUG: nfsd/4476, BKL held at task exit time!
Aug 16 11:11:09 porky kernel: BKL acquired at: nfsd+0x273/0x340 [nfsd]
Aug 16 11:11:09 porky kernel:  [c0390fe4] {kernel_sem.lock}
Aug 16 11:11:09 porky kernel: .. held by:              nfsd: 4476 
[dd1691a0, 116]
Aug 16 11:11:09 porky kernel: ... acquired at: 
lock_kernel+0x28/0x50
Aug 16 11:46:44 porky syslogd 1.4.1: restart.


> 
>>And it goes on and on. This happens everytime. Without netconsole, I
>>only get the nonzero lock count error. Also, one of my lockups on SMP
>>had to do with the kernel_thread_helper:
>>
>>Using IPI Shortcut mode
>>khelper/794[CPU#0]: BUG in set_new_owner at kernel/rt.c:916
> 
> 
> this is a 'must not happen'. Somehow lock->held list got non-empty.  
> Maybe some use-after-free thing? Havent seen it myself.
> 
> 	Ingo
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


-- 
    kr
