Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264727AbUKATFu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264727AbUKATFu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Nov 2004 14:05:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S287592AbUKASwE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Nov 2004 13:52:04 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:19151 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S274985AbUKASfF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Nov 2004 13:35:05 -0500
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: Buffered I/O slowness
Date: Mon, 1 Nov 2004 10:34:56 -0800
User-Agent: KMail/1.7
Cc: linux-kernel@vger.kernel.org, jeremy@sgi.com
References: <200410251814.23273.jbarnes@engr.sgi.com> <20041029173045.32722ac0.akpm@osdl.org> <200411011026.34102.jbarnes@engr.sgi.com>
In-Reply-To: <200411011026.34102.jbarnes@engr.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200411011034.56462.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, November 1, 2004 10:26 am, Jesse Barnes wrote:
> On Friday, October 29, 2004 5:30 pm, Andrew Morton wrote:
> > Jesse Barnes <jbarnes@engr.sgi.com> wrote:
> > > > I'm not sure that we know what's going on yet.  I certainly don't. 
> > > > The above numbers look good, so what's the problem???
> > >
> > > The numbers are ~1/3 of what the machine is capable of with direct I/O.
> >
> > Are there CPU cycles to spare?  If you have just one CPU copying 1GB/sec
> > out of pagecache, maybe it is pegged?
>
> Hm, I thought I had more CPU to spare, but when I set the readahead to a
> large value, I'm taking ~100% of the CPU time on the CPU doing the read. 
> ~98% of that is system time.  When I run 8 copies (this is an 8 CPU
> system), I get ~4GB/s and all the CPUs are near fully busy.  I guess things
> aren't as bad as I initially thought.

OTOH, if I run 8 copies against 8 separate files (the test above was 8 I/O 
threads on the same file), I'm seeing ~16% CPU for each CPU in the machine 
and only about 700 MB/s of I/O throughput, so this case *does* look like a 
problem.  Here's the profile (this is 2.6.10-rc1-mm2).

Jesse

mgr Aggregate throughput: 6241.204239 MB in 10.183594s; 612.868541 MB/s
116885 total                                      0.0162
 50577 ia64_pal_call_static                     263.4219
 42784 default_idle                              95.5000
  6148 ia64_save_scratch_fpregs                  96.0625
  5908 ia64_load_scratch_fpregs                  92.3125
  4738 __copy_user                                2.0008
  2079 _spin_unlock_irq                          12.9938
   926 _spin_unlock_irqrestore                    4.8229
   374 sn_dma_flush                               0.2997
   192 generic_make_request                       0.1250
   177 clone_endio                                0.2634
   149 _read_unlock_irq                           0.9313
   135 dm_table_unplug_all                        0.4688
   128 buffered_rmqueue                           0.0597
   122 mptscsih_io_done                           0.0428
   117 clear_page                                 0.7312
    96 __end_that_request_first                   0.0811
    94 _spin_lock_irqsave                         0.2670
    92 mempool_alloc                              0.0927
    88 handle_IRQ_event                           0.3056
    80 _write_unlock_irq                          0.3571
    80 mpage_end_io_read                          0.1471
    61 kmem_cache_alloc                           0.2383
    59 xfs_iomap                                  0.0181
    59 xfs_bmapi                                  0.0038
    59 do_mpage_readpage                          0.0249
    55 dm_table_any_congested                     0.1719
    53 pcibr_dma_unmap                            0.3312
    51 scsi_io_completion                         0.0228
    47 kmem_cache_free                            0.1224
