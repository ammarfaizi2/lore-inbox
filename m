Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265211AbTAAXj4>; Wed, 1 Jan 2003 18:39:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265222AbTAAXj4>; Wed, 1 Jan 2003 18:39:56 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:50695 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S265211AbTAAXjz>; Wed, 1 Jan 2003 18:39:55 -0500
Date: Wed, 1 Jan 2003 15:43:05 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Christoph Hellwig <hch@lst.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] more procfs bits for !CONFIG_MMU
In-Reply-To: <20030102000522.A6137@lst.de>
Message-ID: <Pine.LNX.4.44.0301011539070.12809-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 2 Jan 2003, Christoph Hellwig wrote:
>
> To avoid ifdef hell I extented the task_foo() abstraction already
> present in array.c a bit and the actual implementations now live
> in task_mmu.c and task_nommu.c.

Please do "proc_mmu.c" and "proc_nommu.c", and move the non-task-related 
parts there too (ie move "pid_maps_read()" there too, and just make the 
no-mmu version of it be empty or whatever, ok?)

That should get rid of the last CONFIG_MMU #ifdef stuff.

Also:

> --- 1.4/fs/proc/Makefile	Sat Dec 14 07:38:56 2002
> +++ edited/fs/proc/Makefile	Wed Jan  1 13:45:28 2003
> @@ -9,6 +9,12 @@
>  proc-objs    := inode.o root.o base.o generic.o array.o \
>  		kmsg.o proc_tty.o proc_misc.o kcore.o
>  
> +ifeq ($(CONFIG_MMU),y)
> +proc-objs    += task_mmu.o
> +else
> +proc-objs    += task_nommu.o
> +endif

Isn't it much nicer to just write this something like

	proc-mmu-y = proc_mmu.o
	proc-mmu-n = proc_nommu.o

	obj-y += $(proc-mmu-$(CONFIG_MMU))

instead, and avoid conditionals?

		Linus

