Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318034AbSGLWVD>; Fri, 12 Jul 2002 18:21:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318035AbSGLWVC>; Fri, 12 Jul 2002 18:21:02 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:16652 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S318034AbSGLWVA>;
	Fri, 12 Jul 2002 18:21:00 -0400
Message-ID: <3D2F567A.3BDAF055@zip.com.au>
Date: Fri, 12 Jul 2002 15:21:46 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Griffiths, Richard A" <richard.a.griffiths@intel.com>
CC: "'Andrea Arcangeli'" <andrea@suse.de>,
       "'Marcelo Tosatti'" <marcelo@conectiva.com.br>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       "'Carter K. George'" <carter@polyserve.com>,
       "'Don Norton'" <djn@polyserve.com>,
       "'James S. Tybur'" <jtybur@polyserve.com>,
       "Gross, Mark" <mark.gross@intel.com>
Subject: Re: fsync fixes for 2.4
References: <01BDB7EEF8D4D3119D95009027AE99951B0E6428@fmsmsx33.fm.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Griffiths, Richard A" wrote:
> 
> ...
> Running on 2.4.19rc1 base 8KB writes to a 1GB file  on an
> ext2 filesystem:
> 
>  2 adapters (on separate PCI buses)
>  Drives per card  Total system throughput EXT2
>            1                    105983 KB/sec
>            2                    179214 KB/sec
>            3                    180237 KB/sec
>            4                    178795 KB/sec
>            5                    175484 KB/sec
>            6                    172903 KB/sec
> 
>  4 adapters
>  Drives per card  Total system throughput EXT2
>            1                     184150 KB/sec
>            2                     165774 KB/sec
>            3                     160775 KB/sec
>            4                     158326 KB/sec
>            5                     157291 KB/sec
>            6                     155901 KB/sec

Well I know what the problem is, but I don't know how to fix
it in 2.4.

With 4 adapters and six disks on each, you have 27 processes
which are responsible for submitting IO: the 24 bonnies,
kswapd, bdflush and kupdate.

If one or two of the request queues gets filled up, *all* these
threads hit those queues and go to sleep.  Nobody is submitting
IO for the other queues and they fall idle.

In 2.4, we have a global LRU of dirty buffers and everyone walks
that list in old->new order.  It has a jumble of buffers which
are dirty against all the queues so inevitably, as soon as one
queue fills up it blocks everyone.

A naive fix would be to get callers of balance_dirty() to skip
over buffers in that queue which do not belong to their blockdev.
But the CPU cost of that search would be astronomical.

A more intrusive fix would be to make callers of balance_dirty()
walk the superblock->inode->i_dirty[_data]_buffers list instead
of the buffer LRU.  That's a sort-of-2.5 approach.

But even that wouldn't help, because then you hit the second
problem: your 24 bonnie threads hit the same queue congestion
in the page reclaim code when they encounter dirty pages on
the page LRU.

I have a fix for the first problem in 2.5.  And the second problem
(the page reclaim code) I have sorta-bandaided.

So.  Hard.

I haven't tested this yet, but you may get some benefit from
this patch:


--- linux-2.4.19-rc1/drivers/block/ll_rw_blk.c	Thu Jul  4 02:01:16 2002
+++ linux-akpm/drivers/block/ll_rw_blk.c	Fri Jul 12 15:28:42 2002
@@ -359,6 +359,7 @@ int blk_grow_request_list(request_queue_
 	q->batch_requests = q->nr_requests / 4;
 	if (q->batch_requests > 32)
 		q->batch_requests = 32;
+	q->batch_requests = 1;
 	spin_unlock_irqrestore(&io_request_lock, flags);
 	return q->nr_requests;
 }
