Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263872AbTEFRr2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 13:47:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263877AbTEFRr2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 13:47:28 -0400
Received: from mail1.ewetel.de ([212.6.122.16]:24042 "EHLO mail1.ewetel.de")
	by vger.kernel.org with ESMTP id S263872AbTEFRrU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 13:47:20 -0400
Date: Tue, 6 May 2003 19:59:45 +0200 (CEST)
From: Pascal Schmidt <der.eremit@email.de>
To: Jens Axboe <axboe@suse.de>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [IDE] trying to make MO drive work with ide-floppy/ide-cd
In-Reply-To: <20030506152543.GX905@suse.de>
Message-ID: <Pine.LNX.4.44.0305061949150.1040-100000@neptune.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-CheckCompat: OK
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 May 2003, Jens Axboe wrote:

> You can play with the c code, you've demonstrated that much so far. So
> play some more, find out which commands are aborted and why. The log
> messages even tell you which ones. Now find out if these are necessary
> for proper MO functionality or not. Or maybe some vital commands are
> even missing, lots of fun there :). But it really should not be very
> hard.

Ok, I got a little bit further with the patch below. I can mount to disk
read-write and do a few things:

$ mount -t ext2 /dev/hde /mnt/mo
$ echo "foo" > /mnt/mo/bar
$ cat /mnt/mo/bar
foo
$ sync

No problem so far. But then

$ umount /mnt/mo

gets me:

------------[ cut here ]------------
kernel BUG at fs/buffer.c:2607!
invalid operand: 0000 [#1]
CPU:    0
EIP:    0060:[<c01466f6>]    Not tainted
EFLAGS: 00010202
EIP is at submit_bh+0x26/0x110
eax: 00000010   ebx: da449bd0   ecx: dfbb4c34   edx: c1494e98
esi: 00000001   edi: c0394900   ebp: de77d200   esp: de04bea8
ds: 007b   es: 007b   ss: 0068
Process umount (pid: 1161, threadinfo=de04a000 task=de210c60)
Stack: dd52a400 da449bd0 c01468e0 00000001 da449bd0 dfbb4b84 00000004 da449bd0 
       de77d200 dd52a400 de77d200 c0188342 da449bd0 00000000 df7c0498 c0186fb9 
       de77d200 dd52a400 de04a000 00000000 de04bf08 c0157e44 de04bf08 dfbb4c18 
Call Trace:
 [<c01468e0>] sync_dirty_buffer+0x80/0xb0
 [<c0188342>] ext2_sync_super+0x42/0x50
 [<c0186fb9>] ext2_put_super+0x29/0x90
 [<c0157e44>] invalidate_inodes+0xa4/0xc0
 [<c0147d70>] generic_shutdown_super+0xa0/0x140
 [<c0148682>] kill_block_super+0x12/0x30
 [<c0147bb7>] deactivate_super+0x67/0xa0
 [<c015a467>] __mntput+0x17/0x30
 [<c014d837>] path_release+0x27/0x30
 [<c015abff>] sys_umount+0x7f/0x90
 [<c0138783>] sys_munmap+0x43/0x60
 [<c015ac1b>] sys_oldumount+0xb/0x10
 [<c0108dbf>] syscall_call+0x7/0xb

Code: 0f 0b 2f 0a a6 3a 33 c0 8b 4b 20 85 c9 75 08 0f 0b 30 0a a6 

umount then segfaults. The BUG is from:

int submit_bh(int rw, struct buffer_head * bh)
{
        struct bio *bio;

        BUG_ON(!buffer_locked(bh));
        BUG_ON(!buffer_mapped(bh));
        ^^^^^^^^^^^^^^^^^^^^^^^^^^^ this one

After this, the MO drive is dead until I reboot. Trying to mount the disk
read-only after that reboot works without problems. Trying to mount 
read-write gives the same BUG_ON again on umount.

Running e2fsck from a 2.4 kernel shows that the directory entry for
/mnt/mo/bar did in fact get written to the disk, but fsck reports it
as using an unused inode, so I guess the inode and data writes did
not happen due to the BUG_ON.

Something seems to missing still.

My patch:

--- linux-2.5/include/linux/cdrom.h	Thu Apr 24 16:39:43 2003
+++ build25/include/linux/cdrom.h	Tue May  6 18:39:41 2003
@@ -387,6 +387,7 @@ struct cdrom_generic_command
 #define CDC_DVD			0x8000	/* drive is a DVD */
 #define CDC_DVD_R		0x10000	/* drive can write DVD-R */
 #define CDC_DVD_RAM		0x20000	/* drive can write DVD-RAM */
+#define CDC_MO			0x40000 /* drive is an MO */
 
 /* drive status possibilities returned by CDROM_DRIVE_STATUS ioctl */
 #define CDS_NO_INFO		0	/* if not implemented */
--- linux-2.5/drivers/cdrom/cdrom.c	Fri Mar 21 07:01:46 2003
+++ build25/drivers/cdrom/cdrom.c	Tue May  6 18:40:51 2003
@@ -425,7 +425,8 @@ int cdrom_open(struct cdrom_device_info 
 	if ((fp->f_flags & O_NONBLOCK) && (cdi->options & CDO_USE_FFLAGS))
 		ret = cdi->ops->open(cdi, 1);
 	else {
-		if ((fp->f_mode & FMODE_WRITE) && !CDROM_CAN(CDC_DVD_RAM))
+		if ((fp->f_mode & FMODE_WRITE)
+		    && !(CDROM_CAN(CDC_DVD_RAM) || CDROM_CAN(CDC_MO)))
 			return -EROFS;
 
 		ret = open_for_data(cdi);
--- linux-2.5/drivers/ide/ide.c	Thu May  1 15:01:12 2003
+++ build25/drivers/ide/ide.c	Tue May  6 17:01:34 2003
@@ -1518,6 +1518,7 @@ int generic_ide_ioctl(struct block_devic
 					return ide_taskfile_ioctl(drive, cmd, arg);
 #ifdef CONFIG_PKT_TASK_IOCTL
 				case ide_cdrom:
+				case ide_optical:
 				case ide_tape:
 				case ide_floppy:
 					return pkt_taskfile_ioctl(drive, cmd, arg);
--- linux-2.5/drivers/ide/ide-probe.c	Sat Apr 26 18:49:57 2003
+++ build25/drivers/ide/ide-probe.c	Tue May  6 19:07:37 2003
@@ -1235,7 +1235,7 @@ struct gendisk *ata_probe(dev_t dev, int
 			(void) request_module("ide-disk");
 		if (drive->scsi)
 			(void) request_module("ide-scsi");
-		if (drive->media == ide_cdrom)
+		if ((drive->media == ide_cdrom) || (drive->media == ide_optical))
 			(void) request_module("ide-cd");
 		if (drive->media == ide_tape)
 			(void) request_module("ide-tape");
--- linux-2.5/drivers/ide/ide-cd.h	Sat Nov  2 22:12:01 2002
+++ build25/drivers/ide/ide-cd.h	Tue May  6 18:33:28 2003
@@ -85,7 +85,8 @@ struct ide_cd_config_flags {
 	__u8 audio_play		: 1; /* can do audio related commands */
 	__u8 close_tray		: 1; /* can close the tray */
 	__u8 writing		: 1; /* pseudo write in progress */
-	__u8 reserved		: 3;
+	__u8 mo                 : 1; /* Drive is an MO */
+	__u8 reserved		: 2;
 	byte max_speed;		     /* Max speed of the drive */
 };
 #define CDROM_CONFIG_FLAGS(drive) (&(((struct cdrom_info *)(drive->driver_data))->config_flags))
--- linux-2.5/drivers/ide/ide-cd.c	Sun Apr 20 23:52:14 2003
+++ build25/drivers/ide/ide-cd.c	Tue May  6 19:26:24 2003
@@ -2793,7 +2793,7 @@ static struct cdrom_device_ops ide_cdrom
 				CDC_MEDIA_CHANGED | CDC_PLAY_AUDIO | CDC_RESET |
 				CDC_IOCTLS | CDC_DRIVE_STATUS | CDC_CD_R |
 				CDC_CD_RW | CDC_DVD | CDC_DVD_R| CDC_DVD_RAM |
-				CDC_GENERIC_PACKET,
+				CDC_GENERIC_PACKET | CDC_MO,
 	.generic_packet		= ide_cdrom_packet,
 };
 
@@ -2826,6 +2826,8 @@ static int ide_cdrom_register (ide_drive
 		devinfo->mask |= CDC_PLAY_AUDIO;
 	if (!CDROM_CONFIG_FLAGS(drive)->close_tray)
 		devinfo->mask |= CDC_CLOSE_TRAY;
+	if (!CDROM_CONFIG_FLAGS(drive)->mo)
+		devinfo->mask |= CDC_MO;
 
 	return register_cdrom(devinfo);
 }
@@ -2871,12 +2873,17 @@ int ide_cdrom_probe_capabilities (ide_dr
 	struct atapi_capabilities_page cap;
 	int nslots = 1;
 
+	if (drive->media == ide_optical) {
+		CDROM_CONFIG_FLAGS(drive)->mo = 1;
+		return nslots;
+	}
+
 	if (CDROM_CONFIG_FLAGS(drive)->nec260) {
 		CDROM_CONFIG_FLAGS(drive)->no_eject = 0;                       
 		CDROM_CONFIG_FLAGS(drive)->audio_play = 1;       
 		return nslots;
 	}
-
+	
 	if (ide_cdrom_get_capabilities(drive, &cap))
 		return 0;
 
@@ -3104,6 +3111,7 @@ int ide_cdrom_setup (ide_drive_t *drive)
 	CDROM_CONFIG_FLAGS(drive)->supp_disc_present = 0;
 	CDROM_CONFIG_FLAGS(drive)->audio_play = 0;
 	CDROM_CONFIG_FLAGS(drive)->close_tray = 1;
+	CDROM_CONFIG_FLAGS(drive)->mo = 0;
 	
 	/* limit transfer size per interrupt. */
 	CDROM_CONFIG_FLAGS(drive)->limit_nframes = 0;
@@ -3180,7 +3188,8 @@ int ide_cdrom_setup (ide_drive_t *drive)
 
 	nslots = ide_cdrom_probe_capabilities (drive);
 
-	if (CDROM_CONFIG_FLAGS(drive)->dvd_ram)
+	if (CDROM_CONFIG_FLAGS(drive)->dvd_ram
+	    || CDROM_CONFIG_FLAGS(drive)->mo)
 		set_disk_ro(drive->disk, 0);
 
 #if 0
@@ -3337,7 +3346,7 @@ static int ide_cdrom_attach (ide_drive_t
 		goto failed;
 	if (!drive->present)
 		goto failed;
-	if (drive->media != ide_cdrom)
+ 	if ((drive->media != ide_cdrom) && (drive->media != ide_optical))
 		goto failed;
 	/* skip drives that we were told to ignore */
 	if (ignore != NULL) {

-- 
Ciao,
Pascal

