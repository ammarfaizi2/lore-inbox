Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964909AbWCAKqE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964909AbWCAKqE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 05:46:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964913AbWCAKqD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 05:46:03 -0500
Received: from wproxy.gmail.com ([64.233.184.197]:34968 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964909AbWCAKqB convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 05:46:01 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=EMyLlM2IJOigs+PwKJeA9HcZymkMXoBOKuqT4qjJ6ls++p8v5PiLfWfAfIMTOs1pqIxVg5dj9FtUIBKAZKEitP94+4Tzbrk+8p2qzXxZq1hcKmlHwGUT7zsJFIx0FcXucPkWg/HPiWFxyn5xb4y1MzkxUgu8pOkcO6rUaUzjYqM=
Message-ID: <d6fe45ba0603010246j15132126x3cb233092319c772@mail.gmail.com>
Date: Wed, 1 Mar 2006 11:46:00 +0100
From: "matteo brancaleoni" <mbrancaleoni@gmail.com>
To: "Neil Brown" <neilb@suse.de>
Subject: Re: Bio & Biovec-1 increasing cache size, never freed during disk IO
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <17412.56916.247822.749271@cse.unsw.edu.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <d6fe45ba0602251245h32b9ac5dw65246ed6e1bba607@mail.gmail.com>
	 <d6fe45ba0602271238q10fea0f8tfc29f0d51c4df1c8@mail.gmail.com>
	 <17411.33114.403066.812228@cse.unsw.edu.au>
	 <d6fe45ba0602280705l6f38f1b8j3126d0be638be8fa@mail.gmail.com>
	 <17412.56916.247822.749271@cse.unsw.edu.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Neil.

unfortunately the patch does nothing, the problem persists.
Tested with 2.6.16-rc5.
(I've double checked if the patch was applied correctly)

Can I do anything to be of some more help?

Greetings,

Matteo.

On 3/1/06, Neil Brown <neilb@suse.de> wrote:
> On Tuesday February 28, mbrancaleoni@gmail.com wrote:
> > Hi Neil,
> >
> > seems that the patch that leads to the error is the one signed up by you:
> > commit 3795bb0fc52fe2af2749f3ad2185cb9c90871ef8
> > Author: NeilBrown <neilb@suse.de>
> > Date:   Mon Dec 12 02:39:16 2005 -0800
> >
> >     [PATCH] md: fix a use-after-free bug in raid1
> >
> >     Who would submit code with a FIXME like that in it !!!!
> >
> >     Signed-off-by: Neil Brown <neilb@suse.de>
> >     Signed-off-by: Andrew Morton <akpm@osdl.org>
> >     Signed-off-by: Linus Torvalds <torvalds@osdl.org>
>
> Thanks for finding this.
>
> There are two bugs here.
> One is that if BIO_RW_BARRIER is rejected by one drive but not the
> other, then we forget to release a bio that we should have released.
>
> The other is that the test for "should we do barrier IO" was wrong so
> that even though one device doesn't support it, raid1 keeps trying it
> (but only on read-ahead requests....)
>
> It would seem that the devices in your array are not all on the same
> controller.  Is that correct?  There isn't a problem with that, but I
> just want to check my understanding of what is happening.
>
> Could you try this patch please and see if it fixes the problem?
>
> Thanks again,
> NeilBrown
>
> Signed-off-by: Neil Brown <neilb@suse.de>
>
> ### Diffstat output
>  ./drivers/md/raid1.c |    7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff ./drivers/md/raid1.c~current~ ./drivers/md/raid1.c
> --- ./drivers/md/raid1.c~current~       2006-02-27 11:52:18.000000000 +1100
> +++ ./drivers/md/raid1.c        2006-03-01 10:30:43.000000000 +1100
> @@ -375,7 +375,7 @@ static int raid1_end_write_request(struc
>                         /* Don't dec_pending yet, we want to hold
>                          * the reference over the retry
>                          */
> -                       return 0;
> +                       goto out;
>                 }
>                 if (test_bit(R1BIO_BehindIO, &r1_bio->state)) {
>                         /* free extra copy of the data pages */
> @@ -392,10 +392,11 @@ static int raid1_end_write_request(struc
>                 raid_end_bio_io(r1_bio);
>         }
>
> +       rdev_dec_pending(conf->mirrors[mirror].rdev, conf->mddev);
> + out:
>         if (r1_bio->bios[mirror]==NULL)
>                 bio_put(bio);
>
> -       rdev_dec_pending(conf->mirrors[mirror].rdev, conf->mddev);
>         return 0;
>  }
>
> @@ -857,7 +858,7 @@ static int make_request(request_queue_t
>         atomic_set(&r1_bio->remaining, 0);
>         atomic_set(&r1_bio->behind_remaining, 0);
>
> -       do_barriers = bio->bi_rw & BIO_RW_BARRIER;
> +       do_barriers = bio_barrier(bio);
>         if (do_barriers)
>                 set_bit(R1BIO_Barrier, &r1_bio->state);
>
>
