Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263647AbTJaWbo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Oct 2003 17:31:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263653AbTJaWbo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Oct 2003 17:31:44 -0500
Received: from smtp.mailix.net ([216.148.213.132]:45255 "EHLO smtp.mailix.net")
	by vger.kernel.org with ESMTP id S263647AbTJaWbl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Oct 2003 17:31:41 -0500
Date: Fri, 31 Oct 2003 23:31:39 +0100
From: Alex Riesen <fork0@users.sf.net>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Matthew Dharm <mdharm-usb@one-eyed-alien.net>,
       Greg Kroah-Hartman <greg@kroah.com>
Subject: 2.6.0-test9: lilo tried to access just umounted medium
Message-ID: <20031031223139.GA1059@steel.home>
Reply-To: Alex Riesen <fork0@users.sf.net>
Mail-Followup-To: Alex Riesen <fork0@users.sf.net>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Matthew Dharm <mdharm-usb@one-eyed-alien.net>,
	Greg Kroah-Hartman <greg@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.6.0-test9 + bk of 31 Oct.

Do not know, it may be a lilo (22.5.7.2, from gentoo) bug...

I had a flash card mounted (usb reader, 6-in-1 thing, uhci).
Looked over the pics on it, unmounted and removed the card.

Edited lilo.conf, and called lilo:

~ lilo
Reading boot sector from /dev/hda2
Warning: Kernel & BIOS return differing head/sector geometries for device 0x80
    Kernel: 65535 cylinders, 16 heads, 63 sectors
      BIOS: 1024 cylinders, 255 heads, 63 sectors
Fatal: open /dev/sdb: No medium found

sdb is the CF-card:

SCSI device sdb: 63489 512-byte hdwr sectors (33 MB)
sdb: Write Protect is off
sdb: Mode Sense: 00 00 00 00
sdb: assuming drive cache: write through
SCSI device sdb: 63489 512-byte hdwr sectors (33 MB)
sdb: Write Protect is off
sdb: Mode Sense: 00 00 00 00
sdb: assuming drive cache: write through
 sdb: sdb1

Next attempt to run lilo was successful. I can reproduce the problem.
I did not notice this before (in test6, for instance).

strace:

write(1, "Warning: Kernel & BIOS return di"..., 79) = 79
write(1, "    Kernel: 65535 cylinders, 16 "..., 50) = 50
write(1, "      BIOS: 1024 cylinders, 255 "..., 50) = 50
open("/dev/hda1", O_RDONLY)             = 7
read(7, "\353<\220MSWIN4.1\0\2 \1\0\2\0\2\0\0\370\277\0?\0\377\0"..., 512) = 512
close(7)                                = 0
stat64("/dev/hda2", {st_mode=S_IFBLK|0660, st_rdev=makedev(3, 2), ...}) = 0
open("/dev/hda2", O_RDONLY)             = 7
read(7, "\372\353 \1\265\1LILO\26\5A\334\242?\0\0\0\0Y\221\335<"..., 512) = 512
close(7)                                = 0
stat64("/dev/hda3", {st_mode=S_IFBLK|0660, st_rdev=makedev(3, 3), ...}) = 0
open("/dev/hda3", O_RDONLY)             = 7
read(7, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 512) = 512
close(7)                                = 0
stat64("/dev/hda4", {st_mode=S_IFBLK|0660, st_rdev=makedev(3, 4), ...}) = 0
open("/dev/hda4", O_RDONLY)             = 7
read(7, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 512) = 512
close(7)                                = 0
stat64("/dev/hda5", {st_mode=S_IFBLK|0660, st_rdev=makedev(3, 5), ...}) = 0
stat64("/dev/hda6", {st_mode=S_IFBLK|0660, st_rdev=makedev(3, 6), ...}) = 0
stat64("/dev/hda7", {st_mode=S_IFBLK|0660, st_rdev=makedev(3, 7), ...}) = 0
stat64("/dev/hda8", {st_mode=S_IFBLK|0660, st_rdev=makedev(3, 8), ...}) = 0
stat64("/dev/hda9", {st_mode=S_IFBLK|0660, st_rdev=makedev(3, 9), ...}) = 0
stat64("/dev/hda10", {st_mode=S_IFBLK|0660, st_rdev=makedev(3, 10), ...}) = 0
stat64("/dev/hda11", {st_mode=S_IFBLK|0660, st_rdev=makedev(3, 11), ...}) = 0
stat64("/dev/hda12", {st_mode=S_IFBLK|0660, st_rdev=makedev(3, 12), ...}) = 0
stat64("/dev/sdb", {st_mode=S_IFBLK|0660, st_rdev=makedev(8, 16), ...}) = 0
stat64("/dev/sdb1", {st_mode=S_IFBLK|0660, st_rdev=makedev(8, 17), ...}) = 0
open("/dev/sdb", O_RDONLY)              = -1 ENOMEDIUM (No medium found)
write(1, "Fatal: open /dev/sdb: No medium "..., 38) = 38
sync()                                  = 0
munmap(0x40016000, 4096)                = 0
_exit(1)                                = ?

There are several suspicious things:
 - why it tries to probe for /dev/sdb (yes, the mass storage driver
   recognizes all slots in the reader at load, but the card was already
   removed!)
 - why probing for /dev/sdb is so special so it terminates (it is not
   mentioned anywhere in lilo.conf)
 - why it enumerates devices at all (there are boot= and root= options in
   lilo.conf). Well, this is more a question for lilo maintainers...


