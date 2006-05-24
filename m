Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964790AbWEXWyw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964790AbWEXWyw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 May 2006 18:54:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964791AbWEXWyv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 May 2006 18:54:51 -0400
Received: from smtp.osdl.org ([65.172.181.4]:10179 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964790AbWEXWyv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 May 2006 18:54:51 -0400
Date: Wed, 24 May 2006 15:57:35 -0700
From: Andrew Morton <akpm@osdl.org>
To: Martin Peschke <mp3@de.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [Patch 5/6] statistics infrastructure
Message-Id: <20060524155735.04ed777a.akpm@osdl.org>
In-Reply-To: <1148474038.2934.18.camel@dyn-9-152-230-71.boeblingen.de.ibm.com>
References: <1148474038.2934.18.camel@dyn-9-152-230-71.boeblingen.de.ibm.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Peschke <mp3@de.ibm.com> wrote:
>

It would be great to have a non-s390 exploiter of this code.  So more
people could try it out.  Is that much work?

One assumes that there's some subsytem or driver which has a real-life need
for such instrumentation, although I don't know which one that would be. 
(And if there is no such subsystem then that's rather a black mark for
merging all this code!)

Thoughts?

> ...
>
> +struct statistic_discipline {
> +	int (*parse)(struct statistic *, struct statistic_info *, int, char *);
> +	void* (*alloc)(struct statistic *, size_t, gfp_t, int);
> +	void (*free)(struct statistic *, void *);
> +	void (*reset)(struct statistic *, void *);
> +	void (*merge)(struct statistic *, void *, void*);
> +	int (*fdata)(struct statistic *, const char *,
> +		     struct statistic_file_private *, void *);
> +	int (*fdef)(struct statistic *, char *);
> +	void (*add)(struct statistic *, int, s64, u64);
> +	void (*set)(struct statistic *, s64, u64);
> +	char *name;
> +	size_t size;
> +};

This practice of omitting the variable names drives me up the wall, sorry. 
Look at the definition of `add' then fall down dazed and confused.

This is particularly true of these function-pointer style declarations. 
For example, do:

	$EDITOR -t aio_read

and you end up here:

        ssize_t (*aio_read) (struct kiocb *, char __user *, size_t, loff_t);

which is uninformative.  You have to go and hunt down an instance of an
aio_read() implementation to actually be sure what those args are doing.

So I think putting the nicely-chosen variable names in there is quite
helpful.

> +#ifdef CONFIG_STATISTICS
> +
> +extern int statistic_create(struct statistic_interface *, const char *);
> +extern int statistic_remove(struct statistic_interface *);
> +
> +/**
> + * statistic_add - update statistic with incremental data in (X, Y) pair
> + * @stat: struct statistic array
> + * @i: index of statistic to be updated
> + * @value: X
> + * @incr: Y
> + *
> + * The actual processing of the (X, Y) data pair is determined by the current
> + * the definition applied to the statistic. See Documentation/statistics.txt.
> + *
> + * This variant takes care of protecting per-cpu data. It is preferred whenever
> + * exploiters don't update several statistics of the same entity in one go.
> + */
> +static inline void statistic_add(struct statistic *stat, int i,
> +				 s64 value, u64 incr)
> +{
> +	unsigned long flags;
> +	local_irq_save(flags);
> +	if (stat[i].state == STATISTIC_STATE_ON)
> +		stat[i].add(&stat[i], smp_processor_id(), value, incr);
> +	local_irq_restore(flags);
> +}

afaict this isn't actually used?

If it is, and assuming this is only accessed via a function pointer (the
mysterious `add' method) then there's not a lot of point in inlining it.

Except if this code really isn't called, then inlining it will avoid having
an unused piece of code in vmlinux.

But if it _is_ used, and it has multiple users then we end up with multiple
copies in vmlinux.

So what's up with that?

And elsewhere we have:

> +static inline void statistic_add(struct statistic *stat, int i,
> +				 s64 value, u64 incr)
> +{
> +}
> +

Do we expect this to have any callers if !CONFIG_STATISTICS?


> +static int statistic_free(struct statistic *stat, struct statistic_info *info)
> +{
> +	int cpu;
> +	stat->state = STATISTIC_STATE_RELEASED;
> +	if (unlikely(info->flags & STATISTIC_FLAGS_NOINCR)) {
> +		statistic_free_ptr(stat, stat->pdata);
> +		stat->pdata = NULL;
> +		return 0;
> +	}
> +	for_each_cpu(cpu) {

for_each_cpu() is on death row.  Replace it with for_each_possible_cpu(). 
If that is indeed appropriate - perhaps you meant online_cpu, or
present_cpu.

> +static void * statistic_alloc_generic(struct statistic *stat, size_t size,
                ^

unwelcome space ;)

> +static int statistic_alloc(struct statistic *stat,
> +			   struct statistic_info *info)
> +{
> +	int cpu;
> +	stat->age = sched_clock();

argh.  Didn't we end up finding a way to avoid this?

At the least, we should have statistics_clock(), or nsec_clock(), or
something which is decoupled from this low-level scheduler-internal thing,
and which architectures can implement (vis attribute-weak) if they have a
preferred/better/more-accurate alternative.


> +	if (unlikely(info->flags & STATISTIC_FLAGS_NOINCR)) {
> +		stat->pdata = statistic_alloc_ptr(stat, GFP_KERNEL, -1);
> +		if (unlikely(!stat->pdata))
> +			return -ENOMEM;
> +		stat->state = STATISTIC_STATE_OFF;
> +		return 0;
> +	}
> +	stat->pdata = kzalloc(sizeof(struct percpu_data), GFP_KERNEL);
> +	if (unlikely(!stat->pdata))
> +		return -ENOMEM;
> +	for_each_online_cpu(cpu) {

hmn.  Now we're using only the online CPUs.  Ah, OK, you have a cpu-hotplug
handler.

> +static int statistic_transition(struct statistic *stat,
> +				struct statistic_info *info,
> +				enum statistic_state requested_state)
> +{
> +	int z = (requested_state < stat->state ? 1 : 0);
> +	int retval = -EINVAL;
> +
> +	while (stat->state != requested_state) {
> +		switch (stat->state) {
> +		case STATISTIC_STATE_INVALID:
> +			retval = ( z ? -EINVAL : statistic_initialise(stat) );
> +			break;
> +		case STATISTIC_STATE_UNCONFIGURED:
> +			retval = ( z ? statistic_uninitialise(stat)
> +				     : statistic_define(stat) );
> +			break;
> +		case STATISTIC_STATE_RELEASED:
> +			retval = ( z ? statistic_initialise(stat)
> +				     : statistic_alloc(stat, info) );
> +			break;
> +		case STATISTIC_STATE_OFF:
> +			retval = ( z ? statistic_free(stat, info)
> +				     : statistic_start(stat) );
> +			break;
> +		case STATISTIC_STATE_ON:
> +			retval = ( z ? statistic_stop(stat) : -EINVAL );
> +			break;

Lots of unneeded parentheses there.

> +static int statistic_reset(struct statistic *stat, struct statistic_info *info)
> +{
> +	enum statistic_state prev_state = stat->state;
> +	int cpu;
> +
> +	if (unlikely(stat->state < STATISTIC_STATE_OFF))
> +		return 0;
> +	statistic_transition(stat, info, STATISTIC_STATE_OFF);
> +	if (unlikely(info->flags & STATISTIC_FLAGS_NOINCR))
> +		statistic_reset_ptr(stat, stat->pdata);
> +	else
> +		for_each_cpu(cpu)

for_each_possible_cpu() (maybe)

> +static inline int statistic_fdata(struct statistic_interface *interface, int i,
> +				  struct statistic_file_private *fpriv)
> +{
> +	struct statistic *stat = &interface->stat[i];
> +	struct statistic_info *info = &interface->info[i];
> +	struct statistic_discipline *disc = &statistic_discs[stat->type];
> +	struct statistic_merge_private mpriv;
> +	int retval;
> +
> +	if (unlikely(stat->state < STATISTIC_STATE_OFF))
> +		return 0;
> +	if (unlikely(info->flags & STATISTIC_FLAGS_NOINCR))
> +		return disc->fdata(stat, info->name, fpriv, stat->pdata);
> +	mpriv.dst = statistic_alloc_ptr(stat, GFP_KERNEL, -1);
> +	if (unlikely(!mpriv.dst))
> +		return -ENOMEM;
> +	spin_lock_init(&mpriv.lock);
> +	mpriv.stat = stat;
> +	on_each_cpu(statistic_merge, &mpriv, 0, 1);
> +	retval = disc->fdata(stat, info->name, fpriv, mpriv.dst);
> +	statistic_free_ptr(stat, mpriv.dst);
> +	return retval;
> +}

You do like that `inline' thingy ;)

> +/* cpu hotplug handling for per-cpu data */
> +
> +static inline int _statistic_hotcpu(struct statistic_interface *interface,
> +				    int i, unsigned long action, int cpu)
> +{
> +	struct statistic *stat = &interface->stat[i];
> +	struct statistic_info *info = &interface->info[i];
> +
> +	if (unlikely(info->flags & STATISTIC_FLAGS_NOINCR))
> +		return 0;
> +	if (stat->state < STATISTIC_STATE_OFF)
> +		return 0;
> +	switch (action) {
> +	case CPU_UP_PREPARE:
> +		stat->pdata->ptrs[cpu] = statistic_alloc_ptr(stat, GFP_ATOMIC,
> +							     cpu_to_node(cpu));
> +		break;

So this allocation can fail.  Does all the other code handle that?  If not,
we should fail the CPU bringup.

Dangit, this is inlined as well.  It makes oops-tracing really hard :(

> +{
> +	statistic_root_dir = debugfs_create_dir(STATISTIC_ROOT_DIR, NULL);
> +	if (unlikely(!statistic_root_dir))
> +		return -ENOMEM;
> +	INIT_LIST_HEAD(&statistic_list);
> +	mutex_init(&statistic_list_mutex);
> +	register_cpu_notifier(&statistic_hotcpu_notifier);

Actually, this can fail too (well, actually it can't, but the API suggests
it can).

> +	int offset;
> +	struct list_head line_lh;
> +	char *nl;
> +	size_t line_size = 0;
> +
> +	INIT_LIST_HEAD(&line_lh);

	LIST_HEAD(line_lh);


> +
> +/* code concerned with utilisation indicator statistic */
> +
> +static void statistic_reset_util(struct statistic *stat, void *ptr)
> +{
> +	struct statistic_entry_util *util = ptr;
> +	util->num = 0;
> +	util->acc = 0;
> +	util->min = (~0ULL >> 1) - 1;
> +	util->max = -(~0ULL >> 1) + 1;
> +}

`min' is a large positive number and `max' is a large negative one.  Is that
right?

`min' gets 0x7ffffffffffffffe, which seems to be off-by-one.

Consider using LLONG_MAX and friends.

> +static void statistic_add_util(struct statistic *stat, int cpu,
> +			       s64 value, u64 incr)
> +{
> +	struct statistic_entry_util *util = stat->pdata->ptrs[cpu];
> +	util->num += incr;
> +	util->acc += value * incr;
> +	if (unlikely(value < util->min))
> +		util->min = value;
> +	if (unlikely(value > util->max))
> +		util->max = value;
> +}

ah, I get it!  `min' isn't minimum-allowable.  It's
minimum-it-has-ever-been.  Makes sense now.

> +static int statistic_fdata_util(struct statistic *stat, const char *name,
> +				struct statistic_file_private *fpriv,
> +				void *data)
> +{
> +	struct sgrb_seg *seg;
> +	struct statistic_entry_util *util = data;
> +	unsigned long long whole = 0;
> +	signed long long min = 0, max = 0, decimal = 0, last_digit;
> +
> +	seg = sgrb_seg_find(&fpriv->read_seg_lh, 128);
> +	if (unlikely(!seg))
> +		return -ENOMEM;
> +	if (likely(util->num)) {
> +		whole = util->acc;
> +		do_div(whole, util->num);
> +		decimal = util->acc * 10000;
> +		do_div(decimal, util->num);
> +		decimal -= whole * 10000;
> +		if (decimal < 0)
> +			decimal = -decimal;
> +		last_digit = decimal;
> +		do_div(last_digit, 10);
> +		last_digit = decimal - last_digit * 10;
> +		if (last_digit >= 5)
> +			decimal += 10;
> +		do_div(decimal, 10);
> +		min = util->min;
> +		max = util->max;
> +	}
> +	seg->offset += sprintf(seg->address + seg->offset,
> +			       "%s %Lu %Ld %Ld.%03lld %Ld\n", name,
> +			       (unsigned long long)util->num,
> +			       (signed long long)min, whole, decimal,
> +			       (signed long long)max);

There's no need to cast `min' and `max' here.  A cast would be needed if
they were u64/s64.

> +
> +static inline int statistic_add_sparse_new(struct statistic_sparse_list *slist,
> +					   s64 value, u64 incr)
> +{
> +	struct statistic_entry_sparse *entry;
> +
> +	if (unlikely(slist->entries == slist->entries_max))
> +		return -ENOMEM;
> +	entry = kmalloc(sizeof(struct statistic_entry_sparse), GFP_ATOMIC);
> +	if (unlikely(!entry))
> +		return -ENOMEM;
> +	entry->value = value;
> +	entry->hits = incr;
> +	slist->entries++;
> +	list_add_tail(&entry->list, &slist->entry_lh);
> +	return 0;
> +}
>
> +static inline void _statistic_add_sparse(struct statistic_sparse_list *slist,
> +					 s64 value, u64 incr)
> +{
> +	struct list_head *head = &slist->entry_lh;
> +	struct statistic_entry_sparse *entry;
> +
> +	list_for_each_entry(entry, head, list) {
> +		if (likely(entry->value == value)) {
> +			entry->hits += incr;
> +			statistic_add_sparse_sort(head, entry);
> +			return;
> +		}
> +	}
> +	if (unlikely(statistic_add_sparse_new(slist, value, incr)))
> +		slist->hits_missed += incr;
> +}

I hereby revoke your inlining license.

> +static void statistic_set_sparse(struct statistic *stat, s64 value, u64 total)
> +{
> +	struct statistic_sparse_list *slist = (struct statistic_sparse_list *)
> +						stat->pdata;

Hang on, what's happening here?  statistic.pdata is `struct percpu_data *'.
That's

struct percpu_data {
	void *ptrs[NR_CPUS];
};

How can we cast that to a statistic_sparse_list* and then start playing
with it?  We're supposed to use per_cpu_ptr() to get at the actual data.


