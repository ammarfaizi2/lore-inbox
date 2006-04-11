Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750923AbWDKP0o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750923AbWDKP0o (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Apr 2006 11:26:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750925AbWDKP0o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Apr 2006 11:26:44 -0400
Received: from e32.co.us.ibm.com ([32.97.110.150]:4829 "EHLO e32.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750914AbWDKP0n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Apr 2006 11:26:43 -0400
Date: Tue, 11 Apr 2006 21:01:14 +0530
From: Rachita Kothiyal <rachita@in.ibm.com>
To: Jens Axboe <axboe@suse.de>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [RFC] Patch to fix cdrom being confused on using kdump
Message-ID: <20060411153114.GA5255@in.ibm.com>
Reply-To: rachita@in.ibm.com
References: <20060407135714.GA25569@in.ibm.com> <20060409102942.GI3859@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="LQksG6bCIzRHxTLp"
Content-Disposition: inline
In-Reply-To: <20060409102942.GI3859@suse.de>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--LQksG6bCIzRHxTLp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Apr 09, 2006 at 12:29:42PM +0200, Jens Axboe wrote:
> On Fri, Apr 07 2006, Rachita Kothiyal wrote:
> 
> if (stat & DRQ_STAT)
> 
> checking for DRQ_STAT again doesn't make sense, how can it ever be
> anything but DRQ_STAT if DRQ_STAT is set?

Hi Jens,

Yes, you are right. The condition itself is redundant there as 
DRQ will always be set there. I will remove it.

> 
> > +			/* DRQ is set. Interrupt not welcome now. Ignore */
> > +			HWIF(drive)->OUTB((stat & 0xEF), IDE_STATUS_REG);
> > +			return ide_stopped;
> 
> And this looks very wrong, you can't write to the status register. Well
> you can, but then it's the command register! Writing stat & 0xef to the
> command register is an odd thing to do. I think you just want to clear
> the DRQ bit, which should be fine after it was read initially. How about
> 
> 
>         if (stat & DRQ_STAT)
>                 return ide_stopped;
> 
> Can you test that?

I tested this, but I see it fail a couple of times...sometimes it hung
while booting up the second kernel and sometimes the kernel paniced 
while shutting it down.(attached partial log for panic)

I see your point that writing to the status register is not a good idea.
I think what we want to do is just ignore this particular interrupt and 
let it continue.
Am not sure if clearing DRQ bit will achieve this. Please correct me if
I am wrong, but to clear the DRQ bit also we will have to write to the 
status register. 

Thanks
Rachita

--LQksG6bCIzRHxTLp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="cdrom_shutdown_panic.log"

Shutting down powersaved                                              done
Saving random seed                                                    done
Umount SMB/ CIFS File Systems                                         done
Shutting down ldap-server                                             done
Shutting down SSH daemon                                              done
Remove Net File System (NFS)                                          unused
Shutting down RPC portmap daemon                                      done
Shutting down syslog services                                         done
Shutting down network interfaces:
cdrom: entering cdrom_open
cdrom: Use count for "/dev/hda" now 1
ide0: start_request: current=0xffff810003bfbaa8
ide0: start_request: current=0xffff810004c222d8
ide0: start_request: current=0xffff810003bfba18
ide0: start_request: current=0xffff810004c222d8
ide0: start_request: current=0xffff810003bfba08
ide0: start_request: current=0xffff810004c222d8
ide0: start_request: current=0xffff810003bfb9f8
ide0: start_request: current=0xffff810004c222d8
cdrom: entering CDROM_DRIVE_STATUS
ide0: start_request: current=0xffff810003bfbbb8
ide0: start_request: current=0xffff810004c222d8
ide0: start_request: current=0xffff810003bfbb58
cdrom: entering cdrom_release
cdrom: Use count for "/dev/hda" now zero
cdrom: hda: No DVD+RW
cdrom: Unlocking door!
ide0: start_request: current=0xffff810003bfbca8
cdrom: entering cdrom_open
cdrom: Use count for "/dev/hda" now 1
ide0: start_request: current=0xffff810003bfbaa8
ide0: start_request: current=0xffff810004c222d8
ide0: start_request: current=0xffff810003bfba18
ide0: start_request: current=0xffff810004c222d8
ide0: start_request: current=0xffff810003bfba08
ide0: start_request: current=0xffff810004c222d8
ide0: start_request: current=0xffff810003bfb9f8
ide0: start_request: current=0xffff810004c222d8
cdrom: entering CDROM_DRIVE_STATUS
ide0: start_request: current=0xffff810003bfbbb8
ide0: start_request: current=0xffff810004c222d8
ide0: start_request: current=0xffff810003bfbb58
cdrom: entering cdrom_release
cdrom: Use count for "/dev/hda" now zero
cdrom: hda: No DVD+RW
cdrom: Unlocking door!
ide0: start_request: current=0xffff810003bfbca8
cdrom: entering cdrom_open
cdrom: Use count for "/dev/hda" now 1
ide0: start_request: current=0xffff810003bfbaa8
ide0: start_request: current=0xffff810004c222d8
ide0: start_request: current=0xffff810003bfba18
ide0: start_request: current=0xffff810004c222d8
ide0: start_request: current=0xffff810003bfba08
ide0: start_request: current=0xffff810004c222d8
ide0: start_request: current=0xffff810003bfb9f8
ide0: start_request: current=0xffff810004c222d8
cdrom: entering CDROM_DRIVE_STATUS
ide0: start_request: current=0xffff810003bfbbb8
ide0: start_request: current=0xffff810004c222d8
ide0: start_request: current=0xffff810003bfbb58
cdrom: entering cdrom_release
cdrom: Use count for "/dev/hda" now zero
cdrom: hda: No DVD+RW
cdrom: Unlocking door!
ide0: start_request: current=0xffff810003bfbca8
cdrom: entering cdrom_open
cdrom: Use count for "/dev/hda" now 1
ide0: start_request: current=0xffff810003bfbaa8
ide0: start_request: current=0xffff810004c222d8
ide0: start_request: current=0xffff810003bfba18
ide0: start_request: current=0xffff810004c222d8
ide0: start_request: current=0xffff810003bfba08
ide0: start_request: current=0xffff810004c222d8
ide0: start_request: current=0xffff810003bfb9f8
ide0: start_request: current=0xffff810004c222d8
cdrom: entering CDROM_DRIVE_STATUS
ide0: start_request: current=0xffff810003bfbbb8
ide0: start_request: current=0xffff810004c222d8
ide0: start_request: current=0xffff810003bfbb58
cdrom: entering cdrom_release
cdrom: Use count for "/dev/hda" now zero
cdrom: hda: No DVD+RW
cdrom: Unlocking door!
ide0: start_request: current=0xffff810003bfbca8
cdrom: entering cdrom_open
cdrom: Use count for "/dev/hda" now 1
ide0: start_request: current=0xffff810003bfbaa8
ide0: start_request: current=0xffff810004c222d8
ide0: start_request: current=0xffff810003bfba18
ide0: start_request: current=0xffff810004c222d8
ide0: start_request: current=0xffff810003bfba08
ide0: start_request: current=0xffff810004c222d8
ide0: start_request: current=0xffff810003bfb9f8
ide0: start_request: current=0xffff810004c222d8
cdrom: entering CDROM_DRIVE_STATUS
ide0: start_request: current=0xffff810003bfbbb8
ide0: start_request: current=0xffff810004c222d8
ide0: start_request: current=0xffff810003bfbb58
cdrom: entering cdrom_release
cdrom: Use count for "/dev/hda" now zero
cdrom: hda: No DVD+RW
cdrom: Unlocking door!
ide0: start_request: current=0xffff810003bfbca8
cdrom: entering cdrom_open
cdrom: Use count for "/dev/hda" now 1
ide0: start_request: current=0xffff810003bfbaa8
ide0: start_request: current=0xffff810004c222d8
ide0: start_request: current=0xffff810003bfba18
ide0: start_request: current=0xffff810004c222d8
ide0: start_request: current=0xffff810003bfba08
ide0: start_request: current=0xffff810004c222d8
ide0: start_request: current=0xffff810003bfb9f8
ide0: start_request: current=0xffff810004c222d8
cdrom: entering CDROM_DRIVE_STATUS
ide0: start_request: current=0xffff810003bfbbb8
ide0: start_request: current=0xffff810004c222d8
ide0: start_request: current=0xffff810003bfbb58
cdrom: entering cdrom_release
cdrom: Use count for "/dev/hda" now zero
cdrom: hda: No DVD+RW
cdrom: Unlocking door!
ide0: start_request: current=0xffff810003bfbca8
cdrom: entering cdrom_open
cdrom: Use count for "/dev/hda" now 1
ide0: start_request: current=0xffff810003bfbaa8
ide0: start_request: current=0xffff810004c222d8
ide0: start_request: current=0xffff810003bfba18
ide0: start_request: current=0xffff810004c222d8
ide0: start_request: current=0xffff810003bfba08
ide0: start_request: current=0xffff810004c222d8
ide0: start_request: current=0xffff810003bfb9f8
ide0: start_request: current=0xffff810004c222d8
cdrom: entering CDROM_DRIVE_STATUS
ide0: start_request: current=0xffff810003bfbbb8
ide0: start_request: current=0xffff810004c222d8
ide0: start_request: current=0xffff810003bfbb58
cdrom: entering cdrom_release
cdrom: Use count for "/dev/hda" now zero
cdrom: hda: No DVD+RW
cdrom: Unlocking door!
ide0: start_request: current=0xffff810003bfbca8
cdrom: entering cdrom_open
cdrom: Use count for "/dev/hda" now 1
ide0: start_request: current=0xffff810003bfbaa8
ide0: start_request: current=0xffff810004c222d8
ide0: start_request: current=0xffff810003bfba18
ide0: start_request: current=0xffff810004c222d8
ide0: start_request: current=0xffff810003bfba08
ide0: start_request: current=0xffff810004c222d8
ide0: start_request: current=0xffff810003bfb9f8
ide0: start_request: current=0xffff810004c222d8
cdrom: entering CDROM_DRIVE_STATUS
ide0: start_request: current=0xffff810003bfbbb8
ide0: start_request: current=0xffff810004c222d8
ide0: start_request: current=0xffff810003bfbb58
cdrom: entering cdrom_release
cdrom: Use count for "/dev/hda" now zero
cdrom: hda: No DVD+RW
cdrom: Unlocking door!
ide0: start_request: current=0xffff810003bfbca8
cdrom: entering cdrom_open
cdrom: Use count for "/dev/hda" now 1
ide0: start_request: current=0xffff810003bfbaa8
ide0: start_request: current=0xffff810004c222d8
ide0: start_request: current=0xffff810003bfba18
ide0: start_request: current=0xffff810004c222d8
ide0: start_request: current=0xffff810003bfba08
ide0: start_request: current=0xffff810004c222d8
ide0: start_request: current=0xffff810003bfb9f8
ide0: start_request: current=0xffff810004c222d8
cdrom: entering CDROM_DRIVE_STATUS
ide0: start_request: current=0xffff810003bfbbb8
ide0: start_request: current=0xffff810004c222d8
ide0: start_request: current=0xffff810003bfbb58
cdrom: entering cdrom_release
cdrom: Use count for "/dev/hda" now zero
cdrom: hda: No DVD+RW
cdrom: Unlocking door!
ide0: start_request: current=0xffff810003bfbca8
cdrom: entering cdrom_open
cdrom: Use count for "/dev/hda" now 1
ide0: start_request: current=0xffff810003bfbaa8
ide0: start_request: current=0xffff810004c222d8
ide0: start_request: current=0xffff810003bfba18
ide0: start_request: current=0xffff810004c222d8
ide0: start_request: current=0xffff810003bfba08
ide0: start_request: current=0xffff810004c222d8
ide0: start_request: current=0xffff810003bfb9f8
ide0: start_request: current=0xffff810004c222d8
cdrom: entering CDROM_DRIVE_STATUS
ide0: start_request: current=0xffff810003bfbbb8
ide0: start_request: current=0xffff810004c222d8
ide0: start_request: current=0xffff810003bfbb58
cdrom: entering cdrom_release
cdrom: Use count for "/dev/hda" now zero
cdrom: hda: No DVD+RW
cdrom: Unlocking door!
ide0: start_request: current=0xffff810003bfbca8
cdrom: entering cdrom_open
cdrom: Use count for "/dev/hda" now 1
ide0: start_request: current=0xffff810003bfbaa8
ide0: start_request: current=0xffff810004c222d8
ide0: start_request: current=0xffff810003bfba18
ide0: start_request: current=0xffff810004c222d8
ide0: start_request: current=0xffff810003bfba08
ide0: start_request: current=0xffff810004c222d8
ide0: start_request: current=0xffff810003bfb9f8
ide0: start_request: current=0xffff810004c222d8
cdrom: entering CDROM_DRIVE_STATUS
ide0: start_request: current=0xffff810003bfbbb8
ide0: start_request: current=0xffff810004c222d8
ide0: start_request: current=0xffff810003bfbb58
cdrom: entering cdrom_release
cdrom: Use count for "/dev/hda" now zero
cdrom: hda: No DVD+RW
cdrom: Unlocking door!
ide0: start_request: current=0xffff810003bfbca8
cdrom: entering cdrom_open
cdrom: Use count for "/dev/hda" now 1
ide0: start_request: current=0xffff810003bfbaa8
ide0: start_request: current=0xffff810004c222d8
ide0: start_request: current=0xffff810003bfba18
ide0: start_request: current=0xffff810004c222d8
ide0: start_request: current=0xffff810003bfba08
ide0: start_request: current=0xffff810004c222d8
ide0: start_request: current=0xffff810003bfb9f8
ide0: start_request: current=0xffff810004c222d8
cdrom: entering CDROM_DRIVE_STATUS
ide0: start_request: current=0xffff810003bfbbb8
ide0: start_request: current=0xffff810004c222d8
ide0: start_request: current=0xffff810003bfbb58
cdrom: entering cdrom_release
cdrom: Use count for "/dev/hda" now zero
cdrom: hda: No DVD+RW
cdrom: Unlocking door!
ide0: start_request: current=0xffff810003bfbca8
cdrom: entering cdrom_open
cdrom: Use count for "/dev/hda" now 1
ide0: start_request: current=0xffff810003bfbaa8
ide0: start_request: current=0xffff810004c222d8
ide0: start_request: current=0xffff810003bfba18
ide0: start_request: current=0xffff810004c222d8
ide0: start_request: current=0xffff810003bfba08
ide0: start_request: current=0xffff810004c222d8
ide0: start_request: current=0xffff810003bfb9f8
ide0: start_request: current=0xffff810004c222d8
cdrom: entering CDROM_DRIVE_STATUS
ide0: start_request: current=0xffff810003bfbbb8
ide0: start_request: current=0xffff810004c222d8
ide0: start_request: current=0xffff810003bfbb58
Rachita: DRQ set.Interrupt ignored
BUG: spinlock recursion on CPU#0, hald-addon-stor/2018
 lock: ffffffff812c1128, .magic: dead4ead, .owner: hald-addon-stor/2018, .owner_cpu: 0

Call Trace: <IRQ> <ffffffff810cf6e9>{_raw_spin_lock+61}
       <ffffffff81042b08>{__do_IRQ+55} <ffffffff8100c3cb>{do_IRQ+59}
       <ffffffff8100aa24>{ret_from_intr+0} <ffffffff880052cf>{:ide_core:ide_do_request+820}
       <ffffffff880052ca>{:ide_core:ide_do_request+815} <ffffffff8118e7d1>{_spin_lock_irqsave+9}
       <ffffffff88161c58>{:ide_cd:cdrom_decode_status+42} <ffffffff881626ca>{:ide_cd:cdrom_pc_intr+510}
       <ffffffff88005abd>{:ide_core:ide_intr+442} <ffffffff810431a8>{note_interrupt+219}
       <ffffffff81042b7e>{__do_IRQ+173} <ffffffff8100c3cb>{do_IRQ+59}
       <ffffffff8100aa24>{ret_from_intr+0} <EOI> <ffffffff8102743a>{vprintk+652}
       <ffffffff88006233>{:ide_core:ide_outsw+0} <ffffffff88006238>{:ide_core:ide_outsw+5}
       <ffffffff88006681>{:ide_core:atapi_output_bytes+38}
       <ffffffff881624cc>{:ide_cd:cdrom_pc_intr+0} <ffffffff88162b5b>{:ide_cd:cdrom_transfer_packet_command+182}
       <ffffffff88162bda>{:ide_cd:cdrom_do_pc_continuation+0}
       <ffffffff8815f91a>{:ide_cd:cdrom_start_packet_command+359}
       <ffffffff880055d2>{:ide_core:ide_do_request+1591} <ffffffff8118d1e4>{thread_return+0}
       <ffffffff8118d23a>{thread_return+86} <ffffffff8800574d>{:ide_core:ide_do_request+1970}
       <ffffffff810bd928>{elv_insert+120} <ffffffff880058a5>{:ide_core:ide_do_drive_cmd+245}
       <ffffffff881603a7>{:ide_cd:cdrom_queue_packet_command+70}
       <ffffffff810bf79a>{blk_end_sync_rq+0} <ffffffff880045f8>{:ide_core:ide_init_drive_cmd+16}
       <ffffffff881604de>{:ide_cd:ide_cdrom_packet+155} <ffffffff810bf79a>{blk_end_sync_rq+0}
       <ffffffff8814b7ea>{:cdrom:cdrom_get_media_event+77}
       <ffffffff88160b22>{:ide_cd:ide_cdrom_drive_status+65}
       <ffffffff8814b266>{:cdrom:cdrom_ioctl+1640} <ffffffff810ca406>{kobject_get+18}
       <ffffffff810c2747>{get_disk+47} <ffffffff810c21a3>{blkdev_ioctl+1558}
       <ffffffff81068f83>{do_open+221} <ffffffff81068e9e>{bdget+284}
       <ffffffff81068896>{bd_claim+131} <ffffffff810693ea>{blkdev_open+0}
       <ffffffff81069422>{blkdev_open+56} <ffffffff810608af>{__dentry_open+238}
       <ffffffff81068967>{block_ioctl+27} <ffffffff81072713>{do_ioctl+27}
       <ffffffff81072957>{vfs_ioctl+527} <ffffffff810729a5>{sys_ioctl+60}
       <ffffffff8100a47e>{system_call+126}
NMI Watchdog detected LOCKUP on CPU 0
CPU 0
Modules linked in: edd ipv6 loop dm_mod usbhid tg3 generic ide_cd shpchp cdrom pci_hotplug uhci_hcd ehci_hcd e752x_edac floppy usbcore edac_mc ext3 jbd processor sg aic79xx scsi_transport_spi piix sd_mod scsi_mod ide_disk ide_core
Pid: 2018, comm: hald-addon-stor Tainted: G     U 2.6.16-rc2-git5-rachita-3-kdump
#6
RIP: 0010:[<ffffffff810ce62b>] <ffffffff810ce62b>{__delay+2}
RSP: 0018:ffffffff8124b8a8  EFLAGS: 00000006
RAX: 00000000b395caba RBX: ffffffff812c1128 RCX: 00000000b395c9c7
RDX: 0000000000000205 RSI: ffffffff811b4fad RDI: 0000000000000001
RBP: 000000001bb47288 R08: 0000000000000007 R09: ffffffff8124b4f0
R10: ffffffff88164154 R11: 0000000000000000 R12: 0000000000000001
R13: ffffffff812c1128 R14: ffff810004af4488 R15: ffffffff8124b908
FS:  00002b44cadc36d0(0000) GS:ffffffff812c1000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: 00002b752a9f8280 CR3: 0000000002d42000 CR4: 00000000000006e0
Process hald-addon-stor (pid: 2018, threadinfo ffff810003bfa000, task ffff81000446e040)
Stack: ffffffff810cf72d 0000000000000000 ffffffff812c1100 0000000000000000
       ffffffff81042b08 ffff810004b71c10 ffffffff8124b908 0000000000000000
       ffff810004af4488 ffffffff8801d220
Call Trace: <IRQ> <ffffffff810cf72d>{_raw_spin_lock+129}
       <ffffffff81042b08>{__do_IRQ+55} <ffffffff8100c3cb>{do_IRQ+59}
       <ffffffff8100aa24>{ret_from_intr+0} <ffffffff880052cf>{:ide_core:ide_do_request+820}
       <ffffffff880052ca>{:ide_core:ide_do_request+815} <ffffffff8118e7d1>{_spin_lock_irqsave+9}
       <ffffffff88161c58>{:ide_cd:cdrom_decode_status+42} <ffffffff881626ca>{:ide_cd:cdrom_pc_intr+510}
       <ffffffff88005abd>{:ide_core:ide_intr+442} <ffffffff810431a8>{note_interrupt+219}
       <ffffffff81042b7e>{__do_IRQ+173} <ffffffff8100c3cb>{do_IRQ+59}
       <ffffffff8100aa24>{ret_from_intr+0} <EOI> <ffffffff8102743a>{vprintk+652}
       <ffffffff88006233>{:ide_core:ide_outsw+0} <ffffffff88006238>{:ide_core:ide_outsw+5}
       <ffffffff88006681>{:ide_core:atapi_output_bytes+38}
       <ffffffff881624cc>{:ide_cd:cdrom_pc_intr+0} <ffffffff88162b5b>{:ide_cd:cdrom_transfer_packet_command+182}
       <ffffffff88162bda>{:ide_cd:cdrom_do_pc_continuation+0}
       <ffffffff8815f91a>{:ide_cd:cdrom_start_packet_command+359}
       <ffffffff880055d2>{:ide_core:ide_do_request+1591} <ffffffff8118d1e4>{thread_return+0}
       <ffffffff8118d23a>{thread_return+86} <ffffffff8800574d>{:ide_core:ide_do_request+1970}
       <ffffffff810bd928>{elv_insert+120} <ffffffff880058a5>{:ide_core:ide_do_drive_cmd+245}
       <ffffffff881603a7>{:ide_cd:cdrom_queue_packet_command+70}
       <ffffffff810bf79a>{blk_end_sync_rq+0} <ffffffff880045f8>{:ide_core:ide_init_drive_cmd+16}
       <ffffffff881604de>{:ide_cd:ide_cdrom_packet+155} <ffffffff810bf79a>{blk_end_sync_rq+0}
       <ffffffff8814b7ea>{:cdrom:cdrom_get_media_event+77}
       <ffffffff88160b22>{:ide_cd:ide_cdrom_drive_status+65}
       <ffffffff8814b266>{:cdrom:cdrom_ioctl+1640} <ffffffff810ca406>{kobject_get+18}
       <ffffffff810c2747>{get_disk+47} <ffffffff810c21a3>{blkdev_ioctl+1558}
       <ffffffff81068f83>{do_open+221} <ffffffff81068e9e>{bdget+284}
       <ffffffff81068896>{bd_claim+131} <ffffffff810693ea>{blkdev_open+0}
       <ffffffff81069422>{blkdev_open+56} <ffffffff810608af>{__dentry_open+238}
       <ffffffff81068967>{block_ioctl+27} <ffffffff81072713>{do_ioctl+27}
       <ffffffff81072957>{vfs_ioctl+527} <ffffffff810729a5>{sys_ioctl+60}
       <ffffffff8100a47e>{system_call+126}

Code: 89 c1 f3 90 0f 31 29 c8 48 39 f8 72 f5 c3 48 69 05 cc a4 1f
console shuts up ...
 <3>Debug: sleeping function called from invalid context at include/linux/rwsem.h:43
in_atomic():1, irqs_disabled():1

Call Trace: <NMI> <ffffffff81027e14>{profile_task_exit+21}
       <ffffffff810299e0>{do_exit+32} <ffffffff8118ede7>{__die+0}
       <ffffffff8118f4d5>{nmi_watchdog_tick+161} <ffffffff8118f2d1>{default_do_nmi+115}
       <ffffffff8118f58b>{do_nmi+61} <ffffffff8118eb87>{nmi+127}
       <ffffffff810ce62b>{__delay+2} <EOE> <IRQ> <ffffffff810cf72d>{_raw_spin_lock+129}
       <ffffffff81042b08>{__do_IRQ+55} <ffffffff8100c3cb>{do_IRQ+59}
       <ffffffff8100aa24>{ret_from_intr+0} <ffffffff880052cf>{:ide_core:ide_do_request+820}
       <ffffffff880052ca>{:ide_core:ide_do_request+815} <ffffffff8118e7d1>{_spin_lock_irqsave+9}
       <ffffffff88161c58>{:ide_cd:cdrom_decode_status+42} <ffffffff881626ca>{:ide_cd:cdrom_pc_intr+510}
       <ffffffff88005abd>{:ide_core:ide_intr+442} <ffffffff810431a8>{note_interrupt+219}
       <ffffffff81042b7e>{__do_IRQ+173} <ffffffff8100c3cb>{do_IRQ+59}
       <ffffffff8100aa24>{ret_from_intr+0} <EOI> <ffffffff8102743a>{vprintk+652}
       <ffffffff88006233>{:ide_core:ide_outsw+0} <ffffffff88006238>{:ide_core:ide_outsw+5}
       <ffffffff88006681>{:ide_core:atapi_output_bytes+38}
       <ffffffff881624cc>{:ide_cd:cdrom_pc_intr+0} <ffffffff88162b5b>{:ide_cd:cdrom_transfer_packet_command+182}
       <ffffffff88162bda>{:ide_cd:cdrom_do_pc_continuation+0}
       <ffffffff8815f91a>{:ide_cd:cdrom_start_packet_command+359}
       <ffffffff880055d2>{:ide_core:ide_do_request+1591} <ffffffff8118d1e4>{thread_return+0}
       <ffffffff8118d23a>{thread_return+86} <ffffffff8800574d>{:ide_core:ide_do_request+1970}
       <ffffffff810bd928>{elv_insert+120} <ffffffff880058a5>{:ide_core:ide_do_drive_cmd+245}
       <ffffffff881603a7>{:ide_cd:cdrom_queue_packet_command+70}
       <ffffffff810bf79a>{blk_end_sync_rq+0} <ffffffff880045f8>{:ide_core:ide_init_drive_cmd+16}
       <ffffffff881604de>{:ide_cd:ide_cdrom_packet+155} <ffffffff810bf79a>{blk_end_sync_rq+0}
       <ffffffff8814b7ea>{:cdrom:cdrom_get_media_event+77}
       <ffffffff88160b22>{:ide_cd:ide_cdrom_drive_status+65}
       <ffffffff8814b266>{:cdrom:cdrom_ioctl+1640} <ffffffff810ca406>{kobject_get+18}
       <ffffffff810c2747>{get_disk+47} <ffffffff810c21a3>{blkdev_ioctl+1558}
       <ffffffff81068f83>{do_open+221} <ffffffff81068e9e>{bdget+284}
       <ffffffff81068896>{bd_claim+131} <ffffffff810693ea>{blkdev_open+0}
       <ffffffff81069422>{blkdev_open+56} <ffffffff810608af>{__dentry_open+238}
       <ffffffff81068967>{block_ioctl+27} <ffffffff81072713>{do_ioctl+27}
       <ffffffff81072957>{vfs_ioctl+527} <ffffffff810729a5>{sys_ioctl+60}
       <ffffffff8100a47e>{system_call+126}
Kernel panic - not syncing: Aiee, killing interrupt handler!

--LQksG6bCIzRHxTLp--
