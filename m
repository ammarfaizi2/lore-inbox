Return-Path: <linux-kernel-owner+w=401wt.eu-S1161005AbXALG5F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161005AbXALG5F (ORCPT <rfc822;w@1wt.eu>);
	Fri, 12 Jan 2007 01:57:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161004AbXALG5F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Jan 2007 01:57:05 -0500
Received: from mail.ggsys.net ([69.26.161.131]:56960 "EHLO mail.ggsys.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161010AbXALG5E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Jan 2007 01:57:04 -0500
Subject: Re: Ext3 mounted as ext2 but journal still in effect.
From: Alberto Alonso <alberto@ggsys.net>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20070111212545.efd5d8c5.akpm@osdl.org>
References: <1168578496.9707.6.camel@w100>
	 <20070111212545.efd5d8c5.akpm@osdl.org>
Content-Type: text/plain
Organization: Global Gate Systems LLC.
Date: Fri, 12 Jan 2007 00:57:01 -0600
Message-Id: <1168585021.9707.25.camel@w100>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You were right, even after making the changes, it seems to be 
telling lies:

# mount
/dev/hda2 on / type ext2 (rw,usrquota)
[...]

However, I think I am still not mounting as ext2:

# dmesg | grep 'Kernel command'
Kernel command line: ro root=/dev/hda2 rootfstype=ext2

# cat /proc/mounts
rootfs / rootfs rw 0 0
/dev/root / ext3 rw 0 0
/proc /proc proc rw,nodiratime 0 0
/sys /sys sysfs rw 0 0
none /dev/pts devpts rw 0 0
usbfs /proc/bus/usb usbfs rw 0 0
/dev/hda1 /boot ext2 rw 0 0
none /dev/shm tmpfs rw,noexec 0 0
none /proc/sys/fs/binfmt_misc binfmt_misc rw 0 0
sunrpc /var/lib/nfs/rpc_pipefs rpc_pipefs rw 0 0

Do I need to mess with the initrd? My grub lines look like
this:

title Fedora Core (2.6.5-1.358smp)
        root (hd0,0)
        kernel /vmlinuz-2.6.5-1.358smp ro root=/dev/hda2 rootfstype=ext2
        initrd /initrd-2.6.5-1.358smp.img
title Fedora Core-up (2.6.5-1.358)
        root (hd0,0)
        kernel /vmlinuz-2.6.5-1.358 ro root=/dev/hda2 rootfstype=ext2
        initrd /initrd-2.6.5-1.358.img


Thanks,

Alberto


On Thu, 2007-01-11 at 21:25 -0800, Andrew Morton wrote:
> On Thu, 11 Jan 2007 23:08:16 -0600
> Alberto Alonso <alberto@ggsys.net> wrote:
> 
> > I have an ext3 filesystem that has been having problems
> > with its journal. The result is that the file system
> > remounts internally as read-only and the server becomes
> > unusable, even shutdown does not work, using up 100% of
> > the CPU but not rebooting.
> > 
> > I found some postings indicating that mounting it as
> > ext2 should fix the problem, as it doesn't appear to be
> > a hardware issue.
> > 
> > So, I decided to mount everything as ext2. Mount shows this:
> > 
> > # mount
> > /dev/hda2 on / type ext2 (rw,usrquota)
> > none on /proc type proc (rw)
> > none on /sys type sysfs (rw)
> > none on /dev/pts type devpts (rw,gid=5,mode=620)
> > usbfs on /proc/bus/usb type usbfs (rw)
> > /dev/hda1 on /boot type ext2 (rw)
> > none on /dev/shm type tmpfs (rw,noexec)
> > none on /proc/sys/fs/binfmt_misc type binfmt_misc (rw)
> > sunrpc on /var/lib/nfs/rpc_pipefs type rpc_pipefs (rw)
> > 
> > But now I still get the error:
> > 
> > # dmesg
> > [...]
> > EXT3-fs error (device hda2) in start_transaction: Journal has aborted
> > EXT3-fs error (device hda2) in start_transaction: Journal has aborted
> > EXT3-fs error (device hda2) in start_transaction: Journal has aborted
> > EXT3-fs error (device hda2) in start_transaction: Journal has aborted
> > [...]
> > 
> > 
> > The kernel is:
> > 
> > # uname -a
> > Linux hyperweb.net 2.6.5-1.358smp #1 SMP Sat May 8 09:25:36 EDT 2004
> > i686 i686 i386 GNU/Linux
> > 
> > 
> > Any ideas?
> > 
> 
> mount(8) tells lies.  Look in /proc/mounts and you'll see that it's really
> mounted as ext3.
> 
> You probably want to add `rootfstype=ext2' to the kernel boot command line.
> 
-- 
Alberto Alonso                        Global Gate Systems LLC.
(512) 351-7233                        http://www.ggsys.net
Hardware, consulting, sysadmin, monitoring and remote backups

