Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267098AbSLKJ5j>; Wed, 11 Dec 2002 04:57:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267099AbSLKJ5j>; Wed, 11 Dec 2002 04:57:39 -0500
Received: from hermine.idb.hist.no ([158.38.50.15]:4870 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S267098AbSLKJ5i>; Wed, 11 Dec 2002 04:57:38 -0500
Message-ID: <3DF70CA8.CC553446@aitel.hist.no>
Date: Wed, 11 Dec 2002 11:00:08 +0100
From: Helge Hafting <helgehaf@aitel.hist.no>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.5.51 i686)
X-Accept-Language: no, en, en
MIME-Version: 1.0
To: ebuddington@wesleyan.edu, linux-kernel@vger.kernel.org
Subject: Re: 2.5.51 won't boot with devfs enabled
References: <20021210111835.A92@ma-northadams1b-112.bur.adelphia.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric Buddington wrote:
> 
> With 2.5.51 (gcc-3.2, Athlon, mostly modules, DEVFS=y, DEVFS_DEBUG=y),
> boot panics with "VFS: Cannot open root device "hda1" or
> 03:01".
> 
> I had the same problem with 2.5.50, avoidable by disabling devfs entirely.
> 
> -Eric
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

Booting anything later than 2.5.48 with devfs configured
either needs an extra kernel parameter, or a code change.  
Something broke when do_mounts.c were reorganized.
It doesn't matter wether devfs is used or not, as long as it
is configured.  

The lilo solution:
lilo tend to have a "root=/dev/hda1" or similiar.
This gets converted to "root=0301" on the kernel command line.
(Look at dmesg after a successful boot)

But this don't work for some reason when devfs is configured.
Use the following:

append="root=/dev/hda1"

to solve the problem.  This isn't converted to numbers and works.
Of course if you use auto-mounted devfs then you don't
have a /dev/hda1 but a /dev/ide/host0/bus0/target0/lun0/part1
instead.  If so, use that as root instead. You still have
to use the append= trick.

The code solution:
Edit init/do_mounts.c
Remove the following lines from the beginning of
the function prepare_namespace:
#ifdef CONFIG_DEVFS_FS
        sys_mount("devfs", "/dev", "devfs", 0, NULL);
        do_devfs = 1;
#endif
Then recompile, and the kernel should work with any lilo setup that
worked for 2.5.47 and earlier.  At least it worked for the setups
I tried.

This has no effect on kernels without devfs, and helps for kernels
comiled with devfs wether devfs is used or not.
I posted a patch for this, but there were no interest at all.


Helge Hafting
