Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261258AbVGLIad@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261258AbVGLIad (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 04:30:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261267AbVGLIac
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 04:30:32 -0400
Received: from [203.171.93.254] ([203.171.93.254]:63693 "EHLO
	cunningham.myip.net.au") by vger.kernel.org with ESMTP
	id S261258AbVGLIaT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 04:30:19 -0400
Subject: Re: [PATCH] [39/48] Suspend2 2.1.9.8 for 2.6.12: 615-poweroff.patch
From: Nigel Cunningham <ncunningham@cyclades.com>
Reply-To: ncunningham@cyclades.com
To: Pavel Machek <pavel@ucw.cz>
Cc: Nigel Cunningham <nigel@suspend2.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20050710181851.GH10904@elf.ucw.cz>
References: <11206164393426@foobar.com> <11206164431370@foobar.com>
	 <20050710181851.GH10904@elf.ucw.cz>
Content-Type: text/plain
Organization: Cycades
Message-Id: <1121157119.13869.120.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Tue, 12 Jul 2005 18:31:59 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Mon, 2005-07-11 at 04:18, Pavel Machek wrote:
> Hi!
> 
> > @@ -0,0 +1,585 @@
> > +/*
> > + * kernel/power/prepare_image.c
> > + *
> > + * Copyright (C) 2003-2005 Nigel Cunningham <nigel@suspend.net>
> > + *
> > + * This file is released under the GPLv2.
> > + *
> > + * We need to eat memory until we can:
> > + * 1. Perform the save without changing anything (RAM_NEEDED < max_mapnr)
> > + * 2. Fit it all in available space (active_writer->available_space() >= STORAGE_NEEDED)
> > + * 3. Reload the pagedir and pageset1 to places that don't collide with their
> > + *    final destinations, not knowing to what extent the resumed kernel will
> > + *    overlap with the one loaded at boot time. I think the resumed kernel should overlap
> > + *    completely, but I don't want to rely on this as it is an unproven assumption. We
> > + *    therefore assume there will be no overlap at all (worse case).
> > + * 4. Meet the user's requested limit (if any) on the size of the image.
> > + *    The limit is in MB, so pages/256 (assuming 4K pages).
> > + *
> > + *    (Final test in save_image doesn't use EATEN_ENOUGH_MEMORY)
> > + */
> 
> Can you just fix/use shrink_all_memory().

We are using shrink_all_memory now. We just try to be intelligent about
how much memory gets freed. Most of the time, very little needs to be
released in order to suspend, and you get a more responsive system than
if you free all and sundry and then have to swap it back in post-resume.
If the use really wants to emulate swsusp and free everything they can,
they can just set the imagesize limit to 1MB. (It's a soft limit).

> > +#define EATEN_ENOUGH_MEMORY() (amount_needed(1) < 1)
> 
> Hmm...
> 
> > +static int arefrozen = 0, numnosave = 0;
> 
> Missing _s.

Fixed. Thanks.

> > +/* display_stats
> > + *
> > + * Display the vital statistics.of the image.
> > + */
> > +#ifdef CONFIG_PM_DEBUG
> > +static void display_stats(void)
> > +{ 
> > +	storage_allocated = active_writer->ops.writer.storage_allocated();
> > +	suspend_message(SUSPEND_EAT_MEMORY, SUSPEND_MEDIUM, 1,
> > +		"Free:%d(%d). Sets:%d(%d),%d(%d). Nosave:%d-%d=%d. Storage:%d/%d+%d=%d(%lu). Needed:%d|%d|%d.\n", 
> > +		
> > +		/* Free */
> > +		real_nr_free_pages(),
> > +		real_nr_free_pages() - nr_free_highpages(),
> > +		
> > +		/* Sets */
> > +		pageset1_size, pageset1_sizelow,
> > +		pageset2_size, pageset2_sizelow,
> > +
> > +		/* Nosave */
> > +		numnosave, extra_pagedir_pages_allocated,
> > +		numnosave - extra_pagedir_pages_allocated,
> > +
> > +		/* Storage */
> > +		storage_allocated,
> > +		MAIN_STORAGE_NEEDED(1), HEADER_STORAGE_NEEDED,
> > +		STORAGE_NEEDED(1),
> > +		storage_available,
> > +
> > +		/* Needed */
> > +		RAM_TO_SUSPEND - real_nr_free_pages() - nr_free_highpages(),
> > +		STORAGE_NEEDED(1) - storage_available, 
> > +		(image_size_limit > 0) ? (STORAGE_NEEDED(1) - (image_size_limit << 8)) : 0);
> > +}
> > +#else
> > +#define display_stats() do { } while(0)
> > +#endif
> 
> Is this kind of debugging neccessary any more?

Not very often. Removed. I can re-add when necessary.

> > +#define MIN_FREE_RAM (max_low_pfn >> 7)
> > +
> > +#define EXTRA_PD1_PAGES_ALLOWANCE 100
> > +
> > +#define MAIN_STORAGE_NEEDED(USE_ECR) \
> > +	((pageset1_size + pageset2_size + 100 + \
> > +	  EXTRA_PD1_PAGES_ALLOWANCE) * \
> > +	 (USE_ECR ? expected_compression_ratio() : 100) / 100)
> > +
> > +#define HEADER_BYTES_NEEDED \
> > +	((extents_allocated * 2 * sizeof(unsigned long)) + \
> > +	 sizeof(struct suspend_header) + \
> > +	 sizeof(struct plugin_header) + \
> > +	 (int) header_storage_for_plugins() + \
> > +	 (PAGES_PER_BITMAP << PAGE_SHIFT) + \
> > +	 num_plugins * \
> > +	 	(sizeof(struct plugin_header) + sizeof(int)))
> > +	
> > +#define HEADER_STORAGE_NEEDED ((int) ((HEADER_BYTES_NEEDED + (int) PAGE_SIZE - 1) >> PAGE_SHIFT))
> > +
> > +#define STORAGE_NEEDED(USE_ECR) \
> > +	(MAIN_STORAGE_NEEDED(USE_ECR) + HEADER_STORAGE_NEEDED)
> > +
> > +#define RAM_TO_SUSPEND (1 + max((pageset1_size + EXTRA_PD1_PAGES_ALLOWANCE - pageset2_sizelow), 0) + \
> > +		MIN_FREE_RAM + memory_for_plugins())
> 
> Can we convert this to inline functions or something?

Done.

Regards,

Nigel
-- 
Evolution.
Enumerate the requirements.
Consider the interdependencies.
Calculate the probabilities.
Be amazed that people believe it happened. 

