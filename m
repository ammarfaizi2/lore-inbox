Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293223AbSBWVom>; Sat, 23 Feb 2002 16:44:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293222AbSBWVod>; Sat, 23 Feb 2002 16:44:33 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:13587 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S293221AbSBWVoT>;
	Sat, 23 Feb 2002 16:44:19 -0500
Message-ID: <3C780CDA.FEAF9CB4@zip.com.au>
Date: Sat, 23 Feb 2002 13:42:50 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.18-rc2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Stephen Lord <lord@sgi.com>
CC: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] only irq-safe atomic ops
In-Reply-To: <3C773C02.93C7753E@zip.com.au.suse.lists.linux.kernel> <1014444810.1003.53.camel@phantasy.suse.lists.linux.kernel> <3C773C02.93C7753E@zip.com.au.suse.lists.linux.kernel> <1014449389.1003.149.camel@phantasy.suse.lists.linux.kernel> <3C774AC8.5E0848A2@zip.com.au.suse.lists.linux.kernel> <3C77F503.1060005@sgi.com.suse.lists.linux.kernel> <3C77FB35.16844FE7@zip.com.au.suse.lists.linux.kernel>,		Andrew Morton's message of "23 Feb 2002 21:36:17 +0100" <p73y9hjq5mw.fsf@oldwotan.suse.de> <3C78045C.668AB945@zip.com.au> <3C780702.9060109@sgi.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Lord wrote:
> 
> ...
> >If we needed exact reader-accounting for the number of dirty pages in the
> >machine then we'd need a ton of new locking in fun places like __free_pte(),
> >and that still doesn't account for pages which are only pte-dirty, and it's
> >not obvious what we'd do with reader-exact dirty page info anyway?
> >
> >
> You do want to avoid a leak in one direction or the other, the os would
> start to think it
> had lots of dirty pages, but not be able to find them, or think there is
> no shortage
> when in fact there was.

Oh absolutely.  Even a one-page-per-hour leak would be catastrophic.

But there is a problem.  If CPUA is always setting pages dirty,
and CPUB is always setting them clean, CPUA's counter will eventually
overflow, and CPUB's will underflow.  Drat. 

One fix for this would be special-case over- and under-flow handling:

	if (TestSetPageDirty(page)) {
		preempt_disable();
		nr_dirty_pages[smp_processor_id()]++;
		if (nr_dirty_pages[smp_processor_id()] > 2,000,000) {
			fit_it_up();
		}
		preempt_enable();
	}

	void fix_it_up()
	{
		spin_lock(&global_counter_lock);
		global_counter += 1,000,000;
		nr_dirty_pages[smp_processor_id()] -= 1,000,000;
		spin_unlock(&global_counter_lock);
	}

	int approx_total_dirty_pages()
	{
		int ret;

		spin_lock(&global_counter_lock);
		ret = global_counter;
		for (all cpus) {
			ret += nr_dirty_pages[cpu];
		}
		spin_unlock(&global_counter_lock);
		return ret;
	}

Or something like that.

Then again, maybe the underflows and overflows don't matter, because the
sum of all counters is always correct.   Unless there's a counter roll-over
during the summation.  No.  Even then it's OK.

hmmm.

-
