Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265815AbUGZQCm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265815AbUGZQCm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jul 2004 12:02:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266173AbUGZQAx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jul 2004 12:00:53 -0400
Received: from posti5.jyu.fi ([130.234.4.34]:4570 "EHLO posti5.jyu.fi")
	by vger.kernel.org with ESMTP id S265947AbUGZPQF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jul 2004 11:16:05 -0400
Date: Mon, 26 Jul 2004 18:15:34 +0300 (EEST)
From: Pasi Sjoholm <ptsjohol@cc.jyu.fi>
X-X-Sender: ptsjohol@silmu.st.jyu.fi
To: Francois Romieu <romieu@fr.zoreil.com>
cc: H?ctor Mart?n <hector@marcansoft.com>,
       Linux-Kernel <linux-kernel@vger.kernel.org>, <akpm@osdl.org>,
       <netdev@oss.sgi.com>, <brad@brad-x.com>
Subject: Re: ksoftirqd uses 99% CPU triggered by network traffic (maybe
 RLT-8139 related)
In-Reply-To: <20040725235927.B30025@electric-eye.fr.zoreil.com>
Message-ID: <Pine.LNX.4.44.0407261745120.31123-100000@silmu.st.jyu.fi>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
X-Spam-Checked: by miltrassassin
	at posti5.jyu.fi; Mon, 26 Jul 2004 18:15:40 +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 25 Jul 2004, Francois Romieu wrote:

> Pasi Sjoholm <ptsjohol@cc.jyu.fi> :
> [...]
> > I haven't been able to reproduce this with normal www-browsing or 
> > ssh-connections but it's always reproducible when my eth0 is under heavy 
> > load.
> I guess it can be reproduced even if the binary (nvidia ?) module is never
> loaded after boot, right ?

After 24 hours of hard working I can answer yes to this question. 
Now I can reproduce this from 2 to 15 minutes with 2 cp-processes from 
samba->workstation->nfs, some software building with make -j 3, playing 
some mp3 via nfs to notice when kernel goes down.. =) and so on..

After that ksoftirqd takes almost all the cpu-time and the network is not 
working at all.

First I made some debugging with:

--
readprofile -r
sleep 10
readprofile -n -v -m /boot/System.map-2.6.7-mm7| sort -n +2 | tail -40
--

I tried this tree different times and here are the results:

-1-
c0114020 unshare_files                                 1   0.0104
c0134400 vma_prio_tree_add                             1   0.0057
c01f1c50 fast_clear_page                               1   0.0104
c01f2190 __copy_to_user_ll                             7   0.0625
c017dbf0 write_profile                                 9   0.1406
c02d1f50 net_rx_action                                10   0.0368
00000000 total                                        29   0.0000
-1-

-2-
c0111c80 finish_task_switch                            1   0.0069
c011f9e0 get_signal_to_deliver                         1   0.0012
c01364c0 __kmalloc                                     1   0.0078
c013ad60 copy_page_range                               1   0.0017
c0141370 page_remove_rmap                              1   0.0069
c014a9f0 do_sync_write                                 1   0.0057
c014aaa0 vfs_write                                     1   0.0033
c0195840 start_this_handle                             1   0.0010
c01f1c20 add_timer_randomness                          1   0.0035
c023f4e0 idedisk_release                               1   0.0052
c017dbf0 write_profile                                 5   0.0781
c01f1f30 extract_entropy                               5   0.0060
c02d1f90 rt_may_expire                                14   0.0972
00000000 total                                        34   0.0000
-2-

-3-
c01105b0 do_page_fault                                 1   0.0007
c012d920 find_lock_page                                1   0.0045
c0131130 bad_page                                      1   0.0063
c01ec430 slow_copy_page                                1   0.0208
c01ec2f0 fast_copy_page                                3   0.0117
c017dcf0 kclist_add                                    4   0.0625
c01ec900 copy_from_user                                4   0.0312
c02c5f00 dev_ifname                                    6   0.0341
00000000 total                                        21   0.0000
-3-

There are quite few ticks in total-rows at least when you are comparing to 
normal operation of kernel: 

--
c017dcf0 kclist_add                                    9   0.1406
c0119100 __do_softirq                                268   2.0938
c0101eb0 default_idle                               9396 195.7500
00000000 total                                      9779   0.0043
--

Also made some debugging with patch which Andrew Morton gave to brad
(http://seclists.org/lists/linux-kernel/2004/Mar/2295.html)

--cut--
diff -puN include/linux/kernel.h~proc-sys-debug include/linux/kernel.h
--- 25/include/linux/kernel.h~proc-sys-debug 2004-02-25 23:12:56.000000000 
-0800+++ 25-akpm/include/linux/kernel.h 2004-02-25 23:12:57.000000000 
-0800
@@ -214,6 +214,8 @@ extern void dump_stack(void);
  1; \
 })

+extern int proc_sys_debug[8];
+
 #endif /* __KERNEL__ */

 #define SI_LOAD_SHIFT 16
diff -puN -L kernel/ksyms.c /dev/null /dev/null
diff -puN kernel/sysctl.c~proc-sys-debug kernel/sysctl.c
--- 25/kernel/sysctl.c~proc-sys-debug 2004-02-25 23:12:56.000000000 -0800
+++ 25-akpm/kernel/sysctl.c 2004-02-25 23:21:37.000000000 -0800
@@ -849,7 +849,26 @@ static ctl_table fs_table[] = {
  { .ctl_name = 0 }
 };

+int proc_sys_debug[8];
+EXPORT_SYMBOL(proc_sys_debug);
+
 static ctl_table debug_table[] = {
+ {1, "0", &proc_sys_debug[0], sizeof(int), 0644, NULL,
+  &proc_dointvec_minmax, &sysctl_intvec, NULL, NULL, NULL},
+ {2, "1", &proc_sys_debug[1], sizeof(int), 0644, NULL,
+  &proc_dointvec_minmax, &sysctl_intvec, NULL, NULL, NULL},
+ {3, "2", &proc_sys_debug[2], sizeof(int), 0644, NULL,
+  &proc_dointvec_minmax, &sysctl_intvec, NULL, NULL, NULL},
+ {4, "3", &proc_sys_debug[3], sizeof(int), 0644, NULL,
+  &proc_dointvec_minmax, &sysctl_intvec, NULL, NULL, NULL},
+ {5, "4", &proc_sys_debug[4], sizeof(int), 0644, NULL,
+  &proc_dointvec_minmax, &sysctl_intvec, NULL, NULL, NULL},
+ {6, "5", &proc_sys_debug[5], sizeof(int), 0644, NULL,
+  &proc_dointvec_minmax, &sysctl_intvec, NULL, NULL, NULL},
+ {7, "6", &proc_sys_debug[6], sizeof(int), 0644, NULL,
+  &proc_dointvec_minmax, &sysctl_intvec, NULL, NULL, NULL},
+ {8, "7", &proc_sys_debug[7], sizeof(int), 0644, NULL,
+  &proc_dointvec_minmax, &sysctl_intvec, NULL, NULL, NULL},
  { .ctl_name = 0 }
 };


_
 kernel/softirq.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletion(-)

diff -puN kernel/softirq.c~a kernel/softirq.c
--- 25/kernel/softirq.c~a 2004-03-11 02:05:20.000000000 -0800
+++ 25-akpm/kernel/softirq.c 2004-03-11 02:06:02.000000000 -0800
@@ -54,8 +54,13 @@ static inline void wakeup_softirqd(void)
  /* Interrupts are disabled: no need to stop preemption */
  struct task_struct *tsk = __get_cpu_var(ksoftirqd);

- if (tsk && tsk->state != TASK_RUNNING)
+ if (tsk && tsk->state != TASK_RUNNING) {
+  if (proc_sys_debug[0]) {
+   printk("%s wakes ksoftirqd\n", current->comm);
+   dump_stack();
+  }
   wake_up_process(tsk);
+ }
 }
--cut--

and running:

 dmesg -c
 echo 1 > /proc/sys/debug/0 ; sleep 5; echo 0 > /proc/sys/debug/0
 dmesg -s 1000000 > /tmp/foo

but it resulted nothing in /tmp/foo and ksoftirqd was eating my cpu time.

SysRq: Show regs gave this:

--
Pid: 2, comm:          ksoftirqd/0
EIP: 0060:[<e0871224>] CPU: 0
EIP is at rtl8139_poll+0xb4/0x100 [8139too]
 EFLAGS: 00000247    Not tainted  (2.6.7-mm7)
EAX: ffffe000 EBX: 00000040 ECX: df4824f8 EDX: c0441978
ESI: df482400 EDI: e0868000 EBP: dff85f80 DS: 007b ES: 007b
CR0: 8005003b CR2: b7c5a000 CR3: 1fafd000 CR4: 000006d0
 [<c0119580>] ksoftirqd+0x0/0xc0
 [<c02c5f3a>] net_rx_action+0x6a/0x110
 [<c01191a9>] __do_softirq+0xa9/0xb0
 [<c01191d7>] do_softirq+0x27/0x30
 [<c01195e8>] ksoftirqd+0x68/0xc0
 [<c01277e5>] kthread+0xa5/0xb0
 [<c0127740>] kthread+0x0/0xb0
 [<c0102111>] kernel_thread_helper+0x5/0x14
--

I'm not a kernel expert but it would seem that ksoftirqd is in some sort a 
loop because I didn't get any "printk("%s wakes ksoftirqd\n", 
current->comm);"-lines.

And rtl8139_poll-function in rtl-8139-drivers is a function made directly 
for NAPI's poll(). But for me is hard to say what's wrong... I will try 
other 8139-card later today if it has a same problem.

> [...]
> > Same thing for me also, except for me it's interrupt 10 (CMI8738-MC6, 
> > eth0), so it's pointing more and more something rtl-8139 related.
> Possible. Which 8139 module do you use ?

8139too.
 
> It would be nice if this thread could be fed to netdev@oss.sgi.com.

Included in cc.

I haven't changed anything else in my hardware but just upgraded my 
10Mbps hub to 100Mbps switch. I guess 10Mbps wasn't generating too many 
interrupts. =)

Hope this helps..

--
Pasi Sjöholm

