Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129351AbRBJLfW>; Sat, 10 Feb 2001 06:35:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129751AbRBJLfN>; Sat, 10 Feb 2001 06:35:13 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:12293 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S129351AbRBJLfF>; Sat, 10 Feb 2001 06:35:05 -0500
Date: Sat, 10 Feb 2001 07:46:14 -0200 (BRST)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Mike Galbraith <mikeg@wen-online.de>
cc: Rik van Riel <riel@conectiva.com.br>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.1-ac7
In-Reply-To: <Pine.Linu.4.10.10102100958090.1007-100000@mikeg.weiden.de>
Message-ID: <Pine.LNX.4.21.0102100727350.27389-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 10 Feb 2001, Mike Galbraith wrote:

> Hi Rik,
> 
> This change makes my box swap madly under load.  It appears to be
> keeping more cache around than is really needed, and therefore
> having to resort to swap instead.  The result is MUCH more I/O than
> previous kernels while doing the same exact job.
> 
> My test load is make -jN bzImage.  Previous kernels kept cache at
> an average of ~20ish mb at a job level N at which level I had nearly
> zero measurable throughput loss compared to single task compile.
> 
> >>From that, I surmise that the cachable component of this job must
> fit in that roughly 20ish mb of space.  (for otherwise, I would be
> suffering throughput loss).  With this vm change, cache is nearly
> three times as large as usual.  Where 30 tasks will run with only
> modest throughput loss in ac5, ac8 throughput tapers off rapidly
> at half of that.

Swapped out pages were not being counted in the flushing limitation.

Could you try the following patch? 

Thanks

--- linux.orig/mm/vmscan.c      Sat Feb 10 08:26:17 2001
+++ linux/mm/vmscan.c   Sat Feb 10 09:34:20 2001
@@ -515,6 +515,7 @@

                        writepage(page);
                        flushed_pages++;
+                       max_launder--;
                        page_cache_release(page);

                        /* And re-start the thing.. */


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
