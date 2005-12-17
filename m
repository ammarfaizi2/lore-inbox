Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964957AbVLQUjd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964957AbVLQUjd (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Dec 2005 15:39:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964951AbVLQUjV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Dec 2005 15:39:21 -0500
Received: from smtp.osdl.org ([65.172.181.4]:54497 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964957AbVLQUjO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Dec 2005 15:39:14 -0500
Date: Sat, 17 Dec 2005 12:38:50 -0800
From: Andrew Morton <akpm@osdl.org>
To: Roland Dreier <rolandd@cisco.com>
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: Re: [PATCH 07/13]  [RFC] ipath core misc files
Message-Id: <20051217123850.aa6cfd53.akpm@osdl.org>
In-Reply-To: <200512161548.3fqe3fMerrheBMdX@cisco.com>
References: <200512161548.KglSM2YESlGlEQfQ@cisco.com>
	<200512161548.3fqe3fMerrheBMdX@cisco.com>
X-Mailer: Sylpheed version 2.1.8 (GTK+ 2.8.7; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roland Dreier <rolandd@cisco.com> wrote:
>
> ...
> +/*
> + * This isn't perfect, but it's close enough for timing work. We want this
> + * to work on systems where the cycle counter isn't the same as the clock
> + * frequency.  The one msec spin is OK, since we execute this only once
> + * when first loaded.  We don't use CURRENT_TIME because on some systems
> + * it only has jiffy resolution; we just assume udelay is well calibrated
> + * and that we aren't likely to be rescheduled.  Do it multiple times,
> + * with a yield in between, to try to make sure we get the "true minimum"
> + * value.
> + * _ipath_pico_per_cycle isn't going to lead to completely accurate
> + * conversions from timestamps to nanoseconds, but it's close enough
> + * for our purposes, which is mainly to allow people to show events with
> + * nsecs or usecs if desired, rather than cycles.
> + */
> +void ipath_init_picotime(void)
> +{
> +	int i;
> +	u_int64_t ts, te, delta = -1ULL;
> +
> +	for (i = 0; i < 5; i++) {
> +		ts = get_cycles();
> +		udelay(250);
> +		te = get_cycles();
> +		if ((te - ts) < delta)
> +			delta = te - ts;
> +		yield();
> +	}
> +	_ipath_pico_per_cycle = 250000000 / delta;
> +}

hm, I hope this is debug code which is going away.  If not, we should take
a look at what it's trying to do here.


> +/*
> + * Our version of the kernel mlock function.  This function is no longer
> + * exposed, so we need to do it ourselves.  It takes a given start page
> + * (page aligned user virtual address) and pins it and the following specified
> + * number of pages.
> + * For now, num_pages is always 1, but that will probably change at some
> + * point (because caller is doing expected sends on a single virtually
> + * contiguous buffer, so we can do all pages at once).
> + */
> +int ipath_mlock(unsigned long start_page, size_t num_pages, struct page **p)
> +{
> +	int n;
> +
> +	_IPATH_VDBG("pin %lx pages from vaddr %lx\n", num_pages, start_page);
> +	down_read(&current->mm->mmap_sem);
> +	n = get_user_pages(current, current->mm, start_page, num_pages, 1, 1,
> +			   p, NULL);
> +	up_read(&current->mm->mmap_sem);
> +	if (n != num_pages) {
> +		_IPATH_INFO
> +		    ("get_user_pages (0x%lx pages starting at 0x%lx failed with %d\n",
> +		     num_pages, start_page, n);
> +		if (n < 0)	/* it's an errno */
> +			return n;
> +		return -ENOMEM;	/* no way to know actual error */
> +	}
> +
> +	return 0;
> +}

OK.  It's perhaps not a very well named function.

> +/*
> + * this is similar to ipath_mlock, but it's always one page, and we mark
> + * the page as locked for i/o, and shared.  This is used for the user process
> + * page that contains the destination address for the rcvhdrq tail update,
> + * so we need to have the vma.  If we don't do this, the page can be taken
> + * away from us on fork, even if the child never touches it, and then
> + * the user process never sees the tail register updates.
> + */
> +int ipath_mlock_nocopy(unsigned long start_page, struct page **p)
> +{
> +	int n;
> +	struct vm_area_struct *vm = NULL;
> +
> +	down_read(&current->mm->mmap_sem);
> +	n = get_user_pages(current, current->mm, start_page, 1, 1, 1, p, &vm);
> +	up_read(&current->mm->mmap_sem);
> +	if (n != 1) {
> +		_IPATH_INFO("get_user_pages for 0x%lx failed with %d\n",
> +			    start_page, n);
> +		if (n < 0)	/* it's an errno */
> +			return n;
> +		return -ENOMEM;	/* no way to know actual error */
> +	}
> +	vm->vm_flags |= VM_SHM | VM_LOCKED;
> +
> +	return 0;
> +}

I don't think we want to be setting the user's VMA's vm_flags in this
manner.  This is purely to retain the physical page across fork?

> +/*
> + * Our version of the kernel munlock function.  This function is no longer
> + * exposed, so we need to do it ourselves.  It unpins the start page
> + * (a page aligned full user virtual address, not a page number)
> + * and pins it and the following specified number of pages.
> + */
> +int ipath_munlock(size_t num_pages, struct page **p)
> +{
> +	int i;
> +
> +	for (i = 0; i < num_pages; i++) {
> +		_IPATH_MMDBG("%u/%lu put_page %p\n", i, num_pages, p[i]);
> +		SetPageDirty(p[i]);
> +		put_page(p[i]);
> +	}
> +	return 0;
> +}

Nope, SetPageDirty() doesn't tell the VM that the page is dirty - it'll
never get written out.  Use set_page_dirty_lock().


