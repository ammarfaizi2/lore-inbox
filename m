Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261420AbVFHXQO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261420AbVFHXQO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Jun 2005 19:16:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261520AbVFHXQN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Jun 2005 19:16:13 -0400
Received: from dvhart.com ([64.146.134.43]:45224 "EHLO localhost.localdomain")
	by vger.kernel.org with ESMTP id S261420AbVFHXOh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Jun 2005 19:14:37 -0400
Date: Wed, 08 Jun 2005 16:14:33 -0700
From: "Martin J. Bligh" <mbligh@mbligh.org>
Reply-To: "Martin J. Bligh" <mbligh@mbligh.org>
To: Andrew Morton <akpm@osdl.org>, Andy Whitcroft <apw@shadowen.org>
Cc: pazke@donpac.ru, linux-kernel@vger.kernel.org
Subject: Re: 2.6.12-rc6-mm1
Message-ID: <1051200000.1118272473@flay>
In-Reply-To: <20050608130117.341fa4ff.akpm@osdl.org>
References: <20050607042931.23f8f8e0.akpm@osdl.org><42A6FF41.5040109@shadowen.org> <20050608130117.341fa4ff.akpm@osdl.org>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--On Wednesday, June 08, 2005 13:01:17 -0700 Andrew Morton <akpm@osdl.org> wrote:

> Andy Whitcroft <apw@shadowen.org> wrote:
>> 
>> We've been seeing an early boot hang on IBM x-series (at least on an
>>  x440) with -rc6-mm1.  Finally got hold of a box to go search for this
>>  and it seems that backing out the three patches below fixes it.
>> 
>>   515  dmi-move-acpi-boot-quirk.patch
>>   516  dmi-move-acpi-sleep-quirk.patch
>>   517  dmi-remove-central-blacklist.patch
> 
> Thanks for taking the time to do that - it helps enormously.
> 
> The patches aren't terribly important - I'll drop them if nobody sees the
> problem.  It might be an incorrect __init/__initdata/etc marking.  But that
> wouldn't cause an "early" boot hang...

That does indeed make it boot. However ... once it's booted it seems
to hit another problem, a hang condition ;-( I suspect it's unrelated.
The box is still up and responsive, but cp spins.

I'm still chasing the other boot/hang double problem (amd64), so can't
really look at this right now, but if anyone has any bright ideas they
want me to try, or wants more info, let me know (machine is still hung
in that state).

Some snippets:

ps -ef:

root     10980 10979  0 09:02 ?        00:00:00 /bin/bash /usr/local/autobench/scripts/run test kernbench 32 5 -
m 2^M
root     11060 10980  0 09:02 ?        00:00:00 /bin/bash /usr/local/autobench/scripts/getsysinfo before /usr/lo
cal/autobench/logs/k^M
root     11219 11060  0 09:02 ?        00:00:00 /bin/bash /usr/local/autobench/scripts/archive_dir /proc/scsi /u
sr/local/autobench/l^M
root     11221 11219 99 09:02 ?        04:13:26 cp -r /proc/scsi/aic7xxx /proc/scsi/device_info /proc/scsi/scsi 
/usr/local/autobench^M

alt+sysrq+t

^M^@getsysinfo    S CB5260CC     0 11060  10980 11219               (NOTLB)
^M^@d5fc1f40 00000082 fffffe00 cb5260cc 00000000 c011259b 2691b900 003d08e4 
^M^@       080fa558 00000001 d5fc1f38 c04715c0 c0473080 bfcb43b8 d740e000 cb526020 
^M^@       00000001 cb526020 00000007 d5fc1fbc 0008b824 26cec200 003d08e4 c02fc928 
^M^@Call Trace:
^M^@ [<c011259b>] do_page_fault+0x193/0x60f
^M^@ [<c011d584>] do_wait+0x2a4/0x358
^M^@ [<c0115ff8>] default_wake_function+0x0/0x1c
^M^@ [<c0115ff8>] default_wake_function+0x0/0x1c
^M^@ [<c011d6c6>] sys_wait4+0x26/0x38
^M^@ [<c011d6ee>] sys_waitpid+0x16/0x1a
^M^@ [<c0102a19>] syscall_call+0x7/0xb
^M^@archive_dir   S CBB810CC     0 11219  11060 11221               (NOTLB)
^M^@d7793f40 00000082 fffffe00 cbb810cc 00000000 c011259b 28b70a00 003d08e4 
^M^@       080fa158 00000001 d7793f38 c04715c0 c0473080 bfc51a68 c040e000 cbb81020 
^M^@       00000001 cbb81020 00000007 d7793fbc 00000000 28b70a00 003d08e4 c02fc928 
^M^@Call Trace:
^M^@ [<c011259b>] do_page_fault+0x193/0x60f
^M^@ [<c011d584>] do_wait+0x2a4/0x358
^M^@ [<c0115ff8>] default_wake_function+0x0/0x1c
^M^@ [<c0115ff8>] default_wake_function+0x0/0x1c
^M^@ [<c011d6c6>] sys_wait4+0x26/0x38
^M^@ [<c011d6ee>] sys_waitpid+0x16/0x1a
^M^@ [<c0102a19>] syscall_call+0x7/0xb
^M^@cp            R running     0 11221  11219                     (NOTLB)
^M^@sleep         S D77A1F68     0 11906   1409                     (NOTLB)
^M^@d77a1f58 00000086 0039a67c d77a1f68 bfade9d8 272d8698 b605a700 003d16b7 
^M^@       d5c1e804 d6ecdbac d77a1f50 c04715c0 c0473080 d77a1fbc d6ecd814 d76d3020 
^M^@       00000282 c0121f31 0039a67c c107d0e0 00000000 b605a700 003d16b7 d77a1f68 
^M^@Call Trace:
^M^@ [<c0121f31>] lock_timer_base+0x19/0x3c
^M^@ [<c02ef4db>] schedule_timeout+0x7b/0x9c
^M^@ [<c0122904>] process_timeout+0x0/0xc
^M^@ [<c01229fb>] sys_nanosleep+0xdb/0x158
^M^@ [<c0102a19>] syscall_call+0x7/0xb
^M^@BUG: soft lockup detected on CPU#0!
^M
^M^@Pid: 0, comm:              swapper
^M^@EIP: 0060:[<c02efcd9>] CPU: 0
^M^@EIP is at _spin_unlock_irqrestore+0x5/0x8
^M^@ EFLAGS: 00000292    Not tainted  (2.6.12-rc6-mm1-autokern1)
^M^@EAX: c03b9b84 EBX: c03b9ad4 ECX: 0a000000 EDX: 00000292
^M^@ESI: 00000074 EDI: c040ffa4 EBP: d5c16000 DS: 007b ES: 007b
^M^@CR0: 8005003b CR2: 080f9008 CR3: 16dd0300 CR4: 000006b0
^M^@ [<c020e729>] __handle_sysrq+0x121/0x128
^M^@ [<c020e74f>] handle_sysrq+0x1f/0x24
^M^@ [<c021dda4>] receive_chars+0x16c/0x270
^M^@ [<c021e0a2>] serial8250_interrupt+0x66/0xe4
^M^@ [<c01320f0>] handle_IRQ_event+0x28/0x58
^M^@ [<c0132203>] __do_IRQ+0xe3/0x134
^M^@ [<c0104b4b>] do_IRQ+0x1b/0x28
^M^@ [<c01033d6>] common_interrupt+0x1a/0x20
^M^@ [<c0100bb0>] default_idle+0x0/0x2c
^M^@ [<c0100bd3>] default_idle+0x23/0x2c
^M^@ [<c0100ca3>] cpu_idle+0x7b/0x8c
^M^@ [<c01002c8>] rest_init+0x28/0x2c
^M^@ [<c0410899>] start_kernel+0x19d/0x1a0


alt+sysrq+p does wierd stuff (is that new patch in your tree Andrew?
doesn't seem to inter-react with the other NMI code well)

Command> break
^@SysRq : Show Regs
^M
^M^@Pid: 0, comm:              swapper
^M^@EIP: 0060:[<c0100bd3>] CPU: 0
^M^@EIP is at default_idle+0x23/0x2c
^M^@ EFLAGS: 00000246    Not tainted  (2.6.12-rc6-mm1-autokern1)
^M^@EAX: 00000000 EBX: c0476020 ECX: c0100bb0 EDX: 003a2f43
^M^@ESI: c040e000 EDI: c0470300 EBP: c0470300 DS: 007b ES: 007b
^M^@CR0: 8005003b CR2: b7e3f5a0 CR3: 16dd0300 CR4: 000006b0
^M^@ [<c0100ca3>] cpu_idle+0x7b/0x8c
^M^@ [<c01002c8>] rest_init+0x28/0x2c
^M^@ [<c0410899>] start_kernel+0x19d/0x1a0
^M^@ Uhhuh. NMI received for unknown reason 00 on CPU 1.
^M^@Uhhuh. NMI received for unknown reason 00 on CPU 16.
^M^@Dazed and confused, but trying to continue
^M^@Uhhuh. NMI received for unknown reason 00 on CPU 3.
^M^@Do you have a strange power saving mode enabled?
^M^@Uhhuh. NMI received for unknown reason 00 on CPU 17.
^M^@----------- IPI show regs -----------
^M^@Pid: 0, comm:              swapper
^M^@EIP: 0060:[<c0100bd3>] CPU: 16
^M^@EIP is at default_idle+0x23/0x2c
^M^@Dazed and confused, but trying to continue
^M^@Uhhuh. NMI received for unknown reason 00 on CPU 2.
^M^@Uhhuh. NMI received for unknown reason 00 on CPU 18.
^M^@Dazed and confused, but trying to continue
^M^@Do you have a strange power saving mode enabled?
^M^@ EFLAGS: 00000246    Not tainted  (2.6.12-rc6-mm1-autokern1)
^M^@Do you have a strange power saving mode enabled?
^M^@Dazed and confused, but trying to continue
^M^@Uhhuh. NMI received for unknown reason 00 on CPU 19.
^M^@EAX: 00000000 EBX: c0476020 ECX: c0100bb0 EDX: 003a2f43
^M^@ESI: d7420000 EDI: c0470300 EBP: c0470300 DS: 007b ES: 007b
^M^@Do you have a strange power saving mode enabled?
^M^@Dazed and confused, but trying to continue
^M^@Do you have a strange power saving mode enabled?
^M^@CR0: 8005003b CR2: 00000000 CR3: 17771800 CR4: 000006b0
^M^@Dazed and confused, but trying to continue
^M^@Do you have a strange power saving mode enabled?
^M^@ [<c0100ca3>] cpu_idle+0x7b/0x8c
^M^@ [<c010e79d>]Uhhuh. NMI received for unknown reason 00 on CPU 6.
^M^@Uhhuh. NMI received for unknown reason 00 on CPU 20.
^M^@ start_secondary+0x13d/0x140
^M^@Dazed and confused, but trying to continue
^M^@ ----------- IPI show regs -----------
^M^@Pid: 0, comm:              swapper
^M^@EIP: 0060:[<c0100bd3>] CPU: 18
^M^@Uhhuh. NMI received for unknown reason 00 on CPU 10.
^M^@EIP is at default_idle+0x23/0x2c
^M^@ EFLAGS: 00000246    Not tainted  (2.6.12-rc6-mm1-autokern1)
^M^@EAX: 00000000 EBX: c0476020 ECX: c0100bb0 EDX: 003a2f43
^M^@ESI: d7426000 EDI: c0470300 EBP: c0470300 DS: 007b ES: 007b
^M^@CR0: 8005003b CR2: b7f25d9c CR3: 00474000 CR4: 000006b0
^M^@ [<c0100ca3>]Uhhuh. NMI received for unknown reason 00 on CPU 29.
^M^@ cpu_idle+0x7b/0x8c
^M^@ [<c010e79d>] start_secondary+0x13d/0x140
^M^@----------- IPI show regs -----------
^M^@Pid: 0, comm:              swapper
^M^@EIP: 0060:[<c0100bd3>] CPU: 2
^M^@ EIP is at default_idle+0x23/0x2c
^M^@ EFLAGS: 00000246    Not tainted  (2.6.12-rc6-mm1-autokern1)
^M^@EAX: 00000000 EBX: c0476020 ECX: c0100bb0 EDX: 003a2f43
^M^@ESI: d7400000 EDI: c0470300 EBP: c0470300 DS: 007b ES: 007b
^M^@CR0: 8005003b CR2: b7edeb00 CR3: 00474000 CR4: 000006b0
^M^@ [<c0100ca3>] cpu_idle+0x7b/0x8c
^M^@ [<c010e79d>]Uhhuh. NMI received for unknown reason 00 on CPU 23.
^M^@ start_secondary+0x13d/0x140
^M^@Uhhuh. NMI received for unknown reason 00 on CPU 7.
^M^@ ----------- IPI show regs -----------
^M^@Pid: 0, comm:              swapper
^M^@EIP: 0060:[<c0100bd3>] CPU: 3
^M^@EIP is at default_idle+0x23/0x2c
^M^@ EFLAGS: 00000246    Not tainted  (2.6.12-rc6-mm1-autokern1)
^M^@EAX: 00000000 EBX: c0476020 ECX: c0100bb0 EDX: 003a2f43
^M^@ESI: d7402000 EDI: c0470300 EBP: c0470300 DS: 007b ES: 007b
^M^@Do you have a strange power saving mode enabled?
^M^@CR0: 8005003b CR2: b7f95438 CR3: 17771800 CR4: 000006b0
^M^@ [<c0100ca3>]Uhhuh. NMI received for unknown reason 00 on CPU 4.
^M^@ cpu_idle+0x7b/0x8c
^M^@ [<c010e79d>] start_secondary+0x13d/0x140
^M^@ ----------- IPI show regs -----------
^M^@Pid: 0, comm:              swapper
^M^@EIP: 0060:[<c0100bd3>] CPU: 17
^M^@Uhhuh. NMI received for unknown reason 00 on CPU 5.
^M^@Dazed and confused, but trying to continue
^M^@EIP is at default_idle+0x23/0x2c
^M^@Uhhuh. NMI received for unknown reason 00 on CPU 14.
^M^@ EFLAGS: 00000246    Not tainted  (2.6.12-rc6-mm1-autokern1)
^M^@EAX: 00000000 EBX: c0476020 ECX: c0100bb0 EDX: 003a2f43
^M^@ESI: d7424000 EDI: c0470300 EBP: c0470300 DS: 007b ES: 007b
^M^@CR0: 8005003b CR2: 00000000 CR3: 00474000 CR4: 000006b0
^M^@ [<c0100ca3>]Uhhuh. NMI received for unknown reason 00 on CPU 9.
^M^@ cpu_idle+0x7b/0x8c
^M^@Uhhuh. NMI received for unknown reason 00 on CPU 25.
^M^@ [<c010e79d>] start_secondary+0x13d/0x140Dazed and confused, but trying to continue
^M
^M^@----------- IPI show regs -----------
^M^@Pid: 0, comm:              swapper
^M^@EIP: 0060:[<c0100bd3>] CPU: 19
^M^@ EIP is at default_idle+0x23/0x2c
^M^@ EFLAGS: 00000246    Not tainted  (2.6.12-rc6-mm1-autokern1)
^M^@EAX: 00000000 EBX: c0476020 ECX: c0100bb0 EDX: 003a2f43
^M^@ESI: d7428000 EDI: c0470300 EBP: c0470300 DS: 007b ES: 007b
^M^@CR0: 8005003b CR2: b7f30d9c CR3: 00474000 CR4: 000006b0
^M^@ [<c0100ca3>] cpu_idle+0x7b/0x8c
^M^@ [<c010e79d>]Uhhuh. NMI received for unknown reason 00 on CPU 13.
^M^@ start_secondary+0x13d/0x140
^M^@ Do you have a strange power saving mode enabled?
^M^@----------- IPI show regs -----------Uhhuh. NMI received for unknown reason 00 on CPU 8.
^M^@Uhhuh. NMI received for unknown reason 00 on CPU 11.
^M^@Dazed and confused, but trying to continue
^M^@Dazed and confused, but trying to continue
^M^@Dazed and confused, but trying to continue
^M
^M^@Pid: 0, comm:              swapper
^M^@EIP: 0060:[<c0100bd3>] CPU: 20
^M^@Dazed and confused, but trying to continue
^M^@Uhhuh. NMI received for unknown reason 00 on CPU 22.
^M^@Uhhuh. NMI received for unknown reason 00 on CPU 26.
^M^@EIP is at default_idle+0x23/0x2c
^M^@ EFLAGS: 00000246    Not tainted  (2.6.12-rc6-mm1-autokern1)
^M^@EAX: 00000000 EBX: c0476020 ECX: c0100bb0 EDX: 003a2f43
^M^@Dazed and confused, but trying to continue
^M^@Do you have a strange power saving mode enabled?
^M^@Dazed and confused, but trying to continue
^M^@Do you have a strange power saving mode enabled?
^M^@ESI: d742a000 EDI: c0470300 EBP: c0470300Uhhuh. NMI received for unknown reason 00 on CPU 30.
^M^@Dazed and confused, but trying to continue
^M^@Do you have a strange power saving mode enabled?
^M^@Do you have a strange power saving mode enabled?
^M^@Do you have a strange power saving mode enabled?
^M^@ DS: 007b ES: 007b
^M^@CR0: 8005003b CR2: 00000000 CR3: 00474000 CR4: 000006b0
^M^@Uhhuh. NMI received for unknown reason 00 on CPU 21.
^M^@ [<c0100ca3>]Dazed and confused, but trying to continue
^M^@Do you have a strange power saving mode enabled?
^M^@Dazed and confused, but trying to continue
^M^@Do you have a strange power saving mode enabled?
^M^@ cpu_idle+0x7b/0x8c
^M^@Dazed and confused, but trying to continue
^M^@ [<c010e79d>]Do you have a strange power saving mode enabled?
^M^@ start_secondary+0x13d/0x140
^M^@Do you have a strange power saving mode enabled?
^M^@Uhhuh. NMI received for unknown reason 00 on CPU 27.
^M^@Dazed and confused, but trying to continue
^M^@Do you have a strange power saving mode enabled?
^M^@Uhhuh. NMI received for unknown reason 00 on CPU 24.
^M^@ ----------- IPI show regs -----------
^M^@Pid: 11221, comm:                   cp
^M^@EIP: 0060:[<c02efbdc>] CPU: 5
^M^@Do you have a strange power saving mode enabled?
^M^@EIP is at _spin_lock_irqsave+0x14/0x20
^M^@ EFLAGS: 00000286    Not tainted  (2.6.12-rc6-mm1-autokern1)
^M^@Dazed and confused, but trying to continue
^M^@EAX: 00000286 EBX: d6ce4800 ECX: c03cabe0 EDX: c049ba84
^M^@ESI: ffffffea EDI: d55f8000 EBP: d55f8000 DS: 007b ES: 007b
^M^@Dazed and confused, but trying to continue
^M^@Do you have a strange power saving mode enabled?
^M^@Dazed and confused, but trying to continue
^M^@Do you have a strange power saving mode enabled?
^M^@Dazed and confused, but trying to continue
^M^@CR0: 80050033 CR2: bfc7d2fc CR3: 16dd02e0 CR4: 000006b0
^M^@ [<c0270377>]Uhhuh. NMI received for unknown reason 00 on CPU 31.
^M^@Uhhuh. NMI received for unknown reason 00 on CPU 12.
^M^@ ahc_linux_proc_info+0x27/0x212
^M^@Do you have a strange power saving mode enabled?
^M^@Do you have a strange power saving mode enabled?
^M^@ [<c0149052>]Do you have a strange power saving mode enabled?
^M^@Dazed and confused, but trying to continue
^M^@Do you have a strange power saving mode enabled?
^M^@ page_add_anon_rmap+0x62/0x68
^M^@ [<c0144358>]Dazed and confused, but trying to continue
^M^@Do you have a strange power saving mode enabled?
^M^@Uhhuh. NMI received for unknown reason 00 on CPU 15.
^M^@Uhhuh. NMI received for unknown reason 00 on CPU 28.
^M^@Dazed and confused, but trying to continue
^M^@ do_anonymous_page+0x1f0/0x21c
^M^@ [<c0144370>]Dazed and confused, but trying to continue
^M^@Do you have a strange power saving mode enabled?
^M^@ do_anonymous_page+0x208/0x21c
^M^@Dazed and confused, but trying to continue
^M^@ [<c01443d9>]Do you have a strange power saving mode enabled?
^M^@Dazed and confused, but trying to continue
^M^@Do you have a strange power saving mode enabled?
^M^@Do you have a strange power saving mode enabled?
^M^@ do_no_page+0x55/0x3e8
^M^@ [<c01372b5>] prep_new_page+0x49/0x50
^M^@ [<c0137973>] buffered_rmqueue+0x16f/0x1d0
^M^@ [<c0137e1b>] __alloc_pages+0x3bb/0x3c8
^M^@ [<c0257cdb>] proc_scsi_read+0x2b/0x44
^M^@ [<c0182f28>] proc_file_read+0xec/0x200
^M^@ [<c0152ff9>] vfs_read+0x91/0x12c
^M^@ [<c01532e4>] sys_read+0x40/0x6c
^M^@ [<c0102a19>] syscall_call+0x7/0xb
^M^@ ----------- IPI show regs -----------
^M^@Pid: 0, comm:              swapper
^M^@EIP: 0060:[<c0100bd3>] CPU: 7
^M^@EIP is at default_idle+0x23/0x2c
^M^@ EFLAGS: 00000246    Not tainted  (2.6.12-rc6-mm1-autokern1)
^M^@EAX: 00000000 EBX: c0476020 ECX: c0100bb0 EDX: 003a2f43
^M^@ESI: d740c000 EDI: c0470300 EBP: c0470300 DS: 007b ES: 007b
^M^@CR0: 8005003b CR2: 00000000 CR3: 00474000 CR4: 000006b0
^M^@ [<c0100ca3>] cpu_idle+0x7b/0x8c
^M^@ [<c010e79d>] start_secondary+0x13d/0x140
^M^@ ----------- IPI show regs -----------
^M^@Pid: 0, comm:              swapper
^M^@EIP: 0060:[<c0100bd3>] CPU: 4
^M^@EIP is at default_idle+0x23/0x2c
^M^@ EFLAGS: 00000246    Not tainted  (2.6.12-rc6-mm1-autokern1)
^M^@EAX: 00000000 EBX: c0476020 ECX: c0100bb0 EDX: 003a2f43
^M^@ESI: d7404000 EDI: c0470300 EBP: c0470300 DS: 007b ES: 007b
^M^@CR0: 8005003b CR2: 080f9c48 CR3: 17771320 CR4: 000006b0
^M^@ [<c0100ca3>] cpu_idle+0x7b/0x8c
^M^@ [<c010e79d>] start_secondary+0x13d/0x140
^M^@ ----------- IPI show regs -----------
^M^@Pid: 0, comm:              swapper
^M^@EIP: 0060:[<c02efcae>] CPU: 30
^M^@EIP is at _spin_lock+0xa/0x10
^M^@ EFLAGS: 00000046    Not tainted  (2.6.12-rc6-mm1-autokern1)
^M^@EAX: c1050aa0 EBX: c1050aa0 ECX: d7463ea8 EDX: 00000003
^M^@ESI: c10d9620 EDI: c10d9fe0 EBP: d7463eb0 DS: 007b ES: 007b
^M^@CR0: 8005003b CR2: b7eea900 CR3: 00474000 CR4: 000006b0
^M^@ [<c011583b>] load_balance+0xcf/0x170
^M^@ [<c0115af5>] rebalance_tick+0xe1/0x104
^M^@ [<c0115d77>] scheduler_tick+0x97/0x318
^M^@ [<c01225b3>] update_process_times+0xef/0x100
^M^@ [<c010f5f9>] smp_apic_timer_interrupt+0xd5/0xe4
^M^@ [<c0103464>] apic_timer_interrupt+0x1c/0x24
^M^@ [<c0100bb0>] default_idle+0x0/0x2c
^M^@ [<c0100bd3>] default_idle+0x23/0x2c
^M^@ [<c0100ca3>] cpu_idle+0x7b/0x8c
^M^@ [<c010e79d>] start_secondary+0x13d/0x140
^M^@----------- IPI show regs ----------- 
^M^@Pid: 0, comm:              swapper
^M^@EIP: 0060:[<c02efb6a>] CPU: 15
^M^@EIP is at _spin_trylock+0x6/0x14
^M^@ EFLAGS: 00000046    Not tainted  (2.6.12-rc6-mm1-autokern1)
^M^@EAX: 00000000 EBX: c1050aa0 ECX: 00000008 EDX: c1050aa0
^M^@ESI: c10875a0 EDI: c1087f60 EBP: d741fe84 DS: 007b ES: 007b
^M^@CR0: 8005003b CR2: 00000000 CR3: 00474000 CR4: 000006b0
^M^@ [<c0114fda>] double_lock_balance+0x12/0x48
^M^@ [<c01157e4>] load_balance+0x78/0x170
^M^@ [<c0115af5>] rebalance_tick+0xe1/0x104
^M^@ [<c0115d77>] scheduler_tick+0x97/0x318
^M^@ [<c01225b3>] update_process_times+0xef/0x100
^M^@ [<c010f5f9>] smp_apic_timer_interrupt+0xd5/0xe4
^M^@ [<c0103464>] apic_timer_interrupt+0x1c/0x24
^M^@ [<c0100bb0>] default_idle+0x0/0x2c
^M^@ [<c0100bd3>] default_idle+0x23/0x2c
^M^@ [<c0100ca3>] cpu_idle+0x7b/0x8c
^M^@ [<c010e79d>] start_secondary+0x13d/0x140
^M^@ ----------- IPI show regs -----------
^M^@Pid: 0, comm:              swapper
^M^@EIP: 0060:[<c0100bd3>] CPU: 21
^M^@EIP is at default_idle+0x23/0x2c
^M^@ EFLAGS: 00000246    Not tainted  (2.6.12-rc6-mm1-autokern1)
^M^@EAX: 00000000 EBX: c0476020 ECX: c0100bb0 EDX: 003a2f43
^M^@ESI: d742c000 EDI: c0470300 EBP: c0470300 DS: 007b ES: 007b
^M^@CR0: 8005003b CR2: 00000000 CR3: 00474000 CR4: 000006b0
^M^@ [<c0100ca3>] cpu_idle+0x7b/0x8c
^M^@ [<c010e79d>] start_secondary+0x13d/0x140
^M^@ ----------- IPI show regs -----------
^M^@Pid: 0, comm:              swapper
^M^@EIP: 0060:[<c0100bd3>] CPU: 14
^M^@EIP is at default_idle+0x23/0x2c
^M^@ EFLAGS: 00000246    Not tainted  (2.6.12-rc6-mm1-autokern1)
^M^@EAX: 00000000 EBX: c0476020 ECX: c0100bb0 EDX: 003a2f43
^M^@ESI: d741c000 EDI: c0470300 EBP: c0470300 DS: 007b ES: 007b
^M^@CR0: 8005003b CR2: b7e64070 CR3: 00474000 CR4: 000006b0
^M^@ [<c0100ca3>] cpu_idle+0x7b/0x8c
^M^@ [<c010e79d>] start_secondary+0x13d/0x140
^M^@ ----------- IPI show regs -----------
^M^@Pid: 0, comm:              swapper
^M^@EIP: 0060:[<c0100bd3>] CPU: 27
^M^@EIP is at default_idle+0x23/0x2c
^M^@ EFLAGS: 00000246    Not tainted  (2.6.12-rc6-mm1-autokern1)
^M^@EAX: 00000000 EBX: c0476020 ECX: c0100bb0 EDX: 003a2f43
^M^@ESI: d745c000 EDI: c0470300 EBP: c0470300 DS: 007b ES: 007b
^M^@CR0: 8005003b CR2: b7f66d9c CR3: 00474000 CR4: 000006b0
^M^@ [<c0100ca3>] cpu_idle+0x7b/0x8c
^M^@ [<c010e79d>] start_secondary+0x13d/0x140
^M^@ ----------- IPI show regs -----------
^M^@Pid: 0, comm:              swapper
^M^@EIP: 0060:[<c0100bd3>] CPU: 8
^M^@EIP is at default_idle+0x23/0x2c
^M^@ EFLAGS: 00000246    Not tainted  (2.6.12-rc6-mm1-autokern1)
^M^@EAX: 00000000 EBX: c0476020 ECX: c0100bb0 EDX: 003a2f43
^M^@ESI: d740e000 EDI: c0470300 EBP: c0470300 DS: 007b ES: 007b
^M^@CR0: 8005003b CR2: 080f133c CR3: 00474000 CR4: 000006b0
^M^@ [<c0100ca3>] cpu_idle+0x7b/0x8c
^M^@ [<c010e79d>] start_secondary+0x13d/0x140
^M^@ ----------- IPI show regs -----------
^M^@Pid: 0, comm:              swapper
^M^@EIP: 0060:[<c0100bd3>] CPU: 25
^M^@EIP is at default_idle+0x23/0x2c
^M^@ EFLAGS: 00000246    Not tainted  (2.6.12-rc6-mm1-autokern1)
^M^@EAX: 00000000 EBX: c0476020 ECX: c0100bb0 EDX: 003a2f43
^M^@ESI: d7436000 EDI: c0470300 EBP: c0470300 DS: 007b ES: 007b
^M^@CR0: 8005003b CR2: b7f74d9c CR3: 00474000 CR4: 000006b0
^M^@ [<c0100ca3>] cpu_idle+0x7b/0x8c
^M^@ [<c010e79d>] start_secondary+0x13d/0x140
^M^@ ----------- IPI show regs -----------
^M^@Pid: 0, comm:              swapper
^M^@EIP: 0060:[<c02efb6a>] CPU: 29
^M^@EIP is at _spin_trylock+0x6/0x14
^M^@ EFLAGS: 00000046    Not tainted  (2.6.12-rc6-mm1-autokern1)
^M^@EAX: 00000001 EBX: c1050aa0 ECX: 00000008 EDX: c1050aa0
^M^@ESI: c10d3ea0 EDI: c10d4860 EBP: d7461e84 DS: 007b ES: 007b
^M^@CR0: 8005003b CR2: 00000000 CR3: 00474000 CR4: 000006b0
^M^@ [<c0114fda>] double_lock_balance+0x12/0x48
^M^@ [<c01157e4>] load_balance+0x78/0x170
^M^@ [<c0115af5>] rebalance_tick+0xe1/0x104
^M^@ [<c0115d77>] scheduler_tick+0x97/0x318
^M^@ [<c01225b3>] update_process_times+0xef/0x100
^M^@ [<c010f5f9>] smp_apic_timer_interrupt+0xd5/0xe4
^M^@ [<c0103464>] apic_timer_interrupt+0x1c/0x24
^M^@ [<c0100bb0>] default_idle+0x0/0x2c
^M^@ [<c0100bd3>] default_idle+0x23/0x2c
^M^@ [<c0100ca3>] cpu_idle+0x7b/0x8c
^M^@ [<c010e79d>] start_secondary+0x13d/0x140
^M^@ ----------- IPI show regs -----------
^M^@Pid: 0, comm:              swapper
^M^@EIP: 0060:[<c0100bd3>] CPU: 31
^M^@EIP is at default_idle+0x23/0x2c
^M^@ EFLAGS: 00000246    Not tainted  (2.6.12-rc6-mm1-autokern1)
^M^@EAX: 00000000 EBX: c0476020 ECX: c0100bb0 EDX: 003a2f43
^M^@ESI: d7464000 EDI: c0470300 EBP: c0470300 DS: 007b ES: 007b
^M^@CR0: 8005003b CR2: 00000000 CR3: 00474000 CR4: 000006b0
^M^@ [<c0100ca3>] cpu_idle+0x7b/0x8c
^M^@ [<c010e79d>] start_secondary+0x13d/0x140
^M^@----------- IPI show regs -----------
^M^@Pid: 0, comm:              swapper
^M^@EIP: 0060:[<c0100bd3>] CPU: 24
^M^@EIP is at default_idle+0x23/0x2c
^M^@  EFLAGS: 00000246    Not tainted  (2.6.12-rc6-mm1-autokern1)
^M^@EAX: 00000000 EBX: c0476020 ECX: c0100bb0 EDX: 003a2f43
^M^@ESI: d7434000 EDI: c0470300 EBP: c0470300 DS: 007b ES: 007b
^M^@CR0: 8005003b CR2: b7f3cdd8 CR3: 00474000 CR4: 000006b0
^M^@ [<c0100ca3>] cpu_idle+0x7b/0x8c
^M^@ [<c010e79d>] start_secondary+0x13d/0x140
^M^@ ----------- IPI show regs -----------
^M^@Pid: 0, comm:              swapper
^M^@EIP: 0060:[<c0100bd3>] CPU: 10
^M^@EIP is at default_idle+0x23/0x2c
^M^@ EFLAGS: 00000246    Not tainted  (2.6.12-rc6-mm1-autokern1)
^M^@EAX: 00000000 EBX: c0476020 ECX: c0100bb0 EDX: 003a2f43
^M^@ESI: d7412000 EDI: c0470300 EBP: c0470300 DS: 007b ES: 007b
^M^@CR0: 8005003b CR2: b7ea6920 CR3: 00474000 CR4: 000006b0
^M^@ [<c0100ca3>] cpu_idle+0x7b/0x8c
^M^@ [<c010e79d>] start_secondary+0x13d/0x140
^M^@ ----------- IPI show regs -----------
^M^@Pid: 0, comm:              swapper
^M^@EIP: 0060:[<c0100bd3>] CPU: 26
^M^@EIP is at default_idle+0x23/0x2c
^M^@ EFLAGS: 00000246    Not tainted  (2.6.12-rc6-mm1-autokern1)
^M^@EAX: 00000000 EBX: c0476020 ECX: c0100bb0 EDX: 003a2f43
^M^@ESI: d7438000 EDI: c0470300 EBP: c0470300 DS: 007b ES: 007b
^M^@CR0: 8005003b CR2: 00000000 CR3: 00474000 CR4: 000006b0
^M^@ [<c0100ca3>] cpu_idle+0x7b/0x8c
^M^@ [<c010e79d>] start_secondary+0x13d/0x140
^M^@ ----------- IPI show regs -----------
^M^@Pid: 0, comm:              swapper
^M^@EIP: 0060:[<c01154a3>] CPU: 13
^M^@EIP is at find_busiest_group+0x103/0x2f8
^M^@ EFLAGS: 00000086    Not tainted  (2.6.12-rc6-mm1-autokern1)
^M^@EAX: 00000005 EBX: 00000005 ECX: c1050aa0 EDX: 00000000
^M^@ESI: c04813ac EDI: 00000200 EBP: d741be7c DS: 007b ES: 007b
^M^@CR0: 8005003b CR2: b7e7e070 CR3: 00474000 CR4: 000006b0
^M^@ [<c01157a2>] load_balance+0x36/0x170
^M^@ [<c0115af5>] rebalance_tick+0xe1/0x104
^M^@ [<c0115d77>] scheduler_tick+0x97/0x318
^M^@ [<c01225b3>] update_process_times+0xef/0x100
^M^@ [<c010f5f9>] smp_apic_timer_interrupt+0xd5/0xe4
^M^@ [<c0103464>] apic_timer_interrupt+0x1c/0x24
^M^@ [<c0100bb0>] default_idle+0x0/0x2c
^M^@ [<c0100bd3>] default_idle+0x23/0x2c
^M^@ [<c0100ca3>] cpu_idle+0x7b/0x8c
^M^@ [<c010e79d>] start_secondary+0x13d/0x140
^M^@ ----------- IPI show regs -----------
^M^@Pid: 0, comm:              swapper
^M^@EIP: 0060:[<c0100bd3>] CPU: 28
^M^@EIP is at default_idle+0x23/0x2c
^M^@ EFLAGS: 00000246    Not tainted  (2.6.12-rc6-mm1-autokern1)
^M^@EAX: 00000000 EBX: c0476020 ECX: c0100bb0 EDX: 003a2f43
^M^@ESI: d745e000 EDI: c0470300 EBP: c0470300 DS: 007b ES: 007b
^M^@CR0: 8005003b CR2: 00000000 CR3: 00474000 CR4: 000006b0
^M^@ [<c0100ca3>] cpu_idle+0x7b/0x8c
^M^@ [<c010e79d>] start_secondary+0x13d/0x140
^M^@ ----------- IPI show regs -----------
^M^@Pid: 0, comm:              swapper
^M^@EIP: 0060:[<c011e897>] CPU: 12
^M^@EIP is at __do_softirq+0x47/0x100
^M^@ EFLAGS: 00000006    Not tainted  (2.6.12-rc6-mm1-autokern1)
^M^@EAX: c0470380 EBX: c0476020 ECX: 00000030 EDX: c1075ce0
^M^@ESI: 00000002 EDI: c0470300 EBP: c0470300 DS: 007b ES: 007b
^M^@CR0: 8005003b CR2: b7f54000 CR3: 00474000 CR4: 000006b0
^M^@ [<c011e97f>] do_softirq+0x2f/0x34
^M^@ [<c011ea24>] irq_exit+0x34/0x38
^M^@ [<c010f601>] smp_apic_timer_interrupt+0xdd/0xe4
^M^@ [<c0103464>] apic_timer_interrupt+0x1c/0x24
^M^@ [<c0100bb0>] default_idle+0x0/0x2c
^M^@ [<c0100bd3>] default_idle+0x23/0x2c
^M^@ [<c0100ca3>] cpu_idle+0x7b/0x8c
^M^@ [<c010e79d>] start_secondary+0x13d/0x140
^M^@ ----------- IPI show regs -----------
^M^@Pid: 0, comm:              swapper
^M^@EIP: 0060:[<c0100bd3>] CPU: 9
^M^@EIP is at default_idle+0x23/0x2c
^M^@ EFLAGS: 00000246    Not tainted  (2.6.12-rc6-mm1-autokern1)
^M^@EAX: 00000000 EBX: c0476020 ECX: c0100bb0 EDX: 003a2f43
^M^@ESI: d7410000 EDI: c0470300 EBP: c0470300 DS: 007b ES: 007b
^M^@CR0: 8005003b CR2: b7f1d900 CR3: 00474000 CR4: 000006b0
^M^@ [<c0100ca3>] cpu_idle+0x7b/0x8c
^M^@ [<c010e79d>] start_secondary+0x13d/0x140
^M^@----------- IPI show regs -----------
^M^@Pid: 0, comm:              swapper
^M^@EIP: 0060:[<c0100bd3>] CPU: 11
^M^@ EIP is at default_idle+0x23/0x2c
^M^@ EFLAGS: 00000246    Not tainted  (2.6.12-rc6-mm1-autokern1)
^M^@EAX: 00000000 EBX: c0476020 ECX: c0100bb0 EDX: 003a2f43
^M^@ESI: d7414000 EDI: c0470300 EBP: c0470300 DS: 007b ES: 007b
^M^@CR0: 8005003b CR2: 00000000 CR3: 00474000 CR4: 000006b0
^M^@ [<c0100ca3>] cpu_idle+0x7b/0x8c
^M^@ [<c010e79d>] start_secondary+0x13d/0x140
^M^@ ----------- IPI show regs -----------
^M^@Pid: 0, comm:              swapper
^M^@EIP: 0060:[<c0100bd3>] CPU: 23
^M^@EIP is at default_idle+0x23/0x2c
^M^@ EFLAGS: 00000246    Not tainted  (2.6.12-rc6-mm1-autokern1)
^M^@EAX: 00000000 EBX: c0476020 ECX: c0100bb0 EDX: 003a2f43
^M^@ESI: d7432000 EDI: c0470300 EBP: c0470300 DS: 007b ES: 007b
^M^@CR0: 8005003b CR2: 00000000 CR3: 00474000 CR4: 000006b0
^M^@ [<c0100ca3>] cpu_idle+0x7b/0x8c
^M^@ [<c010e79d>] start_secondary+0x13d/0x140
^M^@----------- IPI show regs ----------- 
^M^@Pid: 0, comm:              swapper
^M^@EIP: 0060:[<c0100bd3>] CPU: 6
^M^@EIP is at default_idle+0x23/0x2c
^M^@ EFLAGS: 00000246    Not tainted  (2.6.12-rc6-mm1-autokern1)
^M^@EAX: 00000000 EBX: c0476020 ECX: c0100bb0 EDX: 003a2f43
^M^@ESI: d7408000 EDI: c0470300 EBP: c0470300 DS: 007b ES: 007b
^M^@CR0: 8005003b CR2: b7f3cdd8 CR3: 00474000 CR4: 000006b0
^M^@ [<c0100ca3>] cpu_idle+0x7b/0x8c
^M^@ [<c010e79d>] start_secondary+0x13d/0x140
^M^@----------- IPI show regs ----------- 
^M^@Pid: 0, comm:              swapper
^M^@EIP: 0060:[<c0100bd3>] CPU: 22
^M^@EIP is at default_idle+0x23/0x2c
^M^@ EFLAGS: 00000246    Not tainted  (2.6.12-rc6-mm1-autokern1)
^M^@EAX: 00000000 EBX: c0476020 ECX: c0100bb0 EDX: 003a2f43
^M^@ESI: d7430000 EDI: c0470300 EBP: c0470300 DS: 007b ES: 007b
^M^@CR0: 8005003b CR2: 00000000 CR3: 00474000 CR4: 000006b0
^M^@ [<c0100ca3>] cpu_idle+0x7b/0x8c
^M^@ [<c010e79d>] start_secondary+0x13d/0x140
^M^@ Dazed and confused, but trying to continue
^M^@Do you have a strange power saving mode enabled?
^M^@----------- IPI show regs -----------
^M^@Pid: 0, comm:              swapper
^M^@EIP: 0060:[<c0100bd3>] CPU: 1
^M^@EIP is at default_idle+0x23/0x2c
^M^@ EFLAGS: 00000246    Not tainted  (2.6.12-rc6-mm1-autokern1)
^M^@EAX: 00000000 EBX: c0476020 ECX: c0100bb0 EDX: 003a2f43
^M^@ESI: c13fc000 EDI: c0470300 EBP: c0470300 DS: 007b ES: 007b
^M^@CR0: 8005003b CR2: b7ee1d9c CR3: 17771640 CR4: 000006b0
^M^@ [<c0100ca3>] cpu_idle+0x7b/0x8c
^M^@ [<c010e79d>] start_secondary+0x13d/0x140
^M^@ ^M





