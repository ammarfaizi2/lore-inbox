Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263911AbVBDVMX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263911AbVBDVMX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Feb 2005 16:12:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264250AbVBDVMV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Feb 2005 16:12:21 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:63378 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S263911AbVBDVK1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Feb 2005 16:10:27 -0500
Date: Fri, 4 Feb 2005 21:10:14 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Tom Zanussi <zanussi@us.ibm.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Greg KH <greg@kroah.com>,
       Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@muc.de>,
       Roman Zippel <zippel@linux-m68k.org>,
       Robert Wisniewski <bob@watson.ibm.com>, Tim Bird <tim.bird@AM.SONY.COM>,
       karim@opersys.com
Subject: Re: [PATCH] relayfs redux, part 3
Message-ID: <20050204211014.GA25680@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Tom Zanussi <zanussi@us.ibm.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Greg KH <greg@kroah.com>, Andrew Morton <akpm@osdl.org>,
	Andi Kleen <ak@muc.de>, Roman Zippel <zippel@linux-m68k.org>,
	Robert Wisniewski <bob@watson.ibm.com>,
	Tim Bird <tim.bird@AM.SONY.COM>, karim@opersys.com
References: <16899.55393.651042.627079@tut.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16899.55393.651042.627079@tut.ibm.com>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

First set of comments.  Mostly ignores the actual filesystem sematics
bits, that'll come next.


> +#
> +# relayfs Makefile
> +#

probably superflous comment ;-)

> +	mem = vmap(*page_array, *page_count, GFP_KERNEL, PAGE_KERNEL);

Do you really need to vmap it, and eat up vmallocspace and TLB entries?
Maybe some simple arithmetics on a page array could replace it?

> +#include <linux/smp_lock.h>

don't think you need this one.

> +/**
> + *	relayfs_open - open file op for relayfs files
> + *	@inode: the inode
> + *	@filp: the file
> + *
> + *	Associates the channel buffer with the file, and increments the
> + *	channel buffer refcount.
> + */
> +int relayfs_open(struct inode *inode, struct file *filp)
> +{
> +	struct rchan_buf *buf;
> +	int retval = 0;
> +
> +	if (inode->u.generic_ip) {

Can inode->u.generic_ip ever be non-NULL?  What about using
->alloc_inode and ->destroy_inode to have the rchan_buf allocated
as part of the inode?

> +		retval = buf->chan->cb->fileop_notify(buf, filp, RELAY_FILE_OPEN);

I think you should split ->fileop_notify into individual operations for
each of the different events.

> +int relayfs_mmap(struct file *filp, struct vm_area_struct *vma)
> +{
> +	struct rchan_buf *buf = filp->private_data;
> +  
> +	return relay_mmap_buffer(buf, vma);
> +}

> +#include <asm/io.h>

What do you need this one for?

> +#include <asm/current.h>

should already be there through <linux/sched.h>

> +#include <asm/bitops.h>

please use <linux/bitops.h>

> +#include <asm/pgtable.h>

what do you need this one for?

> +#include <asm/hardirq.h>

always use <linux/hardirq.h> instead

> +/* \begin{Code inspired from BTTV driver} */

...

> +	while (size > 0) {
> +		page = kvirt_to_pa(pos);
> +		if (remap_pfn_range(vma, start, page >> PAGE_SHIFT, PAGE_SIZE, PAGE_SHARED))
> +			return -EAGAIN;
> +		start += PAGE_SIZE;
> +		pos += PAGE_SIZE;
> +		size -= PAGE_SIZE;
> +	}
> +
> +	return 0;
> +}

Using remap_pfn_range on normal kernel memory and the PageReserved flags, etc..
is not nice.  You'd better implement a ->nopage handler that just does a simple
array lookup and install the page.  And if you really care about the little
time this spends in the pagefault path you can implement ->populate and
support MAP_POPULATE mmaps :)

> +static struct rchan_buf *rchan_create_buf(struct rchan *chan)
> +{
> +	struct page **page_array;
> +	int page_count;
> +	struct rchan_buf *buf;
> +
> +	if ((buf = kcalloc(1, sizeof(struct rchan_buf), GFP_KERNEL)) == NULL)
> +		return NULL;

this doesn't fir the normal linux style.  Whic you use two lines below:

> +
> +	buf->padding = kmalloc(chan->n_subbufs * sizeof(unsigned *), GFP_KERNEL);
> +	if (buf->padding == NULL)
> +		goto free_buf;

> +	if ((buf->start = relay_alloc_rchan_buf(chan->alloc_size, &page_array, &page_count)) == NULL) {

but here again not.

> +		buf->page_array = NULL;
> +		buf->page_count = 0;
> +		goto free_commit;

also this would be cleaner if placed at another goto label at the end

> +	if ((buf = rchan_create_buf(chan)) == NULL)
> +		return NULL;

so this style is used in various places.  Please try to make it fit normal
style everywhere.

Also you're using foo == NULL a lot while we mostly use !foo.  This isn't
important in anyway, but would make reading a little easier.

> +#define relay_get_buf(chan, cpu)		(chan->buf[cpu])
> +#define relay_get_padding(buf, subbuf_idx)	(buf->padding[subbuf_idx])
> +#define relay_get_commit(buf, subbuf_idx)	(buf->commit[subbuf_idx])

I don't think these macros help following the code.

> +	unsigned long flags;
> +	struct rchan_buf *buf = relay_get_buf(chan, smp_processor_id());
> +
> +	local_irq_save(flags);

you need to place the relay_get_buf inside the locked region, so that
the return value from smp_processor_id() is stable.

