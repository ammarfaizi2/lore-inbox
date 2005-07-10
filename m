Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262006AbVGJSSt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262006AbVGJSSt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Jul 2005 14:18:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262008AbVGJSSt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Jul 2005 14:18:49 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:22246 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262006AbVGJSSq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Jul 2005 14:18:46 -0400
Date: Sun, 10 Jul 2005 20:18:52 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Nigel Cunningham <nigel@suspend2.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [39/48] Suspend2 2.1.9.8 for 2.6.12: 615-poweroff.patch
Message-ID: <20050710181851.GH10904@elf.ucw.cz>
References: <11206164393426@foobar.com> <11206164431370@foobar.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11206164431370@foobar.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> @@ -0,0 +1,585 @@
> +/*
> + * kernel/power/prepare_image.c
> + *
> + * Copyright (C) 2003-2005 Nigel Cunningham <nigel@suspend.net>
> + *
> + * This file is released under the GPLv2.
> + *
> + * We need to eat memory until we can:
> + * 1. Perform the save without changing anything (RAM_NEEDED < max_mapnr)
> + * 2. Fit it all in available space (active_writer->available_space() >= STORAGE_NEEDED)
> + * 3. Reload the pagedir and pageset1 to places that don't collide with their
> + *    final destinations, not knowing to what extent the resumed kernel will
> + *    overlap with the one loaded at boot time. I think the resumed kernel should overlap
> + *    completely, but I don't want to rely on this as it is an unproven assumption. We
> + *    therefore assume there will be no overlap at all (worse case).
> + * 4. Meet the user's requested limit (if any) on the size of the image.
> + *    The limit is in MB, so pages/256 (assuming 4K pages).
> + *
> + *    (Final test in save_image doesn't use EATEN_ENOUGH_MEMORY)
> + */

Can you just fix/use shrink_all_memory().

> +#define EATEN_ENOUGH_MEMORY() (amount_needed(1) < 1)

Hmm...

> +static int arefrozen = 0, numnosave = 0;

Missing _s.

> +/* display_stats
> + *
> + * Display the vital statistics.of the image.
> + */
> +#ifdef CONFIG_PM_DEBUG
> +static void display_stats(void)
> +{ 
> +	storage_allocated = active_writer->ops.writer.storage_allocated();
> +	suspend_message(SUSPEND_EAT_MEMORY, SUSPEND_MEDIUM, 1,
> +		"Free:%d(%d). Sets:%d(%d),%d(%d). Nosave:%d-%d=%d. Storage:%d/%d+%d=%d(%lu). Needed:%d|%d|%d.\n", 
> +		
> +		/* Free */
> +		real_nr_free_pages(),
> +		real_nr_free_pages() - nr_free_highpages(),
> +		
> +		/* Sets */
> +		pageset1_size, pageset1_sizelow,
> +		pageset2_size, pageset2_sizelow,
> +
> +		/* Nosave */
> +		numnosave, extra_pagedir_pages_allocated,
> +		numnosave - extra_pagedir_pages_allocated,
> +
> +		/* Storage */
> +		storage_allocated,
> +		MAIN_STORAGE_NEEDED(1), HEADER_STORAGE_NEEDED,
> +		STORAGE_NEEDED(1),
> +		storage_available,
> +
> +		/* Needed */
> +		RAM_TO_SUSPEND - real_nr_free_pages() - nr_free_highpages(),
> +		STORAGE_NEEDED(1) - storage_available, 
> +		(image_size_limit > 0) ? (STORAGE_NEEDED(1) - (image_size_limit << 8)) : 0);
> +}
> +#else
> +#define display_stats() do { } while(0)
> +#endif

Is this kind of debugging neccessary any more?

> +#define MIN_FREE_RAM (max_low_pfn >> 7)
> +
> +#define EXTRA_PD1_PAGES_ALLOWANCE 100
> +
> +#define MAIN_STORAGE_NEEDED(USE_ECR) \
> +	((pageset1_size + pageset2_size + 100 + \
> +	  EXTRA_PD1_PAGES_ALLOWANCE) * \
> +	 (USE_ECR ? expected_compression_ratio() : 100) / 100)
> +
> +#define HEADER_BYTES_NEEDED \
> +	((extents_allocated * 2 * sizeof(unsigned long)) + \
> +	 sizeof(struct suspend_header) + \
> +	 sizeof(struct plugin_header) + \
> +	 (int) header_storage_for_plugins() + \
> +	 (PAGES_PER_BITMAP << PAGE_SHIFT) + \
> +	 num_plugins * \
> +	 	(sizeof(struct plugin_header) + sizeof(int)))
> +	
> +#define HEADER_STORAGE_NEEDED ((int) ((HEADER_BYTES_NEEDED + (int) PAGE_SIZE - 1) >> PAGE_SHIFT))
> +
> +#define STORAGE_NEEDED(USE_ECR) \
> +	(MAIN_STORAGE_NEEDED(USE_ECR) + HEADER_STORAGE_NEEDED)
> +
> +#define RAM_TO_SUSPEND (1 + max((pageset1_size + EXTRA_PD1_PAGES_ALLOWANCE - pageset2_sizelow), 0) + \
> +		MIN_FREE_RAM + memory_for_plugins())

Can we convert this to inline functions or something?

								Pavel
-- 
teflon -- maybe it is a trademark, but it should not be.
