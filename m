Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264460AbTK0JHY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Nov 2003 04:07:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264462AbTK0JHY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Nov 2003 04:07:24 -0500
Received: from outbound03.telus.net ([199.185.220.222]:12160 "EHLO
	priv-edtnes11-hme0.telusplanet.net") by vger.kernel.org with ESMTP
	id S264460AbTK0JG5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Nov 2003 04:06:57 -0500
Subject: Re: Beaver In Detox AND IEEE1394 badness message
From: Bob Gill <gillb4@telusplanet.net>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: 
Message-Id: <1069924157.2432.119.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 27 Nov 2003 02:09:17 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OK.  Hoping to shed a bit more light on the problem.
Hardware:
I have 1 250MB zip disk, and a 3 port via-chipset firewire card where I
hang 2 external hard drives and occasionally 1 camcorder.
Kernel:
Linux 2.6.0-test9-bk15 thru 2.6.0-test9-bk25  all patched (overwritten)
with svn-6227-i386 trunk
--everything works.  I didn't try hot unplug/replug, but I could run
video into kino while moving data between the firewire drives and have
od showing data from the zip disk  *all at the same time*.  (The zip
disk shows up as the first scsi device).
Up to 2.6.0-test9-bk25 with svn-6227-i386 trunk, cat /proc/scsi/scsi
shows up as:
Attached devices:
Host: scsi0 Channel: 00 Id: 06 Lun: 00
  Vendor: IOMEGA   Model: ZIP 250          Rev: H.41
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi1 Channel: 00 Id: 00 Lun: 00
  Vendor: Maxtor 4 Model: G160J8           Rev:
  Type:   Direct-Access                    ANSI SCSI revision: 06
Host: scsi1 Channel: 00 Id: 01 Lun: 00
  Vendor: Maxtor 4 Model: G160J8           Rev:
  Type:   Direct-Access                    ANSI SCSI revision: 06


Changes made in the land of SCSI broke all of this in:
2.6.0-test9-bk26, 2.6.0-test10, 2.6.0-test10-bk1, 2.6.0-test10-bk2 and 
the current detox-beaver release.  

I get an error at the end of the kernel build when I patch with
svn-6227-i386 trunk (from test9-bk26 on):

if [ -r System.map ]; then /sbin/depmod -ae -F System.map 
2.6.0-test9-bk26; fi
WARNING: /lib/modules/2.6.0-test9-bk26/kernel/drivers/ieee1394/sbp2.ko
needs unknown symbol scsi_find_device

Like others, I get only one device showing up in /proc/scsi/scsi (after
test9-bk25), regardless of whether I tried to use the subversion patch
or not.  The good news is that if instead of having the zip250 show up,
I can unplug the parallel port cables (the zip disk is connected to the
parallel port) and get the first external firewire drive to show up at
/proc/scsi/scsi instead (but just the first one).  That's why IMHO* I
think the problem is more related to SCSI than 1394.  

*keeping in mind that I have never been accused of being a systems
programmer :)
  
I load raw1394 manually, and when I do (for dv) gscanbus shows the two
external drives, and the camcorder -if it's plugged in- for all kernel
versions.

I don't mind being used as a Guinea pig (well OK, using my computer as a
Guinea pig) but you will have to contact me directly as I am not on the
list.  

a part of /var/log/messages from test11 shows:

kernel: nvidia: module license 'NVIDIA' taints kernel.
kernel: 0: nvidia: loading NVIDIA Linux x86 nvidia.o Kernel Module 
1.0-4496  Wed Jul 16 19:03:09 PDT 2003
kernel: sbp2: $Rev: 1034 $ Ben Collins <bcollins@debian.org>
kernel: scsi0 : SCSI emulation for IEEE-1394 SBP-2 Devices
kernel: ieee1394: sbp2: Logged into SBP-2 device
kernel: arch/i386/kernel/semaphore.c:84: spin_is_locked on uninitialized
spinlock f68688f8.
kernel: Unable to handle kernel paging request at virtual address
6b6b6b6b
kernel:  printing eip:
kernel: c01d761e
kernel: *pde = 00000000
kernel: Oops: 0000 [#1]
kernel: CPU:    0
kernel: EIP:    0060:[<c01d761e>]    Tainted: P
kernel: EFLAGS: 00010097
kernel: EIP is at vsnprintf+0x2e2/0x451
kernel: eax: 6b6b6b6b   ebx: 0000000a   ecx: 6b6b6b6b   edx: fffffffeNov
kernel: esi: c03baf8b   edi: 00000000   ebp: f7493d70   esp: f7493d38Nov
kernel: ds: 007b   es: 007b   ss: 0068
kernel: Process modprobe (pid: 1523, threadinfo=f7492000 task=f77fc200)
kernel: Stack: c03baf7d c03bb35f 00000054 00000000 0000000a fffffffa
00000001 00000002
kernel:        ffffffff ffffffff c03bb35f c03baf60 00000046 00000296
f7493dc0 c012573d
kernel:        c03baf60 00000400 c02e14d2 f7493dd8 00000246 f68688c0
00000004 c0311980
kernel: Call Trace:
kernel:  [<c012573d>] printk+0x17a/0x3f8
kernel:  [<c01084f7>] __down+0x1e2/0x347
kernel:  [<c011e760>] default_wake_function+0x0/0x12
kernel:  [<f89a20dd>] sbp2util_allocate_write_packet+0x68/0x74 [sbp2]Nov
kernel:  [<c0108b63>] __down_failed+0xb/0x14
kernel:  [<f89a5e46>] .text.lock.sbp2+0xf/0x27 [sbp2]
kernel:  [<f89a36c0>] sbp2_start_device+0x205/0x3e6 [sbp2]
kernel:  [<f89a347d>] sbp2_start_ud+0x106/0x144 [sbp2]
kernel:  [<f89a2f84>] sbp2_probe+0x4b/0x4f [sbp2]
kernel:  [<c020ace0>] bus_match+0x3d/0x65
kernel:  [<c020adf9>] driver_attach+0x59/0x83
kernel:  [<c020b0bd>] bus_add_driver+0x9d/0xaf
kernel:  [<c020b516>] driver_register+0x88/0x8c
kernel:  [<f88a23ff>] hpsb_register_protocol+0x17/0x28 [ieee1394]
kernel:  [<f89a5e0d>] sbp2_module_init+0xb4/0xde [sbp2]
kernel:  [<c01451f7>] sys_init_module+0x203/0x3e2
kernel:  [<c010a391>] sysenter_past_esp+0x52/0x71
kernel:
kernel: Code: 80 38 00 74 07 40 4a 83 fa ff 75 f4 29 c8 83 e7 10 89 c3
75
kernel:  <6>note: modprobe[1523] exited with preempt_count 2
kernel: Debug: sleeping function called from invalid context at
include/linux/rwsem.h:43
kernel: in_atomic():1, irqs_disabled():0
kernel: Call Trace:
kernel:  [<c0120e14>] __might_sleep+0xab/0xcb
kernel:  [<c0126192>] profile_exit_task+0x22/0x5e
kernel:  [<c01285d1>] do_exit+0x7c/0x904
kernel:  [<c010b59e>] do_divide_error+0x0/0xde
kernel:  [<c011ba39>] do_page_fault+0x202/0x56a
kernel:  [<c01f8bfb>] clear_selection+0x1b/0x60
kernel:  [<c011cfec>] recalc_task_prio+0xb2/0x1ea
kernel:  [<c011b837>] do_page_fault+0x0/0x56a
kernel:  [<c010ae0d>] error_code+0x2d/0x38
kernel:  [<c01d761e>] vsnprintf+0x2e2/0x451
kernel:  [<c012573d>] printk+0x17a/0x3f8
kernel:  [<c01084f7>] __down+0x1e2/0x347
kernel:  [<c011e760>] default_wake_function+0x0/0x12
kernel:  [<f89a20dd>] sbp2util_allocate_write_packet+0x68/0x74 [sbp2]Nov
kernel:  [<c0108b63>] __down_failed+0xb/0x14
kernel:  [<f89a5e46>] .text.lock.sbp2+0xf/0x27 [sbp2]
kernel:  [<f89a36c0>] sbp2_start_device+0x205/0x3e6 [sbp2]
kernel:  [<f89a347d>] sbp2_start_ud+0x106/0x144 [sbp2]
kernel:  [<f89a2f84>] sbp2_probe+0x4b/0x4f [sbp2]
kernel:  [<c020ace0>] bus_match+0x3d/0x65
kernel:  [<c020adf9>] driver_attach+0x59/0x83
kernel:  [<c020b0bd>] bus_add_driver+0x9d/0xaf
kernel:  [<c020b516>] driver_register+0x88/0x8c
kernel:  [<f88a23ff>] hpsb_register_protocol+0x17/0x28 [ieee1394]
kernel:  [<f89a5e0d>] sbp2_module_init+0xb4/0xde [sbp2]
kernel:  [<c01451f7>] sys_init_module+0x203/0x3e2
kernel:  [<c010a391>] sysenter_past_esp+0x52/0x71
kernel:
kernel: bad: scheduling while atomic!
kernel: Call Trace:
kernel:  [<c011e70b>] schedule+0x8b9/0x8be
kernel:  [<c015ab4d>] unmap_page_range+0x41/0x67
kernel:  [<c015ad8e>] unmap_vmas+0x21b/0x345
kernel:  [<c0160c96>] exit_mmap+0xd4/0x2bb
kernel:  [<c0121bcf>] mmput+0xb8/0x145
kernel:  [<c01287ee>] do_exit+0x299/0x904
kernel:  [<c010b59e>] do_divide_error+0x0/0xde
kernel:  [<c011ba39>] do_page_fault+0x202/0x56a
kernel:  [<c01f8bfb>] clear_selection+0x1b/0x60
kernel:  [<c011cfec>] recalc_task_prio+0xb2/0x1ea
kernel:  [<c011b837>] do_page_fault+0x0/0x56a
kernel:  [<c010ae0d>] error_code+0x2d/0x38
kernel:  [<c01d761e>] vsnprintf+0x2e2/0x451
kernel:  [<c012573d>] printk+0x17a/0x3f8
kernel:  [<c01084f7>] __down+0x1e2/0x347
kernel:  [<c011e760>] default_wake_function+0x0/0x12
kernel:  [<f89a20dd>] sbp2util_allocate_write_packet+0x68/0x74 [sbp2]Nov
kernel:  [<c0108b63>] __down_failed+0xb/0x14
kernel:  [<f89a5e46>] .text.lock.sbp2+0xf/0x27 [sbp2]
kernel:  [<f89a36c0>] sbp2_start_device+0x205/0x3e6 [sbp2]
kernel:  [<f89a347d>] sbp2_start_ud+0x106/0x144 [sbp2]
kernel:  [<f89a2f84>] sbp2_probe+0x4b/0x4f [sbp2]
kernel:  [<c020ace0>] bus_match+0x3d/0x65
kernel:  [<c020adf9>] driver_attach+0x59/0x83
kernel:  [<c020b0bd>] bus_add_driver+0x9d/0xaf
kernel:  [<c020b516>] driver_register+0x88/0x8c
kernel:  [<f88a23ff>] hpsb_register_protocol+0x17/0x28 [ieee1394]
kernel:  [<f89a5e0d>] sbp2_module_init+0xb4/0xde [sbp2]
kernel:  [<c01451f7>] sys_init_module+0x203/0x3e2
kernel:  [<c010a391>] sysenter_past_esp+0x52/0x71
kernel:
kernel: i2c-sis96x version 1.0.0
kernel: sis96x smbus 0000:00:02.1: SiS96x SMBus base address: 0x1080
kernel: sis900.c: v1.08.06 9/24/2002
kernel: eth0: ICS LAN PHY transceiver found at address 1.
kernel: eth0: Using transceiver found at address 1 as default
kernel: eth0: SiS 900 PCI Fast Ethernet at 0xe000, IRQ 11,
00:50:2c:02:96:89.
kernel: Slab corruption: start=f68688c0, expend=f6868937,
problemat=f6868900
kernel: Last user: [<f889a18f>](free_hpsb_packet+0x2c/0x33 [ieee1394])
kernel: Data:
****************************************************************6A
******************************************************A5
kernel: Next: 71 F0 2C .8F A1 89 F8 71 F0 2C .....................
kernel: slab error in check_poison_obj(): cache `hpsb_packet': object
was modified after freeing
kernel: Call Trace:
kernel:  [<c014f420>] check_poison_obj+0x106/0x18f
kernel:  [<f889a072>] alloc_hpsb_packet+0x21/0x112 [ieee1394]
kernel:  [<c01517ff>] kmem_cache_alloc+0x183/0x1d4
kernel:  [<f889a072>] alloc_hpsb_packet+0x21/0x112 [ieee1394]
kernel:  [<c01763d0>] bh_lru_install+0xc3/0xff
kernel:  [<c0176474>] __find_get_block+0x68/0xe1
kernel:  [<f889ccec>] hpsb_make_writepacket+0x4a/0x116 [ieee1394]
kernel:  [<f89a20b5>] sbp2util_allocate_write_packet+0x40/0x74 [sbp2]Nov
kernel:  [<f89a4c4e>] sbp2_link_orb_command+0x8c/0x191 [sbp2]
kernel:  [<f89a4df9>] sbp2_send_command+0xa6/0xe3 [sbp2]
kernel:  [<f88d0edd>] scsi_done+0x0/0x6a [scsi_mod]
kernel:  [<f89a5546>] sbp2scsi_queuecommand+0xed/0x2cc [sbp2]
kernel:  [<f88d0edd>] scsi_done+0x0/0x6a [scsi_mod]
kernel:  [<f88d0e67>] scsi_init_cmd_from_req+0xcf/0x145 [scsi_mod]
kernel:  [<f88d0c14>] scsi_dispatch_cmd+0x2ea/0x46e [scsi_mod]
kernel:  [<f88d0edd>] scsi_done+0x0/0x6a [scsi_mod]
kernel:  [<f88d3bee>] scsi_times_out+0x0/0x50 [scsi_mod]
kernel:  [<f88d6460>] scsi_init_cmd_errh+0x95/0xc3 [scsi_mod]
kernel:  [<f88d7f4a>] scsi_request_fn+0x2ea/0x8b4 [scsi_mod]
kernel:  [<c020f877>] blk_insert_request+0xf4/0x217
kernel:  [<c014bd3b>] __alloc_pages+0xa7/0x345
kernel:  [<f88d5fdb>] scsi_insert_special_req+0x3b/0x41 [scsi_mod]
kernel:  [<f88d639d>] scsi_wait_req+0xb5/0xe3 [scsi_mod]
kernel:  [<f88d6111>] scsi_wait_done+0x0/0x1d7 [scsi_mod]
kernel:  [<c01d77b3>] snprintf+0x26/0x2a
kernel:  [<f88d8fdb>] scsi_probe_lun+0x76/0x1fa [scsi_mod]
kernel:  [<f88d9838>] scsi_probe_and_add_lun+0xee/0x1a0 [scsi_mod]
kernel:  [<f88d9b6d>] scsi_scan_target+0x5a/0xf2 [scsi_mod]
kernel:  [<f88d9d38>] scsi_scan_host_selected+0x9e/0xdd [scsi_mod]
kernel:  [<f88db987>] scsi_add_single_device+0x50/0x5e [scsi_mod]
kernel:  [<f88dbc59>] proc_scsi_write+0x24d/0x292 [scsi_mod]
kernel:  [<c0171eab>] vfs_write+0xaf/0x119
kernel:  [<c0171fb1>] sys_write+0x3f/0x5d
kernel:  [<c010a391>] sysenter_past_esp+0x52/0x71
kernel:
kernel:   Vendor: Maxtor 4  Model: G160J8            Rev:
kernel:   Type:   Direct-Access                      ANSI SCSI revision:
06
kernel: SCSI device sda: 268435455 512-byte hdwr sectors (137439 MB)
kernel: sda: cache data unavailable
kernel: sda: assuming drive cache: write through
kernel:  sda: sda1
kernel: Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
kernel: blk: queue c1b8cb1c, I/O limit 4095Mb (mask 0xffffffff)
kernel: blk: queue c1b8cf28, I/O limit 4095Mb (mask 0xffffffff)
kernel: registering 2-0290
kernel: kjournald starting.  Commit interval 5 seconds
...

Thanks,
-- 
Bob Gill <gillb4@telusplanet.net>

