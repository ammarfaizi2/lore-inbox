Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265050AbUEYTPS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265050AbUEYTPS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 May 2004 15:15:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265051AbUEYTPR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 May 2004 15:15:17 -0400
Received: from chaos.analogic.com ([204.178.40.224]:4480 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S265050AbUEYTPB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 May 2004 15:15:01 -0400
Date: Tue, 25 May 2004 15:14:26 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Olaf Hering <olh@suse.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: very low performance on SCSI disks if device node is in tmpfs
In-Reply-To: <20040525184732.GB26661@suse.de>
Message-ID: <Pine.LNX.4.53.0405251457450.582@chaos>
References: <20040525184732.GB26661@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 May 2004, Olaf Hering wrote:

>
> Any ideas why the location of the device node makes such a big
> difference? I always wondered why my firewire is so dog slow with 2.6.
> Now I know the reason: /dev is in tmpfs.
> I dont see that with IDE disks, only with SCSI.
>
> (none):/# /sbin/hdparm -tT /dev/sdb
>
> /dev/sdb:
>  Timing buffer-cache reads:   2532 MB in  2.00 seconds = 1264.93 MB/sec
>  Timing buffered disk reads:   48 MB in  3.12 seconds =  15.41 MB/sec
> (none):/# /sbin/hdparm -tT /tmp/sdb
>
> /tmp/sdb:
>  Timing buffer-cache reads:   2328 MB in  2.00 seconds = 1163.01 MB/sec
>  Timing buffered disk reads:   82 MB in  3.03 seconds =  27.03 MB/sec
>
> This happens also with 2.6.1-mm kernels. I attach the profile with
> devnode in tmpfs and on disk.
>
> --
> USB is for mice, FireWire is for men!
>

You are not actually reading or writing from the 'device'-files.
They are just a trick to associate a major/minor number with
a device. After that initial open, the fd is the handle by which
the device is accessed, not the device-files. Given this, it
doesn't make any difference if the device-file is generated
dynamically as in devfs or statically with `mknod`. Unless you
have a bench mark program that does:

             do {
		open();
		write();
		close();
		open();
		read();
		close();
                } while(forever);

If that's what the program does, it's probably not a good example
to be used as a bench-mark. If the program does that, and you
want to optimize for that, then the way a read is handled (for the
open in devfs), would need to be optimized to use non-paged memory
because it is possible, in principle, to have to page in the contents
of devfs for each access. Right now, kmalloc(GFP_KERNEL) is being
used and that's pagable.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.26 on an i686 machine (5570.56 BogoMips).
            Note 96.31% of all statistics are fiction.


