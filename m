Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1760206AbWLEWNU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760206AbWLEWNU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Dec 2006 17:13:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759822AbWLEWNU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Dec 2006 17:13:20 -0500
Received: from twin.jikos.cz ([213.151.79.26]:37411 "EHLO twin.jikos.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759191AbWLEWNT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Dec 2006 17:13:19 -0500
Date: Tue, 5 Dec 2006 23:13:08 +0100 (CET)
From: Jiri Kosina <jikos@jikos.cz>
To: Neil Brown <neilb@suse.de>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.19-rc6-mm2
In-Reply-To: <Pine.LNX.4.64.0612050844110.28502@twin.jikos.cz>
Message-ID: <Pine.LNX.4.64.0612052305490.28502@twin.jikos.cz>
References: <20061128020246.47e481eb.akpm@osdl.org>
 <Pine.LNX.4.64.0611290147400.28502@twin.jikos.cz> <17780.52337.767875.963882@cse.unsw.edu.au>
 <17780.61551.896455.157225@cse.unsw.edu.au> <Pine.LNX.4.64.0612050844110.28502@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Dec 2006, Jiri Kosina wrote:

> It seemed to be 100% reproducible - happened on every boot of FC6 
> system, so it was probably triggered by some raid/lvm command executed 
> from init scripts after boot, but I didn't examine it further. As soon 
> as I get to the machine where this happens, I will try to narrow it down 
> to the exact userspace command that triggers it and will let you know 
> (probably this evening).

OK, so more details follow (I am not sure how valuable they are, though). 
The command that triggers the BUG is located quite at the beginning of FC6 
/etc/rc.d/rc.sysinit, and it's this

[ -x /sbin/nash ] && echo "raidautorun /dev/md0" | nash --quiet

just after this, the BUG I sent you occurs, and nash is killed on SIGSEGV 
(this command is executed before any other initialization of 
DM/LVM/mapper/whatever happens). strace shows

[ ... ] (boring part stripped)
read(0, "raidautorun /dev/md0\n", 16384) = 21
read(0, "", 16384)                      = 0
access("/usr/bin/raidautorun", X_OK)    = -1 ENOENT (No such file or directory)
access("/bin/raidautorun", X_OK)        = -1 ENOENT (No such file or directory)
access("/sbin/raidautorun", X_OK)       = -1 ENOENT (No such file or directory)
access("/usr/sbin/raidautorun", X_OK)   = -1 ENOENT (No such file or directory)
access("raidautorun", X_OK)             = -1 ENOENT (No such file or directory)
access("/dev/md0", F_OK)                = -1 ENOENT (No such file or directory)
access("", F_OK)                        = -1 ENOENT (No such file or directory)
mkdir("", 0755)                         = -1 ENOENT (No such file or directory)
access("/dev", F_OK)                    = 0
mknod("/dev/md0", S_IFBLK|0600, makedev(9, 0)) = 0
open("/dev/md0", O_RDWR <unfinished ...>
+++ killed by SIGSEGV +++

(at this time, udev is already started). Compared to this command, being 
run later on already booted system, after all the mdadm, mknod 
/dev/mapper/*,etc. stuff has been done). 

[ ... ]
2732  access("/dev", F_OK)              = 0
2732  mknod("/dev/md0", S_IFBLK|0600, makedev(9, 0)) = 0
2732  open("/dev/md0", O_RDWR)          = 3
2732  fcntl64(3, F_GETFD)               = 0
2732  fcntl64(3, F_SETFD, FD_CLOEXEC)   = 0
2732  ioctl(3, 0x914, 0)                = 0
2732  close(3)                          = 0
2732  exit_group(0)                     = ?

(and this doesn't trigger the BUG).

-- 
Jiri Kosina
