Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317148AbSGSWq7>; Fri, 19 Jul 2002 18:46:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317152AbSGSWq7>; Fri, 19 Jul 2002 18:46:59 -0400
Received: from meg.hrz.tu-chemnitz.de ([134.109.132.57]:50185 "EHLO
	meg.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id <S317148AbSGSWpZ>; Fri, 19 Jul 2002 18:45:25 -0400
Date: Sat, 20 Jul 2002 00:39:18 +0200
From: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
To: William D Waddington <csbwaddington@att.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [never mind] kiobufs and highmem
Message-ID: <20020720003918.G758@nightmaster.csn.tu-chemnitz.de>
References: <ic9gju44p7ukriuv4etl0tdc5f6uf5s08m@4ax.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <ic9gju44p7ukriuv4etl0tdc5f6uf5s08m@4ax.com>; from csbwaddington@att.net on Fri, Jul 19, 2002 at 08:00:00AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 19, 2002 at 08:00:00AM -0700, William D Waddington wrote:
> I haven't yet figured out how to allocate a (possibly) non-contiguous
> buffer, since vmalloc is frowned on, or how to populate the kiobuf
> with its pages.

Don't use the kiobuf, since it is bloated.

Try this instead:


/* Pin down user pages and put them into a scatter gather list */
int sg_map_user_pages(struct scatterlist *sgl, const unsigned int max_pages, 
		unsigned long uaddr, size_t count, int rw) {
	int res, i;
	unsigned int nr_pages=((uaddr & ~PAGE_MASK) + count - 1 + ~PAGE_MASK) >> PAGE_SHIFT;
	struct page *pages[max_pages];

	/* User attempted Overflow! */
	if ((uaddr + count) < uaddr)
		return -EINVAL;

	/* To big */
	if (nr_pages > max_pages)
		return -ENOMEM;

	/* Hmm? */
	if (count == 0)
		return 0;

	/* Not enough SGL entries provided! */
	BUG_ON((((uaddr & ~PAGE_MASK) + count + ~PAGE_MASK) >> PAGE_SHIFT) > max_pages );

	down_read(&current->mm->mmap_sem);
	res = get_user_pages(
			current,
			current->mm,
			uaddr,
			nr_pages,
			rw == READ, /* logic is perversed^Wreversed here :-( */
			0, /* don't force */
			&pages[0],
			NULL);
	up_read(&current->mm->mmap_sem);

	/* Errors and no page mapped should return here */
	if (res <= 0) return res;

	memset(sgl, 0, sizeof(*sgl) * nr_pages);

	sgl[0].page = pages[0];	
	sgl[0].offset = uaddr & PAGE_MASK;
	
	/* Page crossing transfers need these adjustments */
	if (res > 1) {
		for (i=1; i < res ; i++) {
			sgl[i].offset = 0;
			sgl[i].page = pages[i];	
			sgl[i].length = PAGE_SIZE;
		}
		sgl[0].length = PAGE_SIZE - sgl[0].offset;
		count -= sgl[0].length;
		count -= (res - 2) * PAGE_SIZE;
	}

	sgl[res - 1].length = count;

	return res;
}

/* And unmap them... */
int sg_unmap_user_pages(struct scatterlist *sgl, const unsigned int nr_pages) {
	int i;

	for (i=0; i < nr_pages; i++)
		page_cache_release(sgl[i].page);

	return 0;
}


That will give you nearly the same. You just have to lock_page()
the pages and UnlockPage() yourself.

Don't give to high values for max_pages, because this might
overflow your stack.

Do the pci_map_sg() after sg_map_user_pages() and pci_unmap_sg()
before sg_unmap_user_pages().

This should work. If you have highmem pages and your device can't
handle >32-bit physical addresses, then kmap() them
before pci_map_sg()ing them and kunmap() them after
pci_unmap_sg()ing.

kiobufs are (next to) useless for character io devices.

Hope that helps

Regards

Ingo Oeser
-- 
Science is what we can tell a computer. Art is everything else. --- D.E.Knuth
