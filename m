Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271921AbRH3Qxo>; Thu, 30 Aug 2001 12:53:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271924AbRH3Qxd>; Thu, 30 Aug 2001 12:53:33 -0400
Received: from mailf.telia.com ([194.22.194.25]:22524 "EHLO mailf.telia.com")
	by vger.kernel.org with ESMTP id <S271921AbRH3QxX>;
	Thu, 30 Aug 2001 12:53:23 -0400
Message-Id: <200108301653.f7UGrdf25667@mailf.telia.com>
Content-Type: text/plain;
  charset="iso-8859-1"
From: Roger Larsson <roger.larsson@skelleftea.mail.telia.com>
To: Daniel Phillips <phillips@bonn-fries.net>,
        Stephan von Krawczynski <skraw@ithnet.com>
Subject: Re: Memory Problem in 2.4.10-pre2 / __alloc_pages failed
Date: Thu, 30 Aug 2001 18:49:08 +0200
X-Mailer: KMail [version 1.3]
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20010829140706.3fcb735c.skraw@ithnet.com> <20010829232929Z16206-32383+2351@humbolt.nl.linux.org>
In-Reply-To: <20010829232929Z16206-32383+2351@humbolt.nl.linux.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursdayen den 30 August 2001 01:36, Daniel Phillips wrote:
> On August 29, 2001 02:07 pm, Stephan von Krawczynski wrote:
> > I managed it again. As with previous 2.4-releases I managed to let
> > __alloc_pages fail quite easily with pretty standard test bed:
> >
> > Hardware: 2 x P-III 1GHz, 1 GB RAM, 29160 U160 SCSI, 36GB HD
> > Kernel: 2.4.10-pre2 with trace output in mm/page_alloc.c (thanks Roger)
> >
> > Test:
> > exported reiserfs filesystem, simply copying files on it from a 2.2.19
> > nfs client (files are big 10-20 MB each). at the same time I read a CD to
> > HD via xcdroast and run setiathome on nice-level 19.
> >
> > Everything runs acceptable, but CPU-Load is high (6-8). Simply "cat
> > /proc/meminfo" takes half a minute sometimes during test. Mouse cannot be
> > moved smoothly during the whole test. When xcdroast is finished with
> > reading CD (at about 1 MB/sec speed, not very fast indeed) the following
> > shows up:
> >
> > Aug 29 13:43:34 admin kernel: __alloc_pages: 1-order allocation failed
> > (gfp=0x20/0). Aug 29 13:43:34 admin kernel: pid=1207;
> > __alloc_pages(gfp=0x20, order=1, ...) Aug 29 13:43:34 admin kernel: Call
> > Trace: [_alloc_pages+22/24] [__get_free_pages+10/24] [<fdcec845>]
> > [<fdcec913>] [<fdceb7d7>] Aug 29 13:43:34 admin kernel:    [<fdcec0f5>]
> > [<fdcea589>] [ip_local_deliver_finish+0/368] [nf_hook_slow+272/404]
> > [ip_rcv_finish+0/480] [ip_local_deliver+436/444] Aug 29 13:43:34 admin
> > kernel:    [ip_local_deliver_finish+0/368] [ip_rcv_finish+0/480]
> > [ip_rcv_finish+413/480] [ip_rcv_finish+0/480] [nf_hook_slow+272/404]
> > [ip_rcv+870/944] Aug 29 13:43:34 admin kernel:    [ip_rcv_finish+0/480]
> > [net_rx_action+362/628] [do_softirq+111/204] [do_IRQ+219/236]
> > [ret_from_intr+0/7] [sys_ioctl+443/532] Aug 29 13:43:34 admin kernel:   
> > [system_call+51/56]
>
> OK, I see what the problem is.  Regular memory users are consuming memory
> right down to the emergency reserve limit, beyond which only PF_MEMALLOC
> users can go.  Unfortunately, since atomic memory allocators can't wait,
> they tend to fail with high frequency in this state.  Duh.
>
> First, there's an effective way to make these particular atomic failures
> go away almost entirely.  The atomic memory user (in this case a network
> interrupt handler) keeps a list of pages for its private use, starting with
> an empty list.  Each time it needs a page it gets it from its private list,
> but if that list is empty it gets it from alloc_pages, and when done with
> it, returns it to its private list.  The alloc_pages call can still fail of
> course, but now it will only fail a few times as it expands its list up to
> the size required for normal traffic.  The effect on throughput should be
> roughly nothing.

Looking at the code - sg already has some private memory... but it does not
use it in this case. (see sg_low_malloc)

But it tries to alloc 8 (2**3) pages atomically. That it quite a bit of memory
(32k!) that is twice more memory than the first computer I used.
But in this case we do not see errors with lower orders, try 4*4096

IN FILE sg.h

#define SG_SCATTER_SZ (8 * 4096)  /* PAGE_SIZE not available to user */
/* Largest size (in bytes) a single scatter-gather list element can have.
   The value must be a power of 2 and <= (PAGE_SIZE * 32) [131072 bytes on
   i386]. The minimum value is PAGE_SIZE. If scatter-gather not supported
   by adapter then this value is the largest data block that can be
   read/written by a single scsi command. The user can find the value of
   PAGE_SIZE by calling getpagesize() defined in unistd.h . */


/RogerL

-- 
Roger Larsson
Skellefteå
Sweden
