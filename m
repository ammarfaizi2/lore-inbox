Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262331AbTFJFOc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 01:14:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262340AbTFJFOb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 01:14:31 -0400
Received: from franka.aracnet.com ([216.99.193.44]:40111 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP id S262331AbTFJFOO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 01:14:14 -0400
Date: Mon, 09 Jun 2003 22:27:17 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Andrew Morton <akpm@digeo.com>
cc: linux-kernel@vger.kernel.org, Bill Irwin <wli@holomorphy.com>
Subject: Re: 2.5.70 (virgin) hangs running SDET
Message-ID: <142420000.1055222836@[10.10.2.4]>
In-Reply-To: <20030609140834.11ad0d63.akpm@digeo.com>
References: <60380000.1055188542@flay> <20030609140834.11ad0d63.akpm@digeo.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> I thought this was specific to the -mjb tree for a while, but I can
>> reproduce it pretty easily on virgin 2.5.70 (but 2.5.69 didn't do
>> this). Andrew looked and pointed out it seems to be an i_sem (ISTR
>> some mention of /proc somewhere too?). Got a good sysrq+t trace out
>> of the virgin kernel (on 16x NUMA-Q) ... below:
> 
> The ps instance which is spinning on kernel_flag in proc_root_lookup is
> what's holding things up.
> 
> Or is it spinning in proc_lookup() or proc_pid_lookup()?  I have a vague
> feeling that I've seen these traces miss out the innermost stack slot...

Grrr. Wonder why it's skipping stuff ...

proc_root_lookup() is definied in fs/proc/root.c
proc_lookup() is defined in fs/proc/generic.c
proc_pid_lookup() is defined in fs/proc/base.c

But as we have .text.lock.base ... doesn't that mean that the guilty
party is proc_pid_lookup() ? In which case, maybe wli's favourite
tasklist_lock is the guilty party here?

> Suggest:
> 
> a) Use CONFIG_SPINLINE, get a new sysrq-T trace

OK ... well tried stage 1 at least. New trace output below, and I'll try
to do something more useful with it this time ;-) I've hacked out the
boring bits, so it'll fit under the lkml size limit. I presume this was
the one you were referring to last time:

ps            R 00000060 4263132092 31912  31675         31919       (NOTLB)
Call Trace:
 [<c016e99a>] .text.lock.base+0x1fe/0x214
 [<c016cd75>] proc_root_lookup+0x85/0x98
 [<c0152cdc>] real_lookup+0x54/0xc4
 [<c0152f6c>] do_lookup+0x48/0x8c
 [<c0153507>] link_path_walk+0x557/0x7fc
 [<c0153ad1>] path_lookup+0x155/0x15c
 [<c0153bf4>] __user_walk+0x28/0x40
 [<c014f661>] vfs_stat+0x19/0x48
 [<c014fc0b>] sys_stat64+0x13/0x30
 [<c015722f>] sys_getdents64+0x67/0xb0
 [<c01570bc>] filldir64+0x0/0x10c
 [<c015726e>] sys_getdents64+0xa6/0xb0
 [<c0108bc7>] syscall_call+0x7/0xb

So presumably this time it's:

ps            R C015219C 4287392944 18368  17475         18378       (NOTLB)

Call Trace:

 [<c015219c>] real_lookup+0x54/0xc4
 [<c015244c>] do_lookup+0x48/0x8c
 [<c01529e7>] link_path_walk+0x557/0x7fc
 [<c0152fb2>] path_lookup+0x156/0x15c
 [<c01530d4>] __user_walk+0x28/0x40
 [<c014eb71>] vfs_stat+0x19/0x48
 [<c014f11b>] sys_stat64+0x13/0x30
 [<c0108b97>] syscall_call+0x7/0xb

I suspect that's bugger all use to man or beast though.

M.

-------------------------------


bash          S EEE4597C 4292485472   295    293   297               (NOTLB)

Call Trace:

 [<c011c817>] session_of_pgrp+0x27/0x84

 [<c019db67>] tiocspgrp+0x6f/0x94

 [<c011df78>] sys_wait4+0x20c/0x244

 [<c0124d4c>] sys_rt_sigprocmask+0x128/0x140

 [<c0118488>] default_wake_function+0x0/0x20

 [<c0118488>] default_wake_function+0x0/0x20

 [<c0108b97>] syscall_call+0x7/0xb


stressdet     S EEEBF3BC 4291151600   297    295   298               (NOTLB)

Call Trace:

 [<c01173b4>] wake_up_forked_process+0x114/0x120

 [<c011df78>] sys_wait4+0x20c/0x244

 [<c0118488>] default_wake_function+0x0/0x20

 [<c0118488>] default_wake_function+0x0/0x20

 [<c0108b97>] syscall_call+0x7/0xb


sdetbench     S EEEBF9DC 4291731712   298    297 16521               (NOTLB)

Call Trace:

 [<c01256a4>] do_sigaction+0x184/0x25c

 [<c012570c>] do_sigaction+0x1ec/0x25c

 [<c011df78>] sys_wait4+0x20c/0x244

 [<c0118488>] default_wake_function+0x0/0x20

 [<c0118488>] default_wake_function+0x0/0x20

 [<c0108b97>] syscall_call+0x7/0xb


sh            S EE9E01DC 4289870080 16521    298 16522               (NOTLB)

Call Trace:

 [<c011df78>] sys_wait4+0x20c/0x244

 [<c0118488>] default_wake_function+0x0/0x20

 [<c0118488>] default_wake_function+0x0/0x20

 [<c0108b97>] syscall_call+0x7/0xb


spec_auto     S EE4A195C 4286980432 16522  16521 16534               (NOTLB)

Call Trace:

 [<c011df78>] sys_wait4+0x20c/0x244

 [<c0118488>] default_wake_function+0x0/0x20

 [<c0118488>] default_wake_function+0x0/0x20

 [<c0108b97>] syscall_call+0x7/0xb


make          S EE482D1C 4288974224 16534  16522 16535   16536       (NOTLB)

Call Trace:

 [<c011df78>] sys_wait4+0x20c/0x244

 [<c0124ca6>] sys_rt_sigprocmask+0x82/0x140

 [<c0118488>] default_wake_function+0x0/0x20

 [<c0118488>] default_wake_function+0x0/0x20

 [<c0108b97>] syscall_call+0x7/0xb


benchrun      S EE64941C 4294901860 16535  16534 16541               (NOTLB)

Call Trace:

 [<c011df78>] sys_wait4+0x20c/0x244

 [<c0118488>] default_wake_function+0x0/0x20

 [<c0118488>] default_wake_function+0x0/0x20

 [<c0108b97>] syscall_call+0x7/0xb


tee           S EE2BCECC 9699760 16536  16522               16534 (NOTLB)

Call Trace:

 [<c0151180>] pipe_wait+0x70/0x94

 [<c0119c98>] autoremove_wake_function+0x0/0x40

 [<c0119c98>] autoremove_wake_function+0x0/0x40

 [<c0151341>] pipe_read+0x19d/0x208

 [<c0146cbc>] vfs_read+0x9c/0xcc

 [<c0146e9d>] sys_read+0x31/0x4c

 [<c0108b97>] syscall_call+0x7/0xb


benchrun      S EE4820DC 3168724 16541  16535 16546               (NOTLB)

Call Trace:

 [<c011df78>] sys_wait4+0x20c/0x244

 [<c0118488>] default_wake_function+0x0/0x20

 [<c0118488>] default_wake_function+0x0/0x20

 [<c0108b97>] syscall_call+0x7/0xb


make          S EE6481BC 4290062436 16546  16541 17458   16547       (NOTLB)

Call Trace:

 [<c011df78>] sys_wait4+0x20c/0x244

 [<c0124ca6>] sys_rt_sigprocmask+0x82/0x140

 [<c0118488>] default_wake_function+0x0/0x20

 [<c0118488>] default_wake_function+0x0/0x20

 [<c0108b97>] syscall_call+0x7/0xb


tee           S EE597EEC 4291487760 16547  16541               16546 (NOTLB)

Call Trace:

 [<c0119cae>] autoremove_wake_function+0x16/0x40

 [<c0151180>] pipe_wait+0x70/0x94

 [<c0119c98>] autoremove_wake_function+0x0/0x40

 [<c0119c98>] autoremove_wake_function+0x0/0x40

 [<c0151341>] pipe_read+0x19d/0x208

 [<c0146cbc>] vfs_read+0x9c/0xcc

 [<c0146e9d>] sys_read+0x31/0x4c

 [<c0108b97>] syscall_call+0x7/0xb


sh            S EE4826FC 4290450352 17458  16546 17463               (NOTLB)

Call Trace:

 [<c011df78>] sys_wait4+0x20c/0x244

 [<c0118488>] default_wake_function+0x0/0x20

 [<c0118488>] default_wake_function+0x0/0x20

 [<c0108b97>] syscall_call+0x7/0xb


time          S EE0EFA1C 4294340704 17463  17458 17464               (NOTLB)

Call Trace:

 [<c011df78>] sys_wait4+0x20c/0x244

 [<c0118488>] default_wake_function+0x0/0x20

 [<c0118488>] default_wake_function+0x0/0x20

 [<c0108b97>] syscall_call+0x7/0xb


time          S EE4A8DBC 4294634736 17464  17463 17465               (NOTLB)

Call Trace:

 [<c0128d9e>] rcu_process_callbacks+0x162/0x180

 [<c011df78>] sys_wait4+0x20c/0x244

 [<c0118488>] default_wake_function+0x0/0x20

 [<c0118488>] default_wake_function+0x0/0x20

 [<c0108b97>] syscall_call+0x7/0xb


run.sdet      S EE363A5C 4291846224 17465  17464 17470               (NOTLB)

Call Trace:

 [<c011df78>] sys_wait4+0x20c/0x244

 [<c0118488>] default_wake_function+0x0/0x20

 [<c0118488>] default_wake_function+0x0/0x20

 [<c0108b97>] syscall_call+0x7/0xb


run           S EE9E07FC 4287517360 17470  17465 17472               (NOTLB)

Call Trace:

 [<c011df78>] sys_wait4+0x20c/0x244

 [<c0118488>] default_wake_function+0x0/0x20

 [<c0118488>] default_wake_function+0x0/0x20

 [<c0108b97>] syscall_call+0x7/0xb


driver        S EE19673C 4293849968 17472  17470 17473               (NOTLB)

Call Trace:

 [<c011df78>] sys_wait4+0x20c/0x244

 [<c0118488>] default_wake_function+0x0/0x20

 [<c0118488>] default_wake_function+0x0/0x20

 [<c0108b97>] syscall_call+0x7/0xb


driver.exec   S EE48395C 4289790288 17473  17472 17475               (NOTLB)

Call Trace:

 [<c011df78>] sys_wait4+0x20c/0x244

 [<c0118488>] default_wake_function+0x0/0x20

 [<c0118488>] default_wake_function+0x0/0x20

 [<c0108b97>] syscall_call+0x7/0xb


sh            S EE91C1BC 4286871792 17475  17473 18368   17476       (NOTLB)

Call Trace:

 [<c011df78>] sys_wait4+0x20c/0x244

 [<c0118488>] default_wake_function+0x0/0x20

 [<c0118488>] default_wake_function+0x0/0x20

 [<c0108b97>] syscall_call+0x7/0xb


sh            S EE91CDFC 4287342280 17476  17473 18905   17478 17475 (NOTLB)

Call Trace:

 [<c011df78>] sys_wait4+0x20c/0x244

 [<c0118488>] default_wake_function+0x0/0x20

 [<c0118488>] default_wake_function+0x0/0x20

 [<c0108b97>] syscall_call+0x7/0xb


sh            S EE81F99C 4286415120 17478  17473 19031   17481 17476 (NOTLB)

Call Trace:

 [<c011df78>] sys_wait4+0x20c/0x244

 [<c0118488>] default_wake_function+0x0/0x20

 [<c0118488>] default_wake_function+0x0/0x20

 [<c0108b97>] syscall_call+0x7/0xb


sh            S EDD17A3C 4294934640 17481  17473 18363   17482 17478 (NOTLB)

Call Trace:

 [<c011df78>] sys_wait4+0x20c/0x244

 [<c0118488>] default_wake_function+0x0/0x20

 [<c0118488>] default_wake_function+0x0/0x20

 [<c0108b97>] syscall_call+0x7/0xb


sh            S EE91D41C 4294239888 17482  17473 18948   17483 17481 (NOTLB)

Call Trace:

 [<c011df78>] sys_wait4+0x20c/0x244

 [<c0118488>] default_wake_function+0x0/0x20

 [<c0118488>] default_wake_function+0x0/0x20

 [<c0108b97>] syscall_call+0x7/0xb


sh            S EE49877C 4294914864 17483  17473 18417   17484 17482 (NOTLB)

Call Trace:

 [<c011df78>] sys_wait4+0x20c/0x244

 [<c0118488>] default_wake_function+0x0/0x20

 [<c0118488>] default_wake_function+0x0/0x20

 [<c0108b97>] syscall_call+0x7/0xb


sh            S EE4993BC 4291403968 17484  17473 19001   17487 17483 (NOTLB)

Call Trace:

 [<c011df78>] sys_wait4+0x20c/0x244

 [<c0118488>] default_wake_function+0x0/0x20

 [<c0118488>] default_wake_function+0x0/0x20

 [<c0108b97>] syscall_call+0x7/0xb


sh            S EDF7E73C 1717104 17487  17473 18733         17484 (NOTLB)

Call Trace:

 [<c011df78>] sys_wait4+0x20c/0x244

 [<c0118488>] default_wake_function+0x0/0x20

 [<c0118488>] default_wake_function+0x0/0x20

 [<c0108b97>] syscall_call+0x7/0xb


make          S EE4026FC 4292752304 18363  17481 18372               (NOTLB)

Call Trace:

 [<c011df78>] sys_wait4+0x20c/0x244

 [<c0124ca6>] sys_rt_sigprocmask+0x82/0x140

 [<c0118488>] default_wake_function+0x0/0x20

 [<c0118488>] default_wake_function+0x0/0x20

 [<c0108b97>] syscall_call+0x7/0xb


ps            R C015219C 4287392944 18368  17475         18378       (NOTLB)

Call Trace:

 [<c015219c>] real_lookup+0x54/0xc4

 [<c015244c>] do_lookup+0x48/0x8c

 [<c01529e7>] link_path_walk+0x557/0x7fc

 [<c0152fb2>] path_lookup+0x156/0x15c

 [<c01530d4>] __user_walk+0x28/0x40

 [<c014eb71>] vfs_stat+0x19/0x48

 [<c014f11b>] sys_stat64+0x13/0x30

 [<c0108b97>] syscall_call+0x7/0xb


cc            S 000047C8 4286978352 18372  18363 18376               (NOTLB)

Call Trace:

 [<c011dbca>] wait_task_zombie+0x142/0x164

 [<c011de96>] sys_wait4+0x12a/0x244

 [<c0118488>] default_wake_function+0x0/0x20

 [<c0118488>] default_wake_function+0x0/0x20

 [<c0108b97>] syscall_call+0x7/0xb


cpp0          W EE36E680 1004432 18376  18372                     (L-TLB)

Call Trace:

 [<c011d891>] do_exit+0x365/0x378

 [<c011d8ca>] sys_exit+0xe/0x10

 [<c0108b97>] syscall_call+0x7/0xb


wc            S EE1B86AC 4292712784 18378  17475               18368 (NOTLB)

Call Trace:

 [<c0151180>] pipe_wait+0x70/0x94

 [<c0119c98>] autoremove_wake_function+0x0/0x40

 [<c0119c98>] autoremove_wake_function+0x0/0x40

 [<c0151341>] pipe_read+0x19d/0x208

 [<c013cf60>] do_brk+0x190/0x1c0

 [<c0146cbc>] vfs_read+0x9c/0xcc

 [<c0146e9d>] sys_read+0x31/0x4c

 [<c0108b97>] syscall_call+0x7/0xb


ps            D 00000246 4276225996 18417  17483         18418       (NOTLB)

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


wc            S EEBDDBEC 4282425456 18418  17483               18417 (NOTLB)

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


ps            D 00000246 4294056144 18733  17487         18741       (NOTLB)

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


wc            S EEE4CACC 2511696 18741  17487               18733 (NOTLB)

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


ps            D 00000246 4289624432 18905  17476         18913       (NOTLB)

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


wc            S EEA3222C 1853264 18913  17476               18905 (NOTLB)

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


ps            D 00000246 4289013424 18948  17482         18952       (NOTLB)

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


wc            S EEB423EC 4284303152 18952  17482               18948 (NOTLB)

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


ps            D 00000246 2818312 19001  17484         19003       (NOTLB)

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


wc            S EDD1A4EC 2664320 19003  17484               19001 (NOTLB)

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


ps            D 00000246 4291625200 19031  17478         19033       (NOTLB)

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


wc            S EDF69EAC 4289324656 19033  17478               19031 (NOTLB)

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


cron          S EE1B83EC 3332432 19084    283 19085               (NOTLB)

Call Trace:

 [<c0151180>] pipe_wait+0x70/0x94

 [<c0119c98>] autoremove_wake_function+0x0/0x40

 [<c0119c98>] autoremove_wake_function+0x0/0x40

 [<c0151341>] pipe_read+0x19d/0x208

 [<c010f045>] old_mmap+0xe9/0x124

 [<c0146cbc>] vfs_read+0x9c/0xcc

 [<c0146e9d>] sys_read+0x31/0x4c

 [<c0108b97>] syscall_call+0x7/0xb


sh            S EDE2C77C 3928880 19085  19084 19086               (NOTLB)

Call Trace:

 [<c011df78>] sys_wait4+0x20c/0x244

 [<c0118488>] default_wake_function+0x0/0x20

 [<c0118488>] default_wake_function+0x0/0x20

 [<c0108b97>] syscall_call+0x7/0xb


exim          D 00000246 8080656 19086  19085                     (NOTLB)

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



telnet> quit
Connection closed.


fletch@titus : /home/fletch/linux/debug 

$ 
Script done on Mon Jun  9 21:53:03 2003

