Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265072AbSJRL3Q>; Fri, 18 Oct 2002 07:29:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265074AbSJRL3Q>; Fri, 18 Oct 2002 07:29:16 -0400
Received: from zero.aec.at ([193.170.194.10]:39953 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id <S265072AbSJRL3P>;
	Fri, 18 Oct 2002 07:29:15 -0400
To: "Samium Gromoff" <_deepfire@mail.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5 and lowmemory boxens
References: <E182V29-000Pfa-00@f15.mail.ru>
From: Andi Kleen <ak@muc.de>
Date: 18 Oct 2002 13:35:04 +0200
In-Reply-To: <E182V29-000Pfa-00@f15.mail.ru>
Message-ID: <m37kggyo7r.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Samium Gromoff" <_deepfire@mail.ru> writes:

>    first: i`ve successfully ran 2.5.43 on a 386sx20/4M ram notebook.
> 
>  the one problem was the ppp over serial not working, but i suspect
>  that it just needs to be recompiled with 2.5 headers (am i right?).
> 
>  the other was, well, the fact that ultra-stripped 2.5.43
>  still used 200k more memory than 2.4.19, and thats despite it was
>  compiled with -Os instead of -O2.
>  actually it was 2000k free with 2.4 vs 1800k  free with 2.5
> 
>  i know Rik had plans of some ultra bloody embedded/lowmem
>  changes for such cases. i`d like to hear about things in the area :)

I would start with clamping down all the hash tables. A lot of code
does something like: 

        mempages *= sizeof(struct list_head);
        for (order = 0; ((1UL << order) << PAGE_SHIFT) < mempages; order++)
                ;

        do {
                unsigned long tmp;

                nr_hash = (1UL << order) * PAGE_SIZE /
                        sizeof(struct list_head);
                d_hash_mask = (nr_hash - 1);

                tmp = nr_hash;
                d_hash_shift = 0;
                while ((tmp >>= 1UL) != 0UL)
                        d_hash_shift++;

                dentry_hashtable = (struct list_head *)
                        __get_free_pages(GFP_ATOMIC, order);
        } while (dentry_hashtable == NULL && --order >= 0);

which usually results in too big hash tables.

Unfortunately this isn't a common function that can be tuned centrally
(it *really* should be). But you could grep for hash and change them
all to only use a single page or even less. 

More text size could be saved by going through the header files and
uninlining bigger functions.

When you have lots of daemons that hang around in select() or poll()
then it's possible to save 8K for each of them by applying a patch
that allocates data for small select on the stack.

Also Linux by default doesn't use the area in 640k-1MB. If you know
the exact mappings there on your box or trust your e820 table then
you can change setup.c to use the free areas in there.

-Andi
