Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750748AbWBEVf4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750748AbWBEVf4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Feb 2006 16:35:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750745AbWBEVf4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Feb 2006 16:35:56 -0500
Received: from e31.co.us.ibm.com ([32.97.110.149]:58062 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750742AbWBEVfz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Feb 2006 16:35:55 -0500
Message-ID: <43E66FB6.6070303@us.ibm.com>
Date: Sun, 05 Feb 2006 15:35:50 -0600
From: Brian King <brking@us.ibm.com>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041207)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Hugh Dickins <hugh@veritas.com>
CC: James Bottomley <James.Bottomley@SteelEye.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org
Subject: Re: [PATCH] ipr: don't doublefree pages from scatterlist
References: <Pine.LNX.4.63.0512271807130.4955@kai.makisara.local> <20060104172727.GA320@tau.solarneutrino.net> <Pine.LNX.4.63.0601042334310.5087@kai.makisara.local> <20060105201249.GB1795@tau.solarneutrino.net> <Pine.LNX.4.64.0601051312380.3169@g5.osdl.org> <20060109033149.GC283@tau.solarneutrino.net> <Pine.LNX.4.64.0601082000450.3169@g5.osdl.org> <Pine.LNX.4.61.0601090933160.7632@goblin.wat.veritas.com> <20060109185350.GG283@tau.solarneutrino.net> <Pine.LNX.4.61.0601091922550.15426@goblin.wat.veritas.com> <20060118001252.GB821@tau.solarneutrino.net> <Pine.LNX.4.61.0601181556050.9110@goblin.wat.veritas.com> <Pine.LNX.4.61.0602031842290.14065@goblin.wat.veritas.com> <Pine.LNX.4.61.0602031953400.14829@goblin.wat.veritas.com> <43E3D3EC.3040006@us.ibm.com> <Pine.LNX.4.61.0602040004020.5406@goblin.wat.veritas.com>
In-Reply-To: <Pine.LNX.4.61.0602040004020.5406@goblin.wat.veritas.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hugh Dickins wrote:
> On Fri, 3 Feb 2006, Brian King wrote:
>>Hugh Dickins wrote:
>>>On some architectures, mapping the scatterlist may coalesce entries:
>>>if that coalesced list is then used for freeing the pages afterwards,
>>>there's a danger that pages may be doubly freed (and others leaked).
>>I don't understand why this is necessary... Comparing the bug you fixed
>>in st with ipr's usage of scatterlists, there is a bit of a difference.
>>st is dealing with user pages and calling page_cache_release to release
>>the pages, and I can begin to understand why there might be a problem
>>in that code.
> 
> Yes, certainly the st and ipr cases seem different, and originally
> I was thinking it was only an issue in connection with get_user_pages.
> 
>>page_cache_release looks at the pages themselves to figure
>>out how many compound pages there are. This could certainly result in
>>double free's occurring.
> 
> I don't follow you there, but better if I try to explain how I see it.
> 
>>Looking at ipr, however, it is simply doing alloc_pages
>>and __free_pages. __free_pages passes in the page allocation order, so
>>I don't think I would have the double free problem.
>>
>>As I understand it, pci_map_sg only modifies the dma_address and dma_length
>>fields when things get coalesced. If it were to coalese pages by
>>turning them into compound pages then I would agree that ipr might have
>>a problem, but I don't think this to be the case...
> 
> It's not fully defined what it does (intentionally: internal detail).

I did a quick check of all the different architectures and was unable
to find any architecture that does what you describe below. All coalescing
appears to be done by only modifying the dma_length and dma_address fields in
the scatterlist.

> But as I understand it, what it's likely to do is coalesce entries as
> far as it can (causes no problem in itself) then shift down and attempt
> to coalesce the entries above.  It's the shifting down that gives the
> problem.
> 
> Imagine we start with sglist
> 
> struct page *a, length A
> struct page *b, length B
> struct page *c, length C
> 
> and pci_map_sg finds a+A brings it to b (I'm writing loosely, mixing
> the page pointers and their corresponding virtual addresses), but b+B
> does not match c.  Then it'll coalesce the first two entries, and
> shift down the third to second place, turning sglist into
> 
> struct page *a, length A+B
> struct page *c, length C
> struct page *c, length C

Disagree. This is how I would expect the sglist to look after pci_map_sg:

struct page *a, length A, dma_addr a, dma_length A+B
struct page *b, length B, dma_addr c, dma_length C
struct page *c, length C, dma_addr n/a, dma_length n/a

> 
> So (again writing loosely, mixing up lengths and orders) on return the
> caller will __free_pages(a, A+B) (itself probably wrong since a and b
> were likely not buddies to start out with), __free_pages(c, C),
> __free_pages(c, C) - doubly freeing c, ensuing mayhem.
> 
> Maybe it doesn't change length A to A+B, just doing that in dma_length;
> but caller is still going to free c twice.
> 
> Agree?

No. I can't find any code in any architecture that modifies either the length,
page, or offset fields in the *_map_sg routines.

I'm still failing to see an actual bug in the ipr driver. Unless there is a
good reason for pushing additional complexity on every caller of pci_map_sg
to do additional bookkeeping, such as an architecture that is actually modifying
fields in the scatterlist other than the dma_* fields, then I think it makes
more sense to clarify the API to say that pci_map_sg will not modify these fields.

Brian

-- 
Brian King
eServer Storage I/O
IBM Linux Technology Center
