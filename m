Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285229AbSA2Waf>; Tue, 29 Jan 2002 17:30:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285093AbSA2WaT>; Tue, 29 Jan 2002 17:30:19 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:30981 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S284902AbSA2W2z>;
	Tue, 29 Jan 2002 17:28:55 -0500
Message-ID: <3C57207E.28598C1F@zip.com.au>
Date: Tue, 29 Jan 2002 14:21:50 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18-pre7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Rusty Russell <rusty@rustcorp.com.au>
CC: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: [PATCH] per-cpu areas for 2.5.3-pre6
In-Reply-To: Your message of "Tue, 29 Jan 2002 01:22:30 -0800."
	             <3C5669D6.B81E0B4@zip.com.au> <E16VgRZ-0007Kf-00@wagner.rustcorp.com.au>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty Russell wrote:
> 
> In message <3C5669D6.B81E0B4@zip.com.au> you write:
> > Rusty Russell wrote:
> > >
> > > This patch introduces the __per_cpu_data tag for data, and the
> > > per_cpu() & this_cpu() macros to go with it.
> > >
> > > This allows us to get rid of all those special case structures
> > > springing up all over the place for CPU-local data.
> >
> > Am I missing something? smp_init() is called quite late in
> > the boot process, and if any code touches per-cpu data before
> > this, it'll get a null pointer deref, won't it?
> 
> Yes.  But for a large amount of code it doesn't matter, and most
> architectures don't know how many CPUs there are before smp_init().
> Of course, we could make it NR_CPUS...

I don't think there's a need.  You can use .data.percpu directly
for the boot CPU, dynamically allocate storage for the others.
This actually saves one CPU's worth of memory :)

> Do you have an example where you want to use this before
> smp_boot_cpus()?  If so, we can bite the bullet.  Otherwise I'd prefer
> not to waste memory.

Well, the slab allocator uses per-CPU data, so with the current patch,
slab.c wouldn't be able to use per_cpu().

But if you use:

 unsigned long __per_cpu_offset[NR_CPUS] = { (unsigned long *)&__per_cpu_start, };

Then each CPU has, at all times, a valid personal __per_cpu_offset[]
entry.   The only restriction is that the boot CPU cannot
touch other CPU's per-cpu data before those CPUs are brought
up.

-
