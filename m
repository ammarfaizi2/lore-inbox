Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129183AbQK3UhG>; Thu, 30 Nov 2000 15:37:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129545AbQK3Ug4>; Thu, 30 Nov 2000 15:36:56 -0500
Received: from h24-65-192-120.cg.shawcable.net ([24.65.192.120]:754 "EHLO
        webber.adilger.net") by vger.kernel.org with ESMTP
        id <S129183AbQK3Ugp>; Thu, 30 Nov 2000 15:36:45 -0500
From: Andreas Dilger <adilger@turbolinux.com>
Message-Id: <200011302005.eAUK5re01932@webber.adilger.net>
Subject: Re: [PATCH] Re: [bug] infinite loop in generic_make_request()
In-Reply-To: <14886.7367.247491.267120@notabene.cse.unsw.edu.au>
 "from Neil Brown at Nov 30, 2000 08:24:23 pm"
To: Neil Brown <neilb@cse.unsw.edu.au>
Date: Thu, 30 Nov 2000 13:05:53 -0700 (MST)
CC: Linus Torvalds <torvalds@transmeta.com>, V Ganesh <ganesh@veritas.com>,
        linux-kernel@vger.kernel.org, linux-LVM@sistina.com, mingo@redhat.com
X-Mailer: ELM [version 2.4ME+ PL73 (25)]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Brown write:
> On Thursday November 30, ganesh@veritas.com wrote:
> > in generic_make_request(), the following code handles stacking:
> > 
> > do {
> >        q = blk_get_queue(bh->b_rdev);
> >        if (!q) {
> >                         printk(...)
> >                         buffer_IO_error(bh);
> >                         break;
> >        }
> > } while (q->make_request_fn(q, rw, bh));
> > 
> > however, make_request_fn may return -1 in case of errors. one such fn is
> > raid0_make_request(). this causes generic_make_request() to loop endlessly.
> > lvm returns 1 unconditionally, so it would also loop if an error occured in
> > lvm_map(). other bdevs might have the same problem.
> > I think a better mechanism would be to mandate that make_request_fn ought
> > to call bh->b_end_io() in case of errors and return 0.
> 
> Good catch, thanks.  Below is a patch to fix md drivers (md.c,
> linear.c and raid0.c).
> 
> NeilBrown

You need to also patch the lvm.c driver at the same time...  However, this
change now makes it very counter-intuitive compared to other kernel
functions.  Normally, we return 0 on success, and -ve on error.  Maybe
the RAID and LVM make_request functions should be changed to do that
instead (i.e. 0 on success, -ve on error, and maybe "1" if they do their
own recursion to break the loop)?

Cheers, Andreas

PS - I fixed the LVM mailing list address...
-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
