Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262296AbUKDRCV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262296AbUKDRCV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 12:02:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262292AbUKDRCV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 12:02:21 -0500
Received: from potato.cts.ucla.edu ([149.142.36.49]:63209 "EHLO
	potato.cts.ucla.edu") by vger.kernel.org with ESMTP id S262296AbUKDRBk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 12:01:40 -0500
Date: Thu, 4 Nov 2004 09:01:39 -0800 (PST)
From: Chris Stromsoe <cbs@cts.ucla.edu>
To: linux-kernel@vger.kernel.org
Subject: Re: deadlock with 2.6.9
In-Reply-To: <Pine.LNX.4.61.0411012112450.24956@potato.cts.ucla.edu>
Message-ID: <Pine.LNX.4.61.0411040836270.19741@potato.cts.ucla.edu>
References: <Pine.LNX.4.61.0411012112450.24956@potato.cts.ucla.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I had another deadlock after the completion of a dvd writing session last 
night.  The dvd was written using the ide interface with growisof.

sysrq+p, sysrq+m, and a partial sysrq+t are at 
http://hashbrown.cts.ucla.edu/deadlock/sysrq+t-20041104.

Virtually everything is stuck in schedule_timeout+0xb4/0xc0.  It looks 
very similar to the last deadlock I had (sysrq+t output is in the same 
directory as the above as sysrq+t-20041101).

cbs:~ > lsmod
Module                  Size  Used by
ide_cd                 39328  0
cdrom                  38460  1 ide_cd
e100                   29760  0
bonding                64552  0

Any ideas?  Anything in particular to check?


-Chris

On Mon, 1 Nov 2004, Chris Stromsoe wrote:

> The machine collects remote syslog, roughly 1000 packets per second. The 
> logs are burned to dvd several times per week.  The hanging may have 
> coincided with the completion of one of the log burning sessions. 
> Before the last crash I was using ide-scsi to do the burning.  Since the 
> last crash, I switched over to directly using the ide device and have 
> disabled ide-scsi.
>
> The machine did not crash.  Remote access with ssh would hang after 
> authentication.  Already running processes that didn't fork anything 
> responded fine to the network.  I could not fork a shell from a serial 
> console.  I was able to use sysrq to pull debugging information.  I was 
> also able to kill off all running processes (sysrq+e and sysrq+i), then 
> log in from the serial console and restart things.
>
> I had the same problem with 2.6.8.1
>
> Most of the processes seem to be stuck in schedule_timeout.
>
> The full sysrq and .config are at 
> http://hashbrown.cts.ucla.edu/deadlock/
>
>
> cbs:~ > lsmod
> Module                  Size  Used by
> sg                     35040  0
> sr_mod                 14884  0
> cdrom                  38460  1 sr_mod
> ide_scsi               15332  0
> e100                   29760  0
> bonding                64552  0
>
>
>
> telnet> send brk
> SysRq : Show Regs
>
> Pid: 0, comm:              swapper
> EIP: 0060:[<c01022cf>] CPU: 0
> EIP is at default_idle+0x2f/0x40
> EFLAGS: 00000246    Not tainted  (2.6.9)
> EAX: 00000000 EBX: c039b000 ECX: c01022a0 EDX: c039b000
> ESI: c04080a0 EDI: c04081a0 EBP: c039bfc4 DS: 007b ES: 007b
> CR0: 8005003b CR2: bffffd66 CR3: 0fb3f000 CR4: 000006d0
> [<c0102516>] show_regs+0x146/0x170
> [<c0207a81>] __handle_sysrq+0x71/0xf0
> [<c021a5aa>] receive_chars+0x11a/0x230
> [<c021a9bd>] serial8250_interrupt+0xdd/0xe0
> [<c0106c96>] handle_IRQ_event+0x36/0x70
> [<c0107063>] do_IRQ+0xe3/0x1b0
> [<c0104cf0>] common_interrupt+0x18/0x20
> [<c010235b>] cpu_idle+0x3b/0x50
> [<c039cb8b>] start_kernel+0x16b/0x190
> [<c0100211>] 0xc0100211
>
>
>
> telnet> send brk
> SysRq : Show Memory
> Mem-info:
> DMA per-cpu:
> cpu 0 hot: low 2, high 6, batch 1
> cpu 0 cold: low 0, high 2, batch 1
> Normal per-cpu:
> cpu 0 hot: low 30, high 90, batch 15
> cpu 0 cold: low 0, high 30, batch 15
> HighMem per-cpu: empty
>
> Free pages:        1348kB (0kB HighMem)
> Active:26008 inactive:2118 dirty:10 writeback:0 unstable:0 free:337 
> slab:16168 mapped:25917 pagetables:12564
> DMA free:172kB min:32kB low:64kB high:96kB active:160kB inactive:48kB 
> present:16384kB
> protections[]: 0 0 0
> Normal free:1176kB min:480kB low:960kB high:1440kB active:103872kB 
> inactive:8424kB present:245760kB
> protections[]: 0 0 0
> HighMem free:0kB min:128kB low:256kB high:384kB active:0kB inactive:0kB 
> present:0kB
> protections[]: 0 0 0
> DMA: 23*4kB 2*8kB 0*16kB 0*32kB 1*64kB 0*128kB 0*256kB 0*512kB 0*1024kB 
> 0*2048kB 0*4096kB = 172kB
> Normal: 54*4kB 8*8kB 14*16kB 5*32kB 2*64kB 1*128kB 1*256kB 0*512kB 0*1024kB 
> 0*2048kB 0*4096kB = 1176kB
> HighMem: empty
> Swap cache: add 66873, delete 65915, find 54916/55208, race 0+0
> Free swap:       805560kB
> 65536 pages of RAM
> 0 pages of HIGHMEM
> 1786 reserved pages
> 600111 pages shared
> 958 pages swap cached
>
>
>
>
> cron          S C1205F60     0  2614    435          2628  2613 (NOTLB)
> cde0bc9c 00000082 00000000 c1205f60 c12068c0 c4dba97c cde0bc94 c014584e
>       c4dba940 c57d3468 b7fe7000 00000001 c1205f60 001aff4a d6c5bd65 
> 0003d278
>       c8c5e530 cf9aed40 7fffffff 00000001 cde0bcd8 c02f9f04 b7fe7000 
> 00000001
> Call Trace:
> [<c02f9f04>] schedule_timeout+0xb4/0xc0
> [<c02ef86e>] unix_wait_for_peer+0xbe/0xd0
> [<c02f028a>] unix_dgram_sendmsg+0x26a/0x500
> [<c0293cab>] sock_sendmsg+0xbb/0xe0
> [<c0295161>] sys_sendto+0xe1/0x100
> [<c02951b2>] sys_send+0x32/0x40
> [<c0295a1a>] sys_socketcall+0x13a/0x250
> [<c0104383>] syscall_call+0x7/0xb
> cron          S C1205F60     0  2628    435          2640  2614 (NOTLB)
> cc738c9c 00000086 c8c5e930 c1205f60 c82e1b7c c4dba73c cc738c94 00000000
>       c4dba700 00000007 cc738cac cebb0690 c1205f60 00289ad9 af39036a 
> 0003d2be
>       c8c5ea90 cf9aed40 7fffffff 00000001 cc738cd8 c02f9f04 00000246 
> 000000d0
> Call Trace:
> [<c02f9f04>] schedule_timeout+0xb4/0xc0
> [<c02ef86e>] unix_wait_for_peer+0xbe/0xd0
> [<c02f028a>] unix_dgram_sendmsg+0x26a/0x500
> [<c0293cab>] sock_sendmsg+0xbb/0xe0
> [<c0295161>] sys_sendto+0xe1/0x100
> [<c02951b2>] sys_send+0x32/0x40
> [<c0295a1a>] sys_socketcall+0x13a/0x250
> [<c0104383>] syscall_call+0x7/0xb
>
> cron          S C1205F60     0  2640    435          2655  2628 (NOTLB)
> c2bfbc9c 00000082 c721b9d0 c1205f60 cd21db7c c4dba07c c2bfbc94 00000000
>       c4dba040 00000007 cf06b200 cebb0690 c1205f60 0027ced4 87b993a6 
> 0003d304
>       c721bb30 cf9aed40 7fffffff 00000001 c2bfbcd8 c02f9f04 c138f6c0 
> c9bdea4c
> Call Trace:
> [<c02f9f04>] schedule_timeout+0xb4/0xc0
> [<c02ef86e>] unix_wait_for_peer+0xbe/0xd0
> [<c02f028a>] unix_dgram_sendmsg+0x26a/0x500
> [<c0293cab>] sock_sendmsg+0xbb/0xe0
> [<c0295161>] sys_sendto+0xe1/0x100
> [<c02951b2>] sys_send+0x32/0x40
> [<c0295a1a>] sys_socketcall+0x13a/0x250
> [<c0104383>] syscall_call+0x7/0xb
> sshd          S C1205F60     0  2653   1410          2654 17528 (NOTLB)
> c163dc9c 00000086 c721b470 c1205f60 00000000 00000000 00000000 00000000
>       c4dba4c0 00000007 cf06b560 c721af10 c1205f60 00039ddd 67910d34 
> 0003d32a
>       c721b5d0 cf9aed40 7fffffff 00000001 c163dcd8 c02f9f04 c138f6c0 
> c9bdea4c
> Call Trace:
> [<c02f9f04>] schedule_timeout+0xb4/0xc0
> [<c02ef86e>] unix_wait_for_peer+0xbe/0xd0
> [<c02f028a>] unix_dgram_sendmsg+0x26a/0x500
> [<c0293cab>] sock_sendmsg+0xbb/0xe0
> [<c0295161>] sys_sendto+0xe1/0x100
> [<c02951b2>] sys_send+0x32/0x40
> [<c0295a1a>] sys_socketcall+0x13a/0x250
> [<c0104383>] syscall_call+0x7/0xb
>
>
>
>
>
> -Chris
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
