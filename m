Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261236AbVFATcs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261236AbVFATcs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 15:32:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261286AbVFATcD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 15:32:03 -0400
Received: from holomorphy.com ([66.93.40.71]:10443 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S261236AbVFAT3h (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 15:29:37 -0400
Date: Wed, 1 Jun 2005 12:29:34 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Bill Davidsen <davidsen@tmr.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Swap maximum size documented ?
Message-ID: <20050601192934.GP20782@holomorphy.com>
References: <200506011225.j51CPDV23243@lastovo.hermes.si> <20050601124025.GZ422@unthought.net> <1117630718.6271.31.camel@laptopd505.fenrus.org> <loom.20050601T150142-941@post.gmane.org> <20050601134022.GM20782@holomorphy.com> <429E0843.5060505@tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <429E0843.5060505@tmr.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:
>> Without CONFIG_HIGHMEM64G=y you have:
>> 32 swapfiles, max swapfile size of 64GB.
>> With CONFIG_HIGHMEM64G=y you have:
>> 32 swapfiles, max swapfile size of 512GB.

On Wed, Jun 01, 2005 at 03:10:59PM -0400, Bill Davidsen wrote:
> Does this apply to mmap as well? I have an application which currently 
> uses 9TB of data, and one thought to boost performance was to mmap the 
> data. Unfortunately, I know 16TB isn't going to be enough for more than 
> a few more years :-(

This only applies to swapping on ia32/i386.

mmap() is limited only by file offsets, which are fully 32-bit on
32-bit systems. remap_file_pages() is limited by PTE_FILE_MAX_BITS,
which is fully 32-bit with CONFIG_HIGHMEM64G=y on i386 but only 29 bit
without it on i386. In general checking for PTE_FILE_MAX_BITS on the
relevant architecture should answer your question for remap_file_pages(),
and BITS_PER_LONG for mmap(). The swap limits for other architectures
will also differ and you generally have to look at the swp_entry/pte
encoding/decoding macros to decipher what the precise limits are
(though a quick hacky C program can help discover them for you).
Generally you get the filesizes by PAGE_SIZE << X_FILE_OFFSET_BITS.

It is in principle possible to sweep the kernel to allow larger file
offsets on 32-bit systems (pgoff_t is something of a preparation for
that), but I wouldn't advise trying it without rather strong kernel-fu
and much willingness to debug it by one's self, and that with a common
failure mode of fs data corruption. Widening swp_entry_t is slightly
harder as the ptes have limited capacity so you have to somehow allocate
extra data in a deadlock-free manner, but one also has less disruptive
failure modes. I suspect you're not itching to implement these things.

One thing to keep in mind is that these are only permissible filesizes.
Virtualspace must be managed properly for windowing where it's limited
and to prevent pagetable proliferation where it's not.


-- wli
