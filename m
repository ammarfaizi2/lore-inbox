Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282056AbRLHLrh>; Sat, 8 Dec 2001 06:47:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282082AbRLHLr2>; Sat, 8 Dec 2001 06:47:28 -0500
Received: from ezri.xs4all.nl ([194.109.253.9]:34264 "HELO ezri.xs4all.nl")
	by vger.kernel.org with SMTP id <S282056AbRLHLrH>;
	Sat, 8 Dec 2001 06:47:07 -0500
Date: Sat, 8 Dec 2001 12:47:05 +0100 (CET)
From: Eric Lammerts <eric@lammerts.org>
To: Pete Zaitcev <zaitcev@redhat.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Would the father of init_mem_lth please stand up
In-Reply-To: <20011207234048.A31442@devserv.devel.redhat.com>
Message-ID: <Pine.LNX.4.43.0112081240080.7546-100000@ally.lammerts.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 7 Dec 2001, Pete Zaitcev wrote:
> drivers/scsi/sd.c:sd_init()
>
>         /* allocate memory */
> #define init_mem_lth(x,n)       x = kmalloc((n) * sizeof(*x), GFP_ATOMIC)
> #define zero_mem_lth(x,n)       memset(x, 0, (n) * sizeof(*x))
>
>         init_mem_lth(rscsi_disks, sd_template.dev_max);
>         init_mem_lth(sd_sizes, maxparts);
>         init_mem_lth(sd_blocksizes, maxparts);
>         init_mem_lth(sd, maxparts);
>         init_mem_lth(sd_gendisks, N_USED_SD_MAJORS);
>         init_mem_lth(sd_max_sectors, sd_template.dev_max << 4);
>
>         if (!rscsi_disks || !sd_sizes || !sd_blocksizes || !sd || !sd_gendisks)
>                 goto cleanup_mem;
> #undef init_mem_lth
> #undef zero_mem_lth
> .....................
> cleanup_mem:
>         kfree(sd_gendisks);
>         kfree(sd);
>         kfree(sd_blocksizes);
>         kfree(sd_sizes);
>         kfree(rscsi_disks);
>
>
> However, it's not only about the puking and keyboard cleanups.
> The code is buggy as well. Scenario:
>
>  0. User inserts a large number of FC-AL adapters with 56 disks each
>  1. modprobe sd_mod
>     No SCSI hosts, sd_init() is NOT called.
>  2. modprobe qla_something
>     sd_init is called and fails on sd_gendisks. modprobe fails.
>     sd_sizes, sd_blocksizes, etc. are LEFT DANGLING
>  3. modprobe qla_something
>     sd_init is called and fails on sd_sizes.
>     kfree is called with a bunch of dangling pointers

I agree it's ugly, but why would kfree be called on dangling pointers?
All those pointers are initialized again on every sd_init() call. And
there are no "goto cleanup_mem"s between the kmallocs.

Eric

