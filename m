Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313638AbSFOEif>; Sat, 15 Jun 2002 00:38:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314101AbSFOEie>; Sat, 15 Jun 2002 00:38:34 -0400
Received: from h-64-105-136-45.SNVACAID.covad.net ([64.105.136.45]:23701 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S313638AbSFOEid>; Sat, 15 Jun 2002 00:38:33 -0400
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Fri, 14 Jun 2002 21:38:29 -0700
Message-Id: <200206150438.VAA27728@adam.yggdrasil.com>
To: linux-kernel@vger.kernel.org
Subject: Re: bio_chain: proposed solution for bio_alloc failure and large IO simplification
Cc: akpm@zip.com.au, axboe@suse.de
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I wrote:
>        Anyhow, I can write bio_chain in a separate file without
>touching changing any existing code in the kernel, if I am not going
>to implement the merge hint.  I think I will do just that so that
>we have something that we can discuss more concretely.

	In case anyone is intersted, here is a sample implementation
that compiles.  I do not know if it works.  I have renamed it
recycle_bio.  This version allocates a bio on the stack (56 bytes
on x86).  I also wrote a version that avoided the stack allocation,
but added a field "void *bi_destructor_private;" to struct bio.

Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."

/* In bio.h: */

extern struct bio *__recycle_bio(struct bio *oldbio);
static inline struct bio *recycle_bio(struct bio *oldbio,
                                      int gfp_mask, int nvecs) {
        struct bio *newbio;

        if (nvecs > oldbio->bi_max)
                BUG();

        if ((newbio = bio_alloc(gfp_mask, nvecs)) != NULL) {
                submit_bio(oldbio->bi_rw, oldbio);
                return newbio;
        } else
                return __recycle_bio(oldbio);
}


/* In bio.c: */
struct bio_completion {
        struct bio bio;
        struct completion done;
};

static void fake_destruct(struct bio *bio)
{
        struct bio_completion *stackbio;

        stackbio = list_entry(bio, struct bio_completion, bio);
        complete(&stackbio->done);
}

struct bio *__recycle_bio(struct bio *bio)
{
        struct bio_completion stackbio;

        stackbio.bio = *bio;
        stackbio.bio.bi_destructor = fake_destruct;

        init_completion(&stackbio.done);
        submit_bio(stackbio.bio.bi_rw, &stackbio.bio);
        wait_for_completion(&stackbio.done);

        return bio;
}
EXPORT_SYMBOL(__recycle_bio);

