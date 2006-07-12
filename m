Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751377AbWGLOGv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751377AbWGLOGv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 10:06:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751378AbWGLOGv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 10:06:51 -0400
Received: from outbound-red.frontbridge.com ([216.148.222.49]:14755 "EHLO
	outbound2-red-R.bigfish.com") by vger.kernel.org with ESMTP
	id S1751377AbWGLOGu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 10:06:50 -0400
X-BigFish: V
X-Server-Uuid: 519AC16A-9632-469E-B354-112C592D09E8
Subject: Re: [discuss] Re: [PATCH] Allow all Opteron processors to
 change pstate at same time
From: "Joachim Deguara" <joachim.deguara@amd.com>
To: "Andi Kleen" <ak@suse.de>
cc: "Mark Langsdorf" <mark.langsdorf@amd.com>, discuss@x86-64.org,
       linux-kernel@vger.kernel.org, cpufreq@lists.linux.org.uk
In-Reply-To: <1152622554.4489.32.camel@lapdog.site>
References: <Pine.LNX.4.64.0607061519040.9066@solonow.amd.com>
 <p73fyhdpqe1.fsf@verdi.suse.de> <1152622554.4489.32.camel@lapdog.site>
Date: Wed, 12 Jul 2006 16:06:08 +0200
Message-ID: <1152713168.14450.18.camel@lapdog.site>
MIME-Version: 1.0
X-Mailer: Evolution 2.6.0
X-OriginalArrivalTime: 12 Jul 2006 14:06:33.0907 (UTC)
 FILETIME=[61C06030:01C6A5BC]
X-WSS-ID: 68ABDE6740O337345-01-01
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-07-11 at 14:55 +0200, Joachim Deguara wrote:
> Here are some initial findings. 

Here are the further findings after letting the machine toggle between
1GHz and 2.2Ghz every two seconds for roughly 24 hours.  Unfortunately
there is an oops after bringing CPU2 online and CPU3 will not come
online.  Still the differences in TSC are not bad:

after 24 hours toggling the freq
Jul 12 23:39:27 gradient kernel: CPU 1: synchronized TSC with CPU 0 (last diff 13 cycles, maxerr 471 cycles)
Jul 12 23:39:27 gradient kernel: CPU 2: synchronized TSC with CPU 0 (last diff 22 cycles, maxerr 580 cycles)
CPU3 does not appear because of oops

Again from yesterdays test
after 2 hours toggling the freq
Jul 11 21:23:35 gradient kernel: CPU 1: synchronized TSC with CPU 0 (last diff 3 cycles, maxerr 502 cycles)
Jul 11 21:23:35 gradient kernel: CPU 2: synchronized TSC with CPU 0 (last diff -91 cycles, maxerr 621 cycles)
Jul 11 21:23:35 gradient kernel: CPU 3: synchronized TSC with CPU 0 (last diff -122 cycles, maxerr 1129 cycles)

after 2 minutes of no toggling (what I see as best case)
Jul 11 21:25:24 gradient kernel: CPU 1: synchronized TSC with CPU 0 (last diff 4 cycles, maxerr 499 cycles)
Jul 11 21:25:24 gradient kernel: CPU 2: synchronized TSC with CPU 0 (last diff -93 cycles, maxerr 625 cycles)
Jul 11 21:25:24 gradient kernel: CPU 3: synchronized TSC with CPU 0 (last diff -122 cycles, maxerr 1126 cycles)

At 1GHz, 1000 cycles translates 1 microsecond, which happens to be
exactly the resolution of gettimeofday.  And we are way below this with
the last diff and the maxerr is theoretical as it is just a measure of
round trip from the sync algo.

Full log of going online with the 24 hours test is below

-joachim

Jul 12 23:39:27 gradient kernel: Booting processor 1/4 APIC 0x1
Jul 12 23:39:27 gradient kernel: Initializing CPU#1
Jul 12 23:39:27 gradient kernel: Calibrating delay using timer specific routine.. 2009.42 BogoMIPS (lpj=4018859)
Jul 12 23:39:27 gradient kernel: CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
Jul 12 23:39:27 gradient kernel: CPU: L2 Cache: 1024K (64 bytes/line)
Jul 12 23:39:27 gradient kernel: CPU 1(2) -> Node 0 -> Core 1
Jul 12 23:39:27 gradient kernel: Dual Core AMD Opteron(tm) Processor 275 stepping 02
Jul 12 23:39:27 gradient kernel: CPU 1: Syncing TSC to CPU 0.
Jul 12 23:39:27 gradient kernel: CPU 1: synchronized TSC with CPU 0 (last diff 13 cycles, maxerr 471 cycles)
Jul 12 23:39:27 gradient kernel: kobject machinecheck1: registering. parent: machinecheck, set: machinecheck
Jul 12 23:39:27 gradient kernel: kobject_uevent
Jul 12 23:39:27 gradient kernel: fill_kobj_path: path = '/devices/system/machinecheck/machinecheck1'
Jul 12 23:39:27 gradient kernel: kobject threshold1: registering. parent: threshold, set: threshold
Jul 12 23:39:27 gradient kernel: kobject_uevent
Jul 12 23:39:27 gradient kernel: fill_kobj_path: path = '/devices/system/threshold/threshold1'
Jul 12 23:39:27 gradient kernel: cpufreq-core: adding CPU 1
Jul 12 23:39:27 gradient kernel: powernow-k8:    0 : fid 0xe, vid 0x8
Jul 12 23:39:27 gradient kernel: powernow-k8:    1 : fid 0xc, vid 0xa
Jul 12 23:39:27 gradient kernel: powernow-k8:    2 : fid 0xa, vid 0xc
Jul 12 23:39:27 gradient kernel: powernow-k8:    3 : fid 0x2, vid 0x12
Jul 12 23:39:27 gradient kernel: powernow-k8:    0 : fid 0xe (2200 MHz), vid 0x8
Jul 12 23:39:27 gradient kernel: powernow-k8:    1 : fid 0xc (2000 MHz), vid 0xa
Jul 12 23:39:27 gradient kernel: powernow-k8:    2 : fid 0xa (1800 MHz), vid 0xc
Jul 12 23:39:27 gradient kernel: powernow-k8:    3 : fid 0x2 (1000 MHz), vid 0x12
Jul 12 23:39:27 gradient kernel: powernow-k8: cpu1, init lo 0x1202, hi 0x1
Jul 12 23:39:27 gradient kernel: powernow-k8: policy current frequency 1000000 kHz
Jul 12 23:39:27 gradient kernel: freq-table: table entry 0: 2200000 kHz, 2062 index
Jul 12 23:39:27 gradient kernel: freq-table: table entry 1: 2000000 kHz, 2572 index
Jul 12 23:39:27 gradient kernel: freq-table: table entry 2: 1800000 kHz, 3082 index
Jul 12 23:39:27 gradient kernel: freq-table: table entry 3: 1000000 kHz, 4610 index
Jul 12 23:39:27 gradient kernel: freq-table: setting show_table for cpu 1 to ffff81007f619800
Jul 12 23:39:27 gradient kernel: powernow-k8: cpu_init done, current fid 0x2, vid 0x12
Jul 12 23:39:27 gradient kernel: cpufreq-core: CPU already managed, adding link
Jul 12 23:39:27 gradient kernel: printk: 31 messages suppressed.
Jul 12 23:39:27 gradient kernel: freq-table: clearing show_table for cpu 1
Jul 12 23:39:27 gradient kernel: kobject_uevent
Jul 12 23:39:27 gradient kernel: fill_kobj_path: path = '/devices/system/cpu/cpu1'
Jul 12 23:39:27 gradient kernel: Booting processor 2/4 APIC 0x2
Jul 12 23:39:27 gradient kernel: Initializing CPU#2
Jul 12 23:39:27 gradient kernel: Calibrating delay using timer specific routine.. 2009.34 BogoMIPS (lpj=4018684)
Jul 12 23:39:27 gradient kernel: CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
Jul 12 23:39:27 gradient kernel: CPU: L2 Cache: 1024K (64 bytes/line)
Jul 12 23:39:27 gradient kernel: CPU 2(2) -> Node 1 -> Core 0
Jul 12 23:39:27 gradient kernel: Dual Core AMD Opteron(tm) Processor 275 stepping 02
Jul 12 23:39:27 gradient kernel: CPU 2: Syncing TSC to CPU 0.
Jul 12 23:39:27 gradient kernel: CPU 2: synchronized TSC with CPU 0 (last diff 22 cycles, maxerr 580 cycles)
Jul 12 23:39:27 gradient kernel: kobject machinecheck2: registering. parent: machinecheck, set: machinecheck
Jul 12 23:39:27 gradient kernel: kobject_uevent
Jul 12 23:39:27 gradient kernel: fill_kobj_path: path = '/devices/system/machinecheck/machinecheck2'
Jul 12 23:39:27 gradient kernel: kobject threshold2: registering. parent: threshold, set: threshold
Jul 12 23:39:27 gradient kernel: kobject_uevent
Jul 12 23:39:27 gradient kernel: fill_kobj_path: path = '/devices/system/threshold/threshold2'
Jul 12 23:39:27 gradient kernel: cpufreq-core: adding CPU 2
Jul 12 23:39:27 gradient kernel: powernow-k8:    0 : fid 0xe, vid 0x8
Jul 12 23:39:27 gradient kernel: powernow-k8:    1 : fid 0xc, vid 0xa
Jul 12 23:39:27 gradient kernel: powernow-k8:    2 : fid 0xa, vid 0xc
Jul 12 23:39:28 gradient kernel: powernow-k8:    3 : fid 0x2, vid 0x12
Jul 12 23:39:28 gradient kernel: powernow-k8:    0 : fid 0xe (2200 MHz), vid 0x8
Jul 12 23:39:28 gradient kernel: powernow-k8:    1 : fid 0xc (2000 MHz), vid 0xa
Jul 12 23:39:28 gradient kernel: powernow-k8:    2 : fid 0xa (1800 MHz), vid 0xc
Jul 12 23:39:28 gradient kernel: powernow-k8:    3 : fid 0x2 (1000 MHz), vid 0x12
Jul 12 23:39:28 gradient kernel: powernow-k8: cpu2, init lo 0x802, hi 0x1
Jul 12 23:39:28 gradient kernel: powernow-k8: policy current frequency 1000000 kHz
Jul 12 23:39:28 gradient kernel: freq-table: table entry 0: 2200000 kHz, 2062 index
Jul 12 23:39:28 gradient kernel: freq-table: table entry 1: 2000000 kHz, 2572 index
Jul 12 23:39:28 gradient kernel: freq-table: table entry 2: 1800000 kHz, 3082 index
Jul 12 23:39:28 gradient kernel: freq-table: table entry 3: 1000000 kHz, 4610 index
Jul 12 23:39:28 gradient kernel: freq-table: setting show_table for cpu 2 to ffff8101d8339480
Jul 12 23:39:28 gradient kernel: powernow-k8: cpu_init done, current fid 0x2, vid 0x8
Jul 12 23:39:28 gradient kernel: Unable to handle kernel NULL pointer dereference at 0000000000000001 RIP: 
Jul 12 23:39:28 gradient kernel: <ffffffff882fa00c>{:powernow_k8:powernowk8_cpu_init+3115}
Jul 12 23:39:28 gradient kernel: PGD 1d24f5067 PUD 1d9035067 PMD 0 
Jul 12 23:39:28 gradient kernel: Oops: 0000 [1] SMP 
Jul 12 23:39:28 gradient kernel: last sysfs file: /devices/system/cpu/cpu2/online
Jul 12 23:39:28 gradient kernel: CPU 2 
Jul 12 23:39:28 gradient kernel: Modules linked in: xt_pkttype ipt_LOG xt_limit cpufreq_ondemand cpufreq_userspace cpufreq_powersave powernow_k8 freq_table snd_pcm_oss
 snd_mixer_oss snd_seq snd_seq_device af_packet button battery ac ip6t_REJECT xt_tcpudp ipt_REJECT xt_state iptable_mangle iptable_nat ip_nat iptable_filter ip6table_m
angle ip_conntrack nfnetlink ip_tables ip6table_filter ip6_tables x_tables ipv6 loop dm_mod forcedeth snd_intel8x0 snd_ac97_codec snd_ac97_bus snd_pcm snd_timer snd so
undcore snd_page_alloc floppy reiserfs edd fan thermal processor sg sata_nv libata amd74xx sd_mod scsi_mod ide_disk ide_core
Jul 12 23:39:28 gradient kernel: Pid: 25406, comm: bash Tainted: G     U 2.6.16.20-20060612161415-smp #14
Jul 12 23:39:28 gradient kernel: RIP: 0010:[<ffffffff882fa00c>] <ffffffff882fa00c>{:powernow_k8:powernowk8_cpu_init+3115}
Jul 12 23:39:28 gradient kernel: RSP: 0018:ffff810078263c18  EFLAGS: 00010202
Jul 12 23:39:28 gradient kernel: RAX: 0000000000000001 RBX: 0000000000000800 RCX: 0000000000000001
Jul 12 23:39:28 gradient kernel: RDX: 0000000000000001 RSI: 0000000000000080 RDI: ffffffff8045c760
Jul 12 23:39:28 gradient kernel: RBP: 0000000000000000 R08: ffffffff8045c760 R09: ffff810078263928
Jul 12 23:39:28 gradient kernel: R10: 0000000000000001 R11: 0000000000000000 R12: 0000000000000000
Jul 12 23:39:28 gradient kernel: R13: 0000000000000002 R14: ffff8101d83394a0 R15: ffff81007f390400
Jul 12 23:39:28 gradient kernel: FS:  00002af6fc81fae0(0000) GS:ffff8101dadd4240(0000) knlGS:0000000000000000
Jul 12 23:39:28 gradient kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
Jul 12 23:39:28 gradient kernel: CR2: 0000000000000001 CR3: 00000001cfe35000 CR4: 00000000000006a0
Jul 12 23:39:28 gradient kernel: Process bash (pid: 25406, threadinfo ffff810078262000, task ffff81007f48f080)
Jul 12 23:39:28 gradient kernel: Stack: 0000000000000000 00000003801e9054 ffff8101d8339480 0000000000000000 
Jul 12 23:39:28 gradient kernel:        0000000000000004 00000000000000c0 0000000000000004 0000000000000000 
Jul 12 23:39:28 gradient kernel:        ffffffffffffffff ffffffffffffffff 
Jul 12 23:39:28 gradient kernel: Call Trace: <ffffffff80268b4f>{cpufreq_add_dev+414}
Jul 12 23:39:28 gradient kernel:        <ffffffff802cf074>{thread_return+0} <ffffffff801911b1>{alloc_inode+42}
Jul 12 23:39:28 gradient kernel:        <ffffffff801b83bf>{sysfs_new_dirent+52} <ffffffff801b863d>{sysfs_make_dirent+27}
Jul 12 23:39:28 gradient kernel:        <ffffffff80268f97>{cpufreq_cpu_callback+49} <ffffffff802d2805>{notifier_call_chain+28}
Jul 12 23:39:28 gradient kernel:        <ffffffff801476bd>{cpu_up+169} <ffffffff80250b94>{store_online+85}
Jul 12 23:39:28 gradient kernel:        <ffffffff801b7d75>{sysfs_write_file+185} <ffffffff8017adc0>{vfs_write+215}
Jul 12 23:39:28 gradient kernel:        <ffffffff8017b381>{sys_write+69} <ffffffff8010a7be>{system_call+126}
Jul 12 23:39:28 gradient kernel: 
Jul 12 23:39:28 gradient kernel: Code: 8b 04 28 25 00 ff 00 00 39 c3 0f 4c d8 ff c2 be 80 00 00 00 
Jul 12 23:39:28 gradient kernel: RIP <ffffffff882fa00c>{:powernow_k8:powernowk8_cpu_init+3115} RSP <ffff810078263c18>
Jul 12 23:39:28 gradient kernel: CR2: 0000000000000001





