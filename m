Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261951AbVAYObh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261951AbVAYObh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 09:31:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261957AbVAYObh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 09:31:37 -0500
Received: from mailgate.pit.comms.marconi.com ([169.144.68.6]:45039 "EHLO
	mailgate.pit.comms.marconi.com") by vger.kernel.org with ESMTP
	id S261951AbVAYObF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 09:31:05 -0500
Message-ID: <313680C9A886D511A06000204840E1CF0A64758D@whq-msgusr-02.pit.comms.marconi.com>
From: "Povolotsky, Alexander" <Alexander.Povolotsky@marconi.com>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: 8xx 2.6.10-rc3 console_init()->con_init()->__alloc_bootmem() caus
	es "Oops: kernel access of bad area"
Date: Tue, 25 Jan 2005 09:30:49 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2657.72)
Content-Type: text/plain;
	charset="ISO-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I booting kernel on 8xx 2.6.10-rc3
while trying to debug non-working console,
I moved  console_init() call way down in __init start_kernel()
and put indefinite while loop right after it -
is it legtimate thing to do ?

Then I got soft reboot and was able to examine the content of the log buffer
in the bootloader.
I see that in a trace (function call sequence):

console_init()->con_init()->__alloc_bootmem() 

I am getting "Oops: kernel access of bad area"

I am looking for advise,
Thanks,
Alex
******************************************************  
         ...........
        lock_kernel();
        page_address_init();
        printk(linux_banner);
        setup_arch(&command_line);
        setup_per_cpu_areas();

        /*
         * Mark the boot cpu "online" so that it can call console drivers in
         * printk() and can access its per-cpu storage.
         */
        smp_prepare_boot_cpu();

        /*
         * Set up the scheduler prior starting any interrupts (such as the
         * timer interrupt). Full topology setup happens at smp_init()
         * time - but meanwhile we still have a functioning scheduler.
         */
        sched_init();
        build_all_zonelists();
        page_alloc_init();
        printk("Kernel command line: %s\n", saved_command_line);
        parse_early_param();
        parse_args("Booting kernel", command_line, __start___param,
                   __stop___param - __start___param,
                   &unknown_bootoption);
        sort_main_extable();
        trap_init();
        rcu_init();
        init_IRQ();
        pidhash_init();
        init_timers();
        softirq_init();
        time_init();
        /*
         * HACK ALERT! This is early. We're ena bling the console before
         * we've done PCI setups etc, and console_init() must be aware of
         * this. But we do want output early, in case something goes wrong.
         */
/*      console_init();   */
<<========================================================
        if (panic_later)
                panic(panic_later, panic_param);
        profile_init();
        local_irq_enable();
#ifdef CONFIG_BLK_DEV_INITRDa
        if (initrd_start && !initrd_below_start_ok &&
                        initrd_start < min_low_pfn << PAGE_SHIFT) {
                printk(KERN_CRIT "initrd overwritten (0x%08lx < 0x%08lx) - "
                    "disabling it.\n",initrd_start,min_low_pfn <<
PAGE_SHIFT);
                initrd_start = 0;
        }
#endif
        vfs_caches_init_early();
        mem_init();
        kmem_cache_init();
        console_init();
<<========================================================
        while (1);
<<======================================================== 
        numa_policy_init();
        if (late_time_init)
                late_time_init();
        calibrate_delay();
        pidmap_init();
        pgtable_cache_init();
        prio_tree_init();
        anon_vma_init();
#ifdef CONFIG_X86
        ......                                                             

*******************                ******************

grep log_buf System.map
c0197a28 d log_buf
c0197a2c d log_buf_len
c01c6464 t log_buf_len_setup
c01d03a0 t __setup_str_log_buf_len_setup
c01d08f0 t __setup_log_buf_len_setup
c01d4a9c b __log_buf
*******************************
R  0c01d4a9c b __log_buf                                       <4>Linux
version
1d4aac  | 20 32 2e 36 2e 31 30 2d 72 63 33 20 28 61 70 6f  |   2.6.10-rc3
(apo
1d4abc  | 76 6f 6c 6f 74 40 6c 6f 63 61 6c 68 6f 73 74 2e  |
volot@localhost.
1d4acc  | 6c 6f 63 61 6c 64 6f 6d 61 69 6e 29 20 28 67 63  |  localdomain)
(gc
1d4adc  | 63 20 76 65 72 73 69 6f 6e 20 33 2e 34 2e 31 29  |  c version
3.4.1)
1d4aec  | 20 23 38 36 20 4d 6f 6e 20 4a 61 6e 20 32 34 20  |   #86 Mon Jan
24
1d4afc  | 31 39 3a 35 38 3a 33 31 20 45 53 54 20 32 30 30  |  19:58:31 EST
200
1d4b0c  | 35 0a 3c 37 3e 4f 6e 20 6e 6f 64 65 20 30 20 74  |  5.<7>On node 0
t
1d4b1c  | 6f 74 61 6c 70 61 67 65 73 3a 20 38 31 39 32 0a  |  otalpages:
8192.
1d4b2c  | 3c 37 3e 20 20 44 4d 41 20 7a 6f 6e 65 3a 20 38  |  <7>  DMA zone:
81
1d4b2d - 1d4b3c - same lines as above
1d4b3d  | 39 32 20 70 61 67 65 73 2c 20 4c 49 46 4f 20 62  |  92 pages, LIFO
b
1d4b4d  | 61 74 63 68 3a 32 0a 3c 37 3e 20 20 4e 6f 72 6d  |  atch:2.<7>
Norm
1d4b5d  | 61 6c 20 7a 6f 6e 65 3a 20 30 20 70 61 67 65 73  |  al zone: 0
pages
1d4b6d  | 2c 20 4c 49 46 4f 20 62 61 74 63 68 3a 31 0a 3c  |  , LIFO
batch:1.<
1d4b7d  | 37 3e 20 20 48 69 67 68 4d 65 6d 20 7a 6f 6e 65  |  7>  HighMem
zone
1d4b8d  | 3a 20 30 20 70 61 67 65 73 2c 20 4c 49 46 4f 20  |  : 0 pages,
LIFO
1d4b3d  | 62 61 74 63 68 3a 31 0a 3c 34 3e 42 75 69 6c 74  |
batch:1.<4>Built 
1d4b3e - 1d4bbb  SAME LINES AS ABOV

                                                              1
zonelists.<4>
1d4bbd  | 4b 65 72 6e 65 6c 20 63 6f 6d 6d 61 6e 64 20 6c  |  Kernel command
li
1d4bce  | 6e 65 3a 20 63 6f 6e 73 6f 6c 65 3d 74 74 79 43  |  ne:
console=ttyC
1d4bde  | 50 4d 30 2c 31 31 35 32 30 30 20 70 61 6e 69 63  |  PM0,115200
panic
1d4bee  | 3d 33 20 72 6f 6f 74 3d 2f 64 65 76 2f 72 61 6d  |  =3
root=/dev/ram
1d4bfe  | 0a 3c 34 3e 50 49 44 20 68 61 73 68 20 74 61 62  |  .<4>PID hash
tab
1d4c0e  | 6c 65 20 65 6e 74 72 69 65 73 3a 20 32 35 36 20  |  le entries:
256
1d4c1e  | 28 6f 72 64 65 72 3a 20 38 2c 20 34 30 39 36 20  |  (order: 8,
4096
1d4c2e  | 62 79 74 65 73 29 0a 3c 34 3e 44 65 63 72 65 6d  |
bytes).<4>Decrem
1d4c3e  | 65 6e 74 65 72 20 46 72 65 71 75 65 6e 63 79 20  |  enter
Frequency
1d4c4e  | 3d 20 31 38 37 35 30 30 30 30 30 2f 36 30 0a 3c  |  =
187500000/60.<5
1d4c5f  | 3e 6d 38 78 78 5f 77 64 74 3a 20 77 64 74 20 64  |  >m8xx_wdt: wdt
d
1d4c6f  | 69 73 61 62 6c 65 64 20 28 53 59 50 43 52 3a 20  |  isabled
(SYPCR:
1d4c7f  | 30 78 34 43 34 42 46 46 38 31 29 0a 3c 34 3e 44  |
0x4C4BFF81).<4>D
1d4c8f  | 65 6e 74 72 79 20 63 61 63 68 65 20 68 61 73 68  |  entry cache
hash
1d4c9f  | 20 74 61 62 6c 65 20 65 6e 74 72 69 65 73 3a 20  |   table
entries:
1d4caf  | 38 31 39 32 20 28 6f 72 64 65 72 3a 20 33 2c 20  |  8192 (order:
3,
1d4cbf  | 33 32 37 36 38 20 62 79 74 65 73 29 0a 3c 34 3e  |  32768
bytes).<4>
1d4ccf  | 49 6e 6f 64 65 2d 63 61 63 68 65 20 68 61 73 68  |  Inode-cache
hash
1d4cdf  | 20 74 61 62 6c 65 20 65 6e 74 72 69 65 73 3a 20  |   table
entries:  4
1d4cf0  | 30 39 36 20 28 6f 72 64 65 72 3a 20 32 2c 20 31  |  096 (order: 2,
1
1d4d00  | 36 33 38 34 20 62 79 74 65 73 29 0a 3c 34 3e 4d  |  6384
bytes).<4>M
1d4d10  | 65 6d 6f 72 79 3a 20 33 30 34 36 34 6b 20 61 76  |  emory: 30464k
av
1d4d20  | 61 69 6c 61 62 6c 65 20 28 31 34 34 34 6b 20 6b  |  ailable (1444k
k
1d4d30  | 65 72 6e 65 6c 20 63 6f 64 65 2c 20 34 30 38 6b  |  ernel code,
408k
1d4d40  | 20 64 61 74 61 2c 20 38 30 6b 20 69 6e 69 74 2c  |   data, 80k
init,
1d4d50  | 20 30 6b 20 68 69 67 68 6d 65 6d 29 0a 3c 34 3e  |   0k
highmem).<4>
1d4d60  | 4f 6f 70 73 3a 20 6b 65 72 6e 65 6c 20 61 63 63  |  Oops: kernel
acc  <<======================
1d4d70  | 65 73 73 20 6f 66 20 62 61 64 20 61 72 65 61 2c  |  ess of bad
area,
1d4d81  | 73 69 67 3a 20 31 31 20 5b 23 31 5d 0a 3c 34 3e  |  sig: 11
[#1].<4>
1d4d91  | 4e 49 50 3a 20 43 30 31 43 37 36 41 43 20 4c 52  |  NIP: C01C76AC
LR
1d4da1  | 3a 20 43 30 31 43 37 43 34 43 20 53 50 3a 20 43  |  : C01C7C4C SP:
C
1d4db1  | 30 31 42 44 46 34 30 20 52 45 47 53 3a 20 63 30  |  01BDF40 REGS:
c0
1d4dc1  | 31 62 64 65 39 30 20 54 52 41 50 3a 20 30 33 30  |  1bde90 TRAP:
030
1d4dd1  | 30 20 20 20 20 4e 6f 74 20 74 61 69 6e 74 65 64  |  0    Not
tainted
1d4de1  | 0a 3c 34 3e 4d 53 52 3a 20 30 30 30 30 39 30 33  |  .<4>MSR:
0000903
1d4df1  | 32 20 45 45 3a 20 31 20 50 52 3a 20 30 20 46 50  |  2 EE: 1 PR: 0
FP
1d4e01  | 3a 20 30 20 4d 45 3a 20 31 20 49 52 2f 44 52 3a  |  : 0 ME: 1
IR/DR:
1d4e12  | 31 31 0a 3c 34 3e 44 41 52 3a 20 30 30 30 30 30  |  11.<4>DAR:
00000
1d4e22  | 30 30 30 2c 20 44 53 49 53 52 3a 20 30 30 30 30  |  000, DSISR:
0000
1d4e32  | 30 30 30 41 0a 3c 34 3e 54 41 53 4b 20 3d 20 63  |  000A.<4>TASK =
c
1d4e42  | 30 31 39 36 39 32 30 5b 30 5d 20 27 73 77 61 70  |  0196920[0]
'swap
1d4e52  | 70 65 72 27 20 54 48 52 45 41 44 3a 20 63 30 31  |  per' THREAD:
c01
1d4e62  | 62 63 30 30 30 4c 61 73 74 20 73 79 73 63 61 6c  |  bc000Last
syscal
1d4e72  | 6c 3a 20 30 20 0a 3c 36 3e 47 50 52 30 30 3a 20  |  l: 0
.<6>GPR00:
1d4e82  | 30 30 30 30 30 30 30 30 20 43 30 31 42 44 46 34  |  00000000
C01BDF4
1d4e92  | 30 20 43 30 31 39 36 39 32 30 20 30 30 30 30 32  |  0 C0196920
00002
1d4ea3  | 30 30 20 30 30 30 30 30 30 30 30 20 30 30 30 30  |  00 00000000
0000
1d4eb3  | 30 30 30 30 20 30 30 30 30 30 30 30 30 20 30 30  |  0000 00000000
00
1d4ec3  | 30 30 30 30 30 30 20 0a 3c 36 3e 47 50 52 30 38  |  000000
.<6>GPR08
1d4ed3  | 3a 20 30 30 30 30 30 30 30 30 20 30 30 30 30 30  |  : 00000000
00000
1d4ee3  | 30 30 30 20 30 30 30 30 30 30 30 30 20 30 30 30  |  000 00000000
000
1d4ef3  | 30 32 30 30 30 20 30 30 30 30 30 30 30 30 20 30  |  02000 00000000
0
1d4f03  | 30 30 31 32 41 35 43 20 30 38 30 30 30 30 30 31  |  0012A5C
08000001
1d4f13  | 20 30 30 30 30 30 30 32 30 20 0a 3c 36 3e 47 50  |   00000020
.<6>GP
1d4f23  | 52 31 36 3a 20 30 34 30 31 33 41 44 30 20 30 34  |  R16: 04013AD0
040
1d4f34  | 31 32 32 41 30 20 32 30 30 30 30 30 30 30 20 32  |  122A0 20000000
2
1d4f44  | 30 30 30 30 38 30 30 20 32 30 30 30 30 38 30 38  |  0000800
20000808
1d4f54  | 20 30 30 30 32 30 30 30 30 20 32 30 30 30 30 30  |   00020000
200000
1d4f64  | 30 34 20 30 30 30 30 36 30 30 30 20 0a 3c 36 3e  |  04 00006000
.<6>
1d4f74  | 47 50 52 32 34 3a 20 46 46 46 46 46 46 46 46 20  |  GPR24:
FFFFFFFF
1d4f84  | 30 30 30 30 30 31 33 34 20 30 30 30 30 30 30 30  |  00000134
0000000
1d4f94  | 46 20 30 30 30 30 30 30 30 31 20 46 46 46 46 46  |  F 00000001
FFFFF
1d4fa4  | 46 46 46 20 30 30 30 30 30 30 31 30 20 30 30 30  |  FFF 00000010
000
1d4fb4  | 30 30 30 30 31 20 43 30 31 44 42 35 38 34 20 0a  |  00001 C01DB584
.<
1d4fc5  | 34 3e 4e 49 50 20 5b 63 30 31 63 37 36 61 63 5d  |  4>NIP
[c01c76ac]
1d4fd5  | 20 5f 5f 61 6c 6c 6f 63 5f 62 6f 6f 74 6d 65 6d  |
__alloc_bootmem
1d4fe5  | 5f 63 6f 72 65 2b 30 78 31 30 38 2f 30 78 33 61  |
_core+0x108/0x3a
1d4ff5  | 30 0a 3c 34 3e 4c 52 20 5b 63 30 31 63 37 63 34  |  0.<4>LR
[c01c7c4
1d5005  | 63 5d 20 5f 5f 61 6c 6c 6f 63 5f 62 6f 6f 74 6d  |  c]
__alloc_bootm
1d5015  | 65 6d 2b 30 78 34 30 2f 30 78 38 34 0a 3c 34 3e  |
em+0x40/0x84.<4>
1d5025  | 43 61 6c 6c 20 74 72 61 63 65 3a 0a 3c 34 3e 20  |  Call
trace:.<4>
1d5035  | 5b 63 30 31 63 37 63 34 63 5d 20 5f 5f 61 6c 6c  |  [c01c7c4c]
__all
1d5045  | 6f 63 5f 62 6f 6f 74 6d 65 6d 2b 30 78 34 30 2f  |
oc_bootmem+0x40/0
1d5056  | 78 38 34 0a 3c 34 3e 20 5b 63 30 31 63 62 38 33  |  x84.<4>
[c01cb83
1d5066  | 34 5d 20 63 6f 6e 5f 69 6e 69 74 2b 30 78 64 30  |  4]
con_init+0xd0
1d5076  | 2f 30 78 32 61 34 0a 3c 34 3e 20 5b 63 30 31 63  |  /0x2a4.<4>
[c01c
1d5086  | 61 64 64 38 5d 20 63 6f 6e 73 6f 6c 65 5f 69 6e  |  add8]
console_in
1d5096  | 69 74 2b 30 78 34 63 2f 30 78 36 38 0a 3c 34 3e  |
it+0x4c/0x68.<4>
1d50a6  | 20 5b 63 30 31 62 65 37 32 63 5d 20 73 74 61 72  |   [c01be72c]
star
1d50b6  | 74 5f 6b 65 72 6e 65 6c 2b 30 78 64 30 2f 30 78  |
t_kernel+0xd0/0x
1d50c6  | 65 30 0a 3c 34 3e 20 5b 63 30 30 30 32 30 35 30  |  e0.<4>
[c0002050
1d50d6  | 5d 20 73 74 61 72 74 5f 68 65 72 65 2b 30 78 34  |  ]
start_here+0x4c
1d50e7  | 2f 30 78 62 30 0a 3c 30 3e 4b 65 72 6e 65 6c 20  |
/0xb0.<0>Kernel  <<======================
1d50f7  | 70 61 6e 69 63 20 2d 20 6e 6f 74 20 73 79 6e 63  |  panic - not
sync
1d5107  | 69 6e 67 3a 20 41 74 74 65 6d 70 74 65 64 20 74  |  ing: Attempted
t
1d5117  | 6f 20 6b 69 6c 6c 20 74 68 65 20 69 64 6c 65 20  |  o kill the
idle
1d5127  | 74 61 73 6b 21 0a 3c 34 3e 20 3c 30 3e 52 65 62  |  task!.<4>
<0>Reb
1d5137  | 6f 6f 74 69 6e 67 20 69 6e 20 33 20 73 65 63 6f  |  ooting in 3
seco
1d5147  | 6e 64 73 2e 2e 00 00 00 00 00 00 00 00 00 00 00  |
nds.............
1d5157  | 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  |
................
1d5167  | 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  |
................
