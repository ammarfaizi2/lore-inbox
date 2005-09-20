Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932730AbVITRNf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932730AbVITRNf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 13:13:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932722AbVITRNf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 13:13:35 -0400
Received: from smtp3-g19.free.fr ([212.27.42.29]:7130 "EHLO smtp3-g19.free.fr")
	by vger.kernel.org with ESMTP id S932752AbVITRNe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 13:13:34 -0400
Message-ID: <1847.192.168.201.6.1127236405.squirrel@pc300>
Date: Tue, 20 Sep 2005 18:13:25 +0100 (BST)
From: "Etienne Lorrain" <etienne.lorrain@masroudeau.com>
To: linux-kernel@vger.kernel.org
Reply-To: etienne.lorrain@masroudeau.com
User-Agent: SquirrelMail/1.4.5
MIME-Version: 1.0
X-Priority: 3 (Normal)
Importance: Normal
X-SA-Exim-Connect-IP: 192.168.2.240
X-SA-Exim-Mail-From: etienne.lorrain@masroudeau.com
Subject: Re: [i386 BOOT CODE] kernel bootable again
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on cygne.masroudeau.com)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>> So if the "something" knows (or can get to know) the sector/tracks
>>>> layout of the disk it's writing the kernel onto, it could store this
>>>> information in the bootblock (is there space for that?). The bootblock
>>>> code would then just read this info and use it.
>
> Actually, DOS/Windows works that way. FAT filesystem stores the number
> of sectors per track in its boot sector.

  Gujin installer creates the filesystem (and the partition table if
 needed), the MBR with the disk geometry, and chain a simple bootloader
 or a menu based bootloader on the created FAT filesystem when told to
 do so.

  So if you just want to put a kernel and initrd on a floppy, and the
 floppy is big enough, you just do:
$ mkdir tmp
$ cd tmp
$ wget http://heanet.dl.sourceforge.net/sourceforge/gujin/install-1.2.tar.gz
$ tar xvzf install-1.2.tar.gz
$ ./instboot tiny.bin /dev/fd0
$ mcopy /boot/vmlinuz-2.6.13 a:
$ mcopy /boot/initrd-2.6.13 a:
  And you reboot with the floppy still inside the drive.

  If you want to put them on your USB thumb drive, and your PC can
 boot USB flash drives as a floppy (lot of BIOS bugs there), you
 just change the line (double check that your USB key is /dev/sda):
$ ./instboot tiny.bin /dev/fd0
  by:
$ ./instboot tiny.bin /dev/sda --disk=BIOS:0x00 --geometry=/dev/sda

  I personnally better like a partition table on my USB drives, so
 I am more used to erase manually the partition table:
$ dd if=/dev/null of=/dev/sda bs=512 count=64 # blank the head of the disk
 and then type:
$ ./instboot boot.bin /dev/sda --disk=BIOS:0x00 --geometry=/dev/sda \
     --mbr-device=/dev/sda --partition_index=1

  When booted from this key, the PC will boot the kernel named vmlinuz*
 and load the initrd/initramfs named initrd* (tiny.bin does not contain
 the graphic menu management).

  I will not say that I tested it lately, but you may also want to put
 your kernel and initrd on a bootable CDROM - without having the usual
 Gujin menu - then you just do:
$ mkdir tmpdir
$ cp /boot/vmlinuz-2.6.13 tmpdir
$ cp /boot/initrd-2.6.13 tmpdir
$ ./instboot tiny.bin tmpdir/tiny.bcd
$ mkisofs -untranslated-filenames -no-emul-boot -boot-load-size 4 \
    -b tiny.bcd tmpdir -o boot.iso
$ cdrecord boot.iso

  It is usually better (and will work for all those configuration)
 to put the kernel and its initrd inside a directory named "/boot",
 but I am highjicking a thread so want to keep it simple...

  Etienne.

