Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272109AbRH2X3r>; Wed, 29 Aug 2001 19:29:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272089AbRH2X3i>; Wed, 29 Aug 2001 19:29:38 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:32275 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S272088AbRH2X3V>; Wed, 29 Aug 2001 19:29:21 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Stephan von Krawczynski <skraw@ithnet.com>,
        roger.larsson@skelleftea.mail.telia.com
Subject: Re: Memory Problem in 2.4.10-pre2 / __alloc_pages failed
Date: Thu, 30 Aug 2001 01:36:10 +0200
X-Mailer: KMail [version 1.3.1]
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20010829140706.3fcb735c.skraw@ithnet.com>
In-Reply-To: <20010829140706.3fcb735c.skraw@ithnet.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20010829232929Z16206-32383+2351@humbolt.nl.linux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On August 29, 2001 02:07 pm, Stephan von Krawczynski wrote:
> I managed it again. As with previous 2.4-releases I managed to let __alloc_pages fail quite easily with pretty standard test bed:
> 
> Hardware: 2 x P-III 1GHz, 1 GB RAM, 29160 U160 SCSI, 36GB HD
> Kernel: 2.4.10-pre2 with trace output in mm/page_alloc.c (thanks Roger)
> 
> Test:
> exported reiserfs filesystem, simply copying files on it from a 2.2.19 nfs client (files are big 10-20 MB each).
> at the same time I read a CD to HD via xcdroast and run setiathome on nice-level 19.
> 
> Everything runs acceptable, but CPU-Load is high (6-8). Simply "cat /proc/meminfo" takes half a minute sometimes during test. Mouse cannot be moved smoothly during the whole test.
> When xcdroast is finished with reading CD (at about 1 MB/sec speed, not very fast indeed) the following shows up:
> 
> Aug 29 13:43:34 admin kernel: __alloc_pages: 1-order allocation failed (gfp=0x20/0).
> Aug 29 13:43:34 admin kernel: pid=1207; __alloc_pages(gfp=0x20, order=1, ...)
> Aug 29 13:43:34 admin kernel: Call Trace: [_alloc_pages+22/24] [__get_free_pages+10/24] [<fdcec845>] [<fdcec913>] [<fdceb7d7>] 
> Aug 29 13:43:34 admin kernel:    [<fdcec0f5>] [<fdcea589>] [ip_local_deliver_finish+0/368] [nf_hook_slow+272/404] [ip_rcv_finish+0/480] [ip_local_deliver+436/444] 
> Aug 29 13:43:34 admin kernel:    [ip_local_deliver_finish+0/368] [ip_rcv_finish+0/480] [ip_rcv_finish+413/480] [ip_rcv_finish+0/480] [nf_hook_slow+272/404] [ip_rcv+870/944] 
> Aug 29 13:43:34 admin kernel:    [ip_rcv_finish+0/480] [net_rx_action+362/628] [do_softirq+111/204] [do_IRQ+219/236] [ret_from_intr+0/7] [sys_ioctl+443/532] 
> Aug 29 13:43:34 admin kernel:    [system_call+51/56] 

OK, I see what the problem is.  Regular memory users are consuming memory
right down to the emergency reserve limit, beyond which only PF_MEMALLOC
users can go.  Unfortunately, since atomic memory allocators can't wait,
they tend to fail with high frequency in this state.  Duh.

First, there's an effective way to make these particular atomic failures
go away almost entirely.  The atomic memory user (in this case a network
interrupt handler) keeps a list of pages for its private use, starting with
an empty list.  Each time it needs a page it gets it from its private list,
but if that list is empty it gets it from alloc_pages, and when done with
it, returns it to its private list.  The alloc_pages call can still fail of
course, but now it will only fail a few times as it expands its list up to
the size required for normal traffic.  The effect on throughput should be
roughly nothing.

Let's try another way of dealing with it.  What I'm trying to do with the
patch below is leave a small reserve of 1/12 of pages->min, above the
emergency reserve, to be consumed by non-PF_MEMALLOC atomic allocators.
Please bear in mind this is completely untested, but would you try it
please and see if the failure frequency goes down?

--- ../2.4.9.clean/mm/page_alloc.c	Thu Aug 16 12:43:02 2001
+++ ./mm/page_alloc.c	Wed Aug 29 23:47:39 2001
@@ -493,6 +493,9 @@
 		}
 
 		/* XXX: is pages_min/4 a good amount to reserve for this? */
+		if (z->free_pages < z->pages_min / 3 && (gfp_mask & __GFP_WAIT) &&
+				!(current->flags & PF_MEMALLOC))
+			continue;
 		if (z->free_pages < z->pages_min / 4 &&
 				!(current->flags & PF_MEMALLOC))
 			continue;
