Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317338AbSGIINu>; Tue, 9 Jul 2002 04:13:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317339AbSGIINt>; Tue, 9 Jul 2002 04:13:49 -0400
Received: from meg.hrz.tu-chemnitz.de ([134.109.132.57]:18448 "EHLO
	meg.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id <S317338AbSGIINt>; Tue, 9 Jul 2002 04:13:49 -0400
Date: Tue, 9 Jul 2002 10:16:15 +0200
From: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
To: Andrew Morton <akpm@zip.com.au>
Cc: Douglas Gilbert <dougg@torque.net>, linux-kernel@vger.kernel.org
Subject: Re: direct-to-BIO for O_DIRECT
Message-ID: <20020709101615.B14399@nightmaster.csn.tu-chemnitz.de>
References: <3D2A5F34.F38B893F@torque.net> <3D2A6608.7C43EE3@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <3D2A6608.7C43EE3@zip.com.au>; from akpm@zip.com.au on Mon, Jul 08, 2002 at 09:26:48PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 08, 2002 at 09:26:48PM -0700, Andrew Morton wrote:
> > > It would be nice if we could just map a set of user pages
> > > to a scatterlist.
> > 
> > After disabling kiobufs in sg I would like such a drop
> > in replacement.
> 
> Ben had lightweight sg structures called `kvecs' and `kveclets'. And
> library functions to map pages into them.  And code to attach them
> to BIOs.  So we'll be looking at getting that happening.

BIOs are for BLOCK devices we want sth. like this for CHARACTER
devices.

I just want sth. along the lines of this:

/* Pin down (COMPLETE!) user pages and put them into a scatter gather list */
int sg_map_user_pages(struct scatterlist *sgl, const unsigned int nr_pages, 
		unsigned long uaddr, int rw) {
	int res, i;
	struct page *pages[nr_pages];

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

	for (i=1; i < res; i++) {
		sgl[i].page = pages[i];	
	}
	return res;
}

/* And unmap them... */
int sg_unmap_user_pages(struct scatterlist *sgl, const unsigned int nr_pages) {
	int i;

	for (i=0; i < nr_pages; i++)
		page_cache_release(sgl[i].page);

	return 0;
}

Possibly more complicated and less error prone, but you get the
idea ;-)

Regards

Ingo Oeser
-- 
Science is what we can tell a computer. Art is everything else. --- D.E.Knuth
