Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318076AbSHBDoB>; Thu, 1 Aug 2002 23:44:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318080AbSHBDoB>; Thu, 1 Aug 2002 23:44:01 -0400
Received: from holomorphy.com ([66.224.33.161]:9407 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S318076AbSHBDoA>;
	Thu, 1 Aug 2002 23:44:00 -0400
Date: Thu, 1 Aug 2002 20:47:01 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@zip.com.au>
Cc: lkml <linux-kernel@vger.kernel.org>,
       "linux-mm@kvack.org" <linux-mm@kvack.org>,
       "Seth, Rohit" <rohit.seth@intel.com>,
       "Saxena, Sunil" <sunil.saxena@intel.com>,
       "Mallick, Asit K" <asit.k.mallick@intel.com>
Subject: Re: large page patch
Message-ID: <20020802034701.GG25038@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@zip.com.au>,
	lkml <linux-kernel@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"Seth, Rohit" <rohit.seth@intel.com>,
	"Saxena, Sunil" <sunil.saxena@intel.com>,
	"Mallick, Asit K" <asit.k.mallick@intel.com>
References: <3D49D45A.D68CCFB4@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
In-Reply-To: <3D49D45A.D68CCFB4@zip.com.au>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 01, 2002 at 05:37:46PM -0700, Andrew Morton wrote:
> This is a large-page support patch from Rohit Seth, forwarded
> with his permission (thanks!).

Overall, the code looks very clean.

(1) So there are now 4 of these things. How do they compare to each
	other? Where are the comparison benchmarks? How do their
	features compare? Which one(s) do users want?

(2) The allocation policies for pagetables mapping the things may as
	well do some kind of lookup, sharing, and cacheing; it's likely
	a significant number of the users of the shm segment will be
	mapping them more or less the same way given database usage
	patterns. It's not a significant amount of space, but kernels
	should be frugal about space, and with many tasks as is typical
	of databases, the savings may well add up to a small but
	respectable chunk of ZONE_NORMAL.

(3) As long as the interface is explicit, it might as well drop flags
	into shm and mmap. There isn't even C library support for these
	things as they are... time to int $0x80 again so I can test.

(4) Requiring app awareness of page alignment looks like an irritating
	porting issue, which doesn't sound as trivial as it would
	otherwise be in already extremely cramped 32-bit virtual
	address spaces.

(5) What's in it for the average user? It's doubtful GNOME will be
	registering memory blocks with these syscalls anytime soon.
	Granted, the opportunities for reducing TLB load this way
	are small on desktop systems, but it doesn't feel quite
	right to just throw mappings of magic physical memory into the
	hands of a few enlightened apps on machines with memory to burn
	and leave all others in the cold.
	By several accounts "scalability" is defined as "performing as
	well on large machines as it does on small ones" ... but this
	seems to be a method of circumventing the kernel's own memory
	management as opposed to a method of improving it in all cases.

(6) As far as reconfiguring, I'm slightly concerned about the robustness
	of change_large_page_mem_size() in terms of how likely it is to
	succeed. Some on-demand defragmentation looks like it should be
	implemented to make it more reliable (now possible thanks to
	rmap). In general, the sysctl seems to lack some adaptivity.
	Granting root privileges to the workload vs. perpetual
	monitoring to find the ideal pool size sounds like a headache.

(7) I'm a little worried by the following:

zone(0): 4096 pages.
zone(1): 225280 pages.
BUG: wrong zone alignment, it will crash
zone(2): 3964928 pages.


My machine doesn't seem to care, but others' might.


Cheers,
Bill
