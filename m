Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261730AbVB1UnG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261730AbVB1UnG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Feb 2005 15:43:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261731AbVB1UnG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Feb 2005 15:43:06 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:21576 "EHLO
	MTVMIME01.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S261730AbVB1UnC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Feb 2005 15:43:02 -0500
Date: Mon, 28 Feb 2005 20:41:31 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Mauricio Lin <mauriciolin@gmail.com>
cc: Andrew Morton <akpm@osdl.org>, wli@holomorphy.com,
       linux-kernel@vger.kernel.org, rrebel@whenu.com,
       marcelo.tosatti@cyclades.com, nickpiggin@yahoo.com.au
Subject: Re: [PATCH] A new entry for /proc
In-Reply-To: <3f250c7105022801564a0d0e13@mail.gmail.com>
Message-ID: <Pine.LNX.4.61.0502282029470.28484@goblin.wat.veritas.com>
References: <20050106202339.4f9ba479.akpm@osdl.org> 
    <Pine.LNX.4.44.0501081917020.4949-100000@localhost.localdomain> 
    <3f250c710502220513179b606a@mail.gmail.com> 
    <3f250c71050224003110e74704@mail.gmail.com> 
    <20050224010947.774628f3.akpm@osdl.org> 
    <3f250c710502240343563c5cb0@mail.gmail.com> 
    <20050224035255.6b5b5412.akpm@osdl.org> 
    <3f250c7105022507146b4794f1@mail.gmail.com> 
    <3f250c71050228014355797bd8@mail.gmail.com> 
    <3f250c7105022801564a0d0e13@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Feb 2005, Mauricio Lin wrote:
> 
> Now I am testing with /proc/pid/smaps and the values are showing that
> the old one is faster than the new one. So I will keep using the old
> smaps version.

Sorry, I don't have time for more than the briefest look.

It appears that your old resident_mem_size method is just checking
pte_present, whereas your new smaps_pte_range method is also doing
pte_page (yet no prior check for pfn_valid: wrong) and checking
!PageReserved i.e. accessing the struct page corresponding to each
pte.  So it's not a fair comparison, your new method is accessing
many more cachelines than your old method.

Though it's correct to check pfn_valid and !PageReserved to get the
same total rss as would be reported elsewhere, I'd suggest that it's
really not worth the overhead of those struct page accesses: just
stick with the pte_present test.

Your smaps_pte_range is missing pte_unmap?

Hugh
