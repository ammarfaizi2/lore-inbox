Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264829AbTL0V4P (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Dec 2003 16:56:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264855AbTL0V4P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Dec 2003 16:56:15 -0500
Received: from waste.org ([209.173.204.2]:23011 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S264829AbTL0V4H (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Dec 2003 16:56:07 -0500
Date: Sat, 27 Dec 2003 15:56:06 -0600
From: Matt Mackall <mpm@selenic.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [ANNOUNCE] 2.6.0-tiny1 tree for small systems
Message-ID: <20031227215606.GO18208@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is the second release of the -tiny kernel tree. The aim of this
tree is to collect patches that reduce kernel disk and memory
footprint as well as tools for working on small systems. Target users
are things like embedded systems, small or legacy desktop folks, and
handhelds.

Latest release includes:
 - sync against 2.6.0
 - fix for CONFIG_SYSCTL compilation
 - Jeff Garzik's netdrvr patchkit, along with latest netpoll/netconsole code
 - kgdb and kgdb-over-ethernet debugging support
 - "make checkstack" to find largest stack users
 - script to estimate actual code size of inline functions (experimental)
 - some other minor new tweaks

Thanks to Holger Shuring, Bill Irwin, and Zwane Mwaikamba for sending
me various tweaks. 

The patch, currently against 2.6.0, can be found at:

 http://selenic.com/tiny/2.6.0-tiny1.patch.bz2
 http://selenic.com/tiny/2.6.0-tiny1-broken-out.tar.bz2


And while I'm at it, I'll include some demo logs:

[my tiny test config: ide + vt + ext2 + net ]
$ size vmlinux
   text    data     bss     dec     hex filename
 861316   76979   20524  958819   ea163 vmlinux

LILO boot: tiny mem=4m
Loading tiny.........
Uncompressing Linux... Ok, booting the kernel.

# cat /proc/meminfo
MemTotal:         2772 kB
MemFree:          1096 kB
Buffers:            64 kB
Cached:            896 kB
SwapCached:          0 kB
Active:            788 kB
Inactive:          392 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:         2772 kB
LowFree:          1096 kB
SwapTotal:           0 kB
SwapFree:            0 kB
Dirty:               0 kB
Writeback:           0 kB
Mapped:            616 kB
Slab:              356 kB
Committed_AS:      280 kB
PageTables:         48 kB
VmallocTotal:  1032168 kB
VmallocUsed:         0 kB
VmallocChunk:  1032168 kB
#

[rebooting with kmalloc auditing and kallsyms]
# cat /proc/kmalloc
total bytes allocated:   266848
slack bytes allocated:    37774
net bytes allocated:     145568
number of allocs:           732
number of frees:            282
number of callers:           71
lost callers:                 0
lost allocs:                  0
unknown frees:                0

   total    slack      net alloc/free  caller
     256      203      256     8/0     alloc_vfsmnt+0x73
    8192     3648     4096     2/1     atkbd_connect+0x1b
     192       48       64     3/2     seq_open+0x10
   12288        0     4096     3/2     seq_read+0x53
    8192        0        0     2/2     alloc_skb+0x3b
     960        0        0    10/10    load_elf_interp+0xa1
    1920      288        0    10/10    load_elf_binary+0x100
     320      130        0    10/10    load_elf_binary+0x1d8
     192       48       96     6/3     request_irq+0x22
    7200     1254     7200    75/0     proc_create+0x74
      64       43       64     2/0     proc_symlink+0x40
    4096      984        0     1/1     check_partition+0x1b
   69632        0    45056    17/6     dup_task_struct+0x38
     128       48      128     2/0     netlink_create+0x84
     128       20      128     1/0     ext2_fill_super+0x2f
      32       28       32     1/0     ext2_fill_super+0x385
      32       31       32     1/0     ext2_fill_super+0x3b6
     608       76      384    19/7     __request_region+0x18
      64       32       64     2/0     rand_initialize_disk+0xd
    8192     2016     8192     2/0     alloc_tty_struct+0x10
     128       56      128     2/0     init_dev+0xba
     128       56      128     2/0     init_dev+0xf3
     128        0      128     2/0     create_workqueue+0x28
    8960     1680     8960    70/0     tty_add_class_device+0x20
    2048      960     2048     4/0     alloc_tty_driver+0x10
    9280     2332     9280     4/0     tty_register_driver+0x2d
     288        0      288     9/0     mempool_create+0x16
    1280      196     1280     9/0     mempool_create+0x41
    1536      384     1536     8/0     mempool_create+0x8f
      64       28       64     1/0     kbd_connect+0x3e
     928      348        0    29/29    kmem_cache_create+0x235
   28288     1448    28288    81/0     do_tune_cpucache+0x2c
...

[counting inline function calls]
$ make 2>../inline-info
  CHK     include/linux/version.h
  SPLIT   include/linux/autoconf.h -> include/config/*
make[1]: `arch/i386/kernel/asm-offsets.s' is up to date.
  CHK     include/asm-i386/asm_offsets.h
  CC      init/main.o
...
  LD      arch/i386/boot/compressed/vmlinux
  OBJCOPY arch/i386/boot/vmlinux.bin
  BUILD   arch/i386/boot/bzImage
Root device is (3, 3)
Boot sector 512 bytes.
Setup is 2538 bytes.
System is 485 kB
Kernel: arch/i386/boot/bzImage is ready
$ scripts/count-inlines ../inline-info
2682  current_thread_info (485 in *.c)
calls:
callers: get_current(1764) <other>(276) copy_from_user(135)
copy_to_user(131) test_thread_flag(36) tcp_put_port(23)
tcp_set_state(22) verify_area(21) TLan_SetTimer(10)
tcp_enter_memory_pressure(6) set_thread_flag(6) sock_orphan(5)
inet_putpeer(5) dev_kfree_skb_any(5) clear_thread_flag(5)
inet_getid(3) sock_graft(2) igmp_mcf_get_first(2) icmp_xmit_lock(2)
csum_and_copy_to_user(2) test_and_clear_thread_flag(1)
tcp_v4_lookup(1) neigh_update_hhs(1) ip_finish_output2(1) gfp_any(1)
fn_flush_list(1) do_kdsk_ioctl(1) do_kdgkb_ioctl(1)
do_kbkeycode_ioctl(1) do_getname(1) alloc_buf(1) activate_task(1)
 
1764  get_current (1494 in *.c)
calls: current_thread_info(2682)
callers: <other>(417) capable(159) flush_tlb_page(11) flush_tlb_mm(10)
do_trap(10) on_sig_stack(9) sas_ss_flags(8) find_process_by_pid(6)
check_sticky(5) flush_tlb_range(4) walk_init_root(3) scm_send(3)
current_is_pdflush(3) current_is_kswapd(3) rwsem_down_failed_common(2)
kmem_freepages(2) get_sigframe(2) follow_dotdot(2) do_mmap2(2)
do_follow_link(2) __vfs_follow_link(2) __exit_mm(2) scm_check_creds(1)
save_i387_fsave(1) restore_i387_fsave(1) read_zero_pagealigned(1)
handle_group_stop(1) good_sigevent(1) get_close_on_exec(1)
fork_traceflag(1) ext2_init_acl(1) exec_permission_lite(1) dup_mmap(1)
do_tty_write(1) de_thread(1) copy_signal(1) copy_sighand(1) copy_fs(1)
cap_set_all(1) cap_netlink_send(1) cap_emulate_setxuid(1)
arch_get_unmapped_area(1)
 
...

[top stack users]
$ make checkstack
objdump -d vmlinux | perl scripts/checkstack.pl i386
 1492 ide_unregister
 1428 huft_build
 1320 inflate_dynamic
 1168 inflate_fixed
  552 ip_setsockopt
  460 tcp_v4_conn_request
  456 tcp_check_req
  448 tcp_timewait_state_process
  440 ip_getsockopt
  368 extract_entropy
  320 do_execve
  288 icmp_send
...

-- 
Matt Mackall : http://www.selenic.com : Linux development and consulting
