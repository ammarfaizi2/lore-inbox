Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267510AbUBRP1A (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 10:27:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267529AbUBRP1A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 10:27:00 -0500
Received: from mail.daysofwonder.com ([209.61.173.130]:21172 "EHLO
	mail.daysofwonder.com") by vger.kernel.org with ESMTP
	id S267510AbUBRP0h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 10:26:37 -0500
Subject: PROBLEM: spurious temporary freeze, scheduler and preempt problem ?
From: Brice Figureau <brice+lklm@daysofwonder.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1077117976.2265.61.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4-8mdk 
Date: Wed, 18 Feb 2004 16:26:16 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I'm working on a java server that uses some native libs (aka JNI). The
server is poll(2)ing a TCP socket with the help of NIO, and dispatch
network requests to a pool of a threads (currently 4) that send back
responses to the client. Those threads are mostly executing native code
(with JNI). The server is using a mysql engine running on the same host
to store a few things (about 10 records stored per seconds if that
matters).

I'm running 2.6.3-rc2 on a UP Celeron (same problem on a PIII too)
system with plenty of RAM, but which runs several other daemons
(postfix, djbdns... those daemons were not loading the machine during
the tests).
The machine was never swapping (see the vmstat output below [2,3]).

I noticed a few weeks ago that when I try to stress-test this particular
application the host on which it runs completely freeze for 3 to 5
seconds, nothing seems to run at all during this time (this was
especially visible during my first test as it was my devl computer
running X and the whole screen was frozen).

I decided to perform torough testing running on quiet machine without X.
During my testbed I tried to capture most data I could (vmstat,
profiling...).

What I've seen is the following:

1) During the freeze, the system was using almost 80% CPU time in kernel
and the remaining in user space

2) During the freeze, even changing from virtual-console to another
could have been frozen. No virtual-console would be alive.

3) a top d 1 or top d 0.5 show that my application was running before
the freeze and after the freeze, with 80% of CPU time in kernel space.

4) load was increasing faster than I could think (>19 after 30 seconds)

I first thought that a profiling (with profile=1 or oprofile) would give
me a good candidate about the problem, but I'm not sure right now (see
the profile output at the end of the mail [4,5])

After that I tried to run vmstat 1 to have a better idea of the problem
[2,3]. You can see the high amount of context-switch and interrupt. I
think that this is because vmstat was stuck (like the other process)
during a few seconds, but the kernel counters were still incrementing.

Then I finally tried several differents kernel and found the following
results:

2.6.3-rc2  -> exhibit the high load problem
2.4.25-rc3 -> immune to the problem, the load never goes beyong 1.20

I finally did a binary search between several version of 2.6 and found
that any kernel *before* 2.6.0-test5 (included) are immune to the
problem and any kernel *after* 2.6.0-test6 (included) have the same load
problem.

On a side note, 2.6.0-test4-mm2 (the only mm kernel I had already
compiled) had the problem too.

So what are the differences between test5 and test6 ? 
It seems that the sched_interactive patch from Con Kolivas was included
in test6, can it be the cause ?

By running and looking at a 'top d 0.5' I couldn't spot any bizarre
dynamic priorities (my java app is at 15 or 16, never more).
The only difference I could spot is that kernel with interactive
scheduler seemed to make runnable several java threads at the same time
(about 3 to 4) unlike the previous scheduler (only 1~2 runnable process
at any time).

Something I should also say is that I tested a 2.6.3-rc2 *without*
preempt and found this kernel to be immune, too. 

I also removed all the sql code in my application and no more freeze !
(Although that does not explain why the combination of the two gives
those results).

Can someone help me find what the problem is ?

Useful data:

1) ver_linux
Linux arsenic 2.6.3-rc2 #2 SMP Wed Feb 18 11:35:24 CET 2004 i686 unknown
unknown GNU/Linux
  
Gnu C                  3.3.1
Gnu make               3.80
util-linux             2.12
mount                  2.11z
module-init-tools      0.9.11a
e2fsprogs              1.34
quota-tools            3.09.
PPP                    2.4.1
nfs-utils              1.0.5
Linux C Library        2.3.2
Dynamic linker (ldd)   2.3.2
Procps                 3.1.11
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               5.0
Modules Loaded


2) vmstat for a kernel with the problem:

procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
 3  0      0 371136   8044  61096    0    0    16   120 1035   351 63  3 30  4
 3  0      0 371136   8044  61112    0    0    12     0 1033   532 78  4 18  0
21  0      0 371024   8064  61116    0    0     0   148 9038 630633 29 71  0  0
 4  0      0 371024   8064  61120    0    0     0     0 1064 43014 58 42  0  0
 4  0      0 371024   8064  61120    0    0     0     0 1159 78750 38 62  0  0
 4  0      0 371040   8080  61120    0    0     0    76 4298 309703 29 71  0  0
15  0      0 370976   8096  61120    0    0     0    96 6833 501193 27 73  0  0
 3  0      0 370992   8096  61124    0    0     0     0 1094 44694 56 44  0  0
 3  0      0 370992   8096  61124    0    0     0     0 1087 65851 42 58  0  0
16  0      0 371024   8112  61124    0    0     0    76 10511 794459 26 74  0  0
 4  0      0 371024   8112  61124    0    0     0     0 1035 56591 50 50  0  0
 3  0      0 371024   8112  61124    0    0     0     0 1025 63930 41 59  0  0
 3  0      0 371024   8112  61124    0    0     0     0 1007 54424 47 53  0  0
 5  0      0 371024   8112  61124    0    0     0     0 1100 56909 53 47  0  0
 5  0      0 370960   8128  61128    0    0     0    60 1154 71518 37 63  0  0
 4  0      0 370960   8128  61128    0    0     0     0 1041 54728 51 49  0  0
12  0      0 370960   8128  61128    0    0     0    12 3147 223442 31 69  0  0

huge freeze before the following line
15  0      0 370952   8152  61128    0    0     0   112 13393 1014908 25 75  0  0
 3  0      0 370944   8152  61128    0    0     0     0 1006 55046 43 57  0  0
 3  0      0 370944   8152  61128    0    0     0     0 1111 66487 40 60  0  0
21  0      0 370920   8168  61128    0    0     0    68 20308 1531575 26 74  0  0
procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
14  0      0 370888   8176  61132    0    0     0    20 4228 313614 25 75  0  0
18  0      0 370912   8200  61132    0    0     0   112 8133 610932 26 74  0  0
 8  0      0 371488   8200  61132    0    0     0    48 1513 104797 31 69  0  0
29  0      0 371440   8216  61132    0    0     0    68 4490 333022 26 74  0  0

3) vmstat for a kernel without the problem

procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
 0  0      0 389060   7884  57472    0    0   153    38 1023    91  5  3 85  7
 2  0      0 388020   7884  57492    0    0     4     0 1012   127  3  3 92  2
 2  0      0 380940   7884  57492    0    0     0     0 1010   440 94  6  0  0
 0  1      0 378636   7928  58460    0    0  1004    16 1173   330 47  5 21 26
 0  0      0 378276   7928  58600    0    0   136     0 1038   291 68 10 11 11
 3  0      0 377828   7944  58652    0    0    52   268 1021   261 68 10 17  5
 3  0      0 377188   7952  58768    0    0   112    24 1017   278 63  7 24  6
 2  0      0 377060   7952  58828    0    0    56     0 1016   276 57  7 27  9
 3  0      0 377060   7960  58864    0    0    36    88 1020   223 65  8 23  4
 0  0      0 376868   7960  58896    0    0    28     0 1009   234 66 10 23  1
 3  0      0 376820   7968  58936    0    0    36   104 1032   229 61  9 26  4
 3  0      0 376756   7968  58972    0    0    32     0 1010   274 47  6 43  3
 0  0      0 376564   7968  59000    0    0    28     0 1009   415 66  3 30  1
 5  0      0 376308   7976  59012    0    0     8    92 1016   387 56  5 39  0
 2  0      0 376236   7976  59080    0    0    68     0 1004   290 78  1 21  0
 4  0      0 375980   7984  59088    0    0     4   204 1056   408 45  5 50  0
 1  0      0 375788   7984  59092    0    0     4     0 1003   330 87  4  9  0
 0  0      0 375596   7984  59096    0    0     0     0 1002   281 74  3 23  0
 0  0      0 375404   7992  59108    0    0     8   120 1024   289 43  4 39 15
 1  0      0 375276   7992  59124    0    0    12     0 1005   394 39  3 57  1
 4  0      0 375204   8000  59132    0    0     4    16 1006  1083 95  5  0  0
procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
 3  0      0 375140   8000  59132    0    0     0     0 1002 95433 37 63  0  0
 3  0      0 375060   8000  59136    0    0     0     0 1012 102262 33 67  0  0
 6  0      0 375044   8008  59136    0    0     0   112 1025 83959 43 57  0  0
 5  0      0 374988   8008  59136    0    0     0     0 1002   232 98  2  0  0
 3  0      0 375052   8016  59136    0    0     0    20 1005   211 98  2  0  0
 3  0      0 375052   8016  59136    0    0     0     0 1007 43272 71 29  0  0
 2  0      0 375052   8016  59140    0    0     0     0 1023 82448 59 41  0  0
 3  0      0 374988   8024  59140    0    0     0    84 1022 132541 39 61  0  0
 3  0      0 374988   8024  59140    0    0     0     0 1002 21207 89 11  0  0
 5  0      0 375004   8032  59144    0    0     0    20 1005 45680 75 25  0  0
 3  0      0 375004   8032  59144    0    0     0     0 1012 24392 82 18  0  0
 3  0      0 375004   8032  59144    0    0     0     0 1015 82373 48 52  0  0
 2  0      0 375004   8032  59144    0    0     0     0 1005 77767 61 39  0  0
 4  0      0 375020   8040  59144    0    0     0    68 1009 148047 31 69  0  0
 3  0      0 375020   8048  59144    0    0     0    32 1008 127918 38 62  0  0
 1  0      0 374956   8048  59144    0    0     0     0 1011 91847 39 61  0  0
 3  0      0 374956   8048  59148    0    0     0     0 1002 94842 51 49  0  0
 4  0      0 374972   8048  59148    0    0     0     0 1006 126960 38 62  0  0
 2  0      0 374972   8056  59148    0    0     0    60 1009 76808 65 35  0  0
 1  0      0 374972   8064  59148    0    0     0   184 1037 111781 32 68  0  0
 2  0      0 374972   8064  59148    0    0     0     0 1002 120766 36 64  0  0

4) readprofile for a kernel with the problem (analysis during atmost 1min)

c0191b55 proc_pid_stat                                14   0.0108
c01936cc write_profile                                15   0.0794
c0241e40 do_con_write                                 15   0.0081
c0130e95 sys_tgkill                                   16   0.0438
c0176dd2 __d_lookup                                   18   0.0496
c018cf88 task_statm                                   18   0.1818
c02037d2 __copy_user_intel                            20   0.1163
c02025f3 number                                       28   0.0452
c014e3a8 do_anonymous_page                            32   0.0516
c012eab4 kill_something_info                         175   0.5591
c0109480 syscall_call                                239  21.7273
c01354ad find_task_by_pid                            280   3.6364
c012dd86 check_kill_permission                       316   1.8588
c010948b syscall_exit                                336  30.5455
c0109f34 device_not_available                        360   8.5714
c0111313 restore_i387_fxsave                         403   2.4132
c01209af __might_sleep                               625   3.0340
c01113ba restore_i387                                673   4.6414
c010870a restore_sigcontext                          753   2.4770
c0130e43 sys_kill                                    757   9.2317
c0108a73 setup_sigcontext                            935   3.1481
c0114ffa sched_clock                                1189   9.0076
c0111111 save_i387_fxsave                           1214   4.8367
c011120c save_i387                                  1872   7.1179
c0111027 convert_fxsr_from_user                     1974   8.4359
c012ea44 kill_proc_info                             2217  19.7946
c0130613 sys_rt_sigprocmask                         2220   5.2857
c0108b9c setup_frame                                2250   4.8077
c010883a sys_sigreturn                              3405  13.3008
c0110eca convert_fxsr_to_user                       3620  10.3725
c0109009 handle_signal                              3927  11.6183
c01084cc sys_rt_sigsuspend                          4121  13.4235
c020399a __copy_from_user_ll                        6233  54.6754
c010915b do_signal                                  6656  24.7435
c020392a __copy_to_user_ll                          7219  64.4554
c01300d4 get_signal_to_deliver                      9293   8.6447
c012e484 group_send_sig_info                       14040  13.2578
c011e5a1 schedule                                  15029   8.2396
c0109454 system_call                               21609 491.1136
00000000 total                                    114435   0.0412

5) profile for a kernel without the problem (in fact a 2.6.3-rc2 without preempt)

c027983c vgacon_cursor                                24   0.0612
c0108d64 syscall_call                                 25   2.2727
c013a306 do_anonymous_page                            25   0.0627
c016e47c pid_revalidate                               26   0.1486
c01d7a86 __copy_user_intel                            28   0.1628
c010f2ed restore_i387_fxsave                          31   0.2138
c0127742 find_task_by_pid                             31   0.4026
c020d598 conv_uni_to_pc                               34   0.1932
c02c2b7f tcp_poll                                     36   0.0945
c010f17d save_i387_fxsave                             40   0.2062
c0153114 link_path_walk                               43   0.0205
c016edac get_tgid_list                                47   0.3072
c0147da7 fget_light                                   49   0.4949
c015c21f __d_lookup                                   51   0.2099
c021308d do_con_write                                 53   0.0287
c0123e02 sys_kill                                     57   0.6951
c010842a setup_sigcontext                             59   0.1987
c01d6bba vsnprintf                                    63   0.0510
c0108144 restore_sigcontext                           66   0.2171
c01702da proc_pid_stat                                69   0.0681
c0116bed __might_sleep                                70   0.4516
c0108553 setup_frame                                  72   0.1538
c016c9de task_statm                                   83   0.8384
c0112a5e sched_clock                                  90   0.6818
c0108274 sys_sigreturn                                93   0.4794
c01236d1 sys_rt_sigprocmask                           99   0.2750
c01089c0 handle_signal                               122   0.4342
c010f093 convert_fxsr_from_user                      143   0.6111
c0107f42 sys_rt_sigsuspend                           146   0.5911
c01d694f number                                      157   0.2536
c010ef36 convert_fxsr_to_user                        179   0.5129
c0108ad9 do_signal                                   463   1.8016
c01d7c4e __copy_from_user_ll                         476   4.1754
c0123300 get_signal_to_deliver                       522   0.6788
c0121d45 group_send_sig_info                         646   0.7242
c01d7bde __copy_to_user_ll                           695   6.2054
c011577c schedule                                    889   0.6679
c0108d38 system_call                                1642  37.3182
c0106d59 default_idle                              53370 1241.1628
00000000 total                                     61980   0.0289

6) Sysreq-T during a freeze available on request.
7) .config or other info available on request

Thank you for your help.
PS: I'm not subscribed to the list, please CC: me if you answer.

--
Brice Figureau


