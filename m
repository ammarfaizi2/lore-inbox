Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129099AbRBLWqT>; Mon, 12 Feb 2001 17:46:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129112AbRBLWqJ>; Mon, 12 Feb 2001 17:46:09 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:58887 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S129099AbRBLWqE>; Mon, 12 Feb 2001 17:46:04 -0500
Date: Mon, 12 Feb 2001 18:56:40 -0200 (BRST)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Mike Galbraith <mikeg@wen-online.de>
cc: Rik van Riel <riel@conectiva.com.br>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.1-ac7
In-Reply-To: <Pine.Linu.4.10.10102111814140.521-100000@mikeg.weiden.de>
Message-ID: <Pine.LNX.4.21.0102121852530.29727-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 11 Feb 2001, Mike Galbraith wrote:

> On Sun, 11 Feb 2001, Rik van Riel wrote:
> 
> > On Sun, 11 Feb 2001, Mike Galbraith wrote:
> > > On Sun, 11 Feb 2001, Mike Galbraith wrote:
> > > 
> > > > Something else I see while watching it run:  MUCH more swapout than
> > > > swapin.  Does that mean we're sending pages to swap only to find out
> > > > that we never need them again?
> > > 
> > > (numbers might be more descriptive)
> > > 
> > > user  :       0:07:21.70  54.3%  page in :   142613
> > > nice  :       0:00:00.00   0.0%  page out:   155454
> > > system:       0:03:40.63  27.1%  swap in :    56334
> > > idle  :       0:02:30.50  18.5%  swap out:   149872
> > > uptime:       0:13:32.83         context :   519726
> > 
> > Indeed, in this case we send a lot more pages to swap
> > than we read back in from swap, this means that the
> > data is still sitting in swap space and was never needed
> > again.
> 
> But it looks and feels (box is I/O hyper-saturated) like
> it wrote it all to disk.
> 
> (btw, ac5 does more disk read.. ie the reduced cache size
> of earlier kernels under heavy pressure does have it's price
> with this workload.. quite visible in agregates.  looks to
> be much cheaper than swap though.. for this workload)

Mike,

Could you please try the attached patch on top of latest Rik's patch?

Thanks!

--- linux.orig/mm/vmscan.c      Sun Feb 11 07:56:29 2001
+++ linux/mm/vmscan.c   Sun Feb 11 11:05:30 2001
@@ -563,7 +566,8 @@
                        /* The buffers were not freed. */
                        if (!clearedbuf) {
                                add_page_to_inactive_dirty_list(page);
-                               flushed_pages++;
+                               if (wait)
+                                       flushed_pages++;

                        /* The page was only in the buffer cache. */
                        } else if (!page->mapping) {




-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://vger.kernel.org/lkml/
