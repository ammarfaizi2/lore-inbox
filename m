Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261943AbUCDPrt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Mar 2004 10:47:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261945AbUCDPrt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Mar 2004 10:47:49 -0500
Received: from phoenix.infradead.org ([213.86.99.234]:22534 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S261943AbUCDPrr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Mar 2004 10:47:47 -0500
Date: Thu, 4 Mar 2004 15:47:42 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Rik van Riel <riel@redhat.com>
Cc: Christoph Hellwig <hch@infradead.org>, Dave McCracken <dmccr@us.ibm.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>, linux-kernel@vger.kernel.org
Subject: Re: 230-objrmap fixes for 2.6.3-mjb2
Message-ID: <20040304154742.A12277@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Rik van Riel <riel@redhat.com>, Dave McCracken <dmccr@us.ibm.com>,
	"Martin J. Bligh" <mbligh@aracnet.com>,
	linux-kernel@vger.kernel.org
References: <20040303160802.A30084@infradead.org> <Pine.LNX.4.44.0403041040310.20043-100000@chimarrao.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0403041040310.20043-100000@chimarrao.boston.redhat.com>; from riel@redhat.com on Thu, Mar 04, 2004 at 10:41:51AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 04, 2004 at 10:41:51AM -0500, Rik van Riel wrote:
> On Wed, 3 Mar 2004, Christoph Hellwig wrote:
> > On Wed, Mar 03, 2004 at 09:58:44AM -0600, Dave McCracken wrote:
> > > It'd mean the page struct would have to have a count of the number of
> > > mlock()ed regions it belongs to, and we'd have to update all the pages each
> > > time we call it.
> > 
> > That would add another atomic_t to struct pages..
> 
> No need for that.  If a page is mlocked, it shouldn't be on any
> of the LRU lists (since it can't be swapped out yadda yadda).
> 
> That means the locked count can share space in the struct page
> with the list head used for the lru.
> 
> The only reason I haven't done this yet is that I didn't get
> around to it...

so would you be okay with an inkernel interface like:

void mlock_page(struct page *page)
{
	if (!test_and_set_bit(PG_mlocked, &page->flags)
		remove_from_lru_if_there();
	atomic_inc(&page.some_union->mlock_count);
}

if so that would help me greatly for xfs, but I'd also need a 2.4 variant..
