Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261316AbSJ1Pum>; Mon, 28 Oct 2002 10:50:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261317AbSJ1Pul>; Mon, 28 Oct 2002 10:50:41 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:44958 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S261316AbSJ1Pui>;
	Mon, 28 Oct 2002 10:50:38 -0500
Date: Mon, 28 Oct 2002 16:54:01 +0100
From: Jens Axboe <axboe@suse.de>
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org, akpm@digeo.com
Subject: Re: [patch][cft] zero-copy dma cd writing and ripping
Message-ID: <20021028155401.GI2937@suse.de>
References: <20021018155650.GJ15494@suse.de> <20021028.043507.104714061.davem@redhat.com> <20021028124240.GC872@suse.de> <1035816048.8970.1.camel@rth.ninka.net> <20021028150832.GF2937@suse.de> <1035821017.9282.7.camel@rth.ninka.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1035821017.9282.7.camel@rth.ninka.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 28 2002, David S. Miller wrote:
> On Mon, 2002-10-28 at 07:08, Jens Axboe wrote:
> > Ok what I make of this is that from bio_map_user() (which does a
> > get_user_pages() I need to do a
> > 
> > 	if (write_to_vm)
> > 		flush_dcache_page(page);
> > 
> > and in bio_unmap_user() I do
> > 
> > 	if (!write_to_vm)
> > 		flush_dcache_page(page);
> > 
> > is that correct?
> 
> Ho hum, it is tricky :-)))
> 
> At bio_map_user() you need to see the user's most recent write
> to the page if you are going "user --> device".  So if "user
> --> device" bio_map_user() must flush_dcache_page().

Yes, that that is the

	if (write_to_vm)
		flush_dcache_page(page);

> I find the write_to_vm condition confusion which is probably why
> I am sitting here spelling this out :-)

Hehe, actually these are confusing, but write_to_vm is probably the
least confusing wording I think. It means we are reading from the
device, thus writing to vm pages.

> At bio_unmap_user(), if we are going "device --> user" you have
> to flush_dcache_page().  And actually, this flush could just as
> legitimately occur at bio_map_user() time.

Thus

	if (!write_to_vm)
		flush_dcache_page(page);

> Therefore, the easiest thing to do is always flush_dcache_page()
> at bio_map_user().
> 
> All the other cases are going to be like this, so we might as
> well cut to the chase and flush_dcache_page() for all the pages
> inside of get_user_pages().
> 
> Whoever made get_user_pages() and didn't carry over the
> flush_dcache_page calls from the mechanism it is meant to replace
> should be spanked :-)

I agree then. I will remove references to flush_dcache_page() in
bio_map_user() and bio_unmap_user(), and we'll just unconditionally do
flush_dcache_page() on every page mapped in get_user_pages(). That
sounds far better to me. Do you really expect users of get_user_pages()
to get this right (remember, we are often talking about device drivers
:-). I sure am not :)

-- 
Jens Axboe

