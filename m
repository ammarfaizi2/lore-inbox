Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268060AbUHFOal@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268060AbUHFOal (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Aug 2004 10:30:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268067AbUHFOal
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Aug 2004 10:30:41 -0400
Received: from ihemail1.lucent.com ([192.11.222.161]:63619 "EHLO
	ihemail1.lucent.com") by vger.kernel.org with ESMTP id S268060AbUHFOag
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Aug 2004 10:30:36 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16659.38405.356084.360627@gargle.gargle.HOWL>
Date: Fri, 6 Aug 2004 10:30:29 -0400
From: "John Stoffel" <stoffel@lucent.com>
To: Harald Arnesen <harald@skogtun.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.8-rc2-bk13 and later: Read-only filesystem on USB
In-Reply-To: <87n01944xd.fsf@basilikum.skogtun.org>
References: <87n01944xd.fsf@basilikum.skogtun.org>
X-Mailer: VM 7.14 under Emacs 20.6.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Harald> When I try to copy a file to my DataBar <www.data-bar.com>
Harald> mounted at /mnt/cf under 2.6.8-rc-2-bk13 or 2.6.8-rc3, I get
Harald> the error "cp: cannon stat `/mnt/cf/testfile': Permission
Harald> denied". Same thing with a CF card in an USB adapter.

There is a change in the FAT or VFAT filesystem.  If you don't specify
a default codepage in the mount command, the filesystem gets mounted
RO.   I'm annoyed by this change since the error isn't propogated
properly back to user space.  I ran into it this morning when trying
to move images from a CF card to my disk.

Here's what I'm doing on a 2.6.8-rc3 system:

    # mount /dev/sdd1 /mnt/s30

Good, no errors.  

    # mount
    /dev/sda2 on / type unknown (rw,errors=remount-ro)
    proc on /proc type proc (rw)
    sysfs on /sys type sysfs (rw)
    devpts on /dev/pts type devpts (rw,gid=5,mode=620)
    tmpfs on /dev/shm type tmpfs (rw)
    usbfs on /proc/bus/usb type usbfs (rw)
    /dev/sda5 on /var type ext3 (rw)
    /dev/sda1 on /boot type ext3 (rw)
    /dev/sda6 on /usr type ext3 (rw)
    /dev/mapper/data_vg-home_lv on /home type ext3 (rw)
    /dev/mapper/data_vg-local_lv on /local type ext3 (rw)
    /dev/sdd1 on /mnt/s30 type msdos (rw)

And it looks like it mounted properly too.

    # touch /mnt/s30/foo
    touch: cannot touch `/mnt/s30/foo': Read-only file system

BOOM!  Fall down and smack my face.  Ok, so now I try to mount it
explicity as vfat, not the default msdos:

    # umount /mnt/s30
    # mount -t vfat /dev/sdd1 /mnt/s30
    # mount
    /dev/sda2 on / type unknown (rw,errors=remount-ro)
    proc on /proc type proc (rw)
    sysfs on /sys type sysfs (rw)
    devpts on /dev/pts type devpts (rw,gid=5,mode=620)
    tmpfs on /dev/shm type tmpfs (rw)
    usbfs on /proc/bus/usb type usbfs (rw)
    /dev/sda5 on /var type ext3 (rw)
    /dev/sda1 on /boot type ext3 (rw)
    /dev/sda6 on /usr type ext3 (rw)
    /dev/mapper/data_vg-home_lv on /home type ext3 (rw)
    /dev/mapper/data_vg-local_lv on /local type ext3 (rw)
    /dev/sdd1 on /mnt/s30 type vfat (rw)

    # touch /mnt/s30/foo
    touch: cannot touch `/mnt/s30/foo': Read-only file system

BOOM!  Still broken, but still reporting as good in mount.  WTF?  Next
attempt:

    # mount -t vfat -o codepage=437 /dev/sdd1 /mnt/s30
    # touch /mnt/s30/foo
    touch: cannot touch `/mnt/s30/foo': Read-only file system

Now WTF is happening?  

    # mount
    /dev/sda2 on / type unknown (rw,errors=remount-ro)
    proc on /proc type proc (rw)
    sysfs on /sys type sysfs (rw)
    devpts on /dev/pts type devpts (rw,gid=5,mode=620)
    tmpfs on /dev/shm type tmpfs (rw)
    usbfs on /proc/bus/usb type usbfs (rw)
    /dev/sda5 on /var type ext3 (rw)
    /dev/sda1 on /boot type ext3 (rw)
    /dev/sda6 on /usr type ext3 (rw)
    /dev/mapper/data_vg-home_lv on /home type ext3 (rw)
    /dev/mapper/data_vg-local_lv on /local type ext3 (rw)
    /dev/sdd1 on /mnt/s30 type vfat (rw,codepage=437)

Stupid tools.... next attempt:

    # mount -o codepage=437 /dev/sdd1 /mnt/s30
    # mount
    /dev/sda2 on / type unknown (rw,errors=remount-ro)
    proc on /proc type proc (rw)
    sysfs on /sys type sysfs (rw)
    devpts on /dev/pts type devpts (rw,gid=5,mode=620)
    tmpfs on /dev/shm type tmpfs (rw)
    usbfs on /proc/bus/usb type usbfs (rw)
    /dev/sda5 on /var type ext3 (rw)
    /dev/sda1 on /boot type ext3 (rw)
    /dev/sda6 on /usr type ext3 (rw)
    /dev/mapper/data_vg-home_lv on /home type ext3 (rw)
    /dev/mapper/data_vg-local_lv on /local type ext3 (rw)
    /dev/sdd1 on /mnt/s30 type msdos (rw,codepage=437)
    # touch /mnt/s30/foo
    # ls -l /mnt/s30/foo
    -rwxr--r--  1 root root 0 Aug  6 10:27 /mnt/s30/foo

Finally, the damm thing is mounted RW and actually lets me write
something to the goddamm thing.  

What a pain in the ass.  This change should be reverted until it's
properly implemented to tell mount(8) that it's not mounted RW, but RO
instead.

John
   John Stoffel - Senior Unix Systems Administrator - Lucent Technologies
	 stoffel@lucent.com - http://www.lucent.com - 978-952-7548
