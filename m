Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262257AbVFWPD0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262257AbVFWPD0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 11:03:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262383AbVFWPD0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 11:03:26 -0400
Received: from mta10.adelphia.net ([68.168.78.202]:27871 "EHLO
	mta10.adelphia.net") by vger.kernel.org with ESMTP id S262257AbVFWPDX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 11:03:23 -0400
Message-ID: <12745583.1119539003004.JavaMail.root@web10.mail.adelphia.net>
Date: Thu, 23 Jun 2005 11:03:22 -0400
From: <cspalletta@adelphia.net>
To: linux-kernel@vger.kernel.org
Subject: namespace question
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
Sensitivity: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I don't believe the following to be an error, but I am curious how it occurs:

Running a kernel module which uses d_path iteratively over the mnt_mountpoint members of the vfsmount structures which hang off of current->namespace->list, I get a curious doubling of the mount point names:

rootfs / rootfs
/dev2/root2 / ext3
proc /proc/proc proc
sysfs /sys/sys sysfs
devpts /dev/pts/dev/pts devpts
tmpfs /dev/shm/dev/shm tmpfs
/dev/hda1 /boot/boot ext2
usbfs /proc/bus/usb/bus/usb usbfs

Is there any simple explanation? I have cross-checked and it appears _not_ be be an artifact of my programming, and I have no CLONE_NEWNS processes. Using the same algorithm with mnt_root produces correct results.  

The code follows:

        char *path;
...
        namespace = current-> namespace
        down_read(&namespace->sem);
        list_for_each_entry(vfsmnt_ptr,&namespace->list,mnt_list) {
                mount = mntget(vfsmnt_ptr);
                dentry = dget(vfsmnt_ptr->mnt_mountpoint);

                device = vfsmnt_ptr->mnt_devname ? vfsmnt_ptr->mnt_devname : "none";

                path = d_path(dentry, mount, buf, PAGE_SIZE);
                error = PTR_ERR(path);
                if(IS_ERR(path)) {
                        dput(dentry);
                        mntput(mount);
                        goto out;
                }

                fstype = vfsmnt_ptr->mnt_sb->s_type->name;
                printk("%s\t%s\t%s\n",device,path,fstype);
---

$ uname -a
Linux nectarsys 2.6.10-1-k7 #1 Fri Mar 11 03:13:32 EST 2005 i686 GNU/Linux




