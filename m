Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261311AbSJ1PoA>; Mon, 28 Oct 2002 10:44:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261312AbSJ1Pn7>; Mon, 28 Oct 2002 10:43:59 -0500
Received: from rth.ninka.net ([216.101.162.244]:19118 "EHLO rth.ninka.net")
	by vger.kernel.org with ESMTP id <S261311AbSJ1Pn7>;
	Mon, 28 Oct 2002 10:43:59 -0500
Subject: Re: [patch][cft] zero-copy dma cd writing and ripping
From: "David S. Miller" <davem@redhat.com>
To: Jens Axboe <axboe@suse.de>
Cc: linux-kernel@vger.kernel.org, akpm@digeo.com
In-Reply-To: <20021028150832.GF2937@suse.de>
References: <20021018155650.GJ15494@suse.de>
	<20021028.043507.104714061.davem@redhat.com> <20021028124240.GC872@suse.de>
	<1035816048.8970.1.camel@rth.ninka.net>  <20021028150832.GF2937@suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 28 Oct 2002 08:03:37 -0800
Message-Id: <1035821017.9282.7.camel@rth.ninka.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-10-28 at 07:08, Jens Axboe wrote:
> Ok what I make of this is that from bio_map_user() (which does a
> get_user_pages() I need to do a
> 
> 	if (write_to_vm)
> 		flush_dcache_page(page);
> 
> and in bio_unmap_user() I do
> 
> 	if (!write_to_vm)
> 		flush_dcache_page(page);
> 
> is that correct?

Ho hum, it is tricky :-)))

At bio_map_user() you need to see the user's most recent write
to the page if you are going "user --> device".  So if "user
--> device" bio_map_user() must flush_dcache_page().

I find the write_to_vm condition confusion which is probably why
I am sitting here spelling this out :-)

At bio_unmap_user(), if we are going "device --> user" you have
to flush_dcache_page().  And actually, this flush could just as
legitimately occur at bio_map_user() time.

Therefore, the easiest thing to do is always flush_dcache_page()
at bio_map_user().

All the other cases are going to be like this, so we might as
well cut to the chase and flush_dcache_page() for all the pages
inside of get_user_pages().

Whoever made get_user_pages() and didn't carry over the
flush_dcache_page calls from the mechanism it is meant to replace
should be spanked :-)

