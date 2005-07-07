Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261333AbVGGMoT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261333AbVGGMoT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Jul 2005 08:44:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261447AbVGGMmo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Jul 2005 08:42:44 -0400
Received: from [203.171.93.254] ([203.171.93.254]:38820 "EHLO
	cunningham.myip.net.au") by vger.kernel.org with ESMTP
	id S261333AbVGGMjh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Jul 2005 08:39:37 -0400
Subject: Re: [PATCH] [46/48] Suspend2 2.1.9.8 for 2.6.12:
	622-swapwriter.patch
From: Nigel Cunningham <ncunningham@cyclades.com>
Reply-To: ncunningham@cyclades.com
To: Pekka Enberg <penberg@gmail.com>
Cc: Nigel Cunningham <nigel@suspend2.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Pekka Enberg <penberg@cs.helsinki.fi>
In-Reply-To: <84144f0205070523332cc6d487@mail.gmail.com>
References: <11206164393426@foobar.com> <11206164442712@foobar.com>
	 <84144f0205070523332cc6d487@mail.gmail.com>
Content-Type: text/plain
Organization: Cycades
Message-Id: <1120740053.4860.1494.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Thu, 07 Jul 2005 22:40:57 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Wed, 2005-07-06 at 16:33, Pekka Enberg wrote:
> On 7/6/05, Nigel Cunningham <nigel@suspend2.net> wrote:
> > diff -ruNp 623-generic-block-io.patch-old/kernel/power/suspend_block_io.c 623-generic-block-io.patch-new/kernel/power/suspend_block_io.c
> > --- 623-generic-block-io.patch-old/kernel/power/suspend_block_io.c      1970-01-01 10:00:00.000000000 +1000
> > +++ 623-generic-block-io.patch-new/kernel/power/suspend_block_io.c      2005-07-05 23:48:59.000000000 +1000
> > @@ -0,0 +1,817 @@
> > +#include "suspend2_core/suspend.h"
> > +#include "suspend2_core/proc.h"
> > +#include "suspend2_core/plugins.h"
> > +#include "suspend2_core/utility.h"
> > +#include "suspend2_core/prepare_image.h"
> 
> You've got circular dependencies. kernel/power/suspend2_core depends
> on kernel/power and vice versa. Please just consider putting them all
> in kernel/power/

Done. They were separate just to keep things tidy.

> > +/* Bits in struct io_info->flags */
> > +#define IO_WRITING 1
> > +#define IO_RESTORE_PAGE_PROT 2
> > +#define IO_AWAITING_READ 3
> > +#define IO_AWAITING_WRITE 4
> > +#define IO_AWAITING_SUBMIT 5
> > +#define IO_AWAITING_CLEANUP 6
> > +#define IO_HANDLE_PAGE_PROT 7
> 
> Please use enums instead.

Done!

> > +
> > +#define MAX_OUTSTANDING_IO 1024
> > +
> > +/*
> > + * ---------------------------------------------------------------
> > + *
> > + *     IO in progress information storage and helpers
> > + *
> > + * ---------------------------------------------------------------
> > + */
> 
> Could we please drop the above banner. Hurts my eyes...

Sorry! :>

> > +
> > +struct io_info {
> > +       struct bio * sys_struct;
> > +       long block[PAGE_SIZE/512];
> 
> You're hardcoding sector size here, no?

As others do.

> > +       struct page * buffer_page;
> > +       struct page * data_page;
> > +       unsigned long flags;
> > +       struct block_device * dev;
> > +       struct list_head list;
> > +       int readahead_index;
> > +       struct work_struct work;
> > +};
> > +
> > +/* Locks separated to allow better SMP support.
> > + * An io_struct moves through the lists as follows.
> > + * free -> submit_batch -> busy -> ready_for_cleanup -> free
> > + */
> > +static LIST_HEAD(ioinfo_free);
> > +static spinlock_t ioinfo_free_lock = SPIN_LOCK_UNLOCKED;
> 
> Please use DEFINE_SPINLOCK instead. It is preferred as some automatic
> lock checkers need it.

Done.

> > +#define BITS_PER_UL (8 * sizeof(unsigned long))
> > +static volatile unsigned long suspend_readahead_flags[(MAX_READAHEAD + BITS_PER_UL - 1) / BITS_PER_UL];
> 
> <asm/types.h> has BITS_PER_LONG. Use it.

Thanks for educating the ignorant :>

> > +static int suspend_end_bio(struct bio * bio, unsigned int num, int err)
> > +{
> > +       struct io_info *io_info = (struct io_info *) bio->bi_private;
> 
> Redundant cast.

k.

> > +static unsigned long suspend_bio_memory_needed(void)
> > +{
> > +       /* We want to have at least enough memory so as to have 128 I/O
> > +        * transactions on the fly at once. If we can to more, fine. */
> > +       return (128 * (PAGE_SIZE + sizeof(struct request) +
> > +                               sizeof(struct bio) + sizeof(struct io_info)));
> 
> Where did the magic 128 come from?

My bad. Should be MAX_OUTSTANDING_IO.

Thanks, once again!

Nigel

-- 
Evolution.
Enumerate the requirements.
Consider the interdependencies.
Calculate the probabilities.
Be amazed that people believe it happened. 

