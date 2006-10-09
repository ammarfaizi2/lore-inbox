Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932821AbWJINin@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932821AbWJINin (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Oct 2006 09:38:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932819AbWJINin
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Oct 2006 09:38:43 -0400
Received: from ns2.gothnet.se ([82.193.160.251]:60703 "EHLO
	GOTHNET-SMTP2.gothnet.se") by vger.kernel.org with ESMTP
	id S932816AbWJINim (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Oct 2006 09:38:42 -0400
Message-ID: <452A50C2.9050409@tungstengraphics.com>
Date: Mon, 09 Oct 2006 15:38:10 +0200
From: Thomas Hellstrom <thomas@tungstengraphics.com>
User-Agent: Mozilla Thunderbird 1.0.6-7.6.20060mdk (X11/20050322)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nick Piggin <npiggin@suse.de>
CC: Andrew Morton <akpm@osdl.org>,
       Linux Memory Management <linux-mm@kvack.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [patch 3/3] mm: fault handler to replace nopage and populate
References: <20061009102635.GC3487@wotan.suse.de> <1160391014.10229.16.camel@localhost.localdomain> <20061009110007.GA3592@wotan.suse.de> <1160392214.10229.19.camel@localhost.localdomain> <20061009111906.GA26824@wotan.suse.de> <1160393579.10229.24.camel@localhost.localdomain> <20061009114527.GB26824@wotan.suse.de> <1160394571.10229.27.camel@localhost.localdomain> <20061009115836.GC26824@wotan.suse.de> <1160395671.10229.35.camel@localhost.localdomain> <20061009121417.GA3785@wotan.suse.de>
In-Reply-To: <20061009121417.GA3785@wotan.suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-BitDefender-Scanner: Mail not scanned due to license constraints
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin wrote:
> On Mon, Oct 09, 2006 at 10:07:50PM +1000, Benjamin Herrenschmidt wrote:
> 
>>On Mon, 2006-10-09 at 13:58 +0200, Nick Piggin wrote:
>>
>>>The VM won't see that you have struct pages backing the ptes, and won't
>>>do the right refcounting or rmap stuff... But for file backed mappings,
>>>all the critical rmap stuff should be set up at mmap time, so you might
>>>have another option to simply always do the nopfn thing, as far as the
>>>VM is concerned (ie. even when you do have a struct page)
>>
>>Any reason why it wouldn't work to flip that bit on the first no_page()
>>after a migration ? A migration always involves destroying all PTEs and
>>is done with a per-object mutex held that no_page() takes too, so we can
>>be pretty sure that the first nopage can set that bit before any PTE is
>>actually inserted in the mapping after all the previous ones have been
>>invalidated... That would avoid having to walk the vma's.
> 
> 
> Ok I guess that would work. I was kind of thinking that one needs to
> hold the mmap_sem for writing when changing the flags, but so long
> as everyone *else* does, then I guess you can get exclusion from just
> the read lock. And your per-object mutex would prevent concurrent
> nopages from modifying it.

Wouldn't that confuse concurrent readers?

Could it be an option to make it safe for the fault handler to 
temporarily drop the mmap_sem read lock given that some conditions TBD 
are met?
In that case it can retake the mmap_sem write lock, do the VMA flags 
modifications, downgrade and do the pte modifications using a helper, or 
even use remap_pfn_range() during the time the write lock is held?

/Thomas






