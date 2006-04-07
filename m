Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751253AbWDGKZr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751253AbWDGKZr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Apr 2006 06:25:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751336AbWDGKZr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Apr 2006 06:25:47 -0400
Received: from mail.bmlv.gv.at ([193.171.152.37]:20123 "EHLO mail.bmlv.gv.at")
	by vger.kernel.org with ESMTP id S1751253AbWDGKZq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Apr 2006 06:25:46 -0400
From: "Ph. Marek" <philipp.marek@bmlv.gv.at>
To: linux-kernel@vger.kernel.org
Subject: Problem substituting /proc/mounts for recovery
Date: Fri, 7 Apr 2006 12:24:31 +0200
User-Agent: KMail/1.9.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604071224.31851.philipp.marek@bmlv.gv.at>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello everybody!

During recovery I'm running off a chroot (booted via knoppix); 
I'm trying to fake a mount table, so that the output of mount 
and df can be correctly parsed by the boot loader installation 
(in the chroot the "df -k /boot" returns no device).

But that is nowadays (2.6.14-1-686-smp (Debian 2.6.14-2)) a problem, 
since /proc/mounts is a symlink.


Observe:
        # cat /proc/mounts > /tmp/mymounts
        # vi /tmp/mymounts
        # mount --bind /tmp/mymounts /proc/mounts
        # ls -la /proc/mounts
        lrwxrwxrwx 1 root root 11 2006-04-07 12:13 /proc/mounts -> self/mounts
        # mount
        ...
        /tmp/mymounts on /proc/17496/mounts type none (rw,bind)
        # ls -la /proc/17496
        ls: /proc/17496: Datei oder Verzeichnis nicht gefunden
        # umount /proc/17496/mounts
        umount: /tmp/mymounts: not mounted
        umount: /proc/17496/mounts: not found
        umount: /tmp/mymounts: not mounted
        umount: /proc/17496/mounts: not found
        # umount /tmp/mymounts
        umount: /tmp/mymounts: not mounted

It seems not to be a simple userspace problem:
	# strace -e umount umount -f /proc/17496/mounts
	umount("/proc/17496/mounts", MNT_FORCE) = -1 ENOENT (No such file or directory)
	umount2: Datei oder Verzeichnis nicht gefunden
	umount: /proc/17496/mounts: not found


So the following questions come to my mind:
- Is that a kernel bug, ie. the dentry of /proc/17496/mounts is not 
  kept in memory for releasing? (along with /proc/17496)
- Should the mount be automatically release if there's no 
  possible user left?
- Should "mount --bind" not follow symlinks, but replace them? That's 
  what I'd need here, to fake the mount table.
- Is there a better way to achieve that?

Also I remember that /proc/mounts was filtered in older kernel versions, 
ie. mounts not visible in the chroot would not be shown. Maybe that would 
be enough to solve my problem of device detection.


Kernel version:
	# cat /proc/version
	Linux version 2.6.14-1-686-smp (Debian 2.6.14-2) (horms@debian.org) (gcc version 4.0.3 20051023 (prerelease) (Debian 4.0.2-3)) #1 SMP Tue Nov 1 16:06:13 JST 2005



Please keep me CC'd, as I'm not subscribed.

Thank you for all answers!


Regards,

Phil
