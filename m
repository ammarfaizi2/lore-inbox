Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267033AbSLDT1K>; Wed, 4 Dec 2002 14:27:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267034AbSLDT1K>; Wed, 4 Dec 2002 14:27:10 -0500
Received: from packet.digeo.com ([12.110.80.53]:46570 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S267033AbSLDT1I>;
	Wed, 4 Dec 2002 14:27:08 -0500
Message-ID: <3DEE58CB.737259DB@digeo.com>
Date: Wed, 04 Dec 2002 11:34:35 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.20aa1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Ravikiran G Thirumalai <kiran@in.ibm.com>
CC: linux-kernel@vger.kernel.org, Rusty Russell <rusty@rustcorp.com.au>,
       dipankar@in.ibm.com
Subject: Re: [patch] kmalloc_percpu  -- 2 of 2
References: <20021204174209.A17375@in.ibm.com> <20021204174550.B17375@in.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 04 Dec 2002 19:34:35.0098 (UTC) FILETIME=[2D08CBA0:01C29BCC]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ravikiran G Thirumalai wrote:
> 
> Here's a 2.5.50 version of kmalloc_percpu originally submitted by Dipankar.


> +/* Use these with kmalloc_percpu */
> +#define get_cpu_ptr(ptr) per_cpu_ptr(ptr, get_cpu())
> +#define put_cpu_ptr(ptr) put_cpu()

These names sound very much like get_cpu_var() and put_cpu_var(),
yet they are using a quite different subsystem.  It would be good
to choose something more distinct.  Not that I can think of anything
at present ;)

The commentary above these functions should clearly state that thou
shalt not sleep between them.

> ...
> --- linux-2.5.50/kernel/Makefile        Thu Nov 28 04:05:51 2002
> +++ kmalloc_percpu-2.5.50/kernel/Makefile       Sun Dec  1 11:54:49 2002
> @@ -4,7 +4,7 @@
> 
>  export-objs = signal.o sys.o kmod.o workqueue.o ksyms.o pm.o exec_domain.o \
>                 printk.o platform.o suspend.o dma.o module.o cpufreq.o \
> -               profile.o rcupdate.o intermodule.o
> +               profile.o rcupdate.o intermodule.o percpu.o

I suppose so.  It _could_ be in mm/percpu.c


> ...
> +static int data_blklist_count =
> +    sizeof (data_blklist) / sizeof (struct percpu_data_blklist);

The ARRAY_SIZE macro is suitable here.

> +static struct percpu_data_blk *
> +percpu_data_blk_alloc(struct percpu_data_blklist *blklist, int flags)
> ...
> +static void
> +percpu_data_blk_free(struct percpu_data_blk *blkp)
> ...
> +static int
> +percpu_data_mem_grow(struct percpu_data_blklist *blklist, int flags)
> ...
> +static void __init
> +percpu_data_blklist_init(struct percpu_data_blklist *blklist)
> ...
> +static struct percpu_data_blklist *
> +percpu_data_get_blklist(size_t size, int flags)
> ...
> +static int
> +__percpu_interlaced_alloc_one(struct percpu_data_blklist *blklist,
> +                             struct percpu_data_blk *blkp)
> ...
> +static int
> +__percpu_interlaced_alloc(struct percpu_data *percpu,
> +                         struct percpu_data_blklist *blklist, int flags)
> ...
> +static int
> +percpu_interlaced_alloc(struct percpu_data *pdata, size_t size, int flags)
> ...
> +static void
> +percpu_data_blk_destroy(struct percpu_data_blklist *blklist,
> +                       struct percpu_data_blk *blkp)
> ...
> +static void
> +__percpu_interlaced_free(struct percpu_data_blklist *blklist,
> +                        struct percpu_data *percpu)
> ...
> +static void
> +percpu_interlaced_free(struct percpu_data *percpu)
> ...

ummm.  What on earth is all that stuff?

> +void *
> +kmalloc_percpu(size_t size, int flags)
> +{
> +       int i;
> +       struct percpu_data *pdata = kmalloc(sizeof (*pdata), flags);
> +
> +       if (!pdata)
> +               goto out_done;
> +       pdata->blkp = NULL;
> +       if (size <= (malloc_sizes[0].cs_size >> 1)) {
> +               if (!percpu_interlaced_alloc(pdata, size, flags))
> +                       goto out;
> +       } else {
> +               for (i = 0; i < NR_CPUS; i++) {
> +                       if (!cpu_possible(i))
> +                               continue;
> +                       pdata->ptrs[i] = kmalloc(size, flags);
> +                       if (!pdata->ptrs[i])
> +                               goto unwind_oom;
> +               }
> +       }
> +       /* Catch derefs w/o wrappers */
> +       return (void *) (~(unsigned long) pdata);
> +
> +unwind_oom:
> +       while (--i >= 0) {
> +               if (!cpu_possible(i))
> +                       continue;
> +               kfree(pdata->ptrs[i]);
> +       }
> +out:
> +       kfree(pdata);
> +out_done:
> +       return NULL;
> +}

If we were to remove the percpu_interlaced_alloc() leg here, we'd
have a nice, simple per-cpu kmalloc implementation.

Could you please explain what all the other code is there for?
