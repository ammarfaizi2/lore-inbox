Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315630AbSFTVur>; Thu, 20 Jun 2002 17:50:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315631AbSFTVuq>; Thu, 20 Jun 2002 17:50:46 -0400
Received: from petasus.ch.intel.com ([143.182.124.5]:45782 "EHLO
	petasus.ch.intel.com") by vger.kernel.org with ESMTP
	id <S315630AbSFTVuo>; Thu, 20 Jun 2002 17:50:44 -0400
Message-ID: <01BDB7EEF8D4D3119D95009027AE99951B0E63EA@fmsmsx33.fm.intel.com>
From: "Griffiths, Richard A" <richard.a.griffiths@intel.com>
To: "'Andrew Morton'" <akpm@zip.com.au>, mgross@unix-os.sc.intel.com
Cc: "Griffiths, Richard A" <richard.a.griffiths@intel.com>,
       "'Jens Axboe'" <axboe@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       lse-tech@lists.sourceforge.net
Subject: RE: ext3 performance bottleneck as the number of spindles gets la
	rge
Date: Thu, 20 Jun 2002 14:50:32 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="ISO-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I should have mentioned the throughput we saw on 4 adapters 6 drives was
126KB/s.  The max theoretical bus bandwith is 640MB/s.

-----Original Message-----
From: Andrew Morton [mailto:akpm@zip.com.au]
Sent: Thursday, June 20, 2002 2:26 PM
To: mgross@unix-os.sc.intel.com
Cc: Griffiths, Richard A; 'Jens Axboe'; Linux Kernel Mailing List;
lse-tech@lists.sourceforge.net
Subject: Re: ext3 performance bottleneck as the number of spindles gets
large


mgross wrote:
> 
> On Thursday 20 June 2002 04:18 pm, Andrew Morton wrote:
> > Yup.  I take it back - high ext3 lock contention happens on 2.5
> > as well, which has block-highmem.  With heavy write traffic onto
> > six disks, two controllers, six filesystems, four CPUs the machine
> > spends about 40% of the time spinning on locks in fs/ext3/inode.c
> > You're un dual CPU, so the contention is less.
> >
> > Not very nice.  But given that the longest spin time was some
> > tens of milliseconds, with the average much lower, it shouldn't
> > affect overall I/O throughput.
> 
> How could losing 40% of your CPU's to spin locks NOT spank your
throughtput?

The limiting factor is usually disk bandwidth, seek latency, rotational
latency.  That's why I want to know your bandwidth.

> Can you copy your lockmeter data from its kernel_flag section?  Id like to
> see it.

I don't find lockmeter very useful.  Here's oprofile output for 2.5.23:

c013ec08 873      1.07487     rmqueue                 
c018a8e4 950      1.16968     do_get_write_access     
c013b00c 969      1.19307     kmem_cache_alloc_batch  
c018165c 1120     1.37899     ext3_writepage          
c0193120 1457     1.79392     journal_add_journal_head 
c0180e30 1458     1.79515     ext3_prepare_write      
c0136948 6546     8.05969     generic_file_write      
c01838ac 42608    52.4606     .text.lock.inode      

So I lost two CPUs on the BKL in fs/ext3/inode.c.  The remaining
two should be enough to saturate all but the most heroic disk
subsystems.

A couple of possibilities come to mind:

1: Processes which should be submitting I/O against disk "A" are
   instead spending tons of time asleep in the page allocator waiting
   for I/O to complete against disk "B".

2: ext3 is just too slow for the rate of data which you're trying to
   push at it.   This exhibits as lock contention, but the root cause
   is the cost of things like ext3_mark_inode_dirty().  And *that*
   is something we can fix - can shave 75% off the cost of that.

Need more data...


> >
> > Possibly something else is happening.  Have you tested ext2?
> 
> No.  We're attempting to see if we can scale to large numbers of spindles
> with EXT3 at the moment.  Perhaps we can effect positive changes to ext3
> before giving up on it and moving to another Journaled FS.

Have you tried *any* other fs?

-
