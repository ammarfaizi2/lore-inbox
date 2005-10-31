Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932338AbVJaHlW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932338AbVJaHlW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 02:41:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932428AbVJaHlV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 02:41:21 -0500
Received: from smtp.osdl.org ([65.172.181.4]:52688 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932338AbVJaHlU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 02:41:20 -0500
Date: Mon, 31 Oct 2005 00:40:46 -0800
From: Andrew Morton <akpm@osdl.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: mpeschke@de.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: [patch 1/14] s390: statistics infrastructure.
Message-Id: <20051031004046.730bc45f.akpm@osdl.org>
In-Reply-To: <20051028140617.GA7300@skybase.boeblingen.de.ibm.com>
References: <20051028140617.GA7300@skybase.boeblingen.de.ibm.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Schwidefsky <schwidefsky@de.ibm.com> wrote:
>
> From: Martin Peschke <mpeschke@de.ibm.com>
> 
> [patch 1/14] s390: statistics infrastructure.
> 
> Add the statistics facility. This features offers a simple way to
> gather statistical data and to display them via the debugfs.
> An example how this is used:
> 
> 	struct statistic_interface *stat_if;
> 	struct statistic *stat;
> 
> 	statistic_interface_create(&stat_if, "whatever");
> 	statistic_create(&stat, stat_if, "stat-name", "unit");
> 	statistic_define_value(stat, range_min, range_max, def_mode);
> 	...
> 	statistic_inc(stat, value);	/* repeat.. */
> 	...
> 	statistic_interface_remove(&stat_if);
> 

I agree with Christoph on this: please present it as a Kconfigurable
generic option and flesh out the changelog a bit.  If the documentation in
the source file isn't sufficient, consider a Documentation/ file too,
please.

> +static struct sgrb_seg *
> +sgrb_seg_alloc(struct list_head *lh, int size, unsigned int gfp)

Use gfp_t throughout.

> +EXPORT_SYMBOL(sgrb_seg_find);

Can we use EXPORT_SYMBOL_GPL throughout?

> +
> +/**
> + * sgrb_seg_release_all - releases scatter-gather buffer
> + * @lh: list_head that holds list of scattered buffer parts
> + */
> +void
> +sgrb_seg_release_all(struct list_head *lh)

Coding style nit: please do

void sgrb_seg_release_all(struct list_head *lh)

as per the rest of the core kernel.

(If we end up deciding to keep all this in arch/s390 then I guess
we can live with s390 peculiarities though)

> +static inline int
> +sgrb_ptr_identical(
> +	struct sgrb_ptr *a,
> +	struct sgrb_ptr *b)
> +{

Here too.

> +
> +/**
> + * sgrb_alloc - prepare a new ringbuffer for use
> + *
> + * @rb: a ringbuffer struct provided by the exploiter
> + * @entry_size: size of entries in ringbuffer
> + * @entry_num: total number of entries in ringbuffer
> + * @seg_size: size of individual, scatter-gathered segments used to build up
> + *            ringbuffer
> + * @gfp: kmalloc flags
> + *
> + * Returns 0 on success.
> + * Returns -ENOMEM if some memory allocation failed.
> + **/
> +int
> +sgrb_alloc(
> +	struct sgrb *rb,
> +	int entry_size, int entry_num, int seg_size, int gfp)
> +{
> +	int i;
> +	struct sgrb_seg *seg;
> +	int entries_per_seg = (seg_size / entry_size);
> +	int seg_num = entry_num / entries_per_seg;
> +	int residual = (entry_num % entries_per_seg) * entry_size;
> +
> +	rb->entry_size = entry_size;
> +	INIT_LIST_HEAD(&rb->seg_lh);
> +	for (i = 0; i < seg_num; i++)
> +		if (!sgrb_seg_alloc(&rb->seg_lh, seg_size, gfp))
> +			return -ENOMEM;
> +	if (residual)
> +		if (!sgrb_seg_alloc(&rb->seg_lh, residual, gfp))
> +			return -ENOMEM;
> +	list_for_each_entry(seg, &rb->seg_lh, list)
> +		break;

eh?   Something's gone rather wrong here.

> +	rb->first.seg = seg;
> +	rb->last.seg = seg;
> +	sgrb_init(rb);
> +	return 0;
> +}
> +EXPORT_SYMBOL(sgrb_alloc);
> +
> ...
> +static void
> +sgrb_next_entry(
> +	struct sgrb *rb,
> +	struct sgrb_ptr *pos,
> +	struct sgrb_ptr *next)
> +{
> +	sgrb_ptr_copy(next, pos);
> +	next->offset += rb->entry_size;
> +	if ((next->offset + rb->entry_size) - 1 > next->seg->size) {
> +		if (rb->seg_lh.prev == &next->seg->list) {
> +			next->seg = NULL;
> +			next->seg = list_prepare_entry(next->seg, &rb->seg_lh, list);
> +		}
> +		list_for_each_entry_continue(next->seg, &rb->seg_lh, list)
> +			break;

You did it again.   I guess it's deliberate.  Isn't there a simpler way?

> +/**
> + * sgrb_produce_nooverwrite - put an entry into the ringbuffer
> + *     if there is room whithout the need to overwrite the oldest

spello

> +/**
> + * sgrb_consume_delete - get an entry from the ringbuffer and
> + *     delete the entry from the ringbuffer so that it can't
> + *     be consumed twice, and in order to free up its slot for
> + *     another entry
> + *
> + * @rb: the ringbuffer to use
> + *
> + * Returns address of the entry read, if there is an entry available.
> + * Returns NULL otherwise.
> + **/
> +void *
> +sgrb_consume_delete(struct sgrb *rb)
> +{
> +	struct sgrb_ptr prev;
> +
> +	if (!sgrb_ptr_valid(&rb->first))
> +		return NULL;
> +	sgrb_ptr_copy(&prev, &rb->first);
> +	if (sgrb_ptr_identical(&rb->last, &rb->first))
> +		sgrb_init(rb);
> +	else
> +		sgrb_next_entry(rb, &rb->first, &rb->first);
> +	rb->entries--;
> +	return sgrb_entry(&prev);
> +}
> +EXPORT_SYMBOL(sgrb_consume_delete);

I guess all of these functions require caller-provided locking, and that's
documented somewhere?

> +
> +extern void tod_to_timeval(__u64, struct timespec *);

Please don't put extern decls in .c files - put them in a header file.

> +static inline void
> +statistic_nsec_to_timespec(u64 nsec, struct timespec *xtime)
> +{
> +	unsigned long long sec;
> +
> +        sec = nsec;
> +        do_div(sec, 1000000000);
> +        xtime->tv_sec = sec;
> +        xtime->tv_nsec = nsec - sec * 1000000000;
> +}
> +
> +static inline u64
> +statistic_timespec_to_nsec(struct timespec *xtime)
> +{
> +	return (xtime->tv_sec * 1000000000 + xtime->tv_nsec);
> +}

Maybe these should be put in jiffies.h.

> +/**
> + * statistic_create - create a statistic and attach it to a given interface
> + * @stat_ptr: reference to struct statistic pointer
> + * @interface_ptr: reference to struct statistic_interface pointer
> + * @name: name of statistic to be created and as seen in "data" and
> + *        "definition" files
> + *
> + * Create a statistic, which - after being defined and enabled - is ready
> + * to capture and compute data provided by the exploiter. A line in the
> + * interface's "definition" file will hold specifics about the named statistic.
> + *
> + * On success, 0 is returned, the struct statistic pointer
> + * provided by the caller points to a newly alloacted struct,
> + * and the statistic is defined as type "value" by default.
> + *
> + * If the struct statistic pointer provided by the caller
> + * is not NULL (used), this routine fails, the struct statistic
> + * pointer is not changed, and -EINVAL is returned.
> + *
> + * If some required memory could not be allocated this routine fails,
> + * the struct statistic pointer is not changed, and -ENOMEM is returned.
> + **/
> +int
> +statistic_create(
> +	struct statistic **stat_ptr,
> +	struct statistic_interface *interface,
> +	const char *name,
> +	const char *units)
> +{
> +	struct statistic *stat;
> +
> +	if (*stat_ptr || !interface)
> +		return -EINVAL;
> +
> +	stat = kmalloc(sizeof(struct statistic), GFP_KERNEL);
> +	if (!stat)
> +		return -ENOMEM;
> +	memset(stat, 0, sizeof(struct statistic));
> +
> +	stat->interface = interface;
> +	strlcpy(stat->name, name, sizeof(stat->name));
> +	strlcpy(stat->units, units, sizeof(stat->units));
> +	statistic_define_value(stat, STATISTIC_RANGE_MIN, STATISTIC_RANGE_MAX,
> +				STATISTIC_DEF_MODE_INC);
> +	statistic_stop_nolock(stat);
> +	stat->started = stat->stopped;
> +	stat->stat_ptr = stat_ptr;
> +
> +	list_add_tail(&stat->list, &interface->statistic_lh);
> +
> +	*stat_ptr = stat;
> +
> +	return 0;
> +}

A lot of this looks pretty generic as well.




It's a lot of code, and it'll be some work to make it generic.

Can you help us decide whether there's actually any point in making it
generic?  What problems was it designed to solve, and what additional
problems might it all be useful for?

Thanks.
