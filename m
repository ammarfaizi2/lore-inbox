Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268739AbUHaPgF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268739AbUHaPgF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 11:36:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268738AbUHaPf6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 11:35:58 -0400
Received: from mail2.bluewin.ch ([195.186.4.73]:26536 "EHLO mail2.bluewin.ch")
	by vger.kernel.org with ESMTP id S268730AbUHaPfc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 11:35:32 -0400
Date: Tue, 31 Aug 2004 17:34:32 +0200
From: Roger Luethi <rl@hellgate.ch>
To: William Lee Irwin III <wli@holomorphy.com>, linux-kernel@vger.kernel.org,
       Albert Cahalan <albert@users.sf.net>, Paul Jackson <pj@sgi.com>
Subject: [BENCHMARK] nproc: Look Ma, No get_tgid_list!
Message-ID: <20040831153431.GA6010@k3.hellgate.ch>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org, Albert Cahalan <albert@users.sf.net>,
	Paul Jackson <pj@sgi.com>
References: <20040827122412.GA20052@k3.hellgate.ch> <20040827162308.GP2793@holomorphy.com> <20040828194546.GA25523@k3.hellgate.ch> <20040828195647.GP5492@holomorphy.com> <20040828201435.GB25523@k3.hellgate.ch> <20040829160542.GF5492@holomorphy.com> <20040829170247.GA9841@k3.hellgate.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040829170247.GA9841@k3.hellgate.ch>
X-Operating-System: Linux 2.6.8 on i686
X-GPG-Fingerprint: 92 F4 DC 20 57 46 7B 95  24 4E 9E E7 5A 54 DC 1B
X-GPG: 1024/80E744BD wwwkeys.ch.pgp.net
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This posting demonstrates a new method of monitoring all processes in
a large system.

You may remember what a /proc based tool does when monitoring some
10^5 processes -- it spends its time in the kernel hanging on to a
read task_list_lock:

==> 10000 processes: top -d 0 -b > /dev/null <==
CPU: CPU with timer interrupt, speed 0 MHz (estimated)
Profiling through timer interrupt
samples  %        image name               symbol name
35855    36.0707  vmlinux                  get_tgid_list
9366      9.4223  vmlinux                  pid_alive
7077      7.1196  libc-2.3.3.so            _IO_vfscanf_internal
5386      5.4184  vmlinux                  number
3664      3.6860  vmlinux                  proc_pid_stat
3077      3.0955  libc-2.3.3.so            _IO_vfprintf_internal
2136      2.1489  vmlinux                  __d_lookup
1720      1.7303  vmlinux                  vsnprintf
1451      1.4597  libc-2.3.3.so            __i686.get_pc_thunk.bx
1409      1.4175  libc-2.3.3.so            _IO_default_xsputn_internal
1258      1.2656  libc-2.3.3.so            _IO_putc_internal
1225      1.2324  vmlinux                  link_path_walk
1210      1.2173  libc-2.3.3.so            ____strtoul_l_internal
1199      1.2062  vmlinux                  task_statm
1157      1.1640  libc-2.3.3.so            ____strtol_l_internal
794       0.7988  libc-2.3.3.so            _IO_sputbackc_internal
776       0.7807  libncurses.so.5.4        _nc_outch

Here's a profile for an nproc based tool monitoring the same set
of processes:

==> 10000 processes: nprocbench <==
CPU: CPU with timer interrupt, speed 0 MHz (estimated)
Profiling through timer interrupt
samples  %        app name                 symbol name
8641     24.8626  vmlinux                  __task_mem
2778      7.9931  vmlinux                  find_pid
2536      7.2968  vmlinux                  finish_task_switch
1872      5.3863  vmlinux                  netlink_recvmsg
1637      4.7101  vmlinux                  nproc_pid_fields
1373      3.9505  vmlinux                  __wake_up
1218      3.5045  vmlinux                  __copy_to_user_ll
1134      3.2628  vmlinux                  __task_mem_cheap
944       2.7162  vmlinux                  mmgrab
876       2.5205  vmlinux                  nproc_ps_do_pid
568       1.6343  vmlinux                  skb_dequeue
526       1.5135  libc-2.3.3.so            __recv
514       1.4789  vmlinux                  alloc_skb
510       1.4674  vmlinux                  __might_sleep
485       1.3955  vmlinux                  skb_release_data
463       1.3322  vmlinux                  netlink_attachskb
363       1.0445  vmlinux                  sys_recvfrom

Resource usage is now dominated by field computation, rather than by
delivery overhead. By now it should be clear that nproc is not only a
cleaner interface with lower overhead for tools, it also scales a lot
better than /proc.

Roger
