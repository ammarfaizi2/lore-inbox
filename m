Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265230AbTAAXuT>; Wed, 1 Jan 2003 18:50:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265236AbTAAXuT>; Wed, 1 Jan 2003 18:50:19 -0500
Received: from carisma.slowglass.com ([195.224.96.167]:46091 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S265230AbTAAXuS>; Wed, 1 Jan 2003 18:50:18 -0500
Date: Wed, 1 Jan 2003 23:58:42 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] more procfs bits for !CONFIG_MMU
Message-ID: <20030101235842.A3044@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Linus Torvalds <torvalds@transmeta.com>,
	Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org
References: <20030102000522.A6137@lst.de> <Pine.LNX.4.44.0301011539070.12809-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0301011539070.12809-100000@home.transmeta.com>; from torvalds@transmeta.com on Wed, Jan 01, 2003 at 03:43:05PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 01, 2003 at 03:43:05PM -0800, Linus Torvalds wrote:
> 
> On Thu, 2 Jan 2003, Christoph Hellwig wrote:
> >
> > To avoid ifdef hell I extented the task_foo() abstraction already
> > present in array.c a bit and the actual implementations now live
> > in task_mmu.c and task_nommu.c.
> 
> Please do "proc_mmu.c" and "proc_nommu.c", and move the non-task-related 
> parts there too (ie move "pid_maps_read()" there too, and just make the 
> no-mmu version of it be empty or whatever, ok?)

I can add an empty stub function, but that doesn't help to reduce the
ifdef mess as there is no /proc/<pid>/maps on nommu at all so we don't
have the struct file_operations and more important can't register it.

Maybe I need to make adding new entries for /proc/<pid>/ dynamic so
proc_mmu.c can just call

	create_proc_pid_entry("stats", &proc_maps_operations, ...)

> > --- 1.4/fs/proc/Makefile	Sat Dec 14 07:38:56 2002
> > +++ edited/fs/proc/Makefile	Wed Jan  1 13:45:28 2003
> > @@ -9,6 +9,12 @@
> >  proc-objs    := inode.o root.o base.o generic.o array.o \
> >  		kmsg.o proc_tty.o proc_misc.o kcore.o
> >  
> > +ifeq ($(CONFIG_MMU),y)
> > +proc-objs    += task_mmu.o
> > +else
> > +proc-objs    += task_nommu.o
> > +endif
> 
> Isn't it much nicer to just write this something like
> 
> 	proc-mmu-y = proc_mmu.o
> 	proc-mmu-n = proc_nommu.o
> 
> 	obj-y += $(proc-mmu-$(CONFIG_MMU))
> 
> instead, and avoid conditionals?

Could be done.  Maybe Kai even has an even nicer generic version? :)
The new makefiles really need some docs..

