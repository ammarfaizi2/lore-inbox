Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316848AbSFKHjS>; Tue, 11 Jun 2002 03:39:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316884AbSFKHjR>; Tue, 11 Jun 2002 03:39:17 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:34570 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S316848AbSFKHjP>;
	Tue, 11 Jun 2002 03:39:15 -0400
Message-ID: <3D05A9E8.FF0DA223@zip.com.au>
Date: Tue, 11 Jun 2002 00:42:32 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Rusty Russell <rusty@rustcorp.com.au>
CC: torvalds@transmeta.com, linux-kernel@vger.kernel.org,
        k-suganuma@mvj.biglobe.ne.jp
Subject: Re: [PATCH] 2.5.21 Nonlinear CPU support
In-Reply-To: <E17Hflq-0005Hf-00@wagner.rustcorp.com.au>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty Russell wrote:
> 
> Linus, please apply.  Tested on my dual x86 box.
> 
> This patch removes smp_num_cpus, cpu_number_map and cpu_logical_map
> from generic code, and uses cpu_online(cpu) instead, in preparation
> for hotplug CPUS.

umm.  This patch does introduce a non-zero amount of bloat:
 
> ...
> -       ntfs_compression_buffers =  (u8**)kmalloc(smp_num_cpus * sizeof(u8*),
> +       ntfs_compression_buffers =  (u8**)kmalloc(NR_CPUS * sizeof(u8*),

and slowdown:

> ...
> --- linux-2.5.21.24110/kernel/sched.c   Mon Jun 10 16:03:56 2002
> +++ linux-2.5.21.24110.updated/kernel/sched.c   Tue Jun 11 13:53:32 2002
> ...
> @@ -530,15 +530,16 @@
> 
>         busiest = NULL;
>         max_load = 1;
> -       for (i = 0; i < smp_num_cpus; i++) {
> -               int logical = cpu_logical_map(i);
> +       for (i = 0; i < NR_CPUS; i++) {
> +               if (!cpu_online(i))
> +                       continue;
> 

and for the majority of SMP machines it gives nothing back, yes?

Is there some way of optimising all that?


-
