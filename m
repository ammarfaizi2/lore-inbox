Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261332AbSJ1QPb>; Mon, 28 Oct 2002 11:15:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261338AbSJ1QPb>; Mon, 28 Oct 2002 11:15:31 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:18081 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S261332AbSJ1QPa>;
	Mon, 28 Oct 2002 11:15:30 -0500
Date: Mon, 28 Oct 2002 17:18:57 +0100
From: Jens Axboe <axboe@suse.de>
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org, akpm@digeo.com
Subject: Re: [patch][cft] zero-copy dma cd writing and ripping
Message-ID: <20021028161857.GK2937@suse.de>
References: <20021018155650.GJ15494@suse.de> <20021028.043507.104714061.davem@redhat.com> <20021028124240.GC872@suse.de> <1035816048.8970.1.camel@rth.ninka.net> <20021028150832.GF2937@suse.de> <1035821017.9282.7.camel@rth.ninka.net> <20021028155401.GI2937@suse.de> <1035822310.8970.9.camel@rth.ninka.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1035822310.8970.9.camel@rth.ninka.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 28 2002, David S. Miller wrote:
> On Mon, 2002-10-28 at 07:54, Jens Axboe wrote:
> > I agree then. I will remove references to flush_dcache_page() in
> > bio_map_user() and bio_unmap_user(), and we'll just unconditionally do
> > flush_dcache_page() on every page mapped in get_user_pages(). That
> > sounds far better to me. Do you really expect users of get_user_pages()
> > to get this right (remember, we are often talking about device drivers
> > :-). I sure am not :)
> 
> I have no expectations whatsoever :-)
> I totally agree with you.

Good, so it shall be then :-)

A related question. get_user_pages() does page_cache_get() on the page,
except if it's reserved. First question is 'why' doesn't it do that on a
reserved page? We get this conditional when mapping, and the unmapping
needs to check for reserved as well before doing page_cache_release().
Surely the extra reference would be ok to hold for PageReserved pages
as well?

And it not, there's a bug if get_user_pages() fails:

	if (!PageReserved(pages[i]))
		page_cache_get(pages[i]);

and if we ever fail:

	while (i--)
		page_cache_release(pages[i]);

-- 
Jens Axboe

