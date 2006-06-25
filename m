Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750735AbWFYVRx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750735AbWFYVRx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jun 2006 17:17:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750766AbWFYVRx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jun 2006 17:17:53 -0400
Received: from server99.tchmachines.com ([72.9.230.178]:10461 "EHLO
	server99.tchmachines.com") by vger.kernel.org with ESMTP
	id S1750735AbWFYVRw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jun 2006 17:17:52 -0400
Date: Sun, 25 Jun 2006 14:19:29 -0700
From: Ravikiran G Thirumalai <kiran@scalex86.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Christoph Lameter <clameter@engr.sgi.com>, linux-kernel@vger.kernel.org
Subject: Re: remove __read_mostly?
Message-ID: <20060625211929.GA3865@localhost.localdomain>
References: <20060625115736.d90e1241.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060625115736.d90e1241.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - server99.tchmachines.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - scalex86.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 25, 2006 at 11:57:36AM -0700, Andrew Morton wrote:
> 
> I'm thinking we should remove __read_mostly.
> 
> Because if we use this everywhere where it's supposed to be used, we end up
> with .bss and .data 100% populated with write-often variables, packed
> closely together.  The cachelines will really flying around.
> 
> IOW: __read_mostly optimises read-mostly variables and pessimises
> write-often variables.
> 
> We want something which optimises both read-mostly and write-often storage.
>  We do that by marking the write-often variables with
> __cacheline_aligned_in_smp.

We already mark write often structures with __cacheline_aligned_in_smp.

The idea behind __read_mostly is to separate variables like cpu maps,
bootcpuinfo etc which are written to very very rarely -- during 
initialization/hot-plugging, but read quite often something like ~100 % read
ratio.  They might not be sharing the cacheline with a 
variable which is not as frequently written to, to mark 
__cacheline_aligned_in_smp, but still, these often read variables would be 
invalidated in cache every time there is a write on these other variables.  
Considering that there are quite a few structures which are read often,
(like cpu maps, cpu info, node to cpu maps etc) it made sense to place them 
in a separate section.

When we mark  variables __read_mostly, it doesn't mean all that is left in
.bss and .data is write mostly.  Surely the rest of .data and .bss which
do not qualify for ~100% read would not be ~100% write/RMW.  We would have 
variables which experience varying ratio of reads and writes.

So as I see it the current scheme of thing is 
1. If a variable is written quite often -- mark __cacheline_aligned_in_smp.
2. If a variable is read quite often .. something like 99:1 read -- mark them
   __read_mostly

> 
> OK?
> 
> [Problem is, I don't think any of the make-foo-__read_mostly patches
> actually identified _which_ write-often variables were affecting `foo', so
> we'll be back to square one.]

Most of the variables we marked as __read_mostly were ones we were seeing
inter-node transfers for read, when we shouldn't be seeing any -- because
they are just written to once during bootup.  And it did not make sense to 
mark the other writers on the inter-node cacheline __cacheline_aligned_in_smp, 
since it would mean a bloat of 128-4096 bytes depending on the arch, and
those variables were not written often enough to warrant padding. A few not
so-often-written variables on the same cacheline would mean these read
mostly variables are always being invalidated.

> 
> [Actually, we should do
> 
> 	#define __write_often __cacheline_aligned_in_smp
> 
> and use __write_often
> 
> a) for documentation and
> 
> b) so the optimisation can be centrally turned off, for space
>    optimisation or for performance validation.]
> 

Sure, we can change users of __cacheline_aligned_in_smp to __write_often and
change the section to .data.write_mostly from .data.cacheline_aligned for 
readability sake.  But, IMHO we do need the __read_mostly section for variables
which experience near 100% read access.  I cannot see any negative aspects of
having a separate read mostly section as there is no padding or bloating
involved.  Granted, we might not see performance difference with some builds
due to the compiler/linker placement / code changes, but this might
resurface later with a newer build/code changes.

Thanks,
Kiran
