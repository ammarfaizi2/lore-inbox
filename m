Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271953AbRHVKnn>; Wed, 22 Aug 2001 06:43:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271958AbRHVKnd>; Wed, 22 Aug 2001 06:43:33 -0400
Received: from ns.ithnet.com ([217.64.64.10]:12810 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S271953AbRHVKnY>;
	Wed, 22 Aug 2001 06:43:24 -0400
Date: Wed, 22 Aug 2001 12:43:22 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Memory Problem in 2.4.9 ?
Message-Id: <20010822124322.708aec3d.skraw@ithnet.com>
In-Reply-To: <20010822010649Z16145-32383+774@humbolt.nl.linux.org>
In-Reply-To: <Pine.LNX.4.33L.0108212146470.5646-100000@imladris.rielhome.conectiva>
	<20010822010649Z16145-32383+774@humbolt.nl.linux.org>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.5.3 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Aug 2001 03:13:23 +0200
Daniel Phillips <phillips@bonn-fries.net> wrote:

> Oops, yes, I forgot for the moment that we no longer age up in 
> __find_page_nolock.  Lets try this instead, which should capture the intended 
> effect of requiring 4 hits to activate a page (n.b., it's just a test):
> 
> --- ../2.4.9.clean/mm/filemap.c	Thu Aug 16 14:12:07 2001
> +++ ./mm/filemap.c	Wed Aug 22 02:02:24 2001
> @@ -980,10 +980,9 @@
>  static inline void check_used_once (struct page *page)
>  {
>  	if (!PageActive(page)) {
> -		if (page->age)
> +		if (++page->age >= 4)
>  			activate_page(page);
>  		else {
> -			page->age = PAGE_AGE_START;
>  			ClearPageReferenced(page);
>  		}
>  	}
> 

Ok. I applied this patch. What I experience is this:

meminfo Before test:

        total:    used:    free:  shared: buffers:  cached:
Mem:  921726976 87789568 833937408        0  6705152 37306368
Swap: 271392768        0 271392768
MemTotal:       900124 kB
MemFree:        814392 kB
MemShared:           0 kB
Buffers:          6548 kB
Cached:          36432 kB
SwapCached:          0 kB
Active:           2944 kB
Inact_dirty:     40036 kB
Inact_clean:         0 kB
Inact_target:      868 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:       900124 kB
LowFree:        814392 kB
SwapTotal:      265032 kB
SwapFree:       265032 kB

meminfo after test:
        total:    used:    free:  shared: buffers:  cached:
Mem:  921726976 918429696  3297280        0  9211904 792858624
Swap: 271392768        0 271392768
MemTotal:       900124 kB
MemFree:          3220 kB
MemShared:           0 kB
Buffers:          8996 kB
Cached:         774276 kB
SwapCached:          0 kB
Active:          46776 kB
Inact_dirty:    731852 kB
Inact_clean:      4644 kB
Inact_target:     8460 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:       900124 kB
LowFree:          3220 kB
SwapTotal:      265032 kB
SwapFree:       265032 kB

I see the cache grow slowly but constantly during file-copy. I stopped the test, when the first errors occured from NFS at client side (cp: /backup/Aug/day_18_10.gz: Stale NFS file handle). Interestingly the errors came up, when all physical memory was eaten up by the cache, the free section was very low, but no swapping occured (swap _is_ turned on).
I could copy 766389 kB in total which looks roughly like cached-value. I guess there is simply no release done. Does the aging algorithm really work (as expected)?

Regards, Stephan
