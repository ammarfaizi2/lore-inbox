Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269293AbUIHSnL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269293AbUIHSnL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Sep 2004 14:43:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269297AbUIHSnL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Sep 2004 14:43:11 -0400
Received: from mail2.bluewin.ch ([195.186.4.73]:57574 "EHLO mail2.bluewin.ch")
	by vger.kernel.org with ESMTP id S269303AbUIHSle (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Sep 2004 14:41:34 -0400
Date: Wed, 8 Sep 2004 20:40:28 +0200
From: Roger Luethi <rl@hellgate.ch>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Cc: Albert Cahalan <albert@users.sf.net>,
       William Lee Irwin III <wli@holomorphy.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>, Paul Jackson <pj@sgi.com>
Subject: [0/1][ANNOUNCE] nproc v2: netlink access to /proc information
Message-ID: <20040908184028.GA10840@k3.hellgate.ch>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org, Albert Cahalan <albert@users.sf.net>,
	William Lee Irwin III <wli@holomorphy.com>,
	"Martin J. Bligh" <mbligh@aracnet.com>, Paul Jackson <pj@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Operating-System: Linux 2.6.9-rc1-bk13 on i686
X-GPG-Fingerprint: 92 F4 DC 20 57 46 7B 95  24 4E 9E E7 5A 54 DC 1B
X-GPG: 1024/80E744BD wwwkeys.ch.pgp.net
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am submitting nproc, a new netlink interface to process information,
for review and a possible inclusion in mainline.

The problems with /proc as far as parsers go are widely known. Parsing is
both difficult and slow (including a more detailed discussion by reference:
http://marc.theaimsgroup.com/?l=linux-kernel&m=109361019528995). What
follows is an overview showing how nproc fares in those areas.

Roger

-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
Clean Interface
---------------
The main motivation was to clean up the mess that are /proc semantics
and provide a clean interface for tools to gather process information.

Nproc does not add new knowledge to the kernel (some redundancy remains
until routines are shared with /proc). Instead, it offers existing
information in a form that works for tools. In fact, a tool can pass
the buffer read from the netlink directly as a va_list to vprintf
(strings require a trivial extra operation).

A small user-space app can present a view like the one below based on
zero prior knowledge about the fields the kernel has to offer. While I
don't envision that as common for tools in the future, it demonstrates
what can be done with little effort. This is not a mock-up, by the way,
the nprocdemo tool exists (lines truncated to fit 80 chars).

MemFree |PageSize|Jiffies   |nr_dirty|nr_writeback|nr_unstable|[...]
____page|____byte|__________|____page|________page|_______page|[...]
    7546|    4096|   1917203|       1|           0|          0|[...]

PID  |Name           |VmSize  |VmLock  |VmRSS   |VmData  |VmStack |[...]
_____|_______________|_____KiB|_____KiB|_____KiB|_____KiB|_____KiB|[...]
    1|init           |    1340|       0|     468|     144|       4|[...]
    2|ksoftirqd/0    |       0|       0|       0|       0|       0|[...]
    3|events/0       |       0|       0|       0|       0|       0|[...]
    4|khelper        |       0|       0|       0|       0|       0|[...]
    5|netlink/0      |       0|       0|       0|       0|       0|[...]
    6|kacpid         |       0|       0|       0|       0|       0|[...]
   23|kblockd/0      |       0|       0|       0|       0|       0|[...]
   24|khubd          |       0|       0|       0|       0|       0|[...]
   36|pdflush        |       0|       0|       0|       0|       0|[...]
   37|pdflush        |       0|       0|       0|       0|       0|[...]
   38|kswapd0        |       0|       0|       0|       0|       0|[...]
   39|aio/0          |       0|       0|       0|       0|       0|[...]
  671|kseriod        |       0|       0|       0|       0|       0|[...]
  686|reiserfs/0     |       0|       0|       0|       0|       0|[...]
  851|udevd          |    1320|       0|     360|     144|       4|[...]
 9159|syslogd        |    1516|       0|     588|     272|      16|[...]
 9382|gpm            |    1540|       0|     468|     152|       4|[...]
 9452|klogd          |    1468|       0|     432|     276|       8|[...]
 9478|hddtemp        |    1692|       0|     848|     472|      16|[...]
 9486|login          |    2152|       0|    1204|     392|      36|[...]
 9487|agetty         |    1340|       0|     488|     156|       4|[...]
 9488|agetty         |    1340|       0|     488|     156|       4|[...]
 9489|agetty         |    1340|       0|     488|     156|       4|[...]
 9490|agetty         |    1340|       0|     488|     156|       4|[...]
 9491|agetty         |    1340|       0|     488|     156|       4|[...]
 9598|zsh            |    4748|       0|    1688|     532|      20|[...]
[...]

Performance
-----------
I measured the time to write a complete process table dump for 5000
tasks to /dev/null 100 times for "ps ax" and nprocdemo.

ps ax     (5 process fields):
real    1m0.472s
user    0m18.227s
sys     0m28.545s

nprocdemo (automatic field discovery, reading and printing 11 process
           fields + 9 global fields):
real    0m9.064s
user    0m2.491s
sys     0m1.554s

The details of resource usage for the benchmarks show that /proc based
tools are suffering badly from the inefficiency of three(!) conversions
between data and strings (kernel produces strings from numbers, app
converts back to numbers, app converts numbers again to strings for
printing).

For nproc based tools, only one conversion remains.

# ps ax > /dev/null
CPU: CPU with timer interrupt, speed 0 MHz (estimated)
Profiling through timer interrupt
samples  %        image name           app name   symbol name
6524     14.0613  vmlinux              ps         number
4828     10.4058  libc-2.3.3.so        ps         _IO_vfscanf_internal
2740      5.9056  vmlinux              ps         vsnprintf
2689      5.7956  vmlinux              ps         proc_pid_stat
1807      3.8946  vmlinux              ps         __d_lookup
1676      3.6123  libc-2.3.3.so        ps         ____strtol_l_internal
1335      2.8773  vmlinux              ps         link_path_walk
1133      2.4420  libproc-3.2.3.so     ps         status2proc
1094      2.3579  vmlinux              ps         render_sigset_t
1088      2.3450  libc-2.3.3.so        ps         _IO_vfprintf_internal
1086      2.3407  libc-2.3.3.so        ps         __GI_strchr
885       1.9075  libc-2.3.3.so        ps         ____strtoul_l_internal
800       1.7242  vmlinux              ps         pid_revalidate
581       1.2522  vmlinux              ps         proc_pid_status
551       1.1876  libc-2.3.3.so        ps         _IO_sputbackc_internal
529       1.1402  vmlinux              ps         system_call
524       1.1294  libc-2.3.3.so        ps         _IO_default_xsputn_internal
476       1.0259  libc-2.3.3.so        ps         __i686.get_pc_thunk.bx
466       1.0044  vmlinux              ps         get_tgid_list
442       0.9526  vmlinux              ps         atomic_dec_and_lock
373       0.8039  vmlinux              ps         dput
311       0.6703  libc-2.3.3.so        ps         __GI___strtol_internal
274       0.5906  vmlinux              ps         __copy_to_user_ll
272       0.5862  vmlinux              ps         path_lookup
270       0.5819  vmlinux              ps         strncpy_from_user
262       0.5647  libproc-3.2.3.so     ps         escape_str
259       0.5582  vmlinux              ps         page_address
249       0.5367  libc-2.3.3.so        ps         __GI_____strtoull_l_internal
244       0.5259  libc-2.3.3.so        ps         __GI_strlen

# nprocdemo > /dev/null
CPU: CPU with timer interrupt, speed 0 MHz (estimated)
Profiling through timer interrupt
samples  %        image name           app name   symbol name
1142     15.9208  libc-2.3.3.so        nprocdemo  _IO_vfprintf_internal
1072     14.9449  vmlinux              vmlinux    __task_mem
611       8.5181  libc-2.3.3.so        nprocdemo  _IO_new_file_xsputn
445       6.2038  vmlinux              vmlinux    nproc_pid_fields
244       3.4016  vmlinux              vmlinux    get_wchan
235       3.2762  vmlinux              nprocdemo  __copy_to_user_ll
233       3.2483  vmlinux              vmlinux    find_pid
215       2.9974  vmlinux              vmlinux    finish_task_switch
208       2.8998  vmlinux              nprocdemo  netlink_recvmsg
158       2.2027  vmlinux              nprocdemo  __wake_up
153       2.1330  libc-2.3.3.so        nprocdemo  __find_specmb
149       2.0772  vmlinux              nprocdemo  finish_task_switch
146       2.0354  libc-2.3.3.so        nprocdemo  __i686.get_pc_thunk.bx
114       1.5893  vmlinux              vmlinux    get_task_mm
94        1.3105  vmlinux              nprocdemo  skb_release_data
87        1.2129  vmlinux              vmlinux    nproc_ps_do_pid
76        1.0595  vmlinux              vmlinux    alloc_skb
72        1.0038  vmlinux              nprocdemo  system_call
68        0.9480  libc-2.3.3.so        nprocdemo  _IO_padn_internal
65        0.9062  libc-2.3.3.so        nprocdemo  read_int
64        0.8922  libc-2.3.3.so        nprocdemo  __recv
63        0.8783  vmlinux              vmlinux    netlink_attachskb
61        0.8504  vmlinux              nprocdemo  kfree
56        0.7807  vmlinux              vmlinux    __kmalloc
55        0.7668  vmlinux              vmlinux    schedule
47        0.6552  vmlinux              vmlinux    __task_mem_cheap
42        0.5855  vmlinux              nprocdemo  sys_socketcall
40        0.5576  vmlinux              nprocdemo  fget
37        0.5158  nprocdemo            nprocdemo  nproc_get_reply

EOT
