Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932174AbWDLLZR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932174AbWDLLZR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Apr 2006 07:25:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932184AbWDLLZR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Apr 2006 07:25:17 -0400
Received: from e35.co.us.ibm.com ([32.97.110.153]:21945 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S932181AbWDLLZP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Apr 2006 07:25:15 -0400
Date: Wed, 12 Apr 2006 16:59:33 +0530
From: Rachita Kothiyal <rachita@in.ibm.com>
To: Jens Axboe <axboe@suse.de>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [RFC] Patch to fix cdrom being confused on using kdump
Message-ID: <20060412112933.GA6204@in.ibm.com>
Reply-To: rachita@in.ibm.com
References: <20060407135714.GA25569@in.ibm.com> <20060409102942.GI3859@suse.de> <20060411153114.GA5255@in.ibm.com> <20060411170357.GR4791@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="fdj2RfSjLxBAspz7"
Content-Disposition: inline
In-Reply-To: <20060411170357.GR4791@suse.de>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--fdj2RfSjLxBAspz7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 11, 2006 at 07:03:57PM +0200, Jens Axboe wrote:
> > 
> > I see your point that writing to the status register is not a good idea.
> > I think what we want to do is just ignore this particular interrupt and 
> > let it continue.
> > Am not sure if clearing DRQ bit will achieve this. Please correct me if
> > I am wrong, but to clear the DRQ bit also we will have to write to the 
> > status register. 
> 
> No, there is not writable status register - that is called the command
> register. Just reading the status register is enough to clear the irq,
> so if you just want to ignore the interrupt that'll work.

Hi Jens,

I actually tried just reading the status register and then returning
ide_stopped. It seemed to be working fine, just that there appears 
a 'status error' message while booting:

<snippet>
ide0: start_request: current=0xffff8100035cba68
hda: status error: status=0x58 { DriveReady SeekComplete DataRequest }
ide: failed opcode was: unknown
hda: drive not ready for command
</snippet>

The second kernel boots up fine though and I am able to mount the cdrom
ok and access its files too.

> What happens if you rearm the interrupt handler instead of returning
> ide_stopped?

In this case the kernel just panics during booting(attaching the partial 
panic log).

Thanks
Rachita

--fdj2RfSjLxBAspz7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="rearm.cap"

usb usb2: SerialNumber: 0000:00:1d.1
usb usb2: configuration #1 chosen from 1 choice
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
ide0: start_request: current=0xffff810003a2ba88
Rachita: DRQ set.Interrupt ignored
hda: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
hda: ide_set_handler: handler not null; old=ffffffff881624cc, new=ffffffff881624cc
----------- [cut here ] --------- [please bite here ] ---------
Kernel BUG at include/linux/timer.h:83
invalid opcode: 0000 [1] 
last sysfs file: /devices/platform/floppy.0/cmos
CPU 0 
Modules linked in: ide_cd cdrom ehci_hcd uhci_hcd usbcore shpchp e752x_edac pci_hotplug edac_mc floppy ext3 jbd processor sg aic79xx scsi_transport_spi piix sd_mod scsi_mod ide_disk ide_core
Pid: 940, comm: modprobe Tainted: G     U 2.6.16-rc2-git5-rachita-3-kdump #6
RIP: 0010:[<ffffffff88006ad1>] <ffffffff88006ad1>{:ide_core:__ide_set_handler+96}
RSP: 0018:ffffffff8124b9b8  EFLAGS: 00010082
RAX: 00000000ffff44ce RBX: ffff810004e2a548 RCX: 00000000000002f8
RDX: 0000000000003a98 RSI: 0000000000000046 RDI: ffff810004e2a588
RBP: ffffffff881624cc R08: 0000000000000007 R09: ffffffff8124b718
R10: 0000000000000010 R11: 0000000000000000 R12: ffffffff8815f1cf
R13: 0000000000003a98 R14: ffffffff881624cc R15: ffffffff8801d438
FS:  00002aba4494e6d0(0000) GS:ffffffff812c1000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: 000000000053873d CR3: 00000000037f4000 CR4: 00000000000006e0
Process modprobe (pid: 940, threadinfo ffff810003a2a000, task ffff8100031760c0)
Stack: 0000000000000002 ffffffff8815f1cf 0000000000000018 0000000000003a98 
       0000000000000002 ffffffff88006cf5 ffff810003a2ba88 0000000000000018 
       ffffffff8801d438 0000000000000001 
Call Trace: <IRQ> <ffffffff8815f1cf>{:ide_cd:cdrom_timer_expiry+0}
       <ffffffff88006cf5>{:ide_core:ide_set_handler+53} <ffffffff88162713>{:ide_cd:cdrom_pc_intr+583}
       <ffffffff881624cc>{:ide_cd:cdrom_pc_intr+0} <ffffffff88005a98>{:ide_core:ide_intr+386}
       <ffffffff810431a8>{note_interrupt+219} <ffffffff81042b7e>{__do_IRQ+173}
       <ffffffff8100c3cb>{do_IRQ+59} <ffffffff8100aa24>{ret_from_intr+0} <EOI>
       <ffffffff81046584>{mempool_alloc+66} <ffffffff8105e21b>{poison_obj+38}
       <ffffffff88006273>{:ide_core:ide_outsw+0} <ffffffff88006278>{:ide_core:ide_outsw+5}
       <ffffffff880066c1>{:ide_core:atapi_output_bytes+38}
       <ffffffff881624cc>{:ide_cd:cdrom_pc_intr+0} <ffffffff88162b68>{:ide_cd:cdrom_transfer_packet_command+182}
       <ffffffff88162be7>{:ide_cd:cdrom_do_pc_continuation+0}
       <ffffffff8815f91a>{:ide_cd:cdrom_start_packet_command+359}
       <ffffffff880055dc>{:ide_core:ide_do_request+1601} <ffffffff810bd928>{elv_insert+120}
       <ffffffff880058b8>{:ide_core:ide_do_drive_cmd+245} <ffffffff881603a7>{:ide_cd:cdrom_queue_packet_command+70}
       <ffffffff81050afd>{__handle_mm_fault+2388} <ffffffff880045f8>{:ide_core:ide_init_drive_cmd+16}
       <ffffffff881604de>{:ide_cd:ide_cdrom_packet+155} <ffffffff810bf79a>{blk_end_sync_rq+0}
       <ffffffff8815f6c1>{:ide_cd:ide_cdrom_get_capabilities+114}
       <ffffffff88161491>{:ide_cd:ide_cd_probe+1335} <ffffffff8118e791>{_spin_unlock_irq+12}
       <ffffffff8118d23a>{thread_return+86} <ffffffff8111da4d>{driver_probe_device+82}
       <ffffffff8111dba4>{__driver_attach+140} <ffffffff8111db18>{__driver_attach+0}
       <ffffffff8111d452>{bus_for_each_dev+67} <ffffffff8111d0c2>{bus_add_driver+126}
       <ffffffff8103eca3>{sys_init_module+5269} <ffffffff81038aa5>{autoremove_wake_function+0}
       <ffffffff810625b2>{vfs_write+283} <ffffffff8100a47e>{system_call+126}

Code: 0f 0b 68 b7 ec 00 88 c2 53 00 48 8b 77 10 41 58 5b 5d 41 5c 
RIP <ffffffff88006ad1>{:ide_core:__ide_set_handler+96} RSP <ffffffff8124b9b8>
 <3>Debug: sleeping function called from invalid context at include/linux/rwsem.h:43
in_atomic():1, irqs_disabled():1

Call Trace: <IRQ> <ffffffff81027e14>{profile_task_exit+21}
       <ffffffff810299e0>{do_exit+32} <ffffffff8100b85e>{kernel_math_error+0}
       <ffffffff8815f1cf>{:ide_cd:cdrom_timer_expiry+0} <ffffffff881624cc>{:ide_cd:cdrom_pc_intr+0}
       <ffffffff8100bdc5>{do_invalid_op+163} <ffffffff88006ad1>{:ide_core:__ide_set_handler+96}
       <ffffffff8102743a>{vprintk+652} <ffffffff81026de9>{release_console_sem+423}
       <ffffffff881624cc>{:ide_cd:cdrom_pc_intr+0} <ffffffff8815f1cf>{:ide_cd:cdrom_timer_expiry+0}
       <ffffffff8100adad>{error_exit+0} <ffffffff881624cc>{:ide_cd:cdrom_pc_intr+0}
       <ffffffff8815f1cf>{:ide_cd:cdrom_timer_expiry+0} <ffffffff881624cc>{:ide_cd:cdrom_pc_intr+0}
       <ffffffff88006ad1>{:ide_core:__ide_set_handler+96} <ffffffff88006aab>{:ide_core:__ide_set_handler+58}
       <ffffffff8815f1cf>{:ide_cd:cdrom_timer_expiry+0} <ffffffff88006cf5>{:ide_core:ide_set_handler+53}
       <ffffffff88162713>{:ide_cd:cdrom_pc_intr+583} <ffffffff881624cc>{:ide_cd:cdrom_pc_intr+0}
       <ffffffff88005a98>{:ide_core:ide_intr+386} <ffffffff810431a8>{note_interrupt+219}
       <ffffffff81042b7e>{__do_IRQ+173} <ffffffff8100c3cb>{do_IRQ+59}
       <ffffffff8100aa24>{ret_from_intr+0} <EOI> <ffffffff81046584>{mempool_alloc+66}
       <ffffffff8105e21b>{poison_obj+38} <ffffffff88006273>{:ide_core:ide_outsw+0}
       <ffffffff88006278>{:ide_core:ide_outsw+5} <ffffffff880066c1>{:ide_core:atapi_output_bytes+38}
       <ffffffff881624cc>{:ide_cd:cdrom_pc_intr+0} <ffffffff88162b68>{:ide_cd:cdrom_transfer_packet_command+182}
       <ffffffff8815f91a>{:ide_cd:cdrom_start_packet_command+359}
       <ffffffff880055dc>{:ide_core:ide_do_request+1601} <ffffffff810bd928>{elv_insert+120}
       <ffffffff880058b8>{:ide_core:ide_do_drive_cmd+245} <ffffffff881603a7>{:ide_cd:cdrom_queue_packet_command+70}
       <ffffffff81050afd>{__handle_mm_fault+2388} <ffffffff880045f8>{:ide_core:ide_init_drive_cmd+16}
       <ffffffff881604de>{:ide_cd:ide_cdrom_packet+155} <ffffffff810bf79a>{blk_end_sync_rq+0}
       <ffffffff8815f6c1>{:ide_cd:ide_cdrom_get_capabilities+114}
       <ffffffff88161491>{:ide_cd:ide_cd_probe+1335} <ffffffff8118e791>{_spin_unlock_irq+12}
       <ffffffff8118d23a>{thread_return+86} <ffffffff8111da4d>{driver_probe_device+82}
       <ffffffff8111dba4>{__driver_attach+140} <ffffffff8111db18>{__driver_attach+0}
       <ffffffff8111d452>{bus_for_each_dev+67} <ffffffff8111d0c2>{bus_add_driver+126}
       <ffffffff8103eca3>{sys_init_module+5269} <ffffffff81038aa5>{autoremove_wake_function+0}
       <ffffffff810625b2>{vfs_write+283} <ffffffff8100a47e>{system_call+126}
Kernel panic - not syncing: Aiee, killing interrupt handler!
 

--fdj2RfSjLxBAspz7--
