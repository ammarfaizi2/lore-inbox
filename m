Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314549AbSD0ADd>; Fri, 26 Apr 2002 20:03:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314550AbSD0ADd>; Fri, 26 Apr 2002 20:03:33 -0400
Received: from dialin-145-254-130-055.arcor-ip.net ([145.254.130.55]:25604
	"EHLO dale.home") by vger.kernel.org with ESMTP id <S314549AbSD0ADb>;
	Fri, 26 Apr 2002 20:03:31 -0400
Date: Sat, 27 Apr 2002 02:03:20 +0200
From: Alex Riesen <fork0@users.sourceforge.net>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: martin@dalecki.de, axboe@suse.de
Subject: 2.5.10(bk r1.558): oops on mount cdrom (scsi emulation)
Message-ID: <20020427020320.A181@steel>
Reply-To: Alex Riesen <fork0@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

That is. Just tried. Details below.

mount options:

/dev/scd0	/mnt/cdrom  iso9660 noauto,user,gid=100,unhide,mode=0444,ro

Device is a cd-recorder:

SCSI subsystem driver Revision: 1.00
Uniform CD-ROM driver unloaded
SCSI subsystem driver Revision: 1.00
ide: unexpected interrupt 1 15
scsi0 : SCSI host adapter emulation for IDE ATAPI devices
  Vendor: AOPEN     Model: CD-RW CRW2440     Rev: 1.00
  Type:   CD-ROM                             ANSI SCSI revision: 02
Attached scsi CD-ROM sr0 at scsi0, channel 0, id 0, lun 0
sr0: scsi3-mmc drive: 40x/40x writer cd/rw xa/form2 cdda tray


Oops is the oops below (slightly formatted). It's reproducable, though
i'd like to avoid the reproduction.

Uniform CD-ROM driver Revision: 3.12
VFS: Disk change detected on device sr(11,0)
Unable to handle kernel NULL pointer dereference at virtual address 00000044
 printing eip:
c019e652
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[ide_start_dma+62/168]    Not tainted
EFLAGS: 00010286
eax: 00000028   ebx: d6bae960   ecx: c029d038   edx: c029d038
esi: 0000d808   edi: c029d12c   ebp: 00000000   esp: d52f5bf4
ds: 0018   es: 0018   ss: 0018
Process mount (pid: 382, threadinfo=d52f4000 task=d6ec52c0)
Stack: d6bae960 c029d12c 00000000 c029d038 c019e7de c029d038 c029d12c 00000000 
       c029d12c d6bae960 c029d12c 00000800 00000000 00000001 00000008 0095cf60 
       c019f7d4 00000000 c029d12c c029d12c d6bae960 c029d038 dca897f7 00000000 
Call Trace: [ide_dmaproc+290/708] [via82cxxx_dmaproc+196/208] [<dca897f7>]
[<dca89915>] [start_request+690/800] [__elv_next_request+10/16]
[ide_queue_commands+343/432] [ide_do_request+85/120] [ide_do_drive_cmd+257/328]
[<dca8a292>] [<dca7d59b>] [<dca7da90>] [<dca832b0>] [<dca8e860>]
[generic_unplug_device+43/76] [__run_task_queue+102/120]
[__wait_on_buffer+90/144] [__bread+80/112] [<dca6002a>]
[get_sb_bdev+526/628] [<dca643a0>] [<dca643a0>] [<dca60ff7>] 
[<dca643a0>] [<dca5ff2c>] [do_kern_mount+74/196] [<dca643a0>]
[do_add_mount+109/316] [do_mount+364/392] [copy_mount_options+76/156]
[sys_mount+164/272] [syscall_call+7/11] 

Code: 8b 50 1c 83 e2 01 b8 08 00 00 00 85 d2 0f 44 e8 8b 81 80 05 
 <3>error: mount[382] exited with preempt_count 1



No filesystem damage. Which is always good.
The isofs had compression compiled in, but the zlib_inflate module
wasn't installed. I just copied it into modules/2.5.10/kernel/lib.

Parts of the config caused the oops (i'll mail the whole
if you think i cut too much):

...
CONFIG_PREEMPT=y
CONFIG_X86_UP_APIC=y
CONFIG_X86_UP_IOAPIC=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
...
CONFIG_IDE=y
CONFIG_BLK_DEV_IDE=y
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_IDEDISK_MULTI_MODE=y
CONFIG_BLK_DEV_IDECD=m
CONFIG_BLK_DEV_IDESCSI=m
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
CONFIG_IDEDMA_PCI_AUTO=y
CONFIG_BLK_DEV_IDEDMA=y
CONFIG_BLK_DEV_VIA82CXXX=y
CONFIG_IDEDMA_AUTO=y
CONFIG_SCSI=m
CONFIG_BLK_DEV_SR=m
CONFIG_SR_EXTRA_DEVS=2
CONFIG_CHR_DEV_SG=m
...
CONFIG_ISO9660_FS=m
CONFIG_JOLIET=y
CONFIG_ZISOFS=y
...
CONFIG_CRC32=m
CONFIG_ZLIB_INFLATE=m
# CONFIG_ZLIB_DEFLATE is not set

The last line is strange, the zlib_deflate was installed!



