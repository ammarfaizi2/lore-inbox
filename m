Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030353AbVKWISy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030353AbVKWISy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 03:18:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030358AbVKWISy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 03:18:54 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:64987 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1030353AbVKWISx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 03:18:53 -0500
Date: Wed, 23 Nov 2005 09:18:45 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Maneesh Soni <maneesh@in.ibm.com>
Cc: Greg KH <greg@kroah.com>, Steven Rostedt <rostedt@goodmis.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: What protection does sysfs_readdir have with SMP/Preemption?
Message-ID: <20051123081845.GA32021@elte.hu>
References: <1132695202.13395.15.camel@localhost.localdomain> <20051122213947.GB8575@kroah.com> <20051123045049.GA22714@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051123045049.GA22714@in.ibm.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=disabled SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Maneesh Soni <maneesh@in.ibm.com> wrote:

> But the bad pointer reference seen in sysfs_readdir() has to be 
> debugged. Assumption here is that if there is a dentry attached to 
> s_dirent, there has to be a inode associated becuase negative dentries 
> are not created in sysfs. Is it possible to get some more information 
> about the recreation scenario. Could you enable DEBUG printks for 
> lib/kobject.c and drivers/base/class.c to see the events happening.

on a related note - i've been carrying the patch below in -rt for 2 
months (i.e. Steven's kernel has it too), as a workaround against the 
crash described below.

so it appears that the -rt kernel is triggering some genuine sysfs race.  
[note that it only happens on an SMP kernel, booting an UP kernel or 
with maxcpus=1 makes the bug go away.] I have done full kobject 
debugging but no conclusive results. Also, that particular crash happens 
earliest with PAGEALLOC enabled. [i have packed up the email discussion 
related to that crash, and i'm sending it to Maneesh separately.  
Maneesh, any ideas or suggestions?]

note that Steven has a dual-core Athlon64 X2 system. Steven, do you get 
the crash even with maxcpus=1?

	Ingo

-----
i'm occasionally getting the crash below on a PREEMPT_RT kernel. Might 
be a PREEMPT_RT bug, or might be some sysfs race only visible under 
PREEMPT_RT. Any ideas? The crash is at:

(gdb) list *0xc01a2095
0xc01a2095 is in sysfs_hash_and_remove (fs/sysfs/inode.c:229).
224     }
225
226     void sysfs_hash_and_remove(struct dentry * dir, const char * name)
227     {
228             struct sysfs_dirent * sd;
229             struct sysfs_dirent * parent_sd = dir->d_fsdata;
230
231             if (dir->d_inode == NULL)
232                     /* no inode means this hasn't been made visible yet */
233                     return;
(gdb)

[...]
Calling initcall 0xc05ba6e0: spi_transport_init+0x0/0x30()
Calling initcall 0xc05ba710: ahc_linux_init+0x0/0xf0()
ACPI: PCI Interrupt 0000:03:04.0[A] -> GSI 18 (level, low) -> IRQ 20
scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 7.0
        <Adaptec aic7899 Ultra160 SCSI adapter>
        aic7899: Ultra160 Wide Channel A, SCSI Id=7, 32/253 SCBs

  Vendor: SEAGATE   Model: ST336706LC        Rev: 010A
  Type:   Direct-Access                      ANSI SCSI revision: 03
scsi0:A:0:0: Tagged Queuing enabled.  Depth 32
 target0:0:0: Beginning Domain Validation
 target0:0:0: wide asynchronous.
 target0:0:0: FAST-80 WIDE SCSI 160.0 MB/s DT (12.5 ns, offset 63)
 target0:0:0: Ending Domain Validation
  Vendor: SEAGATE   Model: ST336706LC        Rev: 010A
  Type:   Direct-Access                      ANSI SCSI revision: 03
scsi0:A:1:0: Tagged Queuing enabled.  Depth 32
 target0:0:1: Beginning Domain Validation
 target0:0:1: wide asynchronous.
 target0:0:1: FAST-80 WIDE SCSI 160.0 MB/s DT (12.5 ns, offset 63)
 target0:0:1: Ending Domain Validation
BUG: Unable to handle kernel paging request at virtual address f6c47fc0
 printing eip:
c01a2095
*pde = 006cc067
*pte = 36c47000
Oops: 0000 [#1]
PREEMPT SMP DEBUG_PAGEALLOC
Modules linked in:
CPU:    1
EIP:    0060:[<c01a2095>]    Not tainted VLI
EFLAGS: 00010282   (2.6.14-rc2-rt2) 
EIP is at sysfs_hash_and_remove+0x15/0x110
eax: f6c47f2c   ebx: f6c42f64   ecx: c013edb4   edx: f6c3e5b8
esi: f6c42f5c   edi: c04fd880   ebp: c277ec88   esp: c277ec70
ds: 007b   es: 007b   ss: 0068   preempt: 00000001
Process swapper (pid: 1, threadinfo=c277e000 task=c277d900 stack_left=3132 worst_left=-1)
Stack: f6c4a3b8 f6c3e5b8 f6c47f2c f6c42f64 f6c42f5c c04fd880 c277ec90 c01a3ddb 
       c277ecb0 c02a8051 c04fd888 f6c3e5b8 c04fd7a0 f6c42f5c f7ad6c68 c04fd7a0 
       c277ecbc c02a9d52 00000000 c277ecd4 c02a9f88 f6c42f5c f7ad6c68 f79ac80c 
Call Trace:
 [<c010405a>] show_stack+0x7a/0x90 (32)
 [<c010421e>] show_registers+0x18e/0x1f0 (56)
 [<c0104420>] die+0x100/0x180 (68)
 [<c0442ea8>] do_page_fault+0x368/0x556 (92)
 [<c0103d0b>] error_code+0x4f/0x54 (84)
 [<c01a3ddb>] sysfs_remove_link+0xb/0x10 (8)
 [<c02a8051>] class_device_del+0xf1/0x100 (32)
 [<c02a9d52>] attribute_container_class_device_del+0x12/0x20 (12)
 [<c02a9f88>] transport_remove_classdev+0x38/0x70 (24)
 [<c02a9bfd>] attribute_container_device_trigger+0x8d/0xc0 (40)
 [<c02a9fcd>] transport_remove_device+0xd/0x10 (8)
 [<c032f01b>] scsi_target_reap+0x9b/0xb0 (20)
 [<c032feb4>] __scsi_scan_target+0x94/0x130 (44)
 [<c0330068>] scsi_scan_channel+0x78/0x90 (32)
 [<c0330109>] scsi_scan_host_selected+0x89/0xf0 (32)
 [<c0330192>] scsi_scan_host+0x22/0x30 (16)
 [<c0349a85>] ahc_linux_register_host+0x1b5/0x1c0 (132)
 [<c034d53d>] ahc_linux_pci_dev_probe+0xed/0x140 (132)
 [<c022a02d>] pci_call_probe+0xd/0x10 (12)
 [<c022a081>] __pci_device_probe+0x51/0x60 (20)
 [<c022a0b9>] pci_device_probe+0x29/0x60 (16)
 [<c02a6d76>] driver_probe_device+0x36/0xb0 (36)
 [<c02a6ebd>] __driver_attach+0x4d/0x70 (20)
 [<c02a6419>] bus_for_each_dev+0x49/0x70 (40)
 [<c02a6ef9>] driver_attach+0x19/0x20 (12)
 [<c02a68e1>] bus_add_driver+0x81/0xd0 (36)
 [<c02a72a1>] driver_register+0x51/0x60 (20)
 [<c022a34b>] pci_register_driver+0x8b/0xa0 (16)
 [<c034d59d>] ahc_linux_pci_init+0xd/0x20 (8)
 [<c05ba799>] ahc_linux_init+0x89/0xf0 (24)
 [<c059ba62>] do_initcalls+0x32/0xe0 (36)
 [<c059bb35>] do_basic_setup+0x25/0x30 (8)
 [<c01003de>] init+0xae/0x2d0 (24)
 [<c0101359>] kernel_thread_helper+0x5/0xc (1032327196)
---------------------------
| preempt count: 00000001 ]
| 1-level deep critical section nesting:
----------------------------------------
.. [<c013fc41>] .... add_preempt_count+0x11/0x20
.....[<c01169a0>] ..   ( <= try_to_wake_up+0x50/0x440)

------------------------------
| showing all locks held by: |  (swapper/1 [c277d900, 116]):
------------------------------

#001:             [c067618c] {(struct semaphore *)(&hwif->gendev_rel_sem)}
... acquired at:               init_hwif_data+0x8d/0x180

#002:             [c0676d0c] {(struct semaphore *)(&hwif->gendev_rel_sem)}
... acquired at:               init_hwif_data+0x8d/0x180

#003:             [c067788c] {(struct semaphore *)(&hwif->gendev_rel_sem)}
... acquired at:               init_hwif_data+0x8d/0x180

#004:             [c067840c] {(struct semaphore *)(&hwif->gendev_rel_sem)}
... acquired at:               init_hwif_data+0x8d/0x180

#005:             [c0678f8c] {(struct semaphore *)(&hwif->gendev_rel_sem)}
... acquired at:               init_hwif_data+0x8d/0x180

#006:             [c0679b0c] {(struct semaphore *)(&hwif->gendev_rel_sem)}
... acquired at:               init_hwif_data+0x8d/0x180

#007:             [c067a68c] {(struct semaphore *)(&hwif->gendev_rel_sem)}
... acquired at:               init_hwif_data+0x8d/0x180

#008:             [c067b20c] {(struct semaphore *)(&hwif->gendev_rel_sem)}
... acquired at:               init_hwif_data+0x8d/0x180

#009:             [c067bd8c] {(struct semaphore *)(&hwif->gendev_rel_sem)}
... acquired at:               init_hwif_data+0x8d/0x180

#010:             [c067c90c] {(struct semaphore *)(&hwif->gendev_rel_sem)}
... acquired at:               init_hwif_data+0x8d/0x180

#011:             [f79a7a00] {(struct semaphore *)(&dev->sem)}
... acquired at:               __driver_attach+0x22/0x70

#012:             [f7aee8ac] {(struct semaphore *)(&shost->scan_mutex)}
... acquired at:               scsi_scan_host_selected+0x56/0xf0

#013:             [c04dc604] {kernel_sem.lock}
... acquired at:               __reacquire_kernel_lock+0x33/0x70

#014:             [c04eed24] {attribute_container_mutex.lock}
... acquired at:               attribute_container_device_trigger+0x18/0xc0

Code: 8b 7c 24 08 89 ec 5d c3 8d b4 26 00 00 00 00 8d bc 27 00 00 00 00 55 89 e5 83 ec 18 89 5d f4 89 75 f8 89 7d fc 89 45 f0 89 55 ec <8b> b0 94 00 00 00 8b 40 4c 85 c0 75 0e 8b 5d f4 8b 75 f8 8b 7d 
 <0>Kernel panic - not syncing: Attempted to kill init!
 

Signed-off-by: Ingo Molnar <mingo@elte.hu>

 drivers/base/class.c |    4 ++++
 1 files changed, 4 insertions(+)

Index: linux/drivers/base/class.c
===================================================================
--- linux.orig/drivers/base/class.c
+++ linux/drivers/base/class.c
@@ -520,8 +520,10 @@ int class_device_add(struct class_device
 		class_name = make_class_name(class_dev);
 		sysfs_create_link(&class_dev->kobj,
 				  &class_dev->dev->kobj, "device");
+		/*
 		sysfs_create_link(&class_dev->dev->kobj, &class_dev->kobj,
 				  class_name);
+		*/
 	}
 
 	/* notify any interfaces this device is now here */
@@ -618,7 +620,9 @@ void class_device_del(struct class_devic
 	if (class_dev->dev) {
 		class_name = make_class_name(class_dev);
 		sysfs_remove_link(&class_dev->kobj, "device");
+		/*
 		sysfs_remove_link(&class_dev->dev->kobj, class_name);
+		*/
 	}
 	if (class_dev->devt_attr)
 		class_device_remove_file(class_dev, class_dev->devt_attr);
