Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752005AbWFLOF4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752005AbWFLOF4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 10:05:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752004AbWFLOF4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 10:05:56 -0400
Received: from 62-99-178-133.static.adsl-line.inode.at ([62.99.178.133]:143
	"HELO office-m.at") by vger.kernel.org with SMTP id S1752005AbWFLOFz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 10:05:55 -0400
Mime-Version: 1.0 (Apple Message framework v750)
Content-Transfer-Encoding: 7bit
Message-Id: <0CB396BB-A11B-4191-982F-8C0B89F848D6@office-m.at>
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
To: linux-kernel@vger.kernel.org
From: Markus Biermaier <mbier@office-m.at>
Subject: Can't Mount CF-Card on boot of 2.6.15 Kernel on EPIA - VFS: Cannot open root device
Date: Mon, 12 Jun 2006 16:05:51 +0200
X-Mailer: Apple Mail (2.750)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

I use an EPIA MII6000E motherboard with CF-Card as hard-drive.
Since this device can't boot from CF-Card I boot from network via  
PXELINUX.
Works fine for kernel 2.4.25.

Now I want to change to kernel 2.6.15.4.

I boot an initrd, execute "linuxrc" and at this point I can mount the  
CF-Card as "hde1", inspect the file-system, ...

As soon as I finish "linuxrc" the root-fs should be mounted but the  
kernel panics with:

   VFS: Cannot open root device "hde1" or unknown-block(0,0)
   Please append a correct "root=" boot option
   Kernel panic - not syncinc: VFS: Unable to mount root fs on  
unknown-block(0,0)

"/tftpboot/pxelinux.cfg/Cxxxxxx":
------------------------- [ BEGIN Cxxxxxx ] -------------------------
DEFAULT standard
LABEL standard
KERNEL vmlinuz
APPEND initrd=initrd ramdisk_size=32768 root=/dev/hde1 acpi=off udev
------------------------- [ END   Cxxxxxx ] -------------------------

I tried:
------------------------- [ BEGIN linuxrc ] -------------------------
   ...
   mount /dev/hde1
   umount /proc
   umount /sys
   cd /mnt
   /mnt/sbin/pivot_root . initrd
   mount /sys /sys -t sysfs
   /sbin/udevstart
   /sbin/pcmcia-socket-startup
   mount /proc
   echo -n "42" > /sys/bus/pcmcia/devices/1.0/allow_func_id_match
   echo 0x3301 > /proc/sys/kernel/real-root-dev
   sleep 5
   exec <dev/console >dev/console 2>&1
   exec chroot . /bin/sh <<EOF
        umount initrd
        /sbin/blockdev --flushbufs /dev/ram0
        sleep 3
        exec /sbin/init 5
   EOF
------------------------- [ END   linuxrc ] -------------------------

I found that the root-fs is mounted twice. First as initial-RAM-Disk.  
Works ok.
Second as "real" root. With "printk" I found that in file "init/ 
do_mounts.c"
...
int err = do_mount_root(name, p, flags, root_mount_data);
...
The value of "name" is "/dev/root" before this statement.
After this "err" is -6 ("No such device or address").

BTW: When I have the line
   echo 0x3301 > /proc/sys/kernel/real-root-dev
in "linuxrc" the panic message
   "VFS: Unable to mount root fs on unknown-block(0,0)"
becomes
   "VFS: Unable to mount root fs on unknown-block(51,1)"

Any ideas?

Markus
  
