Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262805AbTFJODG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 10:03:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262878AbTFJODF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 10:03:05 -0400
Received: from franka.aracnet.com ([216.99.193.44]:54495 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP id S262805AbTFJOBS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 10:01:18 -0400
Date: Tue, 10 Jun 2003 07:14:08 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Andrew Morton <akpm@digeo.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.70 (virgin) hangs running SDET
Message-ID: <5930000.1055254447@[10.10.2.4]>
In-Reply-To: <20030609140834.11ad0d63.akpm@digeo.com>
References: <60380000.1055188542@flay> <20030609140834.11ad0d63.akpm@digeo.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The ps instance which is spinning on kernel_flag in proc_root_lookup is
> what's holding things up.
> 
> Or is it spinning in proc_lookup() or proc_pid_lookup()?  I have a vague
> feeling that I've seen these traces miss out the innermost stack slot...
> 
> Suggest:
> 
> a) Use CONFIG_SPINLINE, get a new sysrq-T trace
> 
> b) Enable spinlock debugging
> 
> c) Try disabling the sched_balance_exec() code.


Moving that locking around as discussed last night didn't fix it. 
It did last 2.5 cycles of repeated SDET this time instead of 0.5,
but that might just be coincidence, as the hang looks the same. Got
a better backtrace out of her this time though ....

Want me to back out the patch I was pointing fingers at? Or I can
carry on with the path you suggested above if you think it'll help ...

Thanks,

M.

ps            R 00000060 4291798672 21055  20137         21069       (NOTLB)
Call Trace:
 [<c016d6de>] proc_pid_lookup+0x16e/0x1d0
 [<c016bd35>] proc_root_lookup+0x85/0x98
 [<c015219c>] real_lookup+0x54/0xc4
 [<c015244c>] do_lookup+0x48/0x8c
 [<c01529e7>] link_path_walk+0x557/0x7fc
 [<c0152fb2>] path_lookup+0x156/0x15c
 [<c01530d4>] __user_walk+0x28/0x40
 [<c014eb71>] vfs_stat+0x19/0x48
 [<c014f11b>] sys_stat64+0x13/0x30
 [<c0108b97>] syscall_call+0x7/0xb

---------------------------------------------

The whole thing (minus the boring parts):

bash          S EEE4597C 4291181460   295    293   297               (NOTLB)
Call Trace:
 [<c011c817>] session_of_pgrp+0x27/0x84
 [<c019db87>] tiocspgrp+0x6f/0x94
 [<c011df78>] sys_wait4+0x20c/0x244
 [<c0124d4c>] sys_rt_sigprocmask+0x128/0x140
 [<c0118488>] default_wake_function+0x0/0x20
 [<c0118488>] default_wake_function+0x0/0x20
 [<c0108b97>] syscall_call+0x7/0xb

stressdet     S EEE44D3C 4291110652   297    295 16086               (NOTLB)
Call Trace:
 [<c011df78>] sys_wait4+0x20c/0x244
 [<c0118488>] default_wake_function+0x0/0x20
 [<c0118488>] default_wake_function+0x0/0x20
 [<c0108b97>] syscall_call+0x7/0xb

sdetbench     S EEDDF39C 4291452472 16086    297 19967               (NOTLB)
Call Trace:
 [<c01256a4>] do_sigaction+0x184/0x25c
 [<c012570c>] do_sigaction+0x1ec/0x25c
 [<c011df78>] sys_wait4+0x20c/0x244
 [<c0118488>] default_wake_function+0x0/0x20
 [<c0118488>] default_wake_function+0x0/0x20
 [<c0108b97>] syscall_call+0x7/0xb

pdflush       S EBA11FE4 4240644464 19965      1                 292 (L-TLB)
Call Trace:
 [<c0132d2e>] __pdflush+0x9e/0x1dc
 [<c0132e6c>] pdflush+0x0/0x14
 [<c0132e77>] pdflush+0xb/0x14
 [<c0106f51>] kernel_thread_helper+0x5/0xc

sh            S ECCBB35C 4252419920 19967  16086 19968               (NOTLB)
Call Trace:
 [<c011df78>] sys_wait4+0x20c/0x244
 [<c0118488>] default_wake_function+0x0/0x20
 [<c0118488>] default_wake_function+0x0/0x20
 [<c0108b97>] syscall_call+0x7/0xb

spec_auto     S EC885A5C 4250181712 19968  19967 19980               (NOTLB)
Call Trace:
 [<c011df78>] sys_wait4+0x20c/0x244
 [<c0118488>] default_wake_function+0x0/0x20
 [<c0118488>] default_wake_function+0x0/0x20
 [<c0108b97>] syscall_call+0x7/0xb

make          S EC8847FC 4271321776 19980  19968 19981   19982       (NOTLB)
Call Trace:
 [<c011df78>] sys_wait4+0x20c/0x244
 [<c0124ca6>] sys_rt_sigprocmask+0x82/0x140
 [<c0118488>] default_wake_function+0x0/0x20
 [<c0118488>] default_wake_function+0x0/0x20
 [<c0108b97>] syscall_call+0x7/0xb

benchrun      S EC88543C 36947572 19981  19980 19987               (NOTLB)
Call Trace:
 [<c011df78>] sys_wait4+0x20c/0x244
 [<c0118488>] default_wake_function+0x0/0x20
 [<c0118488>] default_wake_function+0x0/0x20
 [<c0108b97>] syscall_call+0x7/0xb

tee           S EB43992C 4260444592 19982  19968               19980 (NOTLB)
Call Trace:
 [<c010ac1f>] do_IRQ+0xcf/0x114
 [<c0151180>] pipe_wait+0x70/0x94
 [<c0119c98>] autoremove_wake_function+0x0/0x40
 [<c0119c98>] autoremove_wake_function+0x0/0x40
 [<c0151341>] pipe_read+0x19d/0x208
 [<c0146cbc>] vfs_read+0x9c/0xcc
 [<c0146e9d>] sys_read+0x31/0x4c
 [<c0108b97>] syscall_call+0x7/0xb

benchrun      S EC884E1C 4269534432 19987  19981 19992               (NOTLB)
Call Trace:
 [<c011df78>] sys_wait4+0x20c/0x244
 [<c0118488>] default_wake_function+0x0/0x20
 [<c0118488>] default_wake_function+0x0/0x20
 [<c0108b97>] syscall_call+0x7/0xb

make          S EAE6419C 22804752 19992  19987 20105   19993       (NOTLB)
Call Trace:
 [<c011df78>] sys_wait4+0x20c/0x244
 [<c0124ca6>] sys_rt_sigprocmask+0x82/0x140
 [<c0118488>] default_wake_function+0x0/0x20
 [<c0118488>] default_wake_function+0x0/0x20
 [<c0108b97>] syscall_call+0x7/0xb

tee           S EB43924C 4291174704 19993  19987               19992 (NOTLB)
Call Trace:
 [<c0151180>] pipe_wait+0x70/0x94
 [<c0119c98>] autoremove_wake_function+0x0/0x40
 [<c0119c98>] autoremove_wake_function+0x0/0x40
 [<c0151341>] pipe_read+0x19d/0x208
 [<c0146cbc>] vfs_read+0x9c/0xcc
 [<c0146e9d>] sys_read+0x31/0x4c
 [<c0108b97>] syscall_call+0x7/0xb

sh            S EC8841DC 7002320 20105  19992 20110               (NOTLB)
Call Trace:
 [<c011df78>] sys_wait4+0x20c/0x244
 [<c0118488>] default_wake_function+0x0/0x20
 [<c0118488>] default_wake_function+0x0/0x20
 [<c0108b97>] syscall_call+0x7/0xb

time          S EAE647BC 6673136 20110  20105 20111               (NOTLB)
Call Trace:
 [<c011df78>] sys_wait4+0x20c/0x244
 [<c0118488>] default_wake_function+0x0/0x20
 [<c0118488>] default_wake_function+0x0/0x20
 [<c0108b97>] syscall_call+0x7/0xb

time          S EB4D273C 49304432 20111  20110 20112               (NOTLB)
Call Trace:
 [<c01256a4>] do_sigaction+0x184/0x25c
 [<c012570c>] do_sigaction+0x1ec/0x25c
 [<c011df78>] sys_wait4+0x20c/0x244
 [<c0118488>] default_wake_function+0x0/0x20
 [<c0118488>] default_wake_function+0x0/0x20
 [<c0108b97>] syscall_call+0x7/0xb

run.sdet      S EB75997C 19620144 20112  20111 20117               (NOTLB)
Call Trace:
 [<c011df78>] sys_wait4+0x20c/0x244
 [<c0118488>] default_wake_function+0x0/0x20
 [<c0118488>] default_wake_function+0x0/0x20
 [<c0108b97>] syscall_call+0x7/0xb

run           S EB75935C 17762208 20117  20112 20119               (NOTLB)
Call Trace:
 [<c011df78>] sys_wait4+0x20c/0x244
 [<c0118488>] default_wake_function+0x0/0x20
 [<c0118488>] default_wake_function+0x0/0x20
 [<c0108b97>] syscall_call+0x7/0xb

driver        S EB758D3C 21826976 20119  20117 20120               (NOTLB)
Call Trace:
 [<c011df78>] sys_wait4+0x20c/0x244
 [<c0118488>] default_wake_function+0x0/0x20
 [<c0118488>] default_wake_function+0x0/0x20
 [<c0108b97>] syscall_call+0x7/0xb

driver.exec   S EB75871C 4272960400 20120  20119 20121               (NOTLB)
Call Trace:
 [<c011df78>] sys_wait4+0x20c/0x244
 [<c0118488>] default_wake_function+0x0/0x20
 [<c0118488>] default_wake_function+0x0/0x20
 [<c0108b97>] syscall_call+0x7/0xb

sh            S EE76F99C 4254974224 20121  20120 21638   20122       (NOTLB)
Call Trace:
 [<c011df78>] sys_wait4+0x20c/0x244
 [<c0118488>] default_wake_function+0x0/0x20
 [<c0118488>] default_wake_function+0x0/0x20
 [<c0108b97>] syscall_call+0x7/0xb

sh            S EE76F37C 4230375216 20122  20120 21684   20123 20121 (NOTLB)
Call Trace:
 [<c011df78>] sys_wait4+0x20c/0x244
 [<c0118488>] default_wake_function+0x0/0x20
 [<c0118488>] default_wake_function+0x0/0x20
 [<c0108b97>] syscall_call+0x7/0xb

sh            S EE76ED5C 4252224848 20123  20120 22609   20125 20122 (NOTLB)
Call Trace:
 [<c011df78>] sys_wait4+0x20c/0x244
 [<c0118488>] default_wake_function+0x0/0x20
 [<c0118488>] default_wake_function+0x0/0x20
 [<c0108b97>] syscall_call+0x7/0xb

sh            S EE76E11C 4288371088 20125  20120 22643   20127 20123 (NOTLB)
Call Trace:
 [<c011df78>] sys_wait4+0x20c/0x244
 [<c0118488>] default_wake_function+0x0/0x20
 [<c0118488>] default_wake_function+0x0/0x20
 [<c0108b97>] syscall_call+0x7/0xb

sh            S E9FAF39C 41101072 20127  20120 21662   20128 20125 (NOTLB)
Call Trace:
 [<c011df78>] sys_wait4+0x20c/0x244
 [<c0118488>] default_wake_function+0x0/0x20
 [<c0118488>] default_wake_function+0x0/0x20
 [<c0108b97>] syscall_call+0x7/0xb

sh            S E9FAED7C 17714484 20128  20120 21261   20129 20127 (NOTLB)
Call Trace:
 [<c01173b4>] wake_up_forked_process+0x114/0x120
 [<c011df78>] sys_wait4+0x20c/0x244
 [<c0118488>] default_wake_function+0x0/0x20
 [<c0118488>] default_wake_function+0x0/0x20
 [<c0108b97>] syscall_call+0x7/0xb

sh            S E9FAE75C 11875200 20129  20120 22440   20130 20128 (NOTLB)
Call Trace:
 [<c011df78>] sys_wait4+0x20c/0x244
 [<c0118488>] default_wake_function+0x0/0x20
 [<c0118488>] default_wake_function+0x0/0x20
 [<c0108b97>] syscall_call+0x7/0xb

sh            S E9FAE13C 24607088 20130  20120 21132   20131 20129 (NOTLB)
Call Trace:
 [<c011df78>] sys_wait4+0x20c/0x244
 [<c0118488>] default_wake_function+0x0/0x20
 [<c0118488>] default_wake_function+0x0/0x20
 [<c0108b97>] syscall_call+0x7/0xb

sh            S EB5A99DC 20111744 20131  20120 22675   20132 20130 (NOTLB)
Call Trace:
 [<c011df78>] sys_wait4+0x20c/0x244
 [<c0118488>] default_wake_function+0x0/0x20
 [<c0118488>] default_wake_function+0x0/0x20
 [<c0108b97>] syscall_call+0x7/0xb

sh            S EB5A93BC 4273489648 20132  20120 21183   20133 20131 (NOTLB)
Call Trace:
 [<c011df78>] sys_wait4+0x20c/0x244
 [<c0118488>] default_wake_function+0x0/0x20
 [<c0118488>] default_wake_function+0x0/0x20
 [<c0108b97>] syscall_call+0x7/0xb

sh            S EB5A8D9C 1055968 20133  20120 21634   20134 20132 (NOTLB)
Call Trace:
 [<c011df78>] sys_wait4+0x20c/0x244
 [<c0118488>] default_wake_function+0x0/0x20
 [<c0118488>] default_wake_function+0x0/0x20
 [<c0108b97>] syscall_call+0x7/0xb

sh            S EB5A877C 43340592 20134  20120 22160   20137 20133 (NOTLB)
Call Trace:
 [<c011df78>] sys_wait4+0x20c/0x244
 [<c0118488>] default_wake_function+0x0/0x20
 [<c0118488>] default_wake_function+0x0/0x20
 [<c0108b97>] syscall_call+0x7/0xb

sh            S EB8C415C 4288125264 20137  20120 21055   20139 20134 (NOTLB)
Call Trace:
 [<c011df78>] sys_wait4+0x20c/0x244
 [<c0118488>] default_wake_function+0x0/0x20
 [<c0118488>] default_wake_function+0x0/0x20
 [<c0108b97>] syscall_call+0x7/0xb

sh            S ECDF875C 4293235536 20139  20120 21197   20140 20137 (NOTLB)
Call Trace:
 [<c011df78>] sys_wait4+0x20c/0x244
 [<c0118488>] default_wake_function+0x0/0x20
 [<c0118488>] default_wake_function+0x0/0x20
 [<c0108b97>] syscall_call+0x7/0xb

sh            S ECDF813C 4251761008 20140  20120 21444   20141 20139 (NOTLB)
Call Trace:
 [<c011df78>] sys_wait4+0x20c/0x244
 [<c0118488>] default_wake_function+0x0/0x20
 [<c0118488>] default_wake_function+0x0/0x20
 [<c0108b97>] syscall_call+0x7/0xb

sh            S ECDF99BC 4269826288 20141  20120 21112   20143 20140 (NOTLB)
Call Trace:
 [<c011df78>] sys_wait4+0x20c/0x244
 [<c0118488>] default_wake_function+0x0/0x20
 [<c0118488>] default_wake_function+0x0/0x20
 [<c0108b97>] syscall_call+0x7/0xb

sh            S EA2EC6FC 46306224 20143  20120 21380   20145 20141 (NOTLB)
Call Trace:
 [<c011df78>] sys_wait4+0x20c/0x244
 [<c0118488>] default_wake_function+0x0/0x20
 [<c0118488>] default_wake_function+0x0/0x20
 [<c0108b97>] syscall_call+0x7/0xb

sh            S EA2ED95C 15974736 20145  20120 20598   20149 20143 (NOTLB)
Call Trace:
 [<c011df78>] sys_wait4+0x20c/0x244
 [<c0118488>] default_wake_function+0x0/0x20
 [<c0118488>] default_wake_function+0x0/0x20
 [<c0108b97>] syscall_call+0x7/0xb

sh            S EC840DBC 4254018880 20149  20120 22393   20151 20145 (NOTLB)
Call Trace:
 [<c011df78>] sys_wait4+0x20c/0x244
 [<c0118488>] default_wake_function+0x0/0x20
 [<c0118488>] default_wake_function+0x0/0x20
 [<c0108b97>] syscall_call+0x7/0xb

sh            S EC84017C 4275960112 20151  20120 22236   20152 20149 (NOTLB)
Call Trace:
 [<c011df78>] sys_wait4+0x20c/0x244
 [<c0118488>] default_wake_function+0x0/0x20
 [<c0118488>] default_wake_function+0x0/0x20
 [<c0108b97>] syscall_call+0x7/0xb

sh            S EB971A1C 4266975584 20152  20120 22370         20151 (NOTLB)
Call Trace:
 [<c011df78>] sys_wait4+0x20c/0x244
 [<c0118488>] default_wake_function+0x0/0x20
 [<c0118488>] default_wake_function+0x0/0x20
 [<c0108b97>] syscall_call+0x7/0xb

make          S EB970DDC 32836816 20598  20145 21096               (NOTLB)
Call Trace:
 [<c011df78>] sys_wait4+0x20c/0x244
 [<c0124ca6>] sys_rt_sigprocmask+0x82/0x140
 [<c0118488>] default_wake_function+0x0/0x20
 [<c0118488>] default_wake_function+0x0/0x20
 [<c0108b97>] syscall_call+0x7/0xb

ps            R 00000060 4291798672 21055  20137         21069       (NOTLB)
Call Trace:
 [<c016d6de>] proc_pid_lookup+0x16e/0x1d0
 [<c016bd35>] proc_root_lookup+0x85/0x98
 [<c015219c>] real_lookup+0x54/0xc4
 [<c015244c>] do_lookup+0x48/0x8c
 [<c01529e7>] link_path_walk+0x557/0x7fc
 [<c0152fb2>] path_lookup+0x156/0x15c
 [<c01530d4>] __user_walk+0x28/0x40
 [<c014eb71>] vfs_stat+0x19/0x48
 [<c014f11b>] sys_stat64+0x13/0x30
 [<c0108b97>] syscall_call+0x7/0xb

wc            S EE59B7CC 4294354672 21069  20137               21055 (NOTLB)
Call Trace:
 [<c0151180>] pipe_wait+0x70/0x94
 [<c0119c98>] autoremove_wake_function+0x0/0x40
 [<c0119c98>] autoremove_wake_function+0x0/0x40
 [<c0151341>] pipe_read+0x19d/0x208
 [<c013cf60>] do_brk+0x190/0x1c0
 [<c0146cbc>] vfs_read+0x9c/0xcc
 [<c0146e9d>] sys_read+0x31/0x4c
 [<c0108b97>] syscall_call+0x7/0xb

cc            S 00000000 60306288 21096  20598 21161               (NOTLB)
Call Trace:
 [<c0109586>] apic_timer_interrupt+0x1a/0x20
 [<c011c635>] release_task+0x31/0x184
 [<c011dbca>] wait_task_zombie+0x142/0x164
 [<c011de96>] sys_wait4+0x12a/0x244
 [<c0118488>] default_wake_function+0x0/0x20
 [<c0118488>] default_wake_function+0x0/0x20
 [<c0108b97>] syscall_call+0x7/0xb

ps            D 00000246 18039088 21112  20141         21116       (NOTLB)
Call Trace:
 [<c0107ad5>] __down+0x7d/0xe0
 [<c0118488>] default_wake_function+0x0/0x20
 [<c0107ca8>] __down_failed+0x8/0xc
 [<c015662d>] .text.lock.readdir+0x5/0x18
 [<c01565df>] sys_getdents64+0x67/0xb0
 [<c015646c>] filldir64+0x0/0x10c
 [<c0108b97>] syscall_call+0x7/0xb

wc            S EE37E68C 4261032896 21116  20141               21112 (NOTLB)
Call Trace:
 [<c0151180>] pipe_wait+0x70/0x94
 [<c0119c98>] autoremove_wake_function+0x0/0x40
 [<c0119c98>] autoremove_wake_function+0x0/0x40
 [<c0151341>] pipe_read+0x19d/0x208
 [<c013cf60>] do_brk+0x190/0x1c0
 [<c0146cbc>] vfs_read+0x9c/0xcc
 [<c0146e9d>] sys_read+0x31/0x4c
 [<c0108b97>] syscall_call+0x7/0xb

as            W EB8C5320 4279334592 21161  21096                     (L-TLB)
Call Trace:
 [<c011d891>] do_exit+0x365/0x378
 [<c011d8ca>] sys_exit+0xe/0x10
 [<c0108b97>] syscall_call+0x7/0xb

sh            R EC289DD0 5369232 21132  20130                     (NOTLB)
Call Trace:
 [<c0149a40>] __block_commit_write+0x6c/0x94
 [<c0118692>] wait_for_completion+0x8a/0xbc
 [<c0118488>] default_wake_function+0x0/0x20
 [<c0118488>] default_wake_function+0x0/0x20
 [<c01196aa>] set_cpus_allowed+0xfa/0x108
 [<c01175b9>] sched_migrate_task+0x21/0x34
 [<c0117681>] sched_balance_exec+0x2d/0x34
 [<c0150921>] do_execve+0x1d/0x20c
 [<c013187a>] __alloc_pages+0x82/0x2b4
 [<c01360b1>] invalidate_vcache+0x19/0x88
 [<c015241c>] do_lookup+0x18/0x8c
 [<c015a1c5>] dput+0x19/0x148
 [<c014f0ef>] cp_new_stat64+0xe7/0x100
 [<c01256a4>] do_sigaction+0x184/0x25c
 [<c012570c>] do_sigaction+0x1ec/0x25c
 [<c0125ab6>] sys_rt_sigaction+0xae/0xd4
 [<c0151e9d>] getname+0x5d/0x9c
 [<c010769b>] sys_execve+0x2f/0x6c
 [<c0108b97>] syscall_call+0x7/0xb

ps            D 00000246 13887184 21183  20132         21186       (NOTLB)
Call Trace:
 [<c0107ad5>] __down+0x7d/0xe0
 [<c0118488>] default_wake_function+0x0/0x20
 [<c0107ca8>] __down_failed+0x8/0xc
 [<c0155173>] .text.lock.namei+0x5/0x172
 [<c015244c>] do_lookup+0x48/0x8c
 [<c01529e7>] link_path_walk+0x557/0x7fc
 [<c0152fb2>] path_lookup+0x156/0x15c
 [<c0153483>] open_namei+0x8b/0x3f0
 [<c0146163>] filp_open+0x3b/0x5c
 [<c0146523>] sys_open+0x37/0x78
 [<c0108b97>] syscall_call+0x7/0xb

wc            S EC55590C 19002304 21186  20132               21183 (NOTLB)
Call Trace:
 [<c0115e13>] do_page_fault+0x133/0x478
 [<c0151180>] pipe_wait+0x70/0x94
 [<c0119c98>] autoremove_wake_function+0x0/0x40
 [<c0119c98>] autoremove_wake_function+0x0/0x40
 [<c0151341>] pipe_read+0x19d/0x208
 [<c013cf60>] do_brk+0x190/0x1c0
 [<c0146cbc>] vfs_read+0x9c/0xcc
 [<c0146e9d>] sys_read+0x31/0x4c
 [<c0108b97>] syscall_call+0x7/0xb

sh            R EB6E9DD0 4263313624 21197  20139                     (NOTLB)
Call Trace:
 [<c0118692>] wait_for_completion+0x8a/0xbc
 [<c0118488>] default_wake_function+0x0/0x20
 [<c0118488>] default_wake_function+0x0/0x20
 [<c01196aa>] set_cpus_allowed+0xfa/0x108
 [<c01175b9>] sched_migrate_task+0x21/0x34
 [<c0117681>] sched_balance_exec+0x2d/0x34
 [<c0150921>] do_execve+0x1d/0x20c
 [<c013187a>] __alloc_pages+0x82/0x2b4
 [<c01360b1>] invalidate_vcache+0x19/0x88
 [<c013a286>] do_wp_page+0x396/0x3ac
 [<c013b014>] handle_mm_fault+0x14c/0x1a0
 [<c0115e13>] do_page_fault+0x133/0x478
 [<c0115ce0>] do_page_fault+0x0/0x478
 [<c015a1c5>] dput+0x19/0x148
 [<c01256a4>] do_sigaction+0x184/0x25c
 [<c012570c>] do_sigaction+0x1ec/0x25c
 [<c0125ab6>] sys_rt_sigaction+0xae/0xd4
 [<c0151e9d>] getname+0x5d/0x9c
 [<c010769b>] sys_execve+0x2f/0x6c
 [<c0108b97>] syscall_call+0x7/0xb

ps            D 00000246 33562900 21261  20128         21262       (NOTLB)
Call Trace:
 [<c0107ad5>] __down+0x7d/0xe0
 [<c0118488>] default_wake_function+0x0/0x20
 [<c0107ca8>] __down_failed+0x8/0xc
 [<c0155173>] .text.lock.namei+0x5/0x172
 [<c015244c>] do_lookup+0x48/0x8c
 [<c01529e7>] link_path_walk+0x557/0x7fc
 [<c0152fb2>] path_lookup+0x156/0x15c
 [<c0153483>] open_namei+0x8b/0x3f0
 [<c0146163>] filp_open+0x3b/0x5c
 [<c0146523>] sys_open+0x37/0x78
 [<c0108b97>] syscall_call+0x7/0xb

wc            S EF5A196C 18028944 21262  20128               21261 (NOTLB)
Call Trace:
 [<c0115e13>] do_page_fault+0x133/0x478
 [<c0151180>] pipe_wait+0x70/0x94
 [<c0119c98>] autoremove_wake_function+0x0/0x40
 [<c0119c98>] autoremove_wake_function+0x0/0x40
 [<c0151341>] pipe_read+0x19d/0x208
 [<c013cf60>] do_brk+0x190/0x1c0
 [<c0146cbc>] vfs_read+0x9c/0xcc
 [<c0146e9d>] sys_read+0x31/0x4c
 [<c0108b97>] syscall_call+0x7/0xb

ps            D 00000246 6288304 21380  20143         21382       (NOTLB)
Call Trace:
 [<c0107ad5>] __down+0x7d/0xe0
 [<c0118488>] default_wake_function+0x0/0x20
 [<c0107ca8>] __down_failed+0x8/0xc
 [<c0155173>] .text.lock.namei+0x5/0x172
 [<c015244c>] do_lookup+0x48/0x8c
 [<c01529e7>] link_path_walk+0x557/0x7fc
 [<c0152fb2>] path_lookup+0x156/0x15c
 [<c0153483>] open_namei+0x8b/0x3f0
 [<c0146163>] filp_open+0x3b/0x5c
 [<c0146523>] sys_open+0x37/0x78
 [<c0108b97>] syscall_call+0x7/0xb

wc            S EC163D8C 4269816048 21382  20143               21380 (NOTLB)
Call Trace:
 [<c0115e13>] do_page_fault+0x133/0x478
 [<c0151180>] pipe_wait+0x70/0x94
 [<c0119c98>] autoremove_wake_function+0x0/0x40
 [<c0119c98>] autoremove_wake_function+0x0/0x40
 [<c0151341>] pipe_read+0x19d/0x208
 [<c013cf60>] do_brk+0x190/0x1c0
 [<c0146cbc>] vfs_read+0x9c/0xcc
 [<c0146e9d>] sys_read+0x31/0x4c
 [<c0108b97>] syscall_call+0x7/0xb

ps            D 00000246 4270581392 21444  20140         21445       (NOTLB)
Call Trace:
 [<c0107ad5>] __down+0x7d/0xe0
 [<c0118488>] default_wake_function+0x0/0x20
 [<c0107ca8>] __down_failed+0x8/0xc
 [<c0155173>] .text.lock.namei+0x5/0x172
 [<c015244c>] do_lookup+0x48/0x8c
 [<c01529e7>] link_path_walk+0x557/0x7fc
 [<c0152fb2>] path_lookup+0x156/0x15c
 [<c0153483>] open_namei+0x8b/0x3f0
 [<c0146163>] filp_open+0x3b/0x5c
 [<c0146523>] sys_open+0x37/0x78
 [<c0108b97>] syscall_call+0x7/0xb

wc            S EC555D2C 4294529748 21445  20140               21444 (NOTLB)
Call Trace:
 [<c0115e13>] do_page_fault+0x133/0x478
 [<c0151180>] pipe_wait+0x70/0x94
 [<c0119c98>] autoremove_wake_function+0x0/0x40
 [<c0119c98>] autoremove_wake_function+0x0/0x40
 [<c0151341>] pipe_read+0x19d/0x208
 [<c013cf60>] do_brk+0x190/0x1c0
 [<c0146cbc>] vfs_read+0x9c/0xcc
 [<c0146e9d>] sys_read+0x31/0x4c
 [<c0108b97>] syscall_call+0x7/0xb

ps            D 00000246 9704452 21634  20133         21637       (NOTLB)
Call Trace:
 [<c0107ad5>] __down+0x7d/0xe0
 [<c0118488>] default_wake_function+0x0/0x20
 [<c0107ca8>] __down_failed+0x8/0xc
 [<c0155173>] .text.lock.namei+0x5/0x172
 [<c015244c>] do_lookup+0x48/0x8c
 [<c01529e7>] link_path_walk+0x557/0x7fc
 [<c0152fb2>] path_lookup+0x156/0x15c
 [<c0153483>] open_namei+0x8b/0x3f0
 [<c0146163>] filp_open+0x3b/0x5c
 [<c0146523>] sys_open+0x37/0x78
 [<c0108b97>] syscall_call+0x7/0xb

wc            S EE37E26C 4291931332 21637  20133               21634 (NOTLB)
Call Trace:
 [<c0115e13>] do_page_fault+0x133/0x478
 [<c0151180>] pipe_wait+0x70/0x94
 [<c0119c98>] autoremove_wake_function+0x0/0x40
 [<c0119c98>] autoremove_wake_function+0x0/0x40
 [<c0151341>] pipe_read+0x19d/0x208
 [<c013cf60>] do_brk+0x190/0x1c0
 [<c0146cbc>] vfs_read+0x9c/0xcc
 [<c0146e9d>] sys_read+0x31/0x4c
 [<c0108b97>] syscall_call+0x7/0xb

ps            D 00000246 4286429648 21638  20121         21650       (NOTLB)
Call Trace:
 [<c0107ad5>] __down+0x7d/0xe0
 [<c0118488>] default_wake_function+0x0/0x20
 [<c0107ca8>] __down_failed+0x8/0xc
 [<c0155173>] .text.lock.namei+0x5/0x172
 [<c015244c>] do_lookup+0x48/0x8c
 [<c01529e7>] link_path_walk+0x557/0x7fc
 [<c0152fb2>] path_lookup+0x156/0x15c
 [<c0153483>] open_namei+0x8b/0x3f0
 [<c0146163>] filp_open+0x3b/0x5c
 [<c0146523>] sys_open+0x37/0x78
 [<c0108b97>] syscall_call+0x7/0xb

wc            S ED952D8C 18189552 21650  20121               21638 (NOTLB)
Call Trace:
 [<c0115e13>] do_page_fault+0x133/0x478
 [<c0151180>] pipe_wait+0x70/0x94
 [<c0119c98>] autoremove_wake_function+0x0/0x40
 [<c0119c98>] autoremove_wake_function+0x0/0x40
 [<c0151341>] pipe_read+0x19d/0x208
 [<c013cf60>] do_brk+0x190/0x1c0
 [<c0146cbc>] vfs_read+0x9c/0xcc
 [<c0146e9d>] sys_read+0x31/0x4c
 [<c0108b97>] syscall_call+0x7/0xb

ps            D 00000246 4271391008 21662  20127         21668       (NOTLB)
Call Trace:
 [<c0107ad5>] __down+0x7d/0xe0
 [<c0118488>] default_wake_function+0x0/0x20
 [<c0107ca8>] __down_failed+0x8/0xc
 [<c0155173>] .text.lock.namei+0x5/0x172
 [<c015244c>] do_lookup+0x48/0x8c
 [<c01529e7>] link_path_walk+0x557/0x7fc
 [<c0152fb2>] path_lookup+0x156/0x15c
 [<c0153483>] open_namei+0x8b/0x3f0
 [<c0146163>] filp_open+0x3b/0x5c
 [<c0146523>] sys_open+0x37/0x78
 [<c0108b97>] syscall_call+0x7/0xb

wc            S EA37D7EC 4260988560 21668  20127               21662 (NOTLB)
Call Trace:
 [<c0115e13>] do_page_fault+0x133/0x478
 [<c0151180>] pipe_wait+0x70/0x94
 [<c0119c98>] autoremove_wake_function+0x0/0x40
 [<c0119c98>] autoremove_wake_function+0x0/0x40
 [<c0151341>] pipe_read+0x19d/0x208
 [<c013cf60>] do_brk+0x190/0x1c0
 [<c0146cbc>] vfs_read+0x9c/0xcc
 [<c0146e9d>] sys_read+0x31/0x4c
 [<c0108b97>] syscall_call+0x7/0xb

ps            D 00000246 43281808 21684  20122         21686       (NOTLB)
Call Trace:
 [<c0107ad5>] __down+0x7d/0xe0
 [<c0118488>] default_wake_function+0x0/0x20
 [<c0107ca8>] __down_failed+0x8/0xc
 [<c0155173>] .text.lock.namei+0x5/0x172
 [<c015244c>] do_lookup+0x48/0x8c
 [<c01529e7>] link_path_walk+0x557/0x7fc
 [<c0152fb2>] path_lookup+0x156/0x15c
 [<c0153483>] open_namei+0x8b/0x3f0
 [<c0146163>] filp_open+0x3b/0x5c
 [<c0146523>] sys_open+0x37/0x78
 [<c0108b97>] syscall_call+0x7/0xb

wc            S EE59BD4C 45583764 21686  20122               21684 (NOTLB)
Call Trace:
 [<c0115e13>] do_page_fault+0x133/0x478
 [<c0151180>] pipe_wait+0x70/0x94
 [<c0119c98>] autoremove_wake_function+0x0/0x40
 [<c0119c98>] autoremove_wake_function+0x0/0x40
 [<c0151341>] pipe_read+0x19d/0x208
 [<c013cf60>] do_brk+0x190/0x1c0
 [<c0146cbc>] vfs_read+0x9c/0xcc
 [<c0146e9d>] sys_read+0x31/0x4c
 [<c0108b97>] syscall_call+0x7/0xb

ps            D 00000246 35955104 22160  20134         22163       (NOTLB)
Call Trace:
 [<c0107ad5>] __down+0x7d/0xe0
 [<c0118488>] default_wake_function+0x0/0x20
 [<c0107ca8>] __down_failed+0x8/0xc
 [<c0155173>] .text.lock.namei+0x5/0x172
 [<c015244c>] do_lookup+0x48/0x8c
 [<c01529e7>] link_path_walk+0x557/0x7fc
 [<c0152fb2>] path_lookup+0x156/0x15c
 [<c0153483>] open_namei+0x8b/0x3f0
 [<c0146163>] filp_open+0x3b/0x5c
 [<c0146523>] sys_open+0x37/0x78
 [<c0108b97>] syscall_call+0x7/0xb

wc            S EA37D52C 4274182448 22163  20134               22160 (NOTLB)
Call Trace:
 [<c0115e13>] do_page_fault+0x133/0x478
 [<c0151180>] pipe_wait+0x70/0x94
 [<c0119c98>] autoremove_wake_function+0x0/0x40
 [<c0119c98>] autoremove_wake_function+0x0/0x40
 [<c0151341>] pipe_read+0x19d/0x208
 [<c013cf60>] do_brk+0x190/0x1c0
 [<c0146cbc>] vfs_read+0x9c/0xcc
 [<c0146e9d>] sys_read+0x31/0x4c
 [<c0108b97>] syscall_call+0x7/0xb

ps            D 00000246 4235834348 22236  20151         22237       (NOTLB)
Call Trace:
 [<c0107ad5>] __down+0x7d/0xe0
 [<c0118488>] default_wake_function+0x0/0x20
 [<c0107ca8>] __down_failed+0x8/0xc
 [<c0155173>] .text.lock.namei+0x5/0x172
 [<c015244c>] do_lookup+0x48/0x8c
 [<c01529e7>] link_path_walk+0x557/0x7fc
 [<c0152fb2>] path_lookup+0x156/0x15c
 [<c0153483>] open_namei+0x8b/0x3f0
 [<c0146163>] filp_open+0x3b/0x5c
 [<c0146523>] sys_open+0x37/0x78
 [<c0108b97>] syscall_call+0x7/0xb

wc            S EB348A6C 4232220896 22237  20151               22236 (NOTLB)
Call Trace:
 [<c0115e13>] do_page_fault+0x133/0x478
 [<c0151180>] pipe_wait+0x70/0x94
 [<c0119c98>] autoremove_wake_function+0x0/0x40
 [<c0119c98>] autoremove_wake_function+0x0/0x40
 [<c0151341>] pipe_read+0x19d/0x208
 [<c013cf60>] do_brk+0x190/0x1c0
 [<c0146cbc>] vfs_read+0x9c/0xcc
 [<c0146e9d>] sys_read+0x31/0x4c
 [<c0108b97>] syscall_call+0x7/0xb

ps            D 00000246 4243970900 22370  20152         22375       (NOTLB)
Call Trace:
 [<c0109586>] apic_timer_interrupt+0x1a/0x20
 [<c0107ad5>] __down+0x7d/0xe0
 [<c0118488>] default_wake_function+0x0/0x20
 [<c0107ca8>] __down_failed+0x8/0xc
 [<c0155173>] .text.lock.namei+0x5/0x172
 [<c015244c>] do_lookup+0x48/0x8c
 [<c01529e7>] link_path_walk+0x557/0x7fc
 [<c0152fb2>] path_lookup+0x156/0x15c
 [<c0153483>] open_namei+0x8b/0x3f0
 [<c0146163>] filp_open+0x3b/0x5c
 [<c0146523>] sys_open+0x37/0x78
 [<c0108b97>] syscall_call+0x7/0xb

wc            S EBA7AC2C 4259782824 22375  20152               22370 (NOTLB)
Call Trace:
 [<c0115e13>] do_page_fault+0x133/0x478
 [<c0151180>] pipe_wait+0x70/0x94
 [<c0119c98>] autoremove_wake_function+0x0/0x40
 [<c0119c98>] autoremove_wake_function+0x0/0x40
 [<c0151341>] pipe_read+0x19d/0x208
 [<c013cf60>] do_brk+0x190/0x1c0
 [<c0146cbc>] vfs_read+0x9c/0xcc
 [<c0146e9d>] sys_read+0x31/0x4c
 [<c0108b97>] syscall_call+0x7/0xb

ps            D 00000246 4280657696 22393  20149         22397       (NOTLB)
Call Trace:
 [<c0107ad5>] __down+0x7d/0xe0
 [<c0118488>] default_wake_function+0x0/0x20
 [<c0107ca8>] __down_failed+0x8/0xc
 [<c0155173>] .text.lock.namei+0x5/0x172
 [<c015244c>] do_lookup+0x48/0x8c
 [<c01529e7>] link_path_walk+0x557/0x7fc
 [<c0152fb2>] path_lookup+0x156/0x15c
 [<c0153483>] open_namei+0x8b/0x3f0
 [<c0146163>] filp_open+0x3b/0x5c
 [<c0146523>] sys_open+0x37/0x78
 [<c0108b97>] syscall_call+0x7/0xb

wc            S EED91BCC 4293990672 22397  20149               22393 (NOTLB)
Call Trace:
 [<c0115e13>] do_page_fault+0x133/0x478
 [<c0151180>] pipe_wait+0x70/0x94
 [<c0119c98>] autoremove_wake_function+0x0/0x40
 [<c0119c98>] autoremove_wake_function+0x0/0x40
 [<c0151341>] pipe_read+0x19d/0x208
 [<c013cf60>] do_brk+0x190/0x1c0
 [<c0146cbc>] vfs_read+0x9c/0xcc
 [<c0146e9d>] sys_read+0x31/0x4c
 [<c0108b97>] syscall_call+0x7/0xb

ps            D 00000246 44189360 22440  20129         22444       (NOTLB)
Call Trace:
 [<c0107ad5>] __down+0x7d/0xe0
 [<c0118488>] default_wake_function+0x0/0x20
 [<c0107ca8>] __down_failed+0x8/0xc
 [<c0155173>] .text.lock.namei+0x5/0x172
 [<c015244c>] do_lookup+0x48/0x8c
 [<c01529e7>] link_path_walk+0x557/0x7fc
 [<c0152fb2>] path_lookup+0x156/0x15c
 [<c0153483>] open_namei+0x8b/0x3f0
 [<c0146163>] filp_open+0x3b/0x5c
 [<c0146523>] sys_open+0x37/0x78
 [<c0108b97>] syscall_call+0x7/0xb

wc            S EBA7AACC 20404468 22444  20129               22440 (NOTLB)
Call Trace:
 [<c0115e13>] do_page_fault+0x133/0x478
 [<c0151180>] pipe_wait+0x70/0x94
 [<c0119c98>] autoremove_wake_function+0x0/0x40
 [<c0119c98>] autoremove_wake_function+0x0/0x40
 [<c0151341>] pipe_read+0x19d/0x208
 [<c013cf60>] do_brk+0x190/0x1c0
 [<c0146cbc>] vfs_read+0x9c/0xcc
 [<c0146e9d>] sys_read+0x31/0x4c
 [<c0108b97>] syscall_call+0x7/0xb

ps            D 00000246 16295764 22609  20123         22611       (NOTLB)
Call Trace:
 [<c0107ad5>] __down+0x7d/0xe0
 [<c0118488>] default_wake_function+0x0/0x20
 [<c0107ca8>] __down_failed+0x8/0xc
 [<c0155173>] .text.lock.namei+0x5/0x172
 [<c015244c>] do_lookup+0x48/0x8c
 [<c01529e7>] link_path_walk+0x557/0x7fc
 [<c0152fb2>] path_lookup+0x156/0x15c
 [<c0153483>] open_namei+0x8b/0x3f0
 [<c0146163>] filp_open+0x3b/0x5c
 [<c0146523>] sys_open+0x37/0x78
 [<c0108b97>] syscall_call+0x7/0xb

wc            S EE37E10C 53439636 22611  20123               22609 (NOTLB)
Call Trace:
 [<c0115e13>] do_page_fault+0x133/0x478
 [<c0151180>] pipe_wait+0x70/0x94
 [<c0119c98>] autoremove_wake_function+0x0/0x40
 [<c0119c98>] autoremove_wake_function+0x0/0x40
 [<c0151341>] pipe_read+0x19d/0x208
 [<c013cf60>] do_brk+0x190/0x1c0
 [<c0146cbc>] vfs_read+0x9c/0xcc
 [<c0146e9d>] sys_read+0x31/0x4c
 [<c0108b97>] syscall_call+0x7/0xb

ps            D 00000246 40340816 22643  20125         22647       (NOTLB)
Call Trace:
 [<c0107ad5>] __down+0x7d/0xe0
 [<c0118488>] default_wake_function+0x0/0x20
 [<c0107ca8>] __down_failed+0x8/0xc
 [<c0155173>] .text.lock.namei+0x5/0x172
 [<c015244c>] do_lookup+0x48/0x8c
 [<c01529e7>] link_path_walk+0x557/0x7fc
 [<c0152fb2>] path_lookup+0x156/0x15c
 [<c0153483>] open_namei+0x8b/0x3f0
 [<c0146163>] filp_open+0x3b/0x5c
 [<c0146523>] sys_open+0x37/0x78
 [<c0108b97>] syscall_call+0x7/0xb

wc            S EB0CF50C 16680612 22647  20125               22643 (NOTLB)
Call Trace:
 [<c0115e13>] do_page_fault+0x133/0x478
 [<c0151180>] pipe_wait+0x70/0x94
 [<c0119c98>] autoremove_wake_function+0x0/0x40
 [<c0119c98>] autoremove_wake_function+0x0/0x40
 [<c0151341>] pipe_read+0x19d/0x208
 [<c013cf60>] do_brk+0x190/0x1c0
 [<c0146cbc>] vfs_read+0x9c/0xcc
 [<c0146e9d>] sys_read+0x31/0x4c
 [<c0108b97>] syscall_call+0x7/0xb

ps            D 00000246 4263438032 22675  20131         22678       (NOTLB)
Call Trace:
 [<c0109586>] apic_timer_interrupt+0x1a/0x20
 [<c0107ad5>] __down+0x7d/0xe0
 [<c0118488>] default_wake_function+0x0/0x20
 [<c0107ca8>] __down_failed+0x8/0xc
 [<c0155173>] .text.lock.namei+0x5/0x172
 [<c015244c>] do_lookup+0x48/0x8c
 [<c01529e7>] link_path_walk+0x557/0x7fc
 [<c0152fb2>] path_lookup+0x156/0x15c
 [<c0153483>] open_namei+0x8b/0x3f0
 [<c0146163>] filp_open+0x3b/0x5c
 [<c0146523>] sys_open+0x37/0x78
 [<c0108b97>] syscall_call+0x7/0xb

wc            S EE37EAAC 4233778048 22678  20131               22675 (NOTLB)
Call Trace:
 [<c0115e13>] do_page_fault+0x133/0x478
 [<c0151180>] pipe_wait+0x70/0x94
 [<c0119c98>] autoremove_wake_function+0x0/0x40
 [<c0119c98>] autoremove_wake_function+0x0/0x40
 [<c0151341>] pipe_read+0x19d/0x208
 [<c013cf60>] do_brk+0x190/0x1c0
 [<c0146cbc>] vfs_read+0x9c/0xcc
 [<c0146e9d>] sys_read+0x31/0x4c
 [<c0108b97>] syscall_call+0x7/0xb

cron          S EC1636AC 4285861040 22726    283 22727   22731       (NOTLB)
Call Trace:
 [<c0151180>] pipe_wait+0x70/0x94
 [<c0119c98>] autoremove_wake_function+0x0/0x40
 [<c0119c98>] autoremove_wake_function+0x0/0x40
 [<c0151341>] pipe_read+0x19d/0x208
 [<c010f045>] old_mmap+0xe9/0x124
 [<c0146cbc>] vfs_read+0x9c/0xcc
 [<c0146e9d>] sys_read+0x31/0x4c
 [<c0108b97>] syscall_call+0x7/0xb

sh            S EC6247DC 4289544864 22727  22726 22728               (NOTLB)
Call Trace:
 [<c011df78>] sys_wait4+0x20c/0x244
 [<c0118488>] default_wake_function+0x0/0x20
 [<c0118488>] default_wake_function+0x0/0x20
 [<c0108b97>] syscall_call+0x7/0xb

exim          D 00000246 21823664 22728  22727                     (NOTLB)
Call Trace:
 [<c012f439>] filemap_nopage+0x119/0x2ac
 [<c0107ad5>] __down+0x7d/0xe0
 [<c0118488>] default_wake_function+0x0/0x20
 [<c0107ca8>] __down_failed+0x8/0xc
 [<c0155173>] .text.lock.namei+0x5/0x172
 [<c015244c>] do_lookup+0x48/0x8c
 [<c01526d9>] link_path_walk+0x249/0x7fc
 [<c0152fb2>] path_lookup+0x156/0x15c
 [<c0153483>] open_namei+0x8b/0x3f0
 [<c0146163>] filp_open+0x3b/0x5c
 [<c0146523>] sys_open+0x37/0x78
 [<c0108b97>] syscall_call+0x7/0xb

cron          S EBA7A6AC 38930096 22731    283 22732   22736 22726 (NOTLB)
Call Trace:
 [<c0151180>] pipe_wait+0x70/0x94
 [<c0119c98>] autoremove_wake_function+0x0/0x40
 [<c0119c98>] autoremove_wake_function+0x0/0x40
 [<c0151341>] pipe_read+0x19d/0x208
 [<c010f045>] old_mmap+0xe9/0x124
 [<c0146cbc>] vfs_read+0x9c/0xcc
 [<c0146e9d>] sys_read+0x31/0x4c
 [<c0108b97>] syscall_call+0x7/0xb

sh            S EB9707BC 4276417344 22732  22731 22733               (NOTLB)
Call Trace:
 [<c011df78>] sys_wait4+0x20c/0x244
 [<c0118488>] default_wake_function+0x0/0x20
 [<c0118488>] default_wake_function+0x0/0x20
 [<c0108b97>] syscall_call+0x7/0xb

exim          D 00000246 13541728 22733  22732                     (NOTLB)
Call Trace:
 [<c012f439>] filemap_nopage+0x119/0x2ac
 [<c0107ad5>] __down+0x7d/0xe0
 [<c0118488>] default_wake_function+0x0/0x20
 [<c0107ca8>] __down_failed+0x8/0xc
 [<c0155173>] .text.lock.namei+0x5/0x172
 [<c015244c>] do_lookup+0x48/0x8c
 [<c01526d9>] link_path_walk+0x249/0x7fc
 [<c0152fb2>] path_lookup+0x156/0x15c
 [<c0153483>] open_namei+0x8b/0x3f0
 [<c0146163>] filp_open+0x3b/0x5c
 [<c0146523>] sys_open+0x37/0x78
 [<c0108b97>] syscall_call+0x7/0xb

cron          S EE37EECC 4244626592 22736    283 22737   22741 22731 (NOTLB)
Call Trace:
 [<c0151180>] pipe_wait+0x70/0x94
 [<c0119c98>] autoremove_wake_function+0x0/0x40
 [<c0119c98>] autoremove_wake_function+0x0/0x40
 [<c0151341>] pipe_read+0x19d/0x208
 [<c010f045>] old_mmap+0xe9/0x124
 [<c0146cbc>] vfs_read+0x9c/0xcc
 [<c0146e9d>] sys_read+0x31/0x4c
 [<c0108b97>] syscall_call+0x7/0xb

sh            S EA3D271C 4292289376 22737  22736 22738               (NOTLB)
Call Trace:
 [<c011df78>] sys_wait4+0x20c/0x244
 [<c0118488>] default_wake_function+0x0/0x20
 [<c0118488>] default_wake_function+0x0/0x20
 [<c0108b97>] syscall_call+0x7/0xb

exim          D 00000246 22333268 22738  22737                     (NOTLB)
Call Trace:
 [<c012f439>] filemap_nopage+0x119/0x2ac
 [<c0107ad5>] __down+0x7d/0xe0
 [<c0118488>] default_wake_function+0x0/0x20
 [<c0107ca8>] __down_failed+0x8/0xc
 [<c0155173>] .text.lock.namei+0x5/0x172
 [<c015244c>] do_lookup+0x48/0x8c
 [<c01526d9>] link_path_walk+0x249/0x7fc
 [<c0152fb2>] path_lookup+0x156/0x15c
 [<c0153483>] open_namei+0x8b/0x3f0
 [<c0146163>] filp_open+0x3b/0x5c
 [<c0146523>] sys_open+0x37/0x78
 [<c0108b97>] syscall_call+0x7/0xb

cron          S EB0CF3AC 4285831568 22741    283 22742   22746 22736 (NOTLB)
Call Trace:
 [<c0151180>] pipe_wait+0x70/0x94
 [<c0119c98>] autoremove_wake_function+0x0/0x40
 [<c0119c98>] autoremove_wake_function+0x0/0x40
 [<c0151341>] pipe_read+0x19d/0x208
 [<c010f045>] old_mmap+0xe9/0x124
 [<c0146cbc>] vfs_read+0x9c/0xcc
 [<c0146e9d>] sys_read+0x31/0x4c
 [<c0108b97>] syscall_call+0x7/0xb

sh            S EB4D399C 7258388 22742  22741 22743               (NOTLB)
Call Trace:
 [<c011df78>] sys_wait4+0x20c/0x244
 [<c0118488>] default_wake_function+0x0/0x20
 [<c0118488>] default_wake_function+0x0/0x20
 [<c0108b97>] syscall_call+0x7/0xb

exim          D 00000246 25650992 22743  22742                     (NOTLB)
Call Trace:
 [<c012f439>] filemap_nopage+0x119/0x2ac
 [<c0107ad5>] __down+0x7d/0xe0
 [<c0118488>] default_wake_function+0x0/0x20
 [<c0107ca8>] __down_failed+0x8/0xc
 [<c0155173>] .text.lock.namei+0x5/0x172
 [<c015244c>] do_lookup+0x48/0x8c
 [<c01526d9>] link_path_walk+0x249/0x7fc
 [<c0152fb2>] path_lookup+0x156/0x15c
 [<c0153483>] open_namei+0x8b/0x3f0
 [<c0146163>] filp_open+0x3b/0x5c
 [<c0146523>] sys_open+0x37/0x78
 [<c0108b97>] syscall_call+0x7/0xb

cron          S EC55538C 53226672 22746    283 22747   22751 22741 (NOTLB)
Call Trace:
 [<c0151180>] pipe_wait+0x70/0x94
 [<c0119c98>] autoremove_wake_function+0x0/0x40
 [<c0119c98>] autoremove_wake_function+0x0/0x40
 [<c0151341>] pipe_read+0x19d/0x208
 [<c010f045>] old_mmap+0xe9/0x124
 [<c0146cbc>] vfs_read+0x9c/0xcc
 [<c0146e9d>] sys_read+0x31/0x4c
 [<c0108b97>] syscall_call+0x7/0xb

sh            S EBA3BA3C 4283539568 22747  22746 22748               (NOTLB)
Call Trace:
 [<c011df78>] sys_wait4+0x20c/0x244
 [<c0118488>] default_wake_function+0x0/0x20
 [<c0118488>] default_wake_function+0x0/0x20
 [<c0108b97>] syscall_call+0x7/0xb

exim          D 00000246 4246514992 22748  22747                     (NOTLB)
Call Trace:
 [<c012f439>] filemap_nopage+0x119/0x2ac
 [<c0107ad5>] __down+0x7d/0xe0
 [<c0118488>] default_wake_function+0x0/0x20
 [<c0107ca8>] __down_failed+0x8/0xc
 [<c0155173>] .text.lock.namei+0x5/0x172
 [<c015244c>] do_lookup+0x48/0x8c
 [<c01526d9>] link_path_walk+0x249/0x7fc
 [<c0152fb2>] path_lookup+0x156/0x15c
 [<c0153483>] open_namei+0x8b/0x3f0
 [<c0146163>] filp_open+0x3b/0x5c
 [<c0146523>] sys_open+0x37/0x78
 [<c0108b97>] syscall_call+0x7/0xb

cron          S EB439A8C 4291723568 22751    283 22752   22756 22746 (NOTLB)
Call Trace:
 [<c0151180>] pipe_wait+0x70/0x94
 [<c0119c98>] autoremove_wake_function+0x0/0x40
 [<c0119c98>] autoremove_wake_function+0x0/0x40
 [<c0151341>] pipe_read+0x19d/0x208
 [<c010f045>] old_mmap+0xe9/0x124
 [<c0146cbc>] vfs_read+0x9c/0xcc
 [<c0146e9d>] sys_read+0x31/0x4c
 [<c0108b97>] syscall_call+0x7/0xb

sh            S EBD6995C 5906768 22752  22751 22753               (NOTLB)
Call Trace:
 [<c011df78>] sys_wait4+0x20c/0x244
 [<c0118488>] default_wake_function+0x0/0x20
 [<c0118488>] default_wake_function+0x0/0x20
 [<c0108b97>] syscall_call+0x7/0xb

exim          D 00000246 4712320 22753  22752                     (NOTLB)
Call Trace:
 [<c012f439>] filemap_nopage+0x119/0x2ac
 [<c0107ad5>] __down+0x7d/0xe0
 [<c0118488>] default_wake_function+0x0/0x20
 [<c0107ca8>] __down_failed+0x8/0xc
 [<c0155173>] .text.lock.namei+0x5/0x172
 [<c015244c>] do_lookup+0x48/0x8c
 [<c01526d9>] link_path_walk+0x249/0x7fc
 [<c0152fb2>] path_lookup+0x156/0x15c
 [<c0153483>] open_namei+0x8b/0x3f0
 [<c0146163>] filp_open+0x3b/0x5c
 [<c0146523>] sys_open+0x37/0x78
 [<c0108b97>] syscall_call+0x7/0xb

cron          S EC16380C 4287599312 22756    283 22757   22761 22751 (NOTLB)
Call Trace:
 [<c0151180>] pipe_wait+0x70/0x94
 [<c0119c98>] autoremove_wake_function+0x0/0x40
 [<c0119c98>] autoremove_wake_function+0x0/0x40
 [<c0151341>] pipe_read+0x19d/0x208
 [<c010f045>] old_mmap+0xe9/0x124
 [<c0146cbc>] vfs_read+0x9c/0xcc
 [<c0146e9d>] sys_read+0x31/0x4c
 [<c0108b97>] syscall_call+0x7/0xb

sh            S EAB86DFC 7310592 22757  22756 22758               (NOTLB)
Call Trace:
 [<c011df78>] sys_wait4+0x20c/0x244
 [<c0118488>] default_wake_function+0x0/0x20
 [<c0118488>] default_wake_function+0x0/0x20
 [<c0108b97>] syscall_call+0x7/0xb

exim          D 00000246 4240557744 22758  22757                     (NOTLB)
Call Trace:
 [<c012f439>] filemap_nopage+0x119/0x2ac
 [<c0107ad5>] __down+0x7d/0xe0
 [<c0118488>] default_wake_function+0x0/0x20
 [<c0107ca8>] __down_failed+0x8/0xc
 [<c0155173>] .text.lock.namei+0x5/0x172
 [<c015244c>] do_lookup+0x48/0x8c
 [<c01526d9>] link_path_walk+0x249/0x7fc
 [<c0152fb2>] path_lookup+0x156/0x15c
 [<c0153483>] open_namei+0x8b/0x3f0
 [<c0146163>] filp_open+0x3b/0x5c
 [<c0146523>] sys_open+0x37/0x78
 [<c0108b97>] syscall_call+0x7/0xb

cron          S ED952C2C 75768592 22761    283 22762   22766 22756 (NOTLB)
Call Trace:
 [<c0151180>] pipe_wait+0x70/0x94
 [<c0119c98>] autoremove_wake_function+0x0/0x40
 [<c0119c98>] autoremove_wake_function+0x0/0x40
 [<c0151341>] pipe_read+0x19d/0x208
 [<c010f045>] old_mmap+0xe9/0x124
 [<c0146cbc>] vfs_read+0x9c/0xcc
 [<c0146e9d>] sys_read+0x31/0x4c
 [<c0108b97>] syscall_call+0x7/0xb

sh            S EA4CA15C 17643856 22762  22761 22763               (NOTLB)
Call Trace:
 [<c011df78>] sys_wait4+0x20c/0x244
 [<c0118488>] default_wake_function+0x0/0x20
 [<c0118488>] default_wake_function+0x0/0x20
 [<c0108b97>] syscall_call+0x7/0xb

exim          D 00000246 4233665888 22763  22762                     (NOTLB)
Call Trace:
 [<c012f439>] filemap_nopage+0x119/0x2ac
 [<c0107ad5>] __down+0x7d/0xe0
 [<c0118488>] default_wake_function+0x0/0x20
 [<c0107ca8>] __down_failed+0x8/0xc
 [<c0155173>] .text.lock.namei+0x5/0x172
 [<c015244c>] do_lookup+0x48/0x8c
 [<c01526d9>] link_path_walk+0x249/0x7fc
 [<c0152fb2>] path_lookup+0x156/0x15c
 [<c0153483>] open_namei+0x8b/0x3f0
 [<c0146163>] filp_open+0x3b/0x5c
 [<c0146523>] sys_open+0x37/0x78
 [<c0108b97>] syscall_call+0x7/0xb

cron          S EB348E8C 4293228976 22766    283 22767   22771 22761 (NOTLB)
Call Trace:
 [<c0151180>] pipe_wait+0x70/0x94
 [<c0119c98>] autoremove_wake_function+0x0/0x40
 [<c0119c98>] autoremove_wake_function+0x0/0x40
 [<c0151341>] pipe_read+0x19d/0x208
 [<c010f045>] old_mmap+0xe9/0x124
 [<c0146cbc>] vfs_read+0x9c/0xcc
 [<c0146e9d>] sys_read+0x31/0x4c
 [<c0108b97>] syscall_call+0x7/0xb

sh            S EEDDED7C 4252962104 22767  22766 22768               (NOTLB)
Call Trace:
 [<c011df78>] sys_wait4+0x20c/0x244
 [<c0118488>] default_wake_function+0x0/0x20
 [<c0118488>] default_wake_function+0x0/0x20
 [<c0108b97>] syscall_call+0x7/0xb

exim          D 00000246 4232917840 22768  22767                     (NOTLB)
Call Trace:
 [<c012f439>] filemap_nopage+0x119/0x2ac
 [<c0107ad5>] __down+0x7d/0xe0
 [<c0118488>] default_wake_function+0x0/0x20
 [<c0107ca8>] __down_failed+0x8/0xc
 [<c0155173>] .text.lock.namei+0x5/0x172
 [<c015244c>] do_lookup+0x48/0x8c
 [<c01526d9>] link_path_walk+0x249/0x7fc
 [<c0152fb2>] path_lookup+0x156/0x15c
 [<c0153483>] open_namei+0x8b/0x3f0
 [<c0146163>] filp_open+0x3b/0x5c
 [<c0146523>] sys_open+0x37/0x78
 [<c0108b97>] syscall_call+0x7/0xb

cron          S EB0CF92C 4267889456 22771    283 22772   22776 22766 (NOTLB)
Call Trace:
 [<c0151180>] pipe_wait+0x70/0x94
 [<c0119c98>] autoremove_wake_function+0x0/0x40
 [<c0119c98>] autoremove_wake_function+0x0/0x40
 [<c0151341>] pipe_read+0x19d/0x208
 [<c010f045>] old_mmap+0xe9/0x124
 [<c0146cbc>] vfs_read+0x9c/0xcc
 [<c0146e9d>] sys_read+0x31/0x4c
 [<c0108b97>] syscall_call+0x7/0xb

sh            S EB8C59DC 32989600 22772  22771 22773               (NOTLB)
Call Trace:
 [<c011df78>] sys_wait4+0x20c/0x244
 [<c0118488>] default_wake_function+0x0/0x20
 [<c0118488>] default_wake_function+0x0/0x20
 [<c0108b97>] syscall_call+0x7/0xb

exim          D 00000246 12086624 22773  22772                     (NOTLB)
Call Trace:
 [<c012f439>] filemap_nopage+0x119/0x2ac
 [<c0107ad5>] __down+0x7d/0xe0
 [<c0118488>] default_wake_function+0x0/0x20
 [<c0107ca8>] __down_failed+0x8/0xc
 [<c0155173>] .text.lock.namei+0x5/0x172
 [<c015244c>] do_lookup+0x48/0x8c
 [<c01526d9>] link_path_walk+0x249/0x7fc
 [<c0152fb2>] path_lookup+0x156/0x15c
 [<c0153483>] open_namei+0x8b/0x3f0
 [<c0146163>] filp_open+0x3b/0x5c
 [<c0146523>] sys_open+0x37/0x78
 [<c0108b97>] syscall_call+0x7/0xb

cron          S EA37DECC 9664896 22776    283 22777   22781 22771 (NOTLB)
Call Trace:
 [<c0151180>] pipe_wait+0x70/0x94
 [<c0119c98>] autoremove_wake_function+0x0/0x40
 [<c0119c98>] autoremove_wake_function+0x0/0x40
 [<c0151341>] pipe_read+0x19d/0x208
 [<c010f045>] old_mmap+0xe9/0x124
 [<c0146cbc>] vfs_read+0x9c/0xcc
 [<c0146e9d>] sys_read+0x31/0x4c
 [<c0108b97>] syscall_call+0x7/0xb

sh            S EA594E1C 31902864 22777  22776 22778               (NOTLB)
Call Trace:
 [<c011df78>] sys_wait4+0x20c/0x244
 [<c0118488>] default_wake_function+0x0/0x20
 [<c0118488>] default_wake_function+0x0/0x20
 [<c0108b97>] syscall_call+0x7/0xb

exim          D 00000246 4288115376 22778  22777                     (NOTLB)
Call Trace:
 [<c012f439>] filemap_nopage+0x119/0x2ac
 [<c0107ad5>] __down+0x7d/0xe0
 [<c0118488>] default_wake_function+0x0/0x20
 [<c0107ca8>] __down_failed+0x8/0xc
 [<c0155173>] .text.lock.namei+0x5/0x172
 [<c015244c>] do_lookup+0x48/0x8c
 [<c01526d9>] link_path_walk+0x249/0x7fc
 [<c0152fb2>] path_lookup+0x156/0x15c
 [<c0153483>] open_namei+0x8b/0x3f0
 [<c0146163>] filp_open+0x3b/0x5c
 [<c0146523>] sys_open+0x37/0x78
 [<c0108b97>] syscall_call+0x7/0xb

cron          S EDB98A6C 4262381824 22781    283 22782   22786 22776 (NOTLB)
Call Trace:
 [<c0151180>] pipe_wait+0x70/0x94
 [<c0119c98>] autoremove_wake_function+0x0/0x40
 [<c0119c98>] autoremove_wake_function+0x0/0x40
 [<c0151341>] pipe_read+0x19d/0x208
 [<c010f045>] old_mmap+0xe9/0x124
 [<c0146cbc>] vfs_read+0x9c/0xcc
 [<c0146e9d>] sys_read+0x31/0x4c
 [<c0108b97>] syscall_call+0x7/0xb

sh            S EC26875C 4258435924 22782  22781 22783               (NOTLB)
Call Trace:
 [<c011df78>] sys_wait4+0x20c/0x244
 [<c0118488>] default_wake_function+0x0/0x20
 [<c0118488>] default_wake_function+0x0/0x20
 [<c0108b97>] syscall_call+0x7/0xb

exim          D 00000246 4258843960 22783  22782                     (NOTLB)
Call Trace:
 [<c012f439>] filemap_nopage+0x119/0x2ac
 [<c0107ad5>] __down+0x7d/0xe0
 [<c0118488>] default_wake_function+0x0/0x20
 [<c0107ca8>] __down_failed+0x8/0xc
 [<c0155173>] .text.lock.namei+0x5/0x172
 [<c015244c>] do_lookup+0x48/0x8c
 [<c01526d9>] link_path_walk+0x249/0x7fc
 [<c0152fb2>] path_lookup+0x156/0x15c
 [<c0153483>] open_namei+0x8b/0x3f0
 [<c0146163>] filp_open+0x3b/0x5c
 [<c0146523>] sys_open+0x37/0x78
 [<c0108b97>] syscall_call+0x7/0xb

cron          S EED9190C 12784404 22786    283 22787   22791 22781 (NOTLB)
Call Trace:
 [<c0151180>] pipe_wait+0x70/0x94
 [<c0119c98>] autoremove_wake_function+0x0/0x40
 [<c0119c98>] autoremove_wake_function+0x0/0x40
 [<c0151341>] pipe_read+0x19d/0x208
 [<c010f045>] old_mmap+0xe9/0x124
 [<c0146cbc>] vfs_read+0x9c/0xcc
 [<c0146e9d>] sys_read+0x31/0x4c
 [<c0108b97>] syscall_call+0x7/0xb

sh            S EAA941DC 36083920 22787  22786 22788               (NOTLB)
Call Trace:
 [<c011df78>] sys_wait4+0x20c/0x244
 [<c0118488>] default_wake_function+0x0/0x20
 [<c0118488>] default_wake_function+0x0/0x20
 [<c0108b97>] syscall_call+0x7/0xb

exim          D 00000246 5560936 22788  22787                     (NOTLB)
Call Trace:
 [<c012f439>] filemap_nopage+0x119/0x2ac
 [<c0107ad5>] __down+0x7d/0xe0
 [<c0118488>] default_wake_function+0x0/0x20
 [<c0107ca8>] __down_failed+0x8/0xc
 [<c0155173>] .text.lock.namei+0x5/0x172
 [<c015244c>] do_lookup+0x48/0x8c
 [<c01526d9>] link_path_walk+0x249/0x7fc
 [<c0152fb2>] path_lookup+0x156/0x15c
 [<c0153483>] open_namei+0x8b/0x3f0
 [<c0146163>] filp_open+0x3b/0x5c
 [<c0146523>] sys_open+0x37/0x78
 [<c0108b97>] syscall_call+0x7/0xb

cron          S EBA7A12C 4262266640 22791    283 22792   22796 22786 (NOTLB)
Call Trace:
 [<c0151180>] pipe_wait+0x70/0x94
 [<c0119c98>] autoremove_wake_function+0x0/0x40
 [<c0119c98>] autoremove_wake_function+0x0/0x40
 [<c0151341>] pipe_read+0x19d/0x208
 [<c010f045>] old_mmap+0xe9/0x124
 [<c0146cbc>] vfs_read+0x9c/0xcc
 [<c0146e9d>] sys_read+0x31/0x4c
 [<c0108b97>] syscall_call+0x7/0xb

sh            S ED518D5C 4251127120 22792  22791 22793               (NOTLB)
Call Trace:
 [<c011df78>] sys_wait4+0x20c/0x244
 [<c0118488>] default_wake_function+0x0/0x20
 [<c0118488>] default_wake_function+0x0/0x20
 [<c0108b97>] syscall_call+0x7/0xb

exim          D 00000246 4250819072 22793  22792                     (NOTLB)
Call Trace:
 [<c012f439>] filemap_nopage+0x119/0x2ac
 [<c0107ad5>] __down+0x7d/0xe0
 [<c0118488>] default_wake_function+0x0/0x20
 [<c0107ca8>] __down_failed+0x8/0xc
 [<c0155173>] .text.lock.namei+0x5/0x172
 [<c015244c>] do_lookup+0x48/0x8c
 [<c01526d9>] link_path_walk+0x249/0x7fc
 [<c0152fb2>] path_lookup+0x156/0x15c
 [<c0153483>] open_namei+0x8b/0x3f0
 [<c0146163>] filp_open+0x3b/0x5c
 [<c0146523>] sys_open+0x37/0x78
 [<c0108b97>] syscall_call+0x7/0xb

cron          S EE37E7EC 4222859640 22796    283 22797   22801 22791 (NOTLB)
Call Trace:
 [<c0151180>] pipe_wait+0x70/0x94
 [<c0119c98>] autoremove_wake_function+0x0/0x40
 [<c0119c98>] autoremove_wake_function+0x0/0x40
 [<c0151341>] pipe_read+0x19d/0x208
 [<c010f045>] old_mmap+0xe9/0x124
 [<c0146cbc>] vfs_read+0x9c/0xcc
 [<c0146e9d>] sys_read+0x31/0x4c
 [<c0108b97>] syscall_call+0x7/0xb

sh            S EC8419FC 4277072000 22797  22796 22798               (NOTLB)
Call Trace:
 [<c011df78>] sys_wait4+0x20c/0x244
 [<c0118488>] default_wake_function+0x0/0x20
 [<c0118488>] default_wake_function+0x0/0x20
 [<c0108b97>] syscall_call+0x7/0xb

exim          D 00000246 17454752 22798  22797                     (NOTLB)
Call Trace:
 [<c012f439>] filemap_nopage+0x119/0x2ac
 [<c0107ad5>] __down+0x7d/0xe0
 [<c0118488>] default_wake_function+0x0/0x20
 [<c0107ca8>] __down_failed+0x8/0xc
 [<c0155173>] .text.lock.namei+0x5/0x172
 [<c015244c>] do_lookup+0x48/0x8c
 [<c01526d9>] link_path_walk+0x249/0x7fc
 [<c0152fb2>] path_lookup+0x156/0x15c
 [<c0153483>] open_namei+0x8b/0x3f0
 [<c0146163>] filp_open+0x3b/0x5c
 [<c0146523>] sys_open+0x37/0x78
 [<c0108b97>] syscall_call+0x7/0xb

cron          S EB0CFA8C 5746000 22801    283 22802   22806 22796 (NOTLB)
Call Trace:
 [<c0151180>] pipe_wait+0x70/0x94
 [<c0119c98>] autoremove_wake_function+0x0/0x40
 [<c0119c98>] autoremove_wake_function+0x0/0x40
 [<c0151341>] pipe_read+0x19d/0x208
 [<c010f045>] old_mmap+0xe9/0x124
 [<c0146cbc>] vfs_read+0x9c/0xcc
 [<c0146e9d>] sys_read+0x31/0x4c
 [<c0108b97>] syscall_call+0x7/0xb

sh            S EA14737C 36685696 22802  22801 22803               (NOTLB)
Call Trace:
 [<c0122296>] update_wall_time+0x12/0x3c
 [<c012255f>] do_timer+0x2b/0xac
 [<c011df78>] sys_wait4+0x20c/0x244
 [<c0118488>] default_wake_function+0x0/0x20
 [<c0118488>] default_wake_function+0x0/0x20
 [<c0108b97>] syscall_call+0x7/0xb

exim          D 00000246 4254611808 22803  22802                     (NOTLB)
Call Trace:
 [<c012f439>] filemap_nopage+0x119/0x2ac
 [<c0107ad5>] __down+0x7d/0xe0
 [<c0118488>] default_wake_function+0x0/0x20
 [<c0107ca8>] __down_failed+0x8/0xc
 [<c0155173>] .text.lock.namei+0x5/0x172
 [<c015244c>] do_lookup+0x48/0x8c
 [<c01526d9>] link_path_walk+0x249/0x7fc
 [<c0152fb2>] path_lookup+0x156/0x15c
 [<c0153483>] open_namei+0x8b/0x3f0
 [<c0146163>] filp_open+0x3b/0x5c
 [<c0146523>] sys_open+0x37/0x78
 [<c0108b97>] syscall_call+0x7/0xb

cron          S EDB98E8C 40505440 22806    283 22807   22811 22801 (NOTLB)
Call Trace:
 [<c0151180>] pipe_wait+0x70/0x94
 [<c0119c98>] autoremove_wake_function+0x0/0x40
 [<c0119c98>] autoremove_wake_function+0x0/0x40
 [<c0151341>] pipe_read+0x19d/0x208
 [<c010f045>] old_mmap+0xe9/0x124
 [<c0146cbc>] vfs_read+0x9c/0xcc
 [<c0146e9d>] sys_read+0x31/0x4c
 [<c0108b97>] syscall_call+0x7/0xb

sh            S E9EF4DDC 56732880 22807  22806 22808               (NOTLB)
Call Trace:
 [<c011df78>] sys_wait4+0x20c/0x244
 [<c0118488>] default_wake_function+0x0/0x20
 [<c0118488>] default_wake_function+0x0/0x20
 [<c0108b97>] syscall_call+0x7/0xb

exim          D 00000246 72704864 22808  22807                     (NOTLB)
Call Trace:
 [<c012f439>] filemap_nopage+0x119/0x2ac
 [<c0107ad5>] __down+0x7d/0xe0
 [<c0118488>] default_wake_function+0x0/0x20
 [<c0107ca8>] __down_failed+0x8/0xc
 [<c0155173>] .text.lock.namei+0x5/0x172
 [<c015244c>] do_lookup+0x48/0x8c
 [<c01526d9>] link_path_walk+0x249/0x7fc
 [<c0152fb2>] path_lookup+0x156/0x15c
 [<c0153483>] open_namei+0x8b/0x3f0
 [<c0146163>] filp_open+0x3b/0x5c
 [<c0146523>] sys_open+0x37/0x78
 [<c0108b97>] syscall_call+0x7/0xb

cron          S EED914EC 6250656 22811    283 22812   22816 22806 (NOTLB)
Call Trace:
 [<c0151180>] pipe_wait+0x70/0x94
 [<c0119c98>] autoremove_wake_function+0x0/0x40
 [<c0119c98>] autoremove_wake_function+0x0/0x40
 [<c0151341>] pipe_read+0x19d/0x208
 [<c010f045>] old_mmap+0xe9/0x124
 [<c0146cbc>] vfs_read+0x9c/0xcc
 [<c0146e9d>] sys_read+0x31/0x4c
 [<c0108b97>] syscall_call+0x7/0xb

sh            S EDC1619C 4266957072 22812  22811 22813               (NOTLB)
Call Trace:
 [<c011df78>] sys_wait4+0x20c/0x244
 [<c0118488>] default_wake_function+0x0/0x20
 [<c0118488>] default_wake_function+0x0/0x20
 [<c0108b97>] syscall_call+0x7/0xb

exim          D 00000246 4281451392 22813  22812                     (NOTLB)
Call Trace:
 [<c012f439>] filemap_nopage+0x119/0x2ac
 [<c0107ad5>] __down+0x7d/0xe0
 [<c0118488>] default_wake_function+0x0/0x20
 [<c0107ca8>] __down_failed+0x8/0xc
 [<c0155173>] .text.lock.namei+0x5/0x172
 [<c015244c>] do_lookup+0x48/0x8c
 [<c01526d9>] link_path_walk+0x249/0x7fc
 [<c0152fb2>] path_lookup+0x156/0x15c
 [<c0153483>] open_namei+0x8b/0x3f0
 [<c0146163>] filp_open+0x3b/0x5c
 [<c0146523>] sys_open+0x37/0x78
 [<c0108b97>] syscall_call+0x7/0xb

cron          S EBA7A96C 4612352 22816    283 22817   22821 22811 (NOTLB)
Call Trace:
 [<c0151180>] pipe_wait+0x70/0x94
 [<c0119c98>] autoremove_wake_function+0x0/0x40
 [<c0119c98>] autoremove_wake_function+0x0/0x40
 [<c0151341>] pipe_read+0x19d/0x208
 [<c010f045>] old_mmap+0xe9/0x124
 [<c0146cbc>] vfs_read+0x9c/0xcc
 [<c0146e9d>] sys_read+0x31/0x4c
 [<c0108b97>] syscall_call+0x7/0xb

sh            S EBF7471C 4271248288 22817  22816 22818               (NOTLB)
Call Trace:
 [<c011df78>] sys_wait4+0x20c/0x244
 [<c0118488>] default_wake_function+0x0/0x20
 [<c0118488>] default_wake_function+0x0/0x20
 [<c0108b97>] syscall_call+0x7/0xb

exim          D 00000246 4261599776 22818  22817                     (NOTLB)
Call Trace:
 [<c012f439>] filemap_nopage+0x119/0x2ac
 [<c0107ad5>] __down+0x7d/0xe0
 [<c0118488>] default_wake_function+0x0/0x20
 [<c0107ca8>] __down_failed+0x8/0xc
 [<c0155173>] .text.lock.namei+0x5/0x172
 [<c015244c>] do_lookup+0x48/0x8c
 [<c01526d9>] link_path_walk+0x249/0x7fc
 [<c0152fb2>] path_lookup+0x156/0x15c
 [<c0153483>] open_namei+0x8b/0x3f0
 [<c0146163>] filp_open+0x3b/0x5c
 [<c0146523>] sys_open+0x37/0x78
 [<c0108b97>] syscall_call+0x7/0xb

cron          S EE59B3AC 7400904 22821    283 22822   22826 22816 (NOTLB)
Call Trace:
 [<c0151180>] pipe_wait+0x70/0x94
 [<c0119c98>] autoremove_wake_function+0x0/0x40
 [<c0119c98>] autoremove_wake_function+0x0/0x40
 [<c0151341>] pipe_read+0x19d/0x208
 [<c010f045>] old_mmap+0xe9/0x124
 [<c0146cbc>] vfs_read+0x9c/0xcc
 [<c0146e9d>] sys_read+0x31/0x4c
 [<c0108b97>] syscall_call+0x7/0xb

sh            S EA1AE0DC 33520080 22822  22821 22823               (NOTLB)
Call Trace:
 [<c011df78>] sys_wait4+0x20c/0x244
 [<c0118488>] default_wake_function+0x0/0x20
 [<c0118488>] default_wake_function+0x0/0x20
 [<c0108b97>] syscall_call+0x7/0xb

exim          D 00000246 483712 22823  22822                     (NOTLB)
Call Trace:
 [<c012f439>] filemap_nopage+0x119/0x2ac
 [<c0107ad5>] __down+0x7d/0xe0
 [<c0118488>] default_wake_function+0x0/0x20
 [<c0107ca8>] __down_failed+0x8/0xc
 [<c0155173>] .text.lock.namei+0x5/0x172
 [<c015244c>] do_lookup+0x48/0x8c
 [<c01526d9>] link_path_walk+0x249/0x7fc
 [<c0152fb2>] path_lookup+0x156/0x15c
 [<c0153483>] open_namei+0x8b/0x3f0
 [<c0146163>] filp_open+0x3b/0x5c
 [<c0146523>] sys_open+0x37/0x78
 [<c0108b97>] syscall_call+0x7/0xb

cron          S EC555A6C 4271785920 22826    283 22827   22831 22821 (NOTLB)
Call Trace:
 [<c0151180>] pipe_wait+0x70/0x94
 [<c0119c98>] autoremove_wake_function+0x0/0x40
 [<c0119c98>] autoremove_wake_function+0x0/0x40
 [<c0151341>] pipe_read+0x19d/0x208
 [<c010f045>] old_mmap+0xe9/0x124
 [<c0146cbc>] vfs_read+0x9c/0xcc
 [<c0146e9d>] sys_read+0x31/0x4c
 [<c0108b97>] syscall_call+0x7/0xb

sh            S EC15795C 4272341328 22827  22826 22828               (NOTLB)
Call Trace:
 [<c011df78>] sys_wait4+0x20c/0x244
 [<c0118488>] default_wake_function+0x0/0x20
 [<c0118488>] default_wake_function+0x0/0x20
 [<c0108b97>] syscall_call+0x7/0xb

exim          D 00000246 4284977936 22828  22827                     (NOTLB)
Call Trace:
 [<c012f439>] filemap_nopage+0x119/0x2ac
 [<c0107ad5>] __down+0x7d/0xe0
 [<c0118488>] default_wake_function+0x0/0x20
 [<c0107ca8>] __down_failed+0x8/0xc
 [<c0155173>] .text.lock.namei+0x5/0x172
 [<c015244c>] do_lookup+0x48/0x8c
 [<c01526d9>] link_path_walk+0x249/0x7fc
 [<c0152fb2>] path_lookup+0x156/0x15c
 [<c0153483>] open_namei+0x8b/0x3f0
 [<c0146163>] filp_open+0x3b/0x5c
 [<c0146523>] sys_open+0x37/0x78
 [<c0108b97>] syscall_call+0x7/0xb

cron          S EF5A112C 21771152 22831    283 22832   22836 22826 (NOTLB)
Call Trace:
 [<c0151180>] pipe_wait+0x70/0x94
 [<c0119c98>] autoremove_wake_function+0x0/0x40
 [<c0119c98>] autoremove_wake_function+0x0/0x40
 [<c0151341>] pipe_read+0x19d/0x208
 [<c010f045>] old_mmap+0xe9/0x124
 [<c0146cbc>] vfs_read+0x9c/0xcc
 [<c0146e9d>] sys_read+0x31/0x4c
 [<c0108b97>] syscall_call+0x7/0xb

sh            S ECCBAD3C 1715584 22832  22831 22833               (NOTLB)
Call Trace:
 [<c011df78>] sys_wait4+0x20c/0x244
 [<c0118488>] default_wake_function+0x0/0x20
 [<c0118488>] default_wake_function+0x0/0x20
 [<c0108b97>] syscall_call+0x7/0xb

exim          D 00000246 4271765876 22833  22832                     (NOTLB)
Call Trace:
 [<c012f439>] filemap_nopage+0x119/0x2ac
 [<c0107ad5>] __down+0x7d/0xe0
 [<c0118488>] default_wake_function+0x0/0x20
 [<c0107ca8>] __down_failed+0x8/0xc
 [<c0155173>] .text.lock.namei+0x5/0x172
 [<c015244c>] do_lookup+0x48/0x8c
 [<c01526d9>] link_path_walk+0x249/0x7fc
 [<c0152fb2>] path_lookup+0x156/0x15c
 [<c0153483>] open_namei+0x8b/0x3f0
 [<c0146163>] filp_open+0x3b/0x5c
 [<c0146523>] sys_open+0x37/0x78
 [<c0108b97>] syscall_call+0x7/0xb

cron          S ED95254C 4285009184 22836    283 22837   22841 22831 (NOTLB)
Call Trace:
 [<c0151180>] pipe_wait+0x70/0x94
 [<c0119c98>] autoremove_wake_function+0x0/0x40
 [<c0119c98>] autoremove_wake_function+0x0/0x40
 [<c0151341>] pipe_read+0x19d/0x208
 [<c010f045>] old_mmap+0xe9/0x124
 [<c0146cbc>] vfs_read+0x9c/0xcc
 [<c0146e9d>] sys_read+0x31/0x4c
 [<c0108b97>] syscall_call+0x7/0xb

sh            S EAA9543C 67413616 22837  22836 22838               (NOTLB)
Call Trace:
 [<c011df78>] sys_wait4+0x20c/0x244
 [<c0118488>] default_wake_function+0x0/0x20
 [<c0118488>] default_wake_function+0x0/0x20
 [<c0108b97>] syscall_call+0x7/0xb

exim          D 00000246 4292788336 22838  22837                     (NOTLB)
Call Trace:
 [<c012f439>] filemap_nopage+0x119/0x2ac
 [<c0107ad5>] __down+0x7d/0xe0
 [<c0118488>] default_wake_function+0x0/0x20
 [<c0107ca8>] __down_failed+0x8/0xc
 [<c0155173>] .text.lock.namei+0x5/0x172
 [<c015244c>] do_lookup+0x48/0x8c
 [<c01526d9>] link_path_walk+0x249/0x7fc
 [<c0152fb2>] path_lookup+0x156/0x15c
 [<c0153483>] open_namei+0x8b/0x3f0
 [<c0146163>] filp_open+0x3b/0x5c
 [<c0146523>] sys_open+0x37/0x78
 [<c0108b97>] syscall_call+0x7/0xb

cron          S EE59B24C 4233101800 22841    283 22842   22846 22836 (NOTLB)
Call Trace:
 [<c0151180>] pipe_wait+0x70/0x94
 [<c0119c98>] autoremove_wake_function+0x0/0x40
 [<c0119c98>] autoremove_wake_function+0x0/0x40
 [<c0151341>] pipe_read+0x19d/0x208
 [<c010f045>] old_mmap+0xe9/0x124
 [<c0146cbc>] vfs_read+0x9c/0xcc
 [<c0146e9d>] sys_read+0x31/0x4c
 [<c0108b97>] syscall_call+0x7/0xb

sh            S EEAAA73C 4238406624 22842  22841 22843               (NOTLB)
Call Trace:
 [<c011df78>] sys_wait4+0x20c/0x244
 [<c0118488>] default_wake_function+0x0/0x20
 [<c0118488>] default_wake_function+0x0/0x20
 [<c0108b97>] syscall_call+0x7/0xb

exim          D 00000246 4258678640 22843  22842                     (NOTLB)
Call Trace:
 [<c012f439>] filemap_nopage+0x119/0x2ac
 [<c0107ad5>] __down+0x7d/0xe0
 [<c0118488>] default_wake_function+0x0/0x20
 [<c0107ca8>] __down_failed+0x8/0xc
 [<c0155173>] .text.lock.namei+0x5/0x172
 [<c015244c>] do_lookup+0x48/0x8c
 [<c01526d9>] link_path_walk+0x249/0x7fc
 [<c0152fb2>] path_lookup+0x156/0x15c
 [<c0153483>] open_namei+0x8b/0x3f0
 [<c0146163>] filp_open+0x3b/0x5c
 [<c0146523>] sys_open+0x37/0x78
 [<c0108b97>] syscall_call+0x7/0xb

cron          S EA37D3CC 8587552 22846    283 22847   22851 22841 (NOTLB)
Call Trace:
 [<c0151180>] pipe_wait+0x70/0x94
 [<c0119c98>] autoremove_wake_function+0x0/0x40
 [<c0119c98>] autoremove_wake_function+0x0/0x40
 [<c0151341>] pipe_read+0x19d/0x208
 [<c010f045>] old_mmap+0xe9/0x124
 [<c0146cbc>] vfs_read+0x9c/0xcc
 [<c0146e9d>] sys_read+0x31/0x4c
 [<c0108b97>] syscall_call+0x7/0xb

sh            S E9EF419C 50252000 22847  22846 22848               (NOTLB)
Call Trace:
 [<c011df78>] sys_wait4+0x20c/0x244
 [<c0118488>] default_wake_function+0x0/0x20
 [<c0118488>] default_wake_function+0x0/0x20
 [<c0108b97>] syscall_call+0x7/0xb

exim          D 00000246 955184 22848  22847                     (NOTLB)
Call Trace:
 [<c012f439>] filemap_nopage+0x119/0x2ac
 [<c0107ad5>] __down+0x7d/0xe0
 [<c0118488>] default_wake_function+0x0/0x20
 [<c0107ca8>] __down_failed+0x8/0xc
 [<c0155173>] .text.lock.namei+0x5/0x172
 [<c015244c>] do_lookup+0x48/0x8c
 [<c01526d9>] link_path_walk+0x249/0x7fc
 [<c0152fb2>] path_lookup+0x156/0x15c
 [<c0153483>] open_namei+0x8b/0x3f0
 [<c0146163>] filp_open+0x3b/0x5c
 [<c0146523>] sys_open+0x37/0x78
 [<c0108b97>] syscall_call+0x7/0xb

cron          S EF5A16AC 4261624352 22851    283 22852   22856 22846 (NOTLB)
Call Trace:
 [<c0151180>] pipe_wait+0x70/0x94
 [<c0119c98>] autoremove_wake_function+0x0/0x40
 [<c0119c98>] autoremove_wake_function+0x0/0x40
 [<c0151341>] pipe_read+0x19d/0x208
 [<c010f045>] old_mmap+0xe9/0x124
 [<c0146cbc>] vfs_read+0x9c/0xcc
 [<c0146e9d>] sys_read+0x31/0x4c
 [<c0108b97>] syscall_call+0x7/0xb

sh            S EAE64DDC 1637536 22852  22851 22853               (NOTLB)
Call Trace:
 [<c011df78>] sys_wait4+0x20c/0x244
 [<c0118488>] default_wake_function+0x0/0x20
 [<c0118488>] default_wake_function+0x0/0x20
 [<c0108b97>] syscall_call+0x7/0xb

exim          D 00000246 4288860256 22853  22852                     (NOTLB)
Call Trace:
 [<c012f439>] filemap_nopage+0x119/0x2ac
 [<c0107ad5>] __down+0x7d/0xe0
 [<c0118488>] default_wake_function+0x0/0x20
 [<c0107ca8>] __down_failed+0x8/0xc
 [<c0155173>] .text.lock.namei+0x5/0x172
 [<c015244c>] do_lookup+0x48/0x8c
 [<c01526d9>] link_path_walk+0x249/0x7fc
 [<c0152fb2>] path_lookup+0x156/0x15c
 [<c0153483>] open_namei+0x8b/0x3f0
 [<c0146163>] filp_open+0x3b/0x5c
 [<c0146523>] sys_open+0x37/0x78
 [<c0108b97>] syscall_call+0x7/0xb

cron          S ED95228C 4294567712 22856    283 22857         22851 (NOTLB)
Call Trace:
 [<c0151180>] pipe_wait+0x70/0x94
 [<c0119c98>] autoremove_wake_function+0x0/0x40
 [<c0119c98>] autoremove_wake_function+0x0/0x40
 [<c0151341>] pipe_read+0x19d/0x208
 [<c010f045>] old_mmap+0xe9/0x124
 [<c0146cbc>] vfs_read+0x9c/0xcc
 [<c0146e9d>] sys_read+0x31/0x4c
 [<c0108b97>] syscall_call+0x7/0xb

sh            S EAE82D9C 61873376 22857  22856 22858               (NOTLB)
Call Trace:
 [<c011df78>] sys_wait4+0x20c/0x244
 [<c0118488>] default_wake_function+0x0/0x20
 [<c0118488>] default_wake_function+0x0/0x20
 [<c0108b97>] syscall_call+0x7/0xb

exim_tidydb   D 00000246 4283343056 22858  22857                     (NOTLB)
Call Trace:
 [<c0107ad5>] __down+0x7d/0xe0
 [<c0118488>] default_wake_function+0x0/0x20
 [<c0107ca8>] __down_failed+0x8/0xc
 [<c0155173>] .text.lock.namei+0x5/0x172
 [<c015244c>] do_lookup+0x48/0x8c
 [<c01529e7>] link_path_walk+0x557/0x7fc
 [<c0152fb2>] path_lookup+0x156/0x15c
 [<c0153483>] open_namei+0x8b/0x3f0
 [<c0146163>] filp_open+0x3b/0x5c
 [<c0146523>] sys_open+0x37/0x78
 [<c0108b97>] syscall_call+0x7/0xb


