Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932274AbWE3PRi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932274AbWE3PRi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 11:17:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932312AbWE3PRi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 11:17:38 -0400
Received: from py-out-1112.google.com ([64.233.166.181]:13997 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S932311AbWE3PRh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 11:17:37 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=LSD0TiqcCv6yFySwZN1e8n//QFwWB4ViDamfyxKEsW5jU1rtAxoi7GpgVp9yAOQ4JdQJ4NPHeVPaGO3m7IBVw+vSfCJhTZCQn5tWHjKObkJFq01NWiHFrgTKX0kHDomziBx/ybYjb27QcMALqwz4BQeI5gG7idFYrGxIGQz82oE=
Message-ID: <aa4c40ff0605300817w63da104dq8c28d007447649a2@mail.gmail.com>
Date: Tue, 30 May 2006 08:17:36 -0700
From: "James Lamanna" <jlamanna@gmail.com>
To: "Kai Makisara" <Kai.Makisara@kolumbus.fi>
Subject: Re: [OOPS] amrestore dies in kmem_cache_free 2.6.16.18 - cannot restore backups!
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
       "Mike Christie" <michaelc@cs.wisc.edu>,
       "Bryan Holty" <lgeek@frontiernet.net>
In-Reply-To: <Pine.LNX.4.63.0605271202110.10358@kai.makisara.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <aa4c40ff0605231824j55c998c3oe427dec2404afba0@mail.gmail.com>
	 <Pine.LNX.4.63.0605252224450.4178@kai.makisara.local>
	 <Pine.LNX.4.63.0605271202110.10358@kai.makisara.local>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/27/06, Kai Makisara <Kai.Makisara@kolumbus.fi> wrote:
> On Thu, 25 May 2006, Kai Makisara wrote:
>
> > I am adding linux-scsi to recipients (and quoting the whole message for
> > readers of that list).
> >
> > On Tue, 23 May 2006, James Lamanna wrote:
> >
> > > So I was able to recreate this problem on a vanilla 2.6.16.18 with the
> > > following oops..
> > > I'd say this is a serious regression since I cannot restore backups
> > > anymore (I could with 2.6.14.x, but that kernel series had other
> > > issues...)
> > >
> > > amrestore does manage to read 1 32k block from tape before dying.
> > >
> > > Any help would be greatly appreciated.
> > >
> > I have tried 'amrestore' on my machine with 2.6.16.18 but was not able to
> > reproduce the problem.
>
> OK. Now I think I have found something, thanks to Mike Christie's reminder
> yesterday in another thread that the patch at the end of this message has
> not been merged into 2.6.16 (and 2.6.17-rcx) ;-)

[SNIP]

>
> Next thing was to patch 2.6.16.18 with the patch at the end: No more
> oopses with any alignment.
>
> James, does this fix your problem ?

Kai-

Yes, the patch below does fix my problem and lets amrestore run.
Of course I still have the sense data problem, but I think I'm going
to replace some cables and terminators :)

So I would say that this should be included in 2.6.17, and perhaps a
2.6.16.19? :)

Thanks again!

>
> Kai

-- James

>
> --------------------------------8<------------------------------------------
>
> Excerpt from a message from Brian Holty to linux-scsi and linux-kernel on
> Wed, 22 Mar 2006 06:35:39:
>
> ...
> Based on above, I think the most intuitive fix would be the offset addition of
> the first entry to the initialization of nr_pages.
>
> Without this change, for instance, with 4K io's every sg io that is
> dma_aligned for direct io, but not page aligned will cause slab corruption
> and an oops
>
> I am able to run a number of tests with sg that cause the boundary to be
> crossed, and with this fix there is no slab corruption or data corruption.
>
> Thanks Dan, I had been hunting for this for a couple of days!!
>
> Thoughts??
>
> Signed-off-by: Bryan Holty <lgeek@frontiernet.net>
>
>  --- a/drivers/scsi/scsi_lib.c  2006-03-03 13:17:22.000000000 -0600
> +++ b/drivers/scsi/scsi_lib.c   2006-03-22 06:09:09.669599539 -0600
> @@ -368,7 +368,7 @@
>                            int nsegs, unsigned bufflen, gfp_t gfp)
>  {
>         struct request_queue *q = rq->q;
> -       int nr_pages = (bufflen + PAGE_SIZE - 1) >> PAGE_SHIFT;
> +       int nr_pages = (bufflen + sgl[0].offset + PAGE_SIZE - 1) >> PAGE_SHIFT;
>         unsigned int data_len = 0, len, bytes, off;
>         struct page *page;
>         struct bio *bio = NULL;
>
