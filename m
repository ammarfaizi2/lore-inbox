Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261458AbVCCH0R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261458AbVCCH0R (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 02:26:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261461AbVCCH0R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 02:26:17 -0500
Received: from rproxy.gmail.com ([64.233.170.198]:23825 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261458AbVCCH0O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 02:26:14 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=J4ZgXn9goVmx195k5D2DPcgpdlGgjq/B4JqXRbNFOIGc4tW/gmOHYH0rF9EQXgu6h1ZmlxUvaoZ7T6THmbzegqJyJZl1kBMS33++tPogCIST2PPLFRebcOcqYqiw06P/cH3JxGkdsplxXgvuBpiJrXv0y0+/o8iF0dWOj+gGGos=
Message-ID: <3f250c710503022325af22974@mail.gmail.com>
Date: Thu, 3 Mar 2005 03:25:16 -0400
From: Mauricio Lin <mauriciolin@gmail.com>
Reply-To: Mauricio Lin <mauriciolin@gmail.com>
To: Hugh Dickins <hugh@veritas.com>
Subject: Re: [PATCH] A new entry for /proc
Cc: Andrew Morton <akpm@osdl.org>, wli@holomorphy.com,
       linux-kernel@vger.kernel.org, rrebel@whenu.com,
       marcelo.tosatti@cyclades.com, nickpiggin@yahoo.com.au
In-Reply-To: <Pine.LNX.4.61.0503021858330.5183@goblin.wat.veritas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20050106202339.4f9ba479.akpm@osdl.org>
	 <3f250c7105022507146b4794f1@mail.gmail.com>
	 <3f250c71050228014355797bd8@mail.gmail.com>
	 <3f250c7105022801564a0d0e13@mail.gmail.com>
	 <Pine.LNX.4.61.0502282029470.28484@goblin.wat.veritas.com>
	 <3f250c7105030100085ab86bd2@mail.gmail.com>
	 <3f250c710503010617537a3ca@mail.gmail.com>
	 <3f250c710503010744390391e2@mail.gmail.com>
	 <3f250c71050302042059f36525@mail.gmail.com>
	 <Pine.LNX.4.61.0503021858330.5183@goblin.wat.veritas.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hugh,

How about map an unmap each pte?

I mean remove the pte++ and use pte_offset_map for each incremented
address and then pte_unmap. So each incremented address is an index to
get the next pte via pte_offset_map.

BR,

Mauricio Lin.

On Wed, 2 Mar 2005 19:07:15 +0000 (GMT), Hugh Dickins <hugh@veritas.com> wrote:
> On Wed, 2 Mar 2005, Mauricio Lin wrote:
> > Does anyone know if the place I put pte_unmap is logical and safe
> > after several pte increments?
> 
> The place is logical and safe, but it's still not quite right.
> You should have found several examples of loops having the same
> problem, and what do they do? ....
> 
> >       pte = pte_offset_map(pmd, address);
> >       address &= ~PMD_MASK;
> >       end = address + size;
> >       if (end > PMD_SIZE)
> >               end = PMD_SIZE;
> >       do {
> >               pte_t page = *pte;
> >
> >               address += PAGE_SIZE;
> >               pte++;
> >               if (pte_none(page) || (!pte_present(page)))
> >                       continue;
> >               *rss += PAGE_SIZE;
> >       } while (address < end);
> >       pte_unmap(pte);
> 
>         pte_unmap(pte - 1);
> 
> which works because it's a do {} while () loop which has certainly
> incremented pte at least once.  But some people probably loathe that
> style, and would prefer to save orig_pte then pte_unmap(orig_pte).
> 
> Hugh
>
