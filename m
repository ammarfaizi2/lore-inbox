Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262455AbUKZXx7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262455AbUKZXx7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Nov 2004 18:53:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263083AbUKZTmK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Nov 2004 14:42:10 -0500
Received: from zeus.kernel.org ([204.152.189.113]:4291 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S262453AbUKZT1p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Nov 2004 14:27:45 -0500
Date: Fri, 26 Nov 2004 00:36:30 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Nigel Cunningham <ncunningham@linuxmail.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Suspend 2 merge: 36/51: Highlevel I/O routines.
Message-ID: <20041125233629.GC2909@elf.ucw.cz>
References: <1101292194.5805.180.camel@desktop.cunninghams> <1101298276.5805.334.camel@desktop.cunninghams>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1101298276.5805.334.camel@desktop.cunninghams>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> +extern volatile int suspend_io_time[2][2];

Why volatile?

> +
> +	PRINTFREEMEM("after initialising page transformers");
> +
> +	/* Initialise writer */
> +	active_writer->ops.filter.write_init(whichtowrite);
> +	PRINTFREEMEM("after initialising writer");
> +
> +	get_first_pbe(&pbe, pagedir);
> +
> +	/* Write the data */
> +	for (i=0; i<size; i++) {
> +		int was_mapped = 0;
> +		/* Status update */
> +		if (!(i&0x1FF)) 
> +			suspend_message(SUSPEND_IO, SUSPEND_LOW, 1, ".");
> +		if (((i+base) >= nextupdate) || 
> +				(!(i%(1 << (20 - PAGE_SHIFT)))))
> +			nextupdate = update_status(i + base, barmax, 
> +				" %d/%d MB ", MB(base+i+1), MB(barmax));
> +		if ((i == (size - 5)) &&
> +			TEST_ACTION_STATE(SUSPEND_PAUSE_NEAR_PAGESET_END))
> +			check_shift_keys(1, "Five more pages to write.");
> +		suspend_message(SUSPEND_IO, SUSPEND_VERBOSE, 1,
> +				"Submitting page %d/%d.\n", i, size);
> +
> +		/* Write */
> +		was_mapped = suspend_map_kernel_page(pbe.address, 1);
> +		if (TEST_ACTION_STATE(SUSPEND_TEST_FILTER_SPEED))
> +			ret = first_filter->ops.filter.write_chunk(pbe.origaddress);
> +		else
> +			ret = first_filter->ops.filter.write_chunk(pbe.address);
> +		if (!was_mapped)
> +			suspend_map_kernel_page(pbe.address, 0);
> +
> +		if (ret) {
> +			printk("Write chunk returned %d.\n", ret);
> +			abort_suspend("Failed to write a chunk of the "
> +					"image.");
> +			error = -1;
> +			goto write_pageset_free_buffers;
> +		}

Half of this code seems to be pretty-prints, and performance
metering. That should be gone before mainline merge.

							Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
