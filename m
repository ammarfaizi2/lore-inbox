Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161219AbVKRU6r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161219AbVKRU6r (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 15:58:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161221AbVKRU6r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 15:58:47 -0500
Received: from tornado.reub.net ([202.89.145.182]:11414 "EHLO tornado.reub.net")
	by vger.kernel.org with ESMTP id S1161219AbVKRU6q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 15:58:46 -0500
Message-ID: <437E408A.8010808@reub.net>
Date: Sat, 19 Nov 2005 09:58:50 +1300
From: Reuben Farrelly <reuben-lkml@reub.net>
User-Agent: Thunderbird 1.6a1 (Windows/20051117)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.15-rc1-mm1
References: <20051117111807.6d4b0535.akpm@osdl.org>	<437D80BD.7030609@reub.net> <20051117234252.087fa813.akpm@osdl.org>
In-Reply-To: <20051117234252.087fa813.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On 18/11/2005 8:42 p.m., Andrew Morton wrote:
> Reuben Farrelly <reuben-lkml@reub.net> wrote:
>> Hi,
>>
>> On 18/11/2005 8:18 a.m., Andrew Morton wrote:
>>> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.15-rc1/2.6.15-rc1-mm1
>>>
>>> - reiser4 significantly updated
>>>
>>>
>>>
>>>
>>> Changes since 2.6.14-mm2:
>> This has been one of the best -mm releases in a while.  No problems compiling
>> or running - and so far nearly 18 hours uptime without any surprises.
> 
> We'll have to try harder.  -mm2 is up there now, to break everything again.
> 
>> Following up on a posting from the last -mm release,  I'm still seeing errors 
>> loading multiple network drivers as modules (e100 and sky2) when 
>> CONFIG_PREEMPT_BKL is enabled, with 2.6.14-mm1, 2.6.14-mm2 and now
>> 2.6.15-rc1-mm1.  Mainline git doesn't exhibit the problem, so it's -mm specific.
>>
>> This is what is logged:
>>
>> Nov 18 17:40:42 tornado kernel: e100: 0000:06:03.0: e100_eeprom_load: EEPROM
>> corrupted
>> Nov 18 17:40:42 tornado kernel: ACPI: PCI interrupt for device 0000:06:03.0
>> disabled
>> Nov 18 17:40:42 tornado kernel: e100: probe of 0000:06:03.0 failed with error -11
>> Nov 18 17:40:43 tornado kernel: ACPI: PCI Interrupt 0000:04:00.0[A] -> GSI 17
>> (level, low) -> IRQ 177
>> Nov 18 17:40:43 tornado kernel: sky2 0000:04:00.0: unsupported chip type 0xff
>> Nov 18 17:40:43 tornado kernel: ACPI: PCI interrupt for device 0000:04:00.0
>> disabled
>> Nov 18 17:40:43 tornado kernel: sky2: probe of 0000:04:00.0 failed with error -95
>>
>> I'm certain that both of these NIC's are OK as they work fine with 
>> CONFIG_PREEMPT_BKL not selected.
>>
>> With CONFIG_PREEMPT_BKL disabled and an otherwise identical config, the
>> driver modules load up just fine.
>>
>> A known good kernel with this config was 2.6.14-rc5-mm1.
>> I have backed out git-netdev-all but it made no difference, as well as backed 
>> out the e100 changes in -mm on 2.6.15-mm2, again no difference.  So I suspect 
>> it's not a netdev driver problem.
>>
>> What else can I do to help narrow down the problem?  What other trees or patches 
>> would be worth backing out to try and narrow it down?
> 
> I'd be suspecting the PCI changes firstly.  That's gregkh-pci-*. 
> 
> Conceivably git-acpi, but that hasn't changed in quite some time.  In fact,
> no ACPI changes since 2.6.14-rc5-mm1.
> 
> After that I don't know, sorry.   Binary search time?

Still looking into this one.  It appears that backing out the gregkh-pci patches 
in -rc1-mm2 made no difference.

I don't think I should be able to make this happen so easily though:


[root@tornado ~]# rmmod e100
[root@tornado ~]# rmmod sky2
[root@tornado ~]# strace modprobe e100
Unable to handle kernel NULL pointer dereference at virtual address 00000010
  printing eip:
c0124fc7
*pde = 00000000
Oops: 0000 [#1]
PREEMPT SMP
last sysfs file: /class/net/eth0/flags
Modules linked in: nfsd exportfs lockd sunrpc autofs4 lm85 hwmon_vid eeprom ipv6 
binfmt_misc hw_random crc32 piix i2c_i801
CPU:    0
EIP:    0060:[<c0124fc7>]    Not tainted VLI
EFLAGS: 00010202   (2.6.15-rc1-mm2-preempt)
EIP is at ptrace_check_attach+0x14/0xaf
eax: 00000001   ebx: 00000000   ecx: 00000001   edx: c0417c00
esi: 00000000   edi: 00000000   ebp: e93b0f9c   esp: e93b0f90
ds: 007b   es: 007b   ss: 0068
Process strace (pid: 3386, threadinfo=e93b0000 task=ec4c0130)
Stack: 00000000 00000000 00000018 e93b0fb4 c0125840 00000000 00000018 00000000
        4521bff4 e93b0000 c0102cb7 00000018 00000d3b 00000001 00000000 4521bff4
        bf819eb8 0000001a 0000007b c010007b 0000001a ffffe410 00000073 00000202
Call Trace:
  [<c0103c09>] show_stack+0x94/0xca
  [<c0103dd2>] show_registers+0x17a/0x210
  [<c0104008>] die+0x116/0x19d
  [<c03394dd>] do_page_fault+0x1ed/0x63d
  [<c01038af>] error_code+0x4f/0x54
  [<c0125840>] sys_ptrace+0x50/0xb9
  [<c0102cb7>] sysenter_past_esp+0x54/0x75
---------------------------
| preempt count: 00000002 ]
| 2 level deep critical section nesting:
----------------------------------------
.. [<c03389cc>] .... _read_lock+0x10/0x6b
.....[<c0124fc7>] ..   ( <= ptrace_check_attach+0x14/0xaf)
.. [<c0338938>] .... _spin_lock_irqsave+0x11/0x71
.....[<c0103f36>] ..   ( <= die+0x44/0x19d)

Code: 4c 5b 39 c0 a3 4c 5b 39 c0 c7 43 68 48 5b 39 c0 89 50 04 89 02 eb a8 55 89 
e5 57 56 53 89 c3 89 d7 b8 00 7c 41 c0 e8 f5 39 21 00 <8b> 53 10 f6 c2 01 75 21 
be fd ff ff ff b8 00 7c 41 c0 e8 43 3c
  <3>Debug: sleeping function called from invalid context at 
include/linux/rwsem.h:43
in_atomic():1, irqs_disabled():0
  [<c0103c56>] dump_stack+0x17/0x19
  [<c011a173>] __might_sleep+0x9c/0xae
  [<c011da06>] profile_task_exit+0x16/0x49
  [<c011f6f7>] do_exit+0x1c/0x47a
  [<c010408f>] do_divide_error+0x0/0x9e
  [<c03394dd>] do_page_fault+0x1ed/0x63d
  [<c01038af>] error_code+0x4f/0x54
  [<c0125840>] sys_ptrace+0x50/0xb9
  [<c0102cb7>] sysenter_past_esp+0x54/0x75
---------------------------
| preempt count: 00000001 ]
| 1 level deep critical section nesting:
----------------------------------------
.. [<c03389cc>] .... _read_lock+0x10/0x6b
.....[<c0124fc7>] ..   ( <= ptrace_check_attach+0x14/0xaf)

BUG: strace[3386] exited with nonzero preempt_count 1!
---------------------------
| preempt count: 00000001 ]
| 1 level deep critical section nesting:
----------------------------------------
.. [<c03389cc>] .... _read_lock+0x10/0x6b
.....[<c0124fc7>] ..   ( <= ptrace_check_attach+0x14/0xaf)

BUG: soft lockup detected on CPU#0!

Pid: 3386, comm:               strace
EIP: 0060:[<c0338b8c>] CPU: 0
EIP is at _write_lock_irqsave+0x65/0x7b
  EFLAGS: 00000202    Not tainted  (2.6.15-rc1-mm2-preempt)
EAX: 00ffffff EBX: 00000286 ECX: 00000000 EDX: 00000001
ESI: c0417c00 EDI: ec4c05ec EBP: e93b0e6c DS: 007b ES: 007b
CR0: 8005003b CR2: 00000010 CR3: 00456000 CR4: 000006d0
---------------------------
| preempt count: 00010001 ]
| 1 level deep critical section nesting:
----------------------------------------
.. [<c03389cc>] .... _read_lock+0x10/0x6b
.....[<c0124fc7>] ..   ( <= ptrace_check_attach+0x14/0xaf)

BUG: soft lockup detected on CPU#0!

Pid: 3386, comm:               strace
EIP: 0060:[<c0338b8c>] CPU: 0
EIP is at _write_lock_irqsave+0x65/0x7b
  EFLAGS: 00000202    Not tainted  (2.6.15-rc1-mm2-preempt)
EAX: 00ffffff EBX: 00000286 ECX: 00000000 EDX: 00000001
ESI: c0417c00 EDI: ec4c05ec EBP: e93b0e6c DS: 007b ES: 007b
CR0: 8005003b CR2: 00000010 CR3: 00456000 CR4: 000006d0
---------------------------
| preempt count: 00010001 ]
| 1 level deep critical section nesting:
----------------------------------------
.. [<c03389cc>] .... _read_lock+0x10/0x6b
.....[<c0124fc7>] ..   ( <= ptrace_check_attach+0x14/0xaf)

BUG: soft lockup detected on CPU#0!

Pid: 3386, comm:               strace
EIP: 0060:[<c0338b8c>] CPU: 0
EIP is at _write_lock_irqsave+0x65/0x7b
  EFLAGS: 00000202    Not tainted  (2.6.15-rc1-mm2-preempt)
EAX: 00ffffff EBX: 00000286 ECX: 00000000 EDX: 00000001
ESI: c0417c00 EDI: ec4c05ec EBP: e93b0e6c DS: 007b ES: 007b
CR0: 8005003b CR2: 00000010 CR3: 00456000 CR4: 000006d0
---------------------------
| preempt count: 00010001 ]
| 1 level deep critical section nesting:
----------------------------------------
.. [<c03389cc>] .... _read_lock+0x10/0x6b
.....[<c0124fc7>] ..   ( <= ptrace_check_attach+0x14/0xaf)

BUG: soft lockup detected on CPU#0!

Pid: 3386, comm:               strace
EIP: 0060:[<c0338b8a>] CPU: 0
EIP is at _write_lock_irqsave+0x63/0x7b
  EFLAGS: 00000202    Not tainted  (2.6.15-rc1-mm2-preempt)
EAX: 00ffffff EBX: 00000286 ECX: 00000000 EDX: 00000001
ESI: c0417c00 EDI: ec4c05ec EBP: e93b0e6c DS: 007b ES: 007b
CR0: 8005003b CR2: 00000010 CR3: 00456000 CR4: 000006d0
---------------------------
| preempt count: 00010001 ]
| 1 level deep critical section nesting:
----------------------------------------
.. [<c03389cc>] .... _read_lock+0x10/0x6b
.....[<c0124fc7>] ..   ( <= ptrace_check_attach+0x14/0xaf)

BUG: soft lockup detected on CPU#0!

Pid: 3386, comm:               strace
EIP: 0060:[<c0338b8a>] CPU: 0
EIP is at _write_lock_irqsave+0x63/0x7b
  EFLAGS: 00000202    Not tainted  (2.6.15-rc1-mm2-preempt)
EAX: 00ffffff EBX: 00000286 ECX: 00000000 EDX: 00000001
ESI: c0417c00 EDI: ec4c05ec EBP: e93b0e6c DS: 007b ES: 007b
CR0: 8005003b CR2: 00000010 CR3: 00456000 CR4: 000006d0
---------------------------
| preempt count: 00010001 ]
| 1 level deep critical section nesting:
----------------------------------------
.. [<c03389cc>] .... _read_lock+0x10/0x6b
.....[<c0124fc7>] ..   ( <= ptrace_check_attach+0x14/0xaf)

reuben
