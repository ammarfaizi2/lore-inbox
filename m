Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161633AbWJaLkB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161633AbWJaLkB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 06:40:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161632AbWJaLkA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 06:40:00 -0500
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:37097 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S1161413AbWJaLkA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 06:40:00 -0500
Subject: Re: [PATCH] Use extents for recording what swap is allocated.
From: Nigel Cunningham <ncunningham@linuxmail.org>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <200610242208.34426.rjw@sisk.pl>
References: <1161576857.3466.9.camel@nigel.suspend2.net>
	 <200610242208.34426.rjw@sisk.pl>
Content-Type: text/plain
Date: Tue, 31 Oct 2006 22:39:56 +1100
Message-Id: <1162294796.19737.24.camel@nigel.suspend2.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Tue, 2006-10-24 at 22:08 +0200, Rafael J. Wysocki wrote:
> On Monday, 23 October 2006 06:14, Nigel Cunningham wrote:
> > Switch from bitmaps to using extents to record what swap is allocated;
> > they make more efficient use of memory, particularly where the allocated
> > storage is small and the swap space is large.
> 
> As I said before, I like the overall idea, but I have a bunch of comments.
> 
> > This is also part of the ground work for implementing support for
> > supporting multiple swap devices.
> >     
> > Signed-off-by: Nigel Cunningham <nigel@suspend2.net>
> > 
> > diff --git a/kernel/power/Makefile b/kernel/power/Makefile
> > index 38725f5..d772521 100644
> > --- a/kernel/power/Makefile
> > +++ b/kernel/power/Makefile
> > @@ -5,6 +5,6 @@ endif
> >  
> >  obj-y				:= main.o process.o console.o
> >  obj-$(CONFIG_PM_LEGACY)		+= pm.o
> > -obj-$(CONFIG_SOFTWARE_SUSPEND)	+= swsusp.o disk.o snapshot.o swap.o user.o
> > +obj-$(CONFIG_SOFTWARE_SUSPEND)	+= swsusp.o disk.o snapshot.o swap.o user.o extent.o
> >  
> >  obj-$(CONFIG_MAGIC_SYSRQ)	+= poweroff.o
> > diff --git a/kernel/power/extent.c b/kernel/power/extent.c
> > new file mode 100644
> > index 0000000..b769956
> > --- /dev/null
> > +++ b/kernel/power/extent.c
> > @@ -0,0 +1,119 @@
> > +/* 
> > + * kernel/power/extent.c
> > + * 
> > + * Copyright (C) 2003-2006 Nigel Cunningham <nigel@suspend2.net>
> > + * Copyright (C) 2006 Red Hat, inc.
> > + *
> > + * Distributed under GPLv2.
> > + * 
> > + * These functions encapsulate the manipulation of storage metadata.
> > + */
> > +
> > +#include <linux/suspend.h>
> > +#include "extent.h"
> > +
> > +/* suspend_get_extent
> > + *
> > + * Returns a free extent. May fail, returning NULL instead.
> > + */
> > +static struct extent *suspend_get_extent(void)
> > +{
> > +	struct extent *result;
> 
> I'd call the type 'struct suspend_extent', for clarity.

Done, thanks for the suggestion.

> > +	
> > +	if (!(result = kmalloc(sizeof(struct extent), GFP_ATOMIC)))
> > +		return NULL;
> 
> if you use kzalloc() here, the initializations below won't be necessary and
> the function will reduce to a one-liner (in which case it can be inlined).

Done.

> > +
> > +	result->minimum = result->maximum = 0;
> > +	result->next = NULL;
> > +
> > +	return result;
> > +}
> > +
> > +/* suspend_put_extent_chain.
> > + *
> > + * Frees a whole chain of extents.
> > + */
> > +void suspend_put_extent_chain(struct extent_chain *chain)
> 
> I'd call it suspend_free_all_extents().

Renamed as suspend_free_extent_chain (I'm thinking of future use of
multiple chains for multiple swap devices).

> > +{
> > +	struct extent *this;
> > +
> > +	this = chain->first;
> > +
> > +	while(this) {
> > +		struct extent *next = this->next;
> > +		kfree(this);
> > +		chain->num_extents--;
> > +		this = next;
> > +	}
> > +	
> > +	BUG_ON(chain->num_extents);
> 
> I'd drop this BUG_ON().  Once the code has been debugged, it's no longer
> of any use.

Done.

> > +	chain->first = chain->last_touched = NULL;
> 
> This is against the coding style AFAICT.  Please do
> 
> chain->first = NULL;
> chain->last_touched = NULL;

Done. Didn't know that, thanks.

> > +	chain->size = 0;
> > +}
> > +
> > +/* 
> > + * suspend_add_to_extent_chain
> > + *
> > + * Add an extent to an existing chain.
> > + */
> > +int suspend_add_to_extent_chain(struct extent_chain *chain, 
> > +		unsigned long minimum, unsigned long maximum)
> 
> I'd use shorter names for these arguments, like 'start', 'end'.

min & max now used.

> > +{
> > +	struct extent *new_extent = NULL, *start_at;
> 
> The names are not the best here too, IMHO.  I'd use something like
> *new_ext, *cur_ext.
> 
> > +
> > +	/* Find the right place in the chain */
> > +	start_at = (chain->last_touched && 
> > +		    (chain->last_touched->minimum < minimum)) ?
> > +		chain->last_touched : NULL;
> > +
> > +	if (!start_at && chain->first && chain->first->minimum < minimum)
> > +		start_at = chain->first;
> 
> The above two statements can be simplified, like
> 
> cur_ext = NULL;
> if (chain->last_touched && chain->last_touched->minimum < start)
> 	cur_ext = chain->last_touched;
> else if (chain->first && chain->first->minimum < start)
> 	cur_ext = chain->first;

Done, ta.

> > +
> > +	while (start_at && start_at->next && start_at->next->minimum < minimum)
> > +		start_at = start_at->next;
> 
> You don't need to check if start_at is nonzero in every step.  It's sufficient to
> check this once at the beginning.
> 
> Moreover, the below is also only executed if start_at is nonzero,
> so you can put it under one if () along with the above loop, like this:

Done, ta.

> if (cur_ext) {
> 	while (cur_ext->next && cur_ext->next->minimum < start)
> 		cur_ext = cur_ext->next;
> 
> 	if (cur_ext-> maximum == (start - 1)) {
> 		struct suspend_extent *next_ext;
> 
> 		cur_ext->maximum = end;
> 		next_ext = cur_ext->next;
> 		if (next_ext && cur_ext->maximum == next_ext->minimum - 1) {
> 			cur_ext->maximum = next_ext->maximum;
> 			cur_ext->next = next_ext->next;
> 			kfree(next_ext);
> 			chain->num_extents--;
> 		}
> 
> etc.
> > +
> > +	if (start_at && start_at->maximum == (minimum - 1)) {
> > +		start_at->maximum = maximum;
> > +
> > +		/* Merge with the following one? */
> > +		if (start_at->next &&
> > +		    start_at->maximum + 1 == start_at->next->minimum) {
> > +			struct extent *to_free = start_at->next;
> > +			start_at->maximum = start_at->next->maximum;
> > +			start_at->next = start_at->next->next;
> > +			chain->num_extents--;
> > +			kfree(to_free);
> > +		}
> > +
> > +		chain->last_touched = start_at;
> > +		chain->size+= (maximum - minimum + 1);
> > +
> > +		return 0;
> > +	}
> > +
> > +	new_extent = suspend_get_extent();
> > +	if (!new_extent) {
> > +		printk("Error unable to append a new extent to the chain.\n");
> > +		return 2;
> 
> return -ENOMEM;

Mmm. Ta. Forgotten defunct debugging.

> > +	}
> > +
> > +	chain->num_extents++;
> > +	chain->size+= (maximum - minimum + 1);
> > +	new_extent->minimum = minimum;
> > +	new_extent->maximum = maximum;
> > +	new_extent->next = NULL;
> 
> The last one won't be necessary if you use kzalloc() to allocate extents.

Ack.

> > +
> > +	chain->last_touched = new_extent;
> > +
> > +	if (start_at) {
> > +		struct extent *next = start_at->next;
> > +		start_at->next = new_extent;
> > +		new_extent->next = next;
> 
> *next is unnecessary here.  You can do it like this:
> 
> new_ext->next = cur_ext->next;
> cur_ext->next = new_ext;
> 
> because new_ext->next is initially NULL.

k.

> > +	} else {
> > +		if (chain->first)
> > +			new_extent->next = chain->first;
> > +		chain->first = new_extent;
> > +	}
> > +
> > +	return 0;
> > +}
> > diff --git a/kernel/power/extent.h b/kernel/power/extent.h
> > new file mode 100644
> > index 0000000..062b4c1
> > --- /dev/null
> > +++ b/kernel/power/extent.h
> > @@ -0,0 +1,50 @@
> > +/*
> > + * kernel/power/extent.h
> > + *
> > + * Copyright (C) 2004-2006 Nigel Cunningham <nigel@suspend2.net>
> > + * Copyright (C) 2006 Red Hat, inc.
> > + *
> > + * This file is released under the GPLv2.
> > + *
> > + * It contains declarations related to extents. Extents are
> > + * suspend's method of storing some of the metadata for the image.
> > + * See extent.c for more info.
> > + *
> > + */
> > +
> > +#ifndef EXTENT_H
> > +#define EXTENT_H
> > +
> > +struct extent {
> > +	unsigned long minimum, maximum;
> 
> Well, I'd use shorter names, but whatever.
> 
> > +	struct extent *next;
> > +};
> > +
> > +struct extent_chain {
> > +	int size; /* size of the chain ie sum (max-min+1) */
> > +	int num_extents;
> > +	struct extent *first, *last_touched;
> > +};
> > +
> > +/* Simplify iterating through all the values in an extent chain */
> > +#define suspend_extent_for_each(extent_chain, extentpointer, value) \
> > +if ((extent_chain)->first) \
> > +	for ((extentpointer) = (extent_chain)->first, (value) = \
> > +			(extentpointer)->minimum; \
> > +	     ((extentpointer) && ((extentpointer)->next || (value) <= \
> > +				 (extentpointer)->maximum)); \
> > +	     (((value) == (extentpointer)->maximum) ? \
> > +		((extentpointer) = (extentpointer)->next, (value) = \
> > +		 ((extentpointer) ? (extentpointer)->minimum : 0)) : \
> > +			(value)++))
> 
> This macro doesn't look very nice and is used only once, so I think you
> can drop it and just write the loop where it belongs.

Sort of done - expanded to two loops. 'tis more readable that way
anyway.

> > +
> > +void suspend_put_extent_chain(struct extent_chain *chain);
> > +int suspend_add_to_extent_chain(struct extent_chain *chain, 
> > +		unsigned long minimum, unsigned long maximum);
> > +
> > +/* swap_entry_to_extent_val & extent_val_to_swap_entry: 
> > + * We are putting offset in the low bits so consecutive swap entries
> > + * make consecutive extent values */
> > +#define swap_entry_to_extent_val(swp_entry) (swp_entry.val)
> > +#define extent_val_to_swap_entry(val) (swp_entry_t) { (val) }
> 
> These two macros are also used only once each.  I'd just use the values
> directly.

ack

> > +#endif
> 
> That's all. :-)

Thanks.

> You never change things by fighting the existing reality.
> 		R. Buckminster Fuller

Hmm. Maybe I shouldn't bother with this then :)

Nigel

