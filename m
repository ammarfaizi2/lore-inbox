Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262195AbREXSkL>; Thu, 24 May 2001 14:40:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262197AbREXSkB>; Thu, 24 May 2001 14:40:01 -0400
Received: from voyager.powersurfr.com ([24.109.67.8]:25615 "EHLO
	unity.starfire") by vger.kernel.org with ESMTP id <S262195AbREXSjt>;
	Thu, 24 May 2001 14:39:49 -0400
From: Maciek Nowacki <maciek@Voyager.powersurfr.com>
Date: Thu, 24 May 2001 12:39:43 -0600
To: linux-kernel@vger.kernel.org
Subject: Re: Busy on BLKFLSBUF w/initrd
Message-ID: <20010524123943.A797@wintermute.starfire>
In-Reply-To: <20010523154843.A32583@Voyager.powersurfr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
In-Reply-To: <20010523154843.A32583@Voyager.powersurfr.com>; from maciek on Wed, May 23, 2001 at 03:48:43PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Problem seems to be solved. Here is what I did, for anyone who is interested
in using a loopback file on a local disk as root:

- create a romfs initrd with /linuxrc -> /bin/sh and an empty /initrd dir

- boot, with root=/dev/rd/1 init=/bin/sh

- when /linuxrc comes up, cat /dev/rd/0 > /dev/rd/1

- CTRL-D, exit, etc. to invoke change_root -> /dev/rd/1

- umount /initrd/dev and /initrd

- load modules needed for boot.. ext2, ide, loopback, crypto, and sticky
order-dependent things (in my case, uhci MUST precede eepro100)

- mount -n -t tmpfs none /tmp

- copy needed things to /tmp like /bin, /sbin, /lib (not modules, unless
memory isn't a problem)

- mount -n -t devfs none /tmp/dev

- cd /tmp ; pivot_root . old_root ; chroot bin/sh ...

- now we are chrooted into bin/sh on a tmpfs root

- umount old_root/dev ; umount old_root

- mount real filesystem - mount host on /mnt, loopback on /real_root

- finally chroot into real_root/sbin/init

- once system is running, clear out unneeded files in tmpfs, unmount the
  devfs - memory usage goes to almost nothing (tmpfs is still needed since
  the host for the loopback lives there)

- blockdev --flushbufs /dev/rd/*

(note, I have glossed over some details. /proc is needed in several steps,
and must be unmounted and remounted and so on..)

After running for a while and filling up memory, buffers has gone down far
below the size of the ramdisk, and trying to mount /dev/rd/0 and /dev/rd/1
shows that they are no longer valid filesystems.

This method depends on the change_root() mechanism which I had assumed is
becoming obsolete. It works, and there is no need to mess with
/proc/sys/kernel/real_root_dev if the root is specified on the command line.
Trying to use only pivot_root did not work as /dev/rd/0 could never be
flushed (see previous messages in this thread).

Thanks very much to everyone who helped!

Maciek
