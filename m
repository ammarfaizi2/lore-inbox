Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268222AbUH2RGa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268222AbUH2RGa (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Aug 2004 13:06:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268204AbUH2RFx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Aug 2004 13:05:53 -0400
Received: from mail4.bluewin.ch ([195.186.4.74]:60871 "EHLO mail4.bluewin.ch")
	by vger.kernel.org with ESMTP id S268203AbUH2REA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Aug 2004 13:04:00 -0400
Date: Sun, 29 Aug 2004 19:02:48 +0200
From: Roger Luethi <rl@hellgate.ch>
To: William Lee Irwin III <wli@holomorphy.com>, linux-kernel@vger.kernel.org,
       Albert Cahalan <albert@users.sf.net>, Paul Jackson <pj@sgi.com>
Subject: Re: [BENCHMARK] nproc: netlink access to /proc information
Message-ID: <20040829170247.GA9841@k3.hellgate.ch>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org, Albert Cahalan <albert@users.sf.net>,
	Paul Jackson <pj@sgi.com>
References: <20040827122412.GA20052@k3.hellgate.ch> <20040827162308.GP2793@holomorphy.com> <20040828194546.GA25523@k3.hellgate.ch> <20040828195647.GP5492@holomorphy.com> <20040828201435.GB25523@k3.hellgate.ch> <20040829160542.GF5492@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040829160542.GF5492@holomorphy.com>
X-Operating-System: Linux 2.6.8 on i686
X-GPG-Fingerprint: 92 F4 DC 20 57 46 7B 95  24 4E 9E E7 5A 54 DC 1B
X-GPG: 1024/80E744BD wwwkeys.ch.pgp.net
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 29 Aug 2004 09:05:42 -0700, William Lee Irwin III wrote:
> Okay, these explain some of the difference. I usually see issues with
> around 10000 processes with fully populated virtual address spaces and
> several hundred vmas each, varying between 200 to 1000, mostly
> concentrated at somewhere just above 300.

I agree, that should make quite a difference. As you said, we are
working on orthogonal areas: My current focus is on data delivery (sane
semantics and minimal overhead), while you seem to be more interested
in better data gathering.

I profiled "top -d 0 -b > /dev/null" for about 100 and 10^5 processes.

When monitoring 100 (real-world) processes, /proc specific overhead
(_IO_vfscanf_internal, number, __d_lookup, vsnprintf, etc.) amounts to
about one third of total resource usage.

==> 100 processes: top -d 0 -b > /dev/null <==
CPU: CPU with timer interrupt, speed 0 MHz (estimated)
Profiling through timer interrupt
samples  %        image name               symbol name
20439    12.2035  libc-2.3.3.so            _IO_vfscanf_internal
15852     9.4647  vmlinux                  number
11635     6.9469  vmlinux                  task_statm
9286      5.5444  libc-2.3.3.so            _IO_vfprintf_internal
9128      5.4500  vmlinux                  proc_pid_stat
5395      3.2212  vmlinux                  __d_lookup
4738      2.8289  vmlinux                  vsnprintf
4123      2.4617  libc-2.3.3.so            _IO_default_xsputn_internal
4110      2.4540  libc-2.3.3.so            __i686.get_pc_thunk.bx
3712      2.2163  libc-2.3.3.so            _IO_putc_internal
3504      2.0921  vmlinux                  link_path_walk
3417      2.0402  libc-2.3.3.so            ____strtoul_l_internal
3363      2.0079  libc-2.3.3.so            ____strtol_l_internal
2250      1.3434  libncurses.so.5.4        _nc_outch
2116      1.2634  libc-2.3.3.so            _IO_sputbackc_internal
2006      1.1977  top                      task_show
1851      1.1052  vmlinux                  pid_revalidate

With 10^5 additional dummy processes, resource usage is dominated by
attempts to get a current list of pids. My own benchmark walked a list
of known pids, so that was not an issue. I bet though that nproc can
provide more efficient means to get such a list than getdents (we could
even allow a user to ask for a message on process creation/kill).

So basically that's just another place where nproc-based tools would
trounce /proc-based ones (that piece is vaporware today, though).

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

The remaining profiles are for two benchmarks from my previous message.

Field computation is more prominent than with top because the benchmark
uses a known list of pids and parsing is kept at a trivial level.

==> /prod/pid/statm (2x) for 10000 processes <==
CPU: CPU with timer interrupt, speed 0 MHz (estimated)
Profiling through timer interrupt
samples  %        image name               symbol name
7430      9.9485  libc-2.3.3.so            _IO_vfscanf_internal
6195      8.2948  vmlinux                  __d_lookup
5477      7.3335  vmlinux                  task_statm
5082      6.8046  vmlinux                  number
3227      4.3208  vmlinux                  link_path_walk
3050      4.0838  libc-2.3.3.so            ____strtol_l_internal
2116      2.8332  libc-2.3.3.so            _IO_vfprintf_internal
2064      2.7636  vmlinux                  vsnprintf
1664      2.2280  vmlinux                  atomic_dec_and_lock
1551      2.0767  vmlinux                  task_dumpable
1497      2.0044  vmlinux                  pid_revalidate
1419      1.9000  vmlinux                  system_call
1401      1.8759  vmlinux                  pid_alive
1244      1.6657  libc-2.3.3.so            _IO_sputbackc_internal
1175      1.5733  vmlinux                  dnotify_parent
1060      1.4193  libc-2.3.3.so            _IO_default_xsputn_internal
922       1.2345  vmlinux                  file_move

nproc removes most of the delivery overhead so field computation is
now dominant. Strictly speaking, it should be even higher because the
benchmarks requests the same fields three times, but they only get
computed once in such a case.

==> 27 nproc fields for 10000 processes, one process per request <==
CPU: CPU with timer interrupt, speed 0 MHz (estimated)
Profiling through timer interrupt
samples  %        image name               symbol name
7647     25.0894  vmlinux                  __task_mem
2125      6.9720  vmlinux                  find_pid
1884      6.1813  vmlinux                  nproc_pid_fields
1488      4.8820  vmlinux                  __task_mem_cheap
1161      3.8092  vmlinux                  mmgrab
978       3.2088  vmlinux                  netlink_recvmsg
944       3.0972  vmlinux                  alloc_skb
935       3.0677  vmlinux                  __might_sleep
751       2.4640  vmlinux                  nproc_select_pid
738       2.4213  vmlinux                  system_call
691       2.2671  vmlinux                  skb_dequeue
636       2.0867  vmlinux                  netlink_sendmsg
630       2.0670  vmlinux                  __copy_from_user_ll
624       2.0473  vmlinux                  sockfd_lookup
621       2.0375  vmlinux                  kfree
602       1.9751  vmlinux                  __reply_size
523       1.7159  vmlinux                  fget

Roger
