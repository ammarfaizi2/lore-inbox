Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267372AbUHDTJL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267372AbUHDTJL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Aug 2004 15:09:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267373AbUHDTJL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Aug 2004 15:09:11 -0400
Received: from fw.osdl.org ([65.172.181.6]:18600 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267372AbUHDTJH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Aug 2004 15:09:07 -0400
Date: Wed, 4 Aug 2004 12:06:33 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jens Axboe <axboe@suse.de>
Cc: eric@cisu.net, kernel@kolivas.org, barryn@pobox.com,
       swsnyder@insightbb.com, linux-kernel@vger.kernel.org
Subject: Re: HIGHMEM4G config for 1GB RAM on desktop?
Message-Id: <20040804120633.4dca57b3.akpm@osdl.org>
In-Reply-To: <20040804130707.GN10340@suse.de>
References: <200408021602.34320.swsnyder@insightbb.com>
	<410FA145.70701@kolivas.org>
	<20040804060625.GE10340@suse.de>
	<200408040614.30820.eric@cisu.net>
	<20040804130707.GN10340@suse.de>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe <axboe@suse.de> wrote:
>
> > > > -#define __PAGE_OFFSET		(0xC0000000)
>  > > > +#define __PAGE_OFFSET		(0xB0000000)
>  > > >  #else
>  > > > -#define __PAGE_OFFSET		(0xC0000000UL)
>  > > > +#define __PAGE_OFFSET		(0xB0000000UL)
>  > > >  #endif
>  > >
>  > > Yup precisely. I agree that there probably isn't a whole lot of
>  > > performance hit on a 1GB, it just seems silly that we need highmem on
>  > > such a standard memory configuration these days. Especially when just
>  > > moving the offset slightly removes that need.
>  > 
>  > As a desktop user with 1024MB ram I agree that HIMEM has a silly threshold and 
>  > should not need to be enabled in this case. Its becoming common, especially 
>  > with dual channel memory systems to use 2x512MB sticks. On a hunch I bet 
>  > 2x512 is more common that 1x512 and 1x256 so why not merge this up? Who would 
>  > we submit this patch to?
> 
>  One way would be to ask Andrew what he thinks?

The 896M/128M split has a bit of a problem now each zone has its own LRU:
the size of the highmem zone is less than the amount of memory which is
described by the default /proc/sys/vm/dirty_ratio.  So it is easy to
completely fill highmem with dirty pages.  This causes a fairly large
amount of writeback via vmscan.c's writepage().  This causes poor I/O
submission patterns.  This causes a simple large, linear `dd' write to run
at only 50-70% of disk bandwidth.  (This was 6-12 months ago - it might be
a bit better now)

But I seem to be the only person who has noticed this yet ;) A workaround
is to decrease dirty_ratio and dirty_background_ratio.

Decreasing PAGE_OFFSET as above is attractive, but I believe 0xc0000000 is
part of the ABI, and although we know (from the 4g/4g and other such
patches) that everything will work OK, I wonder if it's really worth doing,
especially as it's a compile-time thing.

But hey, if someone can identify specific benefits from it then perhaps
sneaking in a config option, or maintaining an external patch would be
worthwhile.
