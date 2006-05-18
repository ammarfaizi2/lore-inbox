Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750765AbWERPaL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750765AbWERPaL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 May 2006 11:30:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751368AbWERPaL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 May 2006 11:30:11 -0400
Received: from mtagate4.de.ibm.com ([195.212.29.153]:29103 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP
	id S1750765AbWERPaI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 May 2006 11:30:08 -0400
Subject: Re: [RFC] [Patch 5/6] statistics infrastructure
From: Martin Peschke <mp3@de.ibm.com>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: linux-kernel@vger.kernel.org, chase.venters@clientec.com,
       nickpiggin@yahoo.com.au, kaos@ocs.com.au, akpm@osdl.org,
       clameter@sgi.com, fche@redhat.com, peterc@gelato.unsw.edu.au,
       hch@infradead.org, arjan@infradead.org, ak@suse.de
In-Reply-To: <20060517215256.2b471e72.rdunlap@xenotime.net>
References: <1147892180.3076.23.camel@dyn-9-152-230-71.boeblingen.de.ibm.com>
	 <20060517215256.2b471e72.rdunlap@xenotime.net>
Content-Type: text/plain
Date: Thu, 18 May 2006 17:30:05 +0200
Message-Id: <1147966205.2987.13.camel@dyn-9-152-230-71.boeblingen.de.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I fixed up all the things you have pointed out below.
Actually, I revised all kernel-doc comments and added a few more where
missing so far, like for some structs being part of the programming
interface.

I am going to resend my patches containing all the latest corrections
tomorrow.

On Wed, 2006-05-17 at 21:52 -0700, Randy.Dunlap wrote:
> On Wed, 17 May 2006 20:56:20 +0200 Martin Peschke wrote:
> 
> > This patch adds statistics infrastructure as common code.
> > 
> > Signed-off-by: Martin Peschke <mp3@de.ibm.com>
> > ---
> > 
> >  MAINTAINERS                |    7
> >  arch/s390/Kconfig          |    6
> >  arch/s390/oprofile/Kconfig |    5
> >  include/linux/statistic.h  |  296 +++++++++
> >  lib/Kconfig.statistic      |   11
> >  lib/Makefile               |    2
> >  lib/statistic.c            | 1454 +++++++++++++++++++++++++++++++++++++++++++++
> >  7 files changed, 1776 insertions(+), 5 deletions(-)
> > 
> > diff -Nurp a/include/linux/statistic.h b/include/linux/statistic.h
> > --- a/include/linux/statistic.h	1970-01-01 01:00:00.000000000 +0100
> > +++ b/include/linux/statistic.h	2006-05-17 19:11:32.000000000 +0200
> > @@ -0,0 +1,296 @@
> > +/*
> > + * include/linux/statistic.h
> > + *
> > + * Statistics facility
> > + *
> 
> If some of the following struct fields are private and some are
> public, you can use kernel-doc tags:
> 	/* private: */
> and
> 	/* public: */
> to delineate them.  See Doc/kernel-doc-nano-HOWTO.txt for more info.
> 
> > +struct statistic_interface {
> > +	/* private */
> > +	struct list_head	 list;
> > +	struct dentry		*debugfs_dir;
> > +	struct dentry		*data_file;
> > +	struct dentry		*def_file;
> > +	/* these have to be set by exploiter prior calling statistic_create() */
> > +	struct statistic	*stat;		/* mandatory */
> > +	struct statistic_info	*info;		/* mandatory */
> > +	int			 number;	/* mandatory */
> > +	int			(*pull)(void*);	/* optional */
> > +	void			*pull_private;	/* optional */
> > +};
> 
> > diff -Nurp a/lib/statistic.c b/lib/statistic.c
> > --- a/lib/statistic.c	1970-01-01 01:00:00.000000000 +0100
> > +++ b/lib/statistic.c	2006-05-17 19:11:32.000000000 +0200
> > @@ -0,0 +1,1454 @@
> > +/*
> > + *  lib/statistic.c
> > + *    statistics facility
> > + *
> > +
> > +static void statistic_parse_line(struct statistic_interface *interface,
> > +				 char *def)
> > +{
> > +	char *p, *copy, *twisted, *name = NULL;
> > +	substring_t args[MAX_OPT_ARGS];
> > +	int token, reset = 0, defaults = 0, i;
> > +	int state = STATISTIC_STATE_INVALID;
> > +	struct statistic *stat = interface->stat;
> > +	struct statistic_info *info = interface->info;
> > +
> > +	if (unlikely(!def))
> > +		return;
> > +	twisted = copy = kstrdup(def, GFP_KERNEL);
> > +	if (unlikely(!copy))
> > +		return;
> > +
> > +	while ((p = strsep(&twisted, " ")) != NULL) {
> > +		if (!*p)
> > +			continue;
> > +		token = match_token(p, statistic_match_common, args);
> > +		switch (token) {
> > +		case STATISTIC_STATE_UNCONFIGURED :
> > +		case STATISTIC_STATE_RELEASED :
> > +		case STATISTIC_STATE_OFF :
> > +		case STATISTIC_STATE_ON :
> 
> kernel coding style is no space before ':'.
> 
> > +			state = token;
> > +			break;
> > +		case 1001 :
> > +			if (likely(!name))
> > +				name = match_strdup(&args[0]);
> > +			break;
> > +		case 1002 :
> > +			reset = 1;
> > +			break;
> > +		case 1003 :
> > +			defaults = 1;
> > +			break;
> > +		}
> > +	}
> > +	for (i = 0; i < interface->number; i++, stat++, info++) {
> > +		if (!name || (name && !strcmp(name, info->name))) {
> > +			if (defaults)
> > +				statistic_parse_match(stat, info, NULL);
> > +			if (name)
> > +				statistic_parse_match(stat, info, def);
> > +			if (state != STATISTIC_STATE_INVALID)
> > +				statistic_transition(stat, info, state);
> > +			if (reset)
> > +				statistic_reset(stat, info);
> > +		}
> > +	}
> > +	kfree(copy);
> > +	kfree(name);
> > +}
> > +
> > +
> > +/**
> > + * statistic_create - setup statistics and create debugfs files
> > + *
> 
> No blank line between function name and parameters.
> Blank lines after parameters are good.
> 
> > + * @interface: struct statistic_interface provided by exploiter
> > + * @name: name of debugfs directory to be created
> > + *
> > + * struct statistic_interface must have been set up prior to calling this.
> > + *
> > + * Creates a debugfs directory in "statistics" as well as the "data" and
> > + * "definition" files. Then we attach setup statistics according to the
> > + * definition provided by exploiter through struct statistic_interface.
> > + *
> > + * On success, 0 is returned.
> > + *
> > + * If some required memory could not be allocated, or the creation
> > + * of debugfs entries failed, this routine fails, and -ENOMEM is returned.
> > + */
> > +int statistic_create(struct statistic_interface *interface, const char *name)
> > +{
> > +	struct statistic *stat = interface->stat;
> > +	struct statistic_info *info = interface->info;
> > +	int i;
> > +
> > +	BUG_ON(!stat || !info || !interface->number);
> > +
> > +	interface->debugfs_dir =
> > +		debugfs_create_dir(name, statistic_root_dir);
> > +	if (unlikely(!interface->debugfs_dir))
> > +		return -ENOMEM;
> > +
> > +	interface->data_file = debugfs_create_file(
> > +		STATISTIC_FILENAME_DATA, S_IFREG | S_IRUSR,
> > +		interface->debugfs_dir, (void*)interface, &statistic_data_fops);
> > +	if (unlikely(!interface->data_file)) {
> > +		debugfs_remove(interface->debugfs_dir);
> > +		return -ENOMEM;
> > +	}
> > +
> > +	interface->def_file = debugfs_create_file(
> > +		STATISTIC_FILENAME_DEF, S_IFREG | S_IRUSR | S_IWUSR,
> > +		interface->debugfs_dir, (void*)interface, &statistic_def_fops);
> > +	if (unlikely(!interface->def_file)) {
> > +		debugfs_remove(interface->data_file);
> > +		debugfs_remove(interface->debugfs_dir);
> > +		return -ENOMEM;
> > +	}
> > +
> > +	for (i = 0; i < interface->number; i++, stat++, info++) {
> > +		statistic_transition(stat, info, STATISTIC_STATE_UNCONFIGURED);
> > +		statistic_parse_match(stat, info, NULL);
> > +	}
> > +
> > +	mutex_lock(&statistic_list_mutex);
> > +	list_add(&interface->list, &statistic_list);
> > +	mutex_unlock(&statistic_list_mutex);
> > +	return 0;
> > +}
> > +EXPORT_SYMBOL_GPL(statistic_create);
> > +
> > +
> > +static int statistic_parse_histogram(struct statistic *stat,
> > +				     struct statistic_info *info,
> > +				     int type, char *def)
> > +{
> > +	char *p;
> > +	substring_t args[MAX_OPT_ARGS];
> > +	int token, got_entries = 0, got_interval = 0, got_range = 0;
> > +	u32 entries, base_interval;
> > +	s64 range_min;
> > +
> > +	while ((p = strsep(&def, " ")) != NULL) {
> > +		if (!*p)
> > +			continue;
> > +		token = match_token(p, statistic_match_histogram, args);
> > +		switch (token) {
> > +		case 1 :
> 
> Lose the space before ':'.
> 
> > +			match_int(&args[0], &entries);
> > +			got_entries = 1;
> > +			break;
> > +		case 2 :
> > +			match_int(&args[0], &base_interval);
> > +			got_interval = 1;
> > +			break;
> > +		case 3 :
> > +			match_s64(&args[0], &range_min, 0);
> > +			got_range = 1;
> > +			break;
> > +		}
> > +	}
> > +	if (unlikely(type != stat->type &&
> > +		     !(got_entries && got_interval && got_range)))
> > +		return -EINVAL;
> > +	statistic_transition(stat, info, STATISTIC_STATE_UNCONFIGURED);
> > +	if (got_entries)
> > +		stat->u.histogram.last_index = entries - 1;
> > +	if (got_interval)
> > +		stat->u.histogram.base_interval = base_interval;
> > +	if (got_range)
> > +		stat->u.histogram.range_min = range_min;
> > +	return 0;
> > +}
> 
> ---
> ~Randy

