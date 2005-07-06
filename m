Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262196AbVGFIJn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262196AbVGFIJn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 04:09:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262176AbVGFIGR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 04:06:17 -0400
Received: from nproxy.gmail.com ([64.233.182.203]:50854 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262157AbVGFGdf convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Jul 2005 02:33:35 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=c58oF64/NT3aBvgqk66O6EhFLvtCe+soOar9/8Wt/LstBGCyiA8eNiOc5yI6tJPWnHuvIrvK+1OoJ66MKaPwELtHQCo9kTe9cEsrpUohTMGn5wxIPwYbLPBNwhzydeHFph/m+xPMJcpKJk6iAq4g8JyUliyPVA+DkChX4AMotPs=
Message-ID: <84144f0205070523332cc6d487@mail.gmail.com>
Date: Wed, 6 Jul 2005 09:33:31 +0300
From: Pekka Enberg <penberg@gmail.com>
Reply-To: Pekka Enberg <penberg@gmail.com>
To: Nigel Cunningham <nigel@suspend2.net>
Subject: Re: [PATCH] [46/48] Suspend2 2.1.9.8 for 2.6.12: 622-swapwriter.patch
Cc: linux-kernel@vger.kernel.org, Pekka Enberg <penberg@cs.helsinki.fi>
In-Reply-To: <11206164442712@foobar.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <11206164393426@foobar.com> <11206164442712@foobar.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/6/05, Nigel Cunningham <nigel@suspend2.net> wrote:
> diff -ruNp 623-generic-block-io.patch-old/kernel/power/suspend_block_io.c 623-generic-block-io.patch-new/kernel/power/suspend_block_io.c
> --- 623-generic-block-io.patch-old/kernel/power/suspend_block_io.c      1970-01-01 10:00:00.000000000 +1000
> +++ 623-generic-block-io.patch-new/kernel/power/suspend_block_io.c      2005-07-05 23:48:59.000000000 +1000
> @@ -0,0 +1,817 @@
> +#include "suspend2_core/suspend.h"
> +#include "suspend2_core/proc.h"
> +#include "suspend2_core/plugins.h"
> +#include "suspend2_core/utility.h"
> +#include "suspend2_core/prepare_image.h"

You've got circular dependencies. kernel/power/suspend2_core depends
on kernel/power and vice versa. Please just consider putting them all
in kernel/power/

> +/* Bits in struct io_info->flags */
> +#define IO_WRITING 1
> +#define IO_RESTORE_PAGE_PROT 2
> +#define IO_AWAITING_READ 3
> +#define IO_AWAITING_WRITE 4
> +#define IO_AWAITING_SUBMIT 5
> +#define IO_AWAITING_CLEANUP 6
> +#define IO_HANDLE_PAGE_PROT 7

Please use enums instead.

> +
> +#define MAX_OUTSTANDING_IO 1024
> +
> +/*
> + * ---------------------------------------------------------------
> + *
> + *     IO in progress information storage and helpers
> + *
> + * ---------------------------------------------------------------
> + */

Could we please drop the above banner. Hurts my eyes...

> +
> +struct io_info {
> +       struct bio * sys_struct;
> +       long block[PAGE_SIZE/512];

You're hardcoding sector size here, no?

> +       struct page * buffer_page;
> +       struct page * data_page;
> +       unsigned long flags;
> +       struct block_device * dev;
> +       struct list_head list;
> +       int readahead_index;
> +       struct work_struct work;
> +};
> +
> +/* Locks separated to allow better SMP support.
> + * An io_struct moves through the lists as follows.
> + * free -> submit_batch -> busy -> ready_for_cleanup -> free
> + */
> +static LIST_HEAD(ioinfo_free);
> +static spinlock_t ioinfo_free_lock = SPIN_LOCK_UNLOCKED;

Please use DEFINE_SPINLOCK instead. It is preferred as some automatic
lock checkers need it.

> +#define BITS_PER_UL (8 * sizeof(unsigned long))
> +static volatile unsigned long suspend_readahead_flags[(MAX_READAHEAD + BITS_PER_UL - 1) / BITS_PER_UL];

<asm/types.h> has BITS_PER_LONG. Use it.

> +static int suspend_end_bio(struct bio * bio, unsigned int num, int err)
> +{
> +       struct io_info *io_info = (struct io_info *) bio->bi_private;

Redundant cast.

> +static void suspend_wait_on_readahead(int readahead_index)
> +{
> +       int index = readahead_index/(8 * sizeof(unsigned long));
> +       int bit = readahead_index - index * 8 * sizeof(unsigned long);

Use BITS_PER_LONG here.

> +
> +       /* read_ahead_index is the one we want to return */
> +       while (!test_bit(bit, &suspend_readahead_flags[index]))
> +               do_bio_wait(6);
> +}
> +
> +/*
> + * readahead_done
> + *
> + * Returns whether the readahead requested is ready.
> + */
> +
> +static int suspend_readahead_ready(int readahead_index)
> +{
> +       int index = readahead_index/(8 * sizeof(unsigned long));
> +       int bit = readahead_index - (index * 8 * sizeof(unsigned long));

Ditto.

> +
> +       return test_bit(bit, &suspend_readahead_flags[index]);
> +}
> +
> +/* suspend_readahead_prepare
> + * Set up for doing readahead on an image */
> +static int suspend_prepare_readahead(int index)
> +{
> +       unsigned long new_page = get_zeroed_page(GFP_ATOMIC);
> +
> +       if(!new_page)
> +               return -ENOMEM;
> +
> +       suspend_bio_ops.readahead_pages[index] = virt_to_page(new_page);
> +       return 0;
> +}
> +
> +/* suspend_readahead_cleanup
> + * Clean up structures used for readahead */
> +static void suspend_cleanup_readahead(int page)
> +{
> +       __free_pages(suspend_bio_ops.readahead_pages[page], 0);
> +       suspend_bio_ops.readahead_pages[page] = 0;
> +       return;
> +}
> +
> +static unsigned long suspend_bio_memory_needed(void)
> +{
> +       /* We want to have at least enough memory so as to have 128 I/O
> +        * transactions on the fly at once. If we can to more, fine. */
> +       return (128 * (PAGE_SIZE + sizeof(struct request) +
> +                               sizeof(struct bio) + sizeof(struct io_info)));

Where did the magic 128 come from?
