Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263088AbUKZXyE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263088AbUKZXyE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Nov 2004 18:54:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263063AbUKZTkt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Nov 2004 14:40:49 -0500
Received: from zeus.kernel.org ([204.152.189.113]:4291 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S262456AbUKZT1t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Nov 2004 14:27:49 -0500
Date: Fri, 26 Nov 2004 00:46:35 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Nigel Cunningham <ncunningham@linuxmail.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Suspend 2 merge: 43/51: Utility functions.
Message-ID: <20041125234635.GF2909@elf.ucw.cz>
References: <1101292194.5805.180.camel@desktop.cunninghams> <1101299832.5805.371.camel@desktop.cunninghams>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1101299832.5805.371.camel@desktop.cunninghams>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> These are the routines that I think could possibly be useful elsewhere
> too.
> 
> - A snprintf routine that returns the number of bytes actually put into
> the buffer, not the number that would have been put in if the buffer was
> big enough.
> - Routine for finding a proc dir entry (we use it to find /proc/splash
> when)
> - Support routines for dynamically allocated pageflags. Save those
> precious bits!

How many bits do you need? Two? I'd rather use thow two bits than have
yet another abstraction. Also note that it is doing big order
allocation.


								Pavel
> +#define BITS_PER_PAGE (PAGE_SIZE * 8)
> +#define PAGES_PER_BITMAP ((max_mapnr + BITS_PER_PAGE - 1) / BITS_PER_PAGE)
> +#define BITMAP_ORDER (get_bitmask_order((PAGES_PER_BITMAP) - 1))
> +
> +/* clear_map
> + *
> + * Description:	Clear an array used to store local page flags.
> + * Arguments:	unsigned long *:	The pagemap to be cleared.
> + */
> +
> +void clear_map(unsigned long * pagemap)
> +{
> +	int size = (1 << BITMAP_ORDER) * PAGE_SIZE;
> +	
> +	memset(pagemap, 0, size);
> +}
> +
> +/* allocate_local_pageflags
> + *
> + * Description:	Allocate a bitmap for local page flags.
> + * Arguments:	unsigned long **:	Pointer to the bitmap.
> + * 		int:			Whether to set nosave flags for the
> + * 					newly allocated pages.
> + * Note:	This looks suboptimal, but remember that we might be allocating
> + * 		the Nosave bitmap here.
> + */
> +int allocate_local_pageflags(unsigned long ** pagemap, int setnosave)
> +{
> +	unsigned long * check;
> +	int i;
> +	if (*pagemap) {
> +		printk("Error. Local pageflags map already allocated.\n");
> +		clear_map(*pagemap);
> +	} else {
> +		check = (unsigned long *) __get_free_pages(GFP_ATOMIC,
> +				BITMAP_ORDER);
> +		if (!check) {
> +			printk("Error. Unable to allocate memory for local page flags.");
> +			return 1;
> +		}
> +		clear_map(check);
> +		*pagemap = check;
> +		if (setnosave) {
> +			struct page * firstpage = 
> +				virt_to_page((unsigned long) check);
> +			for (i = 0; i < (1 << BITMAP_ORDER); i++)
> +				SetPageNosave(firstpage + i);
> +		}
> +	}
> +	return 0;
> +}
> +
> +/* freemap
> + *
> + * Description:	Free a local pageflags bitmap.
> + * Arguments:	unsigned long **: Pointer to the bitmap being freed.
> + * Note:	Map being freed might be Nosave.
> + */
> +int free_local_pageflags(unsigned long ** pagemap)
> +{
> +	int i;
> +	if (!*pagemap)
> +		return 1;
> +	else {
> +		struct page * firstpage =
> +			virt_to_page((unsigned long) *pagemap);
> +		for (i = 0; i < (1 << BITMAP_ORDER); i++)
> +			ClearPageNosave(firstpage + i);
> +		free_pages((unsigned long) *pagemap, BITMAP_ORDER);
> +		*pagemap = NULL;
> +		return 0;
> +	}
> +}
> +
> +EXPORT_SYMBOL(suspend_snprintf);
> +EXPORT_SYMBOL(allocate_local_pageflags);
> +EXPORT_SYMBOL(free_local_pageflags);
> +EXPORT_SYMBOL(find_proc_dir_entry);
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
