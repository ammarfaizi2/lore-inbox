Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129965AbRBBS1a>; Fri, 2 Feb 2001 13:27:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129978AbRBBS1U>; Fri, 2 Feb 2001 13:27:20 -0500
Received: from [204.244.205.8] ([204.244.205.8]:63474 "HELO mail.wizard.ca")
	by vger.kernel.org with SMTP id <S129976AbRBBS1M>;
	Fri, 2 Feb 2001 13:27:12 -0500
Date: Fri, 2 Feb 2001 10:27:29 -0800
From: Rob Bos <rbos@wizard.ca>
To: linux-kernel@vger.kernel.org
Subject: loopback driver hardlocking machine
Message-ID: <20010202102729.A364@tech.wizard.ca>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="FL5UXtIhxfXey3p5"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Organisation: Wizard Internet/LinuxMagic
X-Uptime: 10:17am  up 7 min,  2 users,  load average: 0.00, 0.13, 0.09
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--FL5UXtIhxfXey3p5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


Good day;

I have been having consistent trouble with the last several kernels; all the
test[9-12], 2.4.0 (all patched with reiser) and the 2.4.1 kernel (unpatched)
seem to do this for me.  I have devfs enabled as well, but this seems to happen
with or without devfs.  I don't believe it happened when I was running 2.2.18.

bug description and reproducability:

On copying to a loopback-mounted Minix filesystem, my machine seems to hardlock;
it happens after the copy, and seems to happen most often when the disk is
being heavily accessed for other purposes before that.  The loopback filesystem
has resided on both ext2 and reiser filesystems, with no change in frequency of
crashes.  Beyond that it is not reproducible; I have a couple of scripts that
trigger this bug approximately one every five iterations - the machine is 
unable to write any more data to disk, unable to flush buffers, and after 
approximately thirty seconds, seems to hardlock, not accepting any input from
any location (ICMP/IP, mouse, keyboard).

The scripts that trigger this (makeinitrd.sh and makediskimage.sh, which both
utilize mount-copy-unmount; it freezes right after copying all files) are
attached, if that might help.

I did in fact look through the bug-reporting document and the maintainers list,
but did not find anyone who would be specifically concerned with this bug; I
suppose the VFS maintainer might be interested, but I'm not sure if this is
a loopback thing, a Minix thing, a reiserfs thing, a VFS thing, et al, so here
you go.

I am available at this email address for further information about my
configuration.

-- 
Rob Bos - System Administration
Wizard Internet Services - http://www.wizard.ca http://linuxmagic.com
Unix Administration, Website Hosting
Network Services, Programming
--------------------------------------------
(604) 589-0037 Beautiful British Columbia, Canada
--------------------------------------------
Any and all opinions expressed herein are not necessarily
the opinions of Wizard Internet Services.

--FL5UXtIhxfXey3p5
Content-Type: application/x-sh
Content-Disposition: attachment; filename="makediskimage.sh"

#!/bin/bash
# Creates new ramdisk image from ./initrd/* and puts it in disk/initrd.gz
sync
filename=vpn-`cat VERSION`.img
if [ -d initrd ] && [ -d disk ] && [ -d mnt ]; then
	echo -n creating new blank disk image..
	dd if=/dev/zero of=$filename bs=1k count=1440 > /dev/null 2>/dev/null
	echo done

	echo -n formatting blank disk image..
	mkfs.msdos $filename > /dev/null
	echo done

	echo -n mounting disk image..
	mount -o loop $filename mnt
	mount | grep loop | sed s/^.*type//

	echo -n copying root filesystem over..  
	cp -a disk/* mnt
	# Intermittently crashes while doing copy.
	sync
	echo done
	
	echo -n checking disk usage..
	size=`du -s mnt | cut -f1`
	echo $size kilobytes

	echo -n unmounting disk image..
	umount mnt; mount | grep loop && echo existing loops detected.
	echo done

	echo -n syslinux -sf $filename..
	syslinux -sf $filename
	echo done

else
	echo Directories missing.  mnt, initrd, disk.  Not in correct directory?
	exit 0
fi

--FL5UXtIhxfXey3p5
Content-Type: application/x-sh
Content-Disposition: attachment; filename="makeinitrd.sh"

#!/bin/bash
# Creates new ramdisk image from ./initrd/* and puts it in disk/initrd.gz
sync
if [ -d initrd ] && [ -d disk ] && [ -d mnt ]; then
	echo -n creating new ramdisk..
	dd if=/dev/zero of=disk/initrd bs=1k count=4096 > /dev/null 2>/dev/null
	echo done

	echo -n formatting new ramdisk..
	mkfs.minix disk/initrd > /dev/null
	#mkfs.minix disk/initrd
	echo done

	echo -n mounting ramdisk..
	mount -o loop disk/initrd mnt
	mount | grep loop | sed s/^.*type//

	echo -n copying root filesystem over..  
	cp -a initrd/* mnt
	# Intermittently crashes while finishing copy.
	sync
	echo done

	echo -n unmounting ramdisk..
	umount mnt; mount | grep loop && echo existing loops detected.
	echo done

	echo -n gzipping initrd..
	gzip -f -9 disk/initrd;
	sync
	echo done
else
	echo Directories missing.  mnt, initrd, disk.  Not in correct directory?
	exit 0
fi

--FL5UXtIhxfXey3p5--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
