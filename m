Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265950AbUBPWrX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Feb 2004 17:47:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265922AbUBPWrW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Feb 2004 17:47:22 -0500
Received: from gprs152-120.eurotel.cz ([160.218.152.120]:48002 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S265950AbUBPWo5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Feb 2004 17:44:57 -0500
Date: Mon, 16 Feb 2004 23:44:25 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Zwane Mwaikambo <zwane@linuxpower.ca>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       lhcs-devel@lists.sourceforge.net, Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH][2.6-mm] split drain_local_pages
Message-ID: <20040216224425.GB6628@elf.ucw.cz>
References: <Pine.LNX.4.58.0402161720390.11793@montezuma.fsmlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0402161720390.11793@montezuma.fsmlabs.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!


> CPU hotplug core needs to pass a cpu parameter to drain_local_pages, it's
> safe to call __drain_local_pages if the cpu being drained is offline. The
> semantics for drain_local_pages do not change.

The idea looks good to me, but there's something wrong with the patch:

> Index: linux-2.6.3-rc3-mm1/mm/page_alloc.c
> ===================================================================
> RCS file: /home/cvsroot/linux-2.6.3-rc3-mm1/mm/page_alloc.c,v
> retrieving revision 1.1.1.1
> diff -u -p -B -r1.1.1.1 page_alloc.c
> --- linux-2.6.3-rc3-mm1/mm/page_alloc.c	16 Feb 2004 20:42:50 -0000	1.1.1.1
> +++ linux-2.6.3-rc3-mm1/mm/page_alloc.c	16 Feb 2004 21:58:19 -0000
> @@ -414,19 +414,19 @@ int is_head_of_free_region(struct page *
>  }
> 
>  /*
> - * Spill all of this CPU's per-cpu pages back into the buddy allocator.
> + * drain_local_pages helper, this is only safe to use when the cpu
> + * being drained isn't currently online.
>   */
> -void drain_local_pages(void)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

It was void before...

> @@ -1574,7 +1586,7 @@ static int page_alloc_cpu_notify(struct
>  		count = &per_cpu(nr_pagecache_local, cpu);
>  		atomic_add(*count, &nr_pagecache);
>  		*count = 0;
> -		drain_local_pages(cpu);

...but code was passing cpu? The old version could not have compiled
according to the patch..
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
