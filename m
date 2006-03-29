Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750720AbWC2T7l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750720AbWC2T7l (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Mar 2006 14:59:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750760AbWC2T7l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Mar 2006 14:59:41 -0500
Received: from ns1.siteground.net ([207.218.208.2]:41927 "EHLO
	serv01.siteground.net") by vger.kernel.org with ESMTP
	id S1750720AbWC2T7k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Mar 2006 14:59:40 -0500
Date: Wed, 29 Mar 2006 12:00:20 -0800
From: Ravikiran G Thirumalai <kiran@scalex86.org>
To: Mingming Cao <cmm@us.ibm.com>
Cc: Laurent Vivier <Laurent.Vivier@bull.net>, Andrew Morton <akpm@osdl.org>,
       Takashi Sato <sho@tnes.nec.co.jp>,
       Badari Pulavarty <pbadari@us.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: [Ext2-devel] [PATCH 2/2] ext2/3: Support2^32-1blocks(e2fsprogs)
Message-ID: <20060329200020.GA3729@localhost.localdomain>
References: <20060325223358sho@rifu.tnes.nec.co.jp> <1143485147.3970.23.camel@dyn9047017067.beaverton.ibm.com> <20060327131049.2c6a5413.akpm@osdl.org> <20060327225847.GC3756@localhost.localdomain> <1143530126.11560.6.camel@openx2.frec.bull.fr> <1143568905.3935.13.camel@dyn9047017067.beaverton.ibm.com> <1143623605.5046.11.camel@openx2.frec.bull.fr> <1143657317.4045.12.camel@dyn9047017067.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1143657317.4045.12.camel@dyn9047017067.beaverton.ibm.com>
User-Agent: Mutt/1.4.2.1i
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - serv01.siteground.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - scalex86.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 29, 2006 at 10:35:10AM -0800, Mingming Cao wrote:
> On Wed, 2006-03-29 at 11:13 +0200, Laurent Vivier wrote:
> > 
> > You're right, Mingming.
> > 
> > But I think instead of thinking to change "long" by "long long" we
> > should think about changing "long" by "unsigned long" in the per-cpu
> > counter structure.
> > 
> > Is there someone knowing why this counter is signed ?
> 
> I am wondering the same thing asked by Laurent. Initially I thought the
> signed value is there to prevent overflow, or to maintain a "int" type
> counters. Are those the intentions, kiran?

I don't know if the local counter version values can be unsigned in this
case.  Consider a case like this with the initial counter value to be 0,
and FBC_BATCH is 32 (8cpusx4)

cpu 1				cpu 2			cpu 3
--------			-------			--------
add(10)
//local = 10 fbc = 0.
				sub(5)
				//local = -5 fbc = 0
							add(31)
							//local = 31 fbc = 0

				sub(30)
				//local = 0 fbc = -35
				--------------->(A)

Now if the local counters were unsigned, and the global counters unsigned
too, counter read at A would result in a large value, which would mislead
the app.  Maybe it doesn't matter if we use percpu_counter_exceeds at
critical places, so these get caught, but that would mean going on all cpus
more often than before..and that would also mean weird values when we just
use percpu_counter_read to print these counters.

So maybe using long long is a simpler solution here? Andrew, thoughts?

> 
> But it seems the per cpu counters used in ext2/3 are all number of free
> blocks/inodes/directories.  So it should be always positive values.  It
> seems fine to change the percpu counters to type "unsigned long" for
> ext2/3 itself. But I am not sure if this will cause issues for other
> users of percpu counters.  Kiran, could you please confirm this?

I guess most of the uses for per-cpu counters will be up counters, we don't
need the signedness if it wasn't for the issues above.  The nr_files,
memory_allocated counters are up counters too.

Thanks,
Kiran
