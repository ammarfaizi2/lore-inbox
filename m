Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261455AbUKWSXD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261455AbUKWSXD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Nov 2004 13:23:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261492AbUKWSWG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Nov 2004 13:22:06 -0500
Received: from potato.cts.ucla.edu ([149.142.36.49]:30375 "EHLO
	potato.cts.ucla.edu") by vger.kernel.org with ESMTP id S261455AbUKWSSH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Nov 2004 13:18:07 -0500
Date: Tue, 23 Nov 2004 10:17:57 -0800 (PST)
From: Chris Stromsoe <cbs@cts.ucla.edu>
To: linux-kernel@vger.kernel.org
Subject: Re: deadlock also with 2.6.9 nosmp, and 2.6.10-rc1 nosmp, was Re:
 deadlock with 2.6.9
In-Reply-To: <Pine.LNX.4.61.0411191853180.17611@potato.cts.ucla.edu>
Message-ID: <Pine.LNX.4.61.0411231007080.14244@potato.cts.ucla.edu>
References: <Pine.LNX.4.61.0411012112450.24956@potato.cts.ucla.edu>
 <Pine.LNX.4.61.0411040836270.19741@potato.cts.ucla.edu>
 <Pine.LNX.4.61.0411061413390.1115@potato.cts.ucla.edu>
 <Pine.LNX.4.61.0411191853180.17611@potato.cts.ucla.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I managed to get access to the system while it was exhibiting the problem. 
There are two cron processes both in D state.  I was not able to attach to 
either process with gdb.  /proc/pid/wchan showed do_fork for both 
processes.

I was able to 'killall -9 cron' and kill all of the cron tasks.

I had several other processes that /proc/pid/wchan showed in 
unix_wait_for_peer (sshd), futex_wait (syslogd), and do_exit (zombie 
sshd).

When I killed syslogd, the zombie sshd processes disappeared and 
everything started magically working again.


-Chris

On Fri, 19 Nov 2004, Chris Stromsoe wrote:

> I am still seeing this with 2.6.9 nosmp and with 2.6.10-rc1 nosmp.  The 
> symptoms are the same.  Every so often, things stop forking.  sysrq+t 
> shows almost every running process in schedule_timeout.  It seems to 
> happen every few days.
>
> The system is a syslog collector for >100 devices that log everything at 
> debug level.  Every 3 or 4 days (twice a week) it writes all of the logs 
> to dvd using growisofs.
>
> Every few days -- maybe 3 or 4, but not tied in any way that I can see 
> to the dvd writing -- the system becomes unresponsive; nothing forks. 
> I can use sysrq+e and sysrq+i to kill everything and then regain console 
> access and restart everything through /etc/rc*.d/* manually.  Life 
> continues on until the next hang.
>
> I have had the same problem with 2.6.8.1 smp, 2.6.9 smp, 2.6.9 smp 
> booted with nosmp, and now 2.6.10-rc1 smp booted with nosmp.
>
> I'm not sure where to look next.  This is fairly reproducible; it just 
> takes a few days.
>
>
> -Chris
>
>
> On Sat, 6 Nov 2004, Chris Stromsoe wrote:
>
>> I had a third lockup, this time not related to burning a dvd.  As before, 
>> the bulk of the processes that were hung were cron, and looked like:
>> 
>> cron          S C1205F60     0  5023    444          5036  5022 (NOTLB)
>> c721ec9c 00000082 cd1b27f0 c1205f60 ca82ab7c c252a97c c721ec94 c014584e
>>       c252a940 c1fe8900 b7fe7000 ce607150 c1205f60 00239d5b fac8e72b 
>> 00003496
>>       cd1b2950 cf9b1d40 7fffffff 00000001 c721ecd8 c02f9f04 b7fe7000 
>> 00000001
>> Call Trace:
>> [<c02f9f04>] schedule_timeout+0xb4/0xc0
>> [<c02ef86e>] unix_wait_for_peer+0xbe/0xd0
>> [<c02f028a>] unix_dgram_sendmsg+0x26a/0x500
>> [<c0293cab>] sock_sendmsg+0xbb/0xe0
>> [<c0295161>] sys_sendto+0xe1/0x100
>> [<c02951b2>] sys_send+0x32/0x40
>> [<c0295a1a>] sys_socketcall+0x13a/0x250
>> [<c0104383>] syscall_call+0x7/0xb
>> 
>> 
>> Full sysrq+t dump is at <http://hashbrown.cts.ucla.edu/deadlock/>.
>> 
>> 
>> Several others that were in the same state:
>> 
>> sendmail-mta  S C1205F60     0   416      1           434   334 (NOTLB)
>> ceaaceac 00000082 00000000 c1205f60 c12068c0 ceaacf44 ceaace84 c0139bb5
>>       cfba6b80 00000246 ceaaceac c01236d6 c1205f60 00005a1e cb12fa34 
>> 0000acdf
>>       ce9f97f0 0b4fcb33 ceaacec0 00000007 ceaacee8 c02f9eb5 ceaacec0 
>> 0b4fcb33
>> Call Trace:
>> [<c02f9eb5>] schedule_timeout+0x65/0xc0
>> [<c01671ee>] do_select+0x16e/0x2a0
>> [<c016760e>] sys_select+0x2ae/0x4c0
>> [<c0104383>] syscall_call+0x7/0xb
>> 
>> 
>> ntpd          S C1205F60     0   434      1           437   416 (NOTLB)
>> cf7e1eac 00000086 00000000 c1205f60 c12068c0 00000010 c034eb80 00000000
>>       cfba6700 bffffa10 000000d0 cfb1a2e0 c1205f60 000008d0 0c7e1cd2 
>> 0000ace0
>>       ce9f87d0 00000000 7fffffff 00000008 cf7e1ee8 c02f9f04 00000246 
>> cf7e1ed0
>> Call Trace:
>> [<c02f9f04>] schedule_timeout+0xb4/0xc0
>> [<c01671ee>] do_select+0x16e/0x2a0
>> [<c016760e>] sys_select+0x2ae/0x4c0
>> [<c0104383>] syscall_call+0x7/0xb
>> 
>> 
>> mdadm         S C1205F60     0   437      1           440   434 (NOTLB)
>> cf707eac 00000086 00000000 c1205f60 c12068c0 cfb3c610 00000003 00000000
>>       cf8204c0 00000246 cf707eac c01236d6 c1205f60 00000448 b1f651f9 
>> 0000acd3
>>       cfb3d790 0b4fd705 cf707ec0 00000005 cf707ee8 c02f9eb5 cf707ec0 
>> 0b4fd705
>> Call Trace:
>> [<c02f9eb5>] schedule_timeout+0x65/0xc0
>> [<c01671ee>] do_select+0x16e/0x2a0
>> [<c016760e>] sys_select+0x2ae/0x4c0
>> [<c0104383>] syscall_call+0x7/0xb
>> 
>> 
>> 
>> atd           S C1205F60     0   440      1           444   437 (NOTLB)
>> ce5e0f48 00000082 00000000 c1205f60 c12068c0 00000000 00000000 00000000
>>       cfba6280 00000246 ce5e0f48 c01236d6 c1205f60 00006970 daf6df4d 
>> 0000aa54
>>       ce9f8270 0b5bfcbc ce5e0f5c 000f41a7 ce5e0f84 c02f9eb5 ce5e0f5c 
>> 0b5bfcbc
>> Call Trace:
>> [<c02f9eb5>] schedule_timeout+0x65/0xc0
>> [<c01243ce>] sys_nanosleep+0xde/0x160
>> [<c0104383>] syscall_call+0x7/0xb
>> 
>> 
>> 
>> The box is P3 SMP, 256Mb ram, dual Intel eepro100 controllers, bonded into 
>> a single failover device.  The box is a syslog server for ~100 different 
>> other machines logging at debug level.  UDP traffic is constant.  syslog 
>> logs to a stripe of two mirrors, built with mdadm.
>> 
>> Each of the three hangs has been exactly the same.  Nothing forks, but I 
>> can use sysrq to dump the process table, or to kill everything, log in, and 
>> restart.
>> 
>> After I logged in today, all of the partitions were mounted ro, and one of 
>> the mirrors had kicked a partition out.  Tests on the partition and the 
>> disk that it's on so far show no errors.
>> 
>> What would cause everything on the box to hang in schedule_timeout?
>> 
>> 
>> -Chris
>> 
>> On Thu, 4 Nov 2004, Chris Stromsoe wrote:
>> 
>>> I had another deadlock after the completion of a dvd writing session last 
>>> night.  The dvd was written using the ide interface with growisof.
>>> 
>>> sysrq+p, sysrq+m, and a partial sysrq+t are at 
>>> http://hashbrown.cts.ucla.edu/deadlock/sysrq+t-20041104.
>>> 
>>> Virtually everything is stuck in schedule_timeout+0xb4/0xc0.  It looks 
>>> very similar to the last deadlock I had (sysrq+t output is in the same 
>>> directory as the above as sysrq+t-20041101).
>>> 
>>> cbs:~ > lsmod
>>> Module                  Size  Used by
>>> ide_cd                 39328  0
>>> cdrom                  38460  1 ide_cd
>>> e100                   29760  0
>>> bonding                64552  0
>>> 
>>> Any ideas?  Anything in particular to check?
>>> 
>>> 
>>> -Chris
>>> 
>>> On Mon, 1 Nov 2004, Chris Stromsoe wrote:
>>> 
>>>> The machine collects remote syslog, roughly 1000 packets per second. The 
>>>> logs are burned to dvd several times per week.  The hanging may have 
>>>> coincided with the completion of one of the log burning sessions. Before 
>>>> the last crash I was using ide-scsi to do the burning.  Since the last 
>>>> crash, I switched over to directly using the ide device and have disabled 
>>>> ide-scsi.
>>>> 
>>>> The machine did not crash.  Remote access with ssh would hang after 
>>>> authentication.  Already running processes that didn't fork anything 
>>>> responded fine to the network.  I could not fork a shell from a serial 
>>>> console.  I was able to use sysrq to pull debugging information.  I was 
>>>> also able to kill off all running processes (sysrq+e and sysrq+i), then 
>>>> log in from the serial console and restart things.
>>>> 
>>>> I had the same problem with 2.6.8.1
>>>> 
>>>> Most of the processes seem to be stuck in schedule_timeout.
>>>> 
>>>> The full sysrq and .config are at http://hashbrown.cts.ucla.edu/deadlock/
>>>> 
>>>> 
>>>> cbs:~ > lsmod
>>>> Module                  Size  Used by
>>>> sg                     35040  0
>>>> sr_mod                 14884  0
>>>> cdrom                  38460  1 sr_mod
>>>> ide_scsi               15332  0
>>>> e100                   29760  0
>>>> bonding                64552  0
>>>> 
>>>> 
>>>> 
>>>> telnet> send brk
>>>> SysRq : Show Regs
>>>> 
>>>> Pid: 0, comm:              swapper
>>>> EIP: 0060:[<c01022cf>] CPU: 0
>>>> EIP is at default_idle+0x2f/0x40
>>>> EFLAGS: 00000246    Not tainted  (2.6.9)
>>>> EAX: 00000000 EBX: c039b000 ECX: c01022a0 EDX: c039b000
>>>> ESI: c04080a0 EDI: c04081a0 EBP: c039bfc4 DS: 007b ES: 007b
>>>> CR0: 8005003b CR2: bffffd66 CR3: 0fb3f000 CR4: 000006d0
>>>> [<c0102516>] show_regs+0x146/0x170
>>>> [<c0207a81>] __handle_sysrq+0x71/0xf0
>>>> [<c021a5aa>] receive_chars+0x11a/0x230
>>>> [<c021a9bd>] serial8250_interrupt+0xdd/0xe0
>>>> [<c0106c96>] handle_IRQ_event+0x36/0x70
>>>> [<c0107063>] do_IRQ+0xe3/0x1b0
>>>> [<c0104cf0>] common_interrupt+0x18/0x20
>>>> [<c010235b>] cpu_idle+0x3b/0x50
>>>> [<c039cb8b>] start_kernel+0x16b/0x190
>>>> [<c0100211>] 0xc0100211
>>>> 
>>>> 
>>>> 
>>>> telnet> send brk
>>>> SysRq : Show Memory
>>>> Mem-info:
>>>> DMA per-cpu:
>>>> cpu 0 hot: low 2, high 6, batch 1
>>>> cpu 0 cold: low 0, high 2, batch 1
>>>> Normal per-cpu:
>>>> cpu 0 hot: low 30, high 90, batch 15
>>>> cpu 0 cold: low 0, high 30, batch 15
>>>> HighMem per-cpu: empty
>>>> 
>>>> Free pages:        1348kB (0kB HighMem)
>>>> Active:26008 inactive:2118 dirty:10 writeback:0 unstable:0 free:337 
>>>> slab:16168 mapped:25917 pagetables:12564
>>>> DMA free:172kB min:32kB low:64kB high:96kB active:160kB inactive:48kB 
>>>> present:16384kB
>>>> protections[]: 0 0 0
>>>> Normal free:1176kB min:480kB low:960kB high:1440kB active:103872kB 
>>>> inactive:8424kB present:245760kB
>>>> protections[]: 0 0 0
>>>> HighMem free:0kB min:128kB low:256kB high:384kB active:0kB inactive:0kB 
>>>> present:0kB
>>>> protections[]: 0 0 0
>>>> DMA: 23*4kB 2*8kB 0*16kB 0*32kB 1*64kB 0*128kB 0*256kB 0*512kB 0*1024kB 
>>>> 0*2048kB 0*4096kB = 172kB
>>>> Normal: 54*4kB 8*8kB 14*16kB 5*32kB 2*64kB 1*128kB 1*256kB 0*512kB 
>>>> 0*1024kB 0*2048kB 0*4096kB = 1176kB
>>>> HighMem: empty
>>>> Swap cache: add 66873, delete 65915, find 54916/55208, race 0+0
>>>> Free swap:       805560kB
>>>> 65536 pages of RAM
>>>> 0 pages of HIGHMEM
>>>> 1786 reserved pages
>>>> 600111 pages shared
>>>> 958 pages swap cached
>>>> 
>>>> 
>>>> 
>>>> 
>>>> cron          S C1205F60     0  2614    435          2628  2613 (NOTLB)
>>>> cde0bc9c 00000082 00000000 c1205f60 c12068c0 c4dba97c cde0bc94 c014584e
>>>>       c4dba940 c57d3468 b7fe7000 00000001 c1205f60 001aff4a d6c5bd65 
>>>> 0003d278
>>>>       c8c5e530 cf9aed40 7fffffff 00000001 cde0bcd8 c02f9f04 b7fe7000 
>>>> 00000001
>>>> Call Trace:
>>>> [<c02f9f04>] schedule_timeout+0xb4/0xc0
>>>> [<c02ef86e>] unix_wait_for_peer+0xbe/0xd0
>>>> [<c02f028a>] unix_dgram_sendmsg+0x26a/0x500
>>>> [<c0293cab>] sock_sendmsg+0xbb/0xe0
>>>> [<c0295161>] sys_sendto+0xe1/0x100
>>>> [<c02951b2>] sys_send+0x32/0x40
>>>> [<c0295a1a>] sys_socketcall+0x13a/0x250
>>>> [<c0104383>] syscall_call+0x7/0xb
>>>> cron          S C1205F60     0  2628    435          2640  2614 (NOTLB)
>>>> cc738c9c 00000086 c8c5e930 c1205f60 c82e1b7c c4dba73c cc738c94 00000000
>>>>       c4dba700 00000007 cc738cac cebb0690 c1205f60 00289ad9 af39036a 
>>>> 0003d2be
>>>>       c8c5ea90 cf9aed40 7fffffff 00000001 cc738cd8 c02f9f04 00000246 
>>>> 000000d0
>>>> Call Trace:
>>>> [<c02f9f04>] schedule_timeout+0xb4/0xc0
>>>> [<c02ef86e>] unix_wait_for_peer+0xbe/0xd0
>>>> [<c02f028a>] unix_dgram_sendmsg+0x26a/0x500
>>>> [<c0293cab>] sock_sendmsg+0xbb/0xe0
>>>> [<c0295161>] sys_sendto+0xe1/0x100
>>>> [<c02951b2>] sys_send+0x32/0x40
>>>> [<c0295a1a>] sys_socketcall+0x13a/0x250
>>>> [<c0104383>] syscall_call+0x7/0xb
>>>> 
>>>> cron          S C1205F60     0  2640    435          2655  2628 (NOTLB)
>>>> c2bfbc9c 00000082 c721b9d0 c1205f60 cd21db7c c4dba07c c2bfbc94 00000000
>>>>       c4dba040 00000007 cf06b200 cebb0690 c1205f60 0027ced4 87b993a6 
>>>> 0003d304
>>>>       c721bb30 cf9aed40 7fffffff 00000001 c2bfbcd8 c02f9f04 c138f6c0 
>>>> c9bdea4c
>>>> Call Trace:
>>>> [<c02f9f04>] schedule_timeout+0xb4/0xc0
>>>> [<c02ef86e>] unix_wait_for_peer+0xbe/0xd0
>>>> [<c02f028a>] unix_dgram_sendmsg+0x26a/0x500
>>>> [<c0293cab>] sock_sendmsg+0xbb/0xe0
>>>> [<c0295161>] sys_sendto+0xe1/0x100
>>>> [<c02951b2>] sys_send+0x32/0x40
>>>> [<c0295a1a>] sys_socketcall+0x13a/0x250
>>>> [<c0104383>] syscall_call+0x7/0xb
>>>> sshd          S C1205F60     0  2653   1410          2654 17528 (NOTLB)
>>>> c163dc9c 00000086 c721b470 c1205f60 00000000 00000000 00000000 00000000
>>>>       c4dba4c0 00000007 cf06b560 c721af10 c1205f60 00039ddd 67910d34 
>>>> 0003d32a
>>>>       c721b5d0 cf9aed40 7fffffff 00000001 c163dcd8 c02f9f04 c138f6c0 
>>>> c9bdea4c
>>>> Call Trace:
>>>> [<c02f9f04>] schedule_timeout+0xb4/0xc0
>>>> [<c02ef86e>] unix_wait_for_peer+0xbe/0xd0
>>>> [<c02f028a>] unix_dgram_sendmsg+0x26a/0x500
>>>> [<c0293cab>] sock_sendmsg+0xbb/0xe0
>>>> [<c0295161>] sys_sendto+0xe1/0x100
>>>> [<c02951b2>] sys_send+0x32/0x40
>>>> [<c0295a1a>] sys_socketcall+0x13a/0x250
>>>> [<c0104383>] syscall_call+0x7/0xb
>>>> 
>>>> 
>>>> 
>>>> 
>>>> 
>>>> -Chris
>>>> -
>>>> To unsubscribe from this list: send the line "unsubscribe linux-kernel" 
>>>> in
>>>> the body of a message to majordomo@vger.kernel.org
>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>> Please read the FAQ at  http://www.tux.org/lkml/
>>>> 
>>> -
>>> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>> Please read the FAQ at  http://www.tux.org/lkml/
>>> 
>> -
>> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> Please read the FAQ at  http://www.tux.org/lkml/
>> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
