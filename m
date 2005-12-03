Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750838AbVLCOSK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750838AbVLCOSK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Dec 2005 09:18:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751257AbVLCOSJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Dec 2005 09:18:09 -0500
Received: from hera.kernel.org ([140.211.167.34]:17031 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S1750838AbVLCOSI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Dec 2005 09:18:08 -0500
Date: Fri, 2 Dec 2005 22:26:14 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Andrew Morton <akpm@osdl.org>
Cc: wfg@mail.ustc.edu.cn, linux-kernel@vger.kernel.org, christoph@lameter.com,
       riel@redhat.com, a.p.zijlstra@chello.nl, npiggin@suse.de,
       andrea@suse.de, magnus.damm@gmail.com
Subject: Re: [PATCH 02/12] mm: supporting variables and functions for balanced zone aging
Message-ID: <20051203002614.GA3140@dmt.cnet>
References: <20051201101810.837245000@localhost.localdomain> <20051201101933.936973000@localhost.localdomain> <20051201023714.612f0bbf.akpm@osdl.org> <20051201222846.GA3646@dmt.cnet> <20051201150349.3538638e.akpm@osdl.org> <20051202011924.GA3516@mail.ustc.edu.cn> <20051201214931.2dbc35fe.akpm@osdl.org> <20051202151352.GA3707@dmt.cnet> <20051202133917.1ebbe851.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051202133917.1ebbe851.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 02, 2005 at 01:39:17PM -0800, Andrew Morton wrote:
> Marcelo Tosatti <marcelo.tosatti@cyclades.com> wrote:
> >
> > 
> > It all makes sense to me (Wu's description of the problem and your patch), 
> > but still no good with reference to fair scanning.
> 
> Not so.  On a 4G x86 box doing a simple 8GB write this patch took the
> highmem/normal scanning ratio from 0.7 to 3.5.  On that setup the highmem
> zone has 3.6x as many pages as the normal zone, so it's bang-on-target.

Humpf!  What are the pgalloc dma/normal/highmem numbers under such test?

Does this machine need bounce buffers for disk I/O?

> There's not a lot of point in jumping straight into the complex stresstests
> without having first tested the simple stuff.

Its not a really complex stresstest, though yours is simpler. There are 10 
threads operating on 20 files. You can reproduce the load using the 
following FFSB profile (I remake the filesystem each time, results are 
pretty stable):

num_filesystems=1
num_threadgroups=1
directio=0
time=300

[filesystem0]
location=/mnt/hda4/
num_files=20
num_dirs=10
max_filesize=91534338
min_filesize=65535
[end0]

[threadgroup0]
num_threads=10
write_size=2816
write_blocksize=4096
read_size=2816
read_blocksize=4096
create_weight=100
write_weight=30
read_weight=100
[end0]


> > Moreover the patch hurts 
> > interactivity _badly_, not sure why (ssh into the box with FFSB testcase 
> > takes more than one minute to login, while vanilla takes few dozens of seconds). 
> 
> Well, we know that the revert reintroduces an overscanning problem.

Can you remember the testcase for which you added the "truncate reclaim"
logic more precisely? 

> How are you invoking FFSB?  Exactly?  On what sort of machine, with how
> much memory?

Its a single processor Pentium-3 1GHz+ booted with mem=128M, 4/5 years old IDE disk.

> > Follows an interesting part of "diff -u 2614-vanilla.vmstat 2614-akpm.vmstat"
> > (they were not retrieve at the exact same point in the benchmark run, but 
> > that should not matter much):
> > 
> > -slabs_scanned 37632
> > -kswapd_steal 731859
> > -kswapd_inodesteal 1363
> > -pageoutrun 26573
> > -allocstall 636
> > -pgrotated 1898
> > +slabs_scanned 2688
> > +kswapd_steal 502946
> > +kswapd_inodesteal 1
> > +pageoutrun 10612
> > +allocstall 90
> > +pgrotated 68
> >
> > Note how direct reclaim (and slabs_scanned) are hugely affected. 
> 
> hm.  allocstall is much lower and pgrotated has improved and direct reclaim
> has improved.  All of which would indicate that kswapd is doing more work. 
> Yet kswapd reclaimed less pages.  It's hard to say what's going on as these
> numbers came from different stages of the test.

I have a feeling they came from a somewhat equivalent stage (FFSB is a cyclic
test, there are not much of "phases" after the initial creation of files).

Feel free to reproduce the testcase, you simply need the FFSB profile 
above and mem=128M.

It seems very fragile (Wu's patches attempt to address that) in general: you
tweak it here and watch it go nuts there.

> > Normal: 114688kB
> > DMA: 16384kB
> > 
> > Normal/DMA ratio = 114688 / 16384 = 7.000
> >
> > pgscan_kswapd Normal/DMA = (450483 / 88869) = 5.069
> > pgscan_direct Normal/DMA = (23826 / 4224) = 5.640
> > pgscan Normal/DMA = (474309 / 88869) = 5.337
> > pgscan_kswapd Normal/DMA = (441936 / 80520) = 5.488
> > pgscan_direct Normal/DMA = (7392/1188) = 6.222
> > pgscan Normal/DMA = (449328 / 81708) = 5.499
> > pgalloc_normal_dma_ratio = (559994 / 8488) = 6.597
> > pgscan_kswapd Normal/DMA (664883/82845) = 8.025
> > pgscan_direct Normal/DMA = (13485/1745) = 7.727
> > pgscan Normal/DMA = (678368 / 84590) = 8.019
> > pgalloc_normal_dma_ratio = (699927/66313) = 10.554
> 
> All of these look close enough to me.  10-20% over- or under-scanning of
> the teeny DMA zone doesn't seem very important.

Hopefully yes. The lowmem_reserve[] logic is there to _avoid_ over-allocation
(over-scanning) of the DMA zone by GFP_NORMAL allocations, isnt it?

Note, there should be no DMA limited hardware on this box (I'm using PIO for the 
IDE disk). BTW, why do you need lowmem_reserve for the DMA zone if you don't 
have 16MB capped ISA devices on your system?

> Getting normal-vs-highmem right is more important.
> 
> It's hard to say what effect the watermark thingies have on all of this. 
> I'd sugget that you start out with much less complex tests and see if `echo
> 10000 10000 10000 > /proc/sys/vm/lowmem_reserve_ratio' changes anything. 
> (I have that in my rc.local - the thing is a daft waste of memory).
> 
> I'd be more concerned about the interactivity thing, although it sounds
> like the machine is so overloaded with this test that it'd be fairly
> pointless to try to tune that workload first.  It's more important to tune
> the system for more typical heavy loads.

What made me notice it was the huge interactivity difference between
vanilla and your patch, again, I'm not really sure about its root.

> Also, the choice of IO scheduler matters.  Which are you using?

The default for 2.6.14. Thats AS right? 

I'll see if I can do more tests next week.

Best wishes.
