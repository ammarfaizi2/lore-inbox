Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262900AbUJ0Vmn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262900AbUJ0Vmn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 17:42:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262728AbUJ0VhX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 17:37:23 -0400
Received: from holomorphy.com ([207.189.100.168]:4994 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S262916AbUJ0Vet (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 17:34:49 -0400
Date: Wed, 27 Oct 2004 14:34:41 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Jeff Garzik <jgarzik@pobox.com>, mbligh@aracnet.com,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org, bzolnier@gmail.com,
       rddunlap@osdl.org, axboe@suse.de
Subject: Re: [PATCH] Re: news about IDE PIO HIGHMEM bug (was: Re: 2.6.9-mm1)
Message-ID: <20041027213441.GC12934@holomorphy.com>
References: <58cb370e041027074676750027@mail.gmail.com> <417FBB6D.90401@pobox.com> <1246230000.1098892359@[10.10.2.4]> <1246750000.1098892883@[10.10.2.4]> <417FCE4E.4080605@pobox.com> <20041027142914.197c72ed.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041027142914.197c72ed.akpm@osdl.org>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik <jgarzik@pobox.com> wrote:
>> However, pfn_to_page(page_to_pfn(page) + 1) might be safer. If
>> rather slower. Is this patch acceptable to everyone?  Andrew?

On Wed, Oct 27, 2004 at 02:29:14PM -0700, Andrew Morton wrote:
> spose so.  The scatterlist API is being a bit silly there.
> It might be worthwhile doing:
> #ifdef CONFIG_DISCONTIGMEM
> #define nth_page(page,n) pfn_to_page(page_to_pfn((page)) + n)
> #else
> #define nth_page(page,n) ((page)+(n))
> #endif

This is actually not quite good enough. Zones are not guaranteed
to have adjacent mem_map[]'s even with CONFIG_DISCONTIGMEM=n. It may
make sense to prevent merging from spanning zones, but frankly the
overhead of the pfn_to_page()/page_to_pfn() is negligible in comparison
to the data movement and (when applicable) virtual windowing, where in
the merging code cpu overhead is a greater concern, particularly for
devices that don't require manual data movement.


-- wli
