Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262714AbUBZH3p (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Feb 2004 02:29:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262715AbUBZH3p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Feb 2004 02:29:45 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:42979 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262714AbUBZH3n
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Feb 2004 02:29:43 -0500
Message-ID: <403DA056.8030007@pobox.com>
Date: Thu, 26 Feb 2004 02:29:26 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Stephen Rothwell <sfr@canb.auug.org.au>
CC: Andrew Morton <akpm@osdl.org>, Linus Torvalds <linus@osdl.org>,
       anton@samba.org, paulus@samba.org, axboe@suse.de,
       piggin@cyberone.com.au, viro@parcelfarce.linux.theplanet.co.uk,
       hch@lst.de, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iSeries virtual disk
References: <20040123163504.36582570.sfr@canb.auug.org.au>	<20040122221136.174550c3.akpm@osdl.org> <20040226172325.3a139f73.sfr@canb.auug.org.au>
In-Reply-To: <20040226172325.3a139f73.sfr@canb.auug.org.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Mozilla is being annoying and not quoting your patch, so bear with me. 
comments:

1) return an error instead of BUG() (and no error return) in the generic 
DMA routines that can return a meaningful value

2) num_req_outstanding accessed without lock in do_viodasd_request 
(driver's request_fn).  all other accesses are inside spinlock.

3) is viodasd_revalidate really needed?

4) why do you call blkdev_dequeue_request() in do_viodasd_request() 
rather than viodasd_end_request() ?  Or just use end_request() ?

5) is it really OK to call viodasd_open() and viodasd_release() multiple 
times?  These functions do not look guarded against multiple openers.

6) access to a struct viodasd_device in viodasd_ioctl() is completely 
unprotected.  OK, or asking for trouble?

7) use sg_dma_address() and sg_dma_len() accessors instead of directly 
referencing the struct scatterlist elements.  (several places)

8) send_request() probably wants a common error-exit+cleanup path, 
instead of duplicating the same cleanup code multiple times

9) viodasd_restart_all_queues_starting_from -- are you sure you don't 
want to make the function name even longer?  Maybe try for a new record?

10) in viodasd_handleReadWrite() you obtain the queue lock via 
spin_lock(), but the rest of the kernel uses spin_lock_irq() or 
spin_lock_irqsave()

11) viodasd_handleReadWrite, vioHandleBlockEvent -- follow the style in 
the rest of the driver, and eliminate the StudlyCaps.

12) don't you need to set blk_queue_max_phys_segments() too?

13) in viodasd_init(), don't you need to undo the effects of 
vio_set_hostlp() if an error occurs?

14) why does vio_set_dma_mask() always return an error?  That seems 
rather useless and unwanted.

Hey, I just merged iSeries veth, so I had to give you some more work... ;-)

	Jeff


P.S.  I so wish that people had named the API function 
dma_alloc_incoherent() rather than dma_alloc_noncoherent :)


