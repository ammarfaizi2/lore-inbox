Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263785AbTKKVl4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Nov 2003 16:41:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263792AbTKKVl4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Nov 2003 16:41:56 -0500
Received: from mail1-106.ewetel.de ([212.6.122.106]:18820 "EHLO
	mail1.ewetel.de") by vger.kernel.org with ESMTP id S263785AbTKKVlw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Nov 2003 16:41:52 -0500
Date: Tue, 11 Nov 2003 22:41:41 +0100 (CET)
From: Pascal Schmidt <der.eremit@email.de>
To: Linus Torvalds <torvalds@osdl.org>
cc: Jens Axboe <axboe@suse.de>, <linux-kernel@vger.kernel.org>
Subject: Re: 2.9test9-mm1 and DAO ATAPI cd-burning corrupt
In-Reply-To: <Pine.LNX.4.44.0311110950250.30657-100000@home.osdl.org>
Message-ID: <Pine.LNX.4.44.0311112227100.1011-100000@neptune.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-CheckCompat: OK
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Nov 2003, Linus Torvalds wrote:

> 	# Write it out
> 	dd if=testfile of=/dev/hdc bs=4096 count=1

dd behaves strangly on the MO drive. I've tried with 2.6.0-test9 and
the patch appended to the end of this mail.

# dd if=testfile of=/dev/hde bs=4096 count=1
dd: writing `/dev/hde': no space left on device
1+0 records in
0+0 records out

# dd if=/dev/hde of=mofile bs=4096 count=1
0+0 records in
0+0 records out

Mounting the disc read-only works, however, and I can read all the data
on it without problems.

Mounting read-write yields the same old problem:

# mount -t ext2 /dev/hde /mnt/mo
# echo "bar" > /mnt/mo/foo
# umount /mnt/mo

kernel BUG at fs/buffer.c:2658!
invalid operand: 0000 [#1]
CPU:    0
EIP:    0060:[<c014e11c>]    Not tainted
EFLAGS: 00010202
EIP is at submit_bh+0x15c/0x180
eax: 00000010   ebx: e5365360   ecx: c0332b74   edx: e7fe2a40
esi: 00000001   edi: c0334ca0   ebp: e5ad9ecc   esp: e5ad9ebc
ds: 007b   es: 007b   ss: 0068
Process umount (pid: 918, threadinfo=e5ad8000 task=e6134d00)
Stack: c0334ca0 e5ad9ed8 e5c2d400 e5365360 e5ad9eec c014e22e 00000001 e5365360 
       c014c0d3 c15e6708 e5c2d400 e72d3b80 e5ad9f00 c0191faf e5365360 e72d3b80 
       e6f1e40c e5ad9f20 c0190fdd e72d3b80 e5c2d400 e72d3b80 e72d3b80 e72d3bcc 
Call Trace:
 [<c014e22e>] sync_dirty_buffer+0x5e/0xc0
 [<c014c0d3>] mark_buffer_dirty+0x33/0x50
 [<c0191faf>] ext2_sync_super+0x4f/0x60
 [<c0190fdd>] ext2_put_super+0x9d/0xb0
 [<c014f858>] generic_shutdown_super+0xf8/0x110
 [<c01500fd>] kill_block_super+0x1d/0x50
 [<c014f6c4>] deactivate_super+0x44/0x70
 [<c016269c>] sys_umount+0x3c/0xa0
 [<c0162719>] sys_oldumount+0x19/0x20
 [<c010addf>] syscall_call+0x7/0xb

Code: 0f 0b 62 0a a6 c7 2f c0 e9 c1 fe ff ff 0f 0b 61 0a a6 c7 2f 

After that, the MO is dead, "reboot" doesn't do anything, and all that
I can do is press the reset button or use Alt-SysRq-B. Trying to sync
with SysRq-S or remount r/o with SysRq-U don't work anymore at this
point.

Rebooted into 2.4/ide-scsi and ran e2fsck. The directory entry made it
to disk, nothing else.

Rebooted into 2.6/ide-scsi. Mounting read-only once again works 
flawlessly. Mounted read-write, then wrote a small file as above. Tried
to umount. umount sat there in D state for about half a minute, then 
ide-scsi aborted the operation and an ATAPI reset took place. After that, 
umount completed. Again mounting it read-only confirmed that the file made 
it to disk correctly.

Then I tried "e2fsck -f /dev/sda". This hung the machine almost
immediately. Even Alt-SysRq stopped working. Going back to 2.4 and
running e2fsck there shows that the filesystem on the MO is clean, and
a forced fsck doesn't find anything suspicious.
 
>> I didn't see problems with using ide-scsi/sd for that drive in 2.5.7x,
>> by the way, so I'm not so sure ide-scsi is really broken for that
>> purpose.
> It would be interesting to hear if ide-scsi works. 

See above, it doesn't.


--- drivers/cdrom/cdrom.c.orig	Tue Nov 11 22:21:25 2003
+++ drivers/cdrom/cdrom.c	Tue Nov 11 21:49:19 2003
@@ -426,7 +426,8 @@
 	if ((fp->f_flags & O_NONBLOCK) && (cdi->options & CDO_USE_FFLAGS))
 		ret = cdi->ops->open(cdi, 1);
 	else {
-		if ((fp->f_mode & FMODE_WRITE) && !CDROM_CAN(CDC_DVD_RAM))
+		if ((fp->f_mode & FMODE_WRITE) &&
+			!(CDROM_CAN(CDC_DVD_RAM) || CDROM_CAN(CDC_MO_DRIVE)))
 			return -EROFS;
 
 		ret = open_for_data(cdi);
--- drivers/ide/ide-cd.c.orig	Tue Nov 11 22:21:38 2003
+++ drivers/ide/ide-cd.c	Tue Nov 11 21:26:11 2003
@@ -3211,7 +3211,8 @@
 
 	nslots = ide_cdrom_probe_capabilities (drive);
 
-	if (CDROM_CONFIG_FLAGS(drive)->dvd_ram)
+	if (CDROM_CONFIG_FLAGS(drive)->dvd_ram
+		|| CDROM_CONFIG_FLAGS(drive)->mo_drive)
 		set_disk_ro(drive->disk, 0);
 
 #if 0


-- 
Ciao,
Pascal

