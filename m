Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751031AbWIMSVg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751031AbWIMSVg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Sep 2006 14:21:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751032AbWIMSVg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Sep 2006 14:21:36 -0400
Received: from mailout1.vmware.com ([65.113.40.130]:4740 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP
	id S1751028AbWIMSVf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Sep 2006 14:21:35 -0400
Message-ID: <45084C2E.4060203@vmware.com>
Date: Wed, 13 Sep 2006 11:21:34 -0700
From: Zachary Amsden <zach@vmware.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060719)
MIME-Version: 1.0
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.osdl.org, akpm@osdl.org,
       nickpiggin@yahoo.com.au, frankeh@watson.ibm.com, rhim@cc.gateh.edu
Subject: Re: [patch 3/9] Guest page hinting: volatile page cache.
References: <20060901110948.GD15684@skybase>
In-Reply-To: <20060901110948.GD15684@skybase>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Schwidefsky wrote:
> The code added by this patch uses the volatile state for all page cache
> pages, even for pages which are referenced by writable ptes. The host
> needs to be able to check the dirty state of the pages. Since the host
> doesn't know where the page table entries of the guest are located,
> the volatile state as introduced by this patch is only usable on
> architectures with per-page dirty bits (s390 only). For per-pte dirty
> bit architectures some additional code is needed.
>   

What do you mean by per-page dirty bits.  Do you mean per-page dirty 
bits in hardware (s390), in software (Linux), or maintained by the 
hypervisor?

> The interesting question is where to put the state transitions between
> the volatile and the stable state. The simple solution is the make a
> page stable whenever a lookup is done or a page reference is derived
> from a page table entry. Attempts to make pages volatile are added at
> strategic points. Now what are the conditions that prevent a page from
> being made volatile? There are 10 conditions:
> 1) The page is reserved. Some sort of special page.
> 2) The page is marked dirty in the struct page. The page content is
>    more recent than the data on the backing device. The host cannot
>    access the linux internal dirty bit so the page needs to be stable.
> 3) The page is in writeback. The page content is needed for i/o.
> 4) The page is locked. Someone has exclusive access to the page.
>   

I'll tend to agree from a heuristical performance point of view, but I 
don't see any reason that a locked page can't be made volatile from a 
correctness perspective.

> 5) The page is anonymous. Swap cache support needs additional code.
> 6) The page has no mapping. No backing, the page cannot be recreated.
> 7) The page is not uptodate.
> 8) The page has private information. try_to_release_page can fail,
>    e.g. in case the private information is journaling data. The discard
>    fault need to be able to remove the page.
> 9) The page is already discarded.
> 10) The page map count is not equal to the page reference count - 1.
>    The discard fault handler can remove the page cache reference and
>    all mappers of a page. It cannot remove the page reference for any
>    other user of the page.
>   

Does s390 use per physical page permission bits separate from the PTEs?  
Because I don't see how you can generate a discard fault otherwise 
unless you know where the page table entries of the guest are located, 
which you already said you don't.  Or perhaps I'm misunderstanding the 
meaning of discard fault - I'm taking it to mean a fault which happens 
on access to a volatile page that was discarded by the hypervisor - thus 
requiring a refresh of all mapping PTEs?

Thanks,

Zach
