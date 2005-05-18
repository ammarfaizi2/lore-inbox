Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262391AbVERWoV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262391AbVERWoV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 May 2005 18:44:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262385AbVERWoV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 May 2005 18:44:21 -0400
Received: from hqemgate01.nvidia.com ([216.228.112.170]:36420 "EHLO
	HQEMGATE01.nvidia.com") by vger.kernel.org with ESMTP
	id S262347AbVERWn4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 May 2005 18:43:56 -0400
Date: Wed, 18 May 2005 17:43:53 -0500
From: Terence Ripperda <tripperda@nvidia.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: tripperda@nvidia.com
Subject: problems with 2.6.12 and ioremap/iounmap
Message-ID: <20050518224353.GL2596@hygelac>
Reply-To: Terence Ripperda <tripperda@nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="IJpNTDwzlM2Ie8A6"
Content-Disposition: inline
X-Accept-Language: en
X-Operating-System: Linux hrothgar 2.6.7
User-Agent: Mutt/1.5.6+20040907i
X-OriginalArrivalTime: 18 May 2005 22:44:01.0584 (UTC) FILETIME=[161CEB00:01C55BFB]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--IJpNTDwzlM2Ie8A6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

I'm looking into a customer issue where they hit a kernel BUG when
starting X with our driver (attached logfile). This only occurs with
2.6.12 kernels.

this appears to be the 'vmalloc guard page causing change_page_attr
problems' bug. at one point, iounmap subtracted the guard page before
calling change_page_attr, but I see this was reverted as part of a
recent cleanup.

in this case, we're remapping a single page of the extended pci config
space. note that in the log RAX is the the physical address
00000000e00001e3, but the stack indicates that __change_page_attr was
called with address ffff8100e0001000 and pfn 00000000000e0001.

from looking at the implementation in 2.6.12-pre4, I'm not clear how
the guard page is accounted for in iounmap. in vmalloc.c, the guard
page is subtracted from the vm_struct in remove_vm_area (which calls
unmap_vm_area). but iounmap in ioremap.c calls unmap_vm_area directly
rather than calling remove_vm_area, so the guard page is never 
subtracted and the wrong size is passed to change_page_attr.

is the intent that iounmap should call remove_vm_area rather than
unmap_vm_area (with additional changes to not unlink the vma itself)?
or that the guard page should be removed by unmap_ rather than
remove_?

when debugging this issue, I also ran into problems with iounmap using
virt_to_page on a pci IO region. this problem went away when I tried
calling change_page_attr_addr with the virtual address instead. but
perhaps iounmap should be calling ioremap_change_attr rather than
change_page_attr directly. I'll run some additional tests and send out
a patch.

Thanks,
Terence 


--IJpNTDwzlM2Ie8A6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="lho-nvidia.log"

nvidia: module license 'NVIDIA' taints kernel.
ACPI: PCI Interrupt 0000:02:00.0[A] -> Link [LNK3] -> GSI 19 (level, high) -> IRQ 185
PCI: Setting latency timer of device 0000:02:00.0 to 64
NVRM: loading NVIDIA Linux x86_64 NVIDIA Kernel Module  1.0-7174  Tue Mar 22 06:45:40 PST 2005
----------- [cut here ] --------- [please bite here ] ---------
Kernel BUG at "arch/x86_64/mm/pageattr.c":154
invalid operand: 0000 [1] PREEMPT SMP 
CPU 3 
Modules linked in: nvidia eeprom i2c_nforce2 smsc47b397 i2c_sensor i2c_isa i2c_core snd_pcm_oss snd_mixer_oss snd_emu10k1 snd_rawmidi snd_ac97_codec snd_pcm snd_page_alloc snd_util_mem snd_hwdep
Pid: 6087, comm: X Tainted: P      2.6.12-rc3
RIP: 0010:[<ffffffff80121844>] <ffffffff80121844>{__change_page_attr+724}
RSP: 0018:ffff81015c0ffad8  EFLAGS: 00010282
RAX: 00000000e00001e3 RBX: 8000000000000163 RCX: 0000000000000000
RDX: 0000000000000054 RSI: 00000000000e0001 RDI: ffff81000000f000
RBP: 8000000000000163 R08: 03fffffffffff000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: ffff8100e0001000
R13: ffff8100010002a0 R14: ffff81000000c800 R15: 0000000000000002
FS:  00002aaaab493b80(0000) GS:ffffffff8049fac0(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: 00000000008d0540 CR3: 000000015c5b4000 CR4: 00000000000006e0
Process X (pid: 6087, threadinfo ffff81015c0fe000, task ffff81009fede330)
Stack: ffff8100e0001000 00000000000e0001 0000000000000000 0000000000000001 
       ffffffff7fffffff ffffffff80121a8c 0000000000000000 0000000000000163 
       8000000000000163 ffff810002c66c80 
Call Trace:<ffffffff80121a8c>{change_page_attr_addr+140} <ffffffff8012149b>{iounmap+459}
       <ffffffff882b8b0c>{:nvidia:os_unmap_kernel_space+9}
       <ffffffff880abc02>{:nvidia:_nv001628rm+42} <ffffffff880a8fe2>{:nvidia:_nv002102rm+208}
       <ffffffff880a8323>{:nvidia:_nv002113rm+255} <ffffffff880a84f8>{:nvidia:_nv002071rm+100}
       <ffffffff881c6831>{:nvidia:_nv004369rm+371} <ffffffff880a85e0>{:nvidia:_nv002114rm+64}
       <ffffffff880aeb69>{:nvidia:_nv003530rm+141} <ffffffff880aeaad>{:nvidia:_nv003486rm+275}
       <ffffffff88233a1a>{:nvidia:_nv003113rm+126} <ffffffff881c8278>{:nvidia:_nv004360rm+100}
       <ffffffff881c8064>{:nvidia:_nv004193rm+142} <ffffffff880ae8ba>{:nvidia:_nv001209rm+118}
       <ffffffff880af1b1>{:nvidia:_nv001214rm+471} <ffffffff880b24f1>{:nvidia:rm_init_adapter+107}
       <ffffffff882b2f90>{:nvidia:nv_kern_open+826} <ffffffff80181c49>{chrdev_open+457}
       <ffffffff80177e5b>{dentry_open+315} <ffffffff80177fde>{filp_open+62}
       <ffffffff801780cb>{get_unused_fd+219} <ffffffff8017821c>{sys_open+76}
       <ffffffff8010e916>{system_call+126} 

Code: 0f 0b 7c ab 36 80 ff ff ff ff 9a 00 41 8b 45 00 f6 c4 08 74 
RIP <ffffffff80121844>{__change_page_attr+724} RSP <ffff81015c0ffad8>
 <6>note: X[6087] exited with preempt_count 1
scheduling while atomic: X/0x00000001/6087

Call Trace:<ffffffff8034dd1a>{schedule+122} <ffffffff801456f3>{flush_cpu_workqueue+467}
       <ffffffff8014a1c0>{autoremove_wake_function+0} <ffffffff8034dae8>{__down+152}
       <ffffffff8012ffa0>{default_wake_function+0} <ffffffff8034f5d9>{__down_failed+53}
       <ffffffff801a8700>{proc_destroy_inode+0} <ffffffff882b8cb1>{:nvidia:.text.lock.os_interface+5}
       <ffffffff880abea6>{:nvidia:_nv001740rm+12} <ffffffff880b2d39>{:nvidia:rm_free_unused_clients+105}
       <ffffffff882b30d8>{:nvidia:nv_kern_ctl_close+146} <ffffffff882b320d>{:nvidia:nv_kern_close+252}
       <ffffffff80179992>{__fput+98} <ffffffff801782fe>{filp_close+126}
       <ffffffff801360b3>{put_files_struct+115} <ffffffff80136a13>{do_exit+403}
       <ffffffff80245b87>{do_unblank_screen+119} <ffffffff801101e5>{die+69}
       <ffffffff80110631>{do_invalid_op+145} <ffffffff80121844>{__change_page_attr+724}
       <ffffffff8011a8a0>{do_flush_tlb_all+0} <ffffffff8010f329>{error_exit+0}
       <ffffffff80121844>{__change_page_attr+724} <ffffffff80121899>{__change_page_attr+809}
       <ffffffff80121a8c>{change_page_attr_addr+140} <ffffffff8012149b>{iounmap+459}
       <ffffffff882b8b0c>{:nvidia:os_unmap_kernel_space+9}
       <ffffffff880abc02>{:nvidia:_nv001628rm+42} <ffffffff880a8fe2>{:nvidia:_nv002102rm+208}
       <ffffffff880a8323>{:nvidia:_nv002113rm+255} <ffffffff880a84f8>{:nvidia:_nv002071rm+100}
       <ffffffff881c6831>{:nvidia:_nv004369rm+371} <ffffffff880a85e0>{:nvidia:_nv002114rm+64}
       <ffffffff880aeb69>{:nvidia:_nv003530rm+141} <ffffffff880aeaad>{:nvidia:_nv003486rm+275}
       <ffffffff88233a1a>{:nvidia:_nv003113rm+126} <ffffffff881c8278>{:nvidia:_nv004360rm+100}
       <ffffffff881c8064>{:nvidia:_nv004193rm+142} <ffffffff880ae8ba>{:nvidia:_nv001209rm+118}
       <ffffffff880af1b1>{:nvidia:_nv001214rm+471} <ffffffff880b24f1>{:nvidia:rm_init_adapter+107}
       <ffffffff882b2f90>{:nvidia:nv_kern_open+826} <ffffffff80181c49>{chrdev_open+457}
       <ffffffff80177e5b>{dentry_open+315} <ffffffff80177fde>{filp_open+62}
       <ffffffff801780cb>{get_unused_fd+219} <ffffffff8017821c>{sys_open+76}
       <ffffffff8010e916>{system_call+126} 


--IJpNTDwzlM2Ie8A6--
