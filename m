Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263960AbRGEKmA>; Thu, 5 Jul 2001 06:42:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264091AbRGEKlu>; Thu, 5 Jul 2001 06:41:50 -0400
Received: from nat-pool-meridian.redhat.com ([199.183.24.200]:65384 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S263960AbRGEKld>; Thu, 5 Jul 2001 06:41:33 -0400
Date: Thu, 5 Jul 2001 11:41:21 +0100
From: "Stephen C. Tweedie" <sct@redhat.com>
To: michaelc <michaelc@turbolinux.com.cn>
Cc: "Stephen C. Tweedie" <sct@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: about kmap_high function
Message-ID: <20010705114121.J28793@redhat.com>
In-Reply-To: <3620762046.20010629150601@turbolinux.com.cn> <20010703103809.A29868@redhat.com> <1224736781.20010705102835@turbolinux.com.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1224736781.20010705102835@turbolinux.com.cn>; from michaelc@turbolinux.com.cn on Thu, Jul 05, 2001 at 10:28:35AM +0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Jul 05, 2001 at 10:28:35AM +0800, michaelc wrote:

>        Thank you very much for your kindly guide, and I have two question to ask
>    you, One question is, Is kmap_high intended to be called merely in the user
>    context, so the  highmem pages are mapped into user process page table, so
>    on SMP, other processes ( including kernel and user process) that running
>    on another cpu doesn't need to get that kmap virtual address.

No.  In user context, at least for user data pages, the highmem pages
can be mapped into the local process's user page tables and we don't
need kmap to access them at all.  kmap is only needed for pages which
are not already in the user page tables, such as when accessing the
page cache in read or write syscalls.

>       Another question is, when kernel evicts old, unused kmap  mapping and
>    flushes the whole TLB range( call the flush_all_zero_pkmaps), the TLB won't
>    keep those zero  mappings, after that, when user process call kmap_high to
>    get a new kmap mappings, and when the process access that virtual
>    address, MMU component will get the page directory and page table from MEMORY
>    instead of TLB to translate the virtual address into physical  address.

No, user processes never access kmap addresses.  They have direct page
table access to highmem pages in their address space.  Only the kernel
uses kmap, and only for pages which are not in the calling process's
local page tables already.  So we don't have to worry about keeping
kmap and page tables consistent --- they are totally different address
spaces, and the kmap virtual addresses are not visible to user
processes.

Cheers,
 Stephen
