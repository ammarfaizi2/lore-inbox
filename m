Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268710AbUJPMKW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268710AbUJPMKW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Oct 2004 08:10:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268716AbUJPMKW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Oct 2004 08:10:22 -0400
Received: from holomorphy.com ([207.189.100.168]:8593 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S268710AbUJPMJT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Oct 2004 08:09:19 -0400
Date: Sat, 16 Oct 2004 05:09:11 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: christophpfister@bluemail.ch
Cc: linux-kernel@vger.kernel.org
Subject: Re: failure in /mm/memory.c
Message-ID: <20041016120911.GW5607@holomorphy.com>
References: <412EB75E00164E05@mssazhh-int.msg.bluewin.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <412EB75E00164E05@mssazhh-int.msg.bluewin.ch>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 16, 2004 at 12:32:35PM +0100, christophpfister@bluemail.ch wrote:
> i found a failure in function remap_pte_range in memory.c
> static inline void remap_pte_range(...)
> {
> unsigned long end;
> unsigned long pfn;
> address &= ~PMD_MASK;
> end = address + size;
> if (end > PMD_SIZE)
>     end = PMD_SIZE;
> pfn = phys_addr >> PAGE_SHIFT;
> do {
>     BUG_ON(!pte_none(*pte));
>     if (!pfn_valid(pfn) || PageReserved(pfn_to_page(pfn))) *****
>       set_pte(pte, pfn_pte(pfn, prot));
>     address += PAGE_SIZE;
>     pfn++;
>     pte++;
>     } while (address && (address < end));
> }

Well, there are issues...

On Sat, Oct 16, 2004 at 12:32:35PM +0100, christophpfister@bluemail.ch wrote:
> by ****
> the condition is wrong, because it just maps the page, if it's invalid or
> reserved
> correct: if (!(pfn_valid(pfn) || PageReserved(pfn_to_page(pfn))))
> (it doesn't seems to be used, otherwise there must be bugs)

This isn't one of them. De Morgan teach us that what you wrote is just
	!pfn_valid(pfn) && !PageReserved(pfn_to_page(pfn))
which would evaluate pfn_to_page() on an invalid pfn, and so nonsensical.


-- wli
