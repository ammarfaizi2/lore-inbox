Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287860AbSAYXHE>; Fri, 25 Jan 2002 18:07:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288759AbSAYXGy>; Fri, 25 Jan 2002 18:06:54 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:37892 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S288742AbSAYXGu>;
	Fri, 25 Jan 2002 18:06:50 -0500
Date: Sat, 26 Jan 2002 00:06:00 +0100
From: Jens Axboe <axboe@suse.de>
To: Badari Pulavarty <pbadari@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, andrea@suse.de, suparna@in.ibm.com,
        gerrit@us.ibm.com
Subject: Re: BIO usage questions
Message-ID: <20020126000600.F1296@suse.de>
In-Reply-To: <200201252159.g0PLxun17423@eng2.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200201252159.g0PLxun17423@eng2.beaverton.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 25 2002, Badari Pulavarty wrote:
> Hi,
> 
> I have few questions on usage of "bio" in 2.5.X.
> 
> 1) It is acceptable to use "bio" instead of "kio" for doing RAW IO
>    and direct IO ? Currently, "kio" are getting converted to "bio"
>    anywhy. why not use "bio" directly ?
> 
>    I am planning to do this. But I was wondering what are the issues
>    here.

Sure you can do that, you would probably have to provide quite a bit of
the mapping infrastructure (or make it generic, probably Ben's work in
this area would be the best way forward). But bio is a generic container
for block I/O, and you are allowed to use it directly.

> 2) I don't see how to wait for a "bio" to complete. I don't see any
>    wait_queue in bio structure. How can I wait for bio to complete ?

allocate a private bio, and you 'own' the bi_private and bi_end_io. So
you could do something ala

	DECLARE_COMPLETION(wait);

	bio = bio_alloc(GFP_XXX, 1);
	/* fill in bvec, target, etc */
	bio->bi_private = &wait;
	bio->bi_end_io = my_end_io;

	...

	wait_for_completion(&wait);

int my_end_io(struct bio *bio, int nr_sectors)
{
	struct completion *wait = bio->bi_private;

	/* do end i/o stuff */
	...

	/* wake up waiters */
	complete(wait);
	return 0;
}

-- 
Jens Axboe

