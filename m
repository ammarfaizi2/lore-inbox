Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262221AbVCBTIB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262221AbVCBTIB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 14:08:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262412AbVCBTIB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 14:08:01 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:58013 "EHLO
	MTVMIME03.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S262221AbVCBTH4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 14:07:56 -0500
Date: Wed, 2 Mar 2005 19:07:15 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Mauricio Lin <mauriciolin@gmail.com>
cc: Andrew Morton <akpm@osdl.org>, wli@holomorphy.com,
       linux-kernel@vger.kernel.org, rrebel@whenu.com,
       marcelo.tosatti@cyclades.com, nickpiggin@yahoo.com.au
Subject: Re: [PATCH] A new entry for /proc
In-Reply-To: <3f250c71050302042059f36525@mail.gmail.com>
Message-ID: <Pine.LNX.4.61.0503021858330.5183@goblin.wat.veritas.com>
References: <20050106202339.4f9ba479.akpm@osdl.org> 
    <3f250c710502240343563c5cb0@mail.gmail.com> 
    <20050224035255.6b5b5412.akpm@osdl.org> 
    <3f250c7105022507146b4794f1@mail.gmail.com> 
    <3f250c71050228014355797bd8@mail.gmail.com> 
    <3f250c7105022801564a0d0e13@mail.gmail.com> 
    <Pine.LNX.4.61.0502282029470.28484@goblin.wat.veritas.com> 
    <3f250c7105030100085ab86bd2@mail.gmail.com> 
    <3f250c710503010617537a3ca@mail.gmail.com> 
    <3f250c710503010744390391e2@mail.gmail.com> 
    <3f250c71050302042059f36525@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Mar 2005, Mauricio Lin wrote:
> Does anyone know if the place I put pte_unmap is logical and safe
> after several pte increments?

The place is logical and safe, but it's still not quite right.
You should have found several examples of loops having the same
problem, and what do they do? ....

> 	pte = pte_offset_map(pmd, address);
> 	address &= ~PMD_MASK;
> 	end = address + size;
> 	if (end > PMD_SIZE)
> 		end = PMD_SIZE;
> 	do {
> 		pte_t page = *pte;
> 
> 		address += PAGE_SIZE;
> 		pte++;
> 		if (pte_none(page) || (!pte_present(page)))
> 			continue;
> 		*rss += PAGE_SIZE;
> 	} while (address < end);
> 	pte_unmap(pte);

	pte_unmap(pte - 1);

which works because it's a do {} while () loop which has certainly
incremented pte at least once.  But some people probably loathe that
style, and would prefer to save orig_pte then pte_unmap(orig_pte).

Hugh
