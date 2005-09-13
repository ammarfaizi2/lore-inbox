Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964969AbVIMSuo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964969AbVIMSuo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 14:50:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964978AbVIMSuo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 14:50:44 -0400
Received: from 66-23-228-155.clients.speedfactory.net ([66.23.228.155]:22928
	"EHLO kevlar.burdell.org") by vger.kernel.org with ESMTP
	id S964969AbVIMSun (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 14:50:43 -0400
Date: Tue, 13 Sep 2005 14:46:29 -0400
From: Sonny Rao <sonny@burdell.org>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       anton@samba.org, linuxppc64-dev@ozlabs.org
Subject: Re: 2.6.13-mm3
Message-ID: <20050913184629.GA29416@kevlar.burdell.org>
Mail-Followup-To: Sonny Rao <sonny@burdell.org>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	anton@samba.org, linuxppc64-dev@ozlabs.org
References: <20050912024350.60e89eb1.akpm@osdl.org> <20050912145435.GA4722@kevlar.burdell.org> <20050912125641.4b53553d.akpm@osdl.org> <20050913183215.GA28596@kevlar.burdell.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050913183215.GA28596@kevlar.burdell.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 13, 2005 at 02:32:15PM -0400, Sonny Rao wrote:
> On Mon, Sep 12, 2005 at 12:56:41PM -0700, Andrew Morton wrote:
> > Sonny Rao <sonny@burdell.org> wrote:
> > >
> > > On Mon, Sep 12, 2005 at 02:43:50AM -0700, Andrew Morton wrote:
> > > <snip>
> > > > - There are several performance tuning patches here which need careful
> > > >   attention and testing.  (Does anyone do performance testing any more?)
> > > <snip>
> > > > 
> > > >   - The size of the page allocator per-cpu magazines has been increased
> > > > 
> > > >   - The page allocator has been changed to use higher-order allocations
> > > >     when batch-loading the per-cpu magazines.  This is intended to give
> > > >     improved cache colouring effects however it might have the downside of
> > > >     causing extra page allocator fragmentation.
> > > > 
> > > >   - The page allocator's per-cpu magazines have had their lower threshold
> > > >     set to zero.  And we can't remember why it ever had a lower threshold.
> > > > 
> > > 
> > > What would you like? The usual suspects:  SDET, dbench, kernbench ?
> > > 
> > 
> > That would be a good start, thanks.  The higher-order-allocations thing is
> > mainly targeted at big-iron numerical computing I believe.
> > 
> > I've already had one report of fragmentation-derived page allocator
> > failures (http://bugzilla.kernel.org/show_bug.cgi?id=5229).
> 
> Ok, I'm getting much further on ppc64 thanks to Anton B.
> 
> So far, I need patched in the hvc console fix, Anton's SCSI fix for
> 2.6.14-rc1, Paulus's EEH fix, and I reverted
> remove-near-all-bugs-in-mm-mempolicyc.patch and
> convert-mempolicies-to-nodemask_t.patch
> 
> I got most of the way through the boot scripts and crashed while
> bringing up the loopback interface.
> 
> Here's the latest PPC64 crash on 2.6.13-mm3:
> 
> smp_call_function on cpu 5: other cpus not responding (5)
> cpu 0x5: Vector: 0  at [c00000000f3b6b00]
>     pc: 000000000000003d
>     lr: 000000000000003d
>     sp: c00000000f3b6a90
>    msr: 8000000000009032
>   current = 0xc000000002018050
>   paca    = 0xc00000000048a400
>     pid   = 1679, comm = ip
> enter ? for help
> 5:mon> t
> 
> (xmon hangs here)

Here's another one with the traceback:

1:mon> e
cpu 0x1: Vector: 0  at [c0000001ebff7860]
    pc: 000000000000003d
    lr: 000000000000003d
    sp: c0000001ebff77f0
   msr: 8000000000009032
  current = 0xc0000001ebf067f0
  paca    = 0xc000000000488400
    pid   = 1, comm = swapper
1:mon> 
1:mon> t
[c0000001ebff77f0] c0000000000403f8 .xmon+0xf4/0x104 (unreliable)
[c0000001ebff79c0] c00000000002e6fc .smp_call_function+0x1b4/0x1e0
[c0000001ebff7a70] c000000000084d34 .smp_call_function_all_cpus+0x70/0x98
[c0000001ebff7b00] c000000000085ff4 .do_tune_cpucache+0x10c/0x68c
[c0000001ebff7ce0] c0000000000867e8 .enable_cpucache+0x9c/0xec
[c0000001ebff7d60] c0000000000878b8 .kmem_cache_create+0x5e0/0x8e4
[c0000001ebff7e60] c00000000045382c .as_init+0x38/0xbc
[c0000001ebff7ef0] c000000000008888 .init+0x1f4/0x454
[c0000001ebff7f90] c00000000000fa48 .kernel_thread+0x4c/0x68
1:mon> 



I'm starting to think I'm going to have to test the above stuff on
x86... (maybe someone will prove me wrong ;-)) 

Sonny
