Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261465AbUB0Anq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Feb 2004 19:43:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261501AbUB0Anq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Feb 2004 19:43:46 -0500
Received: from supreme.pcug.org.au ([203.10.76.34]:60887 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id S261465AbUB0An2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Feb 2004 19:43:28 -0500
Date: Fri, 27 Feb 2004 11:42:40 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: akpm@osdl.org, linus@osdl.org, anton@samba.org, paulus@samba.org,
       axboe@suse.de, piggin@cyberone.com.au,
       viro@parcelfarce.linux.theplanet.co.uk, hch@lst.de,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iSeries virtual disk
Message-Id: <20040227114240.6e26d870.sfr@canb.auug.org.au>
In-Reply-To: <403DA056.8030007@pobox.com>
References: <20040123163504.36582570.sfr@canb.auug.org.au>
	<20040122221136.174550c3.akpm@osdl.org>
	<20040226172325.3a139f73.sfr@canb.auug.org.au>
	<403DA056.8030007@pobox.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1";
 boundary="Signature=_Fri__27_Feb_2004_11_42_41_+1100_Xs15u9tL0.y1aFOb"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Fri__27_Feb_2004_11_42_41_+1100_Xs15u9tL0.y1aFOb
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

Hi Jeff,

On Thu, 26 Feb 2004 02:29:26 -0500 Jeff Garzik <jgarzik@pobox.com> wrote:
>
> 1) return an error instead of BUG() (and no error return) in the generic 
> DMA routines that can return a meaningful value

I have removed the DMA changes from this patch.

> 2) num_req_outstanding accessed without lock in do_viodasd_request 
> (driver's request_fn).  all other accesses are inside spinlock.

This is actually OK because:
	1) if we see a value too large, when it get decremented by
	handle_read_write, all the queue requst functions will get rerun.
	2) in send_request, if we get an error and decrement the count
	to zero, then the count could have been at most 1 (sonce sends
	are serialised) so in the request funtion, we would not have
	stopped processing requests.

> 3) is viodasd_revalidate really needed?

Not any more - its gone.

> 4) why do you call blkdev_dequeue_request() in do_viodasd_request() 
> rather than viodasd_end_request() ?  Or just use end_request() ?

See Jens' response.

> 5) is it really OK to call viodasd_open() and viodasd_release() multiple 
> times?  These functions do not look guarded against multiple openers.

It is OK.

> 6) access to a struct viodasd_device in viodasd_ioctl() is completely 
> unprotected.  OK, or asking for trouble?

Its OK, beacuse the viodasd_request is completely static data after the
disk is probed - and before that you cannot get the ioctl ...

> 7) use sg_dma_address() and sg_dma_len() accessors instead of directly 
> referencing the struct scatterlist elements.  (several places)

done.

> 8) send_request() probably wants a common error-exit+cleanup path, 
> instead of duplicating the same cleanup code multiple times

done.

> 9) viodasd_restart_all_queues_starting_from -- are you sure you don't 
> want to make the function name even longer?  Maybe try for a new record?

:-)

> 10) in viodasd_handleReadWrite() you obtain the queue lock via 
> spin_lock(), but the rest of the kernel uses spin_lock_irq() or 
> spin_lock_irqsave()

fixed.

> 11) viodasd_handleReadWrite, vioHandleBlockEvent -- follow the style in 
> the rest of the driver, and eliminate the StudlyCaps.

done.

> 12) don't you need to set blk_queue_max_phys_segments() too?

done.

> 13) in viodasd_init(), don't you need to undo the effects of 
> vio_set_hostlp() if an error occurs?

No and, in fact, we can't.

> 14) why does vio_set_dma_mask() always return an error?  That seems 
> rather useless and unwanted.

dma stuff removed ...

New patch following soon.
-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Fri__27_Feb_2004_11_42_41_+1100_Xs15u9tL0.y1aFOb
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAPpKKFG47PeJeR58RAovIAKCvbnptJlop/+TXZeM03uBGKBT//gCZAa6r
lECZy5SONBYtkHQofCI2exg=
=nlTB
-----END PGP SIGNATURE-----

--Signature=_Fri__27_Feb_2004_11_42_41_+1100_Xs15u9tL0.y1aFOb--
