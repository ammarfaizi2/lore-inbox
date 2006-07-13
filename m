Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964849AbWGMIAO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964849AbWGMIAO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 04:00:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964850AbWGMIAO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 04:00:14 -0400
Received: from smtp.osdl.org ([65.172.181.4]:1962 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964849AbWGMIAM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 04:00:12 -0400
Date: Thu, 13 Jul 2006 01:00:04 -0700
From: Andrew Morton <akpm@osdl.org>
To: Martin Peschke <mp3@de.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [Patch] statistics infrastructure - update 10
Message-Id: <20060713010004.63215f02.akpm@osdl.org>
In-Reply-To: <1152722709.3028.28.camel@dyn-9-152-230-71.boeblingen.de.ibm.com>
References: <1152707259.3028.7.camel@dyn-9-152-230-71.boeblingen.de.ibm.com>
	<20060712091024.c5bd19c7.akpm@osdl.org>
	<1152722709.3028.28.camel@dyn-9-152-230-71.boeblingen.de.ibm.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Jul 2006 18:45:08 +0200
Martin Peschke <mp3@de.ibm.com> wrote:

> On Wed, 2006-07-12 at 09:10 -0700, Andrew Morton wrote:
> > On Wed, 12 Jul 2006 14:27:39 +0200
> > Martin Peschke <mp3@de.ibm.com> wrote:
> > 
> > > +#define statistic_ptr(stat, cpu) \
> > > +	((struct percpu_data*)((stat)->data))->ptrs[(cpu)]
> > 
> > This would be the only part of the kernel which uses percpu_data directly -
> > everything else uses the APIs (ie: per_cpu_ptr()).  How come?
> 
> The API, i.e. per_cpu_ptr(), doesn't allow to assign a value to any of
> the pointers in struct percpu_data. I need that capability because I
> make use of cpu hotplug notifications to fix per-cpu data at run time.

Fair enough, I guess.

> With regard to memory footprint this is much more efficient than using
> alloc_percpu().

How much storage are we talking about here?  I find it a bit hard to work
that out.

> Is it be preferable to add something like set_per_cpu_ptr() to the API?

hm.  Add a generic extension to a generic interface within a specific
subsystem versus doing it generically.  Hard call ;)


I'd suggest that you:

- Create a new __alloc_percpu_mask(size_t size, cpumask_t cpus)

- Make that function use your newly added

	percpu_data_populate(struct percpu_data *p, int cpu, size_t size, gfp_t gfp);

	(maybe put `size' into 'struct percpu_data'?)

- implement __alloc_percpu() as __alloc_percpu_mask(size, cpu_possible_map)

- hack around madly until it compiles on uniprocessor.
