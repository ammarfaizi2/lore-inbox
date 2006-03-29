Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750921AbWC2Uil@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750921AbWC2Uil (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Mar 2006 15:38:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750914AbWC2Uil
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Mar 2006 15:38:41 -0500
Received: from e32.co.us.ibm.com ([32.97.110.150]:63432 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750839AbWC2Uil
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Mar 2006 15:38:41 -0500
Subject: Re: [Ext2-devel] [PATCH 2/2] ext2/3: Support2^32-1blocks(e2fsprogs)
From: Mingming Cao <cmm@us.ibm.com>
Reply-To: cmm@us.ibm.com
To: Ravikiran G Thirumalai <kiran@scalex86.org>
Cc: Laurent Vivier <Laurent.Vivier@bull.net>, Andrew Morton <akpm@osdl.org>,
       Takashi Sato <sho@tnes.nec.co.jp>,
       Badari Pulavarty <pbadari@us.ibm.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20060329200020.GA3729@localhost.localdomain>
References: <20060325223358sho@rifu.tnes.nec.co.jp>
	 <1143485147.3970.23.camel@dyn9047017067.beaverton.ibm.com>
	 <20060327131049.2c6a5413.akpm@osdl.org>
	 <20060327225847.GC3756@localhost.localdomain>
	 <1143530126.11560.6.camel@openx2.frec.bull.fr>
	 <1143568905.3935.13.camel@dyn9047017067.beaverton.ibm.com>
	 <1143623605.5046.11.camel@openx2.frec.bull.fr>
	 <1143657317.4045.12.camel@dyn9047017067.beaverton.ibm.com>
	 <20060329200020.GA3729@localhost.localdomain>
Content-Type: text/plain
Organization: IBM LTC
Date: Wed, 29 Mar 2006 12:38:37 -0800
Message-Id: <1143664718.4045.76.camel@dyn9047017067.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-03-29 at 12:00 -0800, Ravikiran G Thirumalai wrote:
> On Wed, Mar 29, 2006 at 10:35:10AM -0800, Mingming Cao wrote:
> > On Wed, 2006-03-29 at 11:13 +0200, Laurent Vivier wrote:
> > > 
> > > You're right, Mingming.
> > > 
> > > But I think instead of thinking to change "long" by "long long" we
> > > should think about changing "long" by "unsigned long" in the per-cpu
> > > counter structure.
> > > 
> > > Is there someone knowing why this counter is signed ?
> > 
> > I am wondering the same thing asked by Laurent. Initially I thought the
> > signed value is there to prevent overflow, or to maintain a "int" type
> > counters. Are those the intentions, kiran?
> 
> I don't know if the local counter version values can be unsigned in this
> case.  Consider a case like this with the initial counter value to be 0,
> and FBC_BATCH is 32 (8cpusx4)
> 
> cpu 1				cpu 2			cpu 3
> --------			-------			--------
> add(10)
> //local = 10 fbc = 0.
> 				sub(5)
> 				//local = -5 fbc = 0
> 							add(31)
> 							//local = 31 fbc = 0
> 
> 				sub(30)
> 				//local = 0 fbc = -35
> 				--------------->(A)
> 
> Now if the local counters were unsigned, and the global counters unsigned
> too, counter read at A would result in a large value, which would mislead
> the app. 

I was thinking to change the global count to "unsigned long", but we
still need to use signed value (long) for the per cpu counters(local
counter), as they are relative values and could be negative.

Something like this:

struct percpu_counter {
        spinlock_t lock;
-       long count;
+	unsigned long count;
        long *counters;
};

This works for ext2/3, as the global value always initialized to some
positive value (e.g. the # of free blocks when the filesystem is
created). But I am concerned the current other two users of percpu
counters(nr_files in VFS and memory_allocated in network code), where
the global value could be initilized to 0, and will have the issue that
you just described.


>  Maybe it doesn't matter if we use percpu_counter_exceeds at
> critical places, so these get caught, but that would mean going on all cpus
> more often than before..and that would also mean weird values when we just
> use percpu_counter_read to print these counters.
> 
Wild suggestion, how about we don't update the global counter is the
result is negative?
 
> So maybe using long long is a simpler solution here? Andrew, thoughts?
> 
> > 
> > But it seems the per cpu counters used in ext2/3 are all number of free
> > blocks/inodes/directories.  So it should be always positive values.  It
> > seems fine to change the percpu counters to type "unsigned long" for
> > ext2/3 itself. But I am not sure if this will cause issues for other
> > users of percpu counters.  Kiran, could you please confirm this?
> 
> I guess most of the uses for per-cpu counters will be up counters, we don't
> need the signedness if it wasn't for the issues above.  The nr_files,
> memory_allocated counters are up counters too.
> 
Okey, that's good to know. 
> Thanks,
> Kiran

