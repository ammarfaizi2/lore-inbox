Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316997AbSFKKxs>; Tue, 11 Jun 2002 06:53:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316999AbSFKKxr>; Tue, 11 Jun 2002 06:53:47 -0400
Received: from mole.bio.cam.ac.uk ([131.111.36.9]:57426 "EHLO
	mole.bio.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S316997AbSFKKxr>; Tue, 11 Jun 2002 06:53:47 -0400
Message-Id: <5.1.0.14.2.20020611114701.00aefec0@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Tue, 11 Jun 2002 11:57:26 +0100
To: Rusty Russell <rusty@rustcorp.com.au>
From: Anton Altaparmakov <aia21@cantab.net>
Subject: Re: [PATCH] 2.5.21 Nonlinear CPU support
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org,
        k-suganuma@mvj.biglobe.ne.jp, Andrew Morton <akpm@zip.com.au>
In-Reply-To: <3D05A9E8.FF0DA223@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 08:42 11/06/02, Andrew Morton wrote:
>Rusty Russell wrote:
> >
> > Linus, please apply.  Tested on my dual x86 box.
> >
> > This patch removes smp_num_cpus, cpu_number_map and cpu_logical_map
> > from generic code, and uses cpu_online(cpu) instead, in preparation
> > for hotplug CPUS.
>
>umm.  This patch does introduce a non-zero amount of bloat:
>
> > ...
> > -       ntfs_compression_buffers =  (u8**)kmalloc(smp_num_cpus * 
> sizeof(u8*),
> > +       ntfs_compression_buffers =  (u8**)kmalloc(NR_CPUS * sizeof(u8*),

This is crazy! It means you are allocating 2MiB of memory instead of just 
128kiB on a 2 CPU system, which will be about 99% of the SMP systems in 
use, at my guess. So your change is throwing away 1920kiB of kernel ram for 
no reason at all. And that is just ntfs...

CPU hot plugging is an extremely specialised corner case so can you please 
make it a config option and not get rid of smp_num_cpus? If people enable 
the option make smp_num_cpus be the same as NR_CPUS and if not leave it be 
as it is now.

Anything else penalizes the majority of users just to allow a tiny minority 
to do strange things like swap cpus without rebooting...

Anton



-- 
   "I've not lost my mind. It's backed up on tape somewhere." - Unknown
-- 
Anton Altaparmakov <aia21 at cantab.net> (replace at with @)
Linux NTFS Maintainer / IRC: #ntfs on irc.openprojects.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/

