Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265321AbTLHDpq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Dec 2003 22:45:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265323AbTLHDpq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Dec 2003 22:45:46 -0500
Received: from ns.int.pl ([212.106.140.230]:26128 "EHLO novacom.pl")
	by vger.kernel.org with ESMTP id S265321AbTLHDpm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Dec 2003 22:45:42 -0500
Date: Mon, 8 Dec 2003 04:46:31 +0100
From: Rafal Skoczylas <nils@secprog.org>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.test11 bug
Message-ID: <20031208034631.GA14081@secprog.org>
Reply-To: Rafal Skoczylas <nils@secprog.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[ I am sorry if this message doesn't get threaded in the original
thread in your software, but I read lkml ocassionally through
usenet-gate so didn't have the original message in my mbox and
couldn't just hit "reply" ;) ]

On Mon, 08 Dec 2003 03:30:12 +0100 Gordon Cormack wrote:
> I have read the FAQ but I'm confused about how to report a 2.6
> kernel bug, or who to report it to.
> [...]
> Dec  6 13:16:01 flax20 kernel: Bad page state at free_hot_cold_page
> Dec  6 13:16:01 flax20 kernel: flags:0x02000114 mapping:00000000
> mapped:1 count:0
> [...]

Hello.
I am experiencing similiar behaviour as described below.
In my case it is mlnetd (of mldonkey package) which seems to be
responsible for driving kernel to a crash[1].
After a few hours of running, either the process gets killed or system
crashes (I am only able to reboot it with alt+prntscr+b, but it seems
like it is not able to [S]ync or [U]nmount filesystems - i have lost
a few files which were open at the time of crash[2]).

It may be worth to mention that I don't remember having such a crash
on 2.6.0-test9 which i used for a couple of weeks (since first day
it apeared on ftp.kernel.org untill test11 - i skipped test10).

Hardware:
---------
ALi M1647, Duron 1200, 512MB sdram.

Kernel:
-------
Linux poziomka 2.6.0-test11 #32 Fri Dec 5 21:10:40 CET 2003 i686
AMD_Duron(TM)Processor unknown Shameless Compilation

Compiled with gcc-3.3.2.

Logs:
-----

--- The last time, i got the following:

Bad page state at free_hot_cold_page
flags:0x01020008 mapping:d38afe68 mapped:0 count:0
Backtrace: 
Call Trace:
 [bad_page+93/144] bad_page+0x5d/0x90
 [free_hot_cold_page+82/256] free_hot_cold_page+0x52/0x100
 [zap_pte_range+358/416] zap_pte_range+0x166/0x1a0
 [zap_pmd_range+75/112] zap_pmd_range+0x4b/0x70
 [unmap_page_range+67/112] unmap_page_range+0x43/0x70 
 [unmap_vmas+225/528] unmap_vmas+0xe1/0x210
 [exit_mmap+123/400] exit_mmap+0x7b/0x190
 [mmput+100/192] mmput+0x64/0xc0
 [do_exit+282/976] do_exit+0x11a/0x3d0
 [do_group_exit+58/176] do_group_exit+0x3a/0xb0
 [get_signal_to_deliver+590/848] get_signal_to_deliver+0x24e/0x350
 [do_signal+149/288] do_signal+0x95/0x120
 [schedule+761/1392] schedule+0x2f9/0x570
 [pipe_write+0/800] pipe_write+0x0/0x320
 [sys_rt_sigsuspend+222/272] sys_rt_sigsuspend+0xde/0x110
 [syscall_call+7/11] syscall_call+0x7/0xb
Trying to fix it up, but a reboot is needed

--- But sometimes it get things like this:

Unable to handle kernel paging request at virtual address 5a85fb5c
 printing eip:
c011e6c4
*pde = 00000000
Oops: 0002 [#1]
CPU:    0
EIP:    0060:[remove_wait_queue+36/112]    Not tainted
EFLAGS: 00010002
EIP is at remove_wait_queue+0x24/0x70
eax: defb4000   ebx: da85fb58   ecx: 5a85fb58   edx: db0468b0
esi: db0468bc   edi: 00000292   ebp: defb5fa0   esp: defb5f58
ds: 007b   es: 007b   ss: 0068
Process mlnetd (pid: 1456, threadinfo=defb4000 task=dd72e100)
Stack: db0468ac db046008 db046000 c0167484 00000000 cad86c08 00000001 c01681f5
       defb5fa0 cad86c00 defb5fa0 00000041 defb4000 08376b48 cad86c08 00000000
       cad86c00 00000001 c01674b0 db046000 00000000 3fd32b9c 083767d8 00000001
Call Trace:
 [poll_freewait+36/80] poll_freewait+0x24/0x50
 [sys_poll+581/656] sys_poll+0x245/0x290
 [__pollwait+0/208] __pollwait+0x0/0xd0
 [syscall_call+7/11] syscall_call+0x7/0xb

Code: 89 59 04 89 0b c7 46 04 00 02 20 00 c7 42 0c 00 01 10 00 57
 <6>note: mlnetd[1456] exited with preempt_count 1
bad: scheduling while atomic!
Call Trace:
 [schedule+1373/1392] schedule+0x55d/0x570
 [unmap_page_range+67/112] unmap_page_range+0x43/0x70
 [unmap_vmas+436/528] unmap_vmas+0x1b4/0x210
 [exit_mmap+123/400] exit_mmap+0x7b/0x190
 [mmput+100/192] mmput+0x64/0xc0
 [do_exit+282/976] do_exit+0x11a/0x3d0
 [do_page_fault+0/1292] do_page_fault+0x0/0x50c
 [die+225/240] die+0xe1/0xf0
 [do_page_fault+474/1292] do_page_fault+0x1da/0x50c
 [do_IRQ+253/304] do_IRQ+0xfd/0x130
 [common_interrupt+24/32] common_interrupt+0x18/0x20
 [tcp_poll+18/352] tcp_poll+0x12/0x160
 [do_page_fault+0/1292] do_page_fault+0x0/0x50c
 [error_code+45/56] error_code+0x2d/0x38
 [remove_wait_queue+36/112] remove_wait_queue+0x24/0x70
 [poll_freewait+36/80] poll_freewait+0x24/0x50
 [sys_poll+581/656] sys_poll+0x245/0x290
 [__pollwait+0/208] __pollwait+0x0/0xd0
 [syscall_call+7/11] syscall_call+0x7/0xb

(this last Call Trace repeted 2 more times)

If there is any important information missing, feel free to ask.
Regards.

[1] Actually, I am not sure, but this is the only candidate because
it uses more and more memory over the time and the crash or kill occurs
more or less at the same level of memory usage (~10-12% of 512Meg).
USER       PID %CPU %MEM   VSZ  RSS TTY      STAT START   TIME COMMAND
nils      1781 11.1 10.5 41252 38796 pts/2   S    03:39   3:15 mlnetd
                    ^^^^
[2] The files loss is probably XFS-related problem.

nils.
-- 
"Blessed is the man, who having nothing to say, abstains from giving wordy
evidence of the fact."  -- http://secprog.org/who/rs/quote.php?id=1
