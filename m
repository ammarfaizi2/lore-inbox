Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751823AbWCBITz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751823AbWCBITz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 03:19:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751882AbWCBITz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 03:19:55 -0500
Received: from wproxy.gmail.com ([64.233.184.193]:31195 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751823AbWCBITy convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 03:19:54 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=l3spNDrfnOIw0qSgK2YKbXQYxW1XGJyLfO+XtZlzVX/vP/w3sYhObH8Q6DdFQa8pEwvqJB8ktV43Px1/5XITifFjTgOqsA+JiMZmVbYSPCmVxOWviHnNIITav/1YGbE8nHs7vNMCKH4zr7BV1AEjyhrWEGyKQElOCNCMcIWEJ+M=
Message-ID: <d6fe45ba0603020019td998ba5we1cb2b689d459e1a@mail.gmail.com>
Date: Thu, 2 Mar 2006 09:19:53 +0100
From: "matteo brancaleoni" <mbrancaleoni@gmail.com>
To: "Neil Brown" <neilb@suse.de>
Subject: Re: Bio & Biovec-1 increasing cache size, never freed during disk IO
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <17414.36065.898271.383401@cse.unsw.edu.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <d6fe45ba0602251245h32b9ac5dw65246ed6e1bba607@mail.gmail.com>
	 <d6fe45ba0602271238q10fea0f8tfc29f0d51c4df1c8@mail.gmail.com>
	 <17411.33114.403066.812228@cse.unsw.edu.au>
	 <d6fe45ba0602280705l6f38f1b8j3126d0be638be8fa@mail.gmail.com>
	 <17412.56916.247822.749271@cse.unsw.edu.au>
	 <d6fe45ba0603010246j15132126x3cb233092319c772@mail.gmail.com>
	 <17414.36065.898271.383401@cse.unsw.edu.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

no, the CONFIG_DEBUG_SLAB was not set.

Thanks for the new patch, compiling now.
I'll let you know asap.

Thanks a lot for the help,

Matteo.

On 3/2/06, Neil Brown <neilb@suse.de> wrote:
> On Wednesday March 1, mbrancaleoni@gmail.com wrote:
> > Hi Neil.
> >
> > unfortunately the patch does nothing, the problem persists.
> > Tested with 2.6.16-rc5.
> > (I've double checked if the patch was applied correctly)
> >
> > Can I do anything to be of some more help?
>
> Yes, try another patch. :-)  and tell me if you have CONFIG_DEBUG_SLAB
> set... there was another use-after-free bug which CONFIG_DEBUG_SLAB
> would have made worse.
>
> This patch should fix it all up.
>
> Thanks again,
> NeilBrown
>
>
> Signed-off-by: Neil Brown <neilb@suse.de>
>
> ### Diffstat output
>  ./drivers/md/raid1.c |   13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
>
> diff ./drivers/md/raid1.c~current~ ./drivers/md/raid1.c
> --- ./drivers/md/raid1.c~current~       2006-02-27 11:52:18.000000000 +1100
> +++ ./drivers/md/raid1.c        2006-03-01 10:44:49.000000000 +1100
> @@ -306,6 +306,7 @@ static int raid1_end_write_request(struc
>         r1bio_t * r1_bio = (r1bio_t *)(bio->bi_private);
>         int mirror, behind = test_bit(R1BIO_BehindIO, &r1_bio->state);
>         conf_t *conf = mddev_to_conf(r1_bio->mddev);
> +       struct bio *to_put = NULL;
>
>         if (bio->bi_size)
>                 return 1;
> @@ -323,6 +324,7 @@ static int raid1_end_write_request(struc
>                  * this branch is our 'one mirror IO has finished' event handler:
>                  */
>                 r1_bio->bios[mirror] = NULL;
> +               to_put = bio;
>                 if (!uptodate) {
>                         md_error(r1_bio->mddev, conf->mirrors[mirror].rdev);
>                         /* an I/O failed, we can't clear the bitmap */
> @@ -375,7 +377,7 @@ static int raid1_end_write_request(struc
>                         /* Don't dec_pending yet, we want to hold
>                          * the reference over the retry
>                          */
> -                       return 0;
> +                       goto out;
>                 }
>                 if (test_bit(R1BIO_BehindIO, &r1_bio->state)) {
>                         /* free extra copy of the data pages */
> @@ -392,10 +394,11 @@ static int raid1_end_write_request(struc
>                 raid_end_bio_io(r1_bio);
>         }
>
> -       if (r1_bio->bios[mirror]==NULL)
> -               bio_put(bio);
> -
>         rdev_dec_pending(conf->mirrors[mirror].rdev, conf->mddev);
> + out:
> +       if (to_put)
> +               bio_put(to_put);
> +
>         return 0;
>  }
>
> @@ -857,7 +860,7 @@ static int make_request(request_queue_t
>         atomic_set(&r1_bio->remaining, 0);
>         atomic_set(&r1_bio->behind_remaining, 0);
>
> -       do_barriers = bio->bi_rw & BIO_RW_BARRIER;
> +       do_barriers = bio_barrier(bio);
>         if (do_barriers)
>                 set_bit(R1BIO_Barrier, &r1_bio->state);
>
>
