Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319165AbSH2KTu>; Thu, 29 Aug 2002 06:19:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319167AbSH2KTu>; Thu, 29 Aug 2002 06:19:50 -0400
Received: from kim.it.uu.se ([130.238.12.178]:26019 "EHLO kim.it.uu.se")
	by vger.kernel.org with ESMTP id <S319165AbSH2KTt>;
	Thu, 29 Aug 2002 06:19:49 -0400
From: Mikael Pettersson <mikpe@csd.uu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15725.63043.601068.257742@kim.it.uu.se>
Date: Thu, 29 Aug 2002 12:24:03 +0200
To: "Mikolaj J. Habryn" <dichro-evo@rcpt.to>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.32 floppy init and misc fixes
In-Reply-To: <1030609060.3529.6.camel@orthos>
References: <1030609060.3529.6.camel@orthos>
X-Mailer: VM 6.90 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mikolaj J. Habryn writes:
 > The floppy driver doesn't clean up it's register_sys_device if it fails
 > to init correctly. The below patch adds the appropriate
 > unregister_sys_device in the various failure paths, and also includes
 > Ewan MacMahon's one-liner for working VCs on devfs-only machines, and a
 > couple of missing #includes. Minimum required to get 2.5.32 working on
 > my Portege.
...
 > --- linux-2.5.32/drivers/block/floppy.c.orig	2002-08-29 16:17:30.000000000 +1000
 > +++ linux-2.5.32/drivers/block/floppy.c	2002-08-29 16:19:20.000000000 +1000
 > @@ -4235,6 +4235,7 @@
 >  	devfs_handle = devfs_mk_dir (NULL, "floppy", NULL);
 >  	if (register_blkdev(MAJOR_NR,"fd",&floppy_fops)) {
 >  		printk("Unable to get major %d for floppy\n",MAJOR_NR);
 > +		unregister_sys_device(&device_floppy);
 >  		return -EBUSY;
 >  	}
 >  
etc.

Floppy has many more problems.
Repeadedly loading and unloading the floppy.o module corrupts
sys_device data structures.
Writing to floppy can give ENOSPC errors even though space exists.
Writing to floppy can OOPS the kernel due to a NULL pointer error.
VFS-over-floppy corrupts data since 2.5.13.
Putting lilo on ext2 on floppy can cause a kernel hang due to an
infinite loop of "buffer layer error".

I have a patch which fixes the {,un}register_sys_device() bugs, NULL
queue bug, zero i_size bug, and fixes read/write enough that raw media
access (e.g. tar or dd to/from /dev/fd0) works. It's in the 2.5-dj tree,
and separately in <http://www.csd.uu.se/~mikpe/linux/patches/2.5/>.

I havent' pushed this to Linus since it's meaningless as long as
the VFS data corruption exists. It was broken by blkdev/VFS changes,
but those responsible haven't yet bothered to repair it.

/Mikael
