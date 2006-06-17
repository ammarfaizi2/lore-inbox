Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751525AbWFQKa3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751525AbWFQKa3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Jun 2006 06:30:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751547AbWFQKa3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Jun 2006 06:30:29 -0400
Received: from mtagate1.de.ibm.com ([195.212.29.150]:62299 "EHLO
	mtagate1.de.ibm.com") by vger.kernel.org with ESMTP
	id S1751525AbWFQKa2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Jun 2006 06:30:28 -0400
Subject: Re: statistics infrastructure (in -mm tree) review
From: Martin Peschke <mp3@de.ibm.com>
To: Greg KH <greg@kroah.com>
Cc: Wu Fengguang <wfg@mail.ustc.edu.cn>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <20060613234739.GA30534@kroah.com>
References: <20060613232131.GA30196@kroah.com>
	 <20060613234739.GA30534@kroah.com>
Content-Type: text/plain
Date: Sat, 17 Jun 2006 12:30:17 +0200
Message-Id: <1150540217.2924.40.camel@dyn-9-152-230-71.boeblingen.de.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-06-13 at 16:47 -0700, Greg KH wrote:
> ... I'd really
> like to see some other, real-world usages of this.  Like perhaps the
> io-schedular statistics?  Some other /proc stats that have nothing to do
> with processes?

Wu is trying it out for readahead statistics:
http://marc.theaimsgroup.com/?l=linux-kernel&m=114946958531310&w=2
I am working on SCSI I/O statistics:
http://marc.theaimsgroup.com/?l=linux-kernel&m=114780190921567&w=2

The zfcp driver (FCP HBA driver for s390) in -mm exports
statistics through this infrastructure.

I could imagine that this code might be exploited by other s390 device
drivers, once we are forced to find a replacement for
homegrown statistics in procfs.

> Oh, and use C99 structure initializers for when creating the statisic
> structures in the example code (and real code), it makes it much easier
> to understand, and future proof when the api changes.

good point - done

> Code comments now:
> 
> 
> > diff -puN arch/s390/Kconfig~statistics-infrastructure arch/s390/Kconfig
> > --- devel/arch/s390/Kconfig~statistics-infrastructure	2006-06-09 15:22:58.000000000 -0700
> > +++ devel-akpm/arch/s390/Kconfig	2006-06-09 15:22:58.000000000 -0700
> > @@ -490,8 +490,14 @@ source "drivers/net/Kconfig"
> >  
> >  source "fs/Kconfig"
> >  
> > +menu "Instrumentation Support"
> > +
> >  source "arch/s390/oprofile/Kconfig"
> >  
> > +source "lib/Kconfig.statistic"
> > +
> > +endmenu
> > +
> >  source "arch/s390/Kconfig.debug"
> >  
> >  source "security/Kconfig"
> > diff -puN arch/s390/oprofile/Kconfig~statistics-infrastructure arch/s390/oprofile/Kconfig
> > --- devel/arch/s390/oprofile/Kconfig~statistics-infrastructure	2006-06-09 15:22:58.000000000 -0700
> > +++ devel-akpm/arch/s390/oprofile/Kconfig	2006-06-09 15:22:58.000000000 -0700
> > @@ -1,6 +1,3 @@
> > -
> > -menu "Profiling support"
> > -
> >  config PROFILING
> >  	bool "Profiling support"
> >  	help
> > @@ -18,5 +15,3 @@ config OPROFILE
> >  
> >  	  If unsure, say N.
> >  
> > -endmenu
> > -
> 
> These two patches should probably go somewhere else, they don't have
> much to do with this one.  (well, adding Kconfig.statistic" does, but
> the other wording doesn't.)

sorry, not sure what you mean

> > diff -puN /dev/null include/linux/statistic.h
> > --- /dev/null	2006-06-03 22:34:36.282200750 -0700
> > +++ devel-akpm/include/linux/statistic.h	2006-06-09 15:22:58.000000000 -0700
> > @@ -0,0 +1,348 @@
> > +/*
> > + * include/linux/statistic.h
> > + *
> > + * Statistics facility
> > + *
> > + * (C) Copyright IBM Corp. 2005, 2006
> > + *
> > + * Author(s): Martin Peschke <mpeschke@de.ibm.com>
> > + *
> > + * This program is free software; you can redistribute it and/or modify
> > + * it under the terms of the GNU General Public License as published by
> > + * the Free Software Foundation; either version 2, or (at your option)
> > + * any later version.
> 
> Are you sure "any later version"?

well, let me get back to an IBM lawyer first...
;-)

> > + * This program is distributed in the hope that it will be useful,
> > + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > + * GNU General Public License for more details.
> > + *
> > + * You should have received a copy of the GNU General Public License
> > + * along with this program; if not, write to the Free Software
> > + * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
> 
> Two not-needed paragraphs.

ditto.

> > +#ifndef STATISTIC_H
> > +#define STATISTIC_H
> > +
> > +#include <linux/fs.h>
> > +#include <linux/types.h>
> > +#include <linux/percpu.h>
> > +
> > +#define STATISTIC_ROOT_DIR	"statistics"
> > +
> > +#define STATISTIC_FILENAME_DATA	"data"
> > +#define STATISTIC_FILENAME_DEF	"definition"
> > +
> > +#define STATISTIC_NEED_BARRIER	1
> 
> Meta-comment about this file, does most of the stuff in this file,
> really belong here?  At first glance, this should only hold the public
> interface to the statistic code, not everything else needed by the
> internal workings of that code.  It looks like it could be made a lot
> smaller.

I slimmed the header file down, for example by moving some structures
to lib/statistic.c. Do you think a lib/statistic.h would be a better
place?

> > +enum statistic_state {
> > +	STATISTIC_STATE_INVALID,
> > +	STATISTIC_STATE_UNCONFIGURED,
> > +	STATISTIC_STATE_RELEASED,
> > +	STATISTIC_STATE_OFF,
> > +	STATISTIC_STATE_ON
> > +};
> > +
> > +enum statistic_type {
> > +	STATISTIC_TYPE_COUNTER_INC,
> > +	STATISTIC_TYPE_COUNTER_PROD,
> > +	STATISTIC_TYPE_UTIL,
> > +	STATISTIC_TYPE_HISTOGRAM_LIN,
> > +	STATISTIC_TYPE_HISTOGRAM_LOG2,
> > +	STATISTIC_TYPE_SPARSE,
> > +	STATISTIC_TYPE_NONE
> > +};
> 
> Make these bit-safe so sparse can catch mistakes?
> 
> > +#define STATISTIC_FLAGS_NOINCR	0x01
> 
> What's this for?

added comment with explaination

> > +struct sgrb_seg {
> > +	struct list_head list;
> > +	char *address;
> > +	int offset;
> > +	int size;
> > +};
> > +
> > +struct statistic_file_private {
> > +	struct list_head read_seg_lh;
> > +	struct list_head write_seg_lh;
> > +	size_t write_seg_total_size;
> > +};
> > +
> > +struct statistic_merge_private {
> > +	struct statistic *stat;
> > +	spinlock_t lock;
> > +	void *dst;
> > +};
> 
> I'm guessing these three structures aren't needed here.  Otherwise,
> please document them.

moved to lib/statistic.c

> > +#ifdef CONFIG_STATISTICS
> 
> Why ifdef now, so late?

added comment with explaination

> > +extern int statistic_create(struct statistic_interface *, const char *);
> > +extern int statistic_remove(struct statistic_interface *);
> > +
> > +/**
> > + * statistic_add - update statistic with incremental data in (X, Y) pair
> > + * @stat: struct statistic array
> > + * @i: index of statistic to be updated
> > + * @value: X
> > + * @incr: Y
> > + *
> > + * The actual processing of the (X, Y) data pair is determined by the current
> > + * the definition applied to the statistic. See Documentation/statistics.txt.
> > + *
> > + * This variant takes care of protecting per-cpu data. It is preferred whenever
> > + * exploiters don't update several statistics of the same entity in one go.
> > + */
> > +static inline void statistic_add(struct statistic *stat, int i,
> > +				 s64 value, u64 incr)
> > +{
> > +	unsigned long flags;
> > +	local_irq_save(flags);
> > +	if (stat[i].state == STATISTIC_STATE_ON)
> > +		stat[i].add(&stat[i], smp_processor_id(), value, incr);
> > +	local_irq_restore(flags);
> > +}
> 
> These are all inline, which I guess is acceptable.  But see the current
> inline-or-not comments on lkml which may make you rethink this.

Still got to lookup this thread. I might change it later.

> > +/**
> > + * statistic_add_nolock - update statistic with incremental data in (X, Y) pair
> > + * @stat: struct statistic array
> > + * @i: index of statistic to be updated
> > + * @value: X
> > + * @incr: Y
> > + *
> > + * The actual processing of the (X, Y) data pair is determined by the current
> > + * definition applied to the statistic. See Documentation/statistics.txt.
> > + *
> > + * This variant leaves protecting per-cpu data to exploiters. It is preferred
> > + * whenever exploiters update several statistics of the same entity in one go.
> > + */
> > +static inline void statistic_add_nolock(struct statistic *stat, int i,
> > +					s64 value, u64 incr)
> > +{
> > +	if (stat[i].state == STATISTIC_STATE_ON)
> > +		stat[i].add(&stat[i], smp_processor_id(), value, incr);
> > +}
> > +
> > +/**
> > + * statistic_inc - update statistic with incremental data in (X, 1) pair
> > + * @stat: struct statistic array
> > + * @i: index of statistic to be updated
> > + * @value: X
> > + *
> > + * The actual processing of the (X, Y) data pair is determined by the current
> > + * definition applied to the statistic. See Documentation/statistics.txt.
> > + *
> > + * This variant takes care of protecting per-cpu data. It is preferred whenever
> > + * exploiters don't update several statistics of the same entity in one go.
> > + */
> > +static inline void statistic_inc(struct statistic *stat, int i, s64 value)
> > +{
> > +	unsigned long flags;
> > +	local_irq_save(flags);
> > +	if (stat[i].state == STATISTIC_STATE_ON)
> > +		stat[i].add(&stat[i], smp_processor_id(), value, 1);
> > +	local_irq_restore(flags);
> > +}
> 
> Shouldn't this just call statistic_add() with a incr of 1?

correct - changed

> > +
> > +/**
> > + * statistic_inc_nolock - update statistic with incremental data in (X, 1) pair
> > + * @stat: struct statistic array
> > + * @i: index of statistic to be updated
> > + * @value: X
> > + *
> > + * The actual processing of the (X, Y) data pair is determined by the current
> > + * definition applied to the statistic. See Documentation/statistics.txt.
> > + *
> > + * This variant leaves protecting per-cpu data to exploiters. It is preferred
> > + * whenever exploiters update several statistics of the same entity in one go.
> > + */
> > +static inline void statistic_inc_nolock(struct statistic *stat, int i,
> > +					s64 value)
> > +{
> > +	if (stat[i].state == STATISTIC_STATE_ON)
> > +		stat[i].add(&stat[i], smp_processor_id(), value, 1);
> > +}
> 
> Shouldn't this just call statistic_add_nolock with a incr of 1?

ditto

> > diff -puN /dev/null lib/Kconfig.statistic
> > --- /dev/null	2006-06-03 22:34:36.282200750 -0700
> > +++ devel-akpm/lib/Kconfig.statistic	2006-06-09 15:22:58.000000000 -0700
> > @@ -0,0 +1,11 @@
> > +config STATISTICS
> > +	bool "Statistics infrastructure"
> > +	depends on DEBUG_FS
> > +	help
> > +	  The statistics infrastructure provides a debug-fs based user interface
> 
> No "-" in debugfs :)

sorry, has been fixed.

> > +	  for statistics of kernel components, that is, usually device drivers.
> 
> Why mention drivers?  Other things might use this (see original comments
> at the start of the message.)

yep, changed that as well

> > --- /dev/null	2006-06-03 22:34:36.282200750 -0700
> > +++ devel-akpm/lib/statistic.c	2006-06-09 15:22:58.000000000 -0700
> > @@ -0,0 +1,1459 @@
> > +/*
> > + *  lib/statistic.c
> > + *    statistics facility
> > + *
> > + *    Copyright (C) 2005, 2006
> > + *		IBM Deutschland Entwicklung GmbH,
> > + *		IBM Corporation
> > + *
> > + *    Author(s): Martin Peschke (mpeschke@de.ibm.com),
> > + *
> > + * This program is free software; you can redistribute it and/or modify
> > + * it under the terms of the GNU General Public License as published by
> > + * the Free Software Foundation; either version 2, or (at your option)
> > + * any later version.
> > + *
> > + * This program is distributed in the hope that it will be useful,
> > + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > + * GNU General Public License for more details.
> > + *
> > + * You should have received a copy of the GNU General Public License
> > + * along with this program; if not, write to the Free Software
> > + * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
> 
> Again with the verbose license :)

I will see...

> > +static void _statistic_barrier(void *unused)
> > +{
> > +}
> > +
> > +static inline int statistic_stop(struct statistic *stat)
> > +{
> > +	stat->stopped = sched_clock();
> > +	stat->state = STATISTIC_STATE_OFF;
> > +	/* ensures that all CPUs have ceased updating statistics */
> > +	smp_mb();
> > +	on_each_cpu(_statistic_barrier, NULL, 0, 1);
> > +	return 0;
> > +}
> 
> Isn't there a way to use rcu for this instead?  Just a suggestion, it
> might be totally wrong...

I am not an rcu expert. But I think rcu doesn't help here.
My barrier makes sure that all the concurrent updates have ceased
before I go on to free the underlying memory. It's a "many
writers"-scenario.

> > +
> > +static int statistic_transition(struct statistic *stat,
> > +				struct statistic_info *info,
> > +				enum statistic_state requested_state)
> > +{
> > +	int z = (requested_state < stat->state ? 1 : 0);
> > +	int retval = -EINVAL;
> 
> 	int retval = 0;
> 
> > +
> > +	while (stat->state != requested_state) {
> > +		switch (stat->state) {
> > +		case STATISTIC_STATE_INVALID:
> > +			retval = ( z ? -EINVAL : statistic_initialise(stat) );
> > +			break;
> > +		case STATISTIC_STATE_UNCONFIGURED:
> > +			retval = ( z ? statistic_uninitialise(stat)
> > +				     : statistic_define(stat) );
> > +			break;
> > +		case STATISTIC_STATE_RELEASED:
> > +			retval = ( z ? statistic_initialise(stat)
> > +				     : statistic_alloc(stat, info) );
> > +			break;
> > +		case STATISTIC_STATE_OFF:
> > +			retval = ( z ? statistic_free(stat, info)
> > +				     : statistic_start(stat) );
> > +			break;
> > +		case STATISTIC_STATE_ON:
> > +			retval = ( z ? statistic_stop(stat) : -EINVAL );
> > +			break;
> > +		}
> > +		if (unlikely(retval))
> > +			return retval;
> 
> delete these two lines.
> 
> > +	}
> > +	return 0;
> 
> 	return retval;

I have simplified this loop.

> > +static match_table_t statistic_match_type = {
> > +	{1, "type=%s"},
> > +	{9, NULL}
> > +};
> 
> named field initializers please.

done

> > +static match_table_t statistic_match_common = {
> > +	{STATISTIC_STATE_UNCONFIGURED, "state=unconfigured"},
> > +	{STATISTIC_STATE_RELEASED, "state=released"},
> > +	{STATISTIC_STATE_OFF, "state=off"},
> > +	{STATISTIC_STATE_ON, "state=on"},
> > +	{1001, "name=%s"},
> > +	{1002, "data=reset"},
> > +	{1003, "defaults"},
> > +	{9999, NULL}
> > +};
> 
> Same here.

Well, no one appears to do this with match_table_t.
And agree that this would be overkill.

> And why do you have numbers and a mix of enums here?  Shouldn't you
> define the name=, data= and defaults too?

Just for my convenience. It simplifies the (single) function using it.

> Also, just null terminate the list, is 9999 really needed?

match_token() requires this array to be terminated.

> > +static struct statistic_discipline statistic_discs[] = {
> > +	{ /* STATISTIC_TYPE_COUNTER_INC */
> > +	  NULL,
> > +	  statistic_alloc_generic,
> > +	  NULL,
> > +	  statistic_reset_counter,
> > +	  statistic_merge_counter,
> > +	  statistic_fdata_counter,
> > +	  NULL,
> > +	  statistic_add_counter_inc,
> > +	  statistic_set_counter_inc,
> > +	  "counter_inc", sizeof(u64)
> > +	},
> 
> named initializers please.  That will let you not have to specify the
> NULL fields, making it much easier to read overall.

You are right. Done.

Thanks, Martin

