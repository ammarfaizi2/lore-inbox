Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263105AbUKTFfh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263105AbUKTFfh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Nov 2004 00:35:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261709AbUKTFbA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Nov 2004 00:31:00 -0500
Received: from gprs214-103.eurotel.cz ([160.218.214.103]:64641 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S262993AbUKTAPk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 19:15:40 -0500
Date: Sat, 20 Nov 2004 01:15:25 +0100
From: Pavel Machek <pavel@suse.cz>
To: hugang@soulinfo.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Software Suspend split to two stage V2.
Message-ID: <20041120001525.GF1594@elf.ucw.cz>
References: <20041119194007.GA1650@hugang.soulinfo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041119194007.GA1650@hugang.soulinfo.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

>   This patch using pagemap for PageSet2 bitmap, It increase suspend
>   speed, In my PowerPC suspend only need 5 secs, cool. 

Well, speed is nice but... I have O(n^2) => O(n) patch in my tree that
provides some nice speedup too, and is less invasive. They are
probably orthogonal.

* you'll have to explain (in Documentation/power/swsusp.txt) why this
is safe. Normal swsusp is safe because interrupts&DMAs are
disabled. You are doing writes but data in page-cache may not be
modified, right? What are exact requirements for this and how it is
guaranteed that data are indeed not modified?

* what is pcs_ prefix? Page Cache Suspend?

(ouch and be warned that this will take quite long to get
in. There are patches in my queue I'd like to get in first, like
O(n^2) => O(n) page marking).

> +static void calc_order(int *po, int *nr)
> +{

"po" is bad name even for local variable.

> +static unsigned long *pageset2map = NULL;
> +
> +#define PAGENUMBER(page) (page-mem_map)
> +#define PAGEINDEX(page) ((PAGENUMBER(page))/(8*sizeof(unsigned long)))
> +#define PAGEBIT(page) ((int) ((PAGENUMBER(page))%(8 * sizeof(unsigned long))))
> +
> +#define BITS_PER_PAGE (PAGE_SIZE * 8)
> +#define PAGES_PER_BITMAP ((max_mapnr + BITS_PER_PAGE - 1) / BITS_PER_PAGE)
> +#define BITMAP_ORDER (get_bitmask_order((PAGES_PER_BITMAP) - 1))

> +#define PagePageset2(page) \
> +	test_bit(PAGEBIT(page), &pageset2map[PAGEINDEX(page)])
> +#define SetPagePageset2(page) \
> +	set_bit(PAGEBIT(page), &pageset2map[PAGEINDEX(page)])

Can't you just get another bit in page.h to avoid these arrays?

> +static int pcs_write(void)
> +{
> +	int error = 0;
> +	int i;
> +
> +	printk( "Writing PageCaches to swap (%d pages): ", nr_copy_pcs);
> +	for (i = 0; i < nr_copy_pcs && !error; i++) {
> +		if (!(i%100))
> +			printk( "." );

Please take % progress from newer swsusp.

> +static void count_data_pages(void);
> +static int swsusp_alloc(void);
> +
> +int pcs_suspend(int resume)
> +{
> +	struct zone *zone;
> +	suspend_pagedir_t *pe = NULL;
> +	int error;
> +
> +	if (resume == 1) {
> +		return (0);
> +	}
> +	if (resume == 2) {
> +		pcs_read();
> +		pcs_free_pagemap();
> +		return (0);
> +	}

I'd understand int resume taking 0 and 1, but what does 2 mean? Also
use return 0; not return (0);

								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
