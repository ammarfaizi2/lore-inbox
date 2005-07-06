Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262221AbVGFOPj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262221AbVGFOPj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 10:15:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261794AbVGFOPj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 10:15:39 -0400
Received: from nproxy.gmail.com ([64.233.182.199]:4329 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262295AbVGFKOh convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Jul 2005 06:14:37 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=sNdW9QxynIpKSks5fw3xsMwZZba6vkP2PyBlQjwdSFj75ODh2esK9vgomEXPyrz1wOUDpM/VsZiEDBO5RyJDcotYu6w0Z4EjwKOD4mXNx3crNONa4ulTyg3sQbOB3fs7jKxeftYrye0Y/kVy8yPtGauN3nXrA00OyW5YfvMsbvA=
Message-ID: <84144f0205070603147c430dcd@mail.gmail.com>
Date: Wed, 6 Jul 2005 13:14:36 +0300
From: Pekka Enberg <penberg@gmail.com>
Reply-To: Pekka Enberg <penberg@gmail.com>
To: Nigel Cunningham <nigel@suspend2.net>
Subject: Re: [PATCH] [34/48] Suspend2 2.1.9.8 for 2.6.12: 610-extent.patch
Cc: linux-kernel@vger.kernel.org, Pekka Enberg <penberg@cs.helsinki.fi>
In-Reply-To: <1120616443531@foobar.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <11206164393426@foobar.com> <1120616443531@foobar.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/6/05, Nigel Cunningham <nigel@suspend2.net> wrote:
> diff -ruNp 611-io.patch-old/kernel/power/suspend2_core/io.c 611-io.patch-new/kernel/power/suspend2_core/io.c
> --- 611-io.patch-old/kernel/power/suspend2_core/io.c    1970-01-01 10:00:00.000000000 +1000
> +++ 611-io.patch-new/kernel/power/suspend2_core/io.c    2005-07-05 23:48:59.000000000 +1000
> @@ -0,0 +1,1006 @@
> +/*
> + * kernel/power/io.c
> + *
> + * Copyright (C) 1998-2001 Gabor Kuti <seasons@fornax.hu>
> + * Copyright (C) 1998,2001,2002 Pavel Machek <pavel@suse.cz>
                                           ^

Whitespace damage (appears elsewhere too).

> + * Copyright (C) 2002-2003 Florent Chabaud <fchabaud@free.fr>
> + * Copyright (C) 2002-2005 Nigel Cunningham <nigel@suspend2.net>
> + *

[snip]

> +       pc = size / 5;
> +
> +       /* Write the data */
> +       for (i=0; i<size; i++) {
> +               int was_mapped = 0;
> +               struct page * page = pfn_to_page(current_page_index);
> +
> +               /* Status update */
> +               if ((i+base) >= nextupdate)
> +                       nextupdate = suspend2_update_status(i + base, barmax,
> +                               " %d/%d MB ", MB(base+i+1), MB(barmax));
> +
> +               if ((i + 1) == pc) {
> +                       printk("%d%%...", 20 * step);
> +                       step++;
> +                       pc = size * step / 5;
> +               }
> +
> +               /* Write */
> +               was_mapped = suspend_map_kernel_page(page, 1);
> +               ret = first_filter->ops.filter.write_chunk(page);
> +               if (!was_mapped)
> +                       suspend_map_kernel_page(page, 0);
> +
> +               if (ret) {
> +                       printk("Write chunk returned %d.\n", ret);
> +                       abort_suspend("Failed to write a chunk of the "
> +                                       "image.");
> +                       error = -1;
> +                       goto write_pageset_free_buffers;
> +               }
> +
> +               /* Interactivity */
> +               check_shift_keys(0, NULL);
> +
> +               if (TEST_RESULT_STATE(SUSPEND_ABORTED)) {

Why is the above in upper case but test_action_state is in lower case?

> +                       abort_suspend("Aborting as requested.");
> +                       error = -1;
> +                       goto write_pageset_free_buffers;
> +               }
> +
> +               /* Prepare next */
> +               current_page_index = __get_next_bit_on(*pageflags, current_page_index);
> +       }
> +
> +       printk("done.\n");
> +
> +       suspend2_update_status(base+size, barmax, " %d/%d MB ",
> +                       MB(base+size), MB(barmax));
> +
> +write_pageset_free_buffers:
> +
> +       /* Cleanup other plugins */
> +       list_for_each_entry(this_plugin, &suspend_plugins, plugin_list) {
> +               if (this_plugin->disabled)
> +                       continue;
> +               if ((this_plugin->type == FILTER_PLUGIN) ||
> +                   (this_plugin->type == WRITER_PLUGIN))
> +                       continue;
> +               if (this_plugin->write_cleanup)
> +                       this_plugin->write_cleanup();
> +       }
> +
> +       /* Flush data and cleanup */
> +       list_for_each_entry(this_plugin, &suspend_filters, ops.filter.filter_list) {
> +               if (this_plugin->disabled)
> +                       continue;
> +               if (this_plugin->write_cleanup)
> +                       this_plugin->write_cleanup();
> +       }
> +       active_writer->write_cleanup();
> +
> +       /* Statistics */
> +       end_time = jiffies;
> +
> +       if ((end_time - start_time) && (!TEST_RESULT_STATE(SUSPEND_ABORTED))) {
> +               suspend_io_time[0][0] += size,
> +               suspend_io_time[0][1] += (end_time - start_time);
> +       }
> +
> +       return error;
> +}
> +
> +/* read_pageset()
> + *
> + * Description:        Read a pageset from disk.
> + * Arguments:  pagedir:        Pointer to the pagedir to be saved.
> + *             whichtowrite:   Controls what debugging output is printed.
> + *             overwrittenpagesonly: Whether to read the whole pageset or
> + *             only part.
> + * Returns:    Zero on success or -1 on failure.
> + */
> +
> +static int read_pageset(struct pagedir * pagedir, int whichtoread,
> +               int overwrittenpagesonly)
> +{
> +       int nextupdate = 0, result = 0, base = 0;
> +       int start_time, end_time, finish_at = pagedir->pageset_size;
> +       int barmax = pagedir1.pageset_size + pagedir2.pageset_size;
> +       int i, pc, step = 1;
> +       struct suspend_plugin_ops * this_plugin, * first_filter = get_next_filter(NULL);
> +       dyn_pageflags_t *pageflags;
> +       int current_page_index;
> +
> +       if (whichtoread == 1) {
> +               suspend2_prepare_status(1, 1, "Reading kernel & process data...");
> +               pageflags = &pageset1_copy_map;
> +       } else {
> +               suspend2_prepare_status(1, 0, "Reading caches...");
> +               if (overwrittenpagesonly)
> +                       barmax = finish_at = min(pageset1_size, pageset2_size);
> +               else {
> +                       base = pagedir1.pageset_size;
> +               }
> +               pageflags = &pageset2_map;
> +       }
> +
> +       start_time=jiffies;
> +
> +       /* Initialise page transformers */
> +       list_for_each_entry(this_plugin, &suspend_filters, ops.filter.filter_list) {
> +               if (this_plugin->disabled)
> +                       continue;
> +               if (this_plugin->read_init &&
> +                               this_plugin->read_init(whichtoread)) {
> +                       abort_suspend("Failed to initialise a filter.");
> +                       result = 1;
> +                       goto read_pageset_free_buffers;
> +               }
> +       }
> +
> +       /* Initialise writer */
> +       if (active_writer->read_init(whichtoread)) {
> +               abort_suspend("Failed to initialise the writer.");
> +               result = 1;
> +               goto read_pageset_free_buffers;
> +       }
> +
> +       /* Initialise other plugins */
> +       list_for_each_entry(this_plugin, &suspend_plugins, plugin_list) {
> +               if (this_plugin->disabled)
> +                       continue;
> +               if ((this_plugin->type == FILTER_PLUGIN) ||
> +                   (this_plugin->type == WRITER_PLUGIN))
> +                       continue;
> +               if (this_plugin->read_init)
> +                       if (this_plugin->read_init(whichtoread)) {
> +                               SET_RESULT_STATE(SUSPEND_ABORTED);
> +                               goto read_pageset_free_buffers;
> +                       }
> +       }
> +
> +       current_page_index = __get_next_bit_on(*pageflags, -1);
> +
> +       pc = finish_at / 5;

What's the magic number 5 that pops up everywhere?
