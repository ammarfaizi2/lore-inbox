Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932552AbWJILpM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932552AbWJILpM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Oct 2006 07:45:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932574AbWJILpM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Oct 2006 07:45:12 -0400
Received: from relay.gothnet.se ([82.193.160.251]:53536 "EHLO
	GOTHNET-SMTP2.gothnet.se") by vger.kernel.org with ESMTP
	id S932552AbWJILpL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Oct 2006 07:45:11 -0400
Message-ID: <452A35FF.50009@tungstengraphics.com>
Date: Mon, 09 Oct 2006 13:43:59 +0200
From: =?ISO-8859-1?Q?Thomas_Hellstr=F6m?= <thomas@tungstengraphics.com>
User-Agent: Mozilla Thunderbird 1.0.6-7.6.20060mdk (X11/20050322)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
CC: linux-mm@kvack.org, Linux Kernel list <linux-kernel@vger.kernel.org>,
       Hugh Dickins <hugh@veritas.com>, Arnd Bergmann <arnd@arndb.de>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: User switchable HW mappings & cie
References: <1160347065.5926.52.camel@localhost.localdomain>
In-Reply-To: <1160347065.5926.52.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-BitDefender-Scanner: Mail not scanned due to license constraints
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin Herrenschmidt wrote:

>Hi !
>
>I'd like to kick a discussion about some issues I've been having along
>with some proposed solutions related to mapping of bits of hardware in
>smarter ways than simply doing a io_remap_pfn_range() and the problems,
>generally caused by get_user_pages().
>
>  
>
...

>The Tungstengrpahics folks (Thomas is on CC) have been working on some
>better memory management to properly handle those things in the DRM. One
>of the things we want to do here is similar to what the SPUs do with
>local store: have a single VMA associated with an object, and have the
>PTEs transparently changed to map either video memory, system memory,
>AGP memory, etc... (the different in cache attributes can be ignored at
>this stage, we can discuss it separately if interested).
>
>I've been suggesting a similar approach as we use for SPUs. That is what
>would make the most sense from a user standpoint: user code access their
>"objects" via a single virtual pointer and the DRM takes care of
>migrating it when necessary (for example migrating it to video RAM when
>it needs to be used by the engine and "swap" it back to main memory when
>not).
>
>
>  
>
...

>The base idea is that we would have the no_page() function of SPU's or
>the DRM either return a struct page when the object is backed to main
>memory, or install the PTE directly (using the helper to hide some of
>the low level TLB flushing logic etc...) and then return NOPAGE_REFAULT
>when hitting the hardware. The helper basically is a one-page version of
>io_remap_pfn_range() with the added "feature" of not doing anything if
>the PTE has been set by somebody else (handle the race case) instead of
>BUG'ing as the current io_remap_pfn_range() does.
>
>  
>
I'm very much for this approach, possibly with the extension that we 
could have a multiple-page version as well, as populating the whole vma 
sometimes may be cheaper than populating each pte with a fault. That 
would basically be an io_remap_pfn_range() which is safe when the 
mmap_sem is taken in read mode (from do_no_page).

One problem that occurs is that the rule for ptes with non-backing 
struct pages
Which I think was introduced in 2.6.16:

    pfn_of_page == vma->vm_pgoff + ((addr - vma->vm_start) >> PAGE_SHIFT)

cannot be honored, at least not with the DRM memory manager, since the 
graphics object will be associated with a vma and not the underlying 
physical address. User space will have vma->vm_pgoff as a handle to the 
object, which may move around in graphics memory.

/Thomas





