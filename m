Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261386AbTCaFLO>; Mon, 31 Mar 2003 00:11:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261391AbTCaFLO>; Mon, 31 Mar 2003 00:11:14 -0500
Received: from holomorphy.com ([66.224.33.161]:3520 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S261386AbTCaFLN>;
	Mon, 31 Mar 2003 00:11:13 -0500
Date: Sun, 30 Mar 2003 21:22:14 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrea Arcangeli <andrea@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: 64GB NUMA-Q after pgcl
Message-ID: <20030331052214.GV13178@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrea Arcangeli <andrea@suse.de>, linux-kernel@vger.kernel.org
References: <20030328040038.GO1350@holomorphy.com> <20030330231945.GH2318@x30.local> <20030331042729.GQ30140@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030331042729.GQ30140@holomorphy.com>
User-Agent: Mutt/1.3.28i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 30, 2003 at 08:27:29PM -0800, William Lee Irwin III wrote:
> I can answer more questions about what goes on to make this happen if
> need be.

I'm just going to start explaining now.

-----------------------------------------      page clustering turns the
|             struct page               |      relationship between base
-----------------------------------------      pages and ptes into 1:N.
  ^   ^   ^   ^   ^   ^   ^   ^   ^   ^        struct pages remain of the
  |   |   |   |   |   |   |   |   |   |        same size, but track a
-----------------------------------------      larger area and are fewer
|PTE|PTE|PTE|PTE|PTE|PTE|PTE|PTE|PTE|PTE|      in number. ptes still point
-----------------------------------------      to the same size areas.


Anonymous pages want smaller than PAGE_SIZE pieces at a time, in fact
exactly 4KB (MMUPAGE_SIZE) to satisfy any particular fault, so we scan
around looking for PTE's to point at as many of the 4KB pieces as we can.

     -------------------------------
                    page
     -------------------------------
     piece | piece | piece | piece |
     -------------------------------
       \        \       \        \
        \        \        \         \
         \        \         \          \
          \        \          \           \
           \        \           \            \
            \        \            \             \
             \        \             \              \
     -------------------------------------------------------------
      PTE  |  PTE  |  PTE  |  PTE  |  PTE  |  PTE  |  PTE  |  PTE
     -------------------------------------------------------------


Miscellaneous side effects happen, like follow_page() and
get_user_pages() need to return pfn's instead of struct pages. Various
address calculations start needing unit conversions. Pagecache lookups
need to add in "subpfn offsets" relative to start of the base page. And
so on and so forth.

The net result should be (and was in Hugh's code) that there is zero
impact on binary compatibility. The smaller EXEC_PAGE_SIZE a.k.a.
MMUPAGE_SIZE is 100% faithfully emulated and the entire affair is fully
transparent to userspace. The maximum filesystem blocksize is increased.
And various O(pages) traversals get linear speedups, and various
O(pages) -sized data structures get linear size reductions.


-- wli
