Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269432AbRHGUxU>; Tue, 7 Aug 2001 16:53:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269433AbRHGUxE>; Tue, 7 Aug 2001 16:53:04 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:50189 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S269432AbRHGUw6>;
	Tue, 7 Aug 2001 16:52:58 -0400
Date: Tue, 7 Aug 2001 13:18:57 -0400
From: Anton Blanchard <anton@samba.org>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: Andrew Tridgell <tridge@valinux.com>, lkml <linux-kernel@vger.kernel.org>,
        Rik van Riel <riel@conectiva.com.br>
Subject: Re: 2.4.8preX VM problems
Message-ID: <20010807131857.A13210@krispykreme>
In-Reply-To: <Pine.LNX.4.21.0108061954001.11203-100000@freak.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.21.0108061954001.11203-100000@freak.distro.conectiva>
User-Agent: Mutt/1.3.18i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
Hi Marcelo,

> Can you please use readprofile to find out where kswapd is spending its
> time when you reach 4G of pagecache ?
> 
> I've never seen kswapd burn CPU time except cases where a lot of memory is
> anonymous and there is a need for lots of swap space allocations.
> (scan_swap_map() is where kswapd spends "all" of its time in such
> workloads)

I was doing a run with 512M lowmem and 2.5G highmem and found this:

__alloc_pages: 1-order allocation failed.
__alloc_pages: 1-order allocation failed.
__alloc_pages: 1-order allocation failed.

# cat /proc/meminfo 
        total:    used:    free:  shared: buffers:  cached:
Mem:  3077513216 3067564032  9949184        0 13807616 2311172096
Swap: 2098176000        0 2098176000
MemTotal:      3005384 kB
MemFree:          9716 kB
MemShared:           0 kB
Buffers:         13484 kB
Cached:        2257004 kB
SwapCached:          0 kB
Active:         888916 kB
Inact_dirty:   1335552 kB
Inact_clean:     46020 kB
Inact_target:      316 kB
HighTotal:     2621440 kB
HighFree:         7528 kB
LowTotal:       383944 kB
LowFree:          2188 kB
SwapTotal:     2049000 kB
SwapFree:      2049000 kB

# readprofile | sort -nr | less
11967239 total                                      7.3285
7417874 idled                                    45230.9390
363813 do_page_launder                          119.3612
236764 ppc_irq_dispatch_handler                 332.5337

I can split out the do_page_launder usage if you want. I had a quick look
at the raw profile information and it appears that we are just looping a
lot.

Paulus and I moved the ppc32 kernel to load at 2G so we have 1.75G of
lowmem. This has stopped the kswapd problem, but I thought the above
information might be useful to you anyway.

Anton
