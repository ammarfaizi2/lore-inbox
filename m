Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319069AbSHFLSF>; Tue, 6 Aug 2002 07:18:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319072AbSHFLSF>; Tue, 6 Aug 2002 07:18:05 -0400
Received: from mta06ps.bigpond.com ([144.135.25.138]:41682 "EHLO
	mta06ps.bigpond.com") by vger.kernel.org with ESMTP
	id <S319069AbSHFLSE>; Tue, 6 Aug 2002 07:18:04 -0400
From: Brad Hards <bhards@bigpond.net.au>
To: linux-kernel@vger.kernel.org
Subject: Filesystem (re)mount confusion
Date: Tue, 6 Aug 2002 21:16:32 +1000
User-Agent: KMail/1.4.5
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8bit
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200208062116.41165.bhards@bigpond.net.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

A (sort-of-) bug report was filed on linux-usb-users, about a kernel log 
message:
<quote>
when I mount usbfs using
mount -t usbfs -o devmode=0666 none /proc/bus/usb
an error message is logged in /var/log/syslog as:
usbdevfs: remount parameter error
</quote>

A bit of investigation shows that 
1. the usbdevfs filesystem "remount" operation [usb/inode.c::usbdevfs_remount()]
is being called twice. The data parameter is "devmode=0666" the first
time, and "devmode" the second time.
2. The remount succeeds the first time, and failes (-EINVAL) the second time.
The failure is in the options parser (usb/inode.c::parse_options()), which
is expecting a value for this option.
3. mount(1) is calling mount(2) only one time, and this looks OK.

I am not sure I understand how the mount system call gets to the
usb filesystem.

I vaguely remember Rusty's lecture where "asmlinkage" was important
for system calls, so I guess that fs/namespace.c::sys_mount() is the entry 
point. The option looks good at this point (data == "devmode=0666).
- From there, I lose it. 

A bit of random printk() insertion shows that do_remount_sb() is being
called with the option statement set to "devmode" (so it is broken
when we get here). [This is in fs/super.c ]

So I guess my questions are:
1. Is there some documentation I should have read before trying to UTSL?
2. Why does a single mount(2) operation result in two calls to the remount
operation for the filesystem?
3. And if anyone is feeling generous, can I have a broad brush view
of how the mount syscall relates to the filesystem implementation?

Brad
- -- 
http://conf.linux.org.au. 22-25Jan2003. Perth, Australia. Birds in Black.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE9T7AVW6pHgIdAuOMRAqpiAJ0QObHv1gkCe+dKhKt9AGfbnR9c1QCfaKpS
z64ZPidVieAR1H3pn8vG/Rg=
=DWDj
-----END PGP SIGNATURE-----

