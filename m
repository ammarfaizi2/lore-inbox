Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264340AbTEHAZs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 20:25:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264386AbTEHAZs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 20:25:48 -0400
Received: from hypatia.llnl.gov ([134.9.11.73]:20096 "EHLO hypatia.llnl.gov")
	by vger.kernel.org with ESMTP id S264340AbTEHAZq convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 20:25:46 -0400
Content-Type: text/plain; charset=US-ASCII
From: Dave Peterson <dsp@llnl.gov>
Organization: Lawrence Livermore National Laboratory
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: Re: [PATCH] fixes for linked list bugs in block I/O code
Date: Wed, 7 May 2003 17:38:09 -0700
User-Agent: KMail/1.4.1
Cc: linux-kernel@vger.kernel.org, axboe@suse.de, davej@suse.de
References: <Pine.SOL.4.30.0305080214580.5113-100000@mion.elka.pw.edu.pl>
In-Reply-To: <Pine.SOL.4.30.0305080214580.5113-100000@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200305071738.09209.dsp@llnl.gov>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 07 May 2003 05:26 pm, Bartlomiej Zolnierkiewicz wrote:
> On Wed, 7 May 2003, Dave Peterson wrote:
> > On Wednesday 07 May 2003 04:42 pm, Bartlomiej Zolnierkiewicz wrote:
> > > > ========== START OF 2.5.69 PATCH FOR drivers/block/ll_rw_blk.c
> > > > =========== --- ll_rw_blk.c.old     Wed May  7 15:55:18 2003
> > > > +++ ll_rw_blk.c.new     Wed May  7 16:01:56 2003
> > > > @@ -1721,6 +1721,7 @@
> > > >                                 break;
> > > >                         }
> > > >
> > > > +                       bio->bi_next = req->biotail->bi_next;
> > >
> > > This is simply wrong, look at the line below.
> > >
> > > >                         req->biotail->bi_next = bio;
> > >
> > > req->bio - first bio
> > > req->bio->bi_next - next bio
> > > ...
> > > req->biotail - last bio
> > >
> > > so req->biotail->bi_next should be NULL
> >
> > I believe it is correct.  Assuming that the list is initially in a
> > sane state, req->biotail->bi_next will be NULL immediately before
> > executing the statement that I added.  Therefore, my fix will set
> > bio->bi_next to NULL, which is what we want because bio becomes the
> > new end of the list.
>
> Yes, but bio->bi_next is a NULL already.

I think assuming this is bad programming form.  You are assuming that
the memory allocator zeros out newly allocated memory.  Though your
assumption may be correct, it's always possible that this behavior will
change some day (perhaps for efficiency reasons), causing your code
to break.  In my opinion, the savings of a few cpu clock cycles that
you gain by omitting the initialization isn't worth compromising
the robustness of your code.

-Dave
