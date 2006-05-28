Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750991AbWE1WEW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750991AbWE1WEW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 May 2006 18:04:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750993AbWE1WEW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 May 2006 18:04:22 -0400
Received: from py-out-1112.google.com ([64.233.166.181]:29789 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1750988AbWE1WEV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 May 2006 18:04:21 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=e7DY3qvAUIyy3qrwh/XqjBH0/ZBwd75Q3AP5cYW3D+5stAbSHDWmdrAdNbVfHiioDmEzoBHgrUPCwrmabtnZf8JQbCW2XHzO60Fz22ajASU4yctZWT/7Euzuz2Ubec5E8HCiOmeE1YHL3TrPHaP1DB/ww10g87fpnZBGAA/nl0M=
Message-ID: <aa4c40ff0605281504w522953f5x63686e898c3a3bc3@mail.gmail.com>
Date: Sun, 28 May 2006 15:04:20 -0700
From: "James Lamanna" <jlamanna@gmail.com>
To: "Kai Makisara" <Kai.Makisara@kolumbus.fi>
Subject: Re: [OOPS] amrestore dies in kmem_cache_free 2.6.16.18 - cannot restore backups!
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
       "Mike Christie" <michaelc@cs.wisc.edu>,
       "Bryan Holty" <lgeek@frontiernet.net>
In-Reply-To: <Pine.LNX.4.63.0605271202110.10358@kai.makisara.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <aa4c40ff0605231824j55c998c3oe427dec2404afba0@mail.gmail.com>
	 <Pine.LNX.4.63.0605252224450.4178@kai.makisara.local>
	 <Pine.LNX.4.63.0605271202110.10358@kai.makisara.local>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/27/06, Kai Makisara <Kai.Makisara@kolumbus.fi> wrote:

[SNIP]

>
>
> Next thing was to patch 2.6.16.18 with the patch at the end: No more
> oopses with any alignment.
>
> James, does this fix your problem ?

Kai-
I'll try and see if I can test this on Tuesday.
I've been traveling for the last few days.

Thanks for your help!

-- James


>
> Kai
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
