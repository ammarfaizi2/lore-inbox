Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262074AbREPUOt>; Wed, 16 May 2001 16:14:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262071AbREPUOk>; Wed, 16 May 2001 16:14:40 -0400
Received: from d12lmsgate-3.de.ibm.com ([195.212.91.201]:60619 "EHLO
	d12lmsgate-3.de.ibm.com") by vger.kernel.org with ESMTP
	id <S262074AbREPUOX>; Wed, 16 May 2001 16:14:23 -0400
From: Ulrich.Weigand@de.ibm.com
X-Lotus-FromDomain: IBMDE
To: linux-kernel@vger.kernel.org
Message-ID: <C1256A4E.006F279E.00@d12mta11.de.ibm.com>
Date: Wed, 16 May 2001 22:14:02 +0200
Subject: OOM deadlock with NFS on 2.4.4
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Hello,

we are experiencing deadlocks when running the RedHat stress test
suite.  The test case is basically compiling a kernel on a file
system mounted via NFS from localhost (while this is obviously not
particularly sensible, it should nevertheless work ...), while
putting memory pressure on the system at the same time.

What happens is that all tasks go to status D (or S), all CPUs
go to the idle routine, and the system never recovers from this
state.  Appended below are excerpts from a snapshot of the
deadlocked system showing the backtraces of all tasks in status D
and some other info.  In the test below, the machine was running
on 2 CPUs and it took about three hours to deadlock; the deadlock
is reached sooner when running on more CPUs.

The apparent reason for the stuck system is a deadlock between
the NFS server and the MM layer (page_launder etc.):

As memory gets low, kswapd (and other tasks as well) decide to
call page_launder to free some dirty pages.  This in turn causes
pages to be written to backing store.  Unfortunately, the backing
store happens to reside on a NFS file system, to page_launder sends
an NFS request to the server and blocks, awaiting the reply.

The NFS server happens to run on the same machine, and in the turn
of processing the request, it needs memory.  This causes page_launder
to get involved again, which causes another NFS request to be sent.
This goes on until the maximum amount of pending NFS requests is
reached.

Then, most tasks (that are not already blocked on something else)
just spin around the loop in nfs_create_request, without anybody
ever making any progress ...

Any idea how to fix this?




SETUP OF REDHAT STRESS TEST
==========================
#
# This is the ctcs driver file.  This file is auto-created.
#
set verbose 1
bg 4 NFS-COMPILE nfstest.sh
bg 1024 TTCP ttcp_driver.sh localhost localhost
bg 256 FIFOS_MMAP dt_driver.sh
bg 64 FS fs-test-driver.sh
bg 256 CRASHME crashme_driver.sh
wait
exit


OUTPUT OF FREE
==============
           total       used       free     shared    buffers     cached
Mem:        126212     125164       1048          0       1160      55528
-/+ buffers/cache:      68476      57736
Swap:       204792       8316     196476



STACK TRACES OF ALL TASKS in STATE 2 (TASK_UNINTERRUPTIBLE)
===========================================================

================================================================
STACK TRACE FOR TASK: 0x596000 (kswapd)

 STACK:
 0 schedule+1076 [0x1bf38]
 1 schedule_timeout+178 [0x1b9f2]
 2 sleep_on_timeout+134 [0x1c6f2]
 3 nfs_create_request+390 [0x7c412]
 4 nfs_update_request+720 [0x7d11c]
 5 nfs_writepage_async+38 [0x7bdc2]
 6 nfs_writepage+274 [0x7bf12]
 7 page_launder+1242 [0x3edc6]
 8 do_try_to_free_pages+118 [0x3fcb2]
 9 kswapd+196 [0x3fdcc]
10 kernel_thread+48 [0x15574]
================================================================

================================================================
STACK TRACE FOR TASK: 0x592000 (bdflush)

 STACK:
 0 schedule+1076 [0x1bf38]
 1 schedule_timeout+178 [0x1b9f2]
 2 sleep_on_timeout+134 [0x1c6f2]
 3 nfs_create_request+390 [0x7c412]
 4 nfs_update_request+720 [0x7d11c]
 5 nfs_writepage_async+38 [0x7bdc2]
 6 nfs_writepage+274 [0x7bf12]
 7 page_launder+1242 [0x3edc6]
 8 bdflush+264 [0x4dfd4]
 9 kernel_thread+48 [0x15574]
================================================================

================================================================
STACK TRACE FOR TASK: 0x590000 (kupdated)

 STACK:
 0 schedule+1076 [0x1bf38]
 1 schedule_timeout+178 [0x1b9f2]
 2 sleep_on_timeout+134 [0x1c6f2]
 3 nfs_create_request+390 [0x7c412]
 4 nfs_update_request+720 [0x7d11c]
 5 nfs_writepage_async+38 [0x7bdc2]
 6 nfs_writepage+274 [0x7bf12]
 7 filemap_fdatasync+314 [0x346fe]
 8 sync_unlocked_inodes+256 [0x62f54]
 9 sync_old_buffers+104 [0x4dd30]
10 kupdate+412 [0x4e1c4]
11 kernel_thread+48 [0x15574]
================================================================

================================================================
STACK TRACE FOR TASK: 0x5274000 (klogd)

 STACK:
 0 schedule+1076 [0x1bf38]
 1 schedule_timeout+178 [0x1b9f2]
 2 sleep_on_timeout+134 [0x1c6f2]
 3 nfs_create_request+390 [0x7c412]
 4 nfs_update_request+720 [0x7d11c]
 5 nfs_writepage_async+38 [0x7bdc2]
 6 nfs_writepage+274 [0x7bf12]
 7 page_launder+1242 [0x3edc6]
 8 do_try_to_free_pages+118 [0x3fcb2]
 9 try_to_free_pages+60 [0x3fed8]
10 __alloc_pages+724 [0x40fe8]
11 __get_free_pages+60 [0x410bc]
12 read_swap_cache_async+98 [0x41b8e]
13 do_swap_page+184 [0x318b8]
14 handle_mm_fault+212 [0x31e80]
15 do_page_fault+638 [0x112ae]
16 pgm_dn [0x13720]
================================================================

================================================================
STACK TRACE FOR TASK: 0x4cc4000 (xfs)

 STACK:
 0 schedule+1076 [0x1bf38]
 1 schedule_timeout+178 [0x1b9f2]
 2 sleep_on_timeout+134 [0x1c6f2]
 3 nfs_create_request+390 [0x7c412]
 4 nfs_update_request+720 [0x7d11c]
 5 nfs_writepage_async+38 [0x7bdc2]
 6 nfs_writepage+274 [0x7bf12]
 7 page_launder+1242 [0x3edc6]
 8 do_try_to_free_pages+118 [0x3fcb2]
 9 try_to_free_pages+60 [0x3fed8]
10 __alloc_pages+724 [0x40fe8]
11 __get_free_pages+60 [0x410bc]
12 read_swap_cache_async+98 [0x41b8e]
13 swapin_readahead+244 [0x317b8]
14 do_swap_page+176 [0x318b0]
15 handle_mm_fault+212 [0x31e80]
16 do_page_fault+638 [0x112ae]
17 pgm_dn [0x13720]
================================================================

================================================================
STACK TRACE FOR TASK: 0x4bb8000 (in.telnetd)

 STACK:
 0 schedule+1076 [0x1bf38]
 1 schedule_timeout+178 [0x1b9f2]
 2 sleep_on_timeout+134 [0x1c6f2]
 3 nfs_create_request+390 [0x7c412]
 4 nfs_update_request+720 [0x7d11c]
 5 nfs_writepage_async+38 [0x7bdc2]
 6 nfs_writepage+274 [0x7bf12]
 7 page_launder+1242 [0x3edc6]
 8 do_try_to_free_pages+118 [0x3fcb2]
 9 try_to_free_pages+60 [0x3fed8]
10 __alloc_pages+724 [0x40fe8]
11 __get_free_pages+60 [0x410bc]
12 __pollwait+74 [0x5caea]
13 tcp_poll+58 [0x1164ce]
14 sock_poll+40 [0xfafc0]
15 do_select+320 [0x5cda8]
16 sys_select+778 [0x5d246]
17 pgm_system_call+34 [0x130d0]
================================================================

================================================================
STACK TRACE FOR TASK: 0x4810000 (free)

 STACK:
 0 schedule+1076 [0x1bf38]
 1 schedule_timeout+178 [0x1b9f2]
 2 sleep_on_timeout+134 [0x1c6f2]
 3 nfs_create_request+390 [0x7c412]
 4 nfs_update_request+720 [0x7d11c]
 5 nfs_writepage_async+38 [0x7bdc2]
 6 nfs_writepage+274 [0x7bf12]
 7 page_launder+1242 [0x3edc6]
 8 do_try_to_free_pages+118 [0x3fcb2]
 9 try_to_free_pages+60 [0x3fed8]
10 __alloc_pages+724 [0x40fe8]
11 __get_free_pages+60 [0x410bc]
12 proc_file_read+76 [0x6a498]
13 sys_read+208 [0x477e0]
14 pgm_system_call+34 [0x130d0]
================================================================

================================================================
STACK TRACE FOR TASK: 0x54b0000 (nfsd)

 STACK:
 0 schedule+1076 [0x1bf38]
 1 schedule_timeout+178 [0x1b9f2]
 2 sleep_on_timeout+134 [0x1c6f2]
 3 nfs_create_request+390 [0x7c412]
 4 nfs_update_request+720 [0x7d11c]
 5 nfs_writepage_async+38 [0x7bdc2]
 6 nfs_writepage+274 [0x7bf12]
 7 page_launder+1242 [0x3edc6]
 8 do_try_to_free_pages+118 [0x3fcb2]
 9 try_to_free_pages+60 [0x3fed8]
10 __alloc_pages+724 [0x40fe8]
11 generic_file_write+1046 [0x3885a]
12 nfsd_write+370 [0x87ab2]
13 nfsd_proc_write+242 [0x844f6]
14 nfsd_dispatch+250 [0x838be]
15 svc_process+774 [0x14cfa6]
16 nfsd+754 [0x8361e]
17 kernel_thread+48 [0x15574]
================================================================

================================================================
STACK TRACE FOR TASK: 0x5578000 (dt)

 STACK:
 0 schedule+1076 [0x1bf38]
 1 schedule_timeout+178 [0x1b9f2]
 2 sleep_on_timeout+134 [0x1c6f2]
 3 nfs_create_request+390 [0x7c412]
 4 nfs_update_request+720 [0x7d11c]
 5 nfs_writepage_async+38 [0x7bdc2]
 6 nfs_writepage+274 [0x7bf12]
 7 page_launder+1242 [0x3edc6]
 8 do_try_to_free_pages+118 [0x3fcb2]
 9 try_to_free_pages+60 [0x3fed8]
10 __alloc_pages+724 [0x40fe8]
11 read_cluster_nonblocking+366 [0x34dfa]
12 filemap_nopage+608 [0x36890]
13 do_no_page+132 [0x31cd0]
14 handle_mm_fault+254 [0x31eaa]
15 do_page_fault+638 [0x112ae]
16 pgm_dn [0x13720]
================================================================

================================================================
STACK TRACE FOR TASK: 0x344c000 (mkdep)

 STACK:
 0 schedule+1076 [0x1bf38]
 1 __rpc_execute+712 [0x149ba4]
 2 rpc_execute+182 [0x149db6]
 3 rpc_call_sync+170 [0x14481e]
 4 nfs_proc_lookup+174 [0x80696]
 5 nfs_lookup_revalidate+404 [0x7ee7c]
 6 cached_lookup+64 [0x565d0]
 7 path_walk+1942 [0x5717a]
 8 open_namei+268 [0x57dd0]
 9 filp_open+76 [0x46bb0]
10 sys_open+116 [0x47084]
11 pgm_system_call+34 [0x130d0]
================================================================

================================================================
STACK TRACE FOR TASK: 0x5652000 (mkdep)

 STACK:
 0 schedule+1076 [0x1bf38]
 1 __rpc_execute+712 [0x149ba4]
 2 rpc_execute+182 [0x149db6]
 3 rpc_call_sync+170 [0x14481e]
 4 nfs_proc_lookup+174 [0x80696]
 5 nfs_lookup_revalidate+404 [0x7ee7c]
 6 cached_lookup+64 [0x565d0]
 7 path_walk+1942 [0x5717a]
 8 __user_walk+106 [0x57b36]
 9 sys_access+136 [0x461dc]
10 pgm_system_call+34 [0x130d0]
================================================================

================================================================
STACK TRACE FOR TASK: 0x48ee000 (md5sum)

 STACK:
 0 schedule+1076 [0x1bf38]
 1 __lock_page+162 [0x34ff2]
 2 lock_page+94 [0x350a6]
 3 do_generic_file_read+946 [0x35cee]
 4 generic_file_read+100 [0x36168]
 5 nfs_file_read+204 [0x7a1c4]
 6 sys_read+208 [0x477e0]
 7 pgm_system_call+34 [0x130d0]
================================================================

================================================================
STACK TRACE FOR TASK: 0x3d76000 (date)

 STACK:
 0 schedule+1076 [0x1bf38]
 1 schedule_timeout+178 [0x1b9f2]
 2 sleep_on_timeout+134 [0x1c6f2]
 3 nfs_create_request+390 [0x7c412]
 4 nfs_update_request+720 [0x7d11c]
 5 nfs_writepage_async+38 [0x7bdc2]
 6 nfs_writepage+274 [0x7bf12]
 7 page_launder+1242 [0x3edc6]
 8 do_try_to_free_pages+118 [0x3fcb2]
 9 try_to_free_pages+60 [0x3fed8]
10 __alloc_pages+724 [0x40fe8]
11 read_cluster_nonblocking+366 [0x34dfa]
12 filemap_nopage+608 [0x36890]
13 do_no_page+132 [0x31cd0]
14 handle_mm_fault+254 [0x31eaa]
15 do_page_fault+638 [0x112ae]
16 pgm_dn [0x13720]
================================================================


RUNNING TASKS
=============


    ADDR    UID    PID   PPID  STATE     FLAGS  NAME
===============================================================================
  188000      0      0      0      0         0  swapper
  5ba000      0      1      0      1       100  init
  5b2000      0      2      1      1        40  kmcheck
  5a6000      0      3      1      1        40  keventd
  596000      0      4      1      2       840  kswapd
  594000      0      5      1      1       840  kreclaimd
  592000      0      6      1      2        40  bdflush
  590000      0      7      1      2        40  kupdated
 54f8000      1    288      1      1       140  portmap
 55f6000      0    350      1      1        40  syslogd
 5274000      0    364      1      2       940  klogd
 56f2000      0    383      1      1        40  crond
 5120000      0    402      1      1       140  inetd
 501c000      0    421      1      1       140  httpd
  886000     99    426    421      1       140  httpd
 4e3c000     99    427    421      1       140  httpd
 4da8000     99    428    421      1       140  httpd
 4d9e000     99    429    421      1       140  httpd
 4e62000     99    430    421      1       140  httpd
 4dcc000     99    431    421      1       140  httpd
 4e36000     99    432    421      1       140  httpd
 4e70000     99    433    421      1       140  httpd
 4cc4000    100    449      1      2       840  xfs
 5522000      0    468      1      1         0  sulogin
 4bb8000      0    469    402      2       800  in.telnetd
 4b86000      0    470    469      1       100  login
 4a76000      0    471    470      1       100  bash
 49cc000      0    486    402      1         0  in.telnetd
 4902000      0    487    486      1       100  login
 4862000      0    488    487      1       100  bash
 4810000      0    499    488      2       800  free
 47e8000      0    500    471      1       100  run
 45a6000      0    506    500      1         0  runtest
 454c000      0    509    500      1         0  runtest
 4538000      0    518    500      1         0  runtest
 41ac000      0   1812    402      1         0  in.telnetd
 2c54000      0   1813   1812      1       100  login
 3740000      0   1816   1813      1       100  bash
 30f2000      0  10371    506      1         0  nfstest.sh
 3672000      0  10413      1      1        40  rpc.rquotad
 40fe000      0  10427      1      1       140  rpc.mountd
 14b0000      0  10445      1      1       140  nfsd
  dca000      0  10446      1      1       140  nfsd
 56b2000      0  10447      1      1       140  nfsd
 1504000      0  10448      1      1       140  nfsd
 166a000      0  10449      1      1       140  nfsd
 57d4000      0  10450      1      1       140  nfsd
 54b0000      0  10451      1      2       940  nfsd
 1962000      0  10452      1      1       140  nfsd
 4614000      0  10453  10445      1        40  lockd
 4f6a000      0  10454  10453      1       840  rpciod
 443a000      0  11023    518      1         0  dt_driver.sh
 2d36000      0  11407  10371      1       100  make
 1486000      0  11430  11407      1       100  make
 2c68000      0  11437  11430      1       100  make
 2148000      0  11444  11437      1       100  make
 4532000      0  12099  11444      1       100  make
 425c000      0  12128  12099      1       100  make
 102e000      0  12199  11444      1       100  make
 5578000      0  12202  11023      2       800  dt
 1b88000      0  12203  12199      1       100  sh
 344c000      0  12204  12203      2       100  mkdep
 29bc000      0  12205  11444      1       100  make
 10d0000      0  12211  12128      1       100  make
  728000      0  12212  12205      1       100  sh
 5652000      0  12213  12212      2       100  mkdep
 3ddc000      0  12214  12211      1       100  sh
 48ee000      0  12215  12214      2         0  md5sum
 47a6000      0  12216    509      1        40  runtest
 3d76000      0  12217  12216      2       800  date

============================
STACK TRACE OF RUNNING TASKS
============================

================================================================
TASK HAS CPU (0): 0x188000 (swapper):
 LOWCORE INFO:
  -psw      : 0x070e0000 0x800151dc
  -function : cpu_idle+172
  -prefix   : 0x005d3000
  -cpu timer: 0xffffd4bc 0xd3b1b1a0
  -clock cmp: 0xb5d7bcd9 0x2d227f40
  -general registers:
     00000000 001e5020 00000000 0000000f
     800151b0 0020613c 00000000 00000000
     00000000 0001f728 00188000 002628e8
     00188000 80015138 800151b0 00189ed0
  -access registers:
     00000000 00000000 00000000 00000000
     00000001 00000000 00000000 00000000
     00000000 00000000 00000000 00000000
     00000000 00000000 00000000 00000000
  -control registers:
     14b52802 0025d07f 00000000 00000000
     00000000 00000000 11000000 8219e1ff
     00000000 00000000 00000000 00000000
     00000000 8219e1ff d0000000 00000000
  -floating point registers:
     00000000 00000000 00000000 00000000
     00000000 00000000 00000000 00000000

 STACK:
 0 start_kernel+660 [0x1d8918]
 1 _stext+98 [0x10862]
 2 <back chain invalid>+<ERROR> [0x647d40]

=================================
STACK TRACE OF RUNNING IDLE TASKS
=================================

=================================================================
TASK HAS CPU (1): 0x5d0000 (swapper):
 LOWCORE INFO:
  -psw      : 0x070e0000 0x800151dc
  -function : cpu_idle+172
  -prefix   : 0x005d2000
  -cpu timer: 0xffffd4be 0x63dd5540
  -clock cmp: 0xb5d7bcd9 0x2e302e80
  -general registers:
     00000000 001e5020 00000000 0000000f
     800151d0 0018b2b0 00000000 00000000
     00000000 00000000 00000000 00000000
     005d0000 80015138 800151d0 005d1e40
  -access registers:
     00000000 00000000 00000000 00000000
     00000001 00000000 00000000 00000000
     00000000 00000000 00000000 00000000
     00000000 00000000 00000000 00000000
  -control registers:
     14b52802 0025d07f 00000000 00000000
     00000000 00000000 11000000 808fc1ff
     00000000 00000000 00000000 00000000
     00000000 808fc1ff d0000000 00000000
  -floating point registers:
     00000000 00000000 00000000 00000000
     00000000 00000000 00000000 00000000

 STACK:
 0 start_secondary+86 [0x1d991e]
 1 start_secondary [0x1d98c8]




Mit freundlichen Gruessen / Best Regards

Ulrich Weigand

--
  Dr. Ulrich Weigand
  Linux for S/390 Design & Development
  IBM Deutschland Entwicklung GmbH, Schoenaicher Str. 220, 71032 Boeblingen
  Phone: +49-7031/16-3727   ---   Email: Ulrich.Weigand@de.ibm.com


