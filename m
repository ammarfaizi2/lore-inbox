Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261627AbVAGVJd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261627AbVAGVJd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 16:09:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261613AbVAGVIl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 16:08:41 -0500
Received: from [213.146.154.40] ([213.146.154.40]:21701 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261603AbVAGVH2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 16:07:28 -0500
Date: Fri, 7 Jan 2005 21:07:26 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Nikita Danilov <nikita@clusterfs.com>
Cc: Christoph Hellwig <hch@infradead.org>, Vladimir Saveliev <vs@namesys.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-mm <linux-mm@kvack.org>
Subject: Re: [RFC] per thread page reservation patch
Message-ID: <20050107210726.GA16215@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Nikita Danilov <nikita@clusterfs.com>,
	Vladimir Saveliev <vs@namesys.com>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org, linux-mm <linux-mm@kvack.org>
References: <20050103011113.6f6c8f44.akpm@osdl.org> <20050103114854.GA18408@infradead.org> <41DC2386.9010701@namesys.com> <1105019521.7074.79.camel@tribesman.namesys.com> <20050107144644.GA9606@infradead.org> <1105118217.3616.171.camel@tribesman.namesys.com> <20050107190545.GA13898@infradead.org> <m1pt0hq81x.fsf@clusterfs.com> <20050107205444.GA15969@infradead.org> <m1hdltq7jj.fsf@clusterfs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1hdltq7jj.fsf@clusterfs.com>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 08, 2005 at 12:00:00AM +0300, Nikita Danilov wrote:
> I don't see how this can work.
> 
>         /* make conservative estimation... */
>         perthread_pages_reserve(100, GFP_KERNEL);
> 
>         /* actually, use only 10 pages during atomic operation */
> 
>         /* want to release remaining 90 pages... */
>         perthread_pages_release(???);
> 
> Can you elaborate how to calculate number of pages that has to be
> released?

That's a good question actually, and it's true for the original
version aswell if we want (and to make the API useful we must) make
it useable for multiple callers in the same thread.

Assuming the callers strictly nest we can indeed just go back to the
orininal count, maybe with an API like:

int perthread_pages_reserve(unsigned int nrpages, unsigned int gfp_mask);
void perthread_pages_release(unsigned int nrpages_goal);


	unsigned int old_nr_pages;

	...

	old_nr_pages = perthread_pages_reserve(100, GFP_KERNEL);

	...

	perthread_pages_release(old_nr_pages);

